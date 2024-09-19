Return-Path: <linux-ext4+bounces-4224-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB697C963
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 14:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6062F284707
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D319E7F5;
	Thu, 19 Sep 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UN+edTHs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870C19DFAE
	for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2024 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749669; cv=none; b=G4smoOPcPRTe3BSwNogfvUpI+9d4TvZPNBGJpdGqrlKdhiGdJ9ADBrYvZZiJ1Z2aAdH6ebCOLh8yntvFXPzoJpO/z3uBVu0YZQfdVS6gekb6nGu8lIF1tYnbN8B5tZlaJTsGJwDJ1ImnN6z4k+aLcPF6c/B2ocd+k+wHzvUxzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749669; c=relaxed/simple;
	bh=x26iYqBoeoZf8GKGmKK3+WLcXQWjkUBKu7A6oBF4hu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MDLKo1TEe2jPYAkUMV0cvrQtmh/LlEMSUJB4798s9gIUoo4yUJuHcwZmir1IfY8Qq2o/oCSKOCVUHyKPpOm68DQ83ccNjsKcnERzPaZw2BHmnIaOH9tXp0cnBwwCwvtOpyhxwZXRn3fts2lFSZB9VvWz10XpLphIoaIul8cPbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UN+edTHs; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-20-194-30.bstnma.fios.verizon.net [108.20.194.30])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 48JCcmC7000891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 08:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1726749530; bh=1oP8nBXnEOv4H0tLtXyba23RZUsaGaX4QZKks4tzHpE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=UN+edTHslSn7V3FXh5V2nJD6dCOR5Og8+8ngJXunwZwqIsHzeEQwSn3C3wSfKyslj
	 ifFLjeVtLlHkPaZqXezqcIsceWiT5ceblZFA5l0IS1PPE6SGG6Hldn10i4W9NQ7zMw
	 WyXFUQOkTAszJYYeA4ygUNd9mOfKUGjeyc7a87oQyy3why6c3eK/c12hj65qGIJcj1
	 AOIWWfHw/8DUL801/DqBo0qGRZKn4rq7CJpBLRkDLfEpUEY8/ANqhsfDb02sKjK0oG
	 TmDVJ+mclyX2sHCQE1+RUro/NYiLQn8q35XDzE7IDAzYZZV/79MH2458Q6zvfkImL/
	 be0oDgHJAM0gQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1F61A15C19A9; Thu, 19 Sep 2024 08:38:48 -0400 (EDT)
Date: Thu, 19 Sep 2024 08:38:48 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 updates for 6.12-rc1
Message-ID: <20240919123848.GA1969831@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.12-rc1

for you to fetch changes up to ff2beee206d23f49d022650122f81285849033e4:

  ext4: convert EXT4_B2C(sbi->s_stripe) users to EXT4_NUM_B2C (2024-09-03 22:14:17 -0400)

NOTE: git will report a merge conflict involving write_begin calls,
   but just taking the version from the ext4 branch should just work.
   See the test branch on the ext4.git branch for the test merge that I
   did my last round of regression tests before sending this pull request.

----------------------------------------------------------------
Lots of cleanups and bug fixes this cycle, primarily in the block
allocation, extent management, fast commit, and journalling.

----------------------------------------------------------------
Artem Sadovnikov (1):
      ext4: fix i_data_sem unlock order in ext4_ind_migrate()

Baokun Li (26):
      jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error
      ext4: refactor ext4_ext_rm_idx() to index 'path'
      ext4: prevent partial update of the extents path
      ext4: fix slab-use-after-free in ext4_split_extent_at()
      ext4: avoid use-after-free in ext4_ext_show_leaf()
      ext4: update orig_path in ext4_find_extent()
      ext4: aovid use-after-free in ext4_ext_insert_extent()
      ext4: drop ppath from ext4_ext_replay_update_ex() to avoid double-free
      ext4: fix double brelse() the buffer of the extents path
      ext4: add new ext4_ext_path_brelse() helper
      ext4: propagate errors from ext4_find_extent() in ext4_insert_range()
      ext4: get rid of ppath in ext4_find_extent()
      ext4: get rid of ppath in get_ext_path()
      ext4: get rid of ppath in ext4_ext_create_new_leaf()
      ext4: get rid of ppath in ext4_ext_insert_extent()
      ext4: get rid of ppath in ext4_split_extent_at()
      ext4: get rid of ppath in ext4_force_split_extent_at()
      ext4: get rid of ppath in ext4_split_extent()
      ext4: get rid of ppath in ext4_split_convert_extents()
      ext4: get rid of ppath in ext4_convert_unwritten_extents_endio()
      ext4: get rid of ppath in ext4_ext_convert_to_initialized()
      ext4: get rid of ppath in ext4_ext_handle_unwritten_extents()
      ext4: get rid of ppath in convert_initialized_extent()
      ext4: refactor ext4_swap_extents() to reuse extents path
      ext4: make some fast commit functions reuse extents path
      ext4: save unnecessary indentation in ext4_ext_create_new_leaf()

Edward Adam Davis (1):
      ext4: no need to continue when the number of entries is 1

Gabriel Krisman Bertazi (1):
      ext4: fix error message when rejecting the default hash

Jan Kara (1):
      ext4: don't set SB_RDONLY after filesystem errors

Junchao Sun (1):
      ext4: adjust the layout of the ext4_inode_info structure to save memory

