Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C053334D7F4
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 21:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhC2TPB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 15:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhC2TOl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Mar 2021 15:14:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F029C061574
        for <linux-ext4@vger.kernel.org>; Mon, 29 Mar 2021 12:14:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so43387pjb.1
        for <linux-ext4@vger.kernel.org>; Mon, 29 Mar 2021 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=DH/8guoaXFahlIeMqqYmtaYw7uA8i39VzkiE5HQH76U=;
        b=PnQP6ohJCABqcBjcSdLgjVsfQcFazszZkNJHJsrkiMKTfBJEbxxWy25/qrLFtoKdhY
         X/ulwcrGJMXuA98ibaQLkbXkdMciSGnZKQzZNfy59Q43z8Uq/f8AL/Y3tAwJCyb6AwEz
         A3PGO3tQCQzBjSi9pf6ixVgNMgdUOxlIXpgKajM1DhvB7mwCXEwA9g948SS0pwbcVcza
         nAjuYYqUaVZcVEdKvAE5caZrOh+/72CAW47kvVIDFnbo2a8VQzFkLzElebBpZ+aYBtdH
         +F9tOAqlTp4Oq2U8/ZUwuuLVGkglwrx/59/HAqTRNHT7w/XE9hlD7YNhawwloWhY+6Xg
         dMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=DH/8guoaXFahlIeMqqYmtaYw7uA8i39VzkiE5HQH76U=;
        b=uA4duGuQzJIvTgpV/VUTr84oEXTdYHYqq1lvKhHPjYJIHlzC8/h2MoPr7StPz0zs1/
         4R46q4GAOJSscEyi94dITY+Y5L+oMzKmMaQ3bnE2hr6SoeI7UWGRR/hdXJv2UTCEIIoV
         7fJWuF1CRIrUtWjTLX9ZmQM5uJ1lsLx6c71mmBPsDZFgPpOsuWT58h/BDVDY+0yblaJH
         MiM2q/2CqtQoqGWHCyj03gyCCb8a594T6qLfDsJtHp3drQ0vGJsO0kH8HzSZ46FfFtU2
         2ywQACMfSrhRvv0h8W2oE/5M7HCUczZ4qUZkBjHR33a4krAc2+ggLyeB2Y6TKTe4GOZQ
         jo3w==
X-Gm-Message-State: AOAM530uAdx1+8iilztQ4u+E5h0s74BvrO6f6EEdhUItG/OhW+WTjlyj
        XDlB3XyQZWi3VWFKBIU2jlzqSg==
X-Google-Smtp-Source: ABdhPJwuULOsjrWn55pNEBmYv6fHPuhZT3VxBXlm8LglTEIJLQ0V2E64b/oeb5PjjX7vex/10wfs4Q==
X-Received: by 2002:a17:902:7b84:b029:e6:ec5a:3097 with SMTP id w4-20020a1709027b84b02900e6ec5a3097mr29386902pll.58.1617045280895;
        Mon, 29 Mar 2021 12:14:40 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 195sm16651849pge.7.2021.03.29.12.14.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 12:14:40 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9DAEEA02-458D-4320-877E-B70F9A4473F9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7695B517-E849-4056-8C4F-4E1046941E30";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v5 5/6] ext4: improve cr 0 / cr 1 group scanning
Date:   Mon, 29 Mar 2021 13:14:38 -0600
In-Reply-To: <20210324231916.2515824-6-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
 <20210324231916.2515824-6-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_7695B517-E849-4056-8C4F-4E1046941E30
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 24, 2021, at 5:19 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Instead of traversing through groups linearly, scan groups in specific
> orders at cr 0 and cr 1. At cr 0, we want to find groups that have the
> largest free order >=3D the order of the request. So, with this patch,
> we maintain lists for each possible order and insert each group into a
> list based on the largest free order in its buddy bitmap. During cr 0
> allocation, we traverse these lists in the increasing order of largest
> free orders. This allows us to find a group with the best available cr
> 0 match in constant time. If nothing can be found, we fallback to cr 1
> immediately.
>=20
> At CR1, the story is slightly different. We want to traverse in the
> order of increasing average fragment size. For CR1, we maintain a rb
> tree of groupinfos which is sorted by average fragment size. Instead
> of traversing linearly, at CR1, we traverse in the order of increasing
> average fragment size, starting at the most optimal group. This brings
> down cr 1 search complexity to log(num groups).
>=20
> For cr >=3D 2, we just perform the linear search as before. Also, in
> case of lock contention, we intermittently fallback to linear search
> even in CR 0 and CR 1 cases. This allows us to proceed during the
> allocation path even in case of high contention.

If you are refreshing this patch anyway, could you rename =
"mb_linear_limit"
to "mb_linear_groups" or "mb_max_linear_groups" or similar?  It =
otherwise
isn't clear what units the "limit" is in (could be MB/GB or something =
else).

Cheers, Andreas

