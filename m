Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE87B72A04C
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jun 2023 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjFIQkN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Jun 2023 12:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjFIQkK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Jun 2023 12:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD802D71;
        Fri,  9 Jun 2023 09:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E07C8659EC;
        Fri,  9 Jun 2023 16:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50678C433D2;
        Fri,  9 Jun 2023 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686328808;
        bh=Dbbd/531TqlJQ2aplzbLhW8uD85ft7u94hFQMfct564=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NJl1qnpylzDU3QVB0xjF0ALkYm68tLN18P2o9ie5KwUTiwqhnWA9eD/7Lu74ynbDb
         61Zjnhs3C8ylAaOHtn8Uv9T+qLRbHoo34mBUNMKnB/YtdAplWZyP4cm/NePq7WMtZW
         sJCH3RhUNMkZM83KUKDAQEWrD9DdzLgohGNuFrEZ+OHfGLS4ninttnQwEWFtka2NtU
         THOXZU3VDDjed+7XjbGf1u/6eAZMBK7xHb9BGWM2DEGefPCz6lOoXLwnfsMq+Ypbwd
         Ianbcl3dOjAPrD/b2gX6sCB12tmqwf18PVCOUUQJHKWSF6TYSrrfO3oZj65xAj4q3a
         7IVEhedRLR3+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F61DC395EC;
        Fri,  9 Jun 2023 16:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 regression fix for 6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230609031309.GA1458078@mit.edu>
References: <20230609031309.GA1458078@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230609031309.GA1458078@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: dea9d8f7643fab07bf89a1155f1f94f37d096a5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fc1c596c2ccd951b089b6b6d54c58a74a137764
Message-Id: <168632880825.22626.5658784830876918759.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jun 2023 16:40:08 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Thu, 8 Jun 2023 23:13:09 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fc1c596c2ccd951b089b6b6d54c58a74a137764

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
