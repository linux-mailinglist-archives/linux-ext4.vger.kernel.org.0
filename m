Return-Path: <linux-ext4+bounces-5248-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB219D1CF9
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2024 02:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64439283B3B
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2024 01:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA03013B2A4;
	Tue, 19 Nov 2024 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dsmf+RyE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD761FDF;
	Tue, 19 Nov 2024 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978582; cv=none; b=iNdkeQO3bxzlDaKIgM78X7icUXGpVlrf5XrcczqWEsT9/j6d2ky3+PYwkoc/KatwPkuOboaH1uderaTLIxOxiRgAGr9Or2Yo5O84sXlzRHq9ffK8EoE/rqJNbFow5mKUwtcMp4KacNusjkM39Qxk6tIqmhLohx7TMkd93L9QG8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978582; c=relaxed/simple;
	bh=3Ovg+xUr7wk7SCYiXEQso8OnrqanQNE0b3DdDeR7h2w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TyXA64k2S7voYhYDkGtkML0Ss8aYb/rCtjdDWsf0kI5reqfqWvT+7VvzgzW0kUZJXA+IKvJ6MrHp1rehuw4kt7UsbjOX3JaR2te/s5t4DvIjZ51ZuHUTHAAp2a+vFhbZ6+u8M0ttt79u9NbJOP8TVewBtP5x5xzB2wxNRhpmtkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dsmf+RyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3B8C4CECF;
	Tue, 19 Nov 2024 01:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731978582;
	bh=3Ovg+xUr7wk7SCYiXEQso8OnrqanQNE0b3DdDeR7h2w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Dsmf+RyE23jzTUieOZ0NyFKz/7ZQikMOc/kF8IWihQI1sU+mHJHuS8TruBuq/QmR/
	 veapb5X9XE/VVYMgjmEdSArxAs5SS6CuWXGM7UZb1kNydfbgPH8rtw4rHD7DJ1e7nx
	 iSiLQokRB+QrXX9ui9acIlrJKx2IAYu3VwUWip7f2azbF1SvJ5Di5PANy5tcp8Erdw
	 WiqmM1ycfXEv84kH292raEzKOvBQuDj3MFADMufM76HKlwLhPQuNcERFx3RUiAtJdS
	 g7a4gEJYOnoyTf8jojNCsMOWLNpCeqKhqZ/2SLwmc38gjkxgM6opCIJdoEYgnV5P3X
	 DR6KFgrHTdR2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5A3809A80;
	Tue, 19 Nov 2024 01:09:54 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118123942.GA1745460@mit.edu>
References: <20241118123942.GA1745460@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118123942.GA1745460@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.13-rc1
X-PR-Tracked-Commit-Id: 3e7c69cdb053f9edea95502853f35952ab6cbf06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e7447ab48d101353c3e5be29e6ff0d322fa5a95
Message-Id: <173197859353.48692.5470864834480542646.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 01:09:53 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 07:39:42 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e7447ab48d101353c3e5be29e6ff0d322fa5a95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