> There is an opportunity to do optimization at CR2 too. That's because
> at CR2 we only consider groups where bb_free counter (number of free
> blocks) is greater than the request extent size. That's left as future
> work.
>=20
> All the changes introduced in this patch are protected under a new
> mount option "mb_optimize_scan".
>=20
> With this patchset, following experiment was performed:
>=20
> Created a highly fragmented disk of size 65TB. The disk had no
> contiguous 2M regions. Following command was run consecutively for 3
> times:
>=20
> time dd if=3D/dev/urandom of=3Dfile bs=3D2M count=3D10
>=20
> Here are the results with and without cr 0/1 optimizations introduced
> in this patch:
>=20
> |---------+------------------------------+---------------------------|
> |         | Without CR 0/1 Optimizations | With CR 0/1 Optimizations |
> |---------+------------------------------+---------------------------|
> | 1st run | 5m1.871s                     | 2m47.642s                 |
> | 2nd run | 2m28.390s                    | 0m0.611s                  |
> | 3rd run | 2m26.530s                    | 0m1.255s                  |
> |---------+------------------------------+---------------------------|
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> ---
> fs/ext4/ext4.h    |  19 ++-
> fs/ext4/mballoc.c | 381 ++++++++++++++++++++++++++++++++++++++++++++--
> fs/ext4/mballoc.h |  17 ++-
> fs/ext4/super.c   |  28 +++-
> fs/ext4/sysfs.c   |   2 +
> 5 files changed, 432 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 85eeeba3bca3..5930c8cb5159 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -162,7 +162,10 @@ enum SHIFT_DIRECTION {
> #define EXT4_MB_USE_RESERVED		0x2000
> /* Do strict check for free blocks while retrying block allocation */
> #define EXT4_MB_STRICT_CHECK		0x4000
> -
> +/* Large fragment size list lookup succeeded at least once for cr =3D =
0 */
> +#define EXT4_MB_CR0_OPTIMIZED		0x8000
> +/* Avg fragment size rb tree lookup succeeded at least once for cr =3D =
1 */
> +#define EXT4_MB_CR1_OPTIMIZED		0x00010000
> struct ext4_allocation_request {
> 	/* target inode for block we're allocating */
> 	struct inode *inode;
> @@ -1247,7 +1250,9 @@ struct ext4_inode_info {
> #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal =
fast commit */
> #define EXT4_MOUNT2_DAX_NEVER		0x00000020 /* Do not allow =
Direct Access */
> #define EXT4_MOUNT2_DAX_INODE		0x00000040 /* For printing =
options only */
> -
> +#define EXT4_MOUNT2_MB_OPTIMIZE_SCAN	0x00000080 /* Optimize group
> +						    * scanning in =
mballoc
> +						    */
>=20
> #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &=3D \
> 						~EXT4_MOUNT_##opt
> @@ -1527,9 +1532,14 @@ struct ext4_sb_info {
> 	unsigned int s_mb_free_pending;
> 	struct list_head s_freed_data_list;	/* List of blocks to be =
freed
> 						   after commit =
completed */
> +	struct rb_root s_mb_avg_fragment_size_root;
> +	rwlock_t s_mb_rb_lock;
> +	struct list_head *s_mb_largest_free_orders;
> +	rwlock_t *s_mb_largest_free_orders_locks;
>=20
> 	/* tunables */
> 	unsigned long s_stripe;
> +	unsigned int s_mb_linear_limit;
> 	unsigned int s_mb_stream_request;
> 	unsigned int s_mb_max_to_scan;
> 	unsigned int s_mb_min_to_scan;
> @@ -1553,6 +1563,8 @@ struct ext4_sb_info {
> 	atomic_t s_bal_goals;	/* goal hits */
> 	atomic_t s_bal_breaks;	/* too long searches */
> 	atomic_t s_bal_2orders;	/* 2^order hits */
> +	atomic_t s_bal_cr0_bad_suggestions;
> +	atomic_t s_bal_cr1_bad_suggestions;
> 	atomic64_t s_bal_cX_groups_considered[4];
> 	atomic64_t s_bal_cX_hits[4];
> 	atomic64_t s_bal_cX_failed[4];		/* cX loop didn't find =
blocks */
> @@ -3309,11 +3321,14 @@ struct ext4_group_info {
> 	ext4_grpblk_t	bb_free;	/* total free blocks */
> 	ext4_grpblk_t	bb_fragments;	/* nr of freespace fragments */
> 	ext4_grpblk_t	bb_largest_free_order;/* order of largest frag =
in BG */
> +	ext4_group_t	bb_group;	/* Group number */
> 	struct          list_head bb_prealloc_list;
> #ifdef DOUBLE_CHECK
> 	void            *bb_bitmap;
> #endif
> 	struct rw_semaphore alloc_sem;
> +	struct rb_node	bb_avg_fragment_size_rb;
> +	struct list_head bb_largest_free_order_node;
> 	ext4_grpblk_t	bb_counters[];	/* Nr of free power-of-two-block
> 					 * regions, index is order.
> 					 * bb_counters[3] =3D 5 means
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 15127d815461..cbf9a89c0ef5 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -127,11 +127,50 @@
>  * smallest multiple of the stripe value (sbi->s_stripe) which is
>  * greater than the default mb_group_prealloc.
>  *
> + * If "mb_optimize_scan" mount option is set, we maintain in memory =
group info
> + * structures in two data structures:
> + *
> + * 1) Array of largest free order lists =
(sbi->s_mb_largest_free_orders)
> + *
> + *    Locking: sbi->s_mb_largest_free_orders_locks(array of rw locks)
> + *
> + *    This is an array of lists where the index in the array =
represents the
> + *    largest free order in the buddy bitmap of the participating =
group infos of
> + *    that list. So, there are exactly MB_NUM_ORDERS(sb) (which means =
total
> + *    number of buddy bitmap orders possible) number of lists. =
Group-infos are
> + *    placed in appropriate lists.
> + *
> + * 2) Average fragment size rb tree =
(sbi->s_mb_avg_fragment_size_root)
> + *
> + *    Locking: sbi->s_mb_rb_lock (rwlock)
> + *
> + *    This is a red black tree consisting of group infos and the tree =
is sorted
> + *    by average fragment sizes (which is calculated as =
ext4_group_info->bb_free
> + *    / ext4_group_info->bb_fragments).
> + *
> + * When "mb_optimize_scan" mount option is set, mballoc consults the =
above data
> + * structures to decide the order in which groups are to be traversed =
for
> + * fulfilling an allocation request.
> + *
> + * At CR =3D 0, we look for groups which have the largest_free_order =
>=3D the order
> + * of the request. We directly look at the largest free order list in =
the data
> + * structure (1) above where largest_free_order =3D order of the =
request. If that
> + * list is empty, we look at remaining list in the increasing order =
of
> + * largest_free_order. This allows us to perform CR =3D 0 lookup in =
O(1) time.
> + *
> + * At CR =3D 1, we only consider groups where average fragment size > =
request
> + * size. So, we lookup a group which has average fragment size just =
above or
> + * equal to request size using our rb tree (data structure 2) in =
O(log N) time.
> + *
> + * If "mb_optimize_scan" mount option is not set, mballoc traverses =
groups in
> + * linear order which requires O(N) search time for each CR 0 and CR =
1 phase.
> + *
>  * The regular allocator (using the buddy cache) supports a few =
tunables.
>  *
>  * /sys/fs/ext4/<partition>/mb_min_to_scan
>  * /sys/fs/ext4/<partition>/mb_max_to_scan
>  * /sys/fs/ext4/<partition>/mb_order2_req
> + * /sys/fs/ext4/<partition>/mb_linear_limit
>  *
>  * The regular allocator uses buddy scan only if the request len is =
power of
>  * 2 blocks and the order of allocation is >=3D sbi->s_mb_order2_reqs. =
The
> @@ -149,6 +188,16 @@
>  * can be used for allocation. ext4_mb_good_group explains how the =
groups are
>  * checked.
>  *
> + * When "mb_optimize_scan" is turned on, as mentioned above, the =
groups may not
> + * get traversed linearly. That may result in subsequent allocations =
being not
> + * close to each other. And so, the underlying device may get filled =
up in a
> + * non-linear fashion. While that may not matter on non-rotational =
devices, for
> + * rotational devices that may result in higher seek times. =
"mb_linear_limit"
> + * tells mballoc how many groups mballoc should search linearly =
before
> + * performing consulting above data structures for more efficient =
lookups. For
> + * non rotational devices, this value defaults to 0 and for =
rotational devices
> + * this is set to MB_DEFAULT_LINEAR_LIMIT.
> + *
>  * Both the prealloc space are getting populated as above. So for the =
first
>  * request we will hit the buddy cache which will result in this =
prealloc
>  * space getting filled. The prealloc space is then later used for the
> @@ -299,6 +348,8 @@
>  *  - bitlock on a group	(group)
>  *  - object (inode/locality)	(object)
>  *  - per-pa lock		(pa)
> + *  - cr0 lists lock		(cr0)
> + *  - cr1 tree lock		(cr1)
>  *
>  * Paths:
>  *  - new pa
> @@ -328,6 +379,9 @@
>  *    group
>  *        object
>  *
> + *  - allocation path (ext4_mb_regular_allocator)
> + *    group
> + *    cr0/cr1
>  */
> static struct kmem_cache *ext4_pspace_cachep;
> static struct kmem_cache *ext4_ac_cachep;
> @@ -351,6 +405,9 @@ static void ext4_mb_generate_from_freelist(struct =
super_block *sb, void *bitmap,
> 						ext4_group_t group);
> static void ext4_mb_new_preallocation(struct ext4_allocation_context =
*ac);
>=20
> +static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
> +			       ext4_group_t group, int cr);
> +
> /*
>  * The algorithm using this percpu seq counter goes below:
>  * 1. We sample the percpu discard_pa_seq counter before trying for =
block
> @@ -744,6 +801,251 @@ static void ext4_mb_mark_free_simple(struct =
super_block *sb,
> 	}
> }
>=20
> +static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node =
*new,
> +			int (*cmp)(struct rb_node *, struct rb_node *))
> +{
> +	struct rb_node **iter =3D &root->rb_node, *parent =3D NULL;
> +
> +	while (*iter) {
> +		parent =3D *iter;
> +		if (cmp(new, *iter) > 0)
> +			iter =3D &((*iter)->rb_left);
> +		else
> +			iter =3D &((*iter)->rb_right);
> +	}
> +
> +	rb_link_node(new, parent, iter);
> +	rb_insert_color(new, root);
> +}
> +
> +static int
> +ext4_mb_avg_fragment_size_cmp(struct rb_node *rb1, struct rb_node =
*rb2)
> +{
> +	struct ext4_group_info *grp1 =3D rb_entry(rb1,
> +						struct ext4_group_info,
> +						=
bb_avg_fragment_size_rb);
> +	struct ext4_group_info *grp2 =3D rb_entry(rb2,
> +						struct ext4_group_info,
> +						=
bb_avg_fragment_size_rb);
> +	int num_frags_1, num_frags_2;
> +
> +	num_frags_1 =3D grp1->bb_fragments ?
> +		grp1->bb_free / grp1->bb_fragments : 0;
> +	num_frags_2 =3D grp2->bb_fragments ?
> +		grp2->bb_free / grp2->bb_fragments : 0;
> +
> +	return (num_frags_2 - num_frags_1);
> +}
> +
> +/*
> + * Reinsert grpinfo into the avg_fragment_size tree with new average
> + * fragment size.
> + */
> +static void
> +mb_update_avg_fragment_size(struct super_block *sb, struct =
ext4_group_info *grp)
> +{
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +
> +	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free =3D=3D 0)
> +		return;
> +
> +	write_lock(&sbi->s_mb_rb_lock);
> +	if (!RB_EMPTY_NODE(&grp->bb_avg_fragment_size_rb)) {
> +		rb_erase(&grp->bb_avg_fragment_size_rb,
> +				&sbi->s_mb_avg_fragment_size_root);
> +		RB_CLEAR_NODE(&grp->bb_avg_fragment_size_rb);
> +	}
> +
> +	ext4_mb_rb_insert(&sbi->s_mb_avg_fragment_size_root,
> +		&grp->bb_avg_fragment_size_rb,
> +		ext4_mb_avg_fragment_size_cmp);
> +	write_unlock(&sbi->s_mb_rb_lock);
> +}
> +
> +/*
> + * Choose next group by traversing largest_free_order lists. Return 0 =
if next
> + * group was selected optimally. Return 1 if next group was not =
selected
> + * optimally. Updates *new_cr if cr level needs an update.
> + */
> +static int ext4_mb_choose_next_group_cr0(struct =
ext4_allocation_context *ac,
> +		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> +{
> +	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> +	struct ext4_group_info *iter, *grp;
> +	int i;
> +
> +	if (ac->ac_status =3D=3D AC_STATUS_FOUND)
> +		return 1;
> +
> +	if (unlikely(sbi->s_mb_stats && ac->ac_flags & =
EXT4_MB_CR0_OPTIMIZED))
> +		atomic_inc(&sbi->s_bal_cr0_bad_suggestions);
> +
> +	grp =3D NULL;
> +	for (i =3D ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> +		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
> +			continue;
> +		read_lock(&sbi->s_mb_largest_free_orders_locks[i]);
> +		if (list_empty(&sbi->s_mb_largest_free_orders[i])) {
> +			=
read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> +			continue;
> +		}
> +		grp =3D NULL;
> +		list_for_each_entry(iter, =
&sbi->s_mb_largest_free_orders[i],
> +				    bb_largest_free_order_node) {
> +			if (sbi->s_mb_stats)
> +				=
atomic64_inc(&sbi->s_bal_cX_groups_considered[0]);
> +			if (likely(ext4_mb_good_group(ac, =
iter->bb_group, 0))) {
> +				grp =3D iter;
> +				break;
> +			}
> +		}
> +		read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> +		if (grp)
> +			break;
> +	}
> +
> +	if (!grp) {
> +		/* Increment cr and search again */
> +		*new_cr =3D 1;
> +	} else {
> +		*group =3D grp->bb_group;
> +		ac->ac_last_optimal_group =3D *group;
> +		ac->ac_flags |=3D EXT4_MB_CR0_OPTIMIZED;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Choose next group by traversing average fragment size tree. Return =
0 if next
> + * group was selected optimally. Return 1 if next group could not =
selected
> + * optimally (due to lock contention). Updates *new_cr if cr lvel =
needs an
> + * update.
> + */
> +static int ext4_mb_choose_next_group_cr1(struct =
ext4_allocation_context *ac,
> +		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> +{
> +	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> +	int avg_fragment_size, best_so_far;
> +	struct rb_node *node, *found;
> +	struct ext4_group_info *grp;
> +
> +	/*
> +	 * If there is contention on the lock, instead of waiting for =
the lock
> +	 * to become available, just continue searching lineraly. We'll =
resume
> +	 * our rb tree search later starting at =
ac->ac_last_optimal_group.
> +	 */
> +	if (!read_trylock(&sbi->s_mb_rb_lock))
> +		return 1;
> +
> +	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
> +		if (sbi->s_mb_stats)
> +			atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
> +		/* We have found something at CR 1 in the past */
> +		grp =3D ext4_get_group_info(ac->ac_sb, =
ac->ac_last_optimal_group);
> +		for (found =3D rb_next(&grp->bb_avg_fragment_size_rb); =
found !=3D NULL;
> +		     found =3D rb_next(found)) {
> +			grp =3D rb_entry(found, struct ext4_group_info,
> +				       bb_avg_fragment_size_rb);
> +			if (sbi->s_mb_stats)
> +				=
atomic64_inc(&sbi->s_bal_cX_groups_considered[1]);
> +			if (likely(ext4_mb_good_group(ac, grp->bb_group, =
1)))
> +				break;
> +		}
> +
> +		goto done;
> +	}
> +
> +	node =3D sbi->s_mb_avg_fragment_size_root.rb_node;
> +	best_so_far =3D 0;
> +	found =3D NULL;
> +
> +	while (node) {
> +		grp =3D rb_entry(node, struct ext4_group_info,
> +			       bb_avg_fragment_size_rb);
> +		avg_fragment_size =3D 0;
> +		/*
> +		 * Perform this check without locking, we'll lock later =
to confirm.
> +		 */
> +		if (ext4_mb_good_group(ac, grp->bb_group, 1)) {
> +			avg_fragment_size =3D grp->bb_fragments ?
> +				grp->bb_free / grp->bb_fragments : 0;
> +			if (!best_so_far || avg_fragment_size < =
best_so_far) {
> +				best_so_far =3D avg_fragment_size;
> +				found =3D node;
> +			}
> +		}
> +		if (avg_fragment_size > ac->ac_g_ex.fe_len)
> +			node =3D node->rb_right;
> +		else
> +			node =3D node->rb_left;
> +	}
> +
> +done:
> +	if (found) {
> +		grp =3D rb_entry(found, struct ext4_group_info,
> +			       bb_avg_fragment_size_rb);
> +		*group =3D grp->bb_group;
> +		ac->ac_flags |=3D EXT4_MB_CR1_OPTIMIZED;
> +	} else {
> +		*new_cr =3D 2;
> +	}
> +
> +	read_unlock(&sbi->s_mb_rb_lock);
> +	ac->ac_last_optimal_group =3D *group;
> +	return 0;
> +}
> +
> +/*
> + * ext4_mb_choose_next_group: choose next group for allocation.
> + *
> + * @ac        Allocation Context
> + * @new_cr    This is an output parameter. If the there is no good =
group
> + *            available at current CR level, this field is updated to =
indicate
> + *            the new cr level that should be used.
> + * @group     This is an input / output parameter. As an input it =
indicates the
> + *            last group used for allocation. As output, this field =
indicates
> + *            the next group that should be used.
> + * @ngroups   Total number of groups
> + */
> +static void ext4_mb_choose_next_group(struct ext4_allocation_context =
*ac,
> +		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> +{
> +	int ret;
> +
> +	*new_cr =3D ac->ac_criteria;
> +
> +	if (!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN) ||
> +	    *new_cr >=3D 2 ||
> +	    !ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> +		goto inc_and_return;
> +
> +	if (ac->ac_groups_linear_remaining) {
> +		ac->ac_groups_linear_remaining--;
> +		goto inc_and_return;
> +	}
> +
> +	if (*new_cr =3D=3D 0) {
> +		ret =3D ext4_mb_choose_next_group_cr0(ac, new_cr, group, =
ngroups);
> +		if (ret)
> +			goto inc_and_return;
> +	}
> +	if (*new_cr =3D=3D 1) {
> +		ret =3D ext4_mb_choose_next_group_cr1(ac, new_cr, group, =
ngroups);
> +		if (ret)
> +			goto inc_and_return;
> +	}
> +	return;
> +
> +inc_and_return:
> +	/*
> +	 * Artificially restricted ngroups for non-extent
> +	 * files makes group > ngroups possible on first loop.
> +	 */
> +	*group =3D *group + 1;
> +	if (*group >=3D ngroups)
> +		*group =3D 0;
> +}
> +
> /*
>  * Cache the order of the largest free extent we have available in =
this block
>  * group.
> @@ -751,18 +1053,33 @@ static void ext4_mb_mark_free_simple(struct =
super_block *sb,
> static void
> mb_set_largest_free_order(struct super_block *sb, struct =
ext4_group_info *grp)
> {
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> 	int i;
> -	int bits;
>=20
> +	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && =
grp->bb_largest_free_order >=3D 0) {
> +		write_lock(&sbi->s_mb_largest_free_orders_locks[
> +					      =
grp->bb_largest_free_order]);
> +		list_del_init(&grp->bb_largest_free_order_node);
> +		write_unlock(&sbi->s_mb_largest_free_orders_locks[
> +					      =
grp->bb_largest_free_order]);
> +	}
> 	grp->bb_largest_free_order =3D -1; /* uninit */
>=20
> -	bits =3D MB_NUM_ORDERS(sb) - 1;
> -	for (i =3D bits; i >=3D 0; i--) {
> +	for (i =3D MB_NUM_ORDERS(sb) - 1; i >=3D 0; i--) {
> 		if (grp->bb_counters[i] > 0) {
> 			grp->bb_largest_free_order =3D i;
> 			break;
> 		}
> 	}
> +	if (test_opt2(sb, MB_OPTIMIZE_SCAN) &&
> +	    grp->bb_largest_free_order >=3D 0 && grp->bb_free) {
> +		write_lock(&sbi->s_mb_largest_free_orders_locks[
> +					      =
grp->bb_largest_free_order]);
> +		list_add_tail(&grp->bb_largest_free_order_node,
> +		      =
&sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
> +		write_unlock(&sbi->s_mb_largest_free_orders_locks[
> +					      =
grp->bb_largest_free_order]);
> +	}
> }
>=20
> static noinline_for_stack
> @@ -818,6 +1135,7 @@ void ext4_mb_generate_buddy(struct super_block =
*sb,
> 	period =3D get_cycles() - period;
> 	atomic_inc(&sbi->s_mb_buddies_generated);
> 	atomic64_add(period, &sbi->s_mb_generation_time);
> +	mb_update_avg_fragment_size(sb, grp);
> }
>=20
> /* The buddy information is attached the buddy cache inode
> @@ -1517,6 +1835,7 @@ static void mb_free_blocks(struct inode *inode, =
struct ext4_buddy *e4b,
>=20
> done:
> 	mb_set_largest_free_order(sb, e4b->bd_info);
> +	mb_update_avg_fragment_size(sb, e4b->bd_info);
> 	mb_check_buddy(e4b);
> }
>=20
> @@ -1653,6 +1972,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, =
struct ext4_free_extent *ex)
> 	}
> 	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
>=20
> +	mb_update_avg_fragment_size(e4b->bd_sb, e4b->bd_info);
> 	ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
> 	mb_check_buddy(e4b);
>=20
> @@ -2347,17 +2667,21 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 		 * from the goal value specified
> 		 */
> 		group =3D ac->ac_g_ex.fe_group;
> +		ac->ac_last_optimal_group =3D group;
> +		ac->ac_groups_linear_remaining =3D =
sbi->s_mb_linear_limit;
> 		prefetch_grp =3D group;
>=20
> -		for (i =3D 0; i < ngroups; group++, i++) {
> -			int ret =3D 0;
> +		for (i =3D 0; i < ngroups; i++) {
> +			int ret =3D 0, new_cr;
> +
> 			cond_resched();
> -			/*
> -			 * Artificially restricted ngroups for =
non-extent
> -			 * files makes group > ngroups possible on first =
loop.
> -			 */
> -			if (group >=3D ngroups)
> -				group =3D 0;
> +
> +			ext4_mb_choose_next_group(ac, &new_cr, &group, =
ngroups);
> +
> +			if (new_cr !=3D cr) {
> +				cr =3D new_cr;
> +				goto repeat;
> +			}
>=20
> 			/*
> 			 * Batch reads of the block allocation bitmaps
> @@ -2578,6 +2902,8 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, =
void *offset)
> 		   atomic64_read(&sbi->s_bal_cX_groups_considered[0]));
> 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
> 		   atomic64_read(&sbi->s_bal_cX_failed[0]));
> +	seq_printf(seq, "\t\tbad_suggestions: %u\n",
> +		   atomic_read(&sbi->s_bal_cr0_bad_suggestions));
>=20
> 	seq_puts(seq, "\tcr1_stats:\n");
> 	seq_printf(seq, "\t\thits: %llu\n", =
atomic64_read(&sbi->s_bal_cX_hits[1]));
> @@ -2585,6 +2911,8 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, =
void *offset)
> 		   atomic64_read(&sbi->s_bal_cX_groups_considered[1]));
> 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
> 		   atomic64_read(&sbi->s_bal_cX_failed[1]));
> +	seq_printf(seq, "\t\tbad_suggestions: %u\n",
> +		   atomic_read(&sbi->s_bal_cr1_bad_suggestions));
>=20
> 	seq_puts(seq, "\tcr2_stats:\n");
> 	seq_printf(seq, "\t\thits: %llu\n", =
atomic64_read(&sbi->s_bal_cX_hits[2]));
> @@ -2719,7 +3047,10 @@ int ext4_mb_add_groupinfo(struct super_block =
*sb, ext4_group_t group,
> 	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
> 	init_rwsem(&meta_group_info[i]->alloc_sem);
> 	meta_group_info[i]->bb_free_root =3D RB_ROOT;
> +	INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
> +	RB_CLEAR_NODE(&meta_group_info[i]->bb_avg_fragment_size_rb);
> 	meta_group_info[i]->bb_largest_free_order =3D -1;  /* uninit */
> +	meta_group_info[i]->bb_group =3D group;
>=20
> 	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
> 	return 0;
> @@ -2909,6 +3240,26 @@ int ext4_mb_init(struct super_block *sb)
> 		i++;
> 	} while (i < MB_NUM_ORDERS(sb));
>=20
> +	sbi->s_mb_avg_fragment_size_root =3D RB_ROOT;
> +	sbi->s_mb_largest_free_orders =3D
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct =
list_head),
> +			GFP_KERNEL);
> +	if (!sbi->s_mb_largest_free_orders) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +	sbi->s_mb_largest_free_orders_locks =3D
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
> +			GFP_KERNEL);
> +	if (!sbi->s_mb_largest_free_orders_locks) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +	for (i =3D 0; i < MB_NUM_ORDERS(sb); i++) {
> +		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
> +		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
> +	}
> +	rwlock_init(&sbi->s_mb_rb_lock);
>=20
> 	spin_lock_init(&sbi->s_md_lock);
> 	sbi->s_mb_free_pending =3D 0;
> @@ -2961,6 +3312,10 @@ int ext4_mb_init(struct super_block *sb)
> 		spin_lock_init(&lg->lg_prealloc_lock);
> 	}
>=20
> +	if (blk_queue_nonrot(bdev_get_queue(sb->s_bdev)))
> +		sbi->s_mb_linear_limit =3D 0;
> +	else
> +		sbi->s_mb_linear_limit =3D MB_DEFAULT_LINEAR_LIMIT;
> 	/* init file for buddy data */
> 	ret =3D ext4_mb_init_backend(sb);
> 	if (ret !=3D 0)
> @@ -2972,6 +3327,8 @@ int ext4_mb_init(struct super_block *sb)
> 	free_percpu(sbi->s_locality_groups);
> 	sbi->s_locality_groups =3D NULL;
> out:
> +	kfree(sbi->s_mb_largest_free_orders);
> +	kfree(sbi->s_mb_largest_free_orders_locks);
> 	kfree(sbi->s_mb_offsets);
> 	sbi->s_mb_offsets =3D NULL;
> 	kfree(sbi->s_mb_maxs);
> @@ -3028,6 +3385,8 @@ int ext4_mb_release(struct super_block *sb)
> 		kvfree(group_info);
> 		rcu_read_unlock();
> 	}
> +	kfree(sbi->s_mb_largest_free_orders);
> +	kfree(sbi->s_mb_largest_free_orders_locks);
> 	kfree(sbi->s_mb_offsets);
> 	kfree(sbi->s_mb_maxs);
> 	iput(sbi->s_buddy_cache);
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 68111a10cfee..02585e3cbcad 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -78,6 +78,18 @@
>  */
> #define MB_DEFAULT_MAX_INODE_PREALLOC	512
>=20
> +/*
> + * Number of groups to search linearly before performing group =
scanning
> + * optimization.
> + */
> +#define MB_DEFAULT_LINEAR_LIMIT		4
> +
> +/*
> + * Minimum number of groups that should be present in the file system =
to perform
> + * group scanning optimizations.
> + */
> +#define MB_DEFAULT_LINEAR_SCAN_THRESHOLD	16
> +
> /*
>  * Number of valid buddy orders
>  */
> @@ -166,11 +178,14 @@ struct ext4_allocation_context {
> 	/* copy of the best found extent taken before preallocation =
efforts */
> 	struct ext4_free_extent ac_f_ex;
>=20
> +	ext4_group_t ac_last_optimal_group;
> +	__u32 ac_groups_considered;
> +	__u32 ac_flags;		/* allocation hints */
> 	__u16 ac_groups_scanned;
> +	__u16 ac_groups_linear_remaining;
> 	__u16 ac_found;
> 	__u16 ac_tail;
> 	__u16 ac_buddy;
> -	__u16 ac_flags;		/* allocation hints */
> 	__u8 ac_status;
> 	__u8 ac_criteria;
> 	__u8 ac_2order;		/* if request is to allocate 2^N blocks =
and
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 3a2cd9fb7e73..6116640081c0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1687,7 +1687,7 @@ enum {
> 	Opt_dioread_nolock, Opt_dioread_lock,
> 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> -	Opt_prefetch_block_bitmaps,
> +	Opt_prefetch_block_bitmaps, Opt_mb_optimize_scan,
> #ifdef CONFIG_EXT4_DEBUG
> 	Opt_fc_debug_max_replay, Opt_fc_debug_force
> #endif
> @@ -1788,6 +1788,7 @@ static const match_table_t tokens =3D {
> 	{Opt_nombcache, "nombcache"},
> 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
> 	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
> +	{Opt_mb_optimize_scan, "mb_optimize_scan=3D%d"},
> 	{Opt_removed, "check=3Dnone"},	/* mount option from ext2/3 */
> 	{Opt_removed, "nocheck"},	/* mount option from ext2/3 */
> 	{Opt_removed, "reservation"},	/* mount option from ext2/3 */
> @@ -1820,6 +1821,8 @@ static ext4_fsblk_t get_sb_block(void **data)
> }
>=20
> #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
> +#define DEFAULT_MB_OPTIMIZE_SCAN	(-1)
> +
> static const char deprecated_msg[] =3D
> 	"Mount option \"%s\" will be removed by %s\n"
> 	"Contact linux-ext4@vger.kernel.org if you think we should keep =
it.\n";
> @@ -2008,6 +2011,7 @@ static const struct mount_opts {
> 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
> 	 MOPT_SET},
> +	{Opt_mb_optimize_scan, EXT4_MOUNT2_MB_OPTIMIZE_SCAN, MOPT_GTE0},
> #ifdef CONFIG_EXT4_DEBUG
> 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
> 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
> @@ -2092,6 +2096,7 @@ static int ext4_set_test_dummy_encryption(struct =
super_block *sb,
> struct ext4_parsed_options {
> 	unsigned long journal_devnum;
> 	unsigned int journal_ioprio;
> +	int mb_optimize_scan;
> };
>=20
> static int handle_mount_opt(struct super_block *sb, char *opt, int =
token,
> @@ -2388,6 +2393,13 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
> 		sbi->s_mount_opt |=3D m->mount_opt;
> 	} else if (token =3D=3D Opt_data_err_ignore) {
> 		sbi->s_mount_opt &=3D ~m->mount_opt;
> +	} else if (token =3D=3D Opt_mb_optimize_scan) {
> +		if (arg !=3D 0 && arg !=3D 1) {
> +			ext4_msg(sb, KERN_WARNING,
> +				 "mb_optimize_scan should be set to 0 or =
1.");
> +			return -1;
> +		}
> +		parsed_opts->mb_optimize_scan =3D arg;
> 	} else {
> 		if (!args->from)
> 			arg =3D 1;
> @@ -4034,6 +4046,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	/* Set defaults for the variables that will be set during =
parsing */
> 	parsed_opts.journal_ioprio =3D DEFAULT_JOURNAL_IOPRIO;
> 	parsed_opts.journal_devnum =3D 0;
> +	parsed_opts.mb_optimize_scan =3D DEFAULT_MB_OPTIMIZE_SCAN;
>=20
> 	if ((data && !orig_data) || !sbi)
> 		goto out_free_base;
> @@ -4984,6 +4997,19 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	ext4_fc_replay_cleanup(sb);
>=20
> 	ext4_ext_init(sb);
> +
> +	/*
> +	 * Enable optimize_scan if number of groups is > threshold. This =
can be
> +	 * turned off by passing "mb_optimize_scan=3D0". This can also =
be
> +	 * turned on forcefully by passing "mb_optimize_scan=3D1".
> +	 */
> +	if (parsed_opts.mb_optimize_scan =3D=3D 1)
> +		set_opt2(sb, MB_OPTIMIZE_SCAN);
> +	else if (parsed_opts.mb_optimize_scan =3D=3D 0)
> +		clear_opt2(sb, MB_OPTIMIZE_SCAN);
> +	else if (sbi->s_groups_count >=3D =
MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
> +		set_opt2(sb, MB_OPTIMIZE_SCAN);
> +
> 	err =3D ext4_mb_init(sb);
> 	if (err) {
> 		ext4_msg(sb, KERN_ERR, "failed to initialize mballoc =
(%d)",
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 59ca9d73b42f..16b8a838f631 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -213,6 +213,7 @@ EXT4_RW_ATTR_SBI_UI(mb_order2_req, =
s_mb_order2_reqs);
> EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
> +EXT4_RW_ATTR_SBI_UI(mb_linear_limit, s_mb_linear_limit);
> EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
> EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, =
s_err_ratelimit_state.interval);
> @@ -260,6 +261,7 @@ static struct attribute *ext4_attrs[] =3D {
> 	ATTR_LIST(mb_stream_req),
> 	ATTR_LIST(mb_group_prealloc),
> 	ATTR_LIST(mb_max_inode_prealloc),
> +	ATTR_LIST(mb_linear_limit),
> 	ATTR_LIST(max_writeback_mb_bump),
> 	ATTR_LIST(extent_max_zeroout_kb),
> 	ATTR_LIST(trigger_fs_error),
> --
> 2.31.0.291.g576ba9dcdaf-goog
>=20


Cheers, Andreas






--Apple-Mail=_7695B517-E849-4056-8C4F-4E1046941E30
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBiJx4ACgkQcqXauRfM
H+D6XA//axSEYWvw57RcJ3WiZ0wdJF7tzTrnouDTBEKDvUHvuyisfWoah/Oz0X77
TqyYr1Im8mlT5opD3KUNzCRzpsRbyMn80iJYq9chMLxPUbsmkpCacYy2AnSrUAb6
Eos5P8LZ6UsLEJ+EcEyYJyoWAb5Iz6etzkC+dj9dq01RSlbeUn1/3ZZzoOnIbaxA
Ri+sS7eTsPJCruNsh1Qpf88O7GiFcFU21X38jjEZ6RP/4058qau5j/tjH4k7mRhL
il90DZVdvEFazFID4+lScS4RGCvM8hUIdFtdoervhBgqx5iuW7cMK0WxRTmL2gFi
igkR3JLQEv6aeoYR9HHkC/+GqIYbp5WdnNYi0CL9yl8nN0UCvQg+Mys+Yf2l+vYg
pV3sNYMBnaoQngpEh4YyBUM6kotdM/0g9mynySBv0HdwBwLc+f5hVoWmQsbWOsK6
tq2E4YBUgMi5h9LgDLBMruLt3Li/Yv4CAcAknG416Rx++nQojA6MBd0BFc77wyl9
dnywU/b94kMgwOJG5PwKec6cdWxKfr+UUchgiNE8oxM9+Ji00/z6iKfozLrlZQgE
TO9w1/fJ6IEfzIJLB3Rb1VJvJ9CAMgY8YtKeeBXjKXZVdixYUzZ5WDNTklVYZ8dP
ndvdKSwu4px+FbEx0gnjU7Kp+mNvajbIjEB1UBwhvofZ0cFvkGY=
=rLq5
-----END PGP SIGNATURE-----

--Apple-Mail=_7695B517-E849-4056-8C4F-4E1046941E30--
