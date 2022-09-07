Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36E5B0C9B
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Sep 2022 20:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiIGSlU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Sep 2022 14:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiIGSlS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Sep 2022 14:41:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C7A5726
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 11:41:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id jm11so15416770plb.13
        for <linux-ext4@vger.kernel.org>; Wed, 07 Sep 2022 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=A5qWF7vbTMBHvVVN4s3i1GnpYqr8JjUXMIWu2el1he8=;
        b=LH25r8bfNLl4LKKo7JBrx3+DlrhMj0tPpqsjdqpWMJ0scJTDv1klnvg2TAMlWMbIZT
         0t6A86Am8hYN403vLE6smXV1rg84crkA3KvcKNmuVcpo8M/p7gofBBktqQsrak+YcK0n
         e6goctnXN3+iCiz5sWRsKonV1FKNk95LMFqHl37WwzD/EBEbi2dJL6Hsso3KIPk9qYR2
         5SDRfle348kFEPxgbaQRCIA7aJzpnKQewUqjlV3d4+v9T6BsotzGXZT213JW6lP3f90V
         2KGhOOc9sYrq1oDpGkMluXpD8gwMKiGcJ+HmYtQmmkjnkGharpo/6Fp1wz7SJBtsw1vE
         vNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A5qWF7vbTMBHvVVN4s3i1GnpYqr8JjUXMIWu2el1he8=;
        b=RsVa1BjZpH52SBj0imJTylhAuvAvUfhjr1UEeMK/gvL2D1djUVZYUQeDiTHL+2pE/Q
         3GhxIeipViUKyDp9Ii0rWj2CfiYYQyRP15ntJiF0RO82+4hbv41pWUHaMqhkt5Zp1Vb3
         guPFP6vtL7KHY+i6uTxqRduxV2NULDQloenx4KwBIMqJcXnioWwixMES50aLti7ESolZ
         MMigAWJ0xscowq8X/eYo/Jpx2qN+79YuZKovYdBuc31p1W0Ph1csbdf5rC86lhiTwRQi
         hS9sbP7pluYyfBUXD234ZqKLaArbhZCGnWp0ctyMux7pXQYCXPK8Hy+CljvA99T1X4P0
         fa0Q==
X-Gm-Message-State: ACgBeo3IreEF3DsRARXfv/OKfHM+nwbSYK9DfD697B42gfs7tOyen8tX
        aL3Gx9Cmhew55akceEoYyWs=
X-Google-Smtp-Source: AA6agR4IuSPPeCeUbIRyXE02cU0SNGffSwMNZlxXr7nAjzuyrZ7sMbF/yDSDkbUES+33x+JLgvkOZw==
X-Received: by 2002:a17:902:c951:b0:176:d421:7502 with SMTP id i17-20020a170902c95100b00176d4217502mr5345487pla.72.1662576076761;
        Wed, 07 Sep 2022 11:41:16 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id x29-20020aa7957d000000b00528bd940390sm12920735pfq.153.2022.09.07.11.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:41:16 -0700 (PDT)
Date:   Thu, 8 Sep 2022 00:11:10 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 5/5] ext4: Use buckets for cr 1 block scan instead of
 rbtree
Message-ID: <20220907184110.wu2uqs7s3hggdtj2@riteshh-domain>
References: <20220906150803.375-1-jack@suse.cz>
 <20220906152920.25584-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906152920.25584-5-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/06 05:29PM, Jan Kara wrote:
> Using rbtree for sorting groups by average fragment size is relatively
> expensive (needs rbtree update on every block freeing or allocation) and
> leads to wide spreading of allocations because selection of block group
> is very sentitive both to changes in free space and amount of blocks
> allocated. Furthermore selecting group with the best matching average
> fragment size is not necessary anyway, even more so because the
> variability of fragment sizes within a group is likely large so average
> is not telling much. We just need a group with large enough average
> fragment size so that we have high probability of finding large enough
> free extent and we don't want average fragment size to be too big so
> that we are likely to find free extent only somewhat larger than what we
> need.
> 
> So instead of maintaing rbtree of groups sorted by fragment size keep
> bins (lists) or groups where average fragment size is in the interval
> [2^i, 2^(i+1)). This structure requires less updates on block allocation
> / freeing, generally avoids chaotic spreading of allocations into block
> groups, and still is able to quickly (even faster that the rbtree)
> provide a block group which is likely to have a suitably sized free
> space extent.

