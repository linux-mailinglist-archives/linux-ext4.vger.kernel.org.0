Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53286599192
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Aug 2022 02:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbiHSAIE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Aug 2022 20:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiHSAID (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Aug 2022 20:08:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF266C8741;
        Thu, 18 Aug 2022 17:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BD4961780;
        Fri, 19 Aug 2022 00:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB419C433D6;
        Fri, 19 Aug 2022 00:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660867681;
        bh=DB5w81cqKm2F5lETmS4LCW82uo9MUw7j0b6cKhvjPgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqSlQanCirhntV3BXdcMMmvvjx/Emgg7+Lhjgq5V8zDG55Yd67QcDGxxL085wovIz
         CzodBqIGBF2qfjqDl0HLA7dDL2I9JTUANHSy/0iA++tRv3UcsJx2jRTqdzlyt4RSXA
         v6Pt40ZAz6LlqMAYgKFlAOl9TtIpJd+RXdKs53IUU9hQJtjameznnmM2/zP52Qamnv
         imB/KrfG5+piZK9bfR8lG2eWA2as88SvelzwDSuYtxvNxgZyfs7nu8y2TMbv0F2Rj8
         ASKT+4QqUja7ccsFDaBFTduQt6l2fjO/jkrM2xaIl2qtTJVgeF1WAMHLZXYoG9w9vz
         82BUAJCEwhIvg==
Date:   Thu, 18 Aug 2022 17:08:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lalith Rajendran <lalithkraj@google.com>
Cc:     tytso@mit.edu, dilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Make ext4_lazyinit_thread freezable.
Message-ID: <Yv7UYfFBmRTKXNc7@magnolia>
References: <20220818214049.1519544-1-lalithkraj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818214049.1519544-1-lalithkraj@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 18, 2022 at 09:40:49PM +0000, Lalith Rajendran wrote:
> ext4_lazyinit_thread is not set freezable. Hence when the thread calls
> try_to_freeze it doesn't freeze during suspend and continues to send
> requests to the storage during suspend, resulting in suspend failures.

Maybe we should just make suspend freeze all the filesystems in order?

https://lore.kernel.org/linux-fsdevel/20210417001026.23858-1-mcgrof@kernel.org/ 

--D

> Signed-off-by: Lalith Rajendran <lalithkraj@google.com>
> ---
>  fs/ext4/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9a66abcca1a85..d77e0904a1327 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3767,6 +3767,7 @@ static int ext4_lazyinit_thread(void *arg)
>  	unsigned long next_wakeup, cur;
>  
>  	BUG_ON(NULL == eli);
> +	set_freezable();
>  
>  cont_thread:
>  	while (true) {
> -- 
> 2.31.0
> 
