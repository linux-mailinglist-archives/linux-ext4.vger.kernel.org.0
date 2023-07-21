Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86C75CC60
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjGUPsQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjGUPsP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:48:15 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7151830F1;
        Fri, 21 Jul 2023 08:48:12 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b9af1826b6so1731986a34.1;
        Fri, 21 Jul 2023 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689954491; x=1690559291;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I+lc7PzFgkp3GKXUtrK1ybJfIk54Omt/+aJOtUlCWbM=;
        b=oeebBto0W9ULoAB1dsBdG2FEDhXHR04mBisI9B0S2BRPniASxMd/VwaEXB65nhnA3M
         kbDmeKEk64UcHIIQoDBZ9Ac2XvW6r6aQY+gXUOdbFiGKJKktvoZw6iIFCP11n5n+vC8C
         K6BXoXOhWx49rog5ADFh/y8egOn/NRWcFdBui/+uxPltI8T6ErpIImc3I5pbDkgv0wXC
         S6+FWRKX6wFkp84Lfs9+YJXv7/mbUrmL2W0Yp4NDRmc2ah161v0MUrYtKJJvALS6neZm
         PqusY4CDtswXLxMy41ilvQ/LnCQBhzdx/dU0monvegCnXPCfI5ohmu9fWy2q58IKvltb
         DC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954491; x=1690559291;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+lc7PzFgkp3GKXUtrK1ybJfIk54Omt/+aJOtUlCWbM=;
        b=joWtZlLE+S1SuKyeOzbWAnf19sIzCwPxHzgWMAWJ1ygmUpLvVBADBTjP/fhscSvvwF
         gnCJFXRWp8xWqIUL9jhRM3EBaLJHnQV76oqWelEapc24Uz+/leEVjY6ZJ3bs01CZNKrA
         JLsC/RxdHSxGKja0eAsrAdq3GJfs+y+7ItXbLGLoR0Lue4j3UbAyjJzIEdq3ANc86tip
         97gmwYQrASA44xHKS/cBCZghsTQZ86Mg94SmsePSJ7H7FeRVxqpuz6fRBXb9qFXWb9Ov
         fpSzJdPh89V1rAOQj4AXDXHsPinF+O1py9pootBTocmBa+vYeNUfW2O1NkNPWv/g85wX
         J3vg==
X-Gm-Message-State: ABy/qLav4J2LvSmP73tCviICe8ppG5dsgMqjtIsKmaS0mfyJCLSlDRPw
        1eOW7z0qUrj9raBqutKCmnU=
X-Google-Smtp-Source: APBJJlHcjmBFeyumgnAdk+a8rjrWgalwAbM3ZvWz5swn+YntIO6wn7r6jX0r2XdH+xQVgMDxs2eRzA==
X-Received: by 2002:a05:6358:2619:b0:135:57d0:d171 with SMTP id l25-20020a056358261900b0013557d0d171mr326488rwc.15.1689954491314;
        Fri, 21 Jul 2023 08:48:11 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id p20-20020a637414000000b00553c09cc795sm3229306pgc.50.2023.07.21.08.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:48:10 -0700 (PDT)
Date:   Fri, 21 Jul 2023 21:18:07 +0530
Message-Id: <87v8edjmfc.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 09/10] ext4: return found group directly in ext4_mb_choose_next_group_best_avail
In-Reply-To: <20230721171007.2065423-10-shikemeng@huaweicloud.com>
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

> Return good group when it's found in loop to remove futher check if good
> group is found after loop.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>

Looks good to me. Feel free to add: 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 6f8e804905d5..b04eceeab967 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1043,18 +1043,16 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
>  							ac->ac_g_ex.fe_len);
>  
>  		grp = ext4_mb_find_good_group_avg_frag_lists(ac, frag_order);
> -		if (grp)
> -			break;
> +		if (grp) {
> +			*group = grp->bb_group;
> +			ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
> +			return;
> +		}
>  	}
>  
> -	if (grp) {
> -		*group = grp->bb_group;
> -		ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
> -	} else {
> -		/* Reset goal length to original goal length before falling into CR_GOAL_LEN_SLOW */
> -		ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
> -		*new_cr = CR_GOAL_LEN_SLOW;
> -	}
> +	/* Reset goal length to original goal length before falling into CR_GOAL_LEN_SLOW */
> +	ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
> +	*new_cr = CR_GOAL_LEN_SLOW;
>  }
>  
>  static inline int should_optimize_scan(struct ext4_allocation_context *ac)
> -- 
> 2.30.0