This makes sense because we anyways maintain buddy bitmap for MB_NUM_ORDERS
bitmaps. Hence our data structure to maintain different lists of groups, with 
their average fragments size can be bounded within MB_NUM_ORDERS lists.
This also makes it for amortized O(1) search time for finding the right group
in CR1 search.

> 
> This patch reduces number of block groups used when untarring archive
> with medium sized files (size somewhat above 64k which is default
> mballoc limit for avoiding locality group preallocation) to about half
> and thus improves write speeds for eMMC flash significantly.
> 

Indeed a nice change. More inline with the how we maintain
sbi->s_mb_largest_free_orders lists.

I think as you already noted there are few minor checkpatch errors,
other than that one small query below.

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/ext4.h    |  10 +-
>  fs/ext4/mballoc.c | 252 +++++++++++++++++++---------------------------
>  fs/ext4/mballoc.h |   1 -
>  3 files changed, 110 insertions(+), 153 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9bca5565547b..3bf9a6926798 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -167,8 +167,6 @@ enum SHIFT_DIRECTION {
>  #define EXT4_MB_CR0_OPTIMIZED		0x8000
>  /* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
>  #define EXT4_MB_CR1_OPTIMIZED		0x00010000
> -/* Perform linear traversal for one group */
> -#define EXT4_MB_SEARCH_NEXT_LINEAR	0x00020000
>  struct ext4_allocation_request {
>  	/* target inode for block we're allocating */
>  	struct inode *inode;
> @@ -1600,8 +1598,8 @@ struct ext4_sb_info {
>  	struct list_head s_discard_list;
>  	struct work_struct s_discard_work;
>  	atomic_t s_retry_alloc_pending;
> -	struct rb_root s_mb_avg_fragment_size_root;
> -	rwlock_t s_mb_rb_lock;
> +	struct list_head *s_mb_avg_fragment_size;
> +	rwlock_t *s_mb_avg_fragment_size_locks;
>  	struct list_head *s_mb_largest_free_orders;
>  	rwlock_t *s_mb_largest_free_orders_locks;
>  
> @@ -3413,6 +3411,8 @@ struct ext4_group_info {
>  	ext4_grpblk_t	bb_first_free;	/* first free block */
>  	ext4_grpblk_t	bb_free;	/* total free blocks */
>  	ext4_grpblk_t	bb_fragments;	/* nr of freespace fragments */
> +	int		bb_avg_fragment_size_order;	/* order of average
> +							   fragment in BG */
>  	ext4_grpblk_t	bb_largest_free_order;/* order of largest frag in BG */
>  	ext4_group_t	bb_group;	/* Group number */
>  	struct          list_head bb_prealloc_list;
> @@ -3420,7 +3420,7 @@ struct ext4_group_info {
>  	void            *bb_bitmap;
>  #endif
>  	struct rw_semaphore alloc_sem;
> -	struct rb_node	bb_avg_fragment_size_rb;
> +	struct list_head bb_avg_fragment_size_node;
>  	struct list_head bb_largest_free_order_node;
>  	ext4_grpblk_t	bb_counters[];	/* Nr of free power-of-two-block
>  					 * regions, index is order.
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index af1e49c3603f..213d2d0750dd 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -140,13 +140,15 @@
>   *    number of buddy bitmap orders possible) number of lists. Group-infos are
>   *    placed in appropriate lists.
>   *
> - * 2) Average fragment size rb tree (sbi->s_mb_avg_fragment_size_root)
> + * 2) Average fragment size lists (sbi->s_mb_avg_fragment_size)
>   *
> - *    Locking: sbi->s_mb_rb_lock (rwlock)
> + *    Locking: sbi->s_mb_avg_fragment_size_locks(array of rw locks)
>   *
> - *    This is a red black tree consisting of group infos and the tree is sorted
> - *    by average fragment sizes (which is calculated as ext4_group_info->bb_free
> - *    / ext4_group_info->bb_fragments).
> + *    This is an array of lists where in the i-th list there are groups with
> + *    average fragment size >= 2^i and < 2^(i+1). The average fragment size
> + *    is computed as ext4_group_info->bb_free / ext4_group_info->bb_fragments.
> + *    Note that we don't bother with a special list for completely empty groups
> + *    so we only have MB_NUM_ORDERS(sb) lists.
>   *
>   * When "mb_optimize_scan" mount option is set, mballoc consults the above data
>   * structures to decide the order in which groups are to be traversed for
> @@ -160,7 +162,8 @@
>   *
>   * At CR = 1, we only consider groups where average fragment size > request
>   * size. So, we lookup a group which has average fragment size just above or
> - * equal to request size using our rb tree (data structure 2) in O(log N) time.
> + * equal to request size using our average fragment size group lists (data
> + * structure 2) in O(1) time.
>   *
>   * If "mb_optimize_scan" mount option is not set, mballoc traverses groups in
>   * linear order which requires O(N) search time for each CR 0 and CR 1 phase.
> @@ -802,65 +805,51 @@ static void ext4_mb_mark_free_simple(struct super_block *sb,
>  	}
>  }
>  
> -static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *new,
> -			int (*cmp)(struct rb_node *, struct rb_node *))
> +static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>  {
> -	struct rb_node **iter = &root->rb_node, *parent = NULL;
> +	int order;
>  
> -	while (*iter) {
> -		parent = *iter;
> -		if (cmp(new, *iter) > 0)
> -			iter = &((*iter)->rb_left);
> -		else
> -			iter = &((*iter)->rb_right);
> -	}
> -
> -	rb_link_node(new, parent, iter);
> -	rb_insert_color(new, root);
> -}
> -
> -static int
> -ext4_mb_avg_fragment_size_cmp(struct rb_node *rb1, struct rb_node *rb2)
> -{
> -	struct ext4_group_info *grp1 = rb_entry(rb1,
> -						struct ext4_group_info,
> -						bb_avg_fragment_size_rb);
> -	struct ext4_group_info *grp2 = rb_entry(rb2,
> -						struct ext4_group_info,
> -						bb_avg_fragment_size_rb);
> -	int num_frags_1, num_frags_2;
> -
> -	num_frags_1 = grp1->bb_fragments ?
> -		grp1->bb_free / grp1->bb_fragments : 0;
> -	num_frags_2 = grp2->bb_fragments ?
> -		grp2->bb_free / grp2->bb_fragments : 0;
> -
> -	return (num_frags_2 - num_frags_1);
> +	/*
> +	 * We don't bother with a special lists groups with only 1 block free
> + 	 * extents and for completely empty groups.
> +	 */
> +	order = fls(len) - 2;
> +	if (order < 0)
> +		return 0;
> +	if (order == MB_NUM_ORDERS(sb))
> +		order--;
> +	return order;
>  }
>  
> -/*
> - * Reinsert grpinfo into the avg_fragment_size tree with new average
> - * fragment size.
> - */
> +/* Move group to appropriate avg_fragment_size list */
>  static void
>  mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	int new_order;
>  
>  	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
>  		return;
>  
> -	write_lock(&sbi->s_mb_rb_lock);
> -	if (!RB_EMPTY_NODE(&grp->bb_avg_fragment_size_rb)) {
> -		rb_erase(&grp->bb_avg_fragment_size_rb,
> -				&sbi->s_mb_avg_fragment_size_root);
> -		RB_CLEAR_NODE(&grp->bb_avg_fragment_size_rb);
> -	}
> +	new_order = mb_avg_fragment_size_order(sb,
> +					grp->bb_free / grp->bb_fragments);

Previous rbtree change was always checking for if grp->bb_fragments for 0.
Can grp->bb_fragments be 0 here?

-ritesh
