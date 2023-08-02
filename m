Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF7F76C214
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 03:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjHBBS7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 21:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjHBBS6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 21:18:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1151FEE;
        Tue,  1 Aug 2023 18:18:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-267fc1d776eso3708783a91.2;
        Tue, 01 Aug 2023 18:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690939137; x=1691543937;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C9gsGeQ/LoJ7llZZGLwajHjT5nPFz20stmvofsT7eEA=;
        b=hnpOzrgKD3dQuM4yqYvt4tt6Ek4eSllhDzfOwXlcWc8TqgDQM1sYqM2yVUl/X057+o
         kgxbSxQnmLzZErVjfDyWaR/vvUWsv5h2fncNBb7ywm2YoWPex0Z/ls9QgCL5YYCBq+Hx
         LPVzCIh0eOYWfCkO/B7oPHs1gJjFKfXubHoD9Z/BWhjgDuJL/1v3fQ8Rt3jpfNyOepE+
         3PEtdxTW/lTviSTPD7ePAekCh9h/GbsllHrim4nsFFFwulPwOAcIw+zN2wgAtuiFm2fa
         SB0Rul9bEsu1rHGCIgg6lS3Q4UNO04XeynaQuVa7U5rEwenxqcS08mEiGYR6FQF79PDZ
         3g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690939137; x=1691543937;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9gsGeQ/LoJ7llZZGLwajHjT5nPFz20stmvofsT7eEA=;
        b=h/10yr55gzplYUqy0c/VXFXNR3MWg+cB2LMDouu8QHcVswi30W7hfUlo6TWBp0FY8r
         aPwGXX9avrou9h7t2mi7Z1az9I+biHFdc+1EN6P9TYKEMhQqcG5XI770NMN1Qauz6Nqz
         syT02typsTUwLYBeEMQpieAc2nt4BvE947/A5emyYT+GHtphwLj2wZYJyGtA7Tuk7FD+
         1l/ZE3WYWZrRAyLrwnIksmq5aKUDvTkvBvFsDZ0viCyx0vPzqR17p1yMQrRMMb72xCMJ
         G7f/yavVfmDVB/GIxz3f8JrPyUekVfof2Gwc1XUREBLFt2dMk7naYvpTnukg61wNJ+kO
         obaQ==
X-Gm-Message-State: ABy/qLYmKQpRZgmTDsCQan3DRDiLxRimpgmAma/fBcqxEa0dXrxWS3kN
        EFcnWlzfRsHq+4m2dMXz+Wo=
X-Google-Smtp-Source: APBJJlGpPVwc7ynSZAI6vPxs2mlQtplvGO8izFBz9z+1eRRoSy/ljEQzYXnR17cHvgcHUHEN/UGXhA==
X-Received: by 2002:a17:90b:1c84:b0:268:557e:1848 with SMTP id oo4-20020a17090b1c8400b00268557e1848mr12667735pjb.2.1690939137055;
        Tue, 01 Aug 2023 18:18:57 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id c8-20020a17090abf0800b0026814d83a5asm104773pjs.26.2023.08.01.18.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 18:18:56 -0700 (PDT)
Date:   Wed, 02 Aug 2023 06:48:52 +0530
Message-Id: <87v8dyw8ar.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH v3 10/10] ext4: correct some stale comment of criteria
In-Reply-To: <20230801143204.2284343-11-shikemeng@huaweicloud.com>
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

> We named criteria with CR_XXX, correct stale comment to criteria with
> raw number.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index bfaab173a3f4..1e8ce0ece47a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2782,8 +2782,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  
>  	/*
>  	 * ac->ac_2order is set only if the fe_len is a power of 2
> -	 * if ac->ac_2order is set we also set criteria to 0 so that we
> -	 * try exact allocation using buddy.
> +	 * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
> +	 * so that we try exact allocation using buddy.
>  	 */
>  	i = fls(ac->ac_g_ex.fe_len);
>  	ac->ac_2order = 0;
> @@ -2840,8 +2840,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  			/*
>  			 * Batch reads of the block allocation bitmaps
>  			 * to get multiple READs in flight; limit
> -			 * prefetching at cr=0/1, otherwise mballoc can
> -			 * spend a lot of time loading imperfect groups
> +			 * prefetching at inexpensive CR, otherwise mballoc
> +			 * can spend a lot of time loading imperfect groups
>  			 */
>  			if ((prefetch_grp == group) &&
>  			    (ext4_mb_cr_expensive(cr) ||
Is this function defined at any place ^^^

-ritesh
