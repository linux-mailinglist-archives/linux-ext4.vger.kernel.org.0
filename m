Return-Path: <linux-ext4+bounces-1094-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89257848B2B
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Feb 2024 06:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E381F22289
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Feb 2024 05:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE863B1;
	Sun,  4 Feb 2024 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="d7sDOq+D"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B2611A
	for <linux-ext4@vger.kernel.org>; Sun,  4 Feb 2024 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707023732; cv=none; b=KKbVJOWNNRxai3zDQ9RvZLyNfk40g2WyjnQOSQwRnJNSzm6yFj1nFjzGGOnhQ/Tj3YrIVs+RKVU+vHOuD7JOs1gFWjfS0PeS7RDYQRy3dErfA5KMdw42FqagTbiJoeREFMnmHXhP5KEPc07E+I3WrazmeJhx7erNdZdbf2btCiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707023732; c=relaxed/simple;
	bh=xFmlI7vywnpnkwopJt9hfOdzW2XX4SrrGwOuJsKfjAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PJIlVye/Zym1LLWabTM5gPe4cfMn4NfKUS8mdsWKGfLv/cPktnPS/itcK5iRs8NtrYH+RQpsZtnZN7icL7bfrkRzCkgr5APWzl181+iY5S4OlrN04TuFXk1HPkMq3MwLQR+D8weeuCeT5lKXlYd9roH+s6c1n5oFnA6MqEqjqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=d7sDOq+D; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4145FOJY022461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Feb 2024 00:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707023726; bh=3GSeuIDQxaZam0abvCGZGnkGb3dP6aSsbWbXsXQ7sFo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=d7sDOq+DtafdLu+k31UgVAK8y5QHZeipM1DujG3nj2HzLrfh5ssb1SJtC78rIlNH2
	 I2Mi6Qcg3U8CTWR67h/ebfQS4RSIOjnEh53mPFVrYCFPJR1W4yWT+u+MVS52gzu85J
	 h+eWktTajVLKerR+xE/Vabt38TX780PeFUURPY5chC/gysLV9E1uWNlHfJzA+zXW7u
	 2CqVtmefKY1oXuud41OPCQzjCUEF0nuz5Dp3y3W8mieUYLXb5pIF2NaMIC3SGc+2op
	 kgro7AhXiNhw0FtlVG1nKeh+JCPYLGghqFaSBnJTAY5amsNNbr5dnn41FXoJCmfAbW
	 pHgQTEuTUA02Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A584B15C02FD; Sun,  4 Feb 2024 00:15:24 -0500 (EST)
Date: Sun, 4 Feb 2024 00:15:24 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 bug fixes for v6.8-rc3
Message-ID: <20240204051524.GA206753@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0d19d9e14687ff6f43d6c4806ace9ff682d7703f:

  Merge tag 'ext4_for_linus-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2024-01-10 16:09:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/for-linus-6.8-rc3

for you to fetch changes up to ec9d669eba4c276d00af88951947fe0e82a6b84c:

  ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC map type (2024-02-01 23:59:21 -0500)

----------------------------------------------------------------
Miscellaneous bug fixes and cleanups in ext4's multi-block allocator
and extent handling code.

----------------------------------------------------------------
Baokun Li (8):
      ext4: fix double-free of blocks due to wrong extents moved_len
      ext4: do not trim the group with corrupted block bitmap
      ext4: regenerate buddy after block freeing failed if under fc replay
      ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()
      ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
      ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
      ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
      ext4: mark the group block bitmap as corrupted before reporting an error

Kemeng Shi (9):
      ext4: remove unused return value of __mb_check_buddy
      ext4: remove unused parameter ngroup in ext4_mb_choose_next_group_*()
      ext4: remove unneeded return value of ext4_mb_release_context
      ext4: remove unused ext4_allocation_context::ac_groups_considered
      ext4: remove unused return value of ext4_mb_release
      ext4: remove unused return value of ext4_mb_release_inode_pa
      ext4: remove unused return value of ext4_mb_release_group_pa
      ext4: remove unnecessary parameter "needed" in ext4_discard_preallocations
      ext4: remove 'needed' in trace_ext4_discard_preallocations

Zhang Yi (6):
      ext4: refactor ext4_da_map_blocks()
      ext4: convert to exclusive lock while inserting delalloc extents
      ext4: correct the hole length returned by ext4_map_blocks()
      ext4: add a hole extent entry in cache after punch
      ext4: make ext4_map_blocks() distinguish delalloc only extent
      ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC map type

 fs/ext4/ext4.h              |   8 +--
 fs/ext4/extents.c           | 124 ++++++++++++++++++++++++++++-----------------
 fs/ext4/file.c              |   2 +-
 fs/ext4/indirect.c          |   2 +-
 fs/ext4/inode.c             |  90 +++++++++++----------------------
 fs/ext4/ioctl.c             |   2 +-
 fs/ext4/mballoc.c           | 140 ++++++++++++++++++++++++++++-----------------------
 fs/ext4/mballoc.h           |   1 -
 fs/ext4/move_extent.c       |  10 ++--
 fs/ext4/super.c             |   2 +-
 include/trace/events/ext4.h |  11 ++--
 11 files changed, 203 insertions(+), 189 deletions(-)

