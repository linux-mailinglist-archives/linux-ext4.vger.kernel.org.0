Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B2675CC42
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjGUPoj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjGUPoi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:44:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC14B30F4;
        Fri, 21 Jul 2023 08:44:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8ad356fe4so14074305ad.2;
        Fri, 21 Jul 2023 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689954266; x=1690559066;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0C0eYVS5aZxLIEA0bvGPWh3Sq+ItY12rccZjuCJYqlY=;
        b=BILLxXLlNvPQqwB5FA+1X0gIPlI1ZQ19zK9WKseGjuUW1maG9lcM95NBJIjyJHopLg
         XIfPdx3QfKs2e0GV9mrvqDey+RmJK5zViir7eBOiZiEzkBywhFGgcnI8u6/+Go9M8u/j
         FG5CapSXMEUAjFDT3E44jrCtppLprY+xAIw/sQYNCvtzr5aDmweNm2Lc4K2jQdrom6ea
         7VZmwXYeFxorKuOUfSJCSGW0FO8ByMxmutFk5DtctgrviGGYlEWb+/zDGc8eFAxq9V0q
         reH1fiIyY9/BSxITWb8pXDv1vyGjePTKeThFVWkgHbNCRSgto/LMQ5IC3u0HCbsBOYZL
         6PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954266; x=1690559066;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0C0eYVS5aZxLIEA0bvGPWh3Sq+ItY12rccZjuCJYqlY=;
        b=NT9gpzolE5eg65fVxaSjYY12bbQ5Fj8we/zAahbYTaEDwNQYutQQ8Y1WmA3lhgWaaP
         d15PbBhL9ExAaonuk9KdHLXhG8Kx2Y26jnoJpbuWT86IPccJvVxoYiVWRJewjfQ35JLP
         yLDTKIM9ku8Cg6hGASTyY3t1Om5MrPGfGmmHI0/c4Um5ScjmyqFMr8IeeOcS3RYbTAWL
         Gm0TPIcJg8/fLS5u56cJxi+5pDajueghOrTQipOeNF7Lewvh+ZfSLRP9aGjK4RxtnYNt
         wgdqiuc2q8Lk4m016+gROftN5jQ1qP5cE8sDh2tF1LShWq2gauguTfDPLdLjd0zlUKfv
         VXQA==
X-Gm-Message-State: ABy/qLbuqO5aN5edQy4bmWUbHoQrbIGE5Z7uGfUDu5WJ9PCjg1ow7QhX
        INRMZlVo9u1xBazXp6Iv+M0=
X-Google-Smtp-Source: APBJJlFHaUtbw7eTFgxquz6Uhipl8aggtFzyUBrFBajFTm3NW40ysRzX9RlNLRnqftOrVBzEHfvZWw==
X-Received: by 2002:a17:903:441:b0:1b8:901d:cfa8 with SMTP id iw1-20020a170903044100b001b8901dcfa8mr1674422plb.18.1689954266062;
        Fri, 21 Jul 2023 08:44:26 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902b78700b001b8a3dd5a4asm3624566pls.283.2023.07.21.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:44:25 -0700 (PDT)
Date:   Fri, 21 Jul 2023 21:14:21 +0530
Message-Id: <874jlxl162.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 06/10] ext4: replace the traditional ternary conditional operator with with max()/min()
In-Reply-To: <20230721171007.2065423-7-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> Replace the traditional ternary conditional operator with with max()/min()

sure. 

>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Looks good to me, feel free to add: 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 78160bf5b533..412d335583fe 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6699,8 +6699,7 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  	void *bitmap;
>  
>  	bitmap = e4b->bd_bitmap;
> -	start = (e4b->bd_info->bb_first_free > start) ?
> -		e4b->bd_info->bb_first_free : start;
> +	start = max(e4b->bd_info->bb_first_free, start);
>  	count = 0;
>  	free_count = 0;
>  
> @@ -6917,8 +6916,7 @@ ext4_mballoc_query_range(
>  
>  	ext4_lock_group(sb, group);
>  
> -	start = (e4b.bd_info->bb_first_free > start) ?
> -		e4b.bd_info->bb_first_free : start;
> +	start = max(e4b.bd_info->bb_first_free, start);
>  	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
>  		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
>  
> -- 
> 2.30.0
