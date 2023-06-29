Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B5C742F10
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjF2Ux0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 16:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjF2UwJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jun 2023 16:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289423595;
        Thu, 29 Jun 2023 13:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FD9361634;
        Thu, 29 Jun 2023 20:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA301C433C0;
        Thu, 29 Jun 2023 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688071900;
        bh=91GnsxmCq5c15wSFhvVC9Fj3JfW1GYcpAiXQHKTcpbg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WEbTSr42ajK/+ya1wClw6M4VTfaH4ZkOS+IswtIMAJlQAk+djJyfS7UI5cBXfIL2Q
         5IT5p4GC+P/3a56iP1L0H03aiVjra7Xcd0j+LuTMqwRpjZN3pfNOfj0Ni+jZrZ0VuE
         NA8Gqyn67UhNRGdVXeBARolytWVwxG5W56cAGcmi0w458WnscaVKQHxMbETEkxK8cB
         ozcDOy8cMqWf9A0IV30hnWAGTRZkPRCRTHBE1kffxfRBvv5Q73rAw/lP7uWSqtkam+
         J7JTlsxb8UKEZv70qMWXlJrwqUfR7YGqgFfPMPME3eNYtzDDjS1bKk8fbLlKPr8QLj
         S4yDx4ap8h8Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9B89E5381B;
        Thu, 29 Jun 2023 20:51:40 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627153618.GA329146@mit.edu>
References: <20230627153618.GA329146@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627153618.GA329146@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 2ef6c32a914b85217b44a0a2418e830e520b085e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53ea167b212f675e40420498e46fa31553b406ac
Message-Id: <168807190082.21634.14409452832650801640.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 20:51:40 +0000
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

The pull request you sent on Tue, 27 Jun 2023 11:36:18 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53ea167b212f675e40420498e46fa31553b406ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
