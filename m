Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484C417E35F
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 16:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgCIPSu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 11:18:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56353 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726446AbgCIPSu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 11:18:50 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 029FIdAR028102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Mar 2020 11:18:41 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id ECE6B42045B; Mon,  9 Mar 2020 11:18:38 -0400 (EDT)
Date:   Mon, 9 Mar 2020 11:18:38 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jean-Louis Dupond <jean-louis@dupond.be>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Filesystem corruption after unreachable storage
Message-ID: <20200309151838.GA4852@mit.edu>
References: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
 <20200124203725.GH147870@mit.edu>
 <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
 <20200220155022.GA532518@mit.edu>
 <7376c09c-63e3-488f-fcf8-89c81832ef2d@dupond.be>
 <adc0517d-b46e-2879-f06c-34c3d7b7c5f6@dupond.be>
 <20200225172355.GA14617@mit.edu>
 <d19e44af-585f-e4a2-5546-7a3345a0ee66@dupond.be>
 <50f93ccb-2b2c-15c5-8b08-facc3a25068a@dupond.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f93ccb-2b2c-15c5-8b08-facc3a25068a@dupond.be>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 09, 2020 at 02:52:38PM +0100, Jean-Louis Dupond wrote:
> Did some more tests today.
> 
> Setting the SCSi timeout higher seems to be the most reliable solution.
> When the storage recovers, the VM just recovers and we can continue :)
> 
> Also did test setting the filesystem option 'error=panic'.
> When the storage recovers, the VM freezes. So a hard reset is needed. But on
> boot a manual fsck is also needed like in the default situation.
> So it seems like it still writes data to the FS before doing the panic?
> You would expect it to not touch the fs anymore.
> 
> Would be nice if this situation could be a bit more error-proof :)

Did the panic happen immediately, or did things hang until the storage
recovered, and *then* it rebooted.  Or did the hard reset and reboot
happened before the storage network connection was restored?

Fundamentally I think what's going on is that even though there is an
I/O error reported back to the OS, but in some cases, the outstanding
I/O actually happens.  So in the error=panic case, we do update the
superblock saying that the file system contains inconsistencies.  And
then we reboot.  But it appears that even though host rebooted, the
storage area network *did* manage to send the I/O to the device.

I'm not sure what we can really do here, other than simply making the
SCSI timeout infinite.  The problem is that storage area networks are
flaky.  Sometimes I/O's make it through, and even though we get an
error, it's an error from the local SCSI layer --- and it's possible
that I/O will make it through.  In other cases, even though the
storage area network was disconnected at the time we sent the I/O
saying the file system has problems, and then rebooted, the I/O
actually makes it through.  Given that, assuming that if we're not
sure, forcing an full file system check is better part of valor.

And if it hangs forever, and we do a hard reset reboot, I don't know
*what* to trust from the storage area network.  Ideally, there would
be some way to do a hard reset of the storage area network so that all
outstanding I/O's from the host that we are about to reset will get
forgotten before we do actually the hard reset.

						- Ted
