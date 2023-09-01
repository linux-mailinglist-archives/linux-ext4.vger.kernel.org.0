Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D278FB6D
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjIAJuS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Sep 2023 05:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjIAJuS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Sep 2023 05:50:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0D01B1;
        Fri,  1 Sep 2023 02:50:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a41035828so1395727b3a.1;
        Fri, 01 Sep 2023 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693561813; x=1694166613; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7o43Qz7LJJ756+VKqbyW6NSetMQmwP74t/a7gq66Aw=;
        b=Sdf7oBT6bLst1lEns7gzB56T/wye5xBd4fxLQgvNwMVdIU2Y7uF16ZFCONHkHzXu85
         kCuwQ7bpL7rgAuAvNIO2+MHfa5YbQWS5a0KPM7W+sE7eHsbN3ztAAKG5DxtnrK8sw8ux
         Aryg4s4AIaUU2bTuWVLYvTDkt/7lTGEQ5Try9RvgrZb0iTDpKsvITpAqii/ob5OaNzyY
         VIgMCZ0ZfNt7KVtGzCY66oiTjy3cDSdNanVwxH08bjQK657AtjJGgjk4Dio238SPeciU
         45d3mrh9BPF1UzAieD/uTo5JY5U3IgnI8Wzp0Z5wZInOYqnxYmcZkl7HU2CbL8XPqzDf
         A55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693561813; x=1694166613;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7o43Qz7LJJ756+VKqbyW6NSetMQmwP74t/a7gq66Aw=;
        b=H4GKkQ70QLoH9NDCmSkbaL7Ecepp2s1rKG6JJ470JxnVf8E4QCt+ieTjAlnxr36IxY
         fm3qOqImEufT4Cq6QfjcU/IQB9ogIpIPB176xFWx3uCRienEjkYMtgu36NkkEcXg7OTc
         fAghBjUZmQPMFmuwKX2ZG9FDrMX40BiwzNOgiLIwHEtht2BmGbttPcHRWHFYKugL4Kh5
         z76Rqy2D2JtMuMS7shlHi3O+ONAdd4DQS/BQLrnpxvbzhqZ3+SWZ/mLglrTWVjtQX1um
         U17xsShxPWN/RbS7iQMfJ2N30I8o/sVqXmlmDug2ypFGgZl/e4fFYtX5SP3eVHrNkRGZ
         fhtA==
X-Gm-Message-State: AOJu0Yy5/JoUrikKZeJuY7fHq0By6Z2VlWxXzMJE+EPbpzwfPsQT9zdO
        /Ltv+NBkYnZyL5XYIcscl+O38Ia9zQY=
X-Google-Smtp-Source: AGHT+IHWAvD4+3rKB+59s8mw5W51Zfs9Y0uCARVIn1OaSqXDpmsZkMMNUhW1O4l8TrwjSDJPEnDC1Q==
X-Received: by 2002:a05:6a00:2493:b0:68a:3458:8e25 with SMTP id c19-20020a056a00249300b0068a34588e25mr2404279pfv.29.1693561813463;
        Fri, 01 Sep 2023 02:50:13 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id r7-20020a62e407000000b006887be16682sm2587517pfh.53.2023.09.01.02.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:50:12 -0700 (PDT)
Date:   Fri, 01 Sep 2023 15:20:09 +0530
Message-Id: <8734zy8bou.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/11] ext4: call ext4_mb_mark_context in ext4_group_add_blocks()
In-Reply-To: <20230826155028.4019470-9-shikemeng@huaweicloud.com>
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

> Call ext4_mb_mark_context in ext4_group_add_blocks() to remove repeat code.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 84 +++++++----------------------------------------
>  1 file changed, 12 insertions(+), 72 deletions(-)

I think same comments (like in patch-5 & patch-6) hold for this and the previous patch as well where
we are seperating out bitmap free and buddy free from ext4_group_add_blocks. 

-ritesh


