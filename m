Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470471EEE2E
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 01:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgFDXNI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Jun 2020 19:13:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59759 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725943AbgFDXNH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Jun 2020 19:13:07 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 054NCxeT012058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 Jun 2020 19:13:00 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B8E4B4200DD; Thu,  4 Jun 2020 19:12:59 -0400 (EDT)
Date:   Thu, 4 Jun 2020 19:12:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 changes for 5.8-rc1
Message-ID: <20200604231259.GA1992367@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 6b8ed62008a49751fc71fefd2a4f89202a7c2d4d:

  ext4: avoid unnecessary transaction starts during writeback (2020-06-03 23:16:56 -0400)

----------------------------------------------------------------
A lot of bug fixes and cleanups for ext4, including:

* Fix performance problems found in dioread_nolock now that it is the
  default, caused by transaction leaks.
* Clean up fiemap handling in ext4
* Clean up and refactor multiple block allocator (mballoc) code
* Fix a problem with mballoc with a smaller file systems running out
  of blocks because they couldn't properly use blocks that had been
  reserved by inode preallocation.
* Fixed a race in ext4_sync_parent() versus rename()
* Simplify the error handling in the extent manipulation code
* Make sure all metadata I/O errors are felected to ext4_ext_dirty()'s and
  ext4_make_inode_dirty()'s callers.
* Avoid passing an error pointer to brelse in ext4_xattr_set()
* Fix race which could result to freeing an inode on the dirty last
  in data=journal mode.
* Fix refcount handling if ext4_iget() fails
* Fix a crash in generic/019 caused by a corrupted extent node

----------------------------------------------------------------
Carlos Guerrero Álvarez (1):
      ext4: fix a style issue in fs/ext4/acl.c

Christoph Hellwig (10):
      ext4: fix fiemap size checks for bitmap files
      ext4: split _ext4_fiemap
      ext4: remove the call to fiemap_check_flags in ext4_fiemap
      fs: mark __generic_block_fiemap static
      fs: move the fiemap definitions out of fs.h
      iomap: fix the iomap_fiemap prototype
      fs: move fiemap range validation into the file systems instances
      fs: handle FIEMAP_FLAG_SYNC in fiemap_prep
      fs: remove the access_ok() check in ioctl_fiemap
      ext4: remove the access_ok() check in ext4_ioctl_get_es_cache

Christophe JAILLET (1):
      ext4: fix a typo in a comment

Eric Biggers (2):
      ext4: fix race between ext4_sync_parent() and rename()
      ext4: add casefold flag to EXT4_INODE_* flags

Eric Whitney (7):
      ext4: remove EXT4_GET_BLOCKS_KEEP_SIZE flag
      ext4: translate a few more map flags to strings in tracepoints
      ext4: remove dead GET_BLOCKS_ZERO code
      ext4: remove redundant GET_BLOCKS_CONVERT code
      ext4: clean up GET_BLOCKS_PRE_IO error handling
      ext4: clean up ext4_ext_convert_to_initialized() error handling
      ext4: rework map struct instantiation in ext4_ext_map_blocks()

Harshad Shirwadkar (3):
      ext4: fix EXT_MAX_EXTENT/INDEX to check for zeroed eh_max
      ext4: handle ext4_mark_inode_dirty errors
      ext4: don't ignore return values from ext4_ext_dirty()

Jan Kara (5):
      writeback: Export inode_io_list_del()
      ext4: Avoid freeing inodes on dirty list
      ext4: drop ext4_journal_free_reserved()
      jbd2: avoid leaking transaction credits when unreserving handle
      ext4: avoid unnecessary transaction starts during writeback

Jason Yan (1):
      ext4: remove unnecessary comparisons to bool

Jeffle Xu (1):
      ext4: fix error pointer dereference

Jens Axboe (1):
      ext4: don't block for O_DIRECT if IOCB_NOWAIT is set

Jonathan Grant (1):
      add comment for ext4_dir_entry_2 file_type member

Kaixu Xia (2):
      ext4: remove unnecessary test_opt for DIOREAD_NOLOCK
      ext4: remove redundant variable has_bigalloc in ext4_fill_super

