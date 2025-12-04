Return-Path: <linux-ext4+bounces-12150-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B182FCA25BE
	for <lists+linux-ext4@lfdr.de>; Thu, 04 Dec 2025 05:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA6B53086E93
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Dec 2025 04:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0385312814;
	Thu,  4 Dec 2025 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7VE0dvw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CDA3112D2;
	Thu,  4 Dec 2025 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823884; cv=none; b=koaBpEu2wzzAxW4IgD9rQwl12Fg0TmjkVMmmaVAw0/sTZ4CLfVKJ1a6Uid0KWIinLbGpB7dJ8vdQ0XkGFZyXuLEbqLt5eRPpD5uj0KmZ3DL4Nv/rtJm1hf6PLGBq8+6mdDkuZ/fmXaUC2LYCcCqTtMNVHIBOQF6tdhBwr0lSfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823884; c=relaxed/simple;
	bh=r5u/tQUgRVoyIWZqVaonmFKLkbSYOyIOTGwueW2Dln8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=thv5oBu9zWRvhDsDWcPJGpt2S65wGKpBUuLXTauXLaAoJfZVhtjM4Emq3Vqk13OyyFuc7nzTcfmxIwafqRNeWoDe0xBmmKifievs3t4tSMBEXU1okvDp6N99rSnjkQ37H8aKKQUjN/Jmjy9lfyxnELemEArGRTImB6byMwUG1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7VE0dvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB8BC16AAE;
	Thu,  4 Dec 2025 04:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764823884;
	bh=r5u/tQUgRVoyIWZqVaonmFKLkbSYOyIOTGwueW2Dln8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Z7VE0dvwOgcXEwftXzApzxdKyUymPTtLlD7PNLWDPSpvD/pTTv/hBvaAopbCGqMAw
	 JrBetpbFbJunSBAyQQ5J/hnqVaJtw2Z8TnoDttg2OCjRIngtdRIAFN1PCIKZp1aii4
	 KDmWEfqbltQyjEX4OQadZQzr3v62b7NIIMP4kczSgH/wwb5Ml3MZm9PYxcOuU3mSga
	 YAhl6O9pg3jRBd6tSTldmdoIp4l7biOlHj3UV3XauaDGwin9iPB3UJRNCqRu3A/2Bx
	 8s+GRNpc01b5O/qT9fh2s2h11z5+bNPXPG5WsCGbMqGP4mdGm+t1HfZoI8Ul9e3xHV
	 taCtKyoATCeyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28C93AA9A8A;
	Thu,  4 Dec 2025 04:48:23 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 changes for 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251203043228.GA1712448@mit.edu>
References: <20251203043228.GA1712448@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251203043228.GA1712448@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.19-rc1
X-PR-Tracked-Commit-Id: 91ef18b567dae84c0cea9b996d933c856e366f52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbeea4db51a6eaf62b4784f718844726dd2199b9
Message-Id: <176482370251.238370.2865013792691489071.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 04:48:22 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 2 Dec 2025 23:32:28 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbeea4db51a6eaf62b4784f718844726dd2199b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

