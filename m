Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F8714D21D
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2020 21:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgA2Uvz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jan 2020 15:51:55 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42356 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726259AbgA2Uvz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jan 2020 15:51:55 -0500
Received: from callcc.thunk.org (guestnat-104-133-9-100.corp.google.com [104.133.9.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00TKofIp031992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 15:50:42 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2DDA1420324; Wed, 29 Jan 2020 15:50:49 -0500 (EST)
Date:   Wed, 29 Jan 2020 15:50:49 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jaco Kroon <jaco@uls.co.za>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: e2fsck fails with unable to set superblock
Message-ID: <20200129205049.GA303030@mit.edu>
References: <20b3e5da-b3ac-edae-ffe0-f6d097c2e309@uls.co.za>
 <91A26A7C-557D-497B-A5ED-B8981B562C24@dilger.ca>
 <90b76473-8ca5-e50a-6c8c-31ea418df7ed@uls.co.za>
 <ebc2dd95-1020-1f6c-f435-f53cf907f9e6@uls.co.za>
 <57CCDA98-4334-469B-B6D8-364417E69423@dilger.ca>
 <61127f04-96bf-58ff-983d-f4b87b7d88f8@uls.co.za>
 <50b83755-3c24-ceff-2529-c89ef4df363b@uls.co.za>
 <7cf0c5cc-7679-41f4-c8e4-e6d79cb88d5f@uls.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cf0c5cc-7679-41f4-c8e4-e6d79cb88d5f@uls.co.za>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 29, 2020 at 06:35:41AM +0200, Jaco Kroon wrote:
> Hi,
> 
> Inode 181716301 block 33554947 conflicts with critical metadata,
> skipping block checks.
> 
> So the critical block stuff I'm guessing can be expected since a bunch
> of those tree structures probably got zeroed too.

It's possible that this was caused by the tree structures getting
written with garbage (33554947 is not zero, so it's not the extent
tree structure getting zeroed, by definition).  If metadata checksums
are enabled, then the kernel would notice (and flag them with EXT4-fs
error reports) if extent trees were not correctly set up.

Another possibility is that hueristics you used for guessing how to
recontrust the block group discripts were incorrectly.  Note that if
the file system has been grown, using on-line or off-line resize2fs,
the results may not be identical to how the block groups laid out by
mke2fs would have done things.  So trying to use the existing pattern
of block group descriptors to reconstruct missing ones is fraught with
potential problems.

If the file system has never been resized, and if you have exactly the
same version of e2fsprogs used to initially create the file system,
and if you have the exact same version of /etc/mke2fs.conf, and the
exact same command-line options to mke2fs, you might be able to use
"mke2fs -S" (see the mke2fs manpage) to rewrite the superblock and
block group descriptors.  But if any of the listed assumptions can't
be assured, it's a dangerous thing to do.

> Another idea is to use debugfs to mark inode 181716301 as deleted, but
> I'm not sure that's safe at this stage?

Well, you'll lose whatever was in that inode, but it's more likely
that the problem is that if the block group descriptors are incorret,
you'll cause even more damage.

Did you make a full image backup of the good disks you can revert any
experiments that you might try?

Good look,

					- Ted

P.S.  For future reference, please take a look at the man page of
e2image for how you can back up the ext4's critical metadata blocks.

