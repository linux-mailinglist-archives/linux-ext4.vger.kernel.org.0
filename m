Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA26758A4FE
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Aug 2022 05:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiHED0v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 23:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiHED0Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 23:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF44ABE38;
        Thu,  4 Aug 2022 20:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D13160A66;
        Fri,  5 Aug 2022 03:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED9C8C433D7;
        Fri,  5 Aug 2022 03:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659669972;
        bh=lnluQbGXEjbKkSL0VjKQBiVpj8vxjDj76CDKB1He2nQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r9qAKgDb64IjLPthz6UWZtJfGcZYF/GkI1tdIBe1J2xd82GtpOwKke+qogPnkDr//
         U8MbpTlnxxrqdhqh5DCxytRdvLz1BqXnPVFzkW2DPTKPRjOMVf4Cpr2G8xoesCDLRF
         8T3aojfgsbPJfXPjv2T67BBjD4MOsYaVm0TkdiEKcFAJq/zMGdT2l+sa6EBv6T+GG/
         yoz5qjdWGMIIIxbnYVyI6SIJtBXpY+xh8uw5MMM7ht2j+9DarUBfk1y7oVg9jDtUvc
         gQgtIfJiI7NOKm3vkZYQBCGJb6hBfXa+myXOxTMQkDf8CN9weQNtJKHzWu7KI3Exgl
         U1fPYClU6naug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDEF9C43142;
        Fri,  5 Aug 2022 03:26:11 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for 5.20/6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YutOk+yCBPujKZeA@mit.edu>
References: <YutOk+yCBPujKZeA@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YutOk+yCBPujKZeA@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: d95efb14c0b81b684deb32ba10cdb78b4178ae5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9daee913dc8d15eb65e0ff560803ab1c28bb480b
Message-Id: <165966997190.9883.8866479310620617134.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 03:26:11 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Thu, 4 Aug 2022 00:44:03 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9daee913dc8d15eb65e0ff560803ab1c28bb480b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
