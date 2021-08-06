Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33E3E3025
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 22:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244700AbhHFUL3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 16:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244657AbhHFUL0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 6 Aug 2021 16:11:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 90A9460EAF;
        Fri,  6 Aug 2021 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628280670;
        bh=i2oexJ5lCfI2E6ZEu88A/HWwKuDbWd0WWAmivugZcgU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JzRUntZSt7/A0ZFmJU9hkDHz+wzBnYMe2BONc1WW3gSjbAESPZqdAZnRHVqxP6t6U
         Qd8RuVFAcqT31RvJ59SBvY6WbzrN6sI5V4zkjItbq6deOI0WS0YkuMWjdHn869XDBh
         u8+musVyBXFvntHAmERtSpNvdMJ1M8m0M2SU/v7TnNBrmr0r7k0zaMva2K/pqh+BZH
         9vAVfPPV4wt8RWM8bp/SJuukAw3kn+dkK84vhfNpASDEtYGHVfhL/uVKtRETSTKZZv
         cDSgKgt/7zeehLxDMG4JbhTWDDYSETf+ODSKSa0VD2qWFcpsp6B7ZM6Qk56Q2iYRfo
         TEvKx7u0gYCdg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7EF7A609F1;
        Fri,  6 Aug 2021 20:11:10 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for v5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YQ1u+Acar/N3aUpm@mit.edu>
References: <YQ1u+Acar/N3aUpm@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YQ1u+Acar/N3aUpm@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 877ba3f729fd3d8ef0e29bc2a55e57cfa54b2e43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9194f32bfd932e976a158d1af97a63be68a2aab
Message-Id: <162828067046.25549.12030796103851495732.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Aug 2021 20:11:10 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Fri, 6 Aug 2021 13:18:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9194f32bfd932e976a158d1af97a63be68a2aab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
