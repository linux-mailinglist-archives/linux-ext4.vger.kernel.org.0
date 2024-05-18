Return-Path: <linux-ext4+bounces-2568-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889278C8FA2
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 06:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC91B21BEE
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 04:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1B3D9E;
	Sat, 18 May 2024 04:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pJldRtGU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D4621
	for <linux-ext4@vger.kernel.org>; Sat, 18 May 2024 04:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716007571; cv=none; b=tAdWgKNRE2DiVta6qmIfb562Vk0hVx5yIMdlwUR1qqmtApE4C3uMXmu2Ra8x8X7ma7GO3Y1CdLBTALwCaRTd0OmbkxFYy5rGFWSxPyLMQCdAEauor0WbpOD1fOPz1d4NcsG67pjAZubNL9nxcv2ysVty5brjCXGqoL4HR5dokr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716007571; c=relaxed/simple;
	bh=zko0GQvgQmrQKqUCDztIo20k64rQkCRdQOFf5LVRNOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d6f3hxsvcRh3q89JTSUreta81ylbUT1vTZQdiCq+NgOrZsmsCpZQfSuIAMEx6uUvyZnxLq1JSvorUXajKOwK3u1POEJNob9HXJhVAr2EtAb9krtoDcee++nB0LI43B/CvF7MaRg4SbVf4rdElJK/uazuyVpHYgvyj/5rpe7r0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pJldRtGU; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44I4k2EV000641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 00:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1716007563; bh=VXD0kbwWVZnwfsiyxEZxxCdIqZ/+aqzg6M6B03Hd/ps=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pJldRtGU3aiRbXK7YAvuBFRrbw4anQFUUwswOnNo+O59Bj2j+oeNd25BDldNaiL53
	 /iYcurizVRTpQ9zRUNlHpZ8Cvke6qqYvbxmZDxIl73iwL6ebvjS4jvv7iTjm7j6j3M
	 MEDAO7ayG1TA1qfDdziOCJaoQA1c8FdT55BB3maP+ZPhDj/7cZoV7h9lkH4R9Oh8MG
	 HYQGuyBsNqYvW7D20hvgmExi19DEibVP0F30MBt8Qjq4kuXzDbtAy3KDFQ93j8KXpU
	 aibupskFnYVv7IjhQa5TkTWxBjL8+nrT+raZCiAL+7byz8f3Z8927Hy90hM9HRGNzc
	 fgmAOlCwlVLfw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DF90715C00DC; Sat, 18 May 2024 00:46:01 -0400 (EDT)
Date: Sat, 18 May 2024 00:46:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 updates for v6.10-rc1
Message-ID: <20240518044601.GA478319@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.10-rc1

for you to fetch changes up to c6a6c9694aadc4c3ab8d89bdd44aed3eab1e43c6:

  ext4: fix error pointer dereference in ext4_mb_load_buddy_gfp() (2024-05-17 11:24:38 -0400)

Note that there is a relatively merge conflict; the relatively simple
resolution which I used when running regression tests is at the tag
ext4_merge_resolution in the ext4 git repo,
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git

----------------------------------------------------------------
Ext4 patches for the 6.10-rc1 merge window:
 - more folio conversion patches
 - add support for FS_IOC_GETFSSYSFSPATH
 - mballoc cleaups and add more kunit tests
 - sysfs cleanups and bug fixes
 - miscellaneous bug fixes and cleanups

----------------------------------------------------------------
Baokun Li (12):
      ext4: avoid overflow when setting values via sysfs
      ext4: refactor out ext4_generic_attr_store()
      ext4: refactor out ext4_generic_attr_show()
      ext4: fix slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists()
      ext4: add new attr pointer attr_mb_order
      ext4: add positive int attr pointer to avoid sysfs variables overflow
      ext4: set type of ac_groups_linear_remaining to __u32 to avoid overflow
      ext4: set the type of max_zeroout to unsigned int to avoid overflow
      ext4: clean up s_mb_rb_lock to fix build warnings with C=1
      ext4: fix mb_cache_entry's e_refcnt leak in ext4_xattr_block_cache_find()
      ext4: propagate errors from ext4_sb_bread() in ext4_xattr_block_cache_find()
      ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()

Christoph Hellwig (1):
      ext4: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method

Colin Ian King (1):
      jbd2: remove redundant assignement to variable err

Dan Carpenter (2):
      ext4: fix potential unnitialized variable
      ext4: fix error pointer dereference in ext4_mb_load_buddy_gfp()

Jan Kara (3):
      ext4: avoid excessive credit estimate in ext4_tmpfile()
      Revert "ext4: drop duplicate ea_inode handling in ext4_xattr_block_set()"
      ext4: do not create EA inode under buffer lock

Justin Stitt (1):
      ext4: replace deprecated strncpy with alternatives

Kemeng Shi (6):
      ext4: implement filesystem specific alloc_inode in unit test
      ext4: keep "prefetch_grp" and "nr" consistent
      ext4: add test_mb_mark_used_cost to estimate cost of mb_mark_used
      ext4: call ext4_mb_mark_free_simple to free continuous bits in found chunk
      ext4: use correct criteria name instead stale integer number in comment
      ext4: open coding repeated check in next_linear_group

Kent Overstreet (1):
      ext4: add support for FS_IOC_GETFSSYSFSPATH

Matthew Wilcox (Oracle) (6):
      ext4: convert bd_bitmap_page to bd_bitmap_folio
      ext4: convert bd_buddy_page to bd_buddy_folio
      ext4: convert ext4_mb_init_cache() to take a folio
      ext4: convert ac_bitmap_page to ac_bitmap_folio
      ext4: convert ac_buddy_page to ac_buddy_folio
      ext4: remove calls to to set/clear the folio error flag

Max Kellermann (1):
      Revert "ext4: apply umask if ACL support is disabled"

Ritesh Harjani (IBM) (2):
      ext4: Fixes len calculation in mpage_journal_page_buffers
      ext4: Remove PAGE_MASK dependency on mpage_submit_folio

Thorsten Blum (1):
      ext4: remove unneeded if checks before kfree

Ye Bin (2):
      jbd2: use shrink_type type instead of bool type for __jbd2_journal_clean_checkpoint_list()
      jbd2: add prefix 'jbd2' for 'shrink_type'

Zhang Yi (1):
      ext4: remove the redundant folio_wait_stable()

 fs/ext4/acl.h          |   5 -
 fs/ext4/ext4.h         |   9 +-
 fs/ext4/extents.c      |   3 +-
 fs/ext4/file.c         |   5 +-
 fs/ext4/inode.c        |  11 +-
 fs/ext4/ioctl.c        |   3 +-
 fs/ext4/mballoc-test.c |  76 +++++++++++++
 fs/ext4/mballoc.c      | 322 +++++++++++++++++++++++++++++---------------------------
 fs/ext4/mballoc.h      |  14 +--
 fs/ext4/move_extent.c  |   4 +-
 fs/ext4/namei.c        |   2 +-
 fs/ext4/page-io.c      |   3 -
 fs/ext4/readpage.c     |   1 -
 fs/ext4/super.c        |  36 +++----
 fs/ext4/sysfs.c        | 174 ++++++++++++++++++------------
 fs/ext4/xattr.c        | 145 +++++++++++++------------
 fs/jbd2/checkpoint.c   |  24 +++--
 fs/jbd2/commit.c       |   3 +-
 include/linux/jbd2.h   |   4 +-
 19 files changed, 481 insertions(+), 363 deletions(-)

