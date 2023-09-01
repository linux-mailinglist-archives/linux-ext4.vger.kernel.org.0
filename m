Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADE78FB00
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 11:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjIAJiK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Sep 2023 05:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjIAJiJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Sep 2023 05:38:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4B8C5;
        Fri,  1 Sep 2023 02:38:06 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bdc27e00a1so1396960a34.3;
        Fri, 01 Sep 2023 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693561085; x=1694165885; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puujmwruwEPZwX3qru4Zjgz8R1GSDUuaeEptqL3yQAE=;
        b=ONOiv8AsHMFB8ngaOkuFoqlfa1ifCHeu+MVzM5b/d44XW+L/CdNFLDMzpASE2Y003n
         9Y3HdR5RgQ/s9dp/TYfZaaa3k9UiLudK6LnOVJ7vPAzVojD2CMubuwaXJthw9UNPvdYr
         eRHEVX2vGdx8ldXZvwm5OewsiH+2qEXZRRGIH5ARIahtO6Vz7CJtQc/EXA8Ah3rheQbe
         gWNMmaPJA06pIAUZeI7RwvhQbOm6MwnhT/UxciiZ4Uo0i7yGSJjABVkXcKrCWGhO2vzN
         S+c7TvcNTP898C065d6lPygOS/Ve+3m3ulQCC7S4VEyIAu8kUNSouoiLGy3Ty7PGDHGT
         Twsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693561085; x=1694165885;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=puujmwruwEPZwX3qru4Zjgz8R1GSDUuaeEptqL3yQAE=;
        b=aNjWjh5s80Rlzp8WmmuDYVUhmEBKG4L1sdwwieKPPmKqNJ3QdtW+nBJRxRvr1y1oHf
         zl++dQ1UAM6OkGdvfe6ndmPWIrbtvAbH1tcZ4dSkxZ7k2xJj/hMfSVQhURhsUSe7zt8U
         O46eo0cxRDRMo+xU1HZQgca4fe+DNgXr3VZGet7mzJiPnNEbPJNI3ayh2aQt3CwABcii
         2St6VCzxWLZgOvVuQh+zw84ucryIXc0IjuR90Am6ccAKUR1uAC/1jQDVCOJViSyYGvwQ
         ISNRp4fgPjGT5VpJIM1RPbOxAKc6rHcv6C1Fwi5XOO3BWI+RxACGMTwDcALkAxweUJW4
         DOzw==
X-Gm-Message-State: AOJu0Yz9ZNbEmdRMOBuDVCeyfH2F3KuUdeW7Lhsshdrj556DIUHnAQE6
        WX/aZ9iTyc3P3Ji+c+gnxPNCMxvx5Jo=
X-Google-Smtp-Source: AGHT+IEaqqAe9tFixyzFM80Ki6nnhy4ODrgqp6gr8xrlSVl0jvXR7+G7i7lSi44g6lkneSJYIu8Nmw==
X-Received: by 2002:a05:6870:5488:b0:1bf:8df:2406 with SMTP id f8-20020a056870548800b001bf08df2406mr1792113oan.27.1693561085393;
        Fri, 01 Sep 2023 02:38:05 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id u9-20020aa78389000000b0067f2f7eccdcsm2588921pfm.193.2023.09.01.02.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:38:04 -0700 (PDT)
Date:   Fri, 01 Sep 2023 15:08:01 +0530
Message-Id: <875y4u8c92.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/11] ext4: call ext4_mb_mark_context in ext4_mb_clear_bb
In-Reply-To: <20230826155028.4019470-7-shikemeng@huaweicloud.com>
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

