Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173903B89E1
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhF3UwA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 16:52:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42983 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229700AbhF3Uv7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 16:51:59 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15UKnRJf032142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 16:49:27 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2E04D15C3C8E; Wed, 30 Jun 2021 16:49:27 -0400 (EDT)
Date:   Wed, 30 Jun 2021 16:49:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 updates for v5.14
Message-ID: <YNzY12HgR4UViC4/@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 16aa4c9a1fbe763c147a964cdc1f5be8ed98ed13:

  jbd2: export jbd2_journal_[un]register_shrinker() (2021-06-30 11:05:00 -0400)

----------------------------------------------------------------
In addition to bug fixes and cleanups, there are two new features for
ext4 in 5.14:
 - Allow applications to poll on changes to /sys/fs/ext4/*/errors_count
 - Add the ioctl EXT4_IOC_CHECKPOINT which allows the journal to be
   checkpointed, truncated and discarded or zero'ed.

----------------------------------------------------------------
Anirudh Rayabharam (1):
      ext4: fix kernel infoleak via ext4_extent_header

Eric Biggers (1):
      ext4: fix comment for s_hash_unsigned

Jan Kara (1):
      ext4: fix overflow in ext4_iomap_alloc()

Jiapeng Chong (1):
      ext4: remove redundant assignment to error

Jonathan Davies (1):
      ext4: notify sysfs on errors_count value change

Joseph Qi (1):
      ext4: remove redundant check buffer_uptodate()

Josh Triplett (2):
      ext4: consolidate checks for resize of bigalloc into ext4_resize_begin
      ext4: add check to prevent attempting to resize an fs with sparse_super2

Leah Rumancik (3):
      ext4: add discard/zeroout flags to journal flush
      ext4: add ioctl EXT4_IOC_CHECKPOINT
      ext4: update journal documentation

Pan Dong (1):
      ext4: fix avefreec in find_group_orlov

Pavel Skripkin (1):
      ext4: fix memory leak in ext4_fill_super

Ritesh Harjani (2):
      ext4: fsmap: fix the block/inode bitmap comment
      ext4: remove duplicate definition of ext4_xattr_ibody_inline_set()

Tian Tao (1):
      ext4: remove set but rewrite variables

Yang Yingliang (1):
      ext4: return error code when ext4_fill_flex_info() fails

Zhang Yi (12):
      ext4: cleanup in-core orphan list if ext4_truncate() failed to get a transaction handle
      ext4: remove check for zero nr_to_scan in ext4_es_scan()
      ext4: correct the cache_nr in tracepoint ext4_es_shrink_exit
      jbd2: remove the out label in __jbd2_journal_remove_checkpoint()
      jbd2: ensure abort the journal if detect IO error when writing original buffer back
      jbd2: don't abort the journal when freeing buffers
      jbd2: remove redundant buffer io error checks
      jbd2,ext4: add a shrinker to release checkpointed buffers
      jbd2: simplify journal_clean_one_cp_list()
      ext4: remove bdev_try_to_free_page() callback
      fs: remove bdev_try_to_free_page callback
      jbd2: export jbd2_journal_[un]register_shrinker()

chenyichong (1):
      ext4: use local variable ei instead of EXT4_I() macro

yangerkun (2):
      jbd2: clean up misleading comments for jbd2_fc_release_bufs
      ext4: no need to verify new add extent block

 Documentation/filesystems/ext4/journal.rst |  39 +++++--
 fs/block_dev.c                             |  15 ---
 fs/ext4/ext4.h                             |  18 ++-
 fs/ext4/extents.c                          |   4 +
 fs/ext4/extents_status.c                   |   4 +-
 fs/ext4/fsmap.h                            |   4 +-
 fs/ext4/ialloc.c                           |  11 +-
 fs/ext4/inline.c                           |  11 +-
 fs/ext4/inode.c                            |   8 +-
 fs/ext4/ioctl.c                            |  80 +++++++++----
 fs/ext4/mmp.c                              |  28 +++--
 fs/ext4/namei.c                            |   2 +-
 fs/ext4/resize.c                           |   9 ++
 fs/ext4/super.c                            |  57 +++++----
 fs/ext4/sysfs.c                            |   5 +
 fs/ext4/xattr.c                            |  26 +----
 fs/ext4/xattr.h                            |   6 +-
 fs/jbd2/checkpoint.c                       | 206 ++++++++++++++++++++++++++-------
 fs/jbd2/journal.c                          | 230 +++++++++++++++++++++++++++++++++++--
 fs/jbd2/transaction.c                      |  17 ---
 fs/ocfs2/alloc.c                           |   2 +-
 fs/ocfs2/journal.c                         |   8 +-
 include/linux/fs.h                         |   1 -
 include/linux/jbd2.h                       |  43 ++++++-
 include/trace/events/jbd2.h                | 101 ++++++++++++++++
 25 files changed, 720 insertions(+), 215 deletions(-)
