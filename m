Return-Path: <linux-ext4+bounces-6994-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BA7A73719
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 17:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391A43A496F
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D91AA782;
	Thu, 27 Mar 2025 16:40:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D7148857
	for <linux-ext4@vger.kernel.org>; Thu, 27 Mar 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093642; cv=none; b=QmyYtPrF3gTsAd6W8isMiQTgHGX7RwpT2Z0aW2JXPfIEnS9m12ywLglQEl2uagMspvA+GrirBf1crjHhT2yA3WEFfbhrBAxt20+UFh0hC3X3YhCqI9v7tJcp32qaCLkGTRMCYAMjJxRMCCMWh+KaOctcBielXB9I0rxNQt4pT+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093642; c=relaxed/simple;
	bh=p0Vod0x1soEuBq1XMYiCO0+hHhpQoQCTRZ+kCxrh8So=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IiRup+XDJLxEGp5EbBo92nInp0EDpc1z0qfokjFlLTviBiA+AH9UNI3W860lHVtFvXiYT7ZBQob1DGDca9nloHOhLZg09qxQbxIbluCws502iv4Cn5BynXJxhauvZRBBBEbLs/nEziVs9ByfjLoso3DwHUCo8xEyfpuNsuMyYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-195.bstnma.fios.verizon.net [108.26.156.195])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52RGeU9p019258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 12:40:30 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CFCA82E010B; Thu, 27 Mar 2025 12:40:29 -0400 (EDT)
Date: Thu, 27 Mar 2025 12:40:29 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 updates for v6.15-rc1
Message-ID: <20250327164029.GA1423119@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4-for_linus-6.15-rc1

for you to fetch changes up to d5e206778e96e8667d3bde695ad372c296dc9353:

  ext4: fix OOB read when checking dotdot dir (2025-03-21 01:33:11 -0400)

----------------------------------------------------------------
Ext4 bug fixes and cleanups, including:

  * hardening against maliciously fuzzed file systems
  * backwards compatibility for the brief period when we attempted to
     ignore zero-width characters
  * avoid potentially BUG'ing if there is a file system corruption found
    during the file system unmount
  * fix free space reporting by statfs when project quotas are enabled
    and the free space is less than the remaining project quota

Also improve performance when replaying a journal with a very large
number of revoke records (applicable for Lustre volumes).

----------------------------------------------------------------
Acs, Jakub (1):
      ext4: fix OOB read when checking dotdot dir

Baokun Li (18):
      ext4: replace opencoded ext4_end_io_end() in ext4_put_io_end()
      ext4: do not convert the unwritten extents if data writeback fails
      ext4: reject the 'data_err=abort' option in nojournal mode
      ext4: extract ext4_has_journal_option() from __ext4_fill_super()
      ext4: abort journal on data writeback failure if in data_err=abort mode
      jbd2: drop JBD2_ABORT_ON_SYNCDATA_ERR
      ext4: update the descriptions of data_err=abort and data_err=ignore
      ext4: remove unused member 'i_unwritten' from 'ext4_inode_info'
      ext4: pack holes in ext4_inode_info
      ext4: convert EXT4_FLAGS_* defines to enum
      ext4: add EXT4_FLAGS_EMERGENCY_RO bit
      ext4: add ext4_emergency_state() helper function
      ext4: add more ext4_emergency_state() checks around sb_rdonly()
      ext4: correct behavior under errors=remount-ro mode
      ext4: show 'emergency_ro' when EXT4_FLAGS_EMERGENCY_RO is set
      ext4: show 'shutdown' hint when ext4 is forced to shutdown
      ext4: goto right label 'out_mmap_sem' in ext4_setattr()
      jbd2: remove jbd2_journal_unfile_buffer()

Bhupesh (1):
      ext4: ignore xattrs past end

Charles Han (1):
      ext4: fix potential null dereference in ext4 kunit test

Christian Göttsche (1):
      ext4: reorder capability check last

Diangang Li (1):
      ext4: clear DISCARD flag if device does not support discard

Eric Biggers (2):
      ext4: remove redundant function ext4_has_metadata_csum
      jbd2: remove redundant function jbd2_journal_has_csum_v2or3_feature

Ethan Carter Edwards (1):
      ext4: hash: simplify kzalloc(n * 1, ...) to kzalloc(n, ...)

Jan Kara (4):
      jbd2: Avoid long replay times due to high number or revoke blocks
      ext4: verify fast symlink length
      jbd2: remove wrong sb->s_sequence check
      jbd2: do not try to recover wiped journal

