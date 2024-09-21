Return-Path: <linux-ext4+bounces-4245-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A18997DB79
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Sep 2024 04:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107211F221DB
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Sep 2024 02:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9212B94;
	Sat, 21 Sep 2024 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feaEH6U4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3133C38;
	Sat, 21 Sep 2024 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726886204; cv=none; b=SbcEyHXCZHkjUpQXffpPj5vMFzbgLEfFVBMbG1vDWczNbQD+Y3K1vUFhENsSsQtPUUuT0yvj33PI4X3FpoY7J7J0W865KgSYUi8713FYovXfnTdoFuasxLc9W/Txd6z3JdgNHa0dr7ITZxknytNjHRFcAjSKqXOFFeM03s4X4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726886204; c=relaxed/simple;
	bh=nqgLqzUUz9L5s1dT4jY6tE2dFCqJpjuTgvQsbZs+sb8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O9mxWdHq+5LToqfFG6zvPtytxI6WrLX4wYOa9GOgvt0tmhn73ZRPTkdydMeuDUkCfwkbijZE7ycUhaUkMPUMmJLMhteFkZlaGd1eQ8HLX3maBmpITydVCMmTAEiWmgwkboAojSmykx7/fcUW8m6wH0SNVcYqiE3+dpR3x6GJ8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feaEH6U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC98C4CEC3;
	Sat, 21 Sep 2024 02:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726886204;
	bh=nqgLqzUUz9L5s1dT4jY6tE2dFCqJpjuTgvQsbZs+sb8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=feaEH6U4BL7FzVoWQniZTqb9WHgrUoU2xNyB5joct8Aoo24vFtpCSaoO/FR0GPmg2
	 tTYxvhA30yTWD43l+pvF4d1S1+46rGXSODzKH05DPzXGW1AZe6MvWEQEV8bEE6y0Xd
	 bmCkc6GNyeHM7b7dBxf4IfN7h0d6OGLDE1QnIGkNM0p+/PAqlkbKQ95zZxcjGtr2mX
	 tS8WdxHj53uznAHT7PtMUbVmUp9rToZijmKtHpGkC24etMvotayRFkQYMlKNXftpa4
	 XIlEYunXneKkUUABpRiQI0ON+ssSco+g2vpWqN+JTe9ym5NRzGZuF5JdDDNIeKVXUU
	 DfFFazl314g3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE20C3806655;
	Sat, 21 Sep 2024 02:36:47 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240919123848.GA1969831@mit.edu>
References: <20240919123848.GA1969831@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240919123848.GA1969831@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.12-rc1
X-PR-Tracked-Commit-Id: ff2beee206d23f49d022650122f81285849033e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 056f8c437dc33e9e8e64b9344e816d7d46c06c16
Message-Id: <172688620630.2370754.15906543814828823915.pr-tracker-bot@kernel.org>
Date: Sat, 21 Sep 2024 02:36:46 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Sep 2024 08:38:48 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/056f8c437dc33e9e8e64b9344e816d7d46c06c16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

