Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65FE76E7EC
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 14:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjHCMKS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 08:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjHCMKR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 08:10:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E32726
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 05:10:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so591882b3a.2
        for <linux-ext4@vger.kernel.org>; Thu, 03 Aug 2023 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691064615; x=1691669415;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3llepoFgMtUTTU4+SIC0wmdj6+LAm45pAM5j8EAy7f0=;
        b=RYgYNp+lPDzCJ21rWxihBL7opj5sHytIhxgf8yNTCxZ3eLwkNxajuYlrIRMzPw2fxb
         jOvipwhwa9fQC8SqNb6wDDXiXqnwXieCDv8CZPXlqSBe+sQzECvdRi5d6mVqRBoEaISN
         azjvUQ4iFoBPMztEigpej7KqSPgFWkrbZFb0qe5CnGtWIZhY/LwWgz+VDtpp5tjUTUj2
         mB8pgbQ684s9lGdNiFTyUa82MX1smW0ig8K0IDN80I8HMcUbs7jXil3ssGcHERL4VhAQ
         tlXQRROgJq9Jh2szhhkfPGqDFuIGNJdFl8evBeMWHeIX5NsyzVY0vqehJlscLzd4aJCp
         PsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691064615; x=1691669415;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3llepoFgMtUTTU4+SIC0wmdj6+LAm45pAM5j8EAy7f0=;
        b=LczFma/LPVrOaEacgaPcyLqCRRL5FIWpQ5bjtxRAqmX+2YSyxY2geCh6nAAUQLD0cp
         3n6omEiHEMWylku7sz21+7GwxT2JIZyn0D3Xmv3OzMOYeurT7O5w5D8Gbu32tb4vUJBa
         mjRuVs2LW6xvtHLIKn/Iz5dtImPyLyZB+MRZciHGHBuw417jtqRn63h01DMx1zeZ0E18
         qjcEH/FeDGIxRhAfEmrgkGTA9UdB7rN0fY7jTOuZwTgTlYtLz71HA9GBK6GHBl+9JG1w
         IXORclClLaCyMRUwf7MmrxMtfI/qwRYYnqo9eMFL7WGTjbmnOb801kEq1Cl4I9UhbpZY
         fIxw==
X-Gm-Message-State: ABy/qLYhIlo7FbaDPvQXWlGuzY8hK4vA4ubdQEx6GbE6mdnpaa14d3oP
        j8oI2wKbzYcPHJPWA6xAzFoH7GvRNDE=
X-Google-Smtp-Source: APBJJlGIPLMJpE9Ggj+pLZ6GMhacCsI6Csfk9q4tYJ91O89rRK9bhoAZWb/udN6wM7y2jdasyIlrSg==
X-Received: by 2002:a17:90a:a47:b0:267:fba3:ed96 with SMTP id o65-20020a17090a0a4700b00267fba3ed96mr14378359pjo.3.1691064615195;
        Thu, 03 Aug 2023 05:10:15 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090a65c200b0026852d886fcsm2505932pjs.36.2023.08.03.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 05:10:14 -0700 (PDT)
Date:   Thu, 03 Aug 2023 17:40:11 +0530
Message-Id: <87msz8wcm4.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Bobi Jam <bobijam@hotmail.com>, linux-ext4@vger.kernel.org
Cc:     Bobi Jam <bobijam@hotmail.com>
Subject: Re: [PATCH 1/2] ext4: optimize metadata allocation for hybrid LUNs
In-Reply-To: <OS3P286MB056789DF4EBAA7363A4346B5AF06A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
> cr 0 on largest free order IOPS group list
> cr 1 on average fragment size IOPS group list
> cr 0 on largest free order non-IOPS group list
> cr 1 on average fragment size non-IOPS group list
> cr >= 2 perform the linear search as before

Yes. The implementation looks straight forward to me.


>
> Non-metadata block allocation does not allocate from the IOPS groups.
>
> Add for mke2fs an option to mark which blocks are in the IOPS region
> of storage at format time:
>
>   -E iops=0-1024G,4096-8192G

However few things to discuss here are - 

1. What happens when the hdd space for data gets fully exhausted? AFAICS, the
allocation for data blocks will still succeed, however we won't be able
to make use of optimized scanning any more. Because we search within
iops lists only when EXT4_MB_HINT_METADATA is set in ac->ac_flags.

2. Similarly what happens when the ssd space for metadata gets full.
In this case we keep falling back to cr2 for allocation and we don't
utilize optimize_scanning to find the block groups from hdd space to
allocate from.

3. So it seems after a period of time, these iops lists can have block
groups belonging to differnt ssds. Could this cause the metadata
allocation of related inodes to come from different ssds.
Will this be optimal? Checking on this...
     ...On checking further on this, we start with a goal group and we
