Return-Path: <linux-ext4+bounces-12132-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22674C9DBF4
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 05:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906C73A84F4
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 04:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239B1E832A;
	Wed,  3 Dec 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PrrKzw7K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7F27732
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764736356; cv=none; b=pmdiC70Wr7Cul+muuLcUrLXTWMEu2Vk3uZW0s2/c3zkhOCm6mhBIdFkktVy2RA4m5adPQnOVZVzcTebm6dhrSShm7KmYbsc+EimJaa66LPADDIrzLGAi98hsFKNzGsipTOPkA6lqtQ5lrTVn5DrXqbPbrSdPfizTwjS8+WdfyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764736356; c=relaxed/simple;
	bh=txidUmZVnION0YDh8T5e8WTVBqtHZ0bBxg+DRgN4D8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TrXD3TC/n6Tjf1fX2nigkyiyNVtu0hqLs6RQ2qAlCYG43jsU3xVxDd1doTFwfhmgkxPgTHctQKMbwQMdrghFet8EpyS1IMpw8jOX7ohMG+t/SJd1kDEYFH7xqNgQecz6+EerW+gSJIU7oqiT3NEjhXGXHZXkYRDj8kpkNzqtow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PrrKzw7K; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-12.bstnma.fios.verizon.net [173.48.102.12])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B34WSq3026385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Dec 2025 23:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764736350; bh=4SW2LXTp/plZp45CkPinIHGm314GmfhMsKjhzXjON5s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PrrKzw7KJPmYMvcJFUawDGLgM7lXXfSl6LH4DSRP2UpYLgAw2eW7qzTXAIontGZxs
	 MVNMspKtakgXESBPk74VzsMphuezXnW5UsYi80HvN54dfj+rXIcj4bFAr30qv49rSX
	 D3LLW3z4GNuDH8FG/YeYtPYLE6JJEY3omFheUzmiNc2bohRd8coH23w98wUOzj0LKD
	 vrRx6nNWQWHZUY51TBVyI5Q0+4uws3vrHxOGaTH2aLHdNz7cOg/8fFTkDT5+6AOD55
	 C5DC12JC+pqAyglUsQDTbClh5RVWaepz0Ab12JG9RDfya5yJyM3+xk18ysXezaNmZO
	 P6iSjnwoNgOaQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 966492E00D9; Tue, 02 Dec 2025 23:32:28 -0500 (EST)
Date: Tue, 2 Dec 2025 23:32:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 changes for 6.19-rc1
Message-ID: <20251203043228.GA1712448@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.19-rc1

for you to fetch changes up to 91ef18b567dae84c0cea9b996d933c856e366f52:

  ext4: mark inodes without acls in __ext4_iget() (2025-11-28 22:35:28 -0500)

----------------------------------------------------------------
New features and improvements for the ext4 file system

* Optimize online defragmentation by using folios instead of individual
  buffer heads
* Improve error codes stored in the superblock when the journal aborts
* Minor cleanups and clarifications in ext4_map_blocks()
* Add documentation of the casefold and encrypt flags
* Add support for file systems with a blocksize greater than the pagesize
* Improve performance by enabling the caching the fact that an inode does
  not have a Posix ACL.

Various Bug Fixes

* Fix false positive compliants from smatch
* Fix error code which is returned by ext4fs_dirhash() when Siphash is
  used without the encryption key
* Fix races when writing to inline data files which could trigger a BUG
* Fix potential NULL dereference when there is an corrupt file system with
  an extended attribute value stored in a inode
* Fix false positive lockdep report when syzbot uses ext4 and ocfs2 together
* Fix false positive reported by DEPT by adjusting lock annotation
* Avoid a potential BUG_ON in jbd2 when a file system is massively corrupted
* Fix a WARN_ON when superblock is corrupted with a non-NULL terminated
  mount options field
* Add check if the userspace passes in a non-NULL terminated mount options
  field to EXT4_IOC_SET_TUNE_SB_PARAM
* Fix a potential journal checksum failure whena file system is copied while
  it is mounted read-only
* Fix a potential potential orphan file tracking error which only showed
  on 32-bit systems
* Fix assertion checks in mballoc (which have to be explicitly enbled by
  manually enabling AGGRESSIVE_CHECKS and recompiling)
* Avoid complaining about overly large orphan files created by mke2fs with
  with file systems with a 64k block size

----------------------------------------------------------------
Alexey Nepomnyashih (1):
      ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()

