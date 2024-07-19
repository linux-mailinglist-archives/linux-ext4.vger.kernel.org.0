Return-Path: <linux-ext4+bounces-3325-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2539371C8
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jul 2024 03:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBBE282276
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jul 2024 01:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063C415CB;
	Fri, 19 Jul 2024 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPf9E4T3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F818282F7;
	Fri, 19 Jul 2024 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721351083; cv=none; b=I6WSMO5xilNPafMFUfj2jkjX7rc3GY3ueQvJ0TeEB68ej7qNWPtEo1s9qasQzdp5fnHvXqnGXJidodXscjBBkRSJvk2kwSkx7n8YemnExUIeb17yrvoNwpQSOsD2eEKnCUMjgBVHrn4z4J5gfSjeEs9P33qPeZRGa7WaY80MK0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721351083; c=relaxed/simple;
	bh=CKH8wjXo/xgb3OnNXkgscUFcrLh+UFQO4BpL4O/sic0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ft5+TYFBFFVFT+s5YtJOr8x7VAYgMaD5LRVDyV7xFmK+YH5281uDi9Y5vOQ6QJy0PxhL3kgqU86k4g4hyE/pZQnct/k6KkeoKPLLqzOtdSzZklCz8me/vF2bm5yIrlVFnWYSDFTD2xXRwP70ONXySkrWsen0GFk7ri75pKS9dSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPf9E4T3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 629ACC116B1;
	Fri, 19 Jul 2024 01:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721351083;
	bh=CKH8wjXo/xgb3OnNXkgscUFcrLh+UFQO4BpL4O/sic0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JPf9E4T3EV5l+tbOmp17A46cY2s3fbRJABqDiXnV3r7JRyB9BeWNo4CX5oWvTn+Xq
	 Ll+0qAWSzhaLOSWpLbXRBzDItnGnazcw/j4CKtOfVZ8LdP2TNhX+iXEwCRttzU37EA
	 fvSxVrhxfpTt1OV3Lk54zXVsNFV5hsQdRR4H43Yx5ZFOkiB9NYNtImoT4o3Fca8BRI
	 ZTYTNzb5nTPHH04ONVz4mNqK/BixjEkVxYhEeGaQHp21ZAnYFj0zw84o55CZH1mfLx
	 afgQ26gkkfABwZ2XBxbF2Akm8mqfUAXfE/TSGcwuHyVzv84BlOQdyMEBKQ2hOaeEo8
	 vOsbzm29vzGbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5911FC433E9;
	Fri, 19 Jul 2024 01:04:43 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240718032730.GA2319255@mit.edu>
References: <20240718032730.GA2319255@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240718032730.GA2319255@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.11-rc1
X-PR-Tracked-Commit-Id: f9ca51596bbfd0f9c386dd1c613c394c78d9e5e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51ed42a8a135511f6d6f75b56e85e6586a06a93c
Message-Id: <172135108335.16878.3127819754984993765.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 01:04:43 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jul 2024 23:27:30 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51ed42a8a135511f6d6f75b56e85e6586a06a93c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

