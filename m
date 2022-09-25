Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C56E5E9438
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Sep 2022 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiIYQI5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Sep 2022 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiIYQI4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Sep 2022 12:08:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C748F2B1AA;
        Sun, 25 Sep 2022 09:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 662C661547;
        Sun, 25 Sep 2022 16:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC758C433C1;
        Sun, 25 Sep 2022 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664122134;
        bh=dkWDGLgNJVgBuh2YIvf+5Bj8u8dAZkN5YbCapJSOJLM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mP8QGXuAe0savFt23e91iQeU/0dWunTyfOuzMFw6Q/tooW99pWGnxHVtnZ38F/2+1
         CDfmFFdWPdSR0wPLmlpfllzX6ziwaFt06NJ4NzGxxljVFv5tKpV66QkrLacDIOb6pw
         iqwyO9OsRPvVL3Nn8Q14fATjaMAz+cLng0mQFP8JTXgSkKBfZqHVMqxF9qmaVNRO8S
         DF/m3MvD55MFNgJ/j9yMY9b9+xUifr+apyJfxIt2Ym+RVbpZMNlrix6puVm6qCwEse
         p72zZKC7XmCtces/XMoBOURtpxiiEQykD4WPu1Y6BffpLkrfssxCt8YfNG0ntKTQ7a
         wjlXZTgmznEWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA4D0C73FEC;
        Sun, 25 Sep 2022 16:08:54 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 bug and regression fixes for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yy+090ziVE6+vBlH@mit.edu>
References: <Yy+090ziVE6+vBlH@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yy+090ziVE6+vBlH@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 80fa46d6b9e7b1527bfd2197d75431fd9c382161
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e049663f678938dd56812ba870a471060f8ce28
Message-Id: <166412213475.26660.7408025851966523450.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Sep 2022 16:08:54 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sat, 24 Sep 2022 21:55:03 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e049663f678938dd56812ba870a471060f8ce28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
