Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343EE7A7236
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Sep 2023 07:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjITFkF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Sep 2023 01:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjITFkE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Sep 2023 01:40:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C38F
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 22:39:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690d2441b95so384142b3a.1
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 22:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695188396; x=1695793196; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TQ92W8Cd7riJcWPKJrv/n0aImxZE1ak2d8A0f+w3aPw=;
        b=d8ih1T7SowQWzlyNZSM4yU0hAi0Vz02GtRkj0ebnSNPNHJQTZyYAWCeot25al5JEoh
         rp8vdP6HSaD12KKgAcDos8PNeACXc2ML9xAPPF3PAgmwzH1GASB407NeU3JgeNZZyAFx
         lrHwwGpikORbFXS2R9cRd+MBgH0jZyhYHLyjmI3avcw4DPxJGIs4zQP1nq6K/3hHifOa
         DGpnc9/hMz3dwC2797GN39yR/Nabqqbi8MEwoZCz8YurHjaVFnikyjGH1241rOUL4872
         DecMyI5fNOvXfQviNbSsx6VqPHDqvXeZStaFnzyMnzYVg1uag5/6qVKwd9GTMkvXQt7C
         9fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695188396; x=1695793196;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQ92W8Cd7riJcWPKJrv/n0aImxZE1ak2d8A0f+w3aPw=;
        b=R9mUyVmuCM0EusBUOrrD+pXLM/92zJs0vTOcWQsdiyYMvZEUyl424lJ3J1que0b66v
         +eaht9mA12+rg+5Y93RoSqQ1BLAjbSZtKk5eQ4lIgFCi2aPUrfPpBiJi9Y8PUgcY191I
         vL5XBWLcbb86xBLH1pxWsFaTWZxWGP/7LCTE1U7bSVLl2cfmDsyAjmlsEHQNWoyu8lxi
         PazmXHiRMtYUwl3sZh6mutUokbPf1WmKuEaudsOwtCJdISrmZ7udRQgAsLXXDMnqOteg
         8EDJszRcV9quaPVM9YT7c91M4w4UF1i6qTNaj1FYcOL4m7rVxkRli3gh63m/L07r4oDS
         drxQ==
X-Gm-Message-State: AOJu0YxkUXpAEDYMaDbWMkTpp48mbYuFvwkoaPQx4GAWmfrqoiWmk+jn
        4aSoA25WXYf+VRCa7NfL7xbRcA6c/a4=
X-Google-Smtp-Source: AGHT+IGsWunudbqNuJ0lf+S2PK9UFiaprco7JXmu6AO1HsAHhLKg+4Ztd+lnfVj3G1vPMvVwDwl7BA==
X-Received: by 2002:a05:6a20:9383:b0:149:97e4:8ae4 with SMTP id x3-20020a056a20938300b0014997e48ae4mr2417631pzh.0.1695188396121;
        Tue, 19 Sep 2023 22:39:56 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id 18-20020a056a00073200b0068844ee18dfsm9354014pfm.83.2023.09.19.22.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 22:39:55 -0700 (PDT)
Date:   Wed, 20 Sep 2023 11:09:52 +0530
Message-Id: <874jjp768n.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Bobi Jam <bobijam@hotmail.com>, linux-ext4@vger.kernel.org
Cc:     Bobi Jam <bobijam@hotmail.com>
Subject: Re: [PATCH v3] ext4: optimize metadata allocation for hybrid LUNs
In-Reply-To: <OS3P286MB056790B5527B8DD75F1B21B7AFF1A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Bobi Jam <bobijam@hotmail.com> writes:

> With LVM it is possible to create an LV with SSD storage at the
> beginning of the LV and HDD storage at the end of the LV, and use that
> to separate ext4 metadata allocations (that need small random IOs)
> from data allocations (that are better suited for large sequential
> IOs) depending on the type of underlying storage.  Between 0.5-1.0% of
> the filesystem capacity would need to be high-IOPS storage in order to
> hold all of the internal metadata.
>
> This would improve performance for inode and other metadata access,
> such as ls, find, e2fsck, and in general improve file access latency,
> modification, truncate, unlink, transaction commit, etc.
>
> This patch split largest free order group lists and average fragment
> size lists into other two lists for IOPS/fast storage groups, and
> cr 0 / cr 1 group scanning for metadata block allocation in following
> order:
>
> if (allocate metadata blocks)
>       if (cr == 0)
>               try to find group in largest free order IOPS group list
>       if (cr == 1)
>               try to find group in fragment size IOPS group list
>       if (above two find failed)
>               fall through normal group lists as before

