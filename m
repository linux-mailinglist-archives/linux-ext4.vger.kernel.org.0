Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28B74AB14C
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Feb 2022 19:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbiBFSik (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Feb 2022 13:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbiBFSij (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Feb 2022 13:38:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6128FC06173B;
        Sun,  6 Feb 2022 10:38:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCF23B80E66;
        Sun,  6 Feb 2022 18:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BE4AC340F5;
        Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644172717;
        bh=H0IkI9G1fsFRFRC31jBjlY59zLvbnVM/X2T8El5TnTU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I4HXusfS3jqQD0qQ9sZ6vQ87mLhD6UbZ50uAubRwUKgQelJZaJfnoLUNsNAOPSwn/
         ajqCc4pWN40j+DkGUgnswadwyvVH91iQV7jXJbrBzXAvtPqdFdJJlO6HtfbZdD3iH0
         q9KCUg++/ITBWzmBEvLj3HH7ljQIfEWYmuiwoh3DtJDgvR0Ajs9Hxylf4ddCmC+Cig
         RqyM52+NvT3+qVkNRn74XCxHKyR7rLXtOjPSh3Lgm2c83vIYVtPN9lvgdktUWmt3lD
         BqVXVT+5hv+WwpGwwJsKgJFlOlljYx4zfke2Zsqu+Vzn5tSuRM/s3MUMfBtR+pKAIN
         wkhbHz1t2HXVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59CE9E6BBD2;
        Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for v5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yf/axKTEyQQM1mfm@mit.edu>
References: <Yf/axKTEyQQM1mfm@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yf/axKTEyQQM1mfm@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: f340b3d9027485945d59f9c04f1e33070b02cae2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8ad2ce873abab1cfd38779c626b79cef6307aac
Message-Id: <164417271736.9246.13128783231515960742.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Feb 2022 18:38:37 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sun, 6 Feb 2022 09:27:16 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8ad2ce873abab1cfd38779c626b79cef6307aac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
