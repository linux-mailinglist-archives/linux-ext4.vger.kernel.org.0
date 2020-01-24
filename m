Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E62148F71
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jan 2020 21:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbgAXUhi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jan 2020 15:37:38 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58454 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387393AbgAXUhh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jan 2020 15:37:37 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00OKbPBc002715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 15:37:29 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1664942014A; Fri, 24 Jan 2020 15:37:25 -0500 (EST)
Date:   Fri, 24 Jan 2020 15:37:25 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jean-Louis Dupond <jean-louis@dupond.be>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Filesystem corruption after unreachable storage
Message-ID: <20200124203725.GH147870@mit.edu>
References: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 24, 2020 at 11:57:10AM +0100, Jean-Louis Dupond wrote:
> 
> There was a short disruption of the SAN, which caused it to be unavailable
> for 20-25 minutes for the ESXi.

20-25 minutes is "short"?  I guess it depends on your definition / POV.  :-)

> What was observed in the VM was the following:
> <hung task warning>

OK, to be expected.

> 
> - After 1080 seconds (SCSi Timeout of 180 * 5 Retries + 1):
> [5878128.028672] sd 0:0:1:0: timing out command, waited 1080s
> [5878128.028701] sd 0:0:1:0: [sdb] tag#592 FAILED Result: hostbyte=DID_OK
> driverbyte=DRIVER_OK
> [5878128.028703] sd 0:0:1:0: [sdb] tag#592 CDB: Write(10) 2a 00 06 0c b4 c8
> 00 00 08 00
> [5878128.028704] print_req_error: I/O error, dev sdb, sector 101496008
> [5878128.028736] EXT4-fs warning (device dm-2): ext4_end_bio:323: I/O error
> 10 writing to inode 3145791 (offset 0 size 0 starting block 12686745)
> 
> So you see the I/O is getting aborted.

Also expected.


> - When the SAN came back, then the filesystem went Read-Only:
> [5878601.212415] EXT4-fs error (device dm-2): ext4_journal_check_start:61:
> Detected aborted journal

Yep....

> Now I did a hard reset of the machine, and a manual fsck was needed to get
> it booting again.
> Fsck was showing the following:
> "Inodes that were part of a corrupted orphan linked list found."
> 
> Manual fsck started with the following:
> Inodes that were part of a corrupted orphan linked list found. Fix<y>?
> Inode 165708 was part of the orphaned inode list. FIXED
> 
> Block bitmap differences: -(863328--863355)
> Fix<y>?
> 
> What worries me is that almost all of the VM's (out of 500) were showing the
> same error.

So that's a bit surprising...

> And even some (+-10) were completely corrupt.

What do you mean by "completely corrupt"?  Can you send an e2fsck
transcript of file systems that were "completely corrupt"?

> Is there for example a chance that the filesystem gets corrupted the moment
> the SAN storage was back accessible?

Hmm...  the one possibility I can think of off the top of my head is
that in order to mark the file system as containing an error, we need
to write to the superblock.  The head of the linked list of orphan
inodes is also in the superblock.  If that had gotten modified in the
intervening 20-25 minutes, it's possible that this would result in
orphaned inodes not on the linked list, causing that error.

It doesn't explain the more severe cases of corruption, though.

> I also have some snapshot available of a corrupted disk if some additional
> debugging info is required.

Before e2fsck was run?  Can you send me a copy of the output of
dumpe2fs run on that disk, and then transcript of e2fsck -fy run on a
copy of that snapshot?

> It would be great to gather some feedback on how to improve the situation
> (next to of course have no SAN outage :)).

Something that you could consider is setting up your system to trigger
a panic/reboot on a hung task timeout, or when ext4 detects an error
(see the man page of tune2fs and mke2fs and the -e option for those
programs).

There are tradeoffs with this, but if you've lost the SAN for 15-30
minutes, the file systems are going to need to be checked anyway, and
the machine will certainly not be serving.  So forcing a reboot might
be the best thing to do.

> On KVM for example there is a unlimited timeout (afaik) until the storage is
> back, and the VM just continues running after storage recovery.

Well, you can adjust the SCSI timeout, if you want to give that a try....

Cheers,

					- Ted
