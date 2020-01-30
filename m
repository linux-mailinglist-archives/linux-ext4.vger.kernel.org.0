Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4AC14D4E4
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jan 2020 01:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgA3A6Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jan 2020 19:58:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47048 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726760AbgA3A6Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jan 2020 19:58:16 -0500
Received: from callcc.thunk.org (guestnat-104-133-9-100.corp.google.com [104.133.9.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00U0w7fD007678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 19:58:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 260E6420324; Wed, 29 Jan 2020 19:58:17 -0500 (EST)
Date:   Wed, 29 Jan 2020 19:58:17 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 changes for 5.6
Message-ID: <20200130005817.GA331314@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 7f6225e446cc8dfa4c3c7959a4de3dd03ec277bf:

  jbd2: clean __jbd2_journal_abort_hard() and __journal_abort_soft() (2020-01-25 03:01:56 -0500)

----------------------------------------------------------------
This merge window, we've added some performance improvements in how we
handle inode locking in the read/write paths, and improving the
performance of Direct I/O overwrites.  We also now record the error
code which caused the first and most recent ext4_error() report in the
superblock, to make it easier to root cause problems in production
systems.  There are also many of the usual cleanups and miscellaneous
bug fixes.

----------------------------------------------------------------
Chengguang Xu (2):
      ext4: remove unnecessary assignment in ext4_htree_store_dirent()
      ext4: choose hardlimit when softlimit is larger than hardlimit in ext4_statfs_project()

Dmitry Monakhov (3):
      ext4: fix extent_status fragmentation for plain files
      ext4: fix symbolic enum printing in trace output
      ext4: fix extent_status trace points

Eric Biggers (20):
      ext4: remove unnecessary ifdefs in htree_dirblock_to_tree()
      ext4: uninline ext4_inode_journal_mode()
      ext4: remove unnecessary selections from EXT3_FS
      docs: ext4.rst: add encryption and verity to features list
      ext4: handle decryption error in __ext4_block_zero_page_range()
      ext4: allow ZERO_RANGE on encrypted files
      ext4: only use fscrypt_zeroout_range() on regular files
      ext4: re-enable extent zeroout optimization on encrypted files
      ext4: fix deadlock allocating crypto bounce page from mempool
      ext4: fix deadlock allocating bio_post_read_ctx from mempool
      ext4: remove unneeded check for error allocating bio_post_read_ctx
      ext4: remove ext4_{ind,ext}_calc_metadata_amount()
      ext4: clean up len and offset checks in ext4_fallocate()
      ext4: remove redundant S_ISREG() checks from ext4_fallocate()
      ext4: make some functions static in extents.c
      ext4: fix documentation for ext4_ext_try_to_merge()
      ext4: remove obsolete comment from ext4_can_extents_be_merged()
      ext4: fix some nonstandard indentation in extents.c
      ext4: add missing braces in ext4_ext_drop_refs()
      ext4: fix race conditions in ->d_compare() and ->d_hash()

Jan Kara (1):
      ext4: Optimize ext4 DIO overwrites

Kai Li (1):
      jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal

Martijn Coenen (1):
      ext4: Add EXT4_IOC_FSGETXATTR/EXT4_IOC_FSSETXATTR to compat_ioctl

Naoto Kobayashi (1):
      ext4: Delete ext4_kvzvalloc()

Ritesh Harjani (4):
      ext4: fix ext4_dax_read/write inode locking sequence for IOCB_NOWAIT
      ext4: Start with shared i_rwsem in case of DIO instead of exclusive
      ext4: Move to shared i_rwsem even without dioread_nolock mount opt
      ext4: remove unused macro MPAGE_DA_EXTENT_TAIL

Shijie Luo (2):
      ext4,jbd2: fix comment and code style
      jbd2: remove pointless assertion in __journal_remove_journal_head

Theodore Ts'o (8):
      ext4: treat buffers contining write errors as valid in ext4_sb_bread()
      Merge branch 'rk/inode_lock' into dev
      ext4: save the error code which triggered an ext4_error() in the superblock
      ext4: simulate various I/O and checksum errors when reading metadata
      ext4: export information about first/last errors via /sys/fs/ext4/<dev>
      ext4: avoid fetching btime in ext4_getattr() unless requested
      ext4: drop ext4_kvmalloc()
      ext4: make dioread_nolock the default

Vasily Averin (1):
      jbd2_seq_info_next should increase position index

wangyan (1):
      jbd2: delete the duplicated words in the comments

zhangyi (F) (4):
      jbd2: switch to use jbd2_journal_abort() when failed to submit the commit record
      ext4, jbd2: ensure panic when aborting with zero errno
      jbd2: make sure ESHUTDOWN to be recorded in the journal superblock
      jbd2: clean __jbd2_journal_abort_hard() and __journal_abort_soft()

zhengbin (1):
      ext4: use true,false for bool variable

 Documentation/admin-guide/ext4.rst    |   2 +
 Documentation/filesystems/fscrypt.rst |   6 +--
 fs/ext4/Kconfig                       |   6 ---
 fs/ext4/balloc.c                      |   5 +-
 fs/ext4/dir.c                         |  10 ++--
 fs/ext4/ext4.h                        |  81 +++++++++++++++++++++++++------
 fs/ext4/ext4_extents.h                |   5 --
 fs/ext4/ext4_jbd2.c                   |  25 ++++++++++
 fs/ext4/ext4_jbd2.h                   |  22 +--------
 fs/ext4/extents.c                     | 205 +++++++++++++++++++++++++++++-------------------------------------------------
 fs/ext4/extents_status.h              |   6 +++
 fs/ext4/file.c                        | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 fs/ext4/ialloc.c                      |   6 ++-
 fs/ext4/indirect.c                    |  26 ----------
 fs/ext4/inline.c                      |   4 +-
 fs/ext4/inode.c                       |  53 +++++++++++++++-----
 fs/ext4/ioctl.c                       |   2 +
 fs/ext4/mballoc.c                     |   4 ++
 fs/ext4/mmp.c                         |   6 ++-
 fs/ext4/namei.c                       |  20 +++++---
 fs/ext4/page-io.c                     |  19 ++++++--
 fs/ext4/readpage.c                    |  42 ++++++++--------
 fs/ext4/resize.c                      |  10 ++--
 fs/ext4/super.c                       | 122 +++++++++++++++++++++++++++++++++-------------
 fs/ext4/sysfs.c                       |  88 +++++++++++++++++++++++++++++++++-
 fs/ext4/xattr.c                       |   6 ++-
 fs/jbd2/checkpoint.c                  |   2 +-
 fs/jbd2/commit.c                      |   4 +-
 fs/jbd2/journal.c                     | 119 +++++++++++++++++++--------------------------
 fs/jbd2/transaction.c                 |   4 +-
 include/linux/jbd2.h                  |   1 -
 include/trace/events/ext4.h           |  27 +++++++++--
 32 files changed, 709 insertions(+), 432 deletions(-)

