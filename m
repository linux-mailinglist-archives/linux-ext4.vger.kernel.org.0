Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2009A762020
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGYR30 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 13:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjGYR3Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 13:29:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB21BD5;
        Tue, 25 Jul 2023 10:29:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb893e6365so17841835ad.2;
        Tue, 25 Jul 2023 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690306162; x=1690910962;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KhSutx2xpmr+Ow/Hq799MNdtT0rBQlKqEtbWDNTHqEc=;
        b=aJRjU0eoXRM0w5MfLyM6EfCnY+GQe0irHXXroRhccmEO0eYf+VopxHjxAYZYPF7bdT
         94g9iMzFH59tBRtE56JZWFy8M8+4d5hCTiOyAFyHrHtDEph4LTztbGscu/dj7IsY/oh4
         n/jQYDGAcZG3mpyJoQKbmIF8XqAj6yFb1v360x35l8KUygl7pJc7078Yp1znIulXeT5j
         /ecZu/PGySMx1vuUic6gd8u5Y5FpjleH1aMXGbQX2awIloj2PINAyd/sTx2M3QUSirp7
         Oifp214sxPMGsZDKoGdw+koCRP817kE/O5+OK4annRcgvujA4sg9YWdn6ugFr1epZaBB
         LgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690306162; x=1690910962;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhSutx2xpmr+Ow/Hq799MNdtT0rBQlKqEtbWDNTHqEc=;
        b=D8dS3FBEy/ree3RI2rvsCuURjQCHrtj8cSKDaeYhfARK9Le3a+vHK69fGdNA8bdPOW
         8qpp3hGY3/Jbp29f55rqCqc0k8/kjMoFicYSekNUL1EO/fGGQmc23+nh4dRVTln3lx9i
         P3SjYPf9zfHHOPDipqwua37VoytVpegu80RHgvIbe5TLAfmtbfYD/F4NOrsDaXFOWKX2
         AvvA6Ev4UL/Fn5U7sNq4W67AIP1ZpBOBCRQfu3p7YnxDttN16IqjLd/qlW8ADhtgZ+lL
         BvTbIFmU05qrTk7rlDCM9OF+Qa2hdkRLHvsqSblQksH17vd2o5k80wxT1L9u8wnuRiz/
         At9g==
X-Gm-Message-State: ABy/qLaHq2uFGDpYhInFvkeHwaD9RaKZgjSu1iVb+9BMIwBThWGaTGpt
        AAHh7BPakxswro+GtgZ9QDU=
X-Google-Smtp-Source: APBJJlGmyt5c0pH0DplGvkPP8bpfsD4fX2k7w9Pemgjs9UeRy+9vHDrqOYOiLy1rlBfrslbOlY4l5w==
X-Received: by 2002:a17:902:dacc:b0:1bb:a922:4a1a with SMTP id q12-20020a170902dacc00b001bba9224a1amr5190839plx.6.1690306162012;
        Tue, 25 Jul 2023 10:29:22 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b801044466sm11390423plb.114.2023.07.25.10.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:29:21 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:59:10 +0530
Message-Id: <871qgvdhnd.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH v2 1/3] ext4: add two helper functions extent_logical_end() and pa_logical_end()
In-Reply-To: <20230724121059.11834-2-libaokun1@huawei.com>
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
> Therefore, we add two helper functions, extent_logical_end() and
> pa_logical_end(), to limit the type of end to loff_t, and also convert
> lstart to loff_t for calculation to avoid overflow.

Sure. extent_logical_end() is not as bad after dropping the third param.
Thanks for addressing review comments and identifying overflow issues :) 

Looks good to me. Feel free to add: 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c |  9 +++------
>  fs/ext4/mballoc.h | 14 ++++++++++++++
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 21b903fe546e..4cb13b3e41b3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4432,7 +4432,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  
>  	/* first, let's learn actual file size
>  	 * given current request is allocated */
> -	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
> +	size = extent_logical_end(sbi, &ac->ac_o_ex);
>  	size = size << bsbits;
>  	if (size < i_size_read(ac->ac_inode))
>  		size = i_size_read(ac->ac_inode);
> @@ -4766,7 +4766,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_locality_group *lg;
>  	struct ext4_prealloc_space *tmp_pa = NULL, *cpa = NULL;
> -	loff_t tmp_pa_end;
>  	struct rb_node *iter;
>  	ext4_fsblk_t goal_block;
>  
> @@ -4862,9 +4861,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	 * pa can possibly satisfy the request hence check if it overlaps
>  	 * original logical start and stop searching if it doesn't.
>  	 */
> -	tmp_pa_end = (loff_t)tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> -
> -	if (ac->ac_o_ex.fe_logical >= tmp_pa_end) {
> +	if (ac->ac_o_ex.fe_logical >= pa_logical_end(sbi, tmp_pa)) {
>  		spin_unlock(&tmp_pa->pa_lock);
>  		goto try_group_pa;
>  	}
> @@ -5769,7 +5766,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
>  
>  	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
>  	inode_pa_eligible = true;
> -	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
> +	size = extent_logical_end(sbi, &ac->ac_o_ex);
>  	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
>  		>> bsbits;
>  
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index df6b5e7c2274..d7aeb5da7d86 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -233,6 +233,20 @@ static inline ext4_fsblk_t ext4_grp_offs_to_block(struct super_block *sb,
>  		(fex->fe_start << EXT4_SB(sb)->s_cluster_bits);
>  }
>  
> +static inline loff_t extent_logical_end(struct ext4_sb_info *sbi,
> +					struct ext4_free_extent *fex)
> +{
> +	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
> +	return (loff_t)fex->fe_logical + EXT4_C2B(sbi, fex->fe_len);
> +}
> +
> +static inline loff_t pa_logical_end(struct ext4_sb_info *sbi,
> +				    struct ext4_prealloc_space *pa)
> +{
> +	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
> +	return (loff_t)pa->pa_lstart + EXT4_C2B(sbi, pa->pa_len);
> +}
> +
>  typedef int (*ext4_mballoc_query_range_fn)(
>  	struct super_block		*sb,
>  	ext4_group_t			agno,
> -- 
> 2.31.1
