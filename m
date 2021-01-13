Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DB62F4FF8
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jan 2021 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhAMQak (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 11:30:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:56606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbhAMQak (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 13 Jan 2021 11:30:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69F31AD57;
        Wed, 13 Jan 2021 16:29:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1BACD1E08EE; Wed, 13 Jan 2021 17:29:58 +0100 (CET)
Date:   Wed, 13 Jan 2021 17:29:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 00/11] lazytime fix and cleanups
Message-ID: <20210113162957.GA26686@quack2.suse.cz>
References: <20210112190253.64307-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112190253.64307-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Tue 12-01-21 11:02:42, Eric Biggers wrote:
> Patch 1 fixes a bug in how __writeback_single_inode() handles lazytime
> expirations.  I originally reported this last year
> (https://lore.kernel.org/r/20200306004555.GB225345@gmail.com) because it
> causes the FS_IOC_REMOVE_ENCRYPTION_KEY ioctl to not work properly, as
> the bug causes inodes to remain dirty after a sync.
> 
> It also turns out that lazytime on XFS is partially broken because it
> doesn't actually write timestamps to disk after a sync() or after
> dirtytime_expire_interval.  This is fixed by the same fix.
> 
> This supersedes previously proposed fixes, including
> https://lore.kernel.org/r/20200307020043.60118-1-tytso@mit.edu and
> https://lore.kernel.org/r/20200325122825.1086872-3-hch@lst.de from last
> year (which had some issues and didn't fix the XFS bug), and v1 of this
> patchset which took a different approach
> (https://lore.kernel.org/r/20210105005452.92521-1-ebiggers@kernel.org).
> 
> Patches 2-11 then clean up various things related to lazytime and
> writeback, such as clarifying the semantics of ->dirty_inode() and the
> inode dirty flags, and improving comments.
> 
> This patchset applies to v5.11-rc2.

Thanks for the patches. I've picked the patches to my tree. I plan to push
patch 1/11 to Linus later this week, the rest of the cleanups will go to
him during the next merge window.

								Honza

> 
> Changed v2 => v3:
>   - Changed ext4 patch to add a helper function
>     inode_is_dirtytime_only() to include/linux/fs.h.
>   - Dropped XFS cleanup patch, as it can be sent/applied separately.
>   - Added Reviewed-by's.
> 
> Changed v1 => v2:
>   - Switched to the fix suggested by Jan Kara, and dropped the
>     patches which introduced ->lazytime_expired().
>   - Fixed bugs in the fat and ext4 patches.
>   - Added patch "fs: improve comments for writeback_single_inode()".
>   - Reordered the patches a bit.
>   - Added Reviewed-by's.
> 
> Eric Biggers (11):
>   fs: fix lazytime expiration handling in __writeback_single_inode()
>   fs: correctly document the inode dirty flags
>   fs: only specify I_DIRTY_TIME when needed in generic_update_time()
>   fat: only specify I_DIRTY_TIME when needed in fat_update_time()
>   fs: don't call ->dirty_inode for lazytime timestamp updates
>   fs: pass only I_DIRTY_INODE flags to ->dirty_inode
>   fs: clean up __mark_inode_dirty() a bit
>   fs: drop redundant check from __writeback_single_inode()
>   fs: improve comments for writeback_single_inode()
>   gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()
>   ext4: simplify i_state checks in __ext4_update_other_inode_time()
> 
>  Documentation/filesystems/vfs.rst |   5 +-
>  fs/ext4/inode.c                   |  20 +----
>  fs/f2fs/super.c                   |   3 -
>  fs/fat/misc.c                     |  23 +++---
>  fs/fs-writeback.c                 | 132 +++++++++++++++++-------------
>  fs/gfs2/file.c                    |   4 +-
>  fs/gfs2/super.c                   |   2 -
>  fs/inode.c                        |  38 +++++----
>  include/linux/fs.h                |  33 ++++++--
>  9 files changed, 146 insertions(+), 114 deletions(-)
> 
> 
> base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
