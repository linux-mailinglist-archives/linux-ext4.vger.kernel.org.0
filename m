Return-Path: <linux-ext4+bounces-8211-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A63AC71A3
	for <lists+linux-ext4@lfdr.de>; Wed, 28 May 2025 21:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F1B1C01E91
	for <lists+linux-ext4@lfdr.de>; Wed, 28 May 2025 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B1221F30;
	Wed, 28 May 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCnnsdRQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F50221F26;
	Wed, 28 May 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461471; cv=none; b=TPOFIl/ecyxnyR6XZKfN/AM0zhOpOUWGMgiuLwRaRE4rGOceyf3rHbXsHrLsfpzmR2HVM0au5RMUdmOH2ol1JYCJAJm1Hx49f0j0pgHMXw31pw0XnWwEHKeTM82r80vzkOPsG8vl9NWH6MTnqLfpRPebPDubZTsyAmYxPH6v2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461471; c=relaxed/simple;
	bh=2VHIvGAt/hrHf8y1tWPpqdd3jYjPjQ6/YwGiPf5X3I4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oCUmLA8ydRWVaUiGjgO27NSsCQG11N5MFGa7agKgugqRxFZaw2OOF9Lr+90gyy0mnDl67to0kPMpIUbNkKvAcOiGfRqrwzn+R1iVW3/pCyrcLYzVcSv8xuAIUvtYbEvMUFAerVg88N9PYMV3nfOzsKdToVZA4qdE0gLjvyKzKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCnnsdRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DA5C4CEE3;
	Wed, 28 May 2025 19:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748461471;
	bh=2VHIvGAt/hrHf8y1tWPpqdd3jYjPjQ6/YwGiPf5X3I4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NCnnsdRQhvzb+3P5rCjAQEwyWrp8uo/8XP0tDJgX6LpVyprTMB3zh+jE8YE8zO/Jg
	 Y0F/vYqKtNNBSqb8QbiIis8Rcl/7WaDSuqnSrwNUu9/VekO2Bp6YnpkBbuOeZD0GLG
	 5jNBPVd1mFOfCGG9nTb5/yN9gxRCLdDWD0GgCJMfiRb9ihqXQmMKT5mh5jB+fQo/LV
	 noCCdmp0XnCD1VirW5km7NU6M81UZG/WiVlt27T00stGfGYQfj+QN4XIiCyE2BpLfu
	 oI/Yiih7qN+AGquIFAJcT/D3MLEem2w6QvpyZsJy8Rt9l5ZNd0HFzteI7bJz66cznT
	 lhsjNXodu1lhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCA3822D1A;
	Wed, 28 May 2025 19:45:06 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 changes for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250527200206.GA2433735@mit.edu>
References: <20250527200206.GA2433735@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250527200206.GA2433735@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.16-rc1
X-PR-Tracked-Commit-Id: 7acd1b315cdcc03b11a3aa1f9c9c85d99ddb4f0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d87d73895fcdbe6e45813efc473544433862364f
Message-Id: <174846150514.2536722.3328388038091912221.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 19:45:05 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 16:02:06 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d87d73895fcdbe6e45813efc473544433862364f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

