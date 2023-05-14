Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22172701AF9
	for <lists+linux-ext4@lfdr.de>; Sun, 14 May 2023 02:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjENAw3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 20:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjENAw2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 20:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B771FC8;
        Sat, 13 May 2023 17:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C3A560C38;
        Sun, 14 May 2023 00:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3E43C433EF;
        Sun, 14 May 2023 00:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684025547;
        bh=dijVKjC72BzWSow4JfwNZCLkQ1FsUCju1wGT4bXy1Is=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PVRpeN8CXaprPCyrZYJk8nUN9p1+kz4lMptDvcD56C0HBAZhUZHEJuNa5UlDDAk1a
         AA09EE+qQUwV/0WLFITPBku6a2pTvCjua3yrGSzKdYMDfZYV7XzbiWfp34rbXsbKMm
         1EvmdNRqD18LAw4AbeZU1+jJ7RdjnMq/JEEqZJt4UpqHyjluxRUHJKRITC6aC1yg5K
         mrQ9fTnptIcRG/RPlzdEtm88mFqGI4yY/GDLaigXKpzYqJIx5gZ54N7/CU38ZCq9/A
         TrDUBTGOAVl3tKzKyMBNaj3hi5lSXFsWXdVJLDoljcae7/h0tbaJM1TyQbbj+iFwyN
         /QK+bWMBGuqDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1A4AE450BA;
        Sun, 14 May 2023 00:52:26 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for v6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZGArOUgijBkG1y3G@mit.edu>
References: <ZGArOUgijBkG1y3G@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZGArOUgijBkG1y3G@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 2a534e1d0d1591e951f9ece2fb460b2ff92edabd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb7c241fae6228e89c0286ffd6f249b3b0dea225
Message-Id: <168402554691.23680.9531950014318802685.pr-tracker-bot@kernel.org>
Date:   Sun, 14 May 2023 00:52:26 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sat, 13 May 2023 20:28:41 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb7c241fae6228e89c0286ffd6f249b3b0dea225

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