Ok, so we are agreeing that if the iops groups are full, we will
fallback to non-iops group for metadata.


> if (allocate data blocks)
>       try to find group in normal group lists as before
>       if (failed to find group in normal group && mb_enable_iops_data)
>               try to find group in IOPS groups

same here but with mb_enable_iops_data.


>
> Non-metadata block allocation does not allocate from the IOPS groups
> if non-IOPS groups are not used up.

Sure. At least ENOSPC use case can be handled once mb_enable_iops_data
is enabled. (for users who might end up using large iops disk)

>
> Add for mke2fs an option to mark which blocks are in the IOPS region
> of storage at format time:
>
>   -E iops=0-1024G,4096-8192G
>
> so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
> group descriptors to decide which groups to allocate dynamic
> filesystem metadata.
>
> Signed-off-by: Bobi Jam <bobijam@hotmail.com
>
> --
> v2->v3: add sysfs mb_enable_iops_data to enable data block allocation
>         from IOPS groups.
> v1->v2: for metadata block allocation, search in IOPS list then normal
>         list.
> ---
>  fs/ext4/balloc.c   |   2 +-
>  fs/ext4/ext4.h     |  13 +++
>  fs/ext4/extents.c  |   5 +-
>  fs/ext4/indirect.c |   5 +-
>  fs/ext4/mballoc.c  | 229 +++++++++++++++++++++++++++++++++++++++++----
>  fs/ext4/sysfs.c    |   4 +
>  6 files changed, 234 insertions(+), 24 deletions(-)
>
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index c1edde817be8..7b1b3ec2650c 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -739,7 +739,7 @@ ext4_fsblk_t ext4_new_meta_blocks(handle_t *handle, struct inode *inode,
>  	ar.inode = inode;
>  	ar.goal = goal;
>  	ar.len = count ? *count : 1;
> -	ar.flags = flags;
> +	ar.flags = flags | EXT4_MB_HINT_METADATA;
>  
>  	ret = ext4_mb_new_blocks(handle, &ar, errp);
>  	if (count)
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8104a21b001a..a8f21f63f5ff 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -382,6 +382,7 @@ struct flex_groups {
>  #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use */
>  #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
>  #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
> +#define EXT4_BG_IOPS		0x0010 /* In IOPS/fast storage */

Not related to this patch. But why not 0x0008? Is it reserved for
anything else?


>  
>  /*
>   * Macro-instructions used to manage group descriptors
> @@ -1112,6 +1113,8 @@ struct ext4_inode_info {
>  #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in use */
>  #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* to test development code */
>  
> +#define EXT2_FLAGS_HAS_IOPS		0x0080	/* has IOPS storage */
> +

same here. Are the flag values in between 0x0004 and 0x0080 are reserved?

>  /*
>   * Mount flags set via mount options or defaults
>   */
> @@ -1514,8 +1517,12 @@ struct ext4_sb_info {
>  	atomic_t s_retry_alloc_pending;
>  	struct list_head *s_mb_avg_fragment_size;
>  	rwlock_t *s_mb_avg_fragment_size_locks;
> +	struct list_head *s_avg_fragment_size_list_iops;  /* avg_frament_size for IOPS groups */
> +	rwlock_t *s_avg_fragment_size_locks_iops;
>  	struct list_head *s_mb_largest_free_orders;
>  	rwlock_t *s_mb_largest_free_orders_locks;
> +	struct list_head *s_largest_free_orders_list_iops; /* largest_free_orders for IOPS grps */
> +	rwlock_t *s_largest_free_orders_locks_iops;
>  
>  	/* tunables */
>  	unsigned long s_stripe;
> @@ -1532,6 +1539,7 @@ struct ext4_sb_info {
>  	unsigned long s_mb_last_start;
>  	unsigned int s_mb_prefetch;
>  	unsigned int s_mb_prefetch_limit;
> +	unsigned int s_mb_enable_iops_data;
>  
>  	/* stats for buddy allocator */
>  	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
> @@ -3366,6 +3374,7 @@ struct ext4_group_info {
>  #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
>  	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
>  #define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
> +#define EXT4_GROUP_INFO_IOPS_BIT		5
>  
>  #define EXT4_MB_GRP_NEED_INIT(grp)	\
>  	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
> @@ -3382,6 +3391,10 @@ struct ext4_group_info {
>  	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
>  #define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
>  	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, &((grp)->bb_state)))
> +#define EXT4_MB_GRP_TEST_IOPS(grp)	\
> +	(test_bit(EXT4_GROUP_INFO_IOPS_BIT, &((grp)->bb_state)))
> +#define EXT4_MB_GRP_SET_IOPS(grp)	\
> +	(set_bit(EXT4_GROUP_INFO_IOPS_BIT, &((grp)->bb_state)))
>  
>  #define EXT4_MAX_CONTENTION		8
>  #define EXT4_CONTENTION_THRESHOLD	2
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 35703dce23a3..6bfa784a3dad 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4272,11 +4272,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	ar.len = EXT4_NUM_B2C(sbi, offset+allocated);
>  	ar.goal -= offset;
>  	ar.logical -= offset;
> -	if (S_ISREG(inode->i_mode))
> +	if (S_ISREG(inode->i_mode) &&
> +	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
>  		ar.flags = EXT4_MB_HINT_DATA;
>  	else
>  		/* disable in-core preallocation for non-regular files */
> -		ar.flags = 0;
> +		ar.flags = EXT4_MB_HINT_METADATA;
>  	if (flags & EXT4_GET_BLOCKS_NO_NORMALIZE)
>  		ar.flags |= EXT4_MB_HINT_NOPREALLOC;
>  	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index c68bebe7ff4b..e1042c4e8ce6 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -610,8 +610,11 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>  	memset(&ar, 0, sizeof(ar));
>  	ar.inode = inode;
>  	ar.logical = map->m_lblk;
> -	if (S_ISREG(inode->i_mode))
> +	if (S_ISREG(inode->i_mode) &&
> +	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
>  		ar.flags = EXT4_MB_HINT_DATA;
> +	else
> +		ar.flags = EXT4_MB_HINT_METADATA;
>  	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
>  		ar.flags |= EXT4_MB_DELALLOC_RESERVED;
>  	if (flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 20f67a260df5..a676d26eccbc 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -828,6 +828,8 @@ static void
>  mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	rwlock_t *afs_locks;
> +	struct list_head *afs_list;
>  	int new_order;
>  
>  	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
> @@ -838,20 +840,24 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>  	if (new_order == grp->bb_avg_fragment_size_order)
>  		return;
>  
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> +	    EXT4_MB_GRP_TEST_IOPS(grp)) {
> +		afs_locks = sbi->s_avg_fragment_size_locks_iops;
> +		afs_list = sbi->s_avg_fragment_size_list_iops;
> +	} else {
> +		afs_locks = sbi->s_mb_avg_fragment_size_locks;
> +		afs_list = sbi->s_mb_avg_fragment_size;
> +	}
> +
>  	if (grp->bb_avg_fragment_size_order != -1) {
> -		write_lock(&sbi->s_mb_avg_fragment_size_locks[
> -					grp->bb_avg_fragment_size_order]);
> +		write_lock(&afs_locks[grp->bb_avg_fragment_size_order]);
>  		list_del(&grp->bb_avg_fragment_size_node);
> -		write_unlock(&sbi->s_mb_avg_fragment_size_locks[
> -					grp->bb_avg_fragment_size_order]);
> +		write_unlock(&afs_locks[grp->bb_avg_fragment_size_order]);
>  	}
>  	grp->bb_avg_fragment_size_order = new_order;
> -	write_lock(&sbi->s_mb_avg_fragment_size_locks[
> -					grp->bb_avg_fragment_size_order]);
> -	list_add_tail(&grp->bb_avg_fragment_size_node,
> -		&sbi->s_mb_avg_fragment_size[grp->bb_avg_fragment_size_order]);
> -	write_unlock(&sbi->s_mb_avg_fragment_size_locks[
> -					grp->bb_avg_fragment_size_order]);
> +	write_lock(&afs_locks[new_order]);
> +	list_add_tail(&grp->bb_avg_fragment_size_node, &afs_list[new_order]);
> +	write_unlock(&afs_locks[new_order]);
>  }
>  
>  /*
> @@ -986,6 +992,95 @@ next_linear_group(struct ext4_allocation_context *ac, int group, int ngroups)
>  	return group + 1 >= ngroups ? 0 : group + 1;
>  }
>  
> +static bool ext4_mb_choose_next_iops_group_cr0(
> +			struct ext4_allocation_context *ac, ext4_group_t *group)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> +	struct ext4_group_info *iter, *grp;
> +	int i;
> +
> +	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR0_OPTIMIZED))
> +		atomic_inc(&sbi->s_bal_cr0_bad_suggestions);
> +
> +	grp = NULL;
> +	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> +		if (list_empty(&sbi->s_largest_free_orders_list_iops[i]))
> +			continue;
> +		read_lock(&sbi->s_largest_free_orders_locks_iops[i]);
> +		if (list_empty(&sbi->s_largest_free_orders_list_iops[i])) {
> +			read_unlock(&sbi->s_largest_free_orders_locks_iops[i]);
> +			continue;
> +		}
> +		grp = NULL;
> +		list_for_each_entry(iter,
> +				    &sbi->s_largest_free_orders_list_iops[i],
> +				    bb_largest_free_order_node) {
> +			if (sbi->s_mb_stats)
> +				atomic64_inc(&sbi->s_bal_cX_groups_considered[0]);
> +			if (likely(ext4_mb_good_group(ac, iter->bb_group, 0))) {
> +				grp = iter;
> +				break;
> +			}
> +		}
> +		read_unlock(&sbi->s_largest_free_orders_locks_iops[i]);
> +		if (grp)
> +			break;
> +	}
> +
> +	if (grp) {
> +		*group = grp->bb_group;
> +		ac->ac_flags |= EXT4_MB_CR0_OPTIMIZED;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool ext4_mb_choose_next_iops_group_cr1(
> +			struct ext4_allocation_context *ac, ext4_group_t *group)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> +	struct ext4_group_info *grp = NULL, *iter;
> +	int i;
> +
> +	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
> +		if (sbi->s_mb_stats)
> +			atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
> +	}
> +
> +	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
> +	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> +		if (list_empty(&sbi->s_avg_fragment_size_list_iops[i]))
> +			continue;
> +		read_lock(&sbi->s_avg_fragment_size_locks_iops[i]);
> +		if (list_empty(&sbi->s_avg_fragment_size_list_iops[i])) {
> +			read_unlock(&sbi->s_avg_fragment_size_locks_iops[i]);
> +			continue;
> +		}
> +		list_for_each_entry(iter,
> +				    &sbi->s_avg_fragment_size_list_iops[i],
> +				    bb_avg_fragment_size_node) {
> +			if (sbi->s_mb_stats)
> +				atomic64_inc(&sbi->s_bal_cX_groups_considered[1]);
> +			if (likely(ext4_mb_good_group(ac, iter->bb_group, 1))) {
> +				grp = iter;
> +				break;
> +			}
> +		}
> +		read_unlock(&sbi->s_avg_fragment_size_locks_iops[i]);
> +		if (grp)
> +			break;
> +	}
> +
> +	if (grp) {
> +		*group = grp->bb_group;
> +		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * ext4_mb_choose_next_group: choose next group for allocation.
>   *
> @@ -1002,6 +1097,10 @@ next_linear_group(struct ext4_allocation_context *ac, int group, int ngroups)
>  static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
>  {
> +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> +	bool alloc_metadata = ac->ac_flags & EXT4_MB_HINT_METADATA;
> +	bool ret = false;
> +
>  	*new_cr = ac->ac_criteria;
>  
>  	if (!should_optimize_scan(ac) || ac->ac_groups_linear_remaining) {
> @@ -1009,11 +1108,37 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  		return;
>  	}
>  
> +	if (alloc_metadata && sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) {
> +		if (*new_cr == 0)
> +			ret = ext4_mb_choose_next_iops_group_cr0(ac, group);
> +		if (!ret && *new_cr < 2)
> +			ret = ext4_mb_choose_next_iops_group_cr1(ac, group);

This is a bit confusing here. Say if *new_cr = 0 fails, then we return
ret = false and fallback to choosing xx_iops_group_cr1(). And say if we
were able to find a group which satisfies this allocation request we
return. But the caller never knows that we allocated using cr1 and not
cr0. Because we never updated *new_cr inside xx_iops_group_crX()

> +		if (ret)
> +			return;
> +		/*
> +		 * Cannot get metadata group from IOPS storage, fall through
> +		 * to slow storage.
> +		 */
> +		cond_resched();

Not sure after you fix above case, do we still require cond_resched()
here. Note we already have one in the for loop which iterates over all
the groups for a given ac_criteria.

> +	}
> +
>  	if (*new_cr == 0) {
>  		ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
>  	} else if (*new_cr == 1) {
>  		ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
>  	} else {
> +		/*
> +		 * Cannot get data group from slow storage, try IOPS storage
> +		 */
> +		if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> +		    !alloc_metadata && sbi->s_mb_enable_iops_data &&
> +		    *new_cr == 3) {
> +			if (ac->ac_2order)
> +				ret = ext4_mb_choose_next_iops_group_cr0(ac,
> +									 group);
> +			if (!ret)
> +				ext4_mb_choose_next_iops_group_cr1(ac, group);
> +		}

We might never come here in this else case because
should_optimize_scan() which we check in the beginning of this function
will return 0 and we will chose a next linear group for CR >= 2.

>  		/*
>  		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
>  		 * bb_free. But until that happens, we should never come here.
> @@ -1030,6 +1155,8 @@ static void
>  mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	rwlock_t *lfo_locks;
> +	struct list_head *lfo_list;
>  	int i;
>  
>  	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--)
> @@ -1042,21 +1169,25 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
>  		return;
>  	}
>  
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> +	    EXT4_MB_GRP_TEST_IOPS(grp)) {
> +		lfo_locks = sbi->s_largest_free_orders_locks_iops;
> +		lfo_list = sbi->s_largest_free_orders_list_iops;
> +	} else {
> +		lfo_locks = sbi->s_mb_largest_free_orders_locks;
> +		lfo_list = sbi->s_mb_largest_free_orders;
> +	}
> +
>  	if (grp->bb_largest_free_order >= 0) {
> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
> -					      grp->bb_largest_free_order]);
> +		write_lock(&lfo_locks[grp->bb_largest_free_order]);
>  		list_del_init(&grp->bb_largest_free_order_node);
> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
> -					      grp->bb_largest_free_order]);
> +		write_unlock(&lfo_locks[grp->bb_largest_free_order]);
>  	}
>  	grp->bb_largest_free_order = i;
>  	if (grp->bb_largest_free_order >= 0 && grp->bb_free) {
> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
> -					      grp->bb_largest_free_order]);
> -		list_add_tail(&grp->bb_largest_free_order_node,
> -		      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
> -					      grp->bb_largest_free_order]);
> +		write_lock(&lfo_locks[i]);
> +		list_add_tail(&grp->bb_largest_free_order_node, &lfo_list[i]);
> +		write_unlock(&lfo_locks[i]);
>  	}
>  }
>  
> @@ -2498,6 +2629,10 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>  		goto out;
>  	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
>  		goto out;
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> +	    (ac->ac_flags & EXT4_MB_HINT_DATA) && EXT4_MB_GRP_TEST_IOPS(grp) &&
> +	    !sbi->s_mb_enable_iops_data)
> +		goto out;

since we already have a grp information here. Then checking for s_flags
and is redundant here right?


>  	if (should_lock) {
>  		__acquire(ext4_group_lock_ptr(sb, group));
>  		ext4_unlock_group(sb, group);
> @@ -3150,6 +3285,9 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
>  	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
>  	init_rwsem(&meta_group_info[i]->alloc_sem);
>  	meta_group_info[i]->bb_free_root = RB_ROOT;
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> +	    desc->bg_flags & EXT4_BG_IOPS)
> +		EXT4_MB_GRP_SET_IOPS(meta_group_info[i]);
>  	INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
>  	INIT_LIST_HEAD(&meta_group_info[i]->bb_avg_fragment_size_node);
>  	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
> @@ -3423,6 +3561,26 @@ int ext4_mb_init(struct super_block *sb)
>  		INIT_LIST_HEAD(&sbi->s_mb_avg_fragment_size[i]);
>  		rwlock_init(&sbi->s_mb_avg_fragment_size_locks[i]);
>  	}
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) {
> +		sbi->s_avg_fragment_size_list_iops =
> +			kmalloc_array(MB_NUM_ORDERS(sb),
> +				      sizeof(struct list_head), GFP_KERNEL);
> +		if (!sbi->s_avg_fragment_size_list_iops) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		sbi->s_avg_fragment_size_locks_iops =
> +			kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
> +				      GFP_KERNEL);
> +		if (!sbi->s_avg_fragment_size_locks_iops) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
> +			INIT_LIST_HEAD(&sbi->s_avg_fragment_size_list_iops[i]);
> +			rwlock_init(&sbi->s_avg_fragment_size_locks_iops[i]);
> +		}
> +	}
>  	sbi->s_mb_largest_free_orders =
>  		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
>  			GFP_KERNEL);
> @@ -3441,6 +3599,27 @@ int ext4_mb_init(struct super_block *sb)
>  		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
>  		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
>  	}
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) {
> +		sbi->s_largest_free_orders_list_iops =
> +			kmalloc_array(MB_NUM_ORDERS(sb),
> +				      sizeof(struct list_head), GFP_KERNEL);
> +		if (!sbi->s_largest_free_orders_list_iops) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		sbi->s_largest_free_orders_locks_iops =
> +			kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
> +				      GFP_KERNEL);
> +		if (!sbi->s_largest_free_orders_locks_iops) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
> +			INIT_LIST_HEAD(
> +				&sbi->s_largest_free_orders_list_iops[i]);
> +			rwlock_init(&sbi->s_largest_free_orders_locks_iops[i]);
> +		}
> +	}
>  
>  	spin_lock_init(&sbi->s_md_lock);
>  	sbi->s_mb_free_pending = 0;
> @@ -3481,6 +3660,8 @@ int ext4_mb_init(struct super_block *sb)
>  			sbi->s_mb_group_prealloc, sbi->s_stripe);
>  	}
>  
> +	sbi->s_mb_enable_iops_data = 0;
> +
>  	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
>  	if (sbi->s_locality_groups == NULL) {
>  		ret = -ENOMEM;
> @@ -3512,8 +3693,12 @@ int ext4_mb_init(struct super_block *sb)
>  out:
>  	kfree(sbi->s_mb_avg_fragment_size);
>  	kfree(sbi->s_mb_avg_fragment_size_locks);
> +	kfree(sbi->s_avg_fragment_size_list_iops);
> +	kfree(sbi->s_avg_fragment_size_locks_iops);
>  	kfree(sbi->s_mb_largest_free_orders);
>  	kfree(sbi->s_mb_largest_free_orders_locks);
> +	kfree(sbi->s_largest_free_orders_list_iops);
> +	kfree(sbi->s_largest_free_orders_locks_iops);
>  	kfree(sbi->s_mb_offsets);
>  	sbi->s_mb_offsets = NULL;
>  	kfree(sbi->s_mb_maxs);
> @@ -3582,8 +3767,12 @@ int ext4_mb_release(struct super_block *sb)
>  	}
>  	kfree(sbi->s_mb_avg_fragment_size);
>  	kfree(sbi->s_mb_avg_fragment_size_locks);
> +	kfree(sbi->s_avg_fragment_size_list_iops);
> +	kfree(sbi->s_avg_fragment_size_locks_iops);
>  	kfree(sbi->s_mb_largest_free_orders);
>  	kfree(sbi->s_mb_largest_free_orders_locks);
> +	kfree(sbi->s_largest_free_orders_list_iops);
> +	kfree(sbi->s_largest_free_orders_locks_iops);
>  	kfree(sbi->s_mb_offsets);
>  	kfree(sbi->s_mb_maxs);
>  	iput(sbi->s_buddy_cache);
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 3042bc605bbf..86ab6c4ed3b8 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -245,6 +245,7 @@ EXT4_ATTR(journal_task, 0444, journal_task);
>  EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
>  EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
>  EXT4_RW_ATTR_SBI_UL(last_trim_minblks, s_last_trim_minblks);
> +EXT4_RW_ATTR_SBI_UI(mb_enable_iops_data, s_mb_enable_iops_data);
>  
>  static unsigned int old_bump_val = 128;
>  EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -295,6 +296,7 @@ static struct attribute *ext4_attrs[] = {
>  	ATTR_LIST(mb_prefetch),
>  	ATTR_LIST(mb_prefetch_limit),
>  	ATTR_LIST(last_trim_minblks),
> +	ATTR_LIST(mb_enable_iops_data),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(ext4);
> @@ -318,6 +320,7 @@ EXT4_ATTR_FEATURE(fast_commit);
>  #if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
>  EXT4_ATTR_FEATURE(encrypted_casefold);
>  #endif
> +EXT4_ATTR_FEATURE(iops);
>  
>  static struct attribute *ext4_feat_attrs[] = {
>  	ATTR_LIST(lazy_itable_init),
> @@ -338,6 +341,7 @@ static struct attribute *ext4_feat_attrs[] = {
>  #if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
>  	ATTR_LIST(encrypted_casefold),
>  #endif
> +	ATTR_LIST(iops),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(ext4_feat);
> -- 
> 2.42.0
