Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF47DFA0D
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Nov 2023 19:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346694AbjKBSiA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Nov 2023 14:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjKBSh4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Nov 2023 14:37:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B1F137;
        Thu,  2 Nov 2023 11:37:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F487C433C8;
        Thu,  2 Nov 2023 18:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698950273;
        bh=TiWD264Zcb85ey+LQGvjJjN1B9Ts8cFbIIHXPwfsSsc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AFUEQT2vWxO6Gm7PPi2JxjWETmdESOV9f6ZULRi5hZVxV/02zATyqGo6M6rnOS5fH
         +D2knram9toxzMbpBpgVeXYQVD9GSazpLz2rSWEBaB+vDmLorHbNYdr8qR/51O0X0f
         gGIgZPB95bdiSpjPn/aqjfKQOtNnMxBa/hneZ6Hsw33u7/krOxCUBY5T2PIEUyGh0K
         etxEVX1u0745ncrLuvP9w+0bDVu0fCBPURa7cRrJpOsucfAZ4pukKDeTsktxWPf4LD
         sf4+8e+z5UmDlHUNU4JAoGAh/zJe5gSyOSJLUe5yeZI4Va7BFXSs5Wzfi13UIVI4Zd
         H/+69Ca4/ePWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C32EC4316B;
        Thu,  2 Nov 2023 18:37:53 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 update for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231101022818.GA108790@mit.edu>
References: <20231101022818.GA108790@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231101022818.GA108790@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.7-rc1
X-PR-Tracked-Commit-Id: 91562895f8030cb9a0470b1db49de79346a69f91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57aff997450420b8a7da6a72f45c3677ac1c2f86
Message-Id: <169895027350.19486.1542030475959231084.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 18:37:53 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 22:28:18 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57aff997450420b8a7da6a72f45c3677ac1c2f86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
