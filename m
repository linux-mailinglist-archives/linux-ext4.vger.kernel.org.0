Return-Path: <linux-ext4+bounces-9249-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F98B175D4
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Jul 2025 19:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7111C24045
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Jul 2025 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B74241663;
	Thu, 31 Jul 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdGfTw7M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342F320CCE3;
	Thu, 31 Jul 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984467; cv=none; b=dLy0QS6gRfCIQQ2PLdubWglfNNyr9wnXujpzPI6vGU/dzw8shj0iwzdX9u0+OxzucolS77w4Amo8cOgFCJ7lgupvYdBTa2YqG2wn2xI1SwquB/Ywf2FFtFCuQMW60y9S079IYGwAqz0jFZv19Cd1s7uGcolzYAt9msBgXMyeetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984467; c=relaxed/simple;
	bh=0tDZ4isx6NrWy8geu7bFHzs7emByQouK1kS5eA9HJfI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WzogcLOwNDS6ioFxbZab9+Wcmsf7MHtqdTahI2ILBvEtywjUxwuSiTSUARlTZajm57hK1oa0KCOR+Cwubh9L3GCnu7QAAyRno8dKQYtysivCFrSU+I0fdfwTbbZ5pN+8njt4L/obn8VnWD/6dvbXDk4x1v9iSH1Vv58s5tcRqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdGfTw7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1772BC4CEEF;
	Thu, 31 Jul 2025 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984467;
	bh=0tDZ4isx6NrWy8geu7bFHzs7emByQouK1kS5eA9HJfI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fdGfTw7MFDQ+fLzdfg/xc4fH5ODQ1B2iAHltqtOfNb59b88O1bM9DCoOPgq2heQ8L
	 QwtpZOTNKkpeRKBdwpy/nAQz1oIDHf6qOc4bfuinxu207JHivqb4U3kYSUzIe451p4
	 aABJk9oSOOqYseLRPZ0s5KKuMva1WhM99lwmyFzz9Tbt6tVSzAS3CP7ivUQj0AjmqM
	 Kifo+34uwt48GCTTBsy3UT5HcKMC1Njq67HHFfULBDo+Op0SS/EVz4FXRD4SDtG5Hk
	 FPFa4qdqJf6VfrLSW0BxczRF4mruojsyAGtBgQKJUT+dGUXJSlQjY0cxlOo+X4uewQ
	 VYa7d5Qi2iSgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC9C383BF51;
	Thu, 31 Jul 2025 17:54:43 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 changes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729033748.GA367490@mit.edu>
References: <20250729033748.GA367490@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729033748.GA367490@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_6.17-rc1
X-PR-Tracked-Commit-Id: 099b847ccc6c1ad2f805d13cfbcc83f5b6d4bc42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff7dcfedf9b1c34d9d06588ced4aa588b6444c59
Message-Id: <175398448244.3232013.16996613778070734265.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 17:54:42 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 23:37:48 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff7dcfedf9b1c34d9d06588ced4aa588b6444c59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

