Return-Path: <linux-ext4+bounces-412-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C980F6C1
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 20:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9394A1C20A01
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 19:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A2E81E59;
	Tue, 12 Dec 2023 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lBu/BoK7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172BBBD
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 11:33:08 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-124-235.bstnma.fios.verizon.net [173.48.124.235])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3BCJX4aW019833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 14:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1702409585; bh=0KcL42PTALNe0VGoTmysrDUPSzlpFZnc0OMkkvwj0Ao=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lBu/BoK7jac5GT20dUnuHoD6xmpq2Cd6+nzPPA8Fr5KUaVtDI15hytaqT9soPxmu2
	 BJV77cs6rooh/OFv6O/BmcM6pNaWgqC6YNja8yaJrB8sFDj5Ttpeml9wuTpjCjHuGB
	 asQgq5eOFtsTcojM3vyXgVOTM+Z5XHOpUUp/4Fs91gzpT/nbaceCU9z0+CuP9Qi168
	 377MtoCjCxhNMgNmg79diIrQ2xFG7f7X5r9s71HrjEZivQe9CxNvEOO+YbKqj+rGRS
	 +9403Bvd2U3den4apvrtXW/4/90Y98PPR/5a74R1uShMtP2y3J8Lw0B1nAaQsj9JHj
	 OwzgB3uXj7jEA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D1D1315C410D; Tue, 12 Dec 2023 14:33:03 -0500 (EST)
Date: Tue, 12 Dec 2023 14:33:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 bug fixes for 6.7-rc6
Message-ID: <20231212193303.GA154795@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.7-rc6

for you to fetch changes up to 6c02757c936063f0631b4e43fe156f8c8f1f351f:

  jbd2: fix soft lockup in journal_finish_inode_data_buffers() (2023-12-12 10:25:46 -0500)

----------------------------------------------------------------
Fix various bugs / regressions for ext4, including a soft lockup, a
WARN_ON, and a BUG.

----------------------------------------------------------------
Baokun Li (1):
      ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS

Jan Kara (1):
      ext4: fix warning in ext4_dio_write_end_io()

Ye Bin (1):
      jbd2: fix soft lockup in journal_finish_inode_data_buffers()

Zhang Yi (2):
      jbd2: correct the printing of write_flags in jbd2_write_superblock()
      jbd2: increase the journal IO's priority

 fs/ext4/file.c       | 14 ++++++++------
 fs/ext4/mballoc.c    |  4 ++++
 fs/jbd2/commit.c     | 10 ++++++----
 fs/jbd2/journal.c    | 24 ++++++++++++++----------
 include/linux/jbd2.h |  3 +++
 5 files changed, 35 insertions(+), 20 deletions(-)

