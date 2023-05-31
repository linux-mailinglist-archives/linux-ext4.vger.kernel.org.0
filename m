Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529A8718942
	for <lists+linux-ext4@lfdr.de>; Wed, 31 May 2023 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjEaSUD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 May 2023 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjEaST4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 May 2023 14:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3E191;
        Wed, 31 May 2023 11:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0647563E90;
        Wed, 31 May 2023 18:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 606D8C433EF;
        Wed, 31 May 2023 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685557159;
        bh=v9YM8gQaPNLPkhe86wDCjn8lgM/GeKdHkJhnDW1pEuw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JYo6TLZOlZsn7VKv+90qU4M7rNogKmc6C9F9CxPpWksSplOCmfphmHZxleni1+lC7
         dkJGDsEa9g0pmzjoBwxJBxKyeRtox4/bZFvSKIu6nDe0njbLgcwuvvyxTABmy3nDpz
         AqEvAH4cc1EuiVK1+DuZUUpzZyhDl916X0U2Xr7/mq4DEQdRO+Bs4NAJWJOlNStBey
         2AZDCTJQX3volFE/pmjYuzRYUGoAptx3+6tyR8Zz6fhy0x2EiTLDiOX1QzSy11FIFy
         4gufV5S5AFELGgJMlsr2KiRnbjDCMdrOnYM53yXOBRYhjW2AluvuBObuive4nnukNi
         16ZHOnLKdpYYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47445E52BF3;
        Wed, 31 May 2023 18:19:19 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230531154552.GA814122@mit.edu>
References: <20230531154552.GA814122@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230531154552.GA814122@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: eb1f822c76beeaa76ab8b6737ab9dc9f9798408c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd2186d1c708fa0ec64291da5aa6b26fb44197c3
Message-Id: <168555715928.4511.3440437819801629558.pr-tracker-bot@kernel.org>
Date:   Wed, 31 May 2023 18:19:19 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Wed, 31 May 2023 11:45:52 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd2186d1c708fa0ec64291da5aa6b26fb44197c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
