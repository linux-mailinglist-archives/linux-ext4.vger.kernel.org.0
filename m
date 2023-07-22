Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A275DD11
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Jul 2023 17:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGVPEy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Jul 2023 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVPEx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Jul 2023 11:04:53 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7003910F5;
        Sat, 22 Jul 2023 08:04:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668704a5b5bso2678389b3a.0;
        Sat, 22 Jul 2023 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690038288; x=1690643088;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wilBskxoDLE0WDOTpeghLkRAu1C7OaNnBdQQcZMzLkI=;
        b=B0Jab/5JHgCCwnSQ6jUTtkFRtAx7xLaCuEztsjj4cfy+HOtr9aSKtg+wlKCdOJR9DD
         8GXr+XDJIhk5+2fgr+f2DAX8eYHXuM586gFHFjeVtK9HBBXAPzx3LoN+6whfMlNev0J6
         BjUMa8rM3hj4JtRcbPPeFkwcCnYta3ot0jOiv1k8RAbkn7IK3Ftv5rmkc5nhSR0U/A7T
         qAMUmQH+p2+3Eh58ejVBLdgiY7xsQjCnFQqAXmzoeOi/GFzmjpfrrs7poYY4FI9pLU1V
         sSWvcoyJnnDBx2La3lsN/veXSSbKI94NYWSfXxYAL1B3VgrQH8Zk1AJ25/VIyY5V+xli
         9Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690038288; x=1690643088;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wilBskxoDLE0WDOTpeghLkRAu1C7OaNnBdQQcZMzLkI=;
        b=V5JHcVJKoydCGUinr3VrhxKdrpHyyLZB7CheJgFmwQpdIxSE7I063OGLqdfMvI8War
         pAgC6KmN/y4PYcTo4ey4MWdCDseCdKgcIWW4bZAT9c8wdSh993xTGNEFrkHQrY7nLEKV
         PmD1OMjuKZcTg/yl2Hzmr/+5gDUgJ79AyMcso6AXZNHPciIUKSgbO8P0uzrMmPYo7IXr
         0Xq0LUfkCZcrh+d/CtPMXispauX1wwLZPY3ke1NKiHILX79HwUCqj18yXOfXijGPfG8p
         y3NyEh2UDjGve0CcW63Vw8jhFqz6EUloiKIQIIMO0AifOr6fTuzp2cX/J45T2xdNnZAL
         A2rA==
X-Gm-Message-State: ABy/qLa5auMa5ycfoU5vbKkQ6HFHcjP7Gfo/5vrrbZBLOrUHDqPhul9Y
        xDBFCQNzk2O91G5J86xaDMM=
X-Google-Smtp-Source: APBJJlGxcmrBPJkkrmx/e3PRqO2PvqLRi84fUXlTWzRTPNzPB8X7wH0zopvOQ+rcNGWzlUfRGaUpvg==
X-Received: by 2002:a05:6a20:3d26:b0:133:f860:ac42 with SMTP id y38-20020a056a203d2600b00133f860ac42mr6636953pzi.34.1690038287764;
        Sat, 22 Jul 2023 08:04:47 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id s21-20020a62e715000000b00678afd4824asm4858236pfh.175.2023.07.22.08.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 08:04:47 -0700 (PDT)
Date:   Sat, 22 Jul 2023 20:34:43 +0530
Message-Id: <87h6pwj8c4.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH v5 5/8] ext4: call ext4_mb_mark_group_bb in ext4_mb_clear_bb
In-Reply-To: <20230629144007.1263510-6-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> call ext4_mb_mark_group_bb in ext4_mb_clear_bb to remove repeat code
> to update block bitmap and group descriptor on disk.
>
> Note: ext4_mb_clear_bb will update buddy and bitmap in two critical
> sections instead of update in the same critical section.
>
> Original lock behavior introduced in commit 7a2fcbf7f8573 ("ext4: don't
> use blocks freed but not yet committed in buddy cache init") to avoid
> race betwwen ext4_mb_free_blocks and ext4_mb_init_cache:
> ext4_mb_load_buddy_gfp
> ext4_lock_group
> mb_clear_bits(bitmap_bh, ...)
> mb_free_blocks/ext4_mb_free_metadata
> ext4_unlock_group
> ext4_mb_unload_buddy
>
> New lock behavior in this patch:
> ext4_mb_load_buddy_gfp
> ext4_lock_group
> mb_clear_bits(bitmap_bh, ...)
> ext4_unlock_group
>
> /* no ext4_mb_init_cache for the same group will be called as
> ext4_mb_load_buddy_gfp will ensure buddy page is update-to-date */
>
> ext4_lock_group
> mb_free_blocks/ext4_mb_free_metadata
> ext4_unlock_group
> ext4_mb_unload_buddy
>
> As buddy page for group is always update-to-date between
> ext4_mb_load_buddy_gfp and ext4_mb_unload_buddy. Then no
> ext4_mb_init_cache will be called for the same group concurrentlly when
> we update bitmap and buddy page betwwen buddy load and unload.

More information will definitely help.

In ext4_mb_init_cache(), within a lock_group(), we first initialize
a incore bitmap from on disk block bitmap, pa and from
ext4_mb_generate_from_freelist() (this function basically requires
ext4_mb_free_metadata() to be called)
Then we go and initialize incore buddy within a page which utilize bitmap
block data (from previous step) for generating buddy info.
So this clearly means we need incore bitmap and mb_free_metadata() to be updated
together within the same group lock.

Now you said that ext4_mb_init_cache() can't be called together between
ext4_mb_load_buddy_gfp() and unload_buddy() because buddy page is uptodate?? 
Can you give more details please? 

What about if the resize gets called on the last group which is within the
same page on which we are operating. Also consider blocksize < pagesize.
That means we can have even more blocks within the same page.
So ext4_mb_init_cache() can still get called right while between load_buddy and unload_buddy?

Maybe I need to take a closer look at it.

-ritesh


>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 90 ++++++++++++-----------------------------------
>  1 file changed, 23 insertions(+), 67 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 34fd12aeaf8d..57cc304b724e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6325,19 +6325,21 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  			       ext4_fsblk_t block, unsigned long count,
>  			       int flags)
>  {
> -	struct buffer_head *bitmap_bh = NULL;
> +	struct ext4_mark_context mc = {
> +		.handle = handle,
> +		.sb = inode->i_sb,
> +		.state = 0,
> +	};
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
>  
> @@ -6369,18 +6371,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
> @@ -6390,28 +6380,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
> @@ -6420,6 +6389,22 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  	if (err)
>  		goto error_return;
>  
> +#ifdef AGGRESSIVE_CHECK
> +	mark_flags |= EXT4_MB_BITMAP_MARKED_CHECK;
> +#endif
> +	err = ext4_mb_mark_group_bb(&mc, block_group, bit, count_clusters,
> +				    mark_flags);
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
> +
>  	/*
>  	 * We need to make sure we don't reuse the freed block until after the
>  	 * transaction is committed. We make an exception if the inode is to be
> @@ -6442,13 +6427,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
> @@ -6461,23 +6441,11 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
> @@ -6492,26 +6460,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
>  	if (overflow && !err) {
>  		block += count;
>  		count = overflow;
> -		put_bh(bitmap_bh);
>  		/* The range changed so it's no longer validated */
>  		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
>  		goto do_more;
>  	}
>  error_return:
> -	brelse(bitmap_bh);
>  	ext4_std_error(sb, err);
>  	return;
>  }
> -- 
> 2.30.0
