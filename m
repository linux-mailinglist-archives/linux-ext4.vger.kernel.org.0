Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86E631DFC7
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Feb 2021 20:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhBQTmq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Feb 2021 14:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhBQTmo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Feb 2021 14:42:44 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801FFC061574
        for <linux-ext4@vger.kernel.org>; Wed, 17 Feb 2021 11:42:03 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z11so23578231lfb.9
        for <linux-ext4@vger.kernel.org>; Wed, 17 Feb 2021 11:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X1ZgQol+zkCX5sC/QHM7iEpFx2w45aC/x2aBEDoHhx8=;
        b=VmZlIkQdiAYk5lE18hTn4yRlMr13MiKHJQa5IYJ0wVr854tbYZKvQiNfryhIh4NpM0
         Jb78BlOFJj0SodXBCXQVwU8BXaZCFlGAeTksscoUFmHbglAoiZ2UrwzYR8bgAnfrh4NM
         430eU6TW+/ysgGHFhWkGoGtyUQcUCF1pqQvmzrs9TnX3R1e0mDfxCEXJvT5t/05Vot5g
         WkLq5WfJXAukGij6YV2MyBg0yqlOSXMO9UsL542iORIfcjF2//C519rRM/2XLvVXj3wu
         oi6QZNbIZf47jvkP+DYsjgE3FK9PZnYh0YVdDoHJhxRwIQvMgrH+RTH4MAVM94CMBa+o
         9wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X1ZgQol+zkCX5sC/QHM7iEpFx2w45aC/x2aBEDoHhx8=;
        b=QXgyp0ypVFwokoyO42qVJPvVHuYw8Xps7oVU4p7TerU6nX2U30aSK15Cu5BfNL6ZC5
         vo5SugTjMDKADzBuqa46H/Ld729/QfBDhmaaujPEmUfDBbvXqKSGSvoUc0eDLiH1hLlw
         X8xxQK2E+/qiW1Sajlj416+zAMfQyU2DPjrfTb3ZOSYoK2Iq1x3aGixv1g5Ieejf9nJz
         MpJVkt8MbTvtjIGNMXQlCXF/6br60QPubWFYJN/Th5VVfhTsKzQfOyKUxDUOPeHidMVm
         WALqZ959GwC83QOfkp9NOwkij9CpT6OJNKJU/XWigZsVk6y2T/Fa9Ydp9CRToGsWAp64
         G9vg==
X-Gm-Message-State: AOAM532u0ipJsi7p/gg3jpuGDQYPwhPIpWGMd81lHW9LCzq5LCVd9Fz5
        H6FYBcue0E1UhBI/P32Z7mYuSzqFhoMZngWM
X-Google-Smtp-Source: ABdhPJx8v2bMSpjt2HH8Sy1/1JFRkTlqcFGzDkzsxhijvUhFuQmt1zNOqxr6md4RtxDmwEZJVPuPcg==
X-Received: by 2002:a19:4005:: with SMTP id n5mr293068lfa.336.1613590921543;
        Wed, 17 Feb 2021 11:42:01 -0800 (PST)
Received: from [192.168.2.192] ([62.33.36.35])
        by smtp.gmail.com with ESMTPSA id v25sm342193ljc.92.2021.02.17.11.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 11:42:00 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH v2 4/5] ext4: improve cr 0 / cr 1 group scanning
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20210209202857.4185846-5-harshadshirwadkar@gmail.com>
Date:   Wed, 17 Feb 2021 22:41:58 +0300
Cc:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        bzzz@whamcloud.com, sihara@ddn.com,
        Andreas Dilger <adilger@dilger.ca>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B83BCF8-953A-4000-AB5C-2A9F95B408C8@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-5-harshadshirwadkar@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Harshad,

Simple test with empty filesystem.

[root@CO82 linux]# dd if=3D/dev/zero of=3D/mnt/foomount/foofile bs=3D2M =
count=3D2 conv=3Dfsync
2+0 records in
2+0 records out
4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.0406173 s, 103 MB/s

Let=E2=80=99s output structures=20

