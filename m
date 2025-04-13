Return-Path: <linux-ext4+bounces-7226-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB780A87250
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD31188D2CD
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210181DF721;
	Sun, 13 Apr 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8D0fbEc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80DE1DED40;
	Sun, 13 Apr 2025 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744557356; cv=none; b=ZcmzGoMQwjDzTdW8+3OL/GNKzXQeRMNsyiCYocSiynAWWgRMatMbtRYbId9Dail6xutHPwJ1+LGojMZRa69aR5ZJXanUxaK+a09faJH49WCjzev+GRhP5YHU5E7L47aSd3+Vk1jvVWkKmOV52fnuHpTdqO1FwYdehbRrvSdFIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744557356; c=relaxed/simple;
	bh=tdFp4ZhyefyGZczwIyEI1rrrD7oBCM+pvPKylwTkiwc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rFEvJgT8ebZFeOnlKCsGKtaxadPTyeT9ieQZoUMGGi0v3Jy/2SCUCZDlmLtWvUOr9qWkQt4w0lyKBUwjlZGAz+4tGBMOvwRIvNOI4UPP5bNXB1M8gliuVQi8e3Wg2cKWANztaFb8sUQZOI3apiEtvVBE0qN7R3NnTNvpDILl6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8D0fbEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC9DC4CEE5;
	Sun, 13 Apr 2025 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744557356;
	bh=tdFp4ZhyefyGZczwIyEI1rrrD7oBCM+pvPKylwTkiwc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B8D0fbEcVCur/vfCJf2mLcoGonvthAQyrsqezAifDvUPMMcxOET7uz8dRcDNx3niL
	 C+rvlQTsAWaZVz8hq+jCdrNfZWGEsUid72hP2A0FIIA4Os+EqhPO5YNHNwLXDc6mac
	 EYbSTP3vhrozgztkhhLp39PAsPKRcblffFLYe0uyNvBKIX+FEJiCpu/eDWXzxRQO1f
	 RYnzn/yOazPqvbxrULBGUs1jal/UmcHCf26Y0tR/UGTPZk4c5E5C014y7h4TuViVRk
	 PAbkRzjGjw7ws4BBPQRYehwdXnq3WJHnoN6jkFSsElMPjBcuxuIhttjvDSDqNzuHos
	 hSxWIpe+q5kSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0638111DD;
	Sun, 13 Apr 2025 15:16:35 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 bug fixes for v6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250413123737.GA1116899@mit.edu>
References: <20250413123737.GA1116899@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250413123737.GA1116899@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.15-rc2
X-PR-Tracked-Commit-Id: 94824ac9a8aaf2fb3c54b4bdde842db80ffa555d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5aaaedb0cb540cda1cdcef34f2d30de67d972d9b
Message-Id: <174455739381.916719.14663401496815104739.pr-tracker-bot@kernel.org>
Date: Sun, 13 Apr 2025 15:16:33 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Apr 2025 08:37:37 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.15-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5aaaedb0cb540cda1cdcef34f2d30de67d972d9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

