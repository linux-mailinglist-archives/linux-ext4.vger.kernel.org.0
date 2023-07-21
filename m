Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7305E75CC15
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjGUPie (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjGUPid (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:38:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BB73AB2;
        Fri, 21 Jul 2023 08:38:02 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e6541c98so1810722b3a.2;
        Fri, 21 Jul 2023 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689953868; x=1690558668;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zxnx8lrSqe0uz990cjnSJO7vRYkaiVW3a3/9IZfsk68=;
        b=O0YzOWVi/Wn1JTqPDmQe+S2wdjKPQgqFJhtKTXe4+I3/4Qye7ekdY+4Vgytcjn0/S8
         U2GAbqBlnRQicJXU3B2Tdte5XaFuI1L07MsiyXClOYXdA2GaBeHQUM4gfae2IuixSH7L
         jKm8l35YjPbjwq1vihvoaM7irkdUivCYB21TCpk7EShK2SF1fqqcWNNCYG+4iKi3J8Ou
         c0BYPYzvA1Aj8aNq/73/fw5H/eWuB3h6pSVw//6DF0qujREh6tujUibuPIxFnxGHrVgy
         CCbpg4g8qqpFrxHWMAn/p683dG/Gf7fntwlABNR92cUc4ptPXtlhCKEARf+0FyZs14s1
         9EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953868; x=1690558668;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxnx8lrSqe0uz990cjnSJO7vRYkaiVW3a3/9IZfsk68=;
        b=UGs1xPAlSPROrJ+RLhe1p70+P6v2JArFqA8LeFDxnFEWyPtpyYXpbWV55+ZRFWqDLW
         Qdg+Sk4iCADDVjUgMIkRyTRe8Nd4q7e4RBqWgsXHhdXcQR3wleg4QsM5/VA6rGlInSOA
         4jM9XrrMFJexgFnYTn9tX0xhylYsXAhPOHCSEhcNPpLMtpzaFaT7dk4ONtYG2pThGaAW
         Gs7m6wGAAW/7oObHg9sdDr0Ap1hdtkSNlUIa/JIVcala+AI8o359j6D8qzdlOo2TNPn+
         K4k+oO6EhJdYxB25qyWLi7cpKQX15BCHvbZiZBZ+AX1EZmiOO1p9W2f7Si7npeDewO7c
         w9Bg==
X-Gm-Message-State: ABy/qLaWtjkjojOayYfks0zq4bmMuXI8Ij6t+VNUa7VMLh7bZCtjpmYx
        fYhP5Qcg89JdoJ0Dc4vABJI=
X-Google-Smtp-Source: APBJJlF3N47eIDOtFT/muVpdRw493oWbGJCzEneKRhBEGWHKBg+F4kx5jZlirtbAVLpT4Z9Ew2Ttog==
X-Received: by 2002:a05:6a20:2d5:b0:138:58b:3259 with SMTP id 21-20020a056a2002d500b00138058b3259mr2602729pzb.35.1689953868504;
        Fri, 21 Jul 2023 08:37:48 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79116000000b0066a31111cc5sm3122547pfh.152.2023.07.21.08.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:37:47 -0700 (PDT)
Date:   Fri, 21 Jul 2023 21:07:44 +0530
Message-Id: <87a5vpl1h3.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 04/10] ext4: use is_power_of_2 helper in ext4_mb_regular_allocator
In-Reply-To: <20230721171007.2065423-5-shikemeng@huaweicloud.com>
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

> Use intuitive is_power_of_2 helper in ext4_mb_regular_allocator.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>

Looks good to me. Feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4031f8e2a660..b838944b5f09 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2795,10 +2795,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  	 * requests upto maximum buddy size we have constructed.
>  	 */
>  	if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
> -		/*
> -		 * This should tell if fe_len is exactly power of 2
> -		 */
> -		if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) == 0)
> +		if (is_power_of_2(ac->ac_g_ex.fe_len))
>  			ac->ac_2order = array_index_nospec(i - 1,
>  							   MB_NUM_ORDERS(sb));
>  	}
> -- 
> 2.30.0
