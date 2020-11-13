Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424692B22FD
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Nov 2020 18:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgKMRtH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Nov 2020 12:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgKMRtH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 13 Nov 2020 12:49:07 -0500
Subject: Re: [GIT PULL] more ext4 fixes for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605289746;
        bh=uy6JqF9hPqeCTlv/daN1loa2XyvaQkfuNjPHEGF0eEA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gxmNE4Og5dopW7j8zmabxjgeGq3P2tvYSXSF7qVdn3iNPEwuo76HF5GfCo4Ci33+g
         d1Hhw72d8BQm2G5jferWebbhqHQ1Zmcg8bTBiIGRoZUVnVt24m4sWJoeOelE85FoK+
         1AexwrCKK1Nu6O3JUZ00ENx7FC+M5FJEjjsuQzIQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201113045848.GA3987678@mit.edu>
References: <20201113045848.GA3987678@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201113045848.GA3987678@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_bugfixes
X-PR-Tracked-Commit-Id: d196e229a80c39254f4adbc312f55f5198e98941
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3ba7afcc11fe9146def1664c32762d5a6a47713
Message-Id: <160528974654.4613.124994218218605930.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Nov 2020 17:49:06 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Thu, 12 Nov 2020 23:58:48 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_bugfixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3ba7afcc11fe9146def1664c32762d5a6a47713

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
