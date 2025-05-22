Return-Path: <linux-ext4+bounces-8136-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A1AAC00DF
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 02:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BBC1BC3521
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B87383;
	Thu, 22 May 2025 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6pVpZ2M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD6195
	for <linux-ext4@vger.kernel.org>; Thu, 22 May 2025 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872114; cv=none; b=WuUlNIi5FE1c+OsfbMGJEwxDsBLsEbqMhOOKj7ldTxZBU11Lm21fpUGGgWxY9eUbOGXyMfIJQC0Oijt5+f6OEbKjKCr7SnnEYDe11VRk0TMakBts4/s+HRXj0GV+3baH5rD2x+ZsHk38EsaD3Ver20F33YqDc5rWz1vVoNm7QYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872114; c=relaxed/simple;
	bh=dimLlWzefVw+xFC8Y82/Uv/MG5e2Bal08feGmHhcZFI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j585DKJyOa/ZHDbExLbDtAMtDZh6Wiqn4E9gdOjjNsB/1r4fNpEr8N+3ehfh1confAlpLPDvpfvZSPMqBcq/NuPrhKXL1pWE+LUOHsZBLvszuguleAbXjkg0X4TPlBzCFfAM28uHqYBNga/y01LJwIkmAPE1FrXL/N6rlAoSG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6pVpZ2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ED1C4CEE4;
	Thu, 22 May 2025 00:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872114;
	bh=dimLlWzefVw+xFC8Y82/Uv/MG5e2Bal08feGmHhcZFI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e6pVpZ2MijOMrc4CrL9xu6OY2ifGVm24nY+07sgzyenaiFZF9h5V/sgxVQQD0QsUe
	 kSDC6JFC7C2UK6oCR0yoLPBoh4WdVQUimMWZ6X4pS44EJJVeQ7d3EB68mP7eE+9hu9
	 WyuF+0ARMWw7PsPhLXO0kti7e+wjzQByIA9LYd5CUoumTyYKfcESH4OqrCrGdFafAm
	 EvlSJXL/upsosHcNFgA40DW+S8wxhMr+YZphQhCNVCgFMznXvV274WR8NH8cE9+Dlk
	 3M+lZW49uRjCT07Zvmr7cXL/bFjdJR7anDABwsH+iZE2JsFl3VOP47eLhOkqhMZ5W1
	 oMHfioaBbedfA==
Date: Wed, 21 May 2025 17:01:53 -0700
Subject: [PATCHSET 1/3] fuse2fs: upgrade to libfuse 3.17
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174787197833.1484400.960875804610238864.stgit@frogsfrogsfrogs>
In-Reply-To: <20250521235837.GB9688@frogsfrogsfrogs>
References: <20250521235837.GB9688@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

In preparation to start hacking on fuse2fs and iomap, upgrade fuse2fs
library support to 3.17, which is the latest upstream release as of this
writing.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-library-upgrade
---
Commits in this patchset:
 * fuse2fs: bump library version
 * fuse2fs: wrap the fuse_set_feature_flag helper for older libfuse
 * fuse2fs: disable nfs exports
---
 configure      |    4 ++--
 configure.ac   |    4 ++--
 misc/fuse2fs.c |   35 ++++++++++++++++++++++++++++++++---
 3 files changed, 36 insertions(+), 7 deletions(-)


