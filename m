Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46243255AE
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Feb 2021 19:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhBYSi1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 13:38:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233597AbhBYShc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 25 Feb 2021 13:37:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 306D664F1C;
        Thu, 25 Feb 2021 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614278199;
        bh=QcRImuC+x+oZnT1THp/q3l/sW/W2q1s6fDey8pgKPWI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ghPnkmaXp7tfUZDmjxsGDmCBnn4IwzuFqsRslzOHtHx6xVl5TcyrygAUqovkrBKR6
         Ph/q/0z0lsHLbWB137/j/794VgKB0ydInvHmoVLiTtz39RA75MwWna2S+KnhKfTDvS
         jCkKp2vUSux0L4bnRhwiL97CbsB5cZsb9nXTKpgwrlOpBQ48iWtPHcFsnT5xyq7+HJ
         HossQLVIzLhSWGFP/Izd14qVB9qhECvPs4SjW8sNyeqgnqu90hYkcbsdBwt/2VaksI
         mprkuxWRlCGsm8xshdmoUCfafMA2YG+PtelVUiHHkJy9KSx8GpUk8jNRig0i630CaQ
         bN6HAO1PEARMg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 13A5C60A0E;
        Thu, 25 Feb 2021 18:36:39 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 changes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDfJjd0JEhAHoC2n@mit.edu>
References: <YDfJjd0JEhAHoC2n@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDfJjd0JEhAHoC2n@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 0a76945fd1ba2ab44da7b578b311efdfedf92e6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f9972bbfef57019519e1685254e876913a70463
Message-Id: <161427819902.26451.17075634460070639012.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Feb 2021 18:36:39 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Thu, 25 Feb 2021 11:00:13 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f9972bbfef57019519e1685254e876913a70463

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
