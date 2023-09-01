Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB778FAE2
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjIAJe2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Sep 2023 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjIAJe2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Sep 2023 05:34:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57836C0;
        Fri,  1 Sep 2023 02:34:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so19953915ad.0;
        Fri, 01 Sep 2023 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693560863; x=1694165663; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO+uLLw2FHoLsIQUr29swe3Fix3Sx8cUyODUzWW8lnk=;
        b=OxX2d4erYQY6wDRWmD0GGdNqIFIrwr5RrPRyK21oY6qbGrryP/GqxAy2YTz3EfY9kE
         WGkf4cguJveb+0prVMtFwRs8yDb5Pvk6T92M3UG8xT65+9Vm6a9xTfUwKoZY03HxRrTb
         7JuN1TcAXEwZ0lK3wixifiZDx5V6OlEkyu8nMGlL54wkZiwuc6bhP1wbrd0P8d1w/tUv
         qvK13dVfr58+vkgAvY9z24o1yS95ZuCTcWimmeqOeDX/kxw/1J7KdVxifcbkWUMZbkNM
         zv8QVHKfqvcnfJKVhK9lp7yA7TBX513rx2opr4RMnYLPc/AWECa0AQMIGKtUarP/doYY
         sc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560863; x=1694165663;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CO+uLLw2FHoLsIQUr29swe3Fix3Sx8cUyODUzWW8lnk=;
        b=DZ3wKNMAeXgnIOjPetJydtI/fOALJc56ggOdOD1jXEmJUDmzAKV0uO4TqXjJeX5Vbf
         Ly20WE9MIf87U+L725aM/lLrPw7ftDHTZBDuMMSQEI9D5/3Kwnr4VfBibIBOWerp7oGL
         uj2q17hAnjVYiSfWioMPtSMoKOm/mBJOdGiYFexPBzR8dhU0gbGfQs8mppw+XW4yXQgs
         y4WBw5qeHAI6Sc5Wbp79Z+7RokLcpnumhbXvLfkkJGOdp8hpOXFR55b7ocghVHxuv215
         FpRQBUjARoGBfquRyNE7judMHWqQ3y0wl2BgPHDkoGgYat5hlO7z9BwsbA9bgbeQhWpT
         nGnQ==
X-Gm-Message-State: AOJu0YzqaRnd/5b5+ELM1tXDGyT/v0NTigI5xlUim+cP8SnxWX6Etfqz
        fKuujEIFJYCegoR0yAin2IZfBzAwoAg=
X-Google-Smtp-Source: AGHT+IF7xj33exuGQhZV1p4yxb8iD7LQgCTYQUTIuaMZWe4KWtrPEZiPoiM1IKY0nrlK6MmU/9suwg==
X-Received: by 2002:a17:90b:4a83:b0:26b:4e40:7be6 with SMTP id lp3-20020a17090b4a8300b0026b4e407be6mr2634951pjb.20.1693560863094;
        Fri, 01 Sep 2023 02:34:23 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090a740c00b00262fc3d911esm4216239pjg.28.2023.09.01.02.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:34:22 -0700 (PDT)
Date:   Fri, 01 Sep 2023 15:04:18 +0530
Message-Id: <878r9q8cf9.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/11] ext4: Separate block bitmap and buddy bitmap freeing in ext4_mb_clear_bb()
In-Reply-To: <20230826155028.4019470-6-shikemeng@huaweicloud.com>
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

> This patch separates block bitmap and buddy bitmap freeing in order to
> udpate block bitmap with ext4_mb_mark_context in following patch.
^^^ update.

>
> Separated freeing is safe with concurrent allocation as long as:
> 1. Firstly allocate block in buddy bitmap, and then in block bitmap.
> 2. Firstly free block in block bitmap, and then buddy bitmap.
> Then freed block will only be available to allocation when both buddy
> bitmap and block bitmap are updated by freeing.
> Allocation obeys rule 1 already, just do sperated freeing with rule 2.

So we also don't need ext4_load_buddy_gfp() before freeing on-disk
bitmap right. Continue below...

>
> Separated freeing has no race with generate_buddy as:
> Once ext4_mb_load_buddy_gfp is executed successfully, the update-to-date
> buddy page can be found in sbi->s_buddy_cache and no more buddy
> initialization of the buddy page will be executed concurrently until
> buddy page is unloaded. As we always do free in "load buddy, free,
> unload buddy" sequence, separated freeing has no race with generate_buddy.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e650eac22237..01ad36a1cc96 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6519,6 +6519,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  	if (err)
>  		goto error_return;


Let me add the a piece of code before the added changes and continue...

	err = ext4_mb_load_buddy_gfp(sb, block_group, &e4b,
				     GFP_NOFS|__GFP_NOFAIL);
	if (err)
		goto error_return;
>  
> +	ext4_lock_group(sb, block_group);
> +	mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
> +	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
> +	ext4_free_group_clusters_set(sb, gdp, ret);
> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> +	ext4_group_desc_csum_set(sb, block_group, gdp);
> +	ext4_unlock_group(sb, block_group);
> +

...Is it required for ext4_mb_load_buddy_gfp() to be called before
freeing on-disk bitmap blocks? Can you explain why please?
At least it is not very clear to me that why do we need
ext4_mb_load_buddy_gfp() before clearing of bitmap blocks. If it's not
needed then I think we should separate out bitmap freeing logic and
buddy freeing logic even further.

Thoughts?

>  	/*
>  	 * We need to make sure we don't reuse the freed block until after the
>  	 * transaction is committed. We make an exception if the inode is to be
> @@ -6541,13 +6549,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  		new_entry->efd_tid = handle->h_transaction->t_tid;
>  
>  		ext4_lock_group(sb, block_group);
> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>  		ext4_mb_free_metadata(handle, &e4b, new_entry);
>  	} else {
> -		/* need to update group_info->bb_free and bitmap
> -		 * with group lock held. generate_buddy look at
> -		 * them with group lock_held
> -		 */
>  		if (test_opt(sb, DISCARD)) {
>  			err = ext4_issue_discard(sb, block_group, bit,
>  						 count_clusters, NULL);
> @@ -6560,14 +6563,9 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
>  
>  		ext4_lock_group(sb, block_group);
> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>  		mb_free_blocks(inode, &e4b, bit, count_clusters);
>  	}
>  
> -	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
> -	ext4_free_group_clusters_set(sb, gdp, ret);
> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> -	ext4_group_desc_csum_set(sb, block_group, gdp);
>  	ext4_unlock_group(sb, block_group);
>  
>  	if (sbi->s_log_groups_per_flex) {


Adding piece of code here...

	if (sbi->s_log_groups_per_flex) {
		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
		atomic64_add(count_clusters,
			     &sbi_array_rcu_deref(sbi, s_flex_groups,
						  flex_group)->free_clusters);
	}

<...>

	/* We dirtied the bitmap block */
	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
	/* And the group descriptor block */
	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
	if (!err)
		err = ret;

I was thinking even this can go around bitmap freeing logic above. So
the next patch becomes very clear that all of the bitmap freeing logic
is just simply moved into ext4_mb_mark_context() function.

-ritesh
