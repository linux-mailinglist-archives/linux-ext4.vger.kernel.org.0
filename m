Return-Path: <linux-ext4+bounces-6998-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA1FA73F7E
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 21:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C8217243F
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 20:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D91ADC86;
	Thu, 27 Mar 2025 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2nuukJ2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25A1DDC15;
	Thu, 27 Mar 2025 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743108505; cv=none; b=Kre6QWDZTSEmECsXyAC/ZAzY0g9PUVzYF5H0/QIKAODxN2VahvMt9PF6jcCJfR6x1d2llpx8H+zGgQmGrHjIHmlchd9kwj3Ka8cpQ4nqBT7kjjyF6gU/iY/iF+MyE3n3+l+yIvXPjZ93YB0Q89zy5N9Px5X4VrTlXIJX8jHcJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743108505; c=relaxed/simple;
	bh=JbTtSR3WwBPRNVp5urqU+Vuc+zE9jbhe05PEJ7Fy9QQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bb6CiQwOe/PgLWwGVEZvqawaQlYCqVyJ4HMeeKY8Yc4XSXi6eAbnWeaKXKDtCH9VvB1jU/3rRAmwHJNJ3wsekr2/PlbzSXtWKNv6szrioxK7eHR35xCt5r471vAa2lmEGeUlFRqyl+Tl0kdI+z5iy8zT+kRRMwfG16okRqhn8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2nuukJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5773EC4CEDD;
	Thu, 27 Mar 2025 20:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743108504;
	bh=JbTtSR3WwBPRNVp5urqU+Vuc+zE9jbhe05PEJ7Fy9QQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U2nuukJ2SZNvCTq62iya3QpIXABb6ErHvEgkYwwv3n4ah76F4hVeNuI7YCbo0TXab
	 3nPt4gCDQI+xQkQgqd0XXE534QCl0JPH9MMjpfbryggJFJ8/L/vRWKu9VC+i26ci4z
	 2f2k+ZDJL0c0PyZdPS1/M2c9w5mbq/dkdtQ5IOxaOr0yNvfBnMhXxoPWgAm2u9xWmL
	 XuPD4yPWcpcCx0h676PrCJJvYVaIO9d3v4CaBlRgBkXb+f0JCYR5vHbac0RT6aNTp7
	 h9qmbTiML0XHEOe+O+e9uQUpS556k3vBw20KpE4bExzky11GYdWxx7++GAEUAadhdR
	 bI88zRwQciEMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB629380AAFD;
	Thu, 27 Mar 2025 20:49:01 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250327164029.GA1423119@mit.edu>
References: <20250327164029.GA1423119@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250327164029.GA1423119@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4-for_linus-6.15-rc1
X-PR-Tracked-Commit-Id: d5e206778e96e8667d3bde695ad372c296dc9353
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c2a430e85994f4873ea5ec42091baa1153bc731
Message-Id: <174310854061.2212788.5577406304130633182.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 20:49:00 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Mar 2025 12:40:29 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4-for_linus-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c2a430e85994f4873ea5ec42091baa1153bc731

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

