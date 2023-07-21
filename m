Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB875CC4D
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGUPp5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGUPp4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:45:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36D5171B;
        Fri, 21 Jul 2023 08:45:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b89600a37fso13503825ad.2;
        Fri, 21 Jul 2023 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689954355; x=1690559155;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H8EVjmEF1PC6BFutgsm7sY/zDflhdcRqTFA4NcPqT9Y=;
        b=ZoMPoD1///6JXtY5UlkEA5f/UptjI9MSZi9re4nRDRiN6ZNu9q4yLLrkOcZMzJLNlG
         NIF6Fr8C32HjdW4blfTOaECkuPzoKAmwd51pqbkDhWyMPFxE57w5wv9B5Nmkp3dFiHXE
         vZ91oJXyHRBExgVwK+1ko3ZuXGyR+mbUl47M41UMOUYe8dxJWnBheybdUTnvS5SiOJHV
         1zOBrDlawuzhpddxLYhTgNb0D0zmJqlDcBBGQSaYKoW8hXFaPpDzgs6abVTiVdVeT5Kr
         IKZxP59ES0ve9neJoB0itBJS7WJ8JUqVYMVxyjCk2GJ6KgEoysRNyvq1H+Dqlp+lSk+f
         V76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954355; x=1690559155;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8EVjmEF1PC6BFutgsm7sY/zDflhdcRqTFA4NcPqT9Y=;
        b=Nv3JtM+P2lVk8ewa+tlxI8BCmalakxY/HYv/jJNmo4tjIWUGZTVDVjtrdsKJAEfdxS
         W9EJu46lwNelSn788+Q51RsxZrGPk7M7QEN1Jz0K5Vok7aKAw/6i8zNeU147qVV32j8W
         cpwWPRC4C+FtITLdGgQ+kCUV5sp2/73FeeQNS8ERuELabBmN3yJ0RpD3HHMrlnBG30Sn
         QEf8vtj6moHdKUYuSb1rYTZp3RVIo9PdB3l/xuz2HV7IlLs3DyEov/3L3lF3Ee/w8xuy
         tKfuJzCtWjy4YjXS28nllIh4ajxynwJaaICMSHR4+okXY00mt2AQDuPYsnsqQhylM8mm
         fLCQ==
X-Gm-Message-State: ABy/qLaUxkesLrGFwdDqBbHr8hcJZ71DTDHD4aGUpYt+cODtJdP+39eU
        4KSDyANS3ZR4e6tA+3UdnT4KE1xhCfE=
X-Google-Smtp-Source: APBJJlF2P6idsYUhytjzrZgXRjvCIBZIPKZpcVUNrzTnvKvd7JJf4aQdomf8o0m57HvADmrw6czSeg==
X-Received: by 2002:a17:902:c946:b0:1b8:78e:7c1 with SMTP id i6-20020a170902c94600b001b8078e07c1mr2254014pla.51.1689954355459;
        Fri, 21 Jul 2023 08:45:55 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709027c0f00b001bb4f9d86ebsm3682297pll.23.2023.07.21.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:45:54 -0700 (PDT)
Date:   Fri, 21 Jul 2023 21:15:51 +0530
Message-Id: <87y1j9jmj4.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 08/10] ext4: return found group directly in ext4_mb_choose_next_group_goal_fast
In-Reply-To: <20230721171007.2065423-9-shikemeng@huaweicloud.com>
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
>  fs/ext4/mballoc.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)


Looks good to me, feel free to add: 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 412d335583fe..6f8e804905d5 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -960,16 +960,14 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
>  	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
>  	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
>  		grp = ext4_mb_find_good_group_avg_frag_lists(ac, i);
> -		if (grp)
> -			break;
> +		if (grp) {
> +			*group = grp->bb_group;
> +			ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
> +			return;
> +		}
>  	}
>  
> -	if (grp) {
> -		*group = grp->bb_group;
> -		ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
> -	} else {
> -		*new_cr = CR_BEST_AVAIL_LEN;
> -	}
> +	*new_cr = CR_BEST_AVAIL_LEN;
>  }
>  
>  /*
> -- 
> 2.30.0
