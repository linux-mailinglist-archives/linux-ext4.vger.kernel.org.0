Return-Path: <linux-ext4+bounces-768-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B366D82A258
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 21:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D6282E77
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 20:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87C4A9B7;
	Wed, 10 Jan 2024 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YrNfFGAB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A817F4CB59
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-122-95.bstnma.fios.verizon.net [173.48.122.95])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40AKZMog029537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 15:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704918923; bh=SqyRMsD2cszlTcwc/TTdt/La2IAXu409uLfnFzuW7zU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YrNfFGABG7FZC4gfJ0E9bwy6DYuf/yO5fg2fc5iuLLi3DwXATtB3bdH24dUfiHHpP
	 E4mI70OXwMsXU4gekfzs3LVmbuBSjgkdb1vw27Ab1TqvGRmQurvIiz2IIstPdRnr4D
	 Uo/y1eUYZgmblfUAa5Kw6qsc/MFuCaVufIpJETC4R5q2Eb3YgrS3rtbEXLr1JKimGL
	 rEFSFFQUcndZdwHANXOOjUZxd3cNi0osEMtOzsNaAphI7EoD999ZjUvulThpO7eL2s
	 Q2f4OwYHboQJSeFCOreQpIM/+XKRo7H0Oadr4Og1qA2b+x8oJ6qQkqNO+Ku8iNjSLa
	 WqCAxD00KpSYg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E438515C0276; Wed, 10 Jan 2024 15:35:21 -0500 (EST)
Date: Wed, 10 Jan 2024 15:35:21 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 update for 6.8-rc1
Message-ID: <20240110203521.GA1013681@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6c02757c936063f0631b4e43fe156f8c8f1f351f:

  jbd2: fix soft lockup in journal_finish_inode_data_buffers() (2023-12-12 10:25:46 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.8-rc1

for you to fetch changes up to 68da4c44b994aea797eb9821acb3a4a36015293e:

  ext4: fix inconsistent between segment fstrim and full fstrim (2024-01-10 13:53:36 -0500)

----------------------------------------------------------------
Various ext4 bug fixes and cleanups for v6.8-rc1.  The fixes are
mostly in the fstrim and mballoc code paths.  Also enable
dioread_nolock in the case where the block size is less than the page
size.  (Dioread_nolock has been default in the bs == ps case for quite
some time.)

----------------------------------------------------------------
Baokun Li (4):
      ext4: unify the type of flexbg_size to unsigned int
      ext4: remove unnecessary check from alloc_flex_gd()
      ext4: avoid online resizing failures due to oversized flex bg
      ext4: reduce unnecessary memory allocation in alloc_flex_gd()

Gou Hao (2):
      ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()
      ext4: improving calculation of 'fe_{len|start}' in mb_find_extent()

Matthew Wilcox (Oracle) (1):
      ext4: convert ext4_da_do_write_end() to take a folio

Ojaswin Mujoo (4):
      ext4: enable dioread_nolock as default for bs < ps case
      ext4: treat end of range as exclusive in ext4_zero_range()
      ext4: clarify handling of unwritten bh in __ext4_block_zero_page_range()
      ext4: fallback to complex scan if aligned scan doesn't work

Suraj Jitindar Singh (1):
      ext4: allow for the last group to be marked as trimmed

Ye Bin (1):
      ext4: fix inconsistent between segment fstrim and full fstrim

Zhihao Cheng (5):
      jbd2: add errseq to detect client fs's bdev writeback error
      jbd2: replace journal state flag by checking errseq
      jbd2: remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'
      jbd2: abort journal when detecting metadata writeback error of fs dev
      ext4: move ext4_check_bdev_write_error() into nojournal mode

 fs/ext4/ext4_jbd2.c   |  5 ++---
 fs/ext4/extents.c     |  6 ++++--
 fs/ext4/inode.c       | 25 ++++++++++++++++---------
 fs/ext4/mballoc.c     | 65 +++++++++++++++++++++++++++++++++++++----------------------------
 fs/ext4/resize.c      | 49 +++++++++++++++++++++++++++++++++----------------
 fs/ext4/super.c       | 11 +----------
 fs/jbd2/checkpoint.c  | 11 -----------
 fs/jbd2/journal.c     | 11 ++++++-----
 fs/jbd2/recovery.c    |  7 +------
 fs/jbd2/transaction.c | 14 ++++++++++++++
 include/linux/jbd2.h  | 37 ++++++++++++++++++++++++++-----------
 11 files changed, 140 insertions(+), 101 deletions(-)

