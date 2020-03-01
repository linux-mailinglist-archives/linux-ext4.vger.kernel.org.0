Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC811750A5
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2020 23:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCAWpK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Mar 2020 17:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgCAWpG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 1 Mar 2020 17:45:06 -0500
Subject: Re: [GIT PULL] more ext4 bug fixes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583102706;
        bh=gZyYeXYf82ORVsxbMK6z75AjXkouB2FvC3dwX4XXpbA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1eyS1CXbXzj9ntxL54eIWp3PrbEK94lK5ocaat7u6kTvB8An1SXVt1H5c8xuKduJl
         l5E7CcL6LnrS2dK0sThHUy6b6dOsW2D/FPbG4PvG9iiL9t74HMi/RsUrNd4sWUL9UZ
         oLLqPGOpJsdP4x6yoHcvJuRJ8yJnRpIDXsiBDHNg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200301220708.GA91502@mit.edu>
References: <20200301220708.GA91502@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200301220708.GA91502@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 37b0b6b8b99c0e1c1f11abbe7cf49b6d03795b3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e70869821a469029aeb056b4da96e5815cc5830e
Message-Id: <158310270604.24436.18176466590107249777.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Mar 2020 22:45:06 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sun, 1 Mar 2020 17:07:08 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e70869821a469029aeb056b4da96e5815cc5830e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
