Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897FB61E55C
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Nov 2022 19:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKFStq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Nov 2022 13:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiKFStq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Nov 2022 13:49:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88817FCDB;
        Sun,  6 Nov 2022 10:49:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2374260DB4;
        Sun,  6 Nov 2022 18:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84300C433C1;
        Sun,  6 Nov 2022 18:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667760584;
        bh=uShMqmsxFJZdVvAZ5OuoI4PsF51Si1grB1PZ0cKL4zw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l4u6cLPNMGuai7jtWwnzsqwy7Wi8qgW8DNUMUJBscXjXjwN4uEuq1Cgy8+b1cl6vt
         x6v8H/RQ3K9WXGevSnJcNuAS8Fm5qgxSllo0O2Eslx8N4/8+wpuNaDH10IjpfZy4DA
         p+MtZl7taOPX04oHdpBorCZuQpeXJZ485GzTpSdyc03UTmfubbS8B3c0Xki+jdtC5D
         IjiHoyyqKdq1KNOzSsaBgtWhJZKp40uhJDhoDjZh15lbyEyY1DmMx0iGMaSoW/bKEu
         66pZWLbnCk7EgCorVKwbjQIB3f5VxDL5qfIx8mDgc44SkSVe3wSt17bGytam5WIhxE
         5xZg3hvMh5GSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7182FC41621;
        Sun,  6 Nov 2022 18:49:44 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 bug fixes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y2dRoyP5tKIZj/b4@mit.edu>
References: <Y2dRoyP5tKIZj/b4@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y2dRoyP5tKIZj/b4@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 0d043351e5baf3857f915367deba2a518b6a0809
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9761070d14db0ac0706684eb2fa37dca3087efa1
Message-Id: <166776058446.6751.15690741379105196285.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Nov 2022 18:49:44 +0000
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

The pull request you sent on Sun, 6 Nov 2022 01:18:11 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9761070d14db0ac0706684eb2fa37dca3087efa1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
