Return-Path: <linux-ext4+bounces-5236-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054669D10AF
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 13:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B72AB24408
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B92E1991DA;
	Mon, 18 Nov 2024 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PwCWYp9K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6A1993B2
	for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2024 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933596; cv=none; b=ikrUNmMrIC/HWHbdsOTpB4IJE0LKwWeEd+CQjPR1tmRLRPPr3RCBQcYc/nnkzKQSrQ3jw1EN/lmpQ9fAxQi4qZ9FI/59uEuQMbVclsYcIUM2niTmgArD9eQMEQg5/MXMdoxXE41jyUUWAgG0BZ/uycwAu1cnYosumzq/ZP45ID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933596; c=relaxed/simple;
	bh=Y89whwxsnH+T4B1CM6x6ApN7ZbvJ4mHDuHMCVmwwWbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fxDWmKDUMRD9QQWieyJcFiNdRbESd5ecsPUpL+xlhrLpTvEZi2kQZ/jK8z3KARtgf5rApJDXyBKPC9oXxNsJbVvHo5lJFxtZIZDqbaj9qUhO1rmatdzWmWaxW0oyazymOpngofRBXmBa6JVaeAARq6RfkNyFqMWD/AW3U6zXEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PwCWYp9K; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-28.bstnma.fios.verizon.net [173.48.111.28])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AICdgh0029145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 07:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731933584; bh=8i/2Dtxs9WU+cyaV0nWb6hSxHSnSMU6XQ6w15BE/fUA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PwCWYp9Kh49O8wVQERyl5O1qp6oLDsV6QM+UlYiomsdhNdKYICFeMFe7Bt0CJTJIc
	 zLSOzm+q3VrF1NbBkjzB/zp6ZPGypvvMXSXbwYTk3haE7JzognMGP+rRdBjKas8Ztu
	 m1PG56fGofSmmSkiLGN1oRwK1HXhiqZrrRj80S8IUdUTf6zeBBE0OnsEicus5Fs9JT
	 48AxuXnEwVvAGW7aIYoXdfc5w7fycIPoeZ6gX7+NTvL5pgd4s2yveTt7h0ntL6X6We
	 NXsAPyWc9cnVWoBfbtJ2iIFmsNeXXEs2jUrf/ij7Rv5Hj5E8XLpWXUTqpabPYe3SVv
	 VbA7KyQTSN91w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 55A8515C02FD; Mon, 18 Nov 2024 07:39:42 -0500 (EST)
Date: Mon, 18 Nov 2024 07:39:42 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 updates for v6.13-rc1
Message-ID: <20241118123942.GA1745460@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.13-rc1

for you to fetch changes up to 3e7c69cdb053f9edea95502853f35952ab6cbf06:

  jbd2: Fix comment describing journal_init_common() (2024-11-13 12:56:48 -0500)

----------------------------------------------------------------
A lot of miscellaneous ext4 bug fixes and cleanups this cycle, most
notably in the journaling code, bufered I/O, and compiler warning
cleanups.

----------------------------------------------------------------
Amir Goldstein (1):
      ext4: return error on syncfs after shutdown

Andy Shevchenko (1):
      ext4: mark ctx_*_flags() with __maybe_unused

Baokun Li (2):
      ext4: show the default enabled prefetch_block_bitmaps option
      ext4: WARN if a full dir leaf block has only one dentry

Brian Foster (2):
      ext4: partial zero eof block on unaligned inode size extension
      mm: zero range of eof folio exposed by inode size extension

Dan Carpenter (1):
      ext4: cleanup variable name in ext4_fc_del()

Daniel Martín Gómez (1):
      jbd2: Fix comment describing journal_init_common()

Gustavo A. R. Silva (1):
      jbd2: avoid dozens of -Wflex-array-member-not-at-end warnings

Jan Kara (1):
      ext4: avoid remount errors with 'abort' mount option

Jeongjun Park (1):
      ext4: supress data-race warnings in ext4_free_inodes_{count,set}()

Jiapeng Chong (1):
      ext4: simplify if condition

Jinliang Zheng (1):
      ext4: disambiguate the return value of ext4_dio_write_end_io()

Long Li (1):
      ext4: fix race in buffer_head read fault injection

Markus Elfring (1):
      ext4: Call ext4_journal_stop(handle) only once in ext4_dio_write_iter()

Mathieu Othacehe (1):
      ext4: prevent an infinite loop in the lazyinit thread

Nicolas Bretz (1):
      ext4: prevent delalloc to nodelalloc on remount

R Sundar (1):
      ext4: use string choices helpers

Theodore Ts'o (1):
      ext4: fix FS_IOC_GETFSMAP handling

Thorsten Blum (3):
      ext4: use str_yes_no() helper function
      ext4: annotate struct fname with __counted_by()
      ext4: use struct_size() to improve ext4_htree_store_dirent()

Ye Bin (6):
      jbd2: remove redundant judgments for check v1 checksum
      jbd2: unified release of buffer_head in do_one_pass()
      jbd2: refactor JBD2_COMMIT_BLOCK process in do_one_pass()
      jbd2: factor out jbd2_do_replay()
      jbd2: remove useless 'block_error' variable
      jbd2: remove the 'success' parameter from the jbd2_do_replay() function

Yu Jiaoliang (1):
      ext4: use ERR_CAST to return an error-valued pointer

Zhang Yi (1):
      ext4: don't pass full mapping flags to ext4_es_insert_extent()

Zhaoyang Huang (1):
      fs: ext4: Don't use CMA for buffer_head

Zhihao Cheng (1):
      jbd2: make b_frozen_data allocation always succeed

j.xia (1):
      ext4: pass write-hint for buffered IO

 fs/ext4/balloc.c         |   4 +-
 fs/ext4/dir.c            |   7 +-
 fs/ext4/ext4.h           |  12 +--
 fs/ext4/extents.c        |  13 +++-
 fs/ext4/extents_status.c |   8 +-
 fs/ext4/extents_status.h |   3 +-
 fs/ext4/fast_commit.c    |   8 +-
 fs/ext4/file.c           |  12 ++-
 fs/ext4/fsmap.c          |  54 ++++++++++++-
 fs/ext4/ialloc.c         |   5 +-
 fs/ext4/indirect.c       |   2 +-
 fs/ext4/inode.c          |  70 ++++++++++++-----
 fs/ext4/mballoc.c        |  22 ++++--
 fs/ext4/mballoc.h        |   1 +
 fs/ext4/mmp.c            |   2 +-
 fs/ext4/move_extent.c    |   2 +-
 fs/ext4/namei.c          |  18 ++++-
 fs/ext4/page-io.c        |   4 +-
 fs/ext4/resize.c         |   2 +-
 fs/ext4/super.c          |  80 ++++++++++++-------
 fs/jbd2/commit.c         |   4 -
 fs/jbd2/journal.c        |  15 ++--
 fs/jbd2/recovery.c       | 311 +++++++++++++++++++++++++++++++++++--------------------------------------
 include/linux/jbd2.h     |  15 ++--
 mm/truncate.c            |  15 ++++
 25 files changed, 402 insertions(+), 287 deletions(-)

