Return-Path: <linux-ext4+bounces-3312-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15DF9346B2
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2024 05:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572FF283E2C
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2024 03:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBFB2CCA3;
	Thu, 18 Jul 2024 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KSpxqNvX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374982C1A2
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jul 2024 03:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721273264; cv=none; b=sc3uSw0nKvslOmz5sIhlOVxXBC6/IP+83V/FuiPVHtQvaMb7Dxl9OHu7LdghLB2i2y2zWYsV4B/fcffn4ATI2E8y8oyhsbeot8kJdeSnG16RFsJL2wjxg3uKQFcAO7eZfYE6GX9ujV7pLYVt65/KmFIKAYlZueR6hsl8rsbE0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721273264; c=relaxed/simple;
	bh=H5XOIF/4jtmrO1iXlPAqGrzPUSL0o1pS9D0HWt0swlw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pJYE15rP18llXBLLB7N8VBUG+9UIsOHQIMifDz5y+X49UfCoWoQkeqmFepiuiEpmdoq19OIMxFvloHNwlqp250VdcxW2nfb9Tu681ZKIoaYi62uShRAq3ux2dxsibCSGPukTmT8n3LUyxkuUasw919BKVkOeJ9Ozv50pqo00cl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KSpxqNvX; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-122-46.bstnma.fios.verizon.net [173.48.122.46])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46I3RVYH023482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 23:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1721273252; bh=ocWANOIEbp9YqJa06Xe7z/YMQJ5BPKENdNERF9tx/pw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KSpxqNvX3eWDzx7pJ6VR/aYIpyhulGzcH/HN559VTxrVUJ9yPilugVDBhrkIqJg7z
	 IiOSxJ7Jypf/o2+GyQcynRGV59ERnQ8qc1dqhD5rhn+izGWspCT2u0yat4PtxJp5hF
	 SO6stnvFrsoHSDBRNDy3ADbYMIGg/E64Y+1HZuZqlYD8qzU7cUQhz+CcMB4UyK3lTR
	 YpGBwyLwnN/STgwgbRR0/HO6T/HuYdwQmsic4aro8hq2YKbP5OVTWWovHV2LCs0E5w
	 uwdR94l0dRgak8FI0xLNBe7zEF1XGtc3HRkXtX2QGlBiNrW4C5Mc5PljY2YBNqMRn0
	 Ccn3PILAbvcrA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0112615C029B; Wed, 17 Jul 2024 23:27:30 -0400 (EDT)
Date: Wed, 17 Jul 2024 23:27:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 updates for 6.11-rc1
Message-ID: <20240718032730.GA2319255@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.11-rc1

for you to fetch changes up to f9ca51596bbfd0f9c386dd1c613c394c78d9e5e6:

  ext4: make sure the first directory block is not a hole (2024-07-10 23:25:12 -0400)

----------------------------------------------------------------
Many cleanups and bug fixes in ext4, especially for the fast commit
feature.  Also some performance improvements; in particular, improving
IOPS and throughput on fast devices running Async Direct I/O by up to
20% by optimizing jbd2_transaction_committed().

----------------------------------------------------------------
Baokun Li (2):
      ext4: check dot and dotdot of dx_root before making dir indexed
      ext4: make sure the first directory block is not a hole

Jan Kara (6):
      ext4: avoid writing unitialized memory to disk in EA inodes
      jbd2: make jbd2_journal_get_max_txn_bufs() internal
      jbd2: precompute number of transaction descriptor blocks
      jbd2: avoid infinite transaction commit loop
      jbd2: drop pointless shrinker batch initialization
      jbd2: increase maximum transaction size

Jeff Johnson (2):
      jbd2: add missing MODULE_DESCRIPTION()
      ext4: add missing MODULE_DESCRIPTION()

Kees Cook (1):
      ext4: use memtostr_pad() for s_volume_name

Kemeng Shi (9):
      jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
      jbd2: remove unused return info from jbd2_journal_write_metadata_buffer
      jbd2: remove unnedded "need_copy_out" in jbd2_journal_write_metadata_buffer
      jbd2: jump to new copy_done tag when b_frozen_data is created concurrently
      jbd2: remove unneeded kmap to do escape in jbd2_journal_write_metadata_buffer
      jbd2: use bh_in instead of jh2bh(jh_in) to simplify code
      jbd2: remove dead equality check of j_commit_[sequence/request] in kjournald2
      jbd2: remove dead check of JBD2_UNMOUNT in kjournald2
      jbd2: remove unnecessary "should_sleep" in kjournald2

Li zeming (1):
      ext4: block_validity: Remove unnecessary ‘NULL’ values from new_node

Luis Henriques (SUSE) (4):
      ext4: fix infinite loop when replaying fast_commit
      ext4: use ext4_update_inode_fsync_trans() helper in inode creation
      ext4: fix possible tid_t sequence overflows
      ext4: don't track ranges in fast_commit if inode has inlined data

Thorsten Blum (1):
      jbd2: use str_plural() to fix Coccinelle warning

Wojciech Gładysz (1):
      ext4: sanity check for NULL pointer after ext4_force_shutdown

Xiaxi Shen (1):
      ext4: fix uninitialized variable in ext4_inlinedir_to_tree

Ye Bin (1):
      jbd2: avoid mount failed when commit block is partial submitted

Zhang Yi (11):
      ext4: factor out a common helper to query extent map
      ext4: check the extent status again before inserting delalloc block
      ext4: warn if delalloc counters are not zero on inactive
      ext4: trim delalloc extent
      ext4: drop iblock parameter
      ext4: make ext4_es_insert_delayed_block() insert multi-blocks
      ext4: make ext4_da_reserve_space() reserve multi-clusters
      ext4: factor out a helper to check the cluster allocation state
      ext4: make ext4_insert_delayed_block() insert multi-blocks
      ext4: make ext4_da_map_blocks() buffer_head unaware
      jbd2: speed up jbd2_transaction_committed()

 fs/buffer.c                 |   2 +
 fs/ext4/block_validity.c    |   2 +-
 fs/ext4/ext4.h              |   2 +-
 fs/ext4/extents_status.c    |  72 ++++++++++-----
 fs/ext4/extents_status.h    |   5 +-
 fs/ext4/fast_commit.c       |  14 ++-
 fs/ext4/ialloc.c            |   5 +-
 fs/ext4/inline.c            |   6 +-
 fs/ext4/inode-test.c        |   1 +
 fs/ext4/inode.c             | 255 +++++++++++++++++++++++++++++++++------------------
 fs/ext4/ioctl.c             |   2 +-
 fs/ext4/namei.c             |  73 +++++++++++----
 fs/ext4/super.c             |   6 +-
 fs/ext4/xattr.c             |   6 ++
 fs/jbd2/commit.c            |  14 +--
 fs/jbd2/journal.c           | 124 ++++++++++++++-----------
 fs/jbd2/recovery.c          |  33 ++++++-
 fs/jbd2/transaction.c       |  45 +++------
 include/linux/jbd2.h        |  12 ++-
 include/trace/events/ext4.h |  26 +++---
 20 files changed, 455 insertions(+), 250 deletions(-)

