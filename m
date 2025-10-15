Return-Path: <linux-ext4+bounces-10884-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1928BDF464
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 17:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2DC19C15B3
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B12D7DED;
	Wed, 15 Oct 2025 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8YdF2oi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BCA2046BA;
	Wed, 15 Oct 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540880; cv=none; b=j62xgUx/mDGp0gFpYdzZduONCF3S0WgLwWaMOO91KBgLKTE0U5UmiBwzDJsn1xVC7lO6amy/3dRDBlpqCSRV+Bp+2LgQyMDWKWkpsa58r3rocyBS68Pm7UdFX3JodQpynOqwR2PU9B6c5HZ/U46LCsSMEfhuoFESQbklgun0/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540880; c=relaxed/simple;
	bh=mfGYqBWMpy61FLzM35bGAz19zpqDlWoRSurCanrcS5U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hKRfQzxX+jhPMxneMr30SoV6KiNbbgqCYEc7tnAsKloiShGrRw5p1PykQZg3vFcynoECAqZ3qyU+VvBVBQK04MTD6WdSKABunsnOWMtJTGmQrDXqcx8UUiJMcym8X8mb9W20WEGG/iu984T9gHjTFLmVXERUwZ9+ImjNOmYdXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8YdF2oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8B7C4CEF8;
	Wed, 15 Oct 2025 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760540880;
	bh=mfGYqBWMpy61FLzM35bGAz19zpqDlWoRSurCanrcS5U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t8YdF2oir/rrBO+nnneU+G5C6K3tnLVbl3+vB63wxK3oG8QXd17BLZQ40ynh+XW/g
	 oc94USIlkuz8e8vmgvFlp0xeTJWjK5E8jDr/lFMZE9rLtHr8SUged84gjwxvzy9s74
	 ks1iXfEqWdOwqq0xREOggFBXF+l9LSANPdXKjv9dtzAzhoMOYHoaN9KitliHNbrppp
	 sUJ3PeXwJougzGVvbT6Rp6qorZzQYiqUYCDScWS5YUBZqny+xi9WzgKUlHXuIyXELk
	 4QPN/CupfJvsinVquMdd0TVyt1nvIg+d+GkYQjtcn3IqJX0uAfL76w3CvyAApfn0Gk
	 LM2pEnmTzpVkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343C3380CFEF;
	Wed, 15 Oct 2025 15:07:46 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 bug fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251015032810.GA780453@mit.edu>
References: <20251015032810.GA780453@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251015032810.GA780453@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git ext4_for_linus-6.18-rc2
X-PR-Tracked-Commit-Id: c065b6046b3493a878c2ceb810aed845431badb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66f8e4df003e61b72fdc794ed0ec8378d74a9a4a
Message-Id: <176054086468.913671.17001476697419747013.pr-tracker-bot@kernel.org>
Date: Wed, 15 Oct 2025 15:07:44 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 Oct 2025 23:28:10 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git ext4_for_linus-6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66f8e4df003e61b72fdc794ed0ec8378d74a9a4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

