Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3825D477B8D
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Dec 2021 19:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbhLPScg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Dec 2021 13:32:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35394 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231582AbhLPScg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Dec 2021 13:32:36 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BGIWEir011373
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 13:32:15 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9C0CE15C00C8; Thu, 16 Dec 2021 13:32:14 -0500 (EST)
Date:   Thu, 16 Dec 2021 13:32:14 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <YbuGLsQy6TSM2xOl@mit.edu>
References: <20211214175058.19511-1-lhenriques@suse.de>
 <20211215004945.GD69182@magnolia>
 <20211215112852.GM14044@quack2.suse.cz>
 <20211215141237.lrymhbebgjunh4n2@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215141237.lrymhbebgjunh4n2@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 15, 2021 at 03:12:37PM +0100, Lukas Czerner wrote:
> > Run fsck of course! And then recover from backups :) I know this is sad but
> > the situation is that our migration code just is not crash-safe (if we
> > crash we are going to free blocks that are still used by the migrated
> > inode) and Luis makes it work in case we do not crash (which should be
> > hopefully more common) and documents it does not work in case we crash.
> > So overall I'd call it a win.
> > 
> > But maybe we should just remove this online-migration functionality
> > completely from the kernel? That would be also a fine solution for me. I
> > was thinking whether we could somehow make the inode migration crash-safe
> > but I didn't think of anything which would not require on-disk format
> > change...
> 
> Since this is not something that anyone can honestly recommend doing
> without a prior backup and a word of warning I personaly would be in favor
> of removing it.

So there are a couple options that we could pursue:

1) We could change the migrate code to stop putting the orphan inode
on the orphan list.  If we do this, an crash in the middle of the
migrate will, in the worst case (when the migration isn't completed
within a single jbd2 transaction) result in a leaked inode.  That's
not ideal, but it won't lead user data loss, and e2fsck will recover
the situation by cloning the blocks, and leaving the inode in
lost+found.

2) We could try to ensure migration happens all within a single
transaction, if they all fit inside a the inode structure, we allocate
a tmp inode for all of the indirect blocks, attach the blocks to the
tmp inode, place the tmp inode on the orphan list, and put all of that
on a single handle, and then in a second handle, truncate the tmp
inode to release the indirect blocks.  If we need to allocate extent
tree blocks, then all of that would need to fit in a single
transaction, and it's a bit more complicated, but it is doable.

3) We can simply remove the inode migration feature by removing
EXT4_EXTENTS_FL from EXT4_FL_USER_MODIFIABLE, and changing the
implementation of the EXT4_IOC_MIGRATE ioctl to return EOPNOTSUPP, and
then cleaning up the code paths that are now unreachable.

The migration feature is clearly less compelling than it was ten years
ago, when ext4 was first introduced --- and most enterprise distros
have never supported the feature even when it has existed.  Also on
the plus side, we've never shipped a program to globally migrate a
file system by using ioctl interface.

On the other hand, there may have been user shell scripts that have
done something like "find /mntpt -type f -print0 | xargs -0 chattr +e {} \;"
And so option #3 could be construed as "breaking userspace", especially
without a deprecation window.

Furthermore, Option #1 is pretty simple to implement, and chances of a
migration getting spread across two jbd2 commits is not actually
pretty low.  And if it does happen, there would only be a single inode
that would get its blocks cloned and attached to lost+found.

Thats being said, if we *did* option #1, in the long run we'd want to
land a complete solution, which would either be something like option
#2, or allocating a flag to give a hint to e2fsprogs that if it does
find an leaked inode with with the flag set on the on-disk inode, that
all it needs to do is to zero out the inode and be done with it.

So the question is, is it worth it to continue supporting the migrate
feature, or should we just delete all of the migration code, and risk
users complaining that we've broken their use case?  The chances of
that happening is admittedly low, and Linus's rule that "it's only
breaking userspace if a user complains" means we might very well get
away with it.  :-)

						- Ted
