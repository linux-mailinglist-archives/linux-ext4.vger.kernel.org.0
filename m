Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484693B00ED
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jun 2021 12:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhFVKHU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Jun 2021 06:07:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40790 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVKHT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Jun 2021 06:07:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3EDF41FD45;
        Tue, 22 Jun 2021 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624356302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=J3kbE7iH7QbzIIxkb82odwgZdE+ENBNes3YiuYmeOBM=;
        b=dbZaYxuILiRaFr5eNjCKVx6KLWyV30rDu5zcZWDodg8k7DNY7SWjEZsUjnr5AvUkLeoYiS
        IHYg6a4F9HqAuNfp8iPFhDinfZYOmytz1WvpkmY7MT9VelJIw7Ly1l+rRfeoLeqtKNjjwd
        fwFvvGTBEW6Ey6AH3SgXEnY/VY7pGY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624356302;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=J3kbE7iH7QbzIIxkb82odwgZdE+ENBNes3YiuYmeOBM=;
        b=dJM0H9PJ8/7nbIk7JI1om+3Wij9R9egMfTmQEuWbdz7G7HypNCeGEN3y6FauKdmkzHQoxG
        XKOS4oqruWUet4Bg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 308DEA3B8D;
        Tue, 22 Jun 2021 10:05:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0FC951E1515; Tue, 22 Jun 2021 12:05:02 +0200 (CEST)
Date:   Tue, 22 Jun 2021 12:05:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [GIT PULL] fs: Hole punch fixes
Message-ID: <20210622100502.GE14261@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  Hello Darrick,

  here is a prepared pull request with the hole punch fixes:

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git hole_punch_fixes_for_5.14-rc1

Top of the tree is a68454854cd9. The full shortlog is:

Jan Kara (13):
      mm: Fix comments mentioning i_mutex
      documentation: Sync file_operations members with reality
      mm: Protect operations adding pages to page cache with invalidate_lock
      mm: Add functions to lock invalidate_lock for two mappings
      ext4: Convert to use mapping->invalidate_lock
      ext2: Convert to using invalidate_lock
      xfs: Convert to use invalidate_lock
      xfs: Convert double locking of MMAPLOCK to use VFS helpers
      zonefs: Convert to using invalidate_lock
      f2fs: Convert to using invalidate_lock
      fuse: Convert to using invalidate_lock
      ceph: Fix race between hole punch and page fault
      cifs: Fix race between hole punch and page fault

Pavel Reichl (1):
      xfs: Refactor xfs_isilocked()

The diffstat is

 Documentation/filesystems/locking.rst |  77 +++++++++++++++-------
 fs/ceph/addr.c                        |   9 ++-
 fs/ceph/file.c                        |   2 +
 fs/cifs/smb2ops.c                     |   2 +
 fs/ext2/ext2.h                        |  11 ----
 fs/ext2/file.c                        |   7 +-
 fs/ext2/inode.c                       |  12 ++--
 fs/ext2/super.c                       |   3 -
 fs/ext4/ext4.h                        |  10 ---
 fs/ext4/extents.c                     |  25 +++----
 fs/ext4/file.c                        |  13 ++--
 fs/ext4/inode.c                       |  47 +++++--------
 fs/ext4/ioctl.c                       |   4 +-
 fs/ext4/super.c                       |  13 ++--
 fs/ext4/truncate.h                    |   8 ++-
 fs/f2fs/data.c                        |   4 +-
 fs/f2fs/f2fs.h                        |   1 -
 fs/f2fs/file.c                        |  62 +++++++++--------
 fs/f2fs/super.c                       |   1 -
 fs/fuse/dax.c                         |  50 +++++++-------
 fs/fuse/dir.c                         |  11 ++--
 fs/fuse/file.c                        |  10 +--
 fs/fuse/fuse_i.h                      |   7 --
 fs/fuse/inode.c                       |   1 -
 fs/inode.c                            |   2 +
 fs/xfs/xfs_bmap_util.c                |  15 +++--
 fs/xfs/xfs_file.c                     |  13 ++--
 fs/xfs/xfs_inode.c                    | 121 ++++++++++++++++++----------------
 fs/xfs/xfs_inode.h                    |   3 +-
 fs/xfs/xfs_super.c                    |   2 -
 fs/zonefs/super.c                     |  23 ++-----
 fs/zonefs/zonefs.h                    |   7 +-
 include/linux/fs.h                    |  39 +++++++++++
 mm/filemap.c                          | 113 ++++++++++++++++++++++++++-----
 mm/madvise.c                          |   2 +-
 mm/memory-failure.c                   |   2 +-
 mm/readahead.c                        |   2 +
 mm/rmap.c                             |  41 ++++++------
 mm/shmem.c                            |  20 +++---
 mm/truncate.c                         |   9 +--
 40 files changed, 453 insertions(+), 351 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
