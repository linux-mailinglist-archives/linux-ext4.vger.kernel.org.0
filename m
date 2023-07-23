Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23075E42D
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jul 2023 20:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGWSos (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jul 2023 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjGWSor (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Jul 2023 14:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D4E40;
        Sun, 23 Jul 2023 11:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D39C660DE6;
        Sun, 23 Jul 2023 18:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40D22C433C8;
        Sun, 23 Jul 2023 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690137886;
        bh=3fSfCImp3vV+DeeQpdh4SyGTsMBiva/uQVPpVtRRCRM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dkXX/zH4eqdLQYch5qPBba3s6BuiS0/MG46IsxwBzVQwptjvgspHzT++u+YFqZ4t7
         poTf35GXsW5TFeqyTUExRZSGF5rZ+ALYTbGKDE+0Tjf/JI3HNRxJKYnKpjwQOJu0ky
         7+eBwhYYZlcptvkNiHzllV9te5BOnL51uIZObT5OSA+/RwTnQIuVYyUJBsufKlyjLM
         iJaaAzFQUTUK73uNviADD3nEAWg4pH8qIwD1C3UcEn5i5GfBJ3vFanc5XSC6KBNBko
         U8Jwxb4ho6nA/E+gDDXD96wEHDJ2PAB726hNFe7OoqyYRy48EZWHm3zTZ5WF1BQ6sw
         m/KXwyYt0plHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E31FC595C2;
        Sun, 23 Jul 2023 18:44:46 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for 6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230723123130.GA10840@mit.edu>
References: <20230723123130.GA10840@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230723123130.GA10840@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.5-rc3
X-PR-Tracked-Commit-Id: 9d3de7ee192a6a253f475197fe4d2e2af10a731f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15b593ba68445a2b436a63044eaecd0679457dc2
Message-Id: <169013788618.27296.14953269324500479481.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jul 2023 18:44:46 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sun, 23 Jul 2023 08:31:30 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15b593ba68445a2b436a63044eaecd0679457dc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
