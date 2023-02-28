Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5376D6A5E15
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 18:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjB1RRn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 12:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1RRm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 12:17:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291021449E;
        Tue, 28 Feb 2023 09:17:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B71346117A;
        Tue, 28 Feb 2023 17:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 283F5C4339B;
        Tue, 28 Feb 2023 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677604661;
        bh=OY4m/h/RIqk+2hyJm3gcqFg4WaOjRoEHwthQBsUGiek=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yp93a3PINyb/K0ZwUP2rjqtrghiG/X0wGXysPuqiUfzlDF9TOH1O32698vLn6a9vV
         bfih9ePXmGHClAz43YoJFJvCmXYfEMRV/tp1drOKg7F6yq2w5aVD1DoWKjIbL8l5wR
         7/cC/Q1C+ab+ctmxNgXd8irqfAINeLn8LchxpFDLt4kbNGymfchoBTuvy+H8x8jxq4
         44tTdPIKqC2mGHh6uL5RaC21cE8JKZM+Y/7Pqqv7N6QXZI1iNeeFlOwoQSLTSemqOa
         9rdRM/8io111rZEUNSYJywUq6vOe/Qc0iCb+x0rX5Ox1+rsBil8UPiYDv93x82mJS1
         NtSB+7qVq8fRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1575CC59A4C;
        Tue, 28 Feb 2023 17:17:41 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 changes for 6.3, part I
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/2CN+FpmGsfzgdE@mit.edu>
References: <Y/2CN+FpmGsfzgdE@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/2CN+FpmGsfzgdE@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: e3645d72f8865ffe36f9dc811540d40aa3c848d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b07ce43db665a6b5a622d5bb1447950d7e1e3fb1
Message-Id: <167760466108.26717.18016265645477587236.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Feb 2023 17:17:41 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Mon, 27 Feb 2023 23:25:27 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b07ce43db665a6b5a622d5bb1447950d7e1e3fb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
