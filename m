Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB978ED29
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Aug 2023 14:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjHaMdc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHaMdb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 08:33:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6761A4;
        Thu, 31 Aug 2023 05:33:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso5123775ad.3;
        Thu, 31 Aug 2023 05:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693485208; x=1694090008; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg4CMrZ1InB58lZei1f7dwdsFupZalIHsxLS2zZxflo=;
        b=JHD4ae+AMqrASOYsnpNHJplNHFBcRaKiuLGYjCrJHx8kk0by+LGWDsRNR+AOK4yJWR
         3vBt8Hel1IX5x6LEH1OxtCxpXLfiTjjNwzl2QLaMiQ0E6Z5wz2/VyyvQDtwKiDGYX3Jf
         Ro8sNN8ulleElGluib4U+/cj40HRPG2udujdKKu1cgqEq8oPp81oSeMSzaS5qoZ56x+E
         JeAkKxhRfS1ZjQcR28AxIH5toUJiZbctZU3A8HTY/295Uf/TIqcHTeYygxjcklrmNlKb
         zrk5bcq3qPZtH8ICEs/E6i2Jz534K/+aEC+pAPATuVAIhkuU70eXxEGDE1eifc5Kx/wd
         pB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693485208; x=1694090008;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vg4CMrZ1InB58lZei1f7dwdsFupZalIHsxLS2zZxflo=;
        b=EC65aiQYj3nU87tT1vbVrZ7rGxq5aGg1eo9nOae6e4OWYKXMN/Nim9+5EFhDBKI+5S
         xEHVu7kp5PYK1NVeUeTh/9SK7cQA9RkeJO6a4lIcqVQ4bSfbBUQUUSWLSfdq7exUnEAL
         4dkUI/esAxLGyM6HRxu2bCFieH1+MXUDHeC/CjXvvhZagnUUXNNFFm3ikHJ3yNB/G4hp
         Zkt9Q9t/s0zkpEqTWQIZ94figkPuK5mqJBKmf9o6/WMbo+hivONz1NNudyl1VZOAiy4x
         ruxQl0m/wKyBZUF3LGO3k9IsDiYtH2CdcDDkAW5+yQQpz/lNl+N+sEncCTtUQCf2ro0n
         wPfw==
X-Gm-Message-State: AOJu0YzqJSQwTVLw+vOP0dliOghJEY/Q2pg6JhRJP+o3xLd+8njLK3TE
        nk+S0prRdY+2LAARM18RD71lKQvInZw=
X-Google-Smtp-Source: AGHT+IHR3NNwJV7mlXAYzL4mw1L9FgcfQBY5jXLWXOfbevfP7E6SjNfSBE4IeUuX0MGyvFYSZyNALw==
X-Received: by 2002:a17:902:d70b:b0:1b8:ae24:c207 with SMTP id w11-20020a170902d70b00b001b8ae24c207mr4181133ply.68.1693485207725;
        Thu, 31 Aug 2023 05:33:27 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b001b9d335223csm1180405plg.26.2023.08.31.05.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:33:26 -0700 (PDT)
Date:   Thu, 31 Aug 2023 18:03:22 +0530
Message-Id: <87sf7z8k8d.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/11] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
In-Reply-To: <20230826155028.4019470-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

Hello Kemeng,

> There are several reasons to add a general function to update block
> bitmap and group descriptor on disk:

... named ext4_mb_mark_context(<params>)

> 1. pair behavior of alloc/free bits. For example,
> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
> 2. remove repeat code to read from disk, update and write back to disk.
> 3. reduce future unit test mocks to catch real IO to update structure
> on disk.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/mballoc.c | 169 +++++++++++++++++++++++++++-------------------
>  1 file changed, 99 insertions(+), 70 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c91db9f57524..e2be572deb75 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3952,6 +3952,100 @@ void ext4_exit_mballoc(void)
>  	ext4_groupinfo_destroy_slabs();
>  }
>  
> +/*
> + * Collect global setting to reduce the number of variable passing to
> + * ext4_mb_mark_context. Pass target group blocks range directly to
> + * reuse the prepared global setting for multiple block ranges and
> + * to show clearly the specific block range will be marked.
> + */
> +struct ext4_mark_context {
> +	struct super_block *sb;
> +	int state;
> +};

This structure definition does not reflect of it's naming.
Why can't we also add cblk & clen, flags to it?

I think the idea of defining a new function named
ext4_mb_prepare_mark_context() was that we can prepare "struct ext4_mark_context"
with different cblk, clen & flags arguments for cases where we might
have to call ext4_mb_mark_context() more than once in the same function
or call ext4_mb_mark_context() anywhere but at the start of the function.

As I see it in the current series, we are calling
ext4_mb_prepare_mark_context() at the start of every function. Just for
this purpose we don't need an extra function, right? That we can directly do
at the time of declaring a structure variable itself (like how you did
in previous version)

What do you think of the approach where we add cblk, clen & flags
variables to ext4_mark_context()? Do you see any problems/difficulties
with that design?

