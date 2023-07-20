Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444E175B5D8
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjGTRsS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjGTRsR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 13:48:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F2268F;
        Thu, 20 Jul 2023 10:48:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b890e2b9b7so6360715ad.3;
        Thu, 20 Jul 2023 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689875292; x=1690480092;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XJqrP7qwrqABEsu1noQY7zuAl85Xjk4i3VEYj5fukiU=;
        b=gHcmSO1pwGxhsMvUsd+fglmy38LDeU/rdtD1hQgRIy69uf3GmZpc8HX0cO8td8P3ow
         bGRThf06JCjl+5Ruc+cDYAxl0njCR3Mc4m288lCnxjXiapdRDY8pgnu6FRNNtk9s+M7D
         3yHMdKJO+q+okR5CaTxQQ+mcR2CsoCyviuSt7RQhJr2ogDbQk6ivuRLhjkfXjJAdt1J0
         UReKTfyOeoM/uPKlPyCqN2l8cMtN9+BWPn3IT3Urb57Psj8wCI/DWiKB27f+8IFFGcbT
         MMnDNdqEIH6qXz+6jq7Y7iQNFt3HzNOMwur5cw51PEd3kqQByvkk3YzGdSCZ33H5fr+F
         kbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689875292; x=1690480092;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJqrP7qwrqABEsu1noQY7zuAl85Xjk4i3VEYj5fukiU=;
        b=P0fTIil2RYz8CD2A5ARfrmPUml0vvshJ0+wYfOBFSJJa7EEiCJp1x0AkAc3b0ahEfn
         60shWRA0FMR3PwXwMM6KCLiW0/lS6l7851vke3sjum+dccolSPmOeq4MN/9T0qoVXqXq
         UcQXH712tIO8hWO8fJ6RXJDM0JxNDM00pOS8b1+h9aDOGZ504WjWx9qC3yikBx/DtSkO
         wr9tj+f6K4o6mzH4iOpSTbvB9XPsCxRh6afc3Bz6A468+ZJ0bxd5WXDbnR7aX4yBwyHV
         ygU+Bsq3NeqIdftFvFY5k3d2aAy0YZjRTOazrOXiUB8zlAWGxof81cemgXsQWnDA2GT+
         BgXw==
X-Gm-Message-State: ABy/qLbBmoNy+fKtf42Cuj4WXBSRiaPdmSvMXd8FJHGcYfjnUyFqWmTk
        7/R+qBLeoSeKg4hce8k5LOo=
X-Google-Smtp-Source: APBJJlFMmQKNZFmTTGChtg3B5PFGIky6JTu3JUyJIHqLps5Ii8BXObBxohOlRALwPUS4nqRGjOBP5g==
X-Received: by 2002:a17:902:ee41:b0:1b1:753a:49ce with SMTP id 1-20020a170902ee4100b001b1753a49cemr82796plo.53.1689875292038;
        Thu, 20 Jul 2023 10:48:12 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b001b80760fd04sm1702493plb.112.2023.07.20.10.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 10:48:11 -0700 (PDT)
Date:   Thu, 20 Jul 2023 23:18:06 +0530
Message-Id: <87bkg6o4o9.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH 1/4] ext4: add two helper functions fex_end() and pa_end()
In-Reply-To: <20230718131052.283350-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Baokun Li <libaokun1@huawei.com> writes:

> When we use lstart + len to calculate the end of free extent or prealloc
> space, it may exceed the maximum value of 4294967295(0xffffffff) supported
> by ext4_lblk_t and cause overflow, which may lead to various problems.
>
> Therefore, we add two helper functions, fex_end() and pa_end(), to limit
> the type of end to loff_t, and also convert lstart to loff_t for
> calculation to avoid overflow.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c |  4 ++--
>  fs/ext4/mballoc.h | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 456150ef6111..eb7f5d35ef96 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4432,7 +4432,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  
>  	/* first, let's learn actual file size
>  	 * given current request is allocated */
> -	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
> +	size = fex_end(sbi, &ac->ac_o_ex, NULL);
>  	size = size << bsbits;
>  	if (size < i_size_read(ac->ac_inode))
>  		size = i_size_read(ac->ac_inode);
> @@ -5665,7 +5665,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
>  
>  	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
>  	inode_pa_eligible = true;
> -	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
> +	size = fex_end(sbi, &ac->ac_o_ex, NULL);
>  	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
>  		>> bsbits;
>  
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index df6b5e7c2274..fe6bf381f30a 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -233,6 +233,19 @@ static inline ext4_fsblk_t ext4_grp_offs_to_block(struct super_block *sb,
>  		(fex->fe_start << EXT4_SB(sb)->s_cluster_bits);
>  }
>  
> +static inline loff_t fex_end(struct ext4_sb_info *sbi,
> +			     struct ext4_free_extent *fex, ext4_grpblk_t *fe_len)
> +{
> +	return (loff_t)fex->fe_logical +
> +		EXT4_C2B(sbi, fe_len ? *fe_len : fex->fe_len);
> +}
> +
> +static inline loff_t pa_end(struct ext4_sb_info *sbi,
> +			    struct ext4_prealloc_space *pa)
> +{
> +	return (loff_t)pa->pa_lstart + EXT4_C2B(sbi, pa->pa_len);
> +}
> +

I didn't find anything else where we could hit any overflow due to
fex->fe_logical + xxx. 
So, looks good to me except these two helper functions.
I think we can directly just typecast those in place. There are many
other places in ext4 code where careful arithmatic of either adding or
bit shifting has been done. These helpers specially fex_end() is
really confusing.

-ritesh

