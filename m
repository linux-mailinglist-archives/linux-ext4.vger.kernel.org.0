Return-Path: <linux-ext4+bounces-9214-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581E8B146EA
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 05:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3BB1AA12E0
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 03:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D8721CA0C;
	Tue, 29 Jul 2025 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WCO83se8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A2DDAD
	for <linux-ext4@vger.kernel.org>; Tue, 29 Jul 2025 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753760280; cv=none; b=SPuU4H3/ypQbJTa1BUmhmT1bIjC846sO1ErYeHVVa+UHwB2cFNrP7a/JBvgSn66QjB6+Dq/y4jz3lXK7/OHeZGgGe8jgrLbr89T3me2BvBxRWveuWtVNvJy97fgUZoLHi97q7+KJyeqxsopb5et+L4zoIHV6BuTGkfaVH/iFFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753760280; c=relaxed/simple;
	bh=u1i49Dv3YX5z8y/jqrH4niAF/TlsgXnzcSUYzb0jqUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cvb1Ab1uYXzo3gMKe9d5fYZiIcxSt5xB/hnp2X01kI1P/carnEo/xi6LefGRf3zT9ad1gaLLYatGf3X/dOAXXIWQCm2laTWhEQJQcJdRAAuPQcHKhgQb7PC3C6C4Fq+C4c2sm/E72BODBuEufhkPo4TX1mS3aLoa2qcukcsOGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WCO83se8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-187.bstnma.fios.verizon.net [173.48.116.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56T3bmRl004852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 23:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753760270; bh=z02aLng5QTCiVBkIvda0j1QXulfh+U+sIwIQCkw/54I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=WCO83se8ngFYx+XUzbe2UjjkPke/KiOdWHo+PNqwdEhTjtQwt92+nCFoAMixqQZGU
	 R6iF4PCjDe29ph2TpODolarB2UaHsgA8vTn6CZ5yaTEe+BaiLttXivT9OfKuFLYaOY
	 5out7IjpytAgCledc3kJ2I3j5huB1fbjDlQQIzWo9mXS+MwPpiKrugtovI7INpp6bY
	 fVFZxdZnXlUPDtnrO6KYCI4MM0FFwXgJtgQbvyNQxIRy8CtuAPYBVl/wQ/VKbyqjLx
	 X1lGuoz1QS0N2ViHiG4ofR0mbgq8EL1NUE0L45WHdgzKJvMPvbTd5EXAKxM5EyFhTn
	 GfybzFMZZuitg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 5F6FA2E00D6; Mon, 28 Jul 2025 23:37:48 -0400 (EDT)
Date: Mon, 28 Jul 2025 23:37:48 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 changes for 6.17-rc1
Message-ID: <20250729033748.GA367490@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_6.17-rc1

for you to fetch changes up to 099b847ccc6c1ad2f805d13cfbcc83f5b6d4bc42:

  ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr (2025-07-25 09:14:17 -0400)

----------------------------------------------------------------
Major ext4 changes for 6.17:

  - Better scalability for ext4 block allocation
  - Fix insufficient credits when writing back large folios

Miscellaneous bug fixes, especially when handling exteded attriutes,
inline data, and fast commit.

----------------------------------------------------------------
Baokun Li (18):
      ext4: fix inode use after free in ext4_end_io_rsv_work()
      ext4: add ext4_try_lock_group() to skip busy groups
      ext4: separate stream goal hits from s_bal_goals for better tracking
      ext4: remove unnecessary s_mb_last_start
      ext4: remove unnecessary s_md_lock on update s_mb_last_group
      ext4: utilize multiple global goals to reduce contention
      ext4: get rid of some obsolete EXT4_MB_HINT flags
      ext4: fix typo in CR_GOAL_LEN_SLOW comment
      ext4: convert sbi->s_mb_free_pending to atomic_t
      ext4: merge freed extent with existing extents before insertion
      ext4: fix zombie groups in average fragment size lists
      ext4: fix largest free orders lists corruption on mb_optimize_scan switch
      ext4: factor out __ext4_mb_scan_group()
      ext4: factor out ext4_mb_might_prefetch()
      ext4: factor out ext4_mb_scan_group()
      ext4: convert free groups order lists to xarrays
      ext4: refactor choose group to scan group
      ext4: implement linear-like traversal across order xarrays

Baolin Liu (1):
      ext4: remove unused EXT_STATS macro from ext4_extents.h

Dan Carpenter (1):
      ext4: remove unnecessary duplicate check in ext4_map_blocks()

I Hsin Cheng (1):
      ext4: Refactor breaking condition for xattr_find_entry()

Jan Kara (1):
      ext4: Make sure BH_New bit is cleared in ->write_end handler

Jinliang Zheng (1):
      ext4: remove duplicate check for EXT4_FC_REPLAY

Theodore Ts'o (4):
      ext4: replace strcmp with direct comparison for '.' and '..'
      ext4: use memcpy() instead of strcpy()
      ext4: refactor the inline directory conversion and new directory codepaths
      ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr

Zhang Yi (12):
      ext4: process folios writeback in bytes
      ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
      ext4: fix stale data if it bail out of the extents mapping loop
      ext4: refactor the block allocation process of ext4_page_mkwrite()
      ext4: restart handle if credits are insufficient during allocating blocks
      ext4: enhance tracepoints during the folios writeback
      ext4: correct the reserved credits for extent conversion
      ext4: reserved credits for one extent during the folio writeback
      ext4: replace ext4_writepage_trans_blocks()
      ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
      ext4: limit the maximum folio order
      ext4: initialize superblock fields in the kballoc-test.c kunit tests

 fs/ext4/balloc.c            |   2 +-
 fs/ext4/ext4.h              |  74 +++----
 fs/ext4/ext4_extents.h      |   7 -
 fs/ext4/extents.c           |   6 +-
 fs/ext4/ialloc.c            |   3 +-
 fs/ext4/inline.c            |  91 +++-----
 fs/ext4/inode.c             | 358 +++++++++++++++++++-----------
 fs/ext4/mballoc-test.c      |   5 +
 fs/ext4/mballoc.c           | 895 +++++++++++++++++++++++++++++++++++++++++---------------------------------
 fs/ext4/mballoc.h           |   9 +-
 fs/ext4/move_extent.c       |   3 +-
 fs/ext4/namei.c             |  69 +++---
 fs/ext4/page-io.c           |  16 +-
 fs/ext4/xattr.c             |   4 +-
 include/trace/events/ext4.h |  50 ++++-
 15 files changed, 900 insertions(+), 692 deletions(-)

