Return-Path: <linux-ext4+bounces-10629-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB22BB834D
	for <lists+linux-ext4@lfdr.de>; Fri, 03 Oct 2025 23:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4BEB348BC1
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Oct 2025 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AA8267B12;
	Fri,  3 Oct 2025 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLZacvAZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C172F2E;
	Fri,  3 Oct 2025 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527167; cv=none; b=RPbz6uvXxPMwe4iN1qPxVWKhcj1keqh1Z9aFneLYiJztNb4ej7t3UQhgTFbkJTDU4aa7+h5yT3YeSCqWJNUQsnm4RBilKeevh3iyqH4LIC9eLwzycVpZIR9PDilEm1C2JTx1VYGy5KpJfI/o03Mp7CpQWrt2MzusQ9mIPTauKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527167; c=relaxed/simple;
	bh=OKX39z+gOiEx++lW8D1XlMDxpbQ0/RdGSxIOaZ0Oq/Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CNvBNv3wr0VplqKNmYEp1flWpVkj9cAUDMu7Zls0kPZlh5NisRngYkDNzJjiR3c0UeM9ocTdfkAHu6uzHBwTBkR82CWDC98MsxhCJo3gURdp3V9KKf+5yoe30kOkJWyinkzyCPTZJpkfNoYm1CmRwI+RxQy7nhhXNzbIfTq+DVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLZacvAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A16C4CEF5;
	Fri,  3 Oct 2025 21:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527167;
	bh=OKX39z+gOiEx++lW8D1XlMDxpbQ0/RdGSxIOaZ0Oq/Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LLZacvAZN97U5eJ/bvCN/YDHUAJfyozEG8VIL8ZQ+CfdxIKfhCy6nj9Lm1uHbIvIm
	 87mJoeG7pW64K6o15qzY6t3Xmc1upl3UTxp+ahfoaVZOBJesscEVYvf4M12ep8IRk3
	 tS/Crw39DZGpkXAjq/ANbhBfaZoS/ENV6oI2ciGhfdGm/ZIyLCb738hX3j4w4q36Y+
	 IMuvzQ+fIH567RqfFooxNCSmptgAXQWjTlTO4aa+Jh2Vte32bCnbPt68TAGTccrham
	 op/1tnH/vNHPDdxCaxyRMfOnQEYVQurIhlCPMk7dU9WCzF+/x95G1z1y5DuXdVfaRI
	 hDFjLFcNwbD2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF4839D0C1A;
	Fri,  3 Oct 2025 21:32:39 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251001025400.GA333371@mit.edu>
References: <20251001025400.GA333371@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251001025400.GA333371@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.18-rc1
X-PR-Tracked-Commit-Id: acf943e9768ec9d9be80982ca0ebc4bfd6b7631e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65989db7f88456273d0913d8d21f6097fa6aad19
Message-Id: <175952715854.86168.4537294494685404824.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:32:38 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Sep 2025 22:54:00 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65989db7f88456273d0913d8d21f6097fa6aad19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

