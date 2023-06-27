Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AAD73FFD5
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jun 2023 17:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjF0Pgd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jun 2023 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjF0PgZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jun 2023 11:36:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E93D2D4A
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jun 2023 08:36:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-246.bstnma.fios.verizon.net [173.48.119.246])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35RFaIHH013049
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 11:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687880179; bh=jfG1GFuhPoMAosl3VLkDP5qeRDVr/htHFmqRKU3oBGU=;
        h=Date:From:To:Cc:Subject;
        b=nNudwhU0EzN0K3XDV/e71Og2Elu+M4VLElDqlmLZFJoD9FAPXZbbQZyS7rAiWdUBU
         o3XOsNBwUIkinY4iIRAf1DjrFM4CoAaWFQWztj4z0qPDZ5EpfjDEx082yrJ7OBXFpw
         h0m+iN7sxUznJjol45GHscBgRH9UuQSkQMOY0RS8cGUaeYV1i/lPexaazKKGibq6Hr
         hgR8yOFY8J5qQV/tKCLH4YNqhqsKJjZiCl4TuiCWHjfZdxGyoaWJ4Lf7AgSO/wX9MO
         rhe/sZzwemi9pjiRaXu/lIQc/T028bRcdrPJE2uZXpVH+uLmAPRXNy5q0zLTwMJBQL
         zyScY8Q0+e3Qw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3DA4D15C027E; Tue, 27 Jun 2023 11:36:18 -0400 (EDT)
