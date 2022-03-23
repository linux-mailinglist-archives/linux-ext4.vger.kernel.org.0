Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527314E5B10
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Mar 2022 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345117AbiCWWLl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Mar 2022 18:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbiCWWLk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Mar 2022 18:11:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFE327FD8;
        Wed, 23 Mar 2022 15:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D75CCB81FE8;
        Wed, 23 Mar 2022 22:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4FC4C340E8;
        Wed, 23 Mar 2022 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648073407;
        bh=qolJ27SnIxSW27HwkjV+UbRWzVMKt118KZi4gH/gKpA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S/X59p/y5dUiGolgtUQwu4RvQGSKNR18NhJ4C9zCLPYwF0caWvidV5b1hoV2LUVJp
         r0C70gg01CCfVDcQyFFfi5545j33REuV+w5/fSaaQdcEQ95zkkvoeTa7MG+Kw2YA59
         KRlogBLovrdcGGX3gvz33at4Uf3vKAZzShyojj4/NXntw/QXC6ytpyGA83NmnylkVZ
         wlPGdEYZzL3EHyBSU88Tfrk7N5X6EAr6ZeiKIIwBb2+Ms3WCq0tVOfEMPT8I43Sle6
         rNDYYIbaFteFN6TD85gXp3sfFN3PLeXbmxQQ9NP9mdRn0T1G95abMlV+ELgdYgaCdW
         0EEVD4JH3Zihw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86E48E7BB0B;
        Wed, 23 Mar 2022 22:10:07 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjuYwa2jhanwyryf@mit.edu>
References: <YjuYwa2jhanwyryf@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjuYwa2jhanwyryf@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 919adbfec29d5b89b3e45620653cbeeb0d42e6fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b03992f0c88baef524842e411fbdc147780dd5d
Message-Id: <164807340750.27141.17045124539245947003.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 22:10:07 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 18:01:37 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b03992f0c88baef524842e411fbdc147780dd5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
