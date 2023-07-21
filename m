Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA375CC39
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGUPno (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGUPno (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:43:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232E1BD;
        Fri, 21 Jul 2023 08:43:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so1847736b3a.2;
        Fri, 21 Jul 2023 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689954223; x=1690559023;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xLhJ2Vz/DBL0jxup+bhsa6b7Q7TYfiw1MNXSBag9bII=;
        b=KT+5Sg5NAkfgUSHCEDxcgyRDqWLZwte9oVPrKqIOqRfbdAMHqjSjeS3BNMCOacVuyc
         gPDhEO6jpeyp1yVPhm0KDxINVO2Aa/qfAXLTVDQO1TaWYI8AehtaPK3KLwIYP5jxQN0a
         7CAd0OjkB2gjUZx0pg5zcsGWTFeXMKDgS/nvLUcldZ861Ekx02ITIvSYXq8Ynqg+Xr3J
         1bW/duynVAoI4phrW8WhoqC45WYzoM9DxtGnOHE4nLkZVeOadAyp4fBnUhLYFLpQea0r
         IslDm3CrE3SUc9lDarI1wiNBTngsJr2QIjojrp9UUMnUUGHj0GZN5Lm6SXAu/Rzv25Sw
         ockg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954223; x=1690559023;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLhJ2Vz/DBL0jxup+bhsa6b7Q7TYfiw1MNXSBag9bII=;
        b=XlWEKPvChAifGBgDI9/GuuaJkRk5kdS7feZKa6oX5Y1G9j06U93/1xzOieKxiqlAJI
         xSC8cXM64PWJ8sICShkrSCfZ6a5kBI3qtsCe4c23QHaXXf01d4ILefLTxSixFCfL/DvT
         /FGQYi5tTHGot8PHfFAzPxRQzjehQe6Ar+MbEUcT8ixLJih45opl8qJ8goZEmdSLKOzE
         FRz1UjRiNpkSYAuLixKYY59qDju/vBgcnus2UcXHOv5TPDTvEJiyBMqBljJRy7ijkbu2
         hV4SsRI223hm+ldsLPeBL8Hcv//ed1mTQ2r5gX5JPeFtVKUOOaeKe4vW6kGBDaunMFmY
         5OjQ==
X-Gm-Message-State: ABy/qLaNCTt3zaMycy9Nz7YjtIFQILJwf3AbAL1cEfJv+8wiBtjW6RuA
        ojpzaN/3YqC+hS2J8qTs3xM=
X-Google-Smtp-Source: APBJJlFWA4jmzzyeoYmqiYhYJ/PiwyDHBkhhF7WRegyy+lHzzkuC3K8GQAwF/+IWDO8MkuvsfVKucg==
X-Received: by 2002:a05:6a21:9993:b0:135:293b:9b14 with SMTP id ve19-20020a056a21999300b00135293b9b14mr3004486pzb.55.1689954222771;
        Fri, 21 Jul 2023 08:43:42 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id a13-20020aa780cd000000b006863240ef3bsm3226586pfn.171.2023.07.21.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:43:42 -0700 (PDT)
Date:   Fri, 21 Jul 2023 21:13:38 +0530
Message-Id: <877cqtl179.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 05/10] ext4: remove unnecessary return for void function
In-Reply-To: <20230721171007.2065423-6-shikemeng@huaweicloud.com>
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

> The return at end of void function is nunecessary, just remove it.

s/nunecessary/unnecessary

Note, while applying this patch series on ted's dev branch, I got a
conflict in this patch. It's eaier to resolve, however you might want to
make sure that it is cleanly applicable on a given tree in v2. 

>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b838944b5f09..78160bf5b533 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4880,7 +4880,6 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
>  		mb_set_bits(bitmap, entry->efd_start_cluster, entry->efd_count);
>  		n = rb_next(n);
>  	}
> -	return;
>  }
>  
>  /*
> @@ -5634,12 +5633,10 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
>  #else
>  static inline void ext4_mb_show_pa(struct super_block *sb)
>  {
> -	return;
>  }
>  static inline void ext4_mb_show_ac(struct ext4_allocation_context *ac)
>  {
>  	ext4_mb_show_pa(ac->ac_sb);
> -	return;
>  }
>  #endif
>  
> @@ -5885,7 +5882,6 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
>  						  order, lg_prealloc_count);
>  		return;

Why not kill this ^^ return too?

>  	}
> -	return ;
>  }
>  
>  /*
> @@ -6470,7 +6466,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  	}
>  error_return:
>  	ext4_std_error(sb, err);
> -	return;
>  }
>  
>  /**
> @@ -6573,7 +6568,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  	}
>  
>  	ext4_mb_clear_bb(handle, inode, block, count, flags);
> -	return;
>  }
>  
>  /**
> -- 
> 2.30.0

With above addressed, feel free to add: 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh
