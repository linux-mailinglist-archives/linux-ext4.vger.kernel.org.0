Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED43E37039E
	for <lists+linux-ext4@lfdr.de>; Sat,  1 May 2021 00:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhD3Wle (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Apr 2021 18:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhD3Wlc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 30 Apr 2021 18:41:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B80D661221;
        Fri, 30 Apr 2021 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619822443;
        bh=5gb9b0HxY+fd54HmbsuzIVxtYrRyc7fswz/T59o8JkM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=orJHm0L+hRxd2WXaMIFowfqiWN8/Mh7bol4WHq7ECMnkoYY34Osnw2Sw1s6maigQg
         D2it12HqoPPpo1giKN3jtDO3IBrkTqLXPNgHQMMfr0MWQ9bMw+BgisbTwy7CFTnSyx
         G21NYbtRHvqYN1/8P3cCRY8+j1wnGvj5Peq6+hTdfFrv6pPz54ffYjaw3gqx/3iF/u
         brznzT4DsXPY5CD/3hny70s0+ChBhfPQDhBtj83SZ5rKc/ca+Ix+hwxokRBdOqiyl9
         uHtX1o1B0z3AZalypA8cBAlEFrEj53Fq4mi4BzG82TuJ25SiM+LyTFH6QeeZNFM5Sv
         1BM9nxI4zP5Cg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B262160A23;
        Fri, 30 Apr 2021 22:40:43 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIwzPefeKM+Vuxn5@mit.edu>
References: <YIwzPefeKM+Vuxn5@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIwzPefeKM+Vuxn5@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 6c0912739699d8e4b6a87086401bf3ad3c59502d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f67672a817ec046f7554a885f0fe0d60e1bf99f
Message-Id: <161982244372.6177.14655443716931571531.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Apr 2021 22:40:43 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Fri, 30 Apr 2021 12:41:33 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f67672a817ec046f7554a885f0fe0d60e1bf99f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
