Return-Path: <linux-ext4+bounces-7457-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26774A9B9F7
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426E91B829B3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBFE21CC68;
	Thu, 24 Apr 2025 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWRlBWJx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0013218ACA
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530721; cv=none; b=HHl1cGnufp2MwP/F33zi++HCzwViPSkXRfWlm0s2QRosZob9UudeS4htAuNuRyX2agYOVihqA/naJilrXHHOprI6vJMaKYPoei+sEUTas/SD2BWM0MQe7LxORpCDmXwJmD3O/6F/BC2vT0S+A1CrjHF0xS0aDruD8SWTSyVcWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530721; c=relaxed/simple;
	bh=NtJXEK29D0qxGjzIdlKQXgxd241+BvEJzGLclAX0EKY=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=og5NzSjH0wefTXZ+cxw/KDrFDE3rr5FB9fOEacGVEP+UbwyC4sAI0nlg7ZsANX3sw3eFs2m7ycmQBECQm54Dm36IoAsO/OCtrctKdStja020cXNDeQxbipf9B89T904HISUfEno1rEk4epBq8nzYzp49vQUBFeWVU1DSf5DAZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWRlBWJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5142EC4CEE3;
	Thu, 24 Apr 2025 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530721;
	bh=NtJXEK29D0qxGjzIdlKQXgxd241+BvEJzGLclAX0EKY=;
	h=Date:Subject:From:To:Cc:From;
	b=AWRlBWJxlpjq8NQF6MVg2GCYlwk251QS+rAd3253X7dRP3ED2/TL3Zt1SKAKiVV3E
	 FKXPKhedRpgMw88mI4NbcxrcNbiHRpmu3eSpJPaVOgjHu9Ux0HDdY7//Vn9tGkC+Wh
	 kX0A2JZCJtKVedWV2mJogaSjPGxG5djiXoCn+Xkoqy/JnjuS7TCyiCyZvqTS9MoXaP
	 s9vuHKQofu5k06lueLs7OBNM1YJf7HhDv0JkKoG9gGeDG04Aqx9PuT0qAqnKYPSZ2t
	 8y+wNXMS3ZoVaxVpUB996W1jCNwkAv5OQJf9vhgYowE2hx+UoOBHbOsBfYmqVtAu9F
	 RG0IFnztDWYnw==
Date: Thu, 24 Apr 2025 14:38:40 -0700
Subject: [PATCHSET 3/5] fuse2fs: many fixes and improvements
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series fixes many many bugs in fuse2fs.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-fixes
---
Commits in this patchset:
 * fuse2fs: refuse unsupported features
 * fuse2fs: return -EOPNOTSUPP when we don't recognize a fallocate mode
 * fuse2fs: implement zero range
 * fuse2fs: remove posix acl translation
 * fuse2fs: log names of xattrs being set/get/removed
 * fuse2fs: add an easy option for emulating kernel access behaviors
 * fuse2fs: report nanoseconds resolution through getattr
 * fuse2fs: clamp timestamps that are being written to disk
 * fuse2fs: add supportable mount options from the kernel
 * fuse2fs: support getting and setting via struct fsxattr
 * fuse2fs: support changing newer iflags
 * fuse2fs: update new child timestamps during mkdir/symlink
 * fuse2fs: report real inode numbers
 * fuse2fs: disable renameat2
 * fuse2fs: fix FITRIM validation
 * fuse2fs: report inode number and file type via readdir
---
 lib/ext2fs/ext2_fs.h |    4 
 misc/fuse2fs.1.in    |    9 +
 misc/fuse2fs.c       |  629 ++++++++++++++++++++++++++------------------------
 3 files changed, 341 insertions(+), 301 deletions(-)