Date:   Tue, 27 Jun 2023 11:36:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 updates for 6.5
Message-ID: <20230627153618.GA329146@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit f451fd97dd2b78f286379203a47d9d295c467255:

  ext4: drop the call to ext4_error() from ext4_get_group_info() (2023-06-14 22:24:05 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 2ef6c32a914b85217b44a0a2418e830e520b085e:

  ext4: avoid updating the superblock on a r/o mount if not needed (2023-06-26 19:36:45 -0400)


Note: there are some minor merge conflicts; see below for the merge
fixup I used before doing my final regression tests.


----------------------------------------------------------------
Various cleanups and bug fixes in ext4's extent status tree,
journalling, and block allocator subsystems.  Also improve performance
for parallel DIO overwrites.

----------------------------------------------------------------
Baokun Li (14):
      ext4: only update i_reserved_data_blocks on successful block allocation
      ext4: add a new helper to check if es must be kept
      ext4: factor out __es_alloc_extent() and __es_free_extent()
      ext4: use pre-allocated es in __es_insert_extent()
      ext4: use pre-allocated es in __es_remove_extent()
      ext4: using nofail preallocation in ext4_es_remove_extent()
      ext4: using nofail preallocation in ext4_es_insert_delayed_block()
      ext4: using nofail preallocation in ext4_es_insert_extent()
      ext4: make ext4_es_remove_extent() return void
      ext4: make ext4_es_insert_delayed_block() return void
      ext4: make ext4_es_insert_extent() return void
      ext4: make ext4_zeroout_es() return void
      ext4: turn quotas off if mount failed after enabling quotas
      ext4: refactoring to use the unified helper ext4_quotas_off()

Brian Foster (1):
      ext4: allow concurrent unaligned dio overwrites

Chao Yu (1):
      ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Kemeng Shi (11):
      ext4: fix wrong unit use in ext4_mb_normalize_request
      ext4: fix unit mismatch in ext4_mb_new_blocks_simple
      ext4: fix wrong unit use in ext4_mb_find_by_goal
      ext4: treat stripe in block unit
      ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
      ext4: remove ext4_block_group and ext4_block_group_offset declaration
      ext4: try all groups in ext4_mb_new_blocks_simple
      ext4: get block from bh in ext4_free_blocks for fast commit replay
      ext4: remove unused parameter from ext4_mb_new_blocks_simple()
      ext4: fix wrong unit use in ext4_mb_clear_bb
      ext4: fix wrong unit use in ext4_mb_new_blocks

Matthew Wilcox (1):
      ext4: Call fsverity_verify_folio()

Ojaswin Mujoo (9):
      ext4: Convert mballoc cr (criteria) to enum
      ext4: Add per CR extent scanned counter
      ext4: Add counter to track successful allocation of goal length
      ext4: Avoid scanning smaller extents in BG during CR1
      ext4: Don't skip prefetching BLOCK_UNINIT groups
      ext4: Ensure ext4_mb_prefetch_fini() is called for all prefetched BGs
      ext4: Abstract out logic to search average fragment list
      ext4: Add allocation criteria 1.5 (CR1_5)
      ext4: Give symbolic names to mballoc criterias

Ritesh Harjani (6):
      ext4: kill unused function ext4_journalled_write_inline_data
      ext4: Change remaining tracepoints to use folio
      ext4: Make mpage_journal_page_buffers use folio
      ext4: Make ext4_write_inline_data_end() use folio
      ext4: mballoc: Remove useless setting of ac_criteria
      ext4: Remove unused extern variables declaration

Theodore Ts'o (2):
      ext4: clean up mballoc criteria comments
      ext4: avoid updating the superblock on a r/o mount if not needed

Zhang Yi (8):
      jbd2: remove unused feature macros
      jbd2: switch to check format version in superblock directly
      jbd2: factor out journal initialization from journal_get_superblock()
      jbd2: remove j_format_version
      jbd2: continue to record log between each mount
      ext4: add journal cycled recording support
      ext4: update doc about journal superblock description
      jbd2: skip reading super block if it has been verified

Zhihao Cheng (2):
      ext4: Fix reusing stale buffer heads from last failed mounting
      ext4: ext4_put_super: Remove redundant checking for 'sbi->s_journal_bdev'

 Documentation/filesystems/ext4/journal.rst |   7 +-
 fs/ext4/ext4.h                             |  89 +++--
 fs/ext4/extents.c                          |  49 +--
 fs/ext4/extents_status.c                   | 207 +++++++-----
 fs/ext4/extents_status.h                   |  14 +-
 fs/ext4/file.c                             |  86 ++---
 fs/ext4/indirect.c                         |   8 +
 fs/ext4/inline.c                           |  39 +--
 fs/ext4/inode.c                            | 114 +++----
 fs/ext4/ioctl.c                            |   5 +-
 fs/ext4/mballoc.c                          | 644 ++++++++++++++++++++++++------------
 fs/ext4/mballoc.h                          |  16 +-
 fs/ext4/readpage.c                         |   2 +-
 fs/ext4/super.c                            |  86 +++--
 fs/ext4/sysfs.c                            |   2 +
 fs/jbd2/journal.c                          |  78 ++---
 fs/jbd2/recovery.c                         |  22 +-
 include/linux/jbd2.h                       |  42 +--
 include/trace/events/ext4.h                |  44 ++-
 19 files changed, 939 insertions(+), 615 deletions(-)


commit 4b50c2604f922d0cdd4940d338506ecf817cba14
Merge: 1ef6663a587b 2ef6c32a914b
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Tue Jun 27 00:23:58 2023 -0400

    Merge branch 'dev' into test

diff --cc fs/ext4/ioctl.c
index 961284cc9b65,55be1b8a6360..331859511f80
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@@ -793,10 -793,18 +793,11 @@@ static int ext4_ioctl_setproject(struc
  }
  #endif
  
 -static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 +int ext4_force_shutdown(struct super_block *sb, u32 flags)
  {
  	struct ext4_sb_info *sbi = EXT4_SB(sb);
 -	__u32 flags;
+ 	int ret;
  
 -	if (!capable(CAP_SYS_ADMIN))
 -		return -EPERM;
 -
 -	if (get_user(flags, (__u32 __user *)arg))
 -		return -EFAULT;
 -
  	if (flags > EXT4_GOING_FLAGS_NOLOGFLUSH)
  		return -EINVAL;
  
diff --cc fs/ext4/super.c
index eaa5858d5285,c638b0db3b2b..c94ebf704616
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@@ -1133,7 -1128,13 +1133,13 @@@ static void ext4_blkdev_remove(struct e
  	struct block_device *bdev;
  	bdev = sbi->s_journal_bdev;
  	if (bdev) {
+ 		/*
+ 		 * Invalidate the journal device's buffers.  We don't want them
+ 		 * floating about in memory - the physical journal device may
+ 		 * hotswapped, and it breaks the `ro-after' testing code.
+ 		 */
+ 		invalidate_bdev(bdev);
 -		ext4_blkdev_put(bdev);
 +		blkdev_put(bdev, sbi->s_sb);
  		sbi->s_journal_bdev = NULL;
  	}
  }
