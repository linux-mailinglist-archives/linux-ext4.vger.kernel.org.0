Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637A86F36BB
	for <lists+linux-ext4@lfdr.de>; Mon,  1 May 2023 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjEAT1N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 May 2023 15:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjEAT1L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 May 2023 15:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA3B26AE;
        Mon,  1 May 2023 12:26:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 304DE61ED9;
        Mon,  1 May 2023 19:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98F7AC433D2;
        Mon,  1 May 2023 19:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682969152;
        bh=lff3rXTSXS+G/bKaC8bYRz5EJaFk8QhXUmYzZG+tWI8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sOQsMA0gEwRJvd1gSO8kMMVNr3nu7b6PEpafxQzqTd9HWtEaOYW93AFBqa82/cKBc
         6SmFtsOy+JxTybagIZfaNpMBT+lU9I60eazIX9JHeiUSKV4PGWe7r9aKzCkd2eMxT8
         KRqzQ3xKVkySV+CJ4frQeG05TCs5rVyC9jm2F+Z52zfBRBCFgBQ95Z5LNB8CrzNlsn
         zi3RQ/PZD9yWMZ1zS8hPNIZqUiQyh6d9bFYS3o6kKGj455C9+m4Aq0iQSB8jR17oOl
         cRKAyCWDykM6HMQf39Hr9V++DMSAm/Bf1bqnVKsRgGJzdCtlTwX+1L/3Azw2HEPPDM
         7midDSLHLfIfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87A37C395C8;
        Mon,  1 May 2023 19:25:52 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 bug fixes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230430180828.GA584597@mit.edu>
References: <20230430180828.GA584597@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230430180828.GA584597@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: d4fab7b28e2f5d74790d47a8d298da0abfb5132f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06936aaf490ff55dd5787375a83d6e486bccc397
Message-Id: <168296915255.17937.17646465410348108304.pr-tracker-bot@kernel.org>
Date:   Mon, 01 May 2023 19:25:52 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sun, 30 Apr 2023 14:08:28 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06936aaf490ff55dd5787375a83d6e486bccc397

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
