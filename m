Return-Path: <linux-ext4+bounces-771-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44E82A5F3
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jan 2024 03:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE761C22DE1
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jan 2024 02:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE64710E8;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3vekc8H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB15A48;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 469A7C43399;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704939846;
	bh=yu0/jadCE85BuoQBVb4J6sG7Dut+pXfoDwsR3ZfqTlY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N3vekc8HsCnPFOL8+K0S4GPiiFFkbAoTHq5tbov/0t1OruSVNNW9e1zaaUSawe32H
	 yFvEsXw+GIpaO9rEBc9w5pCXF1BIIznpNWvhfy9lOkSrRFIFV1DmX9dSwNlRb0o1Ni
	 rmmuv37XvQwszCI7DiE8vUjngLZWQNcRVhAaE+p6u4WGiXLox92Y4myuG1wWEfP8m5
	 nWnGE8EyOOcOfOMg1+/p3+F0P2u4+qzzNJ95zumBdvCzyuJlFM0ROehk4APbQ6GSwU
	 xRQFyB9BVVObS52tmEZQPPrL7jUkO3DECpn/N4xzZ2OHmuLq9AnHBSmsEGDdy6nnzA
	 5oOEQx2LwpBbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35F25DFC686;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 update for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240110203521.GA1013681@mit.edu>
References: <20240110203521.GA1013681@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240110203521.GA1013681@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.8-rc1
X-PR-Tracked-Commit-Id: 68da4c44b994aea797eb9821acb3a4a36015293e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d19d9e14687ff6f43d6c4806ace9ff682d7703f
Message-Id: <170493984621.10151.11449709295506142100.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 02:24:06 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 15:35:21 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d19d9e14687ff6f43d6c4806ace9ff682d7703f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

