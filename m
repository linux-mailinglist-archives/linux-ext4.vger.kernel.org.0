Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252C06A2307
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Feb 2023 21:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBXUHN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Feb 2023 15:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjBXUHK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Feb 2023 15:07:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BD682B1
        for <linux-ext4@vger.kernel.org>; Fri, 24 Feb 2023 12:06:51 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f41so545535lfv.13
        for <linux-ext4@vger.kernel.org>; Fri, 24 Feb 2023 12:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9QGwqMZILZGWGNjfm+UfhBSt5eXmjwNSKZqGNWqpyk=;
        b=JY8ihR577jIw7BJVrkc9KT77G/y3faaRwPaCdSil/NJB788Ta/I+a4aJDpfrCzqehu
         kxThWx4ZbUBxhUGs6XWS+9Xkv4tSYa+m0gLggfjEUmV9xU+vXajd8tg6rzzK1Thh8aBI
         mk3rTlgGErIn2nP80XTQKGQLKMgLlY51zVzsJ2FKcfGX3qicaYdPZhWb+X9Lssn+6g3t
         Gcu5++F7gz0N8NuI5bdsqLnO4nTkNyd1x/q1+sh348o4dj9vpFiv09ajkT9vxfACVI78
         vRDSrAm3w5oMkIHMNoO3oAS6tEx6wvyv5iKgdIownLIRLohQpKC/6lgN/UOP/dFXXvGo
         S9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9QGwqMZILZGWGNjfm+UfhBSt5eXmjwNSKZqGNWqpyk=;
        b=NBIEvX79Y3aalxUBNuh/J9rJWgbE6baNzUkRFcGxcRN7p6gnEDKK0b+x0pOspwsQIg
         f0hdvakt8fgZFrjEWShuCVmYp+3xxqMmmOSLAPnbOB2vA5bxn2WSyd780K7Ry2xvo0bW
         PXcTc0JMtho5gjZl3llIdl7YqCDDg09x42Ariazh6zm3hz9ho7ha8JENK2pKmIDxS18y
         FjJZ8huXyw3Qa9GfvqE1t9BC7Wh4BHiIs0XgZJ6eyjKqSpnFJnviX25hqvz0i+l77W47
         y8WdgcrZebXMs/2iR4LKPCU47ltkWbPxa3STD2GHbNPtG8oQ1TjJIni8Azfphr7KRjIw
         OMKg==
X-Gm-Message-State: AO0yUKWKUJFKtXq5+aURcCuvScyMXqGQz9Sr2SNU9+05yA6G/EBafHRI
        mCW4y/UOmtLgiGNdN2/Rcn6XHw==
X-Google-Smtp-Source: AK7set9qdm53PdnYWxItcti/zXy/GtzaDie9srSAlgeWQmKRRXNGtlVLp3vrvVVo4mDHlWIXG0HoKA==
X-Received: by 2002:a05:6512:4022:b0:4db:3902:c709 with SMTP id br34-20020a056512402200b004db3902c709mr265641lfb.32.1677269200342;
        Fri, 24 Feb 2023 12:06:40 -0800 (PST)
Received: from [10.43.1.252] ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25e83000000b004d8580b2470sm1758120lfq.225.2023.02.24.12.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 12:06:39 -0800 (PST)
Message-ID: <bdefbbd3-c652-2d6f-bd38-b7de6b1b9155@semihalf.com>
Date:   Fri, 24 Feb 2023 21:06:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] ext4: Don't show commit interval if it is zero
Content-Language: en-US
To:     Wang Jianjian <wangjianjian3@huawei.com>,
        linux-ext4@vger.kernel.org
Cc:     zhangzhikang1@huawei.com, wangqiang62@huawei.com,
        zhengbowen7@huawei.com, Theodore Ts'o <tytso@mit.edu>,
        Lukas Czerner <lczerner@redhat.com>,
        Sarthak Kukreti <sarthakkukreti@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
References: <20221219015128.876717-1-wangjianjian3@huawei.com>
From:   Dmytro Maluka <dmy@semihalf.com>
In-Reply-To: <20221219015128.876717-1-wangjianjian3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 12/19/22 02:51, Wang Jianjian wrote:
> If commit interval is 0, it means using default value.
> 
> Fixes: 6e47a3cc68fc ("ext4: get rid of super block and sbi from handle_mount_ops()")
> Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a343e8047d..b93911d80cd9 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2146,7 +2146,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		return 0;
>  	case Opt_commit:
>  		if (result.uint_32 == 0)
> -			ctx->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE;
> +			result.uint_32 = JBD2_DEFAULT_MAX_COMMIT_AGE;
>  		else if (result.uint_32 > INT_MAX / HZ) {
>  			ext4_msg(NULL, KERN_ERR,
>  				 "Invalid commit interval %d, "

Hi,

Thanks for this fix, I just have some remarks about its description in
the commit log.

I think the bug fixed by this patch is more severe than the description
suggests: it's not just about showing or not showing commit interval
(btw I'm not sure what does "show" mean here), it's about setting
incorrect commit interval (0 instead of JBD2_DEFAULT_MAX_COMMIT_AGE*HZ)
when mounting ext4 with default settings.

Also I believe the "Fixes:" tag is misleading: it actually fixes commit
461c3af045d3 ("ext4: Change handle_mount_opt() to use fs_parameter").

This bug introduced in 461c3af045d3 causes a significant performance
degradation at least in certain setups, for instance I'm observing ~10x
performance drop in direct I/O write tests with PSEDN128GA17DC0 SSD disk
and PS5013 E13 NVMe controller.

Ted, I see you've already merged this fix into ext4 dev branch, but I
guess it's not too late to amend the commit message before it gets into
mainline?

Thanks,
Dmytro
