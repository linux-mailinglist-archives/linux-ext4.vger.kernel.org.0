Return-Path: <linux-ext4+bounces-266-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891FD80153D
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 22:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D1B1C20C94
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA15915F;
	Fri,  1 Dec 2023 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8DIkHTC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65502262B6
	for <linux-ext4@vger.kernel.org>; Fri,  1 Dec 2023 21:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC2B3C433C8;
	Fri,  1 Dec 2023 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701465710;
	bh=hf4OKrBksOs2WQ/NyThSMufKPgJTvcsE4gI85L+F4hs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g8DIkHTC1oPNyHE9RRrLE8EiYSEL94DttJwo+k9RFj1uxFwYonLAar/8zIWWpdTQN
	 7S//1EXY7gTZ55jntE97WMx/A16kM3gPuGPSpuBjxU1hxzHn/pqPAfN5jgaZoBrraL
	 NPeU67aVYNYYZ7YbLWLCDR6Pqd5ViTv1qN04YpEN24E8AGFMb0BYYSxm8ZospaIKGb
	 IlYMm+wPPVdJ8GJNKabbNs33xegDR4nEv03mDuzfpaPWCmaDts2JtuMxv/bC+J9uZM
	 f4KypPeSfVBLedkWH2TTdwH8ltnoIgp8zxN9Apmq08Q8nPenZJWcidR2Uaaz69WnIl
	 z5gmjR/t+pKeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C907FC395DC;
	Fri,  1 Dec 2023 21:21:50 +0000 (UTC)
Subject: Re: [GIT PULL] ext2 fix for 6.7-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231201100610.p52r4qm55v3rbejn@quack3>
References: <20231201100610.p52r4qm55v3rbejn@quack3>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231201100610.p52r4qm55v3rbejn@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.7-rc4
X-PR-Tracked-Commit-Id: 8abc712ea4867a81c860853048f24e511bbc20f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1c09da07c550971a1764a113963533dcc8e4d2a
Message-Id: <170146571081.19100.17643329753793770144.pr-tracker-bot@kernel.org>
Date: Fri, 01 Dec 2023 21:21:50 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Dec 2023 11:06:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1c09da07c550971a1764a113963533dcc8e4d2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