> Call ext4_mb_mark_context in ext4_mb_clear_bb to remove repeat code.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 83 +++++++++++------------------------------------
>  1 file changed, 19 insertions(+), 64 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 01ad36a1cc96..25265531cb6a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6424,21 +6424,20 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  			       ext4_fsblk_t block, unsigned long count,
>  			       int flags)
>  {
> -	struct buffer_head *bitmap_bh = NULL;
> +	struct ext4_mark_context mc;
>  	struct super_block *sb = inode->i_sb;
> -	struct ext4_group_desc *gdp;
>  	struct ext4_group_info *grp;
>  	unsigned int overflow;
>  	ext4_grpblk_t bit;
> -	struct buffer_head *gd_bh;
>  	ext4_group_t block_group;
>  	struct ext4_sb_info *sbi;
>  	struct ext4_buddy e4b;
>  	unsigned int count_clusters;
>  	int err = 0;
> -	int ret;
> +	int mark_flags = 0;
>  
>  	sbi = EXT4_SB(sb);
> +	ext4_mb_prepare_mark_context(&mc, handle, sb, 0);
>  
>  	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
>  	    !ext4_inode_block_valid(inode, block, count)) {
> @@ -6468,18 +6467,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  		/* The range changed so it's no longer validated */
>  		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
>  	}
> -	count_clusters = EXT4_NUM_B2C(sbi, count);
> -	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
> -	if (IS_ERR(bitmap_bh)) {
> -		err = PTR_ERR(bitmap_bh);
> -		bitmap_bh = NULL;
> -		goto error_return;
> -	}
> -	gdp = ext4_get_group_desc(sb, block_group, &gd_bh);
> -	if (!gdp) {
> -		err = -EIO;
> -		goto error_return;
> -	}
>  
>  	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
>  	    !ext4_inode_block_valid(inode, block, count)) {
> @@ -6489,28 +6476,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  		goto error_return;
>  	}
>  
> -	BUFFER_TRACE(bitmap_bh, "getting write access");
> -	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
> -					    EXT4_JTR_NONE);
> -	if (err)
> -		goto error_return;
> -
> -	/*
> -	 * We are about to modify some metadata.  Call the journal APIs
> -	 * to unshare ->b_data if a currently-committing transaction is
> -	 * using it
> -	 */
> -	BUFFER_TRACE(gd_bh, "get_write_access");
> -	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
> -	if (err)
> -		goto error_return;
> -#ifdef AGGRESSIVE_CHECK
> -	{
> -		int i;
> -		for (i = 0; i < count_clusters; i++)
> -			BUG_ON(!mb_test_bit(bit + i, bitmap_bh->b_data));
> -	}
> -#endif
> +	count_clusters = EXT4_NUM_B2C(sbi, count);
>  	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
>  
>  	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
> @@ -6519,13 +6485,21 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  	if (err)
>  		goto error_return;
>  
> -	ext4_lock_group(sb, block_group);
> -	mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
> -	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
> -	ext4_free_group_clusters_set(sb, gdp, ret);
> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> -	ext4_group_desc_csum_set(sb, block_group, gdp);
> -	ext4_unlock_group(sb, block_group);
> +#ifdef AGGRESSIVE_CHECK
> +	mark_flags |= EXT4_MB_BITMAP_MARKED_CHECK;
> +#endif
> +	err = ext4_mb_mark_context(&mc, block_group, bit, count_clusters,
> +				   mark_flags);
> +
> +
> +	if (err && mc.changed == 0) {
> +		ext4_mb_unload_buddy(&e4b);
> +		goto error_return;
> +	}
> +
> +#ifdef AGGRESSIVE_CHECK
> +	BUG_ON(mc.changed != count_clusters);
> +#endif
>  
>  	/*
>  	 * We need to make sure we don't reuse the freed block until after the
> @@ -6568,13 +6542,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  
>  	ext4_unlock_group(sb, block_group);
>  
> -	if (sbi->s_log_groups_per_flex) {
> -		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
> -		atomic64_add(count_clusters,
> -			     &sbi_array_rcu_deref(sbi, s_flex_groups,
> -						  flex_group)->free_clusters);
> -	}
> -
>  	/*
>  	 * on a bigalloc file system, defer the s_freeclusters_counter
>  	 * update to the caller (ext4_remove_space and friends) so they
> @@ -6589,26 +6556,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  
>  	ext4_mb_unload_buddy(&e4b);
>  
> -	/* We dirtied the bitmap block */
> -	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
> -	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
> -
> -	/* And the group descriptor block */
> -	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
> -	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
> -	if (!err)
> -		err = ret;
> -

As commented out in previous patch, it would be much simpler if we can
move all the required peices for bitmap freeing logic at one place.
So then this patch just becomes removing them all and using already
created ext4_mb_mark_context() function.

-ritesh