at least scan s_mb_max_linear_groups (4) linearly. So it's unlikely that
we frequently allocate metadata blocks from different SSDs.

4. Ok looking into this, do we even require the iops lists for metadata
allocations? Do we allocate more than 1 blocks for metadata? If not then
maintaining these iops lists for metadata allocation isn't really
helpful. On the other hand it does make sense to maintain it when we
allow data allocations from these ssds when hdds gets full.

5. Did we run any benchmarks with this yet? What kind of gains we are
looking for? Do we have any numbers for this?

6. I couldn't stop but start to think of... 
Should there also be a provision from the user to pass hot/cold data
types which we can use as a hint within the filesystem to allocate from
ssd v/s hdd? Does it even make sense to think in this direction?

-ritesh


>
> so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
> group descriptors to decide which groups to allocate dynamic filesystem
> metadata.
>
> Signed-off-by: Bobi Jam <bobijam@hotmail.com>
> ---
>  fs/ext4/balloc.c  |   2 +-
>  fs/ext4/ext4.h    |  12 +++++
>  fs/ext4/mballoc.c | 154 ++++++++++++++++++++++++++++++++++++++++++------------
>  3 files changed, 134 insertions(+), 34 deletions(-)
>
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index c1edde8..7b1b3ec 100644
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
> index 8104a21..3444b6e 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -382,6 +382,7 @@ struct flex_groups {
>  #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use */
>  #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
>  #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
> +#define EXT4_BG_IOPS		0x0010 /* In IOPS/fast storage */
>  
>  /*
>   * Macro-instructions used to manage group descriptors
> @@ -1112,6 +1113,8 @@ struct ext4_inode_info {
>  #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in use */
>  #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* to test development code */
>  
> +#define EXT2_FLAGS_HAS_IOPS		0x0080	/* has IOPS storage */
> +
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
> @@ -3366,6 +3373,7 @@ struct ext4_group_info {
>  #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
>  	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
>  #define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
> +#define EXT4_GROUP_INFO_IOPS_BIT		5
>  
>  #define EXT4_MB_GRP_NEED_INIT(grp)	\
>  	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
> @@ -3382,6 +3390,10 @@ struct ext4_group_info {
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
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 20f67a2..6d218af 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -828,6 +828,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>  mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	rwlock_t *afs_locks;
> +	struct list_head *afs_list;
>  	int new_order;
>  
>  	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
> @@ -838,20 +840,23 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>  	if (new_order == grp->bb_avg_fragment_size_order)
>  		return;
>  
> +	if (EXT4_MB_GRP_TEST_IOPS(grp)) {
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
> @@ -863,6 +868,10 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_group_info *iter, *grp;
> +	bool iops = ac->ac_flags & EXT4_MB_HINT_METADATA &&
> +		    ac->ac_sb->s_flags & EXT2_FLAGS_HAS_IOPS;
> +	rwlock_t *lfo_locks;
> +	struct list_head *lfo_list;
>  	int i;
>  
>  	if (ac->ac_status == AC_STATUS_FOUND)
> @@ -871,17 +880,25 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
>  	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR0_OPTIMIZED))
>  		atomic_inc(&sbi->s_bal_cr0_bad_suggestions);
>  
> +	if (iops) {
> +		lfo_locks = sbi->s_largest_free_orders_locks_iops;
> +		lfo_list = sbi->s_largest_free_orders_list_iops;
> +	} else {
> +		lfo_locks = sbi->s_mb_largest_free_orders_locks;
> +		lfo_list = sbi->s_mb_largest_free_orders;
> +	}
> +
>  	grp = NULL;
>  	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> -		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
> +		if (list_empty(&lfo_list[i]))
>  			continue;
> -		read_lock(&sbi->s_mb_largest_free_orders_locks[i]);
> -		if (list_empty(&sbi->s_mb_largest_free_orders[i])) {
> -			read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> +		read_lock(&lfo_locks[i]);
> +		if (list_empty(&lfo_list[i])) {
> +			read_unlock(&lfo_locks[i]);
>  			continue;
>  		}
>  		grp = NULL;
> -		list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
> +		list_for_each_entry(iter, &lfo_list[i],
>  				    bb_largest_free_order_node) {
>  			if (sbi->s_mb_stats)
>  				atomic64_inc(&sbi->s_bal_cX_groups_considered[0]);
> @@ -890,7 +907,7 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
>  				break;
>  			}
>  		}
> -		read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> +		read_unlock(&lfo_locks[i]);
>  		if (grp)
>  			break;
>  	}
> @@ -913,6 +930,10 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_group_info *grp = NULL, *iter;
> +	bool iops = ac->ac_flags & EXT4_MB_HINT_METADATA &&
> +		    ac->ac_sb->s_flags & EXT2_FLAGS_HAS_IOPS;
> +	rwlock_t *afs_locks;
> +	struct list_head *afs_list;
>  	int i;
>  
>  	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
> @@ -920,16 +941,24 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
>  			atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
>  	}
>  
> +	if (iops) {
> +		afs_locks = sbi->s_avg_fragment_size_locks_iops;
> +		afs_list = sbi->s_avg_fragment_size_list_iops;
> +	} else {
> +		afs_locks = sbi->s_mb_avg_fragment_size_locks;
> +		afs_list = sbi->s_mb_avg_fragment_size;
> +	}
> +
>  	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
>  	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> -		if (list_empty(&sbi->s_mb_avg_fragment_size[i]))
> +		if (list_empty(&afs_list[i]))
>  			continue;
> -		read_lock(&sbi->s_mb_avg_fragment_size_locks[i]);
> -		if (list_empty(&sbi->s_mb_avg_fragment_size[i])) {
> -			read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
> +		read_lock(&afs_locks[i]);
> +		if (list_empty(&afs_list[i])) {
> +			read_unlock(&afs_locks[i]);
>  			continue;
>  		}
> -		list_for_each_entry(iter, &sbi->s_mb_avg_fragment_size[i],
> +		list_for_each_entry(iter, &afs_list[i],
>  				    bb_avg_fragment_size_node) {
>  			if (sbi->s_mb_stats)
>  				atomic64_inc(&sbi->s_bal_cX_groups_considered[1]);
> @@ -938,7 +967,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
>  				break;
>  			}
>  		}
> -		read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
> +		read_unlock(&afs_locks[i]);
>  		if (grp)
>  			break;
>  	}
> @@ -947,7 +976,15 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
>  		*group = grp->bb_group;
>  		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
>  	} else {
> -		*new_cr = 2;
> +		if (iops) {
> +			/* cannot find proper group in IOPS storage,
> +			 * fall back to cr0 for non-IOPS groups.
> +			 */
> +			ac->ac_flags &= ~EXT4_MB_HINT_METADATA;
> +			*new_cr = 0;
> +		} else {
> +			*new_cr = 2;
> +		}
>  	}
>  }
>  
> @@ -1030,6 +1067,8 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	rwlock_t *lfo_locks;
> +	struct list_head *lfo_list;
>  	int i;
>  
>  	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--)
> @@ -1042,21 +1081,24 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  		return;
>  	}
>  
> +	if (EXT4_MB_GRP_TEST_IOPS(grp)) {
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
> @@ -3150,6 +3192,8 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
>  	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
>  	init_rwsem(&meta_group_info[i]->alloc_sem);
>  	meta_group_info[i]->bb_free_root = RB_ROOT;
> +	if (desc->bg_flags & EXT4_BG_IOPS)
> +		EXT4_MB_GRP_SET_IOPS(meta_group_info[i]);
>  	INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
>  	INIT_LIST_HEAD(&meta_group_info[i]->bb_avg_fragment_size_node);
>  	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
> @@ -3423,6 +3467,24 @@ int ext4_mb_init(struct super_block *sb)
>  		INIT_LIST_HEAD(&sbi->s_mb_avg_fragment_size[i]);
>  		rwlock_init(&sbi->s_mb_avg_fragment_size_locks[i]);
>  	}
> +	sbi->s_avg_fragment_size_list_iops =
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
> +			      GFP_KERNEL);
> +	if (!sbi->s_avg_fragment_size_list_iops) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	sbi->s_avg_fragment_size_locks_iops =
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
> +			      GFP_KERNEL);
> +	if (!sbi->s_avg_fragment_size_locks_iops) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
> +		INIT_LIST_HEAD(&sbi->s_avg_fragment_size_list_iops[i]);
> +		rwlock_init(&sbi->s_avg_fragment_size_locks_iops[i]);
> +	}
>  	sbi->s_mb_largest_free_orders =
>  		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
>  			GFP_KERNEL);
> @@ -3441,6 +3503,24 @@ int ext4_mb_init(struct super_block *sb)
>  		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
>  		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
>  	}
> +	sbi->s_largest_free_orders_list_iops =
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
> +			      GFP_KERNEL);
> +	if (!sbi->s_largest_free_orders_list_iops) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	sbi->s_largest_free_orders_locks_iops =
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
> +			      GFP_KERNEL);
> +	if (!sbi->s_largest_free_orders_locks_iops) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
> +		INIT_LIST_HEAD(&sbi->s_largest_free_orders_list_iops[i]);
> +		rwlock_init(&sbi->s_largest_free_orders_locks_iops[i]);
> +	}
>  
>  	spin_lock_init(&sbi->s_md_lock);
>  	sbi->s_mb_free_pending = 0;
> @@ -3512,8 +3592,12 @@ int ext4_mb_init(struct super_block *sb)
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
> @@ -3582,8 +3666,12 @@ int ext4_mb_release(struct super_block *sb)
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
> -- 
> 1.8.3.1
