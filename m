Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAB78EFE6
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Aug 2023 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbjHaPCK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjHaPCJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 11:02:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9096CC5
        for <linux-ext4@vger.kernel.org>; Thu, 31 Aug 2023 08:02:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37VF1u7T023115
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 11:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1693494117; bh=9dV+QS6TSR5ffl+Ay7p8/ER3RyMk7NaB6eV+bCBDktg=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=dSRnGd4c2tQ5lbqKSeMyQdX4nGco15Ib7f4pky+pulVQJZwPWDzv5vApKmyhOiAJJ
         R9PCZ4kqtkZ5opqQTH0by9rzrKQ98oVay1WAqDt28U+JQrU5hoO5rJ65NsTEVFULgO
         iAdHruvjMczrCQkLgBrcDV7r2LuijuK5urX4fh3ayASMdjpQh4Xl9t+uuRIaY1wFnp
         92Y3vbUMmH7eKd7siG6oBH+R2iwBcd36U6OTXcFVzLxqt49lF/8TCGCw854rnLy4J0
         zBMASFTKYawJFY/H+MOdW9Njpu0WfwHKrSOsBCrr/aWRpwyqqwqLbppNUrXY45P6jg
         1uHhXXgaEzwFg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DDE8315C023A; Thu, 31 Aug 2023 11:01:55 -0400 (EDT)
Date:   Thu, 31 Aug 2023 11:01:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] Ext4 updates for 6.6
Message-ID: <20230831150155.GA364946@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Linus,

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.6-rc1

for you to fetch changes up to 768d612f79822d30a1e7d132a4d4b05337ce42ec:

  ext4: fix slab-use-after-free in ext4_es_insert_extent() (2023-08-27 11:27:13 -0400)

Note that there are a merge conflict with Cristoph's fs_holder_ops
patches.  The resolution is a bit complicated, but can be seen here:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_merge_resolution

The merge resolution can also be seen in the linux-next tree.

These changes were fully tested using "gce-xfstests -c ext4/all -g
auto", and there were no regressions.

----------------------------------------------------------------
Many ext4 and jbd2 cleanups and bug fixes for v6.6-rc1.

  * Cleanups in the ext4 remount code when going to and from read-only
  * Cleanups in ext4's multiblock allocator
  * Cleanups in the jbd2 setup/mounting code paths
  * Performance improvements when appending to a delayed allocation file
  * Miscenallenous syzbot and other bug fixes

----------------------------------------------------------------
Baokun Li (4):
      ext4: add two helper functions extent_logical_end() and pa_logical_end()
      ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow
      ext4: avoid overlapping preallocations due to overflow
      ext4: fix slab-use-after-free in ext4_es_insert_extent()

Brian Foster (1):
      ext4: drop dio overwrite only flag and associated warning

Cai Xinchen (1):
      ext4: remove unused function declaration

Eric Biggers (3):
      ext4: reject casefold inode flag without casefold feature
      ext4: remove redundant checks of s_encoding
      libfs: remove redundant checks of s_encoding

Guoqing Cai (1):
      fs: jbd2: fix an incorrect warn log

Jan Kara (11):
      ext4: remove pointless sb_rdonly() checks from freezing code
      ext4: use sb_rdonly() helper for checking read-only flag
      ext4: make ext4_forced_shutdown() take struct super_block
      ext4: make 'abort' mount option handling standard
      ext4: drop EXT4_MF_FS_ABORTED flag
      ext4: avoid starting transaction on read-only fs in ext4_quota_off()
      ext4: warn on read-only filesystem in ext4_journal_check_start()
      ext4: drop read-only check in ext4_init_inode_table()
      ext4: drop read-only check in ext4_write_inode()
      ext4: drop read-only check from ext4_force_commit()
      ext4: replace read-only check for shutdown check in mmp code

