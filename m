Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC20E50C5FE
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Apr 2022 03:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiDWBXn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Apr 2022 21:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiDWBXj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Apr 2022 21:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4F25D18E;
        Fri, 22 Apr 2022 18:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9376122F;
        Sat, 23 Apr 2022 01:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4727FC385A4;
        Sat, 23 Apr 2022 01:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650676843;
        bh=R8xeU+lU3Opd9ECa9+JWLH3W7hAIJsjrO5mbJXYy5vQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Th07eE0IUisMd27lYutTyYSyCpXIugzMudf1Oytj8OqLCOO0B4kKJOG2G20OhDlPC
         7nTag39gLDAJiE3gqvcuG+YBc2FXogP4Ak7rgbO6rpZCVgQdb4sjua+5Wi4Z7Plmrj
         EmtXmRi5yacyk/Vg70Wdrb3lfzURcvC3wRMnL2aBCbevZFl3LgBzdlOKxP1urwGRgC
         c9rt1NL5yJp0ZDjxTszvUZjO26i63TZOzPl1MvG9EpBvBpRJgbxlCcUh3tnAGXKsAR
         KmIqF6k/Gqrrhpru5LporQWCLS+dp3i09sILvR5cXtmFX9I0w+5nblgvqcIYcjZh2i
         rksUV8Wk58p5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 349B5E6D402;
        Sat, 23 Apr 2022 01:20:43 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YmMsywgKkOpa6dlR@mit.edu>
References: <YmMsywgKkOpa6dlR@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YmMsywgKkOpa6dlR@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 23e3d7f7061f8682c751c46512718f47580ad8f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c00c5e1d157bec0ef0b0b59aa5482eb8dc7e8e49
Message-Id: <165067684321.21969.3748476205738254809.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Apr 2022 01:20:43 +0000
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

The pull request you sent on Fri, 22 Apr 2022 18:31:39 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c00c5e1d157bec0ef0b0b59aa5482eb8dc7e8e49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
