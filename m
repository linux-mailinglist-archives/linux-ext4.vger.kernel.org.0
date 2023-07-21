Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBF575CC72
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjGUPtn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGUPtm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:49:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C01BD;
        Fri, 21 Jul 2023 08:49:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68336d06620so1825260b3a.1;
        Fri, 21 Jul 2023 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689954581; x=1690559381;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HimBXaqllq26zQkYgjRuRe4b9hljrQWyh4an49zyCYE=;
        b=QZLeKXZKxP+a56BhL8fnTKdKFfRYJO9cinucv3D3Dt6mouiVOro22Qx1rw6Iv9gdUw
         63zDH1LeVKOon8uCOVZxvwcvnKNO541Ag4Lts65nIe8wtY1tnYMnyOLp6U1JL12ZI85H
         Z8xTUvh9043S9/fdzJLMlbP478i7IBBIqjfEXa6yoRIOFTquWumbQCFpesMum8a6+O6/
         dhXXLWrk9iRsH4gmqHUHs5s6z/g+FZbQPmk7fQMceVBg6QT4EiSCXgp3iDJYnwVGsIPF
         fenRj4Nk1q+ku1aeIxO9QScXid/z8yLzdUDdlXg/Z0eph3j9XvzYfKy29BF9S8Doy0XL
         E9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954581; x=1690559381;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HimBXaqllq26zQkYgjRuRe4b9hljrQWyh4an49zyCYE=;
        b=Chc33tJcTo6JbOT0jvNqYdIFXQHaK7ANnuB+ixZ/bEThr9FCYcFHvaYWe4Ag2uczjL
         8un6d4Tetw/wxB3hXenqjevDWujae3sfNXItSGERAce78I4H9jvTtoajpHx8hYzomM4y
         3ECUs0qaGc4klCkbjL/4MEt+Bu3wgJrIopGNnTl5Sb1lhz6LojrYcKkXmwcTqmYRkAeC
         z/AmT5FfnzsinCXNlgGnYSw/ovcMif4KybJ9/xx9RG/2yR2gtNCB5558qJStBKog8pL9
         A/5Jpea6Y1HZ5zwSmwmaoXhpWQxXrfPmrLqgN7//V2OFE5fgPfr/BVFgcmT9hNUwhh4o
         7Ohg==
X-Gm-Message-State: ABy/qLafr7gB169RPyqsGenCq4MWPpoAx6eEX+Nt8lNTlsgKw8xAPNTc
        MblQ3tVDzJ7MbJEjmeMdrYg=
X-Google-Smtp-Source: APBJJlF568lAOyJHJI+eaCy8LHBhtAHZBsKfFWF0AjojYslML8NCPgRI6OmzXqpqdBk42BvRgH9JpA==
X-Received: by 2002:a05:6a00:15cc:b0:686:25a7:3cf3 with SMTP id o12-20020a056a0015cc00b0068625a73cf3mr513234pfu.29.1689954581144;
        Fri, 21 Jul 2023 08:49:41 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id r6-20020a62e406000000b00684b64da08bsm3135187pfh.132.2023.07.21.08.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:49:40 -0700 (PDT)
Date:   Fri, 21 Jul 2023 21:19:37 +0530
Message-Id: <87r0p1jmcu.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 10/10] ext4: correct some stale comment of criteria
In-Reply-To: <20230721171007.2065423-11-shikemeng@huaweicloud.com>
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


Looks good to me. Feel free to add: 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b04eceeab967..e30494f3d289 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2778,8 +2778,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
> @@ -2836,8 +2836,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  			/*
>  			 * Batch reads of the block allocation bitmaps
>  			 * to get multiple READs in flight; limit
> -			 * prefetching at cr=0/1, otherwise mballoc can
> -			 * spend a lot of time loading imperfect groups
> +			 * prefetching at cr below CR_FAST, otherwise mballoc
> +			 * can spend a lot of time loading imperfect groups
>  			 */
>  			if ((prefetch_grp == group) &&
>  			    (cr >= CR_FAST ||
> -- 
> 2.30.0
