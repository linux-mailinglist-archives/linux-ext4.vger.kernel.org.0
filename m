Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3824C48A2A9
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jan 2022 23:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbiAJWWK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jan 2022 17:22:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46247 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242105AbiAJWWK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Jan 2022 17:22:10 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20AMM5lX017578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 17:22:06 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8332215C00C8; Mon, 10 Jan 2022 17:22:05 -0500 (EST)
Date:   Mon, 10 Jan 2022 17:22:05 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 updates for 5.17
Message-ID: <YdyxjTFaLWif6BCM@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 6eeaf88fd586f05aaf1d48cb3a139d2a5c6eb055:

  ext4: don't use the orphan list when migrating an inode (2022-01-10 13:25:56 -0500)

----------------------------------------------------------------
Convert ext4 to use the new mount API, and add support for the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.  In addition the usual
large number of clean ups and bug fixes, in particular for the
fast_commit feature.

----------------------------------------------------------------
Adam Borowski (1):
      ext4: drop an always true check

Chunguang Xu (1):
      ext4: fix a possible ABBA deadlock due to busy PA

Dan Carpenter (1):
      ext4: fix a copy and paste typo

Harshad Shirwadkar (5):
      ext4: use ext4_journal_start/stop for fast commit transactions
      ext4: drop ineligible txn start stop APIs
      ext4: simplify updating of fast commit stats
      ext4: update fast commit TODOs
      ext4: initialize err_blk before calling __ext4_get_inode_loc

Jan Kara (3):
      ext4: make sure quota gets properly shutdown on error
      ext4: make sure to reset inode lockdep class when quota enabling fails
      ext4: avoid trim error on fs with small groups

Lukas Czerner (21):
      fs_parse: allow parameter value to be empty
      ext4: Add fs parameter specifications for mount options
      ext4: move option validation to a separate function
      ext4: Change handle_mount_opt() to use fs_parameter
      ext4: Allow sb to be NULL in ext4_msg()
      ext4: move quota configuration out of handle_mount_opt()
      ext4: check ext2/3 compatibility outside handle_mount_opt()
      ext4: get rid of super block and sbi from handle_mount_ops()
      ext4: Completely separate options parsing and sb setup
      ext4: clean up return values in handle_mount_opt()
      ext4: change token2str() to use ext4_param_specs
      ext4: switch to the new mount api
      ext4: Remove unused match_table_t tokens
      ext4: don't fail remount if journalling mode didn't change
      ext4: remove lazytime/nolazytime mount options handled by MS_LAZYTIME
      ext4: fix i_version handling on remount
      ext4: don't use kfree() on rcu protected pointer sbi->s_qf_names
      ext4: only set EXT4_MOUNT_QUOTA when journalled quota file is specified
      ext4: implement support for get/set fs label
      ext4: change s_last_trim_minblks type to unsigned long
      ext4: allow to change s_last_trim_minblks via sysfs

Luís Henriques (1):
      ext4: set csum seed in tmp inode while migrating to extents

Nghia Le (1):
      ext4: remove useless resetting io_end_size in mpage_process_page()

Qing Wang (1):
      ext4: replace snprintf in show functions with sysfs_emit

Sebastian Andrzej Siewior (1):
      ext4: destroy ext4_fc_dentry_cachep kmemcache on module removal

Theodore Ts'o (1):
      ext4: don't use the orphan list when migrating an inode

Xin Yin (3):
      ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
      ext4: use ext4_ext_remove_space() for fast commit replay delete range
      ext4: fast commit may miss tracking unwritten range during ftruncate

Ye Bin (2):
      ext4: Fix BUG_ON in ext4_bread when write quota data
      ext4: fix null-ptr-deref in '__ext4_journal_ensure_credits'

Zhang Yi (1):
      ext4: fix an use-after-free issue about data=journal writeback mode

luo penghao (4):
      ext4: remove redundant statement
      ext4: remove unused assignments
      ext4: remove redundant o_start statement
      ext4: remove unnecessary 'offset' assignment

xu xin (1):
      ext4: use BUG_ON instead of if condition followed by BUG

 fs/ext4/acl.c               |    2 -
 fs/ext4/dir.c               |    1 -
 fs/ext4/ext4.h              |   22 +-
 fs/ext4/ext4_jbd2.c         |    2 +
 fs/ext4/extents.c           |   16 +-
 fs/ext4/fast_commit.c       |  207 ++++----
 fs/ext4/fast_commit.h       |   27 +-
 fs/ext4/file.c              |    4 -
 fs/ext4/inode.c             |   60 +--
 fs/ext4/ioctl.c             |  324 +++++++++++-
 fs/ext4/mballoc.c           |   52 +-
 fs/ext4/migrate.c           |   23 +-
 fs/ext4/move_extent.c       |    1 -
 fs/ext4/resize.c            |   19 +-
 fs/ext4/super.c             | 1915 +++++++++++++++++++++++++++++++++++++++++++-------------------------
 fs/ext4/sysfs.c             |   36 +-
 fs/fs_parser.c              |   31 +-
 fs/jbd2/journal.c           |    2 +
 include/linux/fs_parser.h   |    2 +-
 include/trace/events/ext4.h |   23 +
 20 files changed, 1770 insertions(+), 999 deletions(-)
