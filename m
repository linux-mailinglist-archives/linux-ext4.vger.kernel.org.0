Return-Path: <linux-ext4+bounces-7456-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C53A9B9F6
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B267AABC6
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9820D21CC68;
	Thu, 24 Apr 2025 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMN7yT5e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7BF1F4297
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530716; cv=none; b=W5svd/r2qwwUX9D5v79nSHzr4qaYhRT6JCnrYvIf3CTYuTHxPZL4eGGH55u7Lp5QHM+buBNnY7Xh0+P83T+L8z+r5lII99ypKgQqrkYFRGT7Sg+NuOMNnEXP3EmQIxrfAle6kJiHRkbH6CTeks5JpmhTInGQG/wk8FmJGxnQnSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530716; c=relaxed/simple;
	bh=oPfmZSbrbxE3Vs2FC5JTj4R589G1Oc3JM9oab8gQnZY=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=OJdcP6BUappL7AudBqfu2jr4e5w/suWSwYFp1sCK3fiZsaByJcXtwbUuP7QR3D0T0pYmnj3QPXhoJexaLLnr/61ncFkaKG07Cvd+bPx4V7lp1eJGV6UO9kpLUd6RK6N+vSdco20T2YleJY/oXgNJPcFaSxwnNoVeData+0SfDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMN7yT5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45F3C4CEE3;
	Thu, 24 Apr 2025 21:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530715;
	bh=oPfmZSbrbxE3Vs2FC5JTj4R589G1Oc3JM9oab8gQnZY=;
	h=Date:Subject:From:To:Cc:From;
	b=oMN7yT5eBxcPtNsfxfQGoJGj5nKXYwiHouLWJOeBJaZiVQVvOUUbsuO8ZjFp+esXp
	 BVFqZNO14eFxcnDC6l9qezDXbwrI2iDqNZ4J9j7VJco/Hiav6zomwVY6gXlbcUbi9t
	 tt+KLYkfdy4mwwWQpQx9T2U+Yjjr8XI6UrXYu+GLNHGLna3Qq+q4AiVwda1zHjbz1h
	 nsEr/2kbUMGTQbii48wcX6Ojqo+Nh2jwu/I+4DI7BWez0A9kqgOle8HtvRvKX+nJ78
	 76ac/z1FZ4hagFBtT3i/MIThBeIHYxLdApgo2TQzty22s2xGDv0gyDBHxbOX2C9WPs
	 glo4M+tyZU0cw==
Date: Thu, 24 Apr 2025 14:38:35 -0700
Subject: [PATCHSET 2/5] fuse2fs: prepare for kernel driver replacement
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064664.1160289.1903497308767982357.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series creates a new "kernel" mount option that signals to the
fuse2fs driver that it's being used as a containerizable replacement
for the kernel driver.  This has the effect of delegating quite a
lot of decisionmaking to the kernel, and opening access to users
other than whoever's running the fuse2fs server.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-kernel
---
Commits in this patchset:
 * fuse2fs: add dummy acl/user_xattr mount options
 * fuse2fs: set fuse subtype via argv[0] if possible
 * fuse2fs: make "ro" behavior consistent with the kernel
---
 misc/fuse2fs.c |   56 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 18 deletions(-)


