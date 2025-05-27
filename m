Return-Path: <linux-ext4+bounces-8206-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D208FAC5B2B
	for <lists+linux-ext4@lfdr.de>; Tue, 27 May 2025 22:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3031BA7698
	for <lists+linux-ext4@lfdr.de>; Tue, 27 May 2025 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ED51F463F;
	Tue, 27 May 2025 20:02:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35231DE4F6
	for <linux-ext4@vger.kernel.org>; Tue, 27 May 2025 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376140; cv=none; b=jqabrc7ZWNZ5z+aV0a5K0EW9366+QCVI8xYrldzA0wxCWE07VYp1Sccdgt7qzRdiiV8duR7ox8rumcufgQY4OliztahtDfEURwwelRN//S6cWNRBj7R5w1iYNcg/1YxQtCrkZEiTu2B48iffyCT6eycHLT6wBNnbC/U5dZiqay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376140; c=relaxed/simple;
	bh=1c1UK76FZs7bbUsEiX7pLhBXdXdmxSY7U+L/bMoCjFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jAWGiplUOa+IL7nJhisBLmvW8XadNO73/4GfFEzUbEnIg7KoPpRY3gShqnhndxziJeF/YB37lOFRKDYYU3Dl8+O0iKXr9jj5PpVJBiVkw9K+sPO/ST9RTtT2EY3bg0KGxWmoD2LWo0e5/9SrqWxxllERsd3rYyArYsUaIK9W5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54RK26q5026851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 16:02:06 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 237DC2E00DD; Tue, 27 May 2025 16:02:06 -0400 (EDT)
Date: Tue, 27 May 2025 16:02:06 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 changes for v6.16-rc1
Message-ID: <20250527200206.GA2433735@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.16-rc1

for you to fetch changes up to 7acd1b315cdcc03b11a3aa1f9c9c85d99ddb4f0e:

  ext4: Add a WARN_ON_ONCE for querying LAST_IN_LEAF instead (2025-05-20 14:21:00 -0400)

----------------------------------------------------------------
New ext4 features and performance improvements:
   * Fast commit performance improvements
   * Multi-fsblock atomic write support for bigalloc file systems
   * Large folio support for regular files

This last can result in really stupendous performance for the right
workloads.  For example, see [1] where the Kernel Test Robot reported
over 37% improvement on a large sequential I/O workload.

[1] https://lore.kernel.org/all/202505161418.ec0d753f-lkp@intel.com/

There are also the usual bug fixes and cleanups.  Of note are cleanups
of the extent status tree to fix potential races that could result in
the extent status tree getting corrupted under heavy siulatneous
allocation and deallocation to a single file.

----------------------------------------------------------------
Arnd Bergmann (1):
      ext4: avoid -Wformat-security warning

Brian Foster (1):
      ext4: only dirty folios when data journaling regular files

Christoph Hellwig (1):
      ext4: use writeback_iter in ext4_journalled_submit_inode_data_buffers

Eric Biggers (4):
      ext4: remove sbi argument from ext4_chksum()
      ext4: remove sb argument from ext4_superblock_csum()
      jbd2: remove journal_t argument from jbd2_chksum()
      jbd2: remove journal_t argument from jbd2_superblock_csum()

Harshad Shirwadkar (9):
      ext4: convert i_fc_lock to spinlock
      ext4: for committing inode, make ext4_fc_track_inode wait
      ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
      ext4: rework fast commit commit path
      ext4: drop i_fc_updates from inode fc info
      ext4: update code documentation
      ext4: temporarily elevate commit thread priority
      ext4: convert s_fc_lock to mutex type
      ext4: hold s_fc_lock while during fast commit

Jan Kara (1):
      ext4: fix calculation of credits for extent tree modification

Jeongjun Park (1):
      jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()

Ritesh Harjani (IBM) (12):
      ext4: Document an edge case for overwrites
      ext4: Check if inode uses extents in ext4_inode_can_atomic_write()
      ext4: Make ext4_meta_trans_blocks() non-static for later use
      ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
      ext4: Add multi-fsblock atomic write support with bigalloc
      ext4: Enable support for ext4 multi-fsblock atomic write using bigalloc
      ext4: Add atomic block write documentation
      ext4: Unwritten to written conversion requires EXT4_EX_NOCACHE
      ext4: Simplify last in leaf check in ext4_map_query_blocks
      ext4: Rename and document EXT4_EX_FILTER to EXT4_EX_QUERY_FILTER
      ext4: Simplify flags in ext4_map_query_blocks()
      ext4: Add a WARN_ON_ONCE for querying LAST_IN_LEAF instead

Thadeu Lima de Souza Cascardo (1):
      ext4: inline: fix len overflow in ext4_prepare_inline_data

Zhang Yi (21):
      ext4: ext4: unify EXT4_EX_NOCACHE|NOFAIL flags in ext4_ext_remove_space()
      ext4: generalize EXT4_GET_BLOCKS_IO_SUBMIT flag usage
      ext4: prevent stale extent cache entries caused by concurrent I/O writeback
      ext4: prevent stale extent cache entries caused by concurrent fiemap
      ext4: prevent stale extent cache entries caused by concurrent get es_cache
      ext4: factor out is_special_ino()
      ext4: introduce ext4_check_map_extents_env() debug helper
      ext4: check env when mapping and modifying extents
      ext4: clairfy the rules for modifying extents
      ext4: fix out of bounds punch offset
      ext4: fix incorrect punch max_end
      ext4: factor out ext4_get_maxbytes()
      ext4: ensure i_size is smaller than maxbytes
      ext4: make ext4_mpage_readpages() support large folios
      ext4: make regular file's buffered write path support large folios
      ext4: make __ext4_block_zero_page_range() support large folio
      ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large folio
      ext4: correct the journal credits calculations of allocating blocks
      ext4: make the writeback path support large folios
      ext4: make online defragmentation support large folios
      ext4: enable large folio for regular file

 Documentation/filesystems/ext4/atomic_writes.rst | 225 ++++++++
 Documentation/filesystems/ext4/overview.rst      |   1 +
 fs/ext4/bitmap.c                                 |   8 +-
 fs/ext4/ext4.h                                   |  91 +++-
 fs/ext4/ext4_jbd2.c                              |   3 +-
 fs/ext4/ext4_jbd2.h                              |   4 +-
 fs/ext4/extents.c                                | 177 +++++--
 fs/ext4/extents_status.c                         |  35 +-
 fs/ext4/fast_commit.c                            | 460 +++++++++--------
 fs/ext4/file.c                                   |  14 +-
 fs/ext4/ialloc.c                                 |   8 +-
 fs/ext4/inline.c                                 |   3 +-
 fs/ext4/inode.c                                  | 510 ++++++++++++++++---
 fs/ext4/ioctl.c                                  |  16 +-
 fs/ext4/mmp.c                                    |   2 +-
 fs/ext4/move_extent.c                            |  11 +-
 fs/ext4/namei.c                                  |  10 +-
 fs/ext4/orphan.c                                 |  13 +-
 fs/ext4/readpage.c                               |  28 +-
 fs/ext4/resize.c                                 |   2 +-
 fs/ext4/super.c                                  |  84 ++-
 fs/ext4/xattr.c                                  |  10 +-
 fs/jbd2/commit.c                                 |   6 +-
 fs/jbd2/journal.c                                |  23 +-
 fs/jbd2/recovery.c                               |  10 +-
 fs/jbd2/transaction.c                            |   5 +-
 include/linux/jbd2.h                             |   5 +-
 27 files changed, 1290 insertions(+), 474 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst

