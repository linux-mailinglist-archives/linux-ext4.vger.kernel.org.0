Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF8C75DA57
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Jul 2023 08:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGVGYf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Jul 2023 02:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjGVGYf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Jul 2023 02:24:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED2930F2;
        Fri, 21 Jul 2023 23:24:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-668709767b1so1837217b3a.2;
        Fri, 21 Jul 2023 23:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690007073; x=1690611873;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4i6bu0fpETyCBCUuthwGK2xzZufqjIn7sP3sT/KxBbc=;
        b=dMvrleTqiJoZhMDcZmmGjVkkLwg04GrQk1AXX/ZmlwgpdyjBWCNTcNqqAxKHzU6hMv
         SMklAQk5feQaFHSKN02D6O9q/FmPMd9lC6WeoyGjurv3svY+dJZibc1W3sAkCwlL9ilv
         nj5QU3EGKICCObtfggUbFYosPJ28HzdI8OvZwgVIUmslUJlEBkTYPp4bj27l5EGmJr3v
         ZLxEWlj5P+fAvzq9jYu+XXMBHmdmShpkq7MZJLxguKUex9JaXs2ucVXIntgkKkTbgDvt
         J4kVKX1fx2/d7CiVOC8eo4cdhir5Ylw8a/CFZcmeiHG8q9JXELoq0wfTqg/CYKgibXFh
         Gmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690007073; x=1690611873;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4i6bu0fpETyCBCUuthwGK2xzZufqjIn7sP3sT/KxBbc=;
        b=jwMzaJ3jiZWgcOTVnYJ0DKF70+63wrm0bOlYLSeaDllN1yWesxKV1jRsEV8Dp1TW2H
         p4G/2RcXmiFd/AzNS+u3xdi43dVyf7F15H2Bnscdk1FMHxEnc7d/zlqaVFdA8vLJLfGO
         ZfGwESW+/IOlLzwm3V8Xfj63AaPq+FUIokrLd3t7xyZz1Z0Cfz9Nu+tZtNvuOaq0JUDo
         lnvun1w2tmxxEdVMwwbA0AS+F2odak53dk2Ikc519BYyKx1SahJz75GoDEcEBGuUUqUt
         HMmBiUz3HDIir5+rVaZA/Y3neeKf4d2l5Y0hTik5i0uLqQzwNZX1x4t0GJh333O3xkAl
         QTTw==
X-Gm-Message-State: ABy/qLYiQxyW9JF8geGaW3lRhbF+wcz80jZIwKHVYXTMUYfBEuaiXHOy
        WDM3m4Uhm04RuOLMR+BmPNx+IpiayNM=
X-Google-Smtp-Source: APBJJlHES6oVSy60CgAAx8xMIY0FnvT5obDXk2XqvGL/eEXqOPcJjHFdh+ZG0kPxCXsNphuLB9aoFQ==
X-Received: by 2002:a05:6a00:2ea4:b0:682:b6c8:2eb with SMTP id fd36-20020a056a002ea400b00682b6c802ebmr2511030pfb.1.1690007073014;
        Fri, 21 Jul 2023 23:24:33 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006702c433741sm3950110pfd.3.2023.07.21.23.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 23:24:32 -0700 (PDT)
Date:   Sat, 22 Jul 2023 11:54:28 +0530
Message-Id: <87jzusjwf7.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH v5 1/8] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
In-Reply-To: <20230629144007.1263510-2-shikemeng@huaweicloud.com>
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

> There are several reasons to add a general function to update block
> bitmap and group descriptor on disk:
> 1. pair behavior of alloc/free bits. For example,
> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
> 2. remove repeat code to read from disk, update and write back to disk.
> 3. reduce future unit test mocks to catch real IO to update structure
> on disk.

Thanks for the cleanup and sorry that I am starting to review this
series only now. However I do have some review comments to understand a
bit more on the patch series. 

>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/mballoc.c | 157 +++++++++++++++++++++++++---------------------
>  1 file changed, 87 insertions(+), 70 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a2475b8c9fb5..58864a9116c0 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3948,6 +3948,86 @@ void ext4_exit_mballoc(void)
>  	ext4_groupinfo_destroy_slabs();
>  }
>  
> +struct ext4_mark_context {
> +	struct super_block *sb;
> +	int state;
> +};

It's not totally clear the intention behind this structure from above
since it lacking any comments.

Can you please help me understand why do we need this.
I still don't know whether we require this structure and what is it's
purpose. Is it only for reducing the number of variable passing?

Let me do more reading... 

...On more reading, I was previous considering to rename it to something
like ext4_mb_mark_context, but then I realized the naming of this is
something similar to ext4_allocation_context. So we may keep the naming
as is.

So since this structure, presumably, is used for marking blk bits for
mballoc. Why don't we pass useful information which is relevant for
this operation like - 

    ext4_mark_context {
        ext4_group_t mc_group;          /* block group */
        ext4_grpblk_t mc_clblk;	    /* block in cluster units */
        ext4_grpblk_t mc_cllen;	    /* len in cluster units */
        ext4_grpblk_t mc_clupdates;     /* number of clusters marked/unmarked */
        unsigned int mc_flags;          /* flags ... */
        bool mc_state;                  /* to set or unset state */
    };

Maybe, super_block and handle we can pass as an argument as those doesn't
define the ext4_mark_context for mballoc.

Since this structure is prepared not at the begining of any function, we
may need a prepare function for it. e.g. 

   static void ext4_mb_prepare_mark_context(&mc, ...)
   static int ext4_mb_mark_context(sb, handle, &mc);  (instead of ext4_mb_mark_group_bb())

Does this sounds better to you? Thoughts?

Otherwise I think having a common function for mb_mark_context looks
like a nice cleanup.

-ritesh

> +
> +static int
> +ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
> +		      ext4_grpblk_t blkoff, ext4_grpblk_t len)
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
> @@ -4074,15 +4154,15 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  			int len, int state)
>  {
> -	struct buffer_head *bitmap_bh = NULL;
> -	struct ext4_group_desc *gdp;
> -	struct buffer_head *gdp_bh;
> +	struct ext4_mark_context mc = {
> +		.sb = sb,
> +		.state = state,
> +	};
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	ext4_group_t group;
>  	ext4_grpblk_t blkoff;
> -	int i, err;
> -	int already;
> -	unsigned int clen, clen_changed, thisgrp_len;
> +	int err;
> +	unsigned int clen, thisgrp_len;
>  
>  	while (len > 0) {
>  		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
> @@ -4103,80 +4183,17 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  			ext4_error(sb, "Marking blocks in system zone - "
>  				   "Block = %llu, len = %u",
>  				   block, thisgrp_len);
> -			bitmap_bh = NULL;
>  			break;
>  		}
>  
> -		bitmap_bh = ext4_read_block_bitmap(sb, group);
> -		if (IS_ERR(bitmap_bh)) {
> -			err = PTR_ERR(bitmap_bh);
> -			bitmap_bh = NULL;
> -			break;
> -		}
> -
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
> +		err = ext4_mb_mark_group_bb(&mc, group, blkoff, clen);
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
