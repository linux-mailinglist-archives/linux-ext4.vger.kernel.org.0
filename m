Return-Path: <linux-ext4+bounces-9391-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72232B2A0F3
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 14:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827E61895A57
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0FE31B105;
	Mon, 18 Aug 2025 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nywd6PaY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531531AF18
	for <linux-ext4@vger.kernel.org>; Mon, 18 Aug 2025 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518221; cv=none; b=juJowxb2P430SmxHvinMDXYrA562aNbyEVIlh85hnN4L+WQlKIH5Ifj2+MunKNFSGUoI77mC40Bm7NxQ/aUa1+r6Ywo9UP9HegzhU71Bhfs0tUZoUS0pMZIHxftdde1QIpt6wRRj8YPb26zvuxJ8T/RMSuhE14L4H9HuKsSRsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518221; c=relaxed/simple;
	bh=0uAT5b3eeqg/B5dVGJ+S65SYsAbLnzqRKf+boURVmqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cFuofGsq2/EjL6JQ5S72LE0tnMSM1YdsJ3gqq+FYJBZJzQ9CYN77siiWqYrOF1vXV+mJ0hR3w5Ko9ytqCZgwgq0JqIIGe+54HYOIsQOP4odHKom0vLNLNoqOih7Xy71esmBxkWlJk8sTDpvYsDSN8noxKAwNa8IBvGITjB1uhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nywd6PaY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-50.bstnma.fios.verizon.net [173.48.115.50])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57IBuldJ019235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 07:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755518209; bh=5dfyMZLSE+R8H0J+MxoGc28SsIdX7dVYyr9R1Gb5nmY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=nywd6PaYy04knjojIJiixNdcZ/muMRF99eyCVqP53cQdOgo/mWSJXnpfuatvj3dYt
	 +OUA3PRvcXBGpvDyVe6LFIPs87yXsaXPgYKHusCiNutwLCW0H7GH579+hHkuTgMZLW
	 KvtkrRYO9zIR5jprj4i+YP7n3cL1EuXf91BEFmCfsjSmv3ACxlwNlxZilE6yAD2jEw
	 f3t3xSEfyyyRNwwD4dOS85B9EF0E5fNN6SQ2RZTxxhVZxmTM0qG0+TMekXMosQ211e
	 zLUA/lNjuj452PsgtRnGTt3IOPYpsqY960ODR3SbeLOZWZpXVSklHhUoNFxbSwDKZi
	 CBItRApRvnOXw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D6BE22E00D6; Mon, 18 Aug 2025 07:56:47 -0400 (EDT)
Date: Mon, 18 Aug 2025 07:56:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 bug fixes for v6.17-rc3
Message-ID: <20250818115647.GA1217293@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 099b847ccc6c1ad2f805d13cfbcc83f5b6d4bc42:

  ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr (2025-07-25 09:14:17 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.17-rc3

for you to fetch changes up to 9d98cf4632258720f18265a058e62fde120c0151:

  jbd2: prevent softlockup in jbd2_log_do_checkpoint() (2025-08-13 14:24:14 -0400)

----------------------------------------------------------------
Ext4 bug fixes and cleanups for 6.17-rc3, including most notably:

  * Fix fast commit checks for file systems with ea_inode enabled
  * Don't drop the i_version mount option on a remount
  * Fix FIEMAP reporting when there are holes in a bigalloc file system
  * Don't fail when mounting read-only when there are inodes in the
    orphan file
  * Fix hole length overflow for indirect mapped files on file systems
    with an 8k or 16k block file system.

----------------------------------------------------------------
Andreas Dilger (1):
      ext4: check fast symlink for ea_inode correctly

Antonio Quartulli (1):
      ext4: remove useless if check

Baokun Li (3):
      ext4: show the default enabled i_version option
      ext4: preserve SB_I_VERSION on remount
      jbd2: prevent softlockup in jbd2_log_do_checkpoint()

Baolin Liu (1):
      ext4: fix incorrect function name in comment

Liao Yuanhong (1):
      ext4: use kmalloc_array() for array space allocation

Ojaswin Mujoo (2):
      ext4: fix fsmap end of range reporting with bigalloc
      ext4: fix reserved gdt blocks handling in fsmap

Qianfeng Rong (1):
      ext4: remove redundant __GFP_NOWARN

Theodore Ts'o (2):
      ext4: fix unused variable warning in ext4_init_new_dir
      ext4: don't try to clear the orphan_present feature block device is r/o

Zhang Yi (1):
      ext4: fix hole length calculation overflow in non-extent inodes

 fs/ext4/fsmap.c      | 23 ++++++++++++++++++++---
 fs/ext4/indirect.c   |  4 ++--
 fs/ext4/inode.c      |  4 ++--
 fs/ext4/namei.c      |  4 ----
 fs/ext4/orphan.c     |  5 +++--
 fs/ext4/page-io.c    |  2 +-
 fs/ext4/super.c      | 12 ++++++++----
 fs/jbd2/checkpoint.c |  1 +
 8 files changed, 37 insertions(+), 18 deletions(-)

