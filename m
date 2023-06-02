Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E33F720B12
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jun 2023 23:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjFBVih (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jun 2023 17:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbjFBVig (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jun 2023 17:38:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA3819B;
        Fri,  2 Jun 2023 14:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D09A261228;
        Fri,  2 Jun 2023 21:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EC13C433EF;
        Fri,  2 Jun 2023 21:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685741914;
        bh=D9zK7MIIdg1KWszPyCeEI8+QbwXDhQQarBP3309egXo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kycKgiKYvd+suag3ioPO1oAo++LZIUoZCNLzJDv+892yqX9Be++IEtg3U5lv3t5uw
         fTdbjJnSPE1drlG8shlPDWSHExqyuAEhDeVP/fHSvr38UQMwn4gLgjbD2xbR06WVIf
         /HeUjW9qvVBoGMeKOze9z29VsAfjlkqlryPMFo9+Rpn9AtDYPe4ryPZAW/LXGAi+TN
         vAJod4xrHkuql8QMzFlE527g2DkZQcea4ZE59Eq7aHweMHKYTI3Wh1LjzzjSWjQOYy
         G0dTqEcCXzb1GO+QqgJKOzRtj4EYw/Aq2jfWKLEHYEHTHkBEDx8twwO6bejM8g7yMk
         GPETmUR0uN4yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A831E52BF5;
        Fri,  2 Jun 2023 21:38:34 +0000 (UTC)
Subject: Re: [GIT PULL] (one more) ext4 fix for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230602211203.GA1164822@mit.edu>
References: <20230602211203.GA1164822@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230602211203.GA1164822@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 3582e74599d376bc18cae123045cd295360d885b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d7d0603ca7c397a07efc88e314e38b4242a3a8d
Message-Id: <168574191416.10268.18269693083707255899.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jun 2023 21:38:34 +0000
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

The pull request you sent on Fri, 2 Jun 2023 17:12:03 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d7d0603ca7c397a07efc88e314e38b4242a3a8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
