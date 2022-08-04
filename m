Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3F589720
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 06:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiHDEoK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 00:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiHDEoJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 00:44:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766775927F;
        Wed,  3 Aug 2022 21:44:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2744i4Vo007346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 Aug 2022 00:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1659588245; bh=4LiWPg8lKhe7f68b47/5MyQejevlHO1PMlPEY1WpWFU=;
        h=Date:From:To:Cc:Subject;
        b=X+WLcYDnfsFYB6lB0DsUOb9cLYES9svUyd2Fr21k10AYFoJut/uPCEzkpLy8m+87b
         gxT9k2CANs5OrqDgsWmV2ULgsSBRqYbblB082efkLDXMeFi8kdAaf4NkQ0UyH/r31f
         pB+g6o/rS8UhA5451NcWr+dNynQV+kgN9MOMj+wscNMJrCpmP4uHDwA6fzB5HSD9pH
         TUhqy44eWNPP2UEacIBYlvX5XkivTQPQhdEPocL11Ztf7vwhLk1G0htDCzFXpdQ8bK
         NOzSGw71YkBbnmUOB8QjItqBX9rMLejaF6OrtlYroN4itnxsbdA+7krfttvN0Lqapn
         mRvOVBMjRf34Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D91E615C00E4; Thu,  4 Aug 2022 00:44:03 -0400 (EDT)
Date:   Thu, 4 Aug 2022 00:44:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 updates for 5.20/6.0
Message-ID: <YutOk+yCBPujKZeA@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864acf:

  Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to d95efb14c0b81b684deb32ba10cdb78b4178ae5b:

  ext4: add ioctls to get/set the ext4 superblock uuid (2022-08-02 23:56:26 -0400)

----------------------------------------------------------------
Add new ioctls to set and get the file system UUID in the ext4
superblock and improved the performance of the online resizing of file
systems with bigalloc enabled.  Fixed a lot of bugs, in particular for
the inline data feature, potential races when creating and deleting
inodes with shared extended attribute blocks, and the handling
directory blocks which are corrupted.

----------------------------------------------------------------
Bagas Sanjaya (1):
      Documentation: ext4: fix cell spacing of table heading on blockmap table

Baokun Li (4):
      ext4: add EXT4_INODE_HAS_XATTR_SPACE macro in xattr.h
      ext4: fix use-after-free in ext4_xattr_set_entry
      ext4: correct max_inline_xattr_value_size computing
      ext4: correct the misjudgment in ext4_iget_extra_inode

Eric Whitney (1):
      ext4: fix extent status tree race in writeback error recovery path

Jan Kara (14):
      ext4: use ext4_debug() instead of jbd_debug()
      jbd2: rename jbd_debug() to jbd2_debug()
      jbd2: remove unused exports for jbd2 debugging
      jbd2: unexport jbd2_log_start_commit()
      mbcache: don't reclaim used entries
      mbcache: add functions to delete entry if unused
      ext4: remove EA inode entry from mbcache on inode eviction
      ext4: unindent codeblock in ext4_xattr_block_set()
      ext4: fix race when reusing xattr blocks
      ext2: factor our freeing of xattr block reference
      ext2: unindent codeblock in ext2_xattr_set()
      ext2: avoid deleting xattr block that is being reused
      mbcache: Remove mb_cache_entry_delete()
      mbcache: automatically delete entries from cache on freeing

Jeremy Bongio (1):
      ext4: add ioctls to get/set the ext4 superblock uuid

Jiang Jian (1):
      ext4: aligned '*' in comments

Kiselev, Oleg (2):
      ext4: reduce computation of overhead during resize
      ext4: avoid resizing to a partial cluster size

Li Lingfeng (1):
      ext4: recover csum seed of tmp_inode after migrating to extents

Lukas Czerner (3):
      ext4: check if directory block is within i_size
      ext4: make sure ext4_append() always allocates new block
      ext4: block range must be validated before use in ext4_mb_clear_bb()

Ojaswin Mujoo (1):
      ext4: reflect mb_optimize_scan value in options file

Theodore Ts'o (2):
      ext4: update s_overhead_clusters in the superblock during an on-line resize
      ext4: update the s_overhead_clusters in the backup sb's when resizing

Ye Bin (2):
      ext4: fix warning in ext4_iomap_begin as race between bmap and write
      ext4: avoid remove directory when directory is corrupted

Zhang Yi (2):
      ext4: fix reading leftover inlined symlinks
      jbd2: fix outstanding credits assert in jbd2_journal_commit_transaction()

Zhihao Cheng (1):
      jbd2: fix assertion 'jh->b_frozen_data == NULL' failure when journal aborted

hanjinke (1):
      ext4: reuse order and buddy in mb_mark_used when buddy split

 Documentation/filesystems/ext4/blockmap.rst |   2 +-
 fs/ext2/xattr.c                             | 170 ++++++++++++++++++----------------------
 fs/ext4/balloc.c                            |   2 +-
 fs/ext4/ext4.h                              |  16 +++-
 fs/ext4/ext4_jbd2.c                         |   3 +-
 fs/ext4/fast_commit.c                       |  44 +++++------
 fs/ext4/indirect.c                          |   4 +-
 fs/ext4/inline.c                            |  33 ++++++++
 fs/ext4/inode.c                             |  26 ++++--
 fs/ext4/ioctl.c                             | 105 +++++++++++++++++++++++--
 fs/ext4/mballoc.c                           |  31 +++++++-
 fs/ext4/migrate.c                           |   4 +-
 fs/ext4/namei.c                             |  30 +++++--
 fs/ext4/orphan.c                            |  24 +++---
 fs/ext4/resize.c                            |  39 ++++++++-
 fs/ext4/super.c                             |  13 ++-
 fs/ext4/symlink.c                           |  15 ++++
 fs/ext4/xattr.c                             | 168 +++++++++++++++++++++------------------
 fs/ext4/xattr.h                             |  16 +++-
 fs/jbd2/checkpoint.c                        |   6 +-
 fs/jbd2/commit.c                            |  32 ++++----
 fs/jbd2/journal.c                           |  41 +++++-----
 fs/jbd2/recovery.c                          |  30 +++----
 fs/jbd2/revoke.c                            |   8 +-
 fs/jbd2/transaction.c                       |  40 ++++++----
 fs/mbcache.c                                | 123 +++++++++++++++--------------
 include/linux/jbd2.h                        |   6 +-
 include/linux/mbcache.h                     |  33 +++++---
 28 files changed, 678 insertions(+), 386 deletions(-)
