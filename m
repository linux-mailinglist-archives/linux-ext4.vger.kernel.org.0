Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C527632EF6C
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 16:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhCEPzd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 10:55:33 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36957 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229935AbhCEPzT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 10:55:19 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 125FtCkw029315
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 Mar 2021 10:55:12 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EC1F815C3A88; Fri,  5 Mar 2021 10:55:11 -0500 (EST)
Date:   Fri, 5 Mar 2021 10:55:11 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: badblocks from e2fsprogs
Message-ID: <YEJUX17LMSNna5XS@mit.edu>
References: <CA+icZUXzjAniVZMzS5ePNa6HrjWL6ZrpAgzWufy74zHSyN+urQ@mail.gmail.com>
 <YD0DaqIbAf0T2tw2@mit.edu>
 <CA+icZUXJpEEO4GS1fy9ANXCXJ2BtD_rd1tAtXLun++i0taZwSA@mail.gmail.com>
 <YD0JfjnMtXzGguZ6@mit.edu>
 <CA+icZUUruS8h=CiUwuSsbL9NmCXCvdfV-XFfV=Z=qOpR9b83XA@mail.gmail.com>
 <20210305115957.x4gbppxpzxuvn2kd@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305115957.x4gbppxpzxuvn2kd@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 05, 2021 at 12:59:57PM +0100, Lukas Czerner wrote:
> 
> Just note that not even the device firmware can't really know whether the
> block is good/bad unless it tries to read/write it. In that way I still
> find the badblocks useful because it can "force" the device to notice
> that there is something wrong and try to fix it (perhaps by remapping
> the bad block to spare one). 

Well, there are various different types of smart tests that you can
request via SMART, although most of them don't do a full surface scan
on the disk --- simply because on large disks, this can take 24 to 36
hours to read every single sector.

Also, an HDD also does do some background reading and re-writing of
some blocks, to remediate against adjacent track interference (ATI)
and far track interference.  In addition, although it's not as bad as
with flash, there is actually a slight effect merely *reading* from a
track can cause minor disturbances in the force^H^H^H^H^H^H adjacent
tracks, and of course, writing to a track can definitely cause a minor
weakening of an adjacent track.  This is why, when the disk is idle,
an HDD will spend some of its time reading and then rewriting tracks
that might have been sufficiently weakened by ATI and FTI effects it
would be good to refresh those tracks to prevent data loss.

Some times, when it reads a block which is marginal, it will get the
correct checksum when it retries the read, and in some cases the disk
will automatically rewrite the block with the known correct value.  In
that case, where it's not a matter of the media going bad, but merely
the magnetic signal recorded on the media getting weaker, it won't be
necessary to remap the block(s).

> Of course you could use dd for that, but there are several reasons
> why badblocks is still more convenient tool to do that.

Note that badblocks does not support more than 16TB disks currently.
Part of this is because ext4 doesn't support more than 16TB in its bad
blocks inode (which has to use indirect mapped blocks), and part of
this is because of the "do you really want to spend 36 hours doing all
of these reads"?

If someone wants to work on making badblocks support 64-bit block
numbers, patches are gratefully accepted, but it's a lot of work, and
I've never thought it was worth my personal time....

          	   	      	  	   - Ted

P.S.  If there are bad blocks, modern disks will automatically remap
them when you first write to a block.  And if the block already
contains data, it won't get remapped until you try writing to the
block, in which case you need to decide how to handle the fact that
the previous contents of that block might contain file data or
metadata block data.  So doing something much more sophisticated
probably means more work to e2fsck as well in the ideal case.  Or just
buy high quality HDD's, and do regular backups, or use RAID, or use a
cluster file system which uses Reed Solomon Codes or other erasure
encodings.  :-)

