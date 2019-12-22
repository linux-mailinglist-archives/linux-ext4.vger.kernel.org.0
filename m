Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642EE128FAF
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Dec 2019 20:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLVTKO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Dec 2019 14:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfLVTKO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 22 Dec 2019 14:10:14 -0500
Subject: Re: [GIT PULL] ext4 fixes for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577041813;
        bh=1jSit8CQeOHrXtfDi5X5qF0E8hZqEJBF1s2hOuJ13Ko=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OxJJQAmRYxkz0yadqGu9dkEXuMJ03EVfOP+zUhWgFb31mbt1QGEHomU96gF698x8F
         81Fb7U08sntbcAW6SZ+TSGjaGGc5LSCPxOlmiECfyaNNGnopg3XBZBeS+WL74S81bF
         QrbckfzFg9iprEdXb/pALNrTbB7fK9lH0jLV+zaU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191222142603.GA357248@mit.edu>
References: <20191222142603.GA357248@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191222142603.GA357248@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 23f6b02405343103791c6a9533d73716cdf0c672
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a396560706d457058b9f54f184b6f5973c82032c
Message-Id: <157704181392.1067.2996457268147875057.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Dec 2019 19:10:13 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sun, 22 Dec 2019 09:26:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a396560706d457058b9f54f184b6f5973c82032c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
