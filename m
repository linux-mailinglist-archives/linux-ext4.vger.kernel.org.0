Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9F76B6837
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Mar 2023 17:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCLQYF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 Mar 2023 12:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCLQXy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 Mar 2023 12:23:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788E41DBB5;
        Sun, 12 Mar 2023 09:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAB56B80D1A;
        Sun, 12 Mar 2023 16:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DB82C433D2;
        Sun, 12 Mar 2023 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678638059;
        bh=6AT9DE5uIT4fNvp6jRC1cglsUcG6b/Erf3QkOKmtCL4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fz0Y8V7Qhn60E7awgpranlXywdG9T7D9Cpy7U3L30AWUT6bVgJTeex3g96y5/PXtY
         y998wGt/2xmGKdTfDz69llpoHo3KAr9NqigJ60ZJivlV+yrnMq1Y0exsqRlbW1nW6t
         qXGplCM8YHkmdIlubKCS9coCpL1LumvXdcPwZWpXuv37fm9Xs4t8smSSLKPgT8hNWv
         Rlp8tg7HaWC2kqLtQxmLB1RzcgQMr61gjNv5Lvtf/9Znng1MAtok1n73vft9HhaNXm
         tJeka47QchkPqCTIauYuM7tanQThDuzrxHR9XBOv7nxP1oNeWqAg1la7cYxHZAlYmk
         n4xVMYxS9SOKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C7D1E61B75;
        Sun, 12 Mar 2023 16:20:59 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for 6.3-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230312044116.GA2694785@mit.edu>
References: <20230312044116.GA2694785@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230312044116.GA2694785@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: f5361da1e60d54ec81346aee8e3d8baf1be0b762
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40d0c0901e6c19cf268d2f505bce0b50319c5653
Message-Id: <167863805957.16000.4074357502595179662.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Mar 2023 16:20:59 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sat, 11 Mar 2023 23:41:16 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40d0c0901e6c19cf268d2f505bce0b50319c5653

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
