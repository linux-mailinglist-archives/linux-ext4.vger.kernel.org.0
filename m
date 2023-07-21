Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46BE75CBC9
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGUPcE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGUPcD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:32:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F532D47;
        Fri, 21 Jul 2023 08:32:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-262e839647eso1185223a91.2;
        Fri, 21 Jul 2023 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689953522; x=1690558322;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WIUnonEuz9s/GXG9WtFQfFvEvlsTMFF0HTxFInJ1mG0=;
        b=fJ4PUmtXNPGf0B0fr09V6fdwEJoTM9bq4O5PnJchACO0/MHwAJkBgzsCRUfyTSD22V
         D/0cLhvcSjVciOcvfpbGfZOEKKqdYANcmZY4pyxZ5To2nlyMoh21lMU4yAozTgqXpdZN
         zTsqUxrgau3vrU/GiqAlU3Y4cHAqkcAgKCySJ3r2jSGkQdS25nNLPZjskOx5+OOGH/g4
         LMWUu3Bnq6TeJ9uCTletrZ3LalufheQtxLRONEEjIo4Gvn2g0lRf636U579xSC/qbjvH
         92eioK0u3tHTPX2NjPhgbXongKpIWiZ+ROHRH/qffQQbMAD+edWziytCS174ICgEASfF
         9aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953522; x=1690558322;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIUnonEuz9s/GXG9WtFQfFvEvlsTMFF0HTxFInJ1mG0=;
        b=CZz7GB5OsgzKV4AmDxbeZOyq4dalgorYMo6HT7mncpPcnV0Tmc+V+CL2bUS1Hc1Q47
         4Ut0qXg+vtCImK0EOsNK3gzJFKsnlJXXk24eXl/McEwqmB62dezH+i/T33Joff99sRF+
         3EXpcgbqowOvUHjeg1AJ/LYKuhd8c2cVj+x/dOkwwEEi1hFg/b1K4SYEY7JIhNArjQvi
         sIlxxDrIGqORHQOL1xPmXL5nhVHrXrt02tYT+aagxte6K1QTv5t8G5xyoctCh6h/MAdR
         l1DSeVNbEGRYjrj23aJPH2SE9Gqn6Avsui+4t7QD945FBWn+rofGozt33G+5P/Zu+CNl
         QIuA==
X-Gm-Message-State: ABy/qLZWLz2liUsy6AIFsa9Y10qPJa+aJHLxRQ7l0H2699PXAoPm06xs
        joU6iOxacaLEumo6Ofg0/UU=
X-Google-Smtp-Source: APBJJlHuZyk1TVkN4lmw5V01/td2omLBXot4vw7QkvH2pFvC5VKpZFrU9L7xnfliJawoqdo2+uUb8w==
X-Received: by 2002:a17:90b:3887:b0:267:9767:d1a6 with SMTP id mu7-20020a17090b388700b002679767d1a6mr1949400pjb.3.1689953522182;
        Fri, 21 Jul 2023 08:32:02 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b0024e4f169931sm4327647pjv.2.2023.07.21.08.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:32:01 -0700 (PDT)
Date:   Fri, 21 Jul 2023 21:01:58 +0530
Message-Id: <87cz0ll1qp.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 03/10] ext4: return found group directly in ext4_mb_choose_next_group_p2_aligned
In-Reply-To: <20230721171007.2065423-4-shikemeng@huaweicloud.com>
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

> Return good group when it's found in loop to remove unnecessary NULL
> initialization of grp and futher check if good group is found after loop.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

Makes it simpler. Thanks for the cleanup. 

Feel free to add: 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 33ee3991f62c..4031f8e2a660 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -875,7 +875,7 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
>  			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> -	struct ext4_group_info *iter, *grp;
> +	struct ext4_group_info *iter;
>  	int i;
>  
>  	if (ac->ac_status == AC_STATUS_FOUND)
> @@ -884,7 +884,6 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
>  	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED))
>  		atomic_inc(&sbi->s_bal_p2_aligned_bad_suggestions);
>  
> -	grp = NULL;
>  	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
>  		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
>  			continue;
> @@ -893,28 +892,22 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
>  			read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
>  			continue;
>  		}
> -		grp = NULL;
>  		list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
>  				    bb_largest_free_order_node) {
>  			if (sbi->s_mb_stats)
>  				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
>  			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
> -				grp = iter;
> -				break;
> +				*group = iter->bb_group;
> +				ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
> +				read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> +				return;
>  			}
>  		}
>  		read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> -		if (grp)
> -			break;
>  	}
>  
> -	if (!grp) {
> -		/* Increment cr and search again */
> -		*new_cr = CR_GOAL_LEN_FAST;
> -	} else {
> -		*group = grp->bb_group;
> -		ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
> -	}
> +	/* Increment cr and search again if no group is found */
> +	*new_cr = CR_GOAL_LEN_FAST;
>  }
>  
>  /*
> -- 
> 2.30.0
