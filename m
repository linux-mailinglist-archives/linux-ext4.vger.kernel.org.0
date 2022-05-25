Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA5533632
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 06:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiEYEbJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 00:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiEYEbI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 00:31:08 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1258EC0C
        for <linux-ext4@vger.kernel.org>; Tue, 24 May 2022 21:31:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j6so18179360pfe.13
        for <linux-ext4@vger.kernel.org>; Tue, 24 May 2022 21:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5x7MUMdEyFirTSYVzSr3Vrb0PAT7cLfbzo8HjZ4wCWw=;
        b=dvIqBDBBbvPN09MNLVuqUtkhrKvhuezKj3WCgsja8rsaQX/QBdEsLYl+cjeBmvffaa
         J//bEhKxllEgde0/bxVUhI51eUGJ5IzzLIAJGC+dOQkmiWiORxqT+BjeWGZfZp2IUPd/
         z8gigkaX0Y5LbTqBLBBR8rLm/8EmORyz6reNZj2mcLsXrNq9+p9LpBwmaKErieaP7hO8
         GzVjesDSGLFlGWMTcNLMRVYTRjdLPVLQaFVjVuHBQCMrG46NL+i/W06i2TbEsur3xL/g
         KLkccjk2XXKU4jVT5Z6a+KndlY/JBtfWtAlYieDkDJ2Zqi7b1TD6va9/yjB0ASrFiw/A
         BYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5x7MUMdEyFirTSYVzSr3Vrb0PAT7cLfbzo8HjZ4wCWw=;
        b=RTPkHzQmD40Meok1BxMLs+EiV13q0xT9sNkUlPMlXBnN9d7OMY91fuuetmnzu5zgtY
         Er9p8a8QqzVHckiiwUNwEpKXBFjW0d2hRTzcY3aOtZhE/3vYl5htI5WoVmzQMfYEM5p1
         WmNxHyWBV50byHwhS1Ecngc8WnvMEAHFnvz5JVzLUaaeg+kkCN2tnLpUnXV4ywhNqy1W
         O3yRKqDRPNE82VlEA7i5YVq7U6rqUg7UvksLjxWAtewjgpnKPNbXWY/hQSrwlFHvt6CP
         uikaapGlGiqbrWv36J/tCnX5FHv8Whfla66QGqoYa96EUbN0z327h4lqELKcQ7qEfKtp
         44iA==
X-Gm-Message-State: AOAM530D/rXXV9DkPr9Ep/M2OBpRcfi45sFmIF5g5XQ4BwRxRGev8+yV
        p1EIwcISlCpyRt3e826/Ris=
X-Google-Smtp-Source: ABdhPJyeormJk0+q02LeKLD7rVmnerGWyzwNH7AFutmya629H9LmhhpGaFk2K8t8R/Wv6FWeViHOFw==
X-Received: by 2002:a63:680a:0:b0:3c2:7c45:c0ab with SMTP id d10-20020a63680a000000b003c27c45c0abmr27412916pgc.63.1653453065571;
        Tue, 24 May 2022 21:31:05 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a782:286b:de51:79ce])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ecc500b0015e8d4eb1b6sm8225348plh.0.2022.05.24.21.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 21:31:05 -0700 (PDT)
Date:   Wed, 25 May 2022 10:01:00 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Shuqi Zhang <zhangshuqi3@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, tytso@mit.edu
Subject: Re: [PATCH] ext4: Use kmemdup() to replace kmalloc + memcpy
Message-ID: <20220525043100.qi7m2yve6r4htb2x@riteshh-domain>
References: <20220525030120.803330-1-zhangshuqi3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525030120.803330-1-zhangshuqi3@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/25 11:01AM, Shuqi Zhang wrote:
> Replace kmalloc + memcpy with kmemdup()

Thanks for the patch. A straight forward conversion.

Looks good to me. Feel free to add -

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

>
> Signed-off-by: Shuqi Zhang <zhangshuqi3@huawei.com>
> ---
>  fs/ext4/xattr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 042325349098..564e28a1aa94 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1895,11 +1895,10 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
>
>  			unlock_buffer(bs->bh);
>  			ea_bdebug(bs->bh, "cloning");
> -			s->base = kmalloc(bs->bh->b_size, GFP_NOFS);
> +			s->base = kmemdup(BHDR(bs->bh), bs->bh->b_size, GFP_NOFS);
>  			error = -ENOMEM;
>  			if (s->base == NULL)
>  				goto cleanup;
> -			memcpy(s->base, BHDR(bs->bh), bs->bh->b_size);
>  			s->first = ENTRY(header(s->base)+1);
>  			header(s->base)->h_refcount = cpu_to_le32(1);
>  			s->here = ENTRY(s->base + offset);
> --
> 2.31.1
>
