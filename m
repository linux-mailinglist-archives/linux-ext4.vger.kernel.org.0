Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD10764F6D
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 11:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjG0JVo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jul 2023 05:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjG0JVW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jul 2023 05:21:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF19E5FE8
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 02:11:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f74a8992so86821b3a.1
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690449072; x=1691053872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cACJ3NT7rSPHksG1CSCDv/QZVUluNTqq4KXvaW886oI=;
        b=lKnOasFRjAEbGh7P40XbzLKtOkahlmVFUDvqCWW3ZgaRuzNJSwp4sTaKgMwNwz+Jpc
         hA4nVDJPH5aqf4q8bVxcWLUkzXpK23oeAFnlJRwJaEUIleLrrgs7btXzJpx3+9HaPfQV
         hGIP/T6lERVA8hpdk6KZN9Q4J/+wilHe5ZItz/9QQ1qHO3gv2Y4k+BaS5cDcOKz/WLAL
         6NaRvNv6KF2mZ19RDXY6rbQZ5sQKyx2Yj2LrfaBgxjqmYdHbumQCN0WmWtbB+gjDIGzm
         PXmUTQGLOY5T8H3PnVo3H27NG4eQhipuKvHt4yAhK97ujnI+IJGqA8lmlUO0fy4wYeay
         +oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690449072; x=1691053872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cACJ3NT7rSPHksG1CSCDv/QZVUluNTqq4KXvaW886oI=;
        b=gIttAqhgXkhEVcWfWK03zDfiYEEldBHsveFefGBA329GVAhDkmzVODybfLu9KdQQC5
         hbwbuKIee6cI7KCHLsMv8QWdRd9VWzdQA4gEJa3V+loyfqvohXJErgSSxJwFXTbb2Uyd
         iXc6/5pOq0DM/Y2c98ZREDnldmxW31hb+sCFkeItdyRHna14rSvFLBUIZtwsDMWQJSmg
         AvliPX1zq241nFs0ePtYNfoAHEmVM3UwIJ3MIqJ1QnuPvRrcua4T+6q6jtOlL9+NVQhD
         idF+b2ZMcisVyk/9A2HOXp8h1C+pFGeiheTXTCgzSeCcJD7bNhNUvjgO86q6OVZiTXgd
         d96Q==
X-Gm-Message-State: ABy/qLaEGBgRRDih9P0O8zk8JZhJ5mBS8Ut12Secl11+OOwjAna80vvu
        o1XYul7Kxy6CUP81aEXI5iAoZg==
X-Google-Smtp-Source: APBJJlFfFWIsc+pfSeu4dzuDSzimKXTbXaekoL0gFKsbHel8kB/qljY4u0PtyM2mUW/wDh3jQGEPVg==
X-Received: by 2002:a05:6a00:2d82:b0:675:8627:a291 with SMTP id fb2-20020a056a002d8200b006758627a291mr4692915pfb.3.1690449072033;
        Thu, 27 Jul 2023 02:11:12 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b00682a99b01basm1038080pfo.0.2023.07.27.02.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:11:11 -0700 (PDT)
Message-ID: <1eb30b9e-c43b-b81e-4d96-5d6fa4f2894a@bytedance.com>
Date:   Thu, 27 Jul 2023 17:10:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 22/49] sunrpc: dynamically allocate the sunrpc_cred
 shrinker
Content-Language: en-US
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-23-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230727080502.77895-23-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/7/27 16:04, Qi Zheng wrote:
> Use new APIs to dynamically allocate the sunrpc_cred shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   net/sunrpc/auth.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 2f16f9d17966..6b898b1be6f5 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -861,11 +861,7 @@ rpcauth_uptodatecred(struct rpc_task *task)
>   		test_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags) != 0;
>   }
>   
> -static struct shrinker rpc_cred_shrinker = {
> -	.count_objects = rpcauth_cache_shrink_count,
> -	.scan_objects = rpcauth_cache_shrink_scan,
> -	.seeks = DEFAULT_SEEKS,
> -};
> +static struct shrinker *rpc_cred_shrinker;
>   
>   int __init rpcauth_init_module(void)
>   {
> @@ -874,9 +870,16 @@ int __init rpcauth_init_module(void)
>   	err = rpc_init_authunix();
>   	if (err < 0)
>   		goto out1;
> -	err = register_shrinker(&rpc_cred_shrinker, "sunrpc_cred");
> -	if (err < 0)
> +	rpc_cred_shrinker = shrinker_alloc(0, "sunrpc_cred");
> +	if (!rpc_cred_shrinker)

Here should set err to -ENOMEM, will fix.

>   		goto out2;
> +
> +	rpc_cred_shrinker->count_objects = rpcauth_cache_shrink_count;
> +	rpc_cred_shrinker->scan_objects = rpcauth_cache_shrink_scan;
> +	rpc_cred_shrinker->seeks = DEFAULT_SEEKS;
> +
> +	shrinker_register(rpc_cred_shrinker);
> +
>   	return 0;
>   out2:
>   	rpc_destroy_authunix();
> @@ -887,5 +890,5 @@ int __init rpcauth_init_module(void)
>   void rpcauth_remove_module(void)
>   {
>   	rpc_destroy_authunix();
> -	unregister_shrinker(&rpc_cred_shrinker);
> +	shrinker_free(rpc_cred_shrinker);
>   }