[root@CO82 linux]# cat /proc/fs/ext4/loop0/mb_structs_summary
Largest Free Order Lists:
Order 0 list: 0 Groups
Order 1 list: 0 Groups
Order 2 list: 0 Groups
Order 3 list: 0 Groups
Order 4 list: 0 Groups
Order 5 list: 0 Groups
Order 6 list: 0 Groups
Order 7 list: 0 Groups
Order 8 list: 0 Groups
Order 9 list: 0 Groups
Order 10 list: 0 Groups
Order 11 list: 0 Groups
Order 12 list: 0 Groups
Order 13 list: 1 Groups
Tree
Min: 31620, Max: 31620, Num Nodes: 1
[root@CO82 linux]#

There is information only about one group 13. I suppose because it was =
accessed.
So this lists are not filled initially, but only when a group is =
accessed. Is this expected?

Here is information about  free orders of all groups that captured from =
mb_groups

[root@CO82 linux]# cat /proc/fs/ext4/loop0/mb_groups
#group: free frags first [ 2^0 2^1 2^2 2^3 2^4 2^5 2^6 2^7 2^8 2^9 2^10 =
2^11 2^12 2^13 ]
#0 : 28710 1 4058 [ 0 1 1 0 0 1 0 0 0 0 0 0 1 3 ]
#1 : 31620 1 1148 [ 0 0 1 0 0 0 0 1 1 1 0 1 1 3 ]
#2 : 28672 1 4096 [ 0 0 0 0 0 0 0 0 0 0 0 0 1 3 ]
#3 : 32644 1 124 [ 0 0 1 0 0 0 0 1 1 1 1 1 1 3 ]
#4 : 32768 1 0 [ 0 0 0 0 0 0 0 0 0 0 0 0 0 4 ]
#5 : 32644 1 124 [ 0 0 1 0 0 0 0 1 1 1 1 1 1 3 ]
#6 : 32768 1 0 [ 0 0 0 0 0 0 0 0 0 0 0 0 0 4 ]
#7 : 20500 1 124 [ 0 0 1 0 1 0 0 2 1 1 1 1 2 1 ]

There are a lot of different free ranges on this filesystem.

Best regards,
Artem Blagodarenko.


