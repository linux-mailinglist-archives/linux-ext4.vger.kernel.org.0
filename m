Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90172AC621
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 21:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgKIUpp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 15:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730096AbgKIUpo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Nov 2020 15:45:44 -0500
Subject: Re: [GIT PULL] ext4 cleanups for 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604954744;
        bh=h/Pinh10cboDuZRDBaavb0V/lxi5J66R01FXSXof0nI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HdJfnTlS9NYVx6DwxhJiaIJRgVFT2IuuMwqcI2JoRzASRu7+foCAM+NcY3IAxDqI1
         E9J4pRuf+Ut4tADsY3rgjG691p1xVwY4d4jd5rlf/cu8LQH8morIAuuySN1pLtjs23
         XZL+Jj/nX07asFXI7kTIeJYlbnzf4YBt4AigrFgI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201109173809.GA2916982@mit.edu>
References: <20201109173809.GA2916982@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201109173809.GA2916982@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_cleanups
X-PR-Tracked-Commit-Id: 05d5233df85e9621597c5838e95235107eb624a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91808cd6c24359eee0c1eb7a06ea02dac358cbb5
Message-Id: <160495474400.25406.8560233228341633322.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Nov 2020 20:45:44 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Mon, 9 Nov 2020 12:38:09 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_cleanups

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91808cd6c24359eee0c1eb7a06ea02dac358cbb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
