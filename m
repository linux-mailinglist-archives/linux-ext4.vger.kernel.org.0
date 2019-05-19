Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC192287B
	for <lists+linux-ext4@lfdr.de>; Sun, 19 May 2019 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfESTKg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 May 2019 15:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfESTKf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 19 May 2019 15:10:35 -0400
Subject: Re: [GIT PULL] ext4 fixes for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558293035;
        bh=8jixYHmTH5m9UlhciK6dW32Y/+nWZ8e+T4iaHo0j1LU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=llLcRmglkFFddMLJCcwbNqhDcVZqgWWHvUQZrh7QEXUKdFEXcIt8bXdO/JfjHVZxM
         7AbfTN1ElDzZ6EhOii+qLLkDS1jcBnz6lVsjEJTDS4ncYVmS6a1AM/CBcUtwIc6fAd
         Weidfk/uHsuaMXFApQJEBgZBYg/BMgQIPUBDCvQw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190519055848.GA16693@mit.edu>
References: <20190519055848.GA16693@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190519055848.GA16693@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 2c1d0e3631e5732dba98ef49ac0bec1388776793
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4d36b63b28b76cd584bec48af7b562b4513b87b
Message-Id: <155829303514.20625.8555456470191160244.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 19:10:35 +0000
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sun, 19 May 2019 01:58:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4d36b63b28b76cd584bec48af7b562b4513b87b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
