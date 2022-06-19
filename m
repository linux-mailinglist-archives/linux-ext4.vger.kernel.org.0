Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDD15507F9
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Jun 2022 05:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiFSDC3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Jun 2022 23:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiFSDC1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Jun 2022 23:02:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773BEE08;
        Sat, 18 Jun 2022 20:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9198B80C8C;
        Sun, 19 Jun 2022 03:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C511C341C0;
        Sun, 19 Jun 2022 03:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655607744;
        bh=0IPuyDeTiSd/UX5dQ0RoeHiMjLYfxoHxA8RHgu5/FSg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VSlCyFsVCFHQZ1zoP1qwMWlzfwO8LwMyxT9GKjZ25hT+5y6MSLPFfY+4lWQpb/mDi
         qbzbyknTzr14Ev3BUt3Npp8Hpae7jI9EeV7UR/JzMhXRsw8Q8pUeJi0wSo3VV5o2dJ
         63tjGHIl2pBxpU2hbSxK1yLPO3Qm8fEAWUi0uS3fqWm56vijUT55bKYF4lkP9oOZ9N
         afLgwVQWBOmp/vDe5B4anSLxgCm8oI+hryReFz70CMy0PXXzy+ZBK72lBTcB3JiiZQ
         eqtZ+rP8ncmQcb7Jy1yJFmTEznt1S6Zff7idRPjRpwtSvtpmrDyfzEQ8GZJhp59jke
         GvuoJPlVQ64MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A9B8FD99FF;
        Sun, 19 Jun 2022 03:02:24 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yq5uOVSUci3fv+Mw@mit.edu>
References: <Yq5uOVSUci3fv+Mw@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yq5uOVSUci3fv+Mw@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 1f3ddff3755915a2b38de92d53508594de432d3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 354c6e071be986a44b956f7b57f1884244431048
Message-Id: <165560774449.16247.10080764740469156591.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jun 2022 03:02:24 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sat, 18 Jun 2022 20:30:49 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/354c6e071be986a44b956f7b57f1884244431048

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
