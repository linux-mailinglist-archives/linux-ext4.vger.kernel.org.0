Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D0734354A
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Mar 2021 23:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhCUV74 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 17:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhCUV7g (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 21 Mar 2021 17:59:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2F4B661943;
        Sun, 21 Mar 2021 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616363976;
        bh=+hUe5tocz/fAp5Edahbuy+pW7jeUHfZR12RM5/HntYk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pXYc+9VSVK0G9x91CbXcuiowUC3sml01pcLdcNLy4VZsjGvgejPf57pAA0C1m5mh/
         HzkN/+/9Fs5lBgIKG/kM7+lKF82AEtjIaoiHdg4UDwaf8+Xis03aDaoygsa3cdTTyx
         mr4tGlgzgyc+gFopiDuKQMcw5YOSvNGT13j8D7Ahhau3i1U1D/2Wyl8VB+DDuMHE31
         Rp/3DTONqEtvlJZQx+hOHEgIYzH7IeMAGNiiEj3JNCL5PAHZPQ3P/pgOP1NbrH32b1
         78xmjFt0BunBID+3UIyVQSdM2birEmX/KV681bFpW+C8PPPPnWP/NLKrYYUtbKzVL6
         Gx1gLyw4WuMYw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2101860A5B;
        Sun, 21 Mar 2021 21:59:36 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YFeQ9eBFn5JELyYo@mit.edu>
References: <YFeQ9eBFn5JELyYo@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YFeQ9eBFn5JELyYo@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 64395d950bc476106b39341e42ebfd4d2eb71d2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7f5f1bd3c240c4d527c0871a38dc3d61255ea9e
Message-Id: <161636397607.4823.16885662605201776739.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Mar 2021 21:59:36 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sun, 21 Mar 2021 14:31:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7f5f1bd3c240c4d527c0871a38dc3d61255ea9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
