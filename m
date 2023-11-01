Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733BB7DDAFC
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Nov 2023 03:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjKAC21 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Oct 2023 22:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjKAC21 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Oct 2023 22:28:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A249DA
        for <linux-ext4@vger.kernel.org>; Tue, 31 Oct 2023 19:28:24 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-73.bstnma.fios.verizon.net [173.48.111.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3A12SJL6027238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 22:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1698805700; bh=s2PO5WuG2mbhx+EdVqHqvRSzJCzMfyAXF+xpBka65rc=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=op4967HmVuqzMvQgHqySUxyEcCi6HTKqDylcPFP5AKM6YsBTKuVvOEKZm+IGfcxZw
         psDh715ObPTdqapbBxpL5gDip0/+PlbBZClnmGggbC0xxMfT7YEs5ZgfjxECfgCL0Y
         JytdkSZaNH1bV3ceZ+dmLN8k6w8XysSILsBIAE4zNm4ZYcMMhXUNeApDH3/dMyw1cN
         wgcp/uMP8XXXcWLCBgo11Mc49cUk/480GviqL7pH5CiL34g/zI8u9kg3KPxSnWAYf2
         bMO1Xs2CNAHF1oSn5JWX6GEQ6ExPyXTCebJkTWi/pabxpLlxx47TB3MzZmGkMkxqSa
         u3hbE7Qfe16JA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DFBBC15C024D; Tue, 31 Oct 2023 22:28:18 -0400 (EDT)
Date:   Tue, 31 Oct 2023 22:28:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 update for v6.7-rc1
Message-ID: <20231101022818.GA108790@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.7-rc1

for you to fetch changes up to 91562895f8030cb9a0470b1db49de79346a69f91:

  ext4: properly sync file size update after O_SYNC direct IO (2023-10-31 20:20:55 -0400)

----------------------------------------------------------------
Cleanup ext4's multi-block allocator, including adding some unit
tests, as well as cleaning how we update the backup superblock after
online resizes or updating the label or uuid.

Optimize handling of released data blocks in ext4's commit machinery
to avoid a potential lock contention on s_md_lock spinlock.

Fix a number of ext4 bugs:

 - fix race between writepages and remount
 - fix racy may inline data check in dio write
 - add missed brelse in an error path in update_backups
 - fix umask handling when ACL support is disabled
 - fix lost EIO error when a journal commit races with a fsync of the
   blockdev
 - fix potential improper i_size when there is a crash right after an
   O_SYNC direct  write.
 - check extent node for validity before potentially using what might
   be an invalid pointer
 - fix potential stale data exposure when writing to an unwritten extent
   and the file system is nearly out of space
 - fix potential accounting error around block reservations when writing
   partial delayed allocation writes to a bigalloc cluster
 - avoid memory allocation failure when tracking partial delayed allocation
   writes to a bigalloc cluster
 - fix various debugging print messages

----------------------------------------------------------------
Baokun Li (1):
      ext4: fix race between writepages and remount

Brian Foster (1):
      ext4: fix racy may inline data check in dio write

Gou Hao (1):
      ext4: move 'ix' sanity check to corrent position

Jan Kara (1):
      ext4: properly sync file size update after O_SYNC direct IO

Jinke Han (1):
      ext4: make running and commit transaction have their own freed_data_list

Kemeng Shi (25):
      ext4: correct offset of gdb backup in non meta_bg group to update_backups
      ext4: add missed brelse in update_backups
      ext4: correct return value of ext4_convert_meta_bg
      ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks
      ext4: fix typo in setup_new_flex_group_blocks
      ext4: remove redundant check of count
      ext4: remove commented code in reserve_backup_gdb
      ext4: calculate free_clusters_count in cluster unit in verify_group_input
      ext4: remove EXT4FS_DEBUG defination in resize.c
      ext4: use saved local variable sbi instead of EXT4_SB(sb)
      ext4: simplify the gdbblock calculation in add_new_gdb_meta_bg
      ext4: remove unnecessary check to avoid repeat update_backups for the same gdb
      ext4: remove unnecessary initialization of count2 in set_flexbg_block_bitmap
      ext4: make state in ext4_mb_mark_bb to be bool
      ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
      ext4: call ext4_mb_mark_context in ext4_free_blocks_simple
      ext4: extend ext4_mb_mark_context to support allocation under journal
      ext4: call ext4_mb_mark_context in ext4_mb_mark_diskspace_used
      ext4: Separate block bitmap and buddy bitmap freeing in ext4_mb_clear_bb()
      ext4: call ext4_mb_mark_context in ext4_mb_clear_bb
      ext4: Separate block bitmap and buddy bitmap freeing in ext4_group_add_blocks()
      ext4: call ext4_mb_mark_context in ext4_group_add_blocks()
      ext4: add some kunit stub for mballoc kunit test
      ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
      ext4: run mballoc test with different layouts setting

Lu Hongfei (1):
      ext4: fix traditional comparison using max/min method

Max Kellermann (1):
      ext4: apply umask if ACL support is disabled

Ojaswin Mujoo (1):
      ext4: mark buffer new if it is unwritten to avoid stale data exposure

Theodore Ts'o (1):
      ext4: add missing initialization of call_notify_error in update_super_work()

Wang Jianjian (2):
      ext4: fix incorrect offset
      ext4: no need to generate from free list in mballoc

Ye Bin (2):
      jbd2: print io_block if check data block checksum failed when do recovery
      jbd2: fix printk format type for 'io_block' in do_one_pass()

Zhang Yi (2):
      ext4: correct the start block of counting reserved clusters
      ext4: make sure allocate pending entry not fail

Zhihao Cheng (1):
      jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev

 fs/ext4/acl.h            |   5 +
 fs/ext4/balloc.c         |  16 +-
 fs/ext4/ext4.h           |   8 +-
 fs/ext4/extents.c        |  14 +-
 fs/ext4/extents_status.c | 127 ++++++++----
 fs/ext4/fast_commit.c    |   8 +-
 fs/ext4/file.c           | 169 +++++++---------
 fs/ext4/inode.c          |  14 +-
 fs/ext4/mballoc-test.c   | 349 +++++++++++++++++++++++++++++++++
 fs/ext4/mballoc.c        | 571 +++++++++++++++++++-----------------------------------
 fs/ext4/namei.c          |   3 +-
 fs/ext4/resize.c         |  94 ++++-----
 fs/ext4/super.c          |  17 +-
 fs/jbd2/recovery.c       |  13 +-
 14 files changed, 823 insertions(+), 585 deletions(-)
 create mode 100644 fs/ext4/mballoc-test.c