>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index bb08a71a6e61..fdffa3b40bcd 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6681,25 +6681,22 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
>  			 ext4_fsblk_t block, unsigned long count)
>  {
> -	struct buffer_head *bitmap_bh = NULL;
> -	struct buffer_head *gd_bh;
> +	struct ext4_mark_context mc;
>  	ext4_group_t block_group;
>  	ext4_grpblk_t bit;
> -	unsigned int i;
> -	struct ext4_group_desc *desc;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct ext4_buddy e4b;
> -	int err = 0, ret, free_clusters_count;
> -	ext4_grpblk_t clusters_freed;
> +	int err = 0;
>  	ext4_fsblk_t first_cluster = EXT4_B2C(sbi, block);
>  	ext4_fsblk_t last_cluster = EXT4_B2C(sbi, block + count - 1);
>  	unsigned long cluster_count = last_cluster - first_cluster + 1;
>  
>  	ext4_debug("Adding block(s) %llu-%llu\n", block, block + count - 1);
>  
> -	if (count == 0)
> +	if (cluster_count == 0)
>  		return 0;
>  
> +	ext4_mb_prepare_mark_context(&mc, handle, sb, 0);
>  	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
>  	/*
>  	 * Check to see if we are freeing blocks across a group
> @@ -6712,19 +6709,6 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
>  		goto error_return;
>  	}
>  
> -	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
> -	if (IS_ERR(bitmap_bh)) {
> -		err = PTR_ERR(bitmap_bh);
> -		bitmap_bh = NULL;
> -		goto error_return;
> -	}
> -
> -	desc = ext4_get_group_desc(sb, block_group, &gd_bh);
> -	if (!desc) {
> -		err = -EIO;
> -		goto error_return;
> -	}
> -
>  	if (!ext4_sb_block_valid(sb, NULL, block, count)) {
>  		ext4_error(sb, "Adding blocks in system zones - "
>  			   "Block = %llu, count = %lu",
> @@ -6733,74 +6717,30 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
>  		goto error_return;
>  	}
>  
> -	BUFFER_TRACE(bitmap_bh, "getting write access");
> -	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
> -					    EXT4_JTR_NONE);
> +	err = ext4_mb_load_buddy(sb, block_group, &e4b);
>  	if (err)
>  		goto error_return;
>  
> -	/*
> -	 * We are about to modify some metadata.  Call the journal APIs
> -	 * to unshare ->b_data if a currently-committing transaction is
> -	 * using it
> -	 */
> -	BUFFER_TRACE(gd_bh, "get_write_access");
> -	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
> -	if (err)
> +	err = ext4_mb_mark_context(&mc, block_group, bit, cluster_count,
> +				   EXT4_MB_BITMAP_MARKED_CHECK);
> +	if (err && mc.changed == 0) {
> +		ext4_mb_unload_buddy(&e4b);
>  		goto error_return;
> -
> -	for (i = 0, clusters_freed = 0; i < cluster_count; i++) {
> -		BUFFER_TRACE(bitmap_bh, "clear bit");
> -		if (!mb_test_bit(bit + i, bitmap_bh->b_data)) {
> -			ext4_error(sb, "bit already cleared for block %llu",
> -				   (ext4_fsblk_t)(block + i));
> -			BUFFER_TRACE(bitmap_bh, "bit already cleared");
> -		} else {
> -			clusters_freed++;
> -		}
>  	}
>  
> -	err = ext4_mb_load_buddy(sb, block_group, &e4b);
> -	if (err)
> -		goto error_return;
> -
> -	ext4_lock_group(sb, block_group);
> -	mb_clear_bits(bitmap_bh->b_data, bit, cluster_count);
> -	free_clusters_count = clusters_freed +
> -		ext4_free_group_clusters(sb, desc);
> -	ext4_free_group_clusters_set(sb, desc, free_clusters_count);
> -	ext4_block_bitmap_csum_set(sb, desc, bitmap_bh);
> -	ext4_group_desc_csum_set(sb, block_group, desc);
> -	ext4_unlock_group(sb, block_group);
> +	if (mc.changed != cluster_count)
> +		ext4_error(sb, "bit already cleared in group %u", block_group);
>  
>  	ext4_lock_group(sb, block_group);
>  	mb_free_blocks(NULL, &e4b, bit, cluster_count);
>  	ext4_unlock_group(sb, block_group);
>  
>  	percpu_counter_add(&sbi->s_freeclusters_counter,
> -			   clusters_freed);
> -
> -	if (sbi->s_log_groups_per_flex) {
> -		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
> -		atomic64_add(clusters_freed,
> -			     &sbi_array_rcu_deref(sbi, s_flex_groups,
> -						  flex_group)->free_clusters);
> -	}
> +			   mc.changed);
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
>  error_return:
> -	brelse(bitmap_bh);
>  	ext4_std_error(sb, err);
>  	return err;
>  }
> -- 
> 2.30.0