> On 9 Feb 2021, at 23:28, Harshad Shirwadkar =
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
>=20
> There is an opportunity to do optimization at CR2 too. That's because
> at CR2 we only consider groups where bb_free counter (number of free
> blocks) is greater than the request extent size. That's left as future
> work.
>=20
> All the changes introduced in this patch are protected under a new
> mount option "mb_optimize_scan".
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
> fs/ext4/ext4.h    |  13 +-
> fs/ext4/mballoc.c | 316 ++++++++++++++++++++++++++++++++++++++++++++--
> fs/ext4/mballoc.h |   1 +
> fs/ext4/super.c   |   6 +-
> 4 files changed, 322 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 317b43420ecf..0601c997c87f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -162,6 +162,8 @@ enum SHIFT_DIRECTION {
> #define EXT4_MB_USE_RESERVED		0x2000
> /* Do strict check for free blocks while retrying block allocation */
> #define EXT4_MB_STRICT_CHECK		0x4000
> +/* Avg fragment size rb tree lookup succeeded at least once for cr =3D =
1 */
> +#define EXT4_MB_CR1_OPTIMIZED		0x8000
>=20
> struct ext4_allocation_request {
> 	/* target inode for block we're allocating */
> @@ -1247,7 +1249,9 @@ struct ext4_inode_info {
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
> @@ -1527,6 +1531,10 @@ struct ext4_sb_info {
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
> @@ -3308,11 +3316,14 @@ struct ext4_group_info {
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
> index b7f25120547d..63562f5f42f1 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -147,7 +147,12 @@
>  * the group specified as the goal value in allocation context via
>  * ac_g_ex. Each group is first checked based on the criteria whether =
it
>  * can be used for allocation. ext4_mb_good_group explains how the =
groups are
> - * checked.
> + * checked. If "mb_optimize_scan" mount option is set, instead of =
traversing
> + * groups linearly starting at the goal, the groups are traversed in =
an optimal
> + * order according to each cr level, so as to minimize considering =
groups which
> + * would anyway be rejected by ext4_mb_good_group. This has a side =
effect
> + * though - subsequent allocations may not be close to each other. =
And so,
> + * the underlying device may get filled up in a non-linear fashion.
>  *
>  * Both the prealloc space are getting populated as above. So for the =
first
>  * request we will hit the buddy cache which will result in this =
prealloc
> @@ -299,6 +304,8 @@
>  *  - bitlock on a group	(group)
>  *  - object (inode/locality)	(object)
>  *  - per-pa lock		(pa)
> + *  - cr0 lists lock		(cr0)
> + *  - cr1 tree lock		(cr1)
>  *
>  * Paths:
>  *  - new pa
> @@ -328,6 +335,9 @@
>  *    group
>  *        object
>  *
> + *  - allocation path (ext4_mb_regular_allocator)
> + *    group
> + *    cr0/cr1
>  */
> static struct kmem_cache *ext4_pspace_cachep;
> static struct kmem_cache *ext4_ac_cachep;
> @@ -351,6 +361,9 @@ static void ext4_mb_generate_from_freelist(struct =
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
> @@ -744,6 +757,243 @@ static void ext4_mb_mark_free_simple(struct =
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
> +		if (cmp(new, *iter))
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
> +	return (num_frags_1 < num_frags_2);
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
> +	if (!test_opt2(sb, MB_OPTIMIZE_SCAN))
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
> +			/*
> +			 * Perform this check without a lock, once we =
lock
> +			 * the group, we'll perform this check again.
> +			 */
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
> +	if (ac->ac_flags & EXT4_MB_CR1_OPTIMIZED) {
> +		/* We have found something at CR 1 in the past */
> +		grp =3D ext4_get_group_info(ac->ac_sb, =
ac->ac_last_optimal_group);
> +		for (found =3D rb_next(&grp->bb_avg_fragment_size_rb); =
found !=3D NULL;
> +		     found =3D rb_next(found)) {
> +			grp =3D rb_entry(found, struct ext4_group_info,
> +				       bb_avg_fragment_size_rb);
> +			/*
> +			 * Perform this check without locking, we'll =
lock later
> +			 * to confirm.
> +			 */
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
group available
> + *            at current CR level, this field is updated to indicate =
the new cr
> + *            level that should be used.
> + * @group     This is an input / output parameter. As an input it =
indicates the last
> + *            group used for allocation. As output, this field =
indicates the
> + *            next group that should be used.
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
> @@ -751,18 +1001,32 @@ static void ext4_mb_mark_free_simple(struct =
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
> +	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && =
grp->bb_largest_free_order >=3D 0) {
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
> @@ -818,6 +1082,7 @@ void ext4_mb_generate_buddy(struct super_block =
*sb,
> 	period =3D get_cycles() - period;
> 	atomic_inc(&sbi->s_mb_buddies_generated);
> 	atomic64_add(period, &sbi->s_mb_generation_time);
> +	mb_update_avg_fragment_size(sb, grp);
> }
>=20
> /* The buddy information is attached the buddy cache inode
> @@ -1517,6 +1782,7 @@ static void mb_free_blocks(struct inode *inode, =
struct ext4_buddy *e4b,
>=20
> done:
> 	mb_set_largest_free_order(sb, e4b->bd_info);
> +	mb_update_avg_fragment_size(sb, e4b->bd_info);
> 	mb_check_buddy(e4b);
> }
>=20
> @@ -1653,6 +1919,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, =
struct ext4_free_extent *ex)
> 	}
> 	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
>=20
> +	mb_update_avg_fragment_size(e4b->bd_sb, e4b->bd_info);
> 	ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
> 	mb_check_buddy(e4b);
>=20
> @@ -2346,17 +2613,20 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 		 * from the goal value specified
> 		 */
> 		group =3D ac->ac_g_ex.fe_group;
> +		ac->ac_last_optimal_group =3D group;
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
> @@ -2696,7 +2966,10 @@ int ext4_mb_add_groupinfo(struct super_block =
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
> @@ -2886,6 +3159,22 @@ int ext4_mb_init(struct super_block *sb)
> 		i++;
> 	} while (i < MB_NUM_ORDERS(sb));
>=20
> +	sbi->s_mb_avg_fragment_size_root =3D RB_ROOT;
> +	sbi->s_mb_largest_free_orders =3D
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct =
list_head),
> +			GFP_KERNEL);
> +	if (!sbi->s_mb_largest_free_orders)
> +		goto out;
> +	sbi->s_mb_largest_free_orders_locks =3D
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
> +			GFP_KERNEL);
> +	if (!sbi->s_mb_largest_free_orders_locks)
> +		goto out;
> +	for (i =3D 0; i < MB_NUM_ORDERS(sb); i++) {
> +		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
> +		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
> +	}
> +	rwlock_init(&sbi->s_mb_rb_lock);
>=20
> 	spin_lock_init(&sbi->s_md_lock);
> 	sbi->s_mb_free_pending =3D 0;
> @@ -2949,6 +3238,8 @@ int ext4_mb_init(struct super_block *sb)
> 	free_percpu(sbi->s_locality_groups);
> 	sbi->s_locality_groups =3D NULL;
> out:
> +	kfree(sbi->s_mb_largest_free_orders);
> +	kfree(sbi->s_mb_largest_free_orders_locks);
> 	kfree(sbi->s_mb_offsets);
> 	sbi->s_mb_offsets =3D NULL;
> 	kfree(sbi->s_mb_maxs);
> @@ -3005,6 +3296,7 @@ int ext4_mb_release(struct super_block *sb)
> 		kvfree(group_info);
> 		rcu_read_unlock();
> 	}
> +	kfree(sbi->s_mb_largest_free_orders);
> 	kfree(sbi->s_mb_offsets);
> 	kfree(sbi->s_mb_maxs);
> 	iput(sbi->s_buddy_cache);
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 02861406932f..1e86a8a0460d 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -166,6 +166,7 @@ struct ext4_allocation_context {
> 	/* copy of the best found extent taken before preallocation =
efforts */
> 	struct ext4_free_extent ac_f_ex;
>=20
> +	ext4_group_t ac_last_optimal_group;
> 	__u32 ac_groups_considered;
> 	__u16 ac_groups_scanned;
> 	__u16 ac_found;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0f0db49031dc..a14363654cfd 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -154,6 +154,7 @@ static inline void __ext4_read_bh(struct =
buffer_head *bh, int op_flags,
> 	clear_buffer_verified(bh);
>=20
> 	bh->b_end_io =3D end_io ? end_io : end_buffer_read_sync;
> +
> 	get_bh(bh);
> 	submit_bh(REQ_OP_READ, op_flags, bh);
> }
> @@ -1687,7 +1688,7 @@ enum {
> 	Opt_dioread_nolock, Opt_dioread_lock,
> 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> -	Opt_prefetch_block_bitmaps,
> +	Opt_prefetch_block_bitmaps, Opt_mb_optimize_scan,
> #ifdef CONFIG_EXT4_DEBUG
> 	Opt_fc_debug_max_replay, Opt_fc_debug_force
> #endif
> @@ -1788,6 +1789,7 @@ static const match_table_t tokens =3D {
> 	{Opt_nombcache, "nombcache"},
> 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
> 	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
> +	{Opt_mb_optimize_scan, "mb_optimize_scan"},
> 	{Opt_removed, "check=3Dnone"},	/* mount option from ext2/3 */
> 	{Opt_removed, "nocheck"},	/* mount option from ext2/3 */
> 	{Opt_removed, "reservation"},	/* mount option from ext2/3 */
> @@ -2008,6 +2010,8 @@ static const struct mount_opts {
> 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
> 	 MOPT_SET},
> +	{Opt_mb_optimize_scan, EXT4_MOUNT2_MB_OPTIMIZE_SCAN,
> +	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
> #ifdef CONFIG_EXT4_DEBUG
> 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
> 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
> --=20
> 2.30.0.478.g8a0d178c01-goog
>=20

