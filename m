Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B17E791C6E
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 20:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353363AbjIDSLS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Sep 2023 14:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353434AbjIDSLQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Sep 2023 14:11:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34017199;
        Mon,  4 Sep 2023 11:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89DB2CE0F95;
        Mon,  4 Sep 2023 18:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5532FC116A3;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851069;
        bh=kDblhT9YU6Z13oCtuFpW2rqTqYaBtsASH9dKHi3/gS0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KCIPdf7Q0FJfi462+L+9hLlIq0BX3t5I5nU+KyC3JUzPxLXnAhbxymMCPphIjkZk2
         nAsEm8alo/h9yzDnwp6A8LVb7rfbQMxy2RfjbpRRrEaQ/eBashGE75ZiLRId6mtGSt
         n174WOpZJUMdgC0EjnVVC2vm5+7uig8ReNTtltsXQsPxwJ4Heo6W2elu0nWCCAFa+P
         IPwUZr1zyeD6ymPLFhgxMaBz9kyOb8bPnob2+yLx+ge2NU+glqZFicKWUrFr0q5nEO
         oYTUotqMOD89YLI/lMJVg/6rp/a47wySfbJ7iLUnBpXB+H2O664scK9VXRyIFBHpkL
         AGY3UbxOXs2Pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F4B9C0C3FD;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/2] fsverity: simplify initcall and move sysctl
 registration
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169385106912.19669.17692351155547248889.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Sep 2023 18:11:09 +0000
References: <20230705212743.42180-1-ebiggers@kernel.org>
In-Reply-To: <20230705212743.42180-1-ebiggers@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fsverity@lists.linux.dev, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@google.com>:

On Wed,  5 Jul 2023 14:27:41 -0700 you wrote:
> This series simplifies handling of errors during the fsverity_init()
> initcall, and moves the sysctl registration out of signature.c so that
> it is not unnecessarily tied to the builtin signature feature.
> 
> Eric Biggers (2):
>   fsverity: simplify handling of errors during initcall
>   fsverity: move sysctl registration out of signature.c
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] fsverity: simplify handling of errors during initcall
    https://git.kernel.org/jaegeuk/f2fs/c/e77000ccc531
  - [f2fs-dev,2/2] fsverity: move sysctl registration out of signature.c
    https://git.kernel.org/jaegeuk/f2fs/c/456ae5fe9b44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


