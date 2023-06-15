Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26E673231E
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 01:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbjFOXKU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 19:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjFOXKS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 19:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7132976;
        Thu, 15 Jun 2023 16:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EBCE61F63;
        Thu, 15 Jun 2023 23:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C68F1C433C9;
        Thu, 15 Jun 2023 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686870613;
        bh=jhksP9WMMWlHDsaqSzyOkdl26kKD1TWUOXNLfAlMq2I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lQJFzaubKhXSvfTm1OVUfzy+xOvvd76HgYwwpF1SG4Mdd+jID+8MwZ/o/8oeQ3Bk7
         QwVq4ckKAFnj2IEFHvchCSjo3JRs63gAiAzNpj3P6gxDcg9lmcqNdX2IgUMWKugFAy
         XKj9xlRXm7GJD0JqoTa2ZBYYMJ8Nk48O0VjvKzeC7w9WKHHigvsOE94bFiW1h1z2yo
         OlXHg76krE2J1OeRDXiFEcL0DXspwSifQE6+yA3nbXnSrh6Mbclk3wrFLsBMcea8QD
         ZLCzDKe52YVTzRllHyHwtfH8NjOgEaKEVClZEx4R3DKKI9KTpahT5ASh/UlgO7PNM5
         RTWCOPpHX4JvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B320FC395C7;
        Thu, 15 Jun 2023 23:10:13 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230615205546.GA323671@mit.edu>
References: <20230615205546.GA323671@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230615205546.GA323671@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: f451fd97dd2b78f286379203a47d9d295c467255
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62d8779610bb7a7b8f9c7ab8bf317193ebe76d93
Message-Id: <168687061372.8077.5573958266552631827.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Jun 2023 23:10:13 +0000
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

The pull request you sent on Thu, 15 Jun 2023 16:55:46 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62d8779610bb7a7b8f9c7ab8bf317193ebe76d93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