Julian Sun (5):
      ext4: Remove a redundant return statement
      ext4: Don't set EXT4_STATE_MAY_INLINE_DATA for ea inodes
      ext4: Introduce a new helper function ext4_generic_write_inline_data()
      ext4: Replace ext4_da_write_inline_data_begin() with ext4_generic_write_inline_data().
      ext4: Refactor out ext4_try_to_write_inline_data()

Kemeng Shi (12):
      ext4: remove unused ext4 journal callback
      jbd2: remove unused transaction->t_private_list
      ext4: remove unneeded forward declaration
      jbd2: remove unused h_jdata flag of handle
      jbd2: remove unused return value of jbd2_journal_cancel_revoke
      jbd2: remove unused return value of do_readahead
      jbd2: remove stale comment of update_t_max_wait
      jbd2: correct stale function name in comment
      jbd2: Correct stale comment of release_buffer_page
      ext4: add missing brelse() for bh2 in ext4_dx_add_entry()
      ext4: remove unneeded forward declaration in namei.c
      ext4: remove unused input "inode" in ext4_find_dest_de

Matthew Wilcox (Oracle) (1):
      ext4: remove references to bh->b_page

Nicolas Bretz (1):
      ext4: on a remount, only log the ro or r/w state when it has changed

Ojaswin Mujoo (4):
      ext4: protect ext4_release_dquot against freezing
      ext4: define ext4_journal_destroy wrapper
      ext4: avoid journaling sb update on error if journal is destroying
      ext4: Make sb update interval tunable

Theodore Ts'o (2):
      ext4: introduce linear search for dentries
      ext4: don't over-report free space or inodes in statvfs

Ye Bin (2):
      ext4: introduce ITAIL helper
      ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

Zhang Yi (13):
      ext4: remove writable userspace mappings before truncating page cache
      ext4: don't explicit update times in ext4_fallocate()
      ext4: don't write back data before punch hole in nojournal mode
      ext4: refactor ext4_punch_hole()
      ext4: refactor ext4_zero_range()
      ext4: refactor ext4_collapse_range()
      ext4: refactor ext4_insert_range()
      ext4: factor out ext4_do_fallocate()
      ext4: move out inode_lock into ext4_fallocate()
      ext4: move out common parts into ext4_fallocate()
      jbd2: fix off-by-one while erasing journal
      jbd2: add a missing data flush during file and fs synchronization
      ext4: correct the error handle in ext4_fallocate()

Zizhi Wo (1):
      ext4: update the comment about mb_optimize_scan

 Documentation/admin-guide/ext4.rst        |   7 +-
 Documentation/filesystems/journalling.rst |   4 +-
 fs/ext4/balloc.c                          |   4 +-
 fs/ext4/bitmap.c                          |   8 +-
 fs/ext4/dir.c                             |   7 +-
 fs/ext4/ext4.h                            |  94 ++++----
 fs/ext4/ext4_jbd2.c                       |  12 +-
 fs/ext4/ext4_jbd2.h                       | 113 +++------
 fs/ext4/extents.c                         | 531 ++++++++++++++++---------------------------
 fs/ext4/extents_status.c                  |   1 -
 fs/ext4/file.c                            |  27 ++-
 fs/ext4/fsync.c                           |  12 +-
 fs/ext4/hash.c                            |   2 +-
 fs/ext4/ialloc.c                          |   9 +-
 fs/ext4/inline.c                          | 205 ++++++-----------
 fs/ext4/inode.c                           | 288 +++++++++++++----------
 fs/ext4/ioctl.c                           |  13 +-
 fs/ext4/mballoc-test.c                    |   2 +
 fs/ext4/mballoc.c                         |   8 +-
 fs/ext4/mmp.c                             |   6 +-
 fs/ext4/namei.c                           | 117 +++++-----
 fs/ext4/orphan.c                          |   2 +-
 fs/ext4/page-io.c                         |  75 ++++--
 fs/ext4/resize.c                          |   4 +-
 fs/ext4/super.c                           | 267 ++++++++++++----------
 fs/ext4/sysfs.c                           |   4 +
 fs/ext4/xattr.c                           |  47 ++--
 fs/ext4/xattr.h                           |  10 +
 fs/jbd2/commit.c                          |  10 +-
 fs/jbd2/journal.c                         |  34 +--
 fs/jbd2/recovery.c                        |  80 +++++--
 fs/jbd2/revoke.c                          |  21 +-
 fs/jbd2/transaction.c                     |  21 +-
 include/linux/fs.h                        |  10 +-
 include/linux/jbd2.h                      |  24 +-
 35 files changed, 967 insertions(+), 1112 deletions(-)

