Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2202E2E2908
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Dec 2020 23:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgLXWXX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Dec 2020 17:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbgLXWXW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Dec 2020 17:23:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 56E1E22AAC;
        Thu, 24 Dec 2020 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608848562;
        bh=h4qUmfPe0sV4bCxtvJk9QDxndIk054qGKcvC62jzGtI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r2FZx2GgblItiFx66/qk8ppTDQe4E8WPC8AlZCC9oKnoMiN/FjVslcMY864YiMIL9
         vPjIf2+qGN+MNp9nCclVuujXutcqo1m1K5JrZdP2M2hsDgUUs1ohwRO9fk5sxeNN0A
         ZQWiqhT6jLUBuCbSa1dNKJ+C8pgZ0pkT6MHBh0aG6kwqSgW4sIB32IRSBWhy6j+7O7
         hm6K2I781r0OwT1VhCuTk3+o3tBCcJFj8vYOFCbwlCHFqWxUOlOKbv61VDuCxSP5N0
         /At5JhnHTQ611p6WF4hxtEdd8Y5kR00kXRFH8Y2G3DUmFBVtrKisZKvmThbuBxUY1R
         Fr4jvcQAD9Q8g==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 52C9260159;
        Thu, 24 Dec 2020 22:22:42 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for v5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X+J35oGDo2HnOuOP@mit.edu>
References: <X+J35oGDo2HnOuOP@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X+J35oGDo2HnOuOP@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: be993933d2e997fdb72b8b1418d2a84df79b8962
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 555a6e8c11e6282bb2704ef1cee64ceaeb41773e
Message-Id: <160884856233.14240.10076898485757265029.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Dec 2020 22:22:42 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Tue, 22 Dec 2020 17:49:10 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/555a6e8c11e6282bb2704ef1cee64ceaeb41773e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
