Return-Path: <linux-ext4+bounces-8830-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5FBAFA72C
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E141318913DA
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC2D12C544;
	Sun,  6 Jul 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6ZFC3rP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A11846F
	for <linux-ext4@vger.kernel.org>; Sun,  6 Jul 2025 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826656; cv=none; b=uiNVUlFkb+HW99VQPbADJhXbvDnK29abApwxdoOQdY/nHdwkOsam7KkaiDJyPK4HBy9xq0+6RGKHz4QBTf236bj/DCeg74456sKt3T53o4RDaHzsFW/lwPNAwfDCZ5uRd11t3l07NnshIy6uOOaEL4B/h0ftO8t2ufklqLoxOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826656; c=relaxed/simple;
	bh=EjHo7bsSc7WwqJgw8bkcqmc1WEm6O/DRDJDbmmNvCik=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=cQbj8cAdVGXOeFlyXphB284ZUBE0N4QPRJeJ3f1fqgqdj8spg2RCxuUtDnuHNehVXkicGnaS1RxhlyxQZA8u4nAe2ujUg7aTezMF5zj0r1XmCNxBV8wbmU+lVEWxkVcU1NljWYsDsP/Pi3W5MqUizTDYN8njWhdnAhjo/Lfo030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6ZFC3rP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461A8C4CEEE;
	Sun,  6 Jul 2025 18:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751826655;
	bh=EjHo7bsSc7WwqJgw8bkcqmc1WEm6O/DRDJDbmmNvCik=;
	h=Date:Subject:From:To:Cc:From;
	b=f6ZFC3rPyDo1XBbTQbjFgF3Owp/v+ootni3nQwddTuxdWpWEd+7BzZqcl1g7qbBhg
	 V5IdBLmYdxKGU+//HVBE4ZXjTB5Nf7NXOPbiT2zIAgWHtIrvBTOCTulPMFzig87teo
	 yIIwD3BGxJFoUqyPrMEicDGjBWBRwlEA0G13I4QWQOmKyN9dyPtyOMGTrPJw22ze4e
	 jU641VvWJoPUmITGvNmB/KLTLTCtdHVI08nrilXjaCREN9T8x8olHGO3FmYSAt7ooJ
	 s+r+fRrYynZdIuD8rOj0QWpqTj7AwkAJS4z2sGGh5ypiWdEQ04vzPMuNKZtJWGF0XZ
	 R2vaRmAHD+aaA==
Date: Sun, 06 Jul 2025 11:30:54 -0700
Subject: [PATCHSET] fuse2fs: more bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series fixes more bugs in fuse2fs.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-fixes
---
Commits in this patchset:
 * libext2fs: fix off-by-one bug in punch_extent_blocks
 * libext2fs: fix arguments passed to ->block_alloc_stats_range
 * fuse2fs: refactor uid/gid setting
 * fuse2fs: fix gid inheritance on sgid parent directories
 * fuse2fs: don't truncate when creating a new file
 * fuse2fs: fix incorrect EOFS input handling in FITRIM
 * fuse2fs: fix incorrect unit conversion at the end of FITRIM
 * fuse2fs: don't try to mount after option parsing errors
---
 lib/ext2fs/alloc_stats.c |    5 ++
 lib/ext2fs/punch.c       |    2 -
 misc/fuse2fs.c           |  111 ++++++++++++++++++++++++++++++++--------------
 3 files changed, 83 insertions(+), 35 deletions(-)