> +
> +static inline void ext4_mb_prepare_mark_context(struct ext4_mark_context *mc,
> +						struct super_block *sb,
> +						int state)
> +{
> +	mc->sb = sb;
> +	mc->state = state;
> +}
> +
> +static int
> +ext4_mb_mark_context(struct ext4_mark_context *mc, ext4_group_t group,
> +		     ext4_grpblk_t blkoff, ext4_grpblk_t len)
> +{
> +	struct super_block *sb = mc->sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct buffer_head *bitmap_bh = NULL;
> +	struct ext4_group_desc *gdp;
> +	struct buffer_head *gdp_bh;
> +	int err;
> +	unsigned int i, already, changed;
> +
> +	bitmap_bh = ext4_read_block_bitmap(sb, group);
> +	if (IS_ERR(bitmap_bh))
> +		return PTR_ERR(bitmap_bh);
> +
> +	err = -EIO;
> +	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
> +	if (!gdp)
> +		goto out_err;
> +
> +	ext4_lock_group(sb, group);
> +	if (ext4_has_group_desc_csum(sb) &&
> +	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> +		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> +		ext4_free_group_clusters_set(sb, gdp,
> +			ext4_free_clusters_after_init(sb, group, gdp));
> +	}
> +
> +	already = 0;
> +	for (i = 0; i < len; i++)
> +		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
> +				mc->state)
> +			already++;
> +	changed = len - already;
> +
> +	if (mc->state) {
> +		mb_set_bits(bitmap_bh->b_data, blkoff, len);
> +		ext4_free_group_clusters_set(sb, gdp,
> +			ext4_free_group_clusters(sb, gdp) - changed);
> +	} else {
> +		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
> +		ext4_free_group_clusters_set(sb, gdp,
> +			ext4_free_group_clusters(sb, gdp) + changed);
> +	}
> +
> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> +	ext4_group_desc_csum_set(sb, group, gdp);
> +	ext4_unlock_group(sb, group);
> +
> +	if (sbi->s_log_groups_per_flex) {
> +		ext4_group_t flex_group = ext4_flex_group(sbi, group);
> +		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
> +					   s_flex_groups, flex_group);
> +
> +		if (mc->state)
> +			atomic64_sub(changed, &fg->free_clusters);
> +		else
> +			atomic64_add(changed, &fg->free_clusters);
> +	}
> +
> +	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
> +	if (err)
> +		goto out_err;
> +	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
> +	if (err)
> +		goto out_err;
> +
> +	sync_dirty_buffer(bitmap_bh);
> +	sync_dirty_buffer(gdp_bh);
> +
> +out_err:
> +	brelse(bitmap_bh);
> +	return err;
> +}
>  
>  /*
>   * Check quota and mark chosen space (ac->ac_b_ex) non-free in bitmaps
> @@ -4078,16 +4172,14 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  			int len, int state)
>  {
> -	struct buffer_head *bitmap_bh = NULL;
> -	struct ext4_group_desc *gdp;
> -	struct buffer_head *gdp_bh;
> +	struct ext4_mark_context mc;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	ext4_group_t group;
>  	ext4_grpblk_t blkoff;
> -	int i, err = 0;
> -	int already;
> -	unsigned int clen, clen_changed, thisgrp_len;
> +	int err = 0;
> +	unsigned int clen, thisgrp_len;
>  
> +	ext4_mb_prepare_mark_context(&mc, sb, state);
>  	while (len > 0) {
>  		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
>  
> @@ -4107,80 +4199,17 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  			ext4_error(sb, "Marking blocks in system zone - "
>  				   "Block = %llu, len = %u",
>  				   block, thisgrp_len);
> -			bitmap_bh = NULL;
> -			break;
> -		}
> -
> -		bitmap_bh = ext4_read_block_bitmap(sb, group);
> -		if (IS_ERR(bitmap_bh)) {
> -			err = PTR_ERR(bitmap_bh);
> -			bitmap_bh = NULL;
>  			break;
>  		}
>  
> -		err = -EIO;
> -		gdp = ext4_get_group_desc(sb, group, &gdp_bh);
> -		if (!gdp)
> -			break;
> -
> -		ext4_lock_group(sb, group);
> -		already = 0;
> -		for (i = 0; i < clen; i++)
> -			if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
> -					 !state)
> -				already++;
> -
> -		clen_changed = clen - already;
> -		if (state)
> -			mb_set_bits(bitmap_bh->b_data, blkoff, clen);
> -		else
> -			mb_clear_bits(bitmap_bh->b_data, blkoff, clen);
> -		if (ext4_has_group_desc_csum(sb) &&
> -		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> -			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> -			ext4_free_group_clusters_set(sb, gdp,
> -			     ext4_free_clusters_after_init(sb, group, gdp));
> -		}
> -		if (state)
> -			clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
> -		else
> -			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
> -
> -		ext4_free_group_clusters_set(sb, gdp, clen);
> -		ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> -		ext4_group_desc_csum_set(sb, group, gdp);
> -
> -		ext4_unlock_group(sb, group);
> -
> -		if (sbi->s_log_groups_per_flex) {
> -			ext4_group_t flex_group = ext4_flex_group(sbi, group);
> -			struct flex_groups *fg = sbi_array_rcu_deref(sbi,
> -						   s_flex_groups, flex_group);
> -
> -			if (state)
> -				atomic64_sub(clen_changed, &fg->free_clusters);
> -			else
> -				atomic64_add(clen_changed, &fg->free_clusters);
> -
> -		}
> -
> -		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
> -		if (err)
> -			break;
> -		sync_dirty_buffer(bitmap_bh);
> -		err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
> -		sync_dirty_buffer(gdp_bh);
> +		err = ext4_mb_mark_context(&mc, group, blkoff, clen);
>  		if (err)
>  			break;
>  
>  		block += thisgrp_len;
>  		len -= thisgrp_len;
> -		brelse(bitmap_bh);
>  		BUG_ON(len < 0);
>  	}
> -
> -	if (err)
> -		brelse(bitmap_bh);
>  }
>  
>  /*
> -- 
> 2.30.0


-ritesh
