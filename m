Return-Path: <linux-ext4+bounces-9393-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AABB2AE66
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 18:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486DA580A29
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9F2343D72;
	Mon, 18 Aug 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF1DYXbk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1F343D63;
	Mon, 18 Aug 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535202; cv=none; b=VMTYDtlEnbQXTSSyEyfBocrkjkYfaKAro9TkFCj3xhgbvMmUN+DdsYd/N1qUH6b9u8H7B5/EdSYSqr1+Wk5WkaMWl60PDvQ+0kmyQzUg2+L72kS6R5yHF3MdG2B3HM9ZZuomAYavKM5fPrcdUEdu/S2NTXZWu/3OYbYOxNkh8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535202; c=relaxed/simple;
	bh=bShpHH3uhC/GBmamLJt58CgFM/xvNSjJ84riw1GuhDU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XA5DY6vJFUVvIUjp9WRLzKEvy2L1QLZDT6JCjpWCLdh6cx0f/zz8l+vB1xQoPIbFMW2eHTsowHK7vpQ9nkBBgfbHvlhlENo8N1vNCvjdmnmH+6NE/uIlT/z/VNXSQaQRqA5z+ONRzajDVAQiDkw4VDFd51VWDBxGXcmJoAgcw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF1DYXbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDA7C4CEF1;
	Mon, 18 Aug 2025 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755535202;
	bh=bShpHH3uhC/GBmamLJt58CgFM/xvNSjJ84riw1GuhDU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iF1DYXbkk+aZNmKlHCN++q5PtiZeFoLaZKanEj0GkCjUNGy1BNh7znwy6mMOC0bVF
	 t83vCZlO1MkNcOdA04+74fyR12/A4xpnZ8NMhjJQEQl79ycOo3y3V6CbvXPaIzitUb
	 onY3yXvFBgrvzfJQaBne0OU1lNBpcDwr0Arjtm4ejfo1QKJJLvs52LAklmbpyd5dcj
	 RGo2EQpqMu7tuWP2ODDj7Pzv+hnEI9HpNczzHe4Y5ofM5iUxjXSyLLDk9ulJ/aa7hY
	 InuTuBmXK2iXPm1Be+dwXRrzkOmyeS430vMQJPDuC1LwoXbJ5WWhv0dHnvAKSC1C3Y
	 xdw99e2OBlHLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5D2383BF57;
	Mon, 18 Aug 2025 16:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 bug fixes for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250818115647.GA1217293@mit.edu>
References: <20250818115647.GA1217293@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250818115647.GA1217293@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.17-rc3
X-PR-Tracked-Commit-Id: 9d98cf4632258720f18265a058e62fde120c0151
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 074e461d9ed5bbd393a76ae42caa2a5a55add23b
Message-Id: <175553521251.2821944.959930811606865325.pr-tracker-bot@kernel.org>
Date: Mon, 18 Aug 2025 16:40:12 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Aug 2025 07:56:47 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/074e461d9ed5bbd393a76ae42caa2a5a55add23b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

