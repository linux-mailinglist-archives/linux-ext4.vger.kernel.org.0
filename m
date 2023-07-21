Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ED975CB94
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjGUPXc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjGUPXQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:23:16 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5683C35;
        Fri, 21 Jul 2023 08:22:54 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9ed0831bcso1703911a34.0;
        Fri, 21 Jul 2023 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689952974; x=1690557774;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sc/DTasP+qpzciCLfF1JlTQRXfUStyF2Qp67Z3I2zcE=;
        b=mwNakMTygU7aeOlyMGN+1YRXfckEAaBjZjgrsxiGExbe1JtrAWqD07Qye6c9hqpqhS
         NSvfGLEod46/FYQq+BwuOs10pt7FBKcScPwYNc1gpP2IynnNI8Oug1W4oRjPO1Q7VT/Y
         qzCI5leeaCHf2iXugSrEa+TfozQZie+QYDxT7Qh5nLDHkaZe0XCUJvvL2+ZxvDrj2oGF
         ijotZv1mRYKioa+esPC95sZ5tz4XnRunRYMqfOVzo0YiZTLoxiKmrABWm+cT+oeLe7dU
         MKOSID+fJHIDH+uW2wNvxrRALEMUJaPLjChWlftPk7eV+SO77w8Wxu33Abumu2mVemXw
         ol/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952974; x=1690557774;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sc/DTasP+qpzciCLfF1JlTQRXfUStyF2Qp67Z3I2zcE=;
        b=ATMrs7YIeI8Esu5zuOuPywuZJK+2RVJHkqzh94ocRV9VwReKY1+ceIuMLcn1AVEdRt
         ujDgAG0bVzeMG1DBgRI88cn8ADZ1ldnGQF/MGpJUx4sJS/EFduuBqaPt5iK9mkadEA11
         2lj3OJ4b3jkBTyfYCHr/hs2gtdb3FmdSM/8eFGXP+TRSBHKO905vZqPCXNwBxhEyyePY
         lpaWxolvj95CUFKY8ugeI1lLh0Tv3Xg3gRjNiinYj5KC60EcDBvwURXsA3Y7rxaJPsVk
         bQImkzKGYdsWazGN08vQjL1p1su3xJLh2UxreEgNqA2nAgjiYAmMIC7JGgBtsuzbsAPb
         gYyA==
X-Gm-Message-State: ABy/qLbPFHDqGr1aLUUtOFCZe3gEJbYCGtc0Ukt48zMVEozecGFJ3zrF
        tYuXo6JIUvXgrn15WqyyWsejOREgf0s=
X-Google-Smtp-Source: APBJJlELpyaxYg1wg936x5ogzeyFoPXGq5hxdNV11us7uI9wcb5a/Zg9CQORzMhqmGM2od+F6//YSA==
X-Received: by 2002:a05:6808:2897:b0:39c:475e:d78a with SMTP id eu23-20020a056808289700b0039c475ed78amr2307330oib.17.1689952973691;
        Fri, 21 Jul 2023 08:22:53 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a01c300b00263c8b33bcfsm2878401pjd.14.2023.07.21.08.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:22:52 -0700 (PDT)
Date:   Fri, 21 Jul 2023 20:52:49 +0530
Message-Id: <87iladl25y.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 01/10] ext4: correct grp validation in ext4_mb_good_group
In-Reply-To: <20230721171007.2065423-2-shikemeng@huaweicloud.com>
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

> Group corruption check will access memory of grp and will trigger kernel
> crash if grp is NULL. So do NULL check before corruption check.
>

Fixes: 5354b2af3406 ("ext4: allow ext4_get_group_info() to fail")

> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 3ab37533349f..90ffabac100b 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2554,7 +2554,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
>  
>  	BUG_ON(cr < CR_POWER2_ALIGNED || cr >= EXT4_MB_NUM_CRS);
>  
> -	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
> +	if (!grp || unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))

maybe like below?
      if (unlikely(!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))

-ritesh

>  		return false;
>  
>  	free = grp->bb_free;
> -- 
> 2.30.0