Ritesh Harjani (21):
      ext4: mballoc: print bb_free info even when it is 0
      ext4: mballoc: refactor ext4_mb_show_ac()
      ext4: mballoc: add more mb_debug() msgs
      ext4: mballoc: correct the mb_debug() format specifier for pa_len var
      ext4: mballoc: fix few other format specifier in mb_debug()
      ext4: mballoc: simplify error handling in ext4_init_mballoc()
      ext4: mballoc: make ext4_mb_use_preallocated() return type as bool
      ext4: mballoc: refactor code inside DOUBLE_CHECK into separate function
      ext4: mballoc: fix possible NULL ptr & remove BUG_ONs from DOUBLE_CHECK
      ext4: balloc: use task_pid_nr() helper
      ext4: use BIT() macro for BH_** state bits
      ext4: improve ext_debug() msg in case of block allocation failure
      ext4: replace EXT_DEBUG with __maybe_unused in ext4_ext_handle_unwritten_extents()
      ext4: mballoc: make mb_debug() implementation to use pr_debug()
      ext4: make ext_debug() implementation to use pr_debug()
      ext4: mballoc: add blocks to PA list under same spinlock after allocating blocks
      ext4: mballoc: refactor ext4_mb_discard_preallocations()
      ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling
      ext4: mballoc: refactor ext4_mb_good_group()
      ext4: mballoc: use lock for checking free blocks while retrying
      ext4: fix EXT4_MAX_LOGICAL_BLOCK macro

Theodore Ts'o (1):
      ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path

Xiyu Yang (1):
      ext4: fix buffer_head refcnt leak when ext4_iget() fails

 Documentation/filesystems/fiemap.txt |  12 +-
 fs/bad_inode.c                       |   1 +
 fs/btrfs/extent_io.h                 |   1 +
 fs/btrfs/inode.c                     |   4 +-
 fs/cifs/inode.c                      |   1 +
 fs/cifs/smb2ops.c                    |   6 +-
 fs/ext2/inode.c                      |   1 +
 fs/ext4/Kconfig                      |   3 +-
 fs/ext4/acl.c                        |   5 +-
 fs/ext4/balloc.c                     |   5 +-
 fs/ext4/ext4.h                       |  42 +++--
 fs/ext4/ext4_extents.h               |   9 +-
 fs/ext4/ext4_jbd2.h                  |  11 +-
 fs/ext4/extents.c                    | 473 ++++++++++++++++++++++++++++++------------------------
 fs/ext4/extents_status.c             |   2 +-
 fs/ext4/file.c                       |  17 +-
 fs/ext4/fsync.c                      |  28 ++--
 fs/ext4/ialloc.c                     |   1 +
 fs/ext4/indirect.c                   |   4 +-
 fs/ext4/inline.c                     |   6 +-
 fs/ext4/inode.c                      | 108 +++++++------
 fs/ext4/ioctl.c                      |  41 +----
 fs/ext4/mballoc.c                    | 512 ++++++++++++++++++++++++++++++++++++++---------------------
 fs/ext4/mballoc.h                    |  16 +-
 fs/ext4/migrate.c                    |  12 +-
 fs/ext4/namei.c                      |  76 +++++----
 fs/ext4/super.c                      |  27 ++--
 fs/ext4/xattr.c                      |  13 +-
 fs/f2fs/data.c                       |   3 +-
 fs/f2fs/inline.c                     |   1 +
 fs/fs-writeback.c                    |   1 +
 fs/gfs2/inode.c                      |   1 +
 fs/hpfs/file.c                       |   1 +
 fs/internal.h                        |   2 -
 fs/ioctl.c                           |  82 ++++------
 fs/iomap/fiemap.c                    |  11 +-
 fs/jbd2/transaction.c                |  14 +-
 fs/nilfs2/inode.c                    |   3 +-
 fs/ocfs2/extent_map.c                |   4 +-
 fs/overlayfs/inode.c                 |   5 +-
 fs/xfs/xfs_iops.c                    |   1 +
 include/linux/fiemap.h               |  25 +++
 include/linux/fs.h                   |  23 +--
 include/linux/iomap.h                |   2 +-
 include/linux/writeback.h            |   1 +
 include/trace/events/ext4.h          |   9 +-
 include/uapi/linux/fiemap.h          |   6 +-
 47 files changed, 938 insertions(+), 694 deletions(-)
 create mode 100644 include/linux/fiemap.h
