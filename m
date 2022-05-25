Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDC3533531
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 04:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbiEYCQg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 May 2022 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243771AbiEYCQf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 May 2022 22:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45621DA5C;
        Tue, 24 May 2022 19:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E8436153C;
        Wed, 25 May 2022 02:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 859D3C3411F;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653444993;
        bh=5m/aamUmm7ZVPj7Ky355gFBD5jRqxEr6iM8x7CwkLYs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hiviaMlDpdJYVrC4rtcjaAuih3sI00zZG/CK0vA9ggLNKi3KT3o35apvy3A72MnPV
         G2jixUbVDD5A2ZBDQnHO0phJDM5glaXNJj+JfCr0gwF0Sf0vBfBuwz4P1h1998fLYR
         KUwP/csapx4h6C3hQI/6HNlBsT6dlP+FbkwaZJcE6oAMyfy+a4+5gjAnLYOZp2c/3B
         rr59VMufVc09Is9vHWu5q7gh3QKxoyIguJ74dBAuNglZZ14+jKgc+zQBJvvRexT56l
         zXNw2AwxCrKxSFlC+PrarK3EaQeW3ZxKyw4V9ZY61w0w1mQDCE4QgDNgaM5GYNYl9U
         w1dDV8dfd9kGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73863F03939;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yo07mIe2Hc6GYFrX@mit.edu>
References: <Yo07mIe2Hc6GYFrX@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yo07mIe2Hc6GYFrX@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 5f41fdaea63ddf96d921ab36b2af4a90ccdb5744
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fea3043314f30a87ca04fd1219661810600e256f
Message-Id: <165344499346.22339.13348168376412224335.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 02:16:33 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 16:10:00 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fea3043314f30a87ca04fd1219661810600e256f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
