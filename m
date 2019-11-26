Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47315109E5B
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2019 13:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfKZMxM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Nov 2019 07:53:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37720 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727501AbfKZMxM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Nov 2019 07:53:12 -0500
Received: from callcc.thunk.org (97-71-153.205.biz.bhn.net [97.71.153.205] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAQCr5Xb004532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 07:53:06 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6BE084202FD; Tue, 26 Nov 2019 07:53:04 -0500 (EST)
Date:   Tue, 26 Nov 2019 07:53:04 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 updates for 5.5
Message-ID: <20191126125304.GA20746@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to dfdeeb41fb08fbe11d3cfefba9c0fcd00c95a36d:

  Merge branch 'tt/misc' into dev (2019-11-19 12:25:42 -0500)

----------------------------------------------------------------
This merge window saw the the following new featuers added to ext4:

 * Direct I/O via iomap (required the iomap-for-next branch from Darrick
   as a prereq).
 * Support for using dioread-nolock where the block size < page size.
 * Support for encryption for file systems where the block size < page size.
 * Rework of journal credits handling so a revoke-heavy workload will
   not cause the journal to run out of space.
 * Replace bit-spinlocks with spinlocks in jbd2

Also included were some bug fixes and cleanups, mostly to clean up
corner cases from fuzzed file systems and error path handling.

----------------------------------------------------------------
Chandan Rajendra (1):
      ext4: Enable encryption for subpage-sized blocks

Chengguang Xu (1):
      ext4: code cleanup for get_next_id

Christoph Hellwig (20):
      xfs: initialize iomap->flags in xfs_bmbt_to_iomap
      xfs: set IOMAP_F_NEW more carefully
      xfs: use a struct iomap in xfs_writepage_ctx
      xfs: refactor the ioend merging code
      xfs: turn io_append_trans into an io_private void pointer
      xfs: remove the fork fields in the writepage_ctx and ioend
      iomap: zero newly allocated mapped blocks
      iomap: lift common tracing code from xfs to iomap
      iomap: lift the xfs writeback code to iomap
      iomap: warn on inline maps in iomap_writepage_map
      iomap: move struct iomap_page out of iomap.h
      iomap: cleanup iomap_ioend_compare
      iomap: pass a struct page to iomap_finish_page_writeback
      iomap: better document the IOMAP_F_* flags
      iomap: remove the unused iomap argument to __iomap_write_end
      iomap: always use AOP_FLAG_NOFS in iomap_write_begin
      iomap: ignore non-shared or non-data blocks in xfs_file_dirty
      iomap: move the zeroing case out of iomap_read_page_sync
      iomap: use write_begin to read pages to unshare
      iomap: renumber IOMAP_HOLE to 0

Darrick J. Wong (1):
      iomap: enhance writeback error message

Dave Chinner (1):
      iomap: iomap that extends beyond EOF should be marked dirty

Eric Biggers (1):
      fs/buffer.c: support fscrypt in block_read_full_page()

Gao Xiang (1):
      ext4: bio_alloc with __GFP_DIRECT_RECLAIM never fails

Goldwyn Rodrigues (1):
      iomap: use a srcmap for a read-modify-write I/O

Jan Kara (32):
      iomap: Allow forcing of waiting for running DIO in iomap_dio_rw()
      xfs: Use iomap_dio_rw to wait for unaligned direct IO
      jbd2: Move dropping of jh reference out of un/re-filing functions
      jbd2: Drop unnecessary branch from jbd2_journal_forget()
      jbd2: Don't call __bforget() unnecessarily
      jbd2: Fix possible overflow in jbd2_log_space_left()
      jbd2: Fixup stale comment in commit code
      jbd2: Completely fill journal descriptor blocks
      ext4: Move marking of handle as sync to ext4_add_nondir()
      ext4: Do not iput inode under running transaction
      ext4: Fix credit estimate for final inode freeing
      ext4: Fix ext4_should_journal_data() for EA inodes
      ext4: Use ext4_journal_extend() instead of jbd2_journal_extend()
      ext4: Avoid unnecessary revokes in ext4_alloc_branch()
      ext4: Provide function to handle transaction restarts
      ext4, jbd2: Provide accessor function for handle credits
      ocfs2: Use accessor function for h_buffer_credits
      jbd2: Fix statistics for the number of logged blocks
      jbd2: Reorganize jbd2_journal_stop()
      jbd2: Drop pointless check from jbd2_journal_stop()
      jbd2: Drop pointless wakeup from jbd2_journal_stop()
      jbd2: Factor out common parts of stopping and restarting a handle
      jbd2: Account descriptor blocks into t_outstanding_credits
      jbd2: Drop jbd2_space_needed()
      jbd2: Reserve space for revoke descriptor blocks
      jbd2: Rename h_buffer_credits to h_total_credits
      jbd2: Make credit checking more strict
      ext4: Reserve revoke credits for freed blocks
      jbd2: Provide trace event for handle restarts
      jbd2: Fine tune estimate of necessary descriptor blocks
      ext4: fix leak of quota reservations
      jbd2: make jbd2_handle_buffer_credits() handle reserved handles

Joseph Qi (1):
      fs/iomap: remove redundant check in iomap_dio_rw()

Matthew Bobrowski (11):
      ext4: reorder map.m_flags checks within ext4_iomap_begin()
      ext4: update direct I/O read lock pattern for IOCB_NOWAIT
      ext4: iomap that extends beyond EOF should be marked dirty
      ext4: move set iomap routines into a separate helper ext4_set_iomap()
      ext4: split IOMAP_WRITE branch in ext4_iomap_begin() into helper
      ext4: introduce new callback for IOMAP_REPORT
      ext4: introduce direct I/O read using iomap infrastructure
      ext4: move inode extension/truncate code out from ->iomap_end() callback
      ext4: move inode extension check out from ext4_iomap_alloc()
      ext4: update ext4_sync_file() to not use __generic_file_fsync()
      ext4: introduce direct I/O write using iomap infrastructure

Olof Johansson (1):
      ext4: remove unused variable warning in parse_options()

Ritesh Harjani (6):
      ext4: keep uniform naming convention for io & io_end variables
      ext4: Add API to bring in support for unwritten io_end_vec conversion
      ext4: Refactor mpage_map_and_submit_buffers function
      ext4: Add support for blocksize < pagesize in dioread_nolock
      ext4: Enable blocksize < pagesize for dioread_nolock
      ext4: Add error handling for io_end_vec struct allocation

Theodore Ts'o (7):
      Merge branch 'rh/dioread-nolock-1k' into dev
      Merge branch 'iomap-for-next' into mb/dio
      Merge branch 'jk/jbd2-revoke-overflow'
      Merge branch 'mb/dio' into master
      ext4: add more paranoia checking in ext4_expand_extra_isize handling
      ext4: work around deleting a file with i_nlink == 0 safely
      Merge branch 'tt/misc' into dev

Thomas Gleixner (4):
      jbd2: Simplify journal_unmap_buffer()
      jbd2: Remove jbd_trylock_bh_state()
      jbd2: Make state lock a spinlock
      jbd2: Free journal head outside of locked region

yangerkun (1):
      ext4: fix a bug in ext4_wait_for_tail_page_commit

 Documentation/filesystems/fscrypt.rst |   4 +-
 fs/buffer.c                           |  48 ++-
 fs/dax.c                              |  13 +-
 fs/ext2/inode.c                       |   2 +-
 fs/ext4/ext4.h                        |  22 +-
 fs/ext4/ext4_jbd2.c                   |  32 +-
 fs/ext4/ext4_jbd2.h                   | 106 ++++++-
 fs/ext4/extents.c                     | 149 ++++++----
 fs/ext4/file.c                        | 412 +++++++++++++++++++++-----
 fs/ext4/fsync.c                       |  72 +++--
 fs/ext4/ialloc.c                      |   7 +-
 fs/ext4/indirect.c                    | 125 +++++---
 fs/ext4/inode.c                       | 926 +++++++++++++++++++---------------------------------------
 fs/ext4/migrate.c                     | 103 +++----
 fs/ext4/namei.c                       |  50 ++--
 fs/ext4/page-io.c                     | 167 ++++++-----
 fs/ext4/readpage.c                    |   6 +-
 fs/ext4/resize.c                      |  46 +--
 fs/ext4/super.c                       |  57 +---
 fs/ext4/xattr.c                       |  94 +++---
 fs/gfs2/bmap.c                        |   3 +-
 fs/gfs2/file.c                        |   6 +-
 fs/iomap/Makefile                     |  16 +-
 fs/iomap/apply.c                      |  25 +-
 fs/iomap/buffered-io.c                | 749 +++++++++++++++++++++++++++++++++++++++++------
 fs/iomap/direct-io.c                  |  11 +-
 fs/iomap/fiemap.c                     |   4 +-
 fs/iomap/seek.c                       |   4 +-
 fs/iomap/swapfile.c                   |   3 +-
 fs/iomap/trace.c                      |  12 +
 fs/iomap/trace.h                      |  88 ++++++
 fs/jbd2/checkpoint.c                  |   2 +-
 fs/jbd2/commit.c                      |  26 +-
 fs/jbd2/journal.c                     |  65 ++++-
 fs/jbd2/revoke.c                      |   6 +
 fs/jbd2/transaction.c                 | 400 +++++++++++++------------
 fs/ocfs2/alloc.c                      |  32 +-
 fs/ocfs2/journal.c                    |   8 +-
 fs/ocfs2/suballoc.c                   |  19 +-
 fs/xfs/libxfs/xfs_bmap.c              |  14 +-
 fs/xfs/libxfs/xfs_bmap.h              |   3 +-
 fs/xfs/xfs_aops.c                     | 754 ++++++++---------------------------------------
 fs/xfs/xfs_aops.h                     |  17 --
 fs/xfs/xfs_file.c                     |  13 +-
 fs/xfs/xfs_iomap.c                    |  51 +++-
 fs/xfs/xfs_iomap.h                    |   2 +-
 fs/xfs/xfs_pnfs.c                     |   2 +-
 fs/xfs/xfs_reflink.c                  |   2 +-
 fs/xfs/xfs_super.c                    |  11 +-
 fs/xfs/xfs_trace.h                    |  65 -----
 include/linux/iomap.h                 | 129 +++++---
 include/linux/jbd2.h                  | 118 ++++----
 include/linux/journal-head.h          |  21 +-
 include/trace/events/ext4.h           |  13 +-
 include/trace/events/jbd2.h           |  16 +-
 55 files changed, 2776 insertions(+), 2375 deletions(-)
 create mode 100644 fs/iomap/trace.c
 create mode 100644 fs/iomap/trace.h
