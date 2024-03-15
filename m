Return-Path: <linux-ext4+bounces-1668-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A777687D29D
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 18:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA911F2322F
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03104EB51;
	Fri, 15 Mar 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd/8PL+F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179794CB28;
	Fri, 15 Mar 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523205; cv=none; b=Ma/MdcdOz0AOIBJPEYaF3AhfU4jme1wL0i3Cfg9CTF2IUuSEifCrZ8hUpBrRhQOZrxivZ+GaaKHYQ5oOtuhCNNWMb5ZtyUT0LkZxbOj43Iqpm01Nx+9GiFOvh4Fb2oFGwhVtofB0EuEMSPW6PB6tcZb+cjXSz3NfNIQqoYChhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523205; c=relaxed/simple;
	bh=8FwTLU0EGv9cT5aj/hVZtvmH1kY+dgW2IHCJTRUQ8Dw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qFnwmXAAL79Hh0RL+LHKdxHk7ir4Ru5mk4mBgOQf/3qd4zJNMFjE2/Jy2s0AzRqyRrI+jvxbXOjTwFRwjw+a0RJbZDHH365hxGZaMXBLd/TZ6E+FQy3LDVQCAgvJNYIIJp5hK+rcaWLqOzlJ50WmkOwoW4g8x/sIQRRn4jnQ1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd/8PL+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECC0FC433F1;
	Fri, 15 Mar 2024 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710523205;
	bh=8FwTLU0EGv9cT5aj/hVZtvmH1kY+dgW2IHCJTRUQ8Dw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pd/8PL+FM25TKRPBSu1EDymx43QA8IcWVMVkbtrJYg+9VcD7QA8XcFYTtrGeLtcw/
	 egQ2k382zt9nLChvh1k3vi5VhzQAjewsNSRWHPmV8yg9D0zpl+IiVJt2LxrV4D9FaB
	 9h8XYtKBTJvfmJls/el0lXQsZYgeiDlFgcrDmJ6RmdzmPN47Xu7HrVW7jYRH3HMe42
	 9qwADjpeoTbPJ+jjgcsRw+DjB7gYKxOKYwKOuu1C4mjEBHwCfQvdq2Gk4pc6VTXZpw
	 VD5qhGtUeU3bpoDaG25cp3l0hjOMlC+pyCi/8N6MCUkbvVfpkS5UbAX78AlqxeCvW/
	 op8XG2tGzaABQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0BEED84BC3;
	Fri, 15 Mar 2024 17:20:04 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240314035609.GA856050@mit.edu>
References: <20240314035609.GA856050@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240314035609.GA856050@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.9-rc1
X-PR-Tracked-Commit-Id: 0ecae5410ab526225293d2591ca4632b22c2fd8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68bf6bfdcf56b5e6567a668ffc15d5e449356c02
Message-Id: <171052320482.31681.10945127470133257665.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 17:20:04 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 23:56:09 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68bf6bfdcf56b5e6567a668ffc15d5e449356c02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

