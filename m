Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EB878F5B4
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347824AbjHaWmw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 18:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347807AbjHaWmr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 18:42:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C7CCF;
        Thu, 31 Aug 2023 15:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 078FE62AE9;
        Thu, 31 Aug 2023 22:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E7D4C433CC;
        Thu, 31 Aug 2023 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693521764;
        bh=sLm/g9hju5FD5aJgSXRX5clMzFnGwUf8NcACyvpRGGc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XmMk7zzHg3wC/1/EHIKTRmvBLzAqaEQMSmAp4rJg3j/RHyOm3cu2QuCFSFLUPZRRj
         eztD+HqQxyn/TRH/2d+lXOgyk11QwBgp2BeobeaNYw7OTASIsghnWNUkgBZ6fGF3en
         3eEnDh+8DJOqM8mJNByYpsbC5ufBTvfEbJLZaCxDiKvOVuzwq/1d4wcYVQ89p8x1WL
         VmR59gNvurlCaADNz76gO04tpj+Rf3weIEEfIwQUk+LquyP+2hfHH/Vuc5oEaVW+Dz
         xTVBp7iB61jb5Th3mdV+ZGO/LnNvmfo0fDoqrOzz6ZMDqpmBUASgw2FzIX95ljY9vV
         fBxeaaIO4PTvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B9E3E270FB;
        Thu, 31 Aug 2023 22:42:44 +0000 (UTC)
Subject: Re: [GIT PULL] Ext4 updates for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230831150155.GA364946@mit.edu>
References: <20230831150155.GA364946@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230831150155.GA364946@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.6-rc1
X-PR-Tracked-Commit-Id: 768d612f79822d30a1e7d132a4d4b05337ce42ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ef96fcfd50b9980470efb1acec7c27a60b98e87
Message-Id: <169352176437.24475.8944537774974212914.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 22:42:44 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 11:01:55 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ef96fcfd50b9980470efb1acec7c27a60b98e87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