Kemeng Shi (10):
      ext4: correct grp validation in ext4_mb_good_group
      ext4: avoid potential data overflow in next_linear_group
      ext4: return found group directly in ext4_mb_choose_next_group_p2_aligned
      ext4: use is_power_of_2 helper in ext4_mb_regular_allocator
      ext4: remove unnecessary return for void function
      ext4: replace the traditional ternary conditional operator with with max()/min()
      ext4: remove unused ext4_{set}/{clear}_bit_atomic
      ext4: return found group directly in ext4_mb_choose_next_group_goal_fast
      ext4: return found group directly in ext4_mb_choose_next_group_best_avail
      ext4: correct some stale comment of criteria

Liu Song (1):
      ext4: do not mark inode dirty every time when appending using delalloc

Lu Hongfei (2):
      ext4: change the type of blocksize in ext4_mb_init_cache()
      ext4: use sbi instead of EXT4_SB(sb) in ext4_mb_new_blocks_simple()

Luís Henriques (1):
      ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}

Ojaswin Mujoo (1):
      ext4: replace CR_FAST macro with inline function for readability

Ritesh Harjani (1):
      ext4: don't use CR_BEST_AVAIL_LEN for non-regular files

Ruan Jinjie (1):
      ext4: use LIST_HEAD() to initialize the list_head in mballoc.c

Su Hui (1):
      ext4: mballoc: avoid garbage value from err

Theodore Ts'o (1):
      ext4: rename s_error_work to s_sb_upd_work

Vitaliy Kuznetsov (1):
      ext4: add periodic superblock update check

Wang Jianjian (2):
      jbd2: remove unused t_handle_lock
      ext4: add correct group descriptors and reserved GDT blocks to system zone

Yang Li (1):
      jbd2: remove unused function '__cp_buffer_busy'

Zhang Yi (14):
      jbd2: fix checkpoint cleanup performance regression
      jbd2: move load_superblock() dependent functions
      jbd2: move load_superblock() into journal_init_common()
      jbd2: don't load superblock in jbd2_journal_check_used_features()
      jbd2: checking valid features early in journal_get_superblock()
      jbd2: open code jbd2_verify_csum_type() helper
      jbd2: cleanup load_superblock()
      jbd2: add fast_commit space check
      jbd2: cleanup journal_init_common()
      jbd2: drop useless error tag in jbd2_journal_wipe()
      jbd2: jbd2_journal_init_{dev,inode} return proper error return value
      ext4: cleanup ext4_get_dev_journal() and ext4_get_journal()
      ext4: ext4_get_{dev}_journal return proper error value
      jbd2: correct the end of the journal recovery scan range

Zhihao Cheng (2):
      jbd2: check 'jh->b_transaction' before removing it from checkpoint
      ext4: fix unttached inode after power cut with orphan file feature enabled

 fs/ext4/balloc.c         |  15 ++-
 fs/ext4/block_validity.c |   8 +-
 fs/ext4/crypto.c         |   4 +
 fs/ext4/ext4.h           |  32 +++--
 fs/ext4/ext4_jbd2.c      |   5 +-
 fs/ext4/extents_status.c |  44 +++++--
 fs/ext4/file.c           |  38 +++---
 fs/ext4/fsync.c          |   9 +-
 fs/ext4/hash.c           |   2 +-
 fs/ext4/ialloc.c         |   8 +-
 fs/ext4/inline.c         |   2 +-
 fs/ext4/inode.c          | 124 +++++++++++-------
 fs/ext4/ioctl.c          |   2 +-
 fs/ext4/mballoc.c        | 200 +++++++++++++----------------
 fs/ext4/mballoc.h        |  14 ++
 fs/ext4/mmp.c            |   2 +-
 fs/ext4/namei.c          |  17 ++-
 fs/ext4/page-io.c        |   2 +-
 fs/ext4/super.c          | 308 +++++++++++++++++++++++++-------------------
 fs/ext4/xattr.c          |   2 +-
 fs/jbd2/checkpoint.c     |  34 +++--
 fs/jbd2/journal.c        | 484 +++++++++++++++++++++++++++++++++-------------------------------------
 fs/jbd2/recovery.c       |  12 +-
 fs/libfs.c               |  14 +-
 fs/ocfs2/journal.c       |   8 +-
 include/linux/jbd2.h     |   5 -
 26 files changed, 717 insertions(+), 678 deletions(-)
