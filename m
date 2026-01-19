Return-Path: <linux-ext4+bounces-12996-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A8D3AB2D
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 15:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D55F30B22FC
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B345376BC2;
	Mon, 19 Jan 2026 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTAA4tpe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AE36A011
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831080; cv=none; b=iW2I+XzTKAIx3mVVj9WXoDpQvPp1nBbslOIp0U3PSTmaF6v5H9k7sAYIowsxnzbMTgeEj1AQ7xaqVcOnnifOLH/u2dpwfWz7llyfHk1AdMuYNPuACZuzAWhA4zx3flY/IpaHTB8ItjJjssjax/q+bsHtnVRg5jZZ9MQoBOvoLCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831080; c=relaxed/simple;
	bh=AbuW+jYTTrkArkTIgwZor9e1qua6mggGAHkHY+7MTB8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GwEwZJPUZNNRor39WcXGSjWgx8pA9xv4yBymq00eJM8QOc6GuNhGnxNIeVlyY3ZU3tTqLo0gngOCyceE2hDTtfYUt9XSUIqgPo12LOkr3ceMAskCIhVtJAt/aEevcjGrjfeDanvYMRR1/iLJ42bFQD9PelW1AP6FTIkEpAeOLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTAA4tpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C81EC116C6;
	Mon, 19 Jan 2026 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768831080;
	bh=AbuW+jYTTrkArkTIgwZor9e1qua6mggGAHkHY+7MTB8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jTAA4tpeV0FlMiyaZe8ABDuWlWkz/C0FRpNNzBujf2XHhSjnZRazCg+R0P/Ctjf52
	 FQTaEfdKzckADWq7gGU02CzYDwFytW0ubU2pYL9vVj2JX43vYNqFN0VGyP4rAwxl7G
	 j/Fm4j8rs+ZApgeg6p8o7xVPD3ywd1fBrxNfJggbu1fDd/RRvnq2xpKDm4gTkLVU1f
	 Q8cAhuDePC2wDRe1KUJG70xi1kBZ1F7QTzqSp3jAflt35gyGgYcLSmrx/eUnm66q/0
	 C8FF49P6xIyIKMrURMJLBZSMU9T0NH/r0JZl4J4DpTyGWK66ZSWN4CRW6CZrv7YtE2
	 lwHtvZ6Tcx5/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78EBE3A54A38;
	Mon, 19 Jan 2026 13:54:31 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for 6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260118165159.GA580401@mit.edu>
References: <20260118165159.GA580401@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260118165159.GA580401@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.19-rc6
X-PR-Tracked-Commit-Id: d250bdf531d9cd4096fedbb9f172bb2ca660c868
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8907398a6d941b204b90b6a40eecfdfd7d00c44
Message-Id: <176883087003.1423140.7406741107538361100.pr-tracker-bot@kernel.org>
Date: Mon, 19 Jan 2026 13:54:30 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Jan 2026 11:51:59 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8907398a6d941b204b90b6a40eecfdfd7d00c44

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

