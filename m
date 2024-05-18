Return-Path: <linux-ext4+bounces-2576-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B12F8C926E
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 23:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EF21F213B8
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573E6BFD4;
	Sat, 18 May 2024 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXhns8xk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F6B6A8D2;
	Sat, 18 May 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716067323; cv=none; b=RFHuX4Eu7WwJlZgdF23rVv+1mmZ+N97TfHbMwDA8r63/Z6UlbV8kr923GuMlmeOF3HCurJjKNaik4cn6zM94m5pwZjY9lO/rwqTGssrrCJSe2WSA/C+n8PKaOba4kyNWTJOr+dcvq8KewRoXABeXK3No7/eau08eQVtSkaLPB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716067323; c=relaxed/simple;
	bh=w2MSsx4AtkY4WGN2jjRrBiv2LeqNsKokFam2uTVsV4I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kye8x2hbYZeYiPY2shZxwsdh22cijiplTqbmQIx8E000KBHF8goajY4ZDrQpPcaEZ3P9yTwJOOLXw9UTFrHNU2JijgpbSId+mcbOpK3qTYDotDLtUugTM6PwQ8sc9Vnb72ithMosS0QiZHg2zIDtdmw7GOUjYvtJDTDpXDJ19Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXhns8xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8421C32786;
	Sat, 18 May 2024 21:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716067322;
	bh=w2MSsx4AtkY4WGN2jjRrBiv2LeqNsKokFam2uTVsV4I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sXhns8xkb/ebuV7iqPlYmy80yaSw9QSqDPbqLtR5VBIr8GdA6kVqyXFWVpNfOFn68
	 ZXUytzTwlb3CfGVFz9IqR1+BQGGShPohLkStdJtOWwSpptc6SGoS9/ikeEq1bcxjJg
	 BEtgGvqvDY1mUlb/zxmsjUSGV9hRTk5BwJw5U4JbMOUMqOa/2zHUjBVmIM7cLBpMK8
	 lGp5tmEoPNJh5VPcd44cu6zvWxLAfncgP98k/hDmL9OlEDjY9vubRGJaB1MMAXhwu/
	 ELt9IElFwaZ5wFaVT/A1iG8rJfUtVs8nk3TsxOPB/8VTm9QJNF7bhX0fGxCrj2T9n/
	 4kqieEcH8/ELg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDE02C54BB7;
	Sat, 18 May 2024 21:22:02 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240518044601.GA478319@mit.edu>
References: <20240518044601.GA478319@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240518044601.GA478319@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.10-rc1
X-PR-Tracked-Commit-Id: c6a6c9694aadc4c3ab8d89bdd44aed3eab1e43c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7991c92f4cc50b971fcb4d05087e490dc47a6857
Message-Id: <171606732283.14195.6977441195801310395.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 21:22:02 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 May 2024 00:46:01 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7991c92f4cc50b971fcb4d05087e490dc47a6857

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