Baokun Li (22):
      ext4: align max orphan file size with e2fsprogs limit
      ext4: remove page offset calculation in ext4_block_truncate_page()
      ext4: remove PAGE_SIZE checks for rec_len conversion
      ext4: make ext4_punch_hole() support large block size
      ext4: enable DIOREAD_NOLOCK by default for BS > PS as well
      ext4: introduce s_min_folio_order for future BS > PS support
      ext4: support large block size in ext4_calculate_overhead()
      ext4: support large block size in ext4_readdir()
      ext4: add EXT4_LBLK_TO_B macro for logical block to bytes conversion
      ext4: add EXT4_LBLK_TO_PG and EXT4_PG_TO_LBLK for block/page conversion
      ext4: support large block size in ext4_mb_load_buddy_gfp()
      ext4: support large block size in ext4_mb_get_buddy_page_lock()
      ext4: support large block size in ext4_mb_init_cache()
      ext4: prepare buddy cache inode for BS > PS with large folios
      ext4: support large block size in ext4_mpage_readpages()
      ext4: support large block size in ext4_block_write_begin()
      ext4: support large block size in mpage_map_and_submit_buffers()
      ext4: support large block size in mpage_prepare_extent_to_map()
      ext4: make data=journal support large block size
      ext4: support verifying data from large folios with fs-verity
      ext4: add checks for large folio incompatibilities when BS > PS
      ext4: enable block size larger than page size

Byungchul Park (1):
      jbd2: use a weaker annotation in journal handling

Daniel Tang (1):
      Documentation: ext4: Document casefold and encrypt flags

Deepanshu Kartikey (1):
      ext4: refresh inline data size before write operations

Fedor Pchelkin (2):
      ext4: fix string copying in parse_apply_sb_mount_options()
      ext4: check if mount_opts is NUL-terminated in ext4_ioctl_set_tune_sb()

Haibo Chen (1):
      ext4: clear i_state_flags when alloc inode

Haodong Tian (1):
      fs/ext4: fix typo in comment

Jan Kara (1):
      ext4: mark inodes without acls in __ext4_iget()

Julian Sun (1):
      ext4: make error code in __ext4fs_dirhash() consistent.

Karina Yankevich (1):
      ext4: xattr: fix null pointer deref in ext4_raw_inode()

Ranganath V N (1):
      fs: ext4: fix uninitialized symbols

Tetsuo Handa (1):
      jbd2: use a per-journal lock_class_key for jbd2_trans_commit_key

Wengang Wang (1):
      jbd2: store more accurate errno in superblock when possible

Yang Erkun (3):
      ext4: rename EXT4_GET_BLOCKS_PRE_IO
      ext4: cleanup for ext4_map_blocks
      ext4: correct the comments place for EXT4_EXT_MAY_ZEROOUT

Ye Bin (2):
      jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted
      jbd2: fix the inconsistency between checksum and data in memory for journal sb

Yongjian Sun (2):
      ext4: fix incorrect group number assertion in mb_check_buddy
      ext4: improve integrity checking in __mb_check_buddy by enhancing order-0 validation

Zhang Yi (12):
      ext4: correct the checking of quota files before moving extents
      ext4: introduce seq counter for the extent status entry
      ext4: make ext4_es_lookup_extent() pass out the extent seq counter
      ext4: pass out extent seq counter when mapping blocks
      ext4: use EXT4_B_TO_LBLK() in mext_check_arguments()
      ext4: add mext_check_validity() to do basic check
      ext4: refactor mext_check_arguments()
      ext4: rename mext_page_mkuptodate() to mext_folio_mkuptodate()
      ext4: introduce mext_move_extent()
      ext4: switch to using the new extent movement method
      ext4: add large folios support for moving extents
      ext4: add two trace points for moving extents

Zhihao Cheng (3):
      ext4: remove page offset calculation in ext4_block_zero_page_range()
      ext4: rename 'page' references to 'folio' in multi-block allocator
      ext4: support large block size in __ext4_block_zero_page_range()

 Documentation/filesystems/ext4/inodes.rst |   2 +
 Documentation/filesystems/ext4/super.rst  |   4 +-
 fs/ext4/balloc.c                          |   2 +-
 fs/ext4/dir.c                             |   8 +-
 fs/ext4/ext4.h                            |  50 +--
 fs/ext4/ext4_jbd2.c                       |   3 +-
 fs/ext4/extents.c                         |  28 +-
 fs/ext4/extents_status.c                  |  31 +-
 fs/ext4/extents_status.h                  |   2 +-
 fs/ext4/hash.c                            |   2 +-
 fs/ext4/ialloc.c                          |   1 -
 fs/ext4/inline.c                          |  14 +-
 fs/ext4/inode.c                           | 165 +++++-----
 fs/ext4/ioctl.c                           |  14 +-
 fs/ext4/mballoc.c                         | 188 ++++++-----
 fs/ext4/move_extent.c                     | 786 +++++++++++++++++++++-----------------------
 fs/ext4/namei.c                           |  18 +-
 fs/ext4/orphan.c                          |   4 +-
 fs/ext4/readpage.c                        |   7 +-
 fs/ext4/super.c                           |  72 +++-
 fs/ext4/sysfs.c                           |   6 +
 fs/ext4/verity.c                          |   2 +-
 fs/ext4/xattr.c                           |   6 +-
 fs/jbd2/checkpoint.c                      |   2 +-
 fs/jbd2/journal.c                         |  35 +-
 fs/jbd2/transaction.c                     |  26 +-
 include/linux/jbd2.h                      |   6 +
 include/trace/events/ext4.h               |  99 +++++-
 28 files changed, 872 insertions(+), 711 deletions(-)