Kemeng Shi (18):
      ext4: correct comment of ext4_xattr_cmp
      ext4: correct comment of ext4_xattr_block_cache_insert
      ext4: correct comment of h_checksum
      jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit
      jbd2: remove dead check in journal_alloc_journal_head
      jbd2: remove unused return value of jbd2_fc_release_bufs
      jbd2: remove unneeded kmap for jh_in->b_frozen_data in jbd2_journal_write_metadata_buffer
      jbd2: remove unneeded done_copy_out variable in jbd2_journal_write_metadata_buffer
      jbd2: move escape handle to futher improve jbd2_journal_write_metadata_buffer
      jbd2: correct comment jbd2_mark_journal_empty
      jbd2: remove unneeded check of ret in jbd2_fc_get_buf
      ext4: avoid buffer_head leak in ext4_mark_inode_used()
      ext4: avoid potential buffer_head leak in __ext4_new_inode()
      ext4: avoid negative min_clusters in find_group_orlov()
      ext4: remove dead check in __ext4_new_inode()
      ext4: move checksum length calculation of inode bitmap into ext4_inode_bitmap_csum_[verify/set]() functions
      ext4: remove unneeded NULL check of buffer_head in ext4_mark_inode_used()
      ext4: check buffer_verified in advance to avoid unneeded ext4_get_group_info()

Lizhi Xu (1):
      ext4: filesystems without casefold feature cannot be mounted with siphash

Luis Henriques (SUSE) (6):
      ext4: fix fast commit inode enqueueing during a full journal commit
      ext4: fix access to uninitialised lock in fc replay path
      ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()
      ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
      ext4: fix incorrect tid assumption in jbd2_journal_shrink_checkpoint_list()
      ext4: fix incorrect tid assumption in ext4_fc_mark_ineligible()

Markus Elfring (1):
      ext4: use seq_putc() in two functions

Matthew Wilcox (Oracle) (4):
      ext4: reduce stack usage in ext4_mpage_readpages()
      ext4: pipeline buffer reads in mext_page_mkuptodate()
      ext4: remove array of buffer_heads from mext_page_mkuptodate()
      ext4: tidy the BH loop in mext_page_mkuptodate()

Ojaswin Mujoo (2):
      ext4: check stripe size compatibility on remount as well
      ext4: convert EXT4_B2C(sbi->s_stripe) users to EXT4_NUM_B2C

Randy Dunlap (1):
      jbd2: fix kernel-doc for j_transaction_overhead_buffers

Shida Zhang (4):
      ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers
      ext4: hoist ext4_block_write_begin and replace the __block_write_begin
      ext4: fix a potential assertion failure due to improperly dirtied buffer
      ext4: remove the special buffer dirty handling in do_journal_get_write_access

Stefan Tauner (1):
      Documentation: ext4.rst: remove obsolete descriptions of noacl/nouser_xattr options

Thadeu Lima de Souza Cascardo (4):
      ext4: ext4_search_dir should return a proper error
      ext4: return error on ext4_find_inline_entry
      ext4: explicitly exit when ext4_find_inline_entry returns an error
      ext4: avoid OOB when system.data xattr changes underneath the filesystem

Thorsten Blum (1):
      ext4: annotate struct ext4_xattr_inode_array with __counted_by()

Wojciech Gładysz (1):
      ext4: nested locking for xattr inode

Xiaxi Shen (1):
      ext4: fix timer use-after-free on failed mount

Zhang Yi (12):
      ext4: factor out ext4_map_create_blocks() to allocate new blocks
      ext4: optimize the EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set
      ext4: don't set EXTENT_STATUS_DELAYED on allocated blocks
      ext4: let __revise_pending() return newly inserted pendings
      ext4: passing block allocation information to ext4_es_insert_extent()
      ext4: update delalloc data reserve spcae in ext4_es_insert_extent()
      ext4: drop ext4_es_delayed_clu()
      ext4: use ext4_map_query_blocks() in ext4_map_blocks()
      ext4: drop unused ext4_es_store_status()
      ext4: make extent status types exclusive
      ext4: drop ext4_es_is_delonly()
      ext4: drop all delonly descriptions

Zhihao Cheng (1):
      ext4: dax: fix overflowing extents beyond inode size when partially writing

carrion bent (1):
      ext4: fix macro definition error of EXT4_DIRENT_HASH and EXT4_DIRENT_MINOR_HASH

yangerkun (2):
      ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard
      ext4: dax: keep orphan list before truncate overflow allocated blocks

yao.ly (1):
      ext4: correct encrypted dentry name hash when not casefolded

 Documentation/admin-guide/ext4.rst |  10 -
 fs/ext4/bitmap.c                   |   8 +-
 fs/ext4/dir.c                      |  14 +-
 fs/ext4/ext4.h                     |  31 +-
 fs/ext4/extents.c                  | 823 ++++++++++++++++++-----------------
 fs/ext4/extents_status.c           | 240 ++++------
 fs/ext4/extents_status.h           |  28 +-
 fs/ext4/fast_commit.c              |  47 +-
 fs/ext4/file.c                     |  20 +-
 fs/ext4/ialloc.c                   |  35 +-
 fs/ext4/indirect.c                 |   7 -
 fs/ext4/inline.c                   |  46 +-
 fs/ext4/inode.c                    | 292 ++++++-------
 fs/ext4/mballoc.c                  |  25 +-
 fs/ext4/migrate.c                  |   7 +-
 fs/ext4/move_extent.c              |  90 ++--
 fs/ext4/namei.c                    |  16 +-
 fs/ext4/readpage.c                 |  16 +-
 fs/ext4/resize.c                   |   3 +-
 fs/ext4/super.c                    |  65 ++-
 fs/ext4/xattr.c                    |  31 +-
 fs/ext4/xattr.h                    |   7 +-
 fs/jbd2/checkpoint.c               |  21 +-
 fs/jbd2/journal.c                  |  97 ++---
 include/linux/jbd2.h               |   4 +-
 25 files changed, 989 insertions(+), 994 deletions(-)

