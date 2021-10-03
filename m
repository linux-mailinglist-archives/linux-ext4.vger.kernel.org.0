Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F28C4203FE
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Oct 2021 23:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhJCVCk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Oct 2021 17:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhJCVCj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 3 Oct 2021 17:02:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 978B56134F;
        Sun,  3 Oct 2021 21:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633294851;
        bh=7n2xwObzoARYrQnvu603jRY3Gc2rfSAjpQmgTIXEUz4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gxQqmiE0x+2qMA75lmpCEJ269nUQssroDuRvYGYTjdygn19TSov/0HofUTefRK9n3
         F//+yGTBatCzmypxbyOXcL01D1jkLb93ezqBRsjtRuGKQ35p/uZlCsNAV8Pikcmd9S
         sSofW94VbpY5nqtLZg0MEuTyIfAqpDJ6TYrNxTbIN6zeg6pITfrRSt7r4CNpWPf54q
         C/FKUJQSNzODAVeMQhBmdiwYuKCQWf52/tvzThmksY/d+ycayjJ+jhaF2LUDBaub2T
         tdRkXhiRI96/L1p+wPT36/W149y6XtoNFV1/vKF0wfAbKJw2NqCSJrVz40EgEC6W95
         eq1KsAb6Ret2A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 84A4160982;
        Sun,  3 Oct 2021 21:00:51 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for 5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVnay/TJEr8K64+U@mit.edu>
References: <YVnay/TJEr8K64+U@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVnay/TJEr8K64+U@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: f2c77973507fd116c3657df1dc048864a2b16a1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca3cef466feaaf296c8519e2cc5ccf6565e3e7e9
Message-Id: <163329485148.21280.244814728557688517.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Oct 2021 21:00:51 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sun, 3 Oct 2021 12:31:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca3cef466feaaf296c8519e2cc5ccf6565e3e7e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
