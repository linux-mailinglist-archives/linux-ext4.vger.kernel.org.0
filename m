Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46C5F7267
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Oct 2022 03:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiJGBBi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Oct 2022 21:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiJGBBf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Oct 2022 21:01:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26924BA255;
        Thu,  6 Oct 2022 18:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE21861B8C;
        Fri,  7 Oct 2022 01:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F3CDC433D7;
        Fri,  7 Oct 2022 01:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665104494;
        bh=XgQPgDh10tj1gddINJYdsJGlEjtU5fqOe3GB01kXops=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N/ER5EnxG4oq4uzruZblOaXvR70Lncfs4H4Z1xoNe9WqmtjF2A8qZaakNOutUQiE7
         8SvksN15Mo7CaLFHRJQK27b4b4KMfwURdDLZeCjPtRbHTE8vZ3lryOdxtlNmQ9xoCk
         9eOkn4CT2H85CwoqrfcvZH3ibiRWX9oUMbwruiQUwh3zkp6TA2P6wQqhERLBLHWhHR
         yHqSd7x6ScDnqUtp+5OZ8+2KjCkIEKcL5TjcGzphm+JV6Y8Onv3MDK5vTFkC7cYslh
         wizTiu03wJ3m1ww0oHEy6LE2Baxmq3SxfaxoCHEvCNuFb0V6F506RmQtFxebGCXwMS
         fvZdQt4PiDb9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CF29E2A05E;
        Fri,  7 Oct 2022 01:01:34 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 changes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz0B+L+vHKIARzKj@mit.edu>
References: <Yz0B+L+vHKIARzKj@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz0B+L+vHKIARzKj@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 1b45cc5c7b920fd8bf72e5a888ec7abeadf41e09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc32a6330fb0e90d1ce813c720d50098a41ec2e6
Message-Id: <166510449404.27686.7857889008788375375.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 01:01:34 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Wed, 5 Oct 2022 00:03:04 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc32a6330fb0e90d1ce813c720d50098a41ec2e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
