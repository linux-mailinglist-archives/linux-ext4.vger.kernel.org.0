Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBD309451
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Jan 2021 11:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhA3KUH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Jan 2021 05:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhA3KT6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Jan 2021 05:19:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A33C061573
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 02:19:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h15so6891065pli.8
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 02:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=FptO0HupPYAkjRR0LO1v8QKMb9VNKKFxglsOoMOBQHw=;
        b=SPMCvG/m++u+Rko6VIvJD/o31c+Rnq4uAcmSvXBtIjIy3rtd1nBmWkDuVYJllA8NK4
         MeNrSJPkiQdX/9leAJ5BxZTYZPiXyeQELIVDqQ4Zu44/hwFbS9xW2nlmTTtK58szpk5U
         7YWN+Wfh3BZqjBqE2mtBlMmjTXhVVLT50MMrbzY1BtcwwzgwPHvEGwEd1mWaNfru9n5A
         tsf3HALz7hnf/uDOg0nZYF/ZxLMFmRClF0KrvPTlwd8/1MEiOCFv56pGIh2dx0u1Pfq/
         StF3aS6pTsRX0VrK91vYrzOU906R6jRl0pkUgfNhLG5FIeRdfSK3qNet+2fsOmqKaoej
         kAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=FptO0HupPYAkjRR0LO1v8QKMb9VNKKFxglsOoMOBQHw=;
        b=sXDxIwn20NJb6Gub2QrFpZr50NEJWqtBXjV+1KeQvwWrIyhcGh8/SV0Oe/Hsiu7v9k
         i58IOd1nmAE69K6OOwdO7oXyAmFJ6l3vceNM62GisgtWoBgpNTjlggREovMFSngGbJKf
         5EAkC/IarhATXuYmTNTmz+WJenMpY8lsXycyOXkPZrdwO8M9TfL29/tIWpTXbGi36C1l
         WuTf8L6yhvhYm7Co4vAEdO3qYc+wp/LGSyTmFwiv88b10/RS1LkU2P6Zvp9Gt5bj5lxN
         IKSM5RuK5HFodg7fWmqIdK95wHv+JnrAbQJjlBLAT1iovblxr5mE2vraeGc2skDuztvi
         6cBg==
X-Gm-Message-State: AOAM530bW6BSmG6yHdpd0ov6NoE3jXn/4+GQX76gTp78Az+4XsK4k0kd
        WyracdkkXo7iQJ/Y9raWceIezw==
X-Google-Smtp-Source: ABdhPJzrS6+6Wb/O5GMZyfQ/4Q8EbYHAXKZNfHqybhoFJVVS5MsxuA7nK08xXsfj8oaGpVNfJtNBVQ==
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr8619681pja.228.1612001955784;
        Sat, 30 Jan 2021 02:19:15 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x81sm11879563pfc.46.2021.01.30.02.19.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jan 2021 02:19:15 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8D9E6541-296F-48ED-A1E1-B6E17C08448B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_716D2D85-C50F-49BD-BF32-F283BCA7B7E8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/4] ext4: improve cr 0 / cr 1 group scanning
Date:   Sat, 30 Jan 2021 03:19:12 -0700
In-Reply-To: <20210129222931.623008-4-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
 <20210129222931.623008-4-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_716D2D85-C50F-49BD-BF32-F283BCA7B7E8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 29, 2021, at 3:29 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Instead of traversing through groups linearly,

For linear IO writes to a file, before checking any of the lists,
it makes sense to still check the current and next group to see
if they have free extents of the proper size?  That would preserve
linearity of writes to a file in the common few-threads-writing case.

That would reduce contention on the list locks (as you mention later)
compared to *every* thread checking the list each time, as well as
improve the sequential allocation for files.  The cr0/cr1 list/tree
would only be used for finding a new allocation group if the current
and next groups fail.

> scan groups in specific
> orders at cr 0 and cr 1. At cr 0, we want to find groups that have the
> largest free order >=3D the order of the request. So, with this patch,
> we maintain all the ext4_group_info structs in lists for each possible
> order.

This would be more clear like (if I'm describing this correctly):

   we maintain lists for each possible order and insert each group
   into a list based on the largest free order in its buddy bitmap.

> During cr 0 allocation, we traverse these lists in the
> increasing order of largest free orders. This allows us to find a
> group with the best available cr 0 match in constant time. If nothing
> can be found, we fallback to cr 1 immediately.

Just to clarify, if allocating, say, an 8MB extent, this would jump
straight to the 8MB group list to look for groups that have free
extents in their 8MB buddy bitmap, and if that list is empty it will
go to the 16MB list to look for a group, repeat as necessary until an
extent is found (and split) or there are no larger extents and the
cr0 pass is finished?

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

Did you look at separate locks for each order of the cr0 list to
reduce contention?  It might be possible to opportunistically avoid
locking any of the list heads when *checking* if the list is empty
or not. I don't think there are serious issues with races if the
list is already empty.

Having multiple list locks is fine if there is a specific locking
order (larger to smaller) when multiple locks are taken.  If there
is a group with the correct order it only needs a single list lock,
and if a higher order group is needed (requiring the extent to be
split) then the next lower list would be locked to insert the group,
which can be taken without dropping the higher-order list lock.

When inserting groups back into the list, assuming that each thread
will stick with the same group for some number of allocations (rather
than having to re-lookup the same group each time), does it make more
sense to put the group at the *end* of the list so that the next
thread doing a lookup will find a different group than another thread
was just allocating from?

Is there any particular requirement why the rb lock and the list
lock(s) need to be the same lock?  I'd imagine that they do not,
since a thread will be using either one list or the other.  Making
these separate locks and reducing the lock hold time would allow
more threads to be doing useful work instead of spinning.

Cheers, Andreas

> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
> fs/ext4/ext4.h    |   6 ++
> fs/ext4/mballoc.c | 223 ++++++++++++++++++++++++++++++++++++++++++++--
> fs/ext4/mballoc.h |   1 +
> 3 files changed, 222 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 6dd127942208..da12a083bf52 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1527,6 +1527,9 @@ struct ext4_sb_info {
> 	unsigned int s_mb_free_pending;
> 	struct list_head s_freed_data_list;	/* List of blocks to be =
freed
> 						   after commit =
completed */
> +	struct rb_root s_mb_avg_fragment_size_root;
> +	struct list_head *s_mb_largest_free_orders;
> +	rwlock_t s_mb_rb_lock;
>=20
> 	/* tunables */
> 	unsigned long s_stripe;
> @@ -3304,11 +3307,14 @@ struct ext4_group_info {
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
> index 11c56b0e6f35..413259477b03 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -744,6 +744,193 @@ static void ext4_mb_mark_free_simple(struct =
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
> + * Reinsert grpinfo into the avg_fragment_size tree and into the =
appropriate
> + * largest_free_order list.
> + */
> +static void
> +ext4_mb_reinsert_grpinfo(struct super_block *sb, struct =
ext4_group_info *grp)
> +{
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
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
> +
> +	list_del_init(&grp->bb_largest_free_order_node);
> +	if (grp->bb_largest_free_order >=3D 0)
> +		list_add(&grp->bb_largest_free_order_node,
> +			 =
&sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
> +	write_unlock(&sbi->s_mb_rb_lock);
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
> +	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> +	int avg_fragment_size, best_so_far, i;
> +	struct rb_node *node, *found;
> +	struct ext4_group_info *grp;
> +
> +	*new_cr =3D ac->ac_criteria;
> +	if (*new_cr >=3D 2 ||
> +	    !ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> +		goto inc_and_return;
> +
> +	/*
> +	 * If there is contention on the lock, instead of waiting for =
the lock
> +	 * to become available, just continue searching lineraly.
> +	 */
> +	if (!read_trylock(&sbi->s_mb_rb_lock))
> +		goto inc_and_return;
> +
> +	if (*new_cr =3D=3D 0) {
> +		grp =3D NULL;
> +
> +		if (ac->ac_status =3D=3D AC_STATUS_FOUND)
> +			goto inc_and_return;
> +
> +		for (i =3D ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); =
i++) {
> +			if =
(list_empty(&sbi->s_mb_largest_free_orders[i]))
> +				continue;
> +			grp =3D =
list_first_entry(&sbi->s_mb_largest_free_orders[i],
> +					       struct ext4_group_info,
> +					       =
bb_largest_free_order_node);
> +			break;
> +		}
> +
> +		if (grp) {
> +			*group =3D grp->bb_group;
> +			goto done;
> +		}
> +		/* Increment cr and search again */
> +		*new_cr =3D 1;
> +	}
> +
> +	/*
> +	 * At CR 1, if enough groups are not loaded, we just fallback to
> +	 * linear search
> +	 */
> +	if (atomic_read(&sbi->s_mb_buddies_generated) <
> +	    ext4_get_groups_count(ac->ac_sb)) {
> +		read_unlock(&sbi->s_mb_rb_lock);
> +		goto inc_and_return;
> +	}
> +
> +	if (*new_cr =3D=3D 1) {
> +		if (ac->ac_f_ex.fe_len > 0) {
> +			/* We have found something at CR 1 in the past =
*/
> +			grp =3D ext4_get_group_info(ac->ac_sb, =
ac->ac_last_optimal_group);
> +			found =3D =
rb_next(&grp->bb_avg_fragment_size_rb);
> +			if (found) {
> +				grp =3D rb_entry(found, struct =
ext4_group_info,
> +					       bb_avg_fragment_size_rb);
> +				*group =3D grp->bb_group;
> +			} else {
> +				*new_cr =3D 2;
> +			}
> +			goto done;
> +		}
> +
> +		/* This is the first time we are searching in the tree =
*/
> +		node =3D sbi->s_mb_avg_fragment_size_root.rb_node;
> +		best_so_far =3D 0;
> +		found =3D NULL;
> +
> +		while (node) {
> +			grp =3D rb_entry(node, struct ext4_group_info,
> +				bb_avg_fragment_size_rb);
> +			avg_fragment_size =3D grp->bb_fragments ?
> +				grp->bb_free / grp->bb_fragments : 0;
> +			if (avg_fragment_size > ac->ac_g_ex.fe_len) {
> +				if (!best_so_far || avg_fragment_size < =
best_so_far) {
> +					best_so_far =3D =
avg_fragment_size;
> +					found =3D node;
> +				}
> +			}
> +			if (avg_fragment_size > ac->ac_g_ex.fe_len)
> +				node =3D node->rb_right;
> +			else
> +				node =3D node->rb_left;
> +		}
> +		if (found) {
> +			grp =3D rb_entry(found, struct ext4_group_info,
> +				bb_avg_fragment_size_rb);
> +			*group =3D grp->bb_group;
> +		} else {
> +			*new_cr =3D 2;
> +		}
> +	}
> +done:
> +	read_unlock(&sbi->s_mb_rb_lock);
> +	ac->ac_last_optimal_group =3D *group;
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
> @@ -818,6 +1005,7 @@ void ext4_mb_generate_buddy(struct super_block =
*sb,
> 	period =3D get_cycles() - period;
> 	atomic_inc(&sbi->s_mb_buddies_generated);
> 	atomic64_add(period, &sbi->s_mb_generation_time);
> +	ext4_mb_reinsert_grpinfo(sb, grp);
> }
>=20
> /* The buddy information is attached the buddy cache inode
> @@ -1517,6 +1705,7 @@ static void mb_free_blocks(struct inode *inode, =
struct ext4_buddy *e4b,
>=20
> done:
> 	mb_set_largest_free_order(sb, e4b->bd_info);
> +	ext4_mb_reinsert_grpinfo(sb, e4b->bd_info);
> 	mb_check_buddy(e4b);
> }
>=20
> @@ -1653,6 +1842,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, =
struct ext4_free_extent *ex)
> 	}
> 	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
>=20
> +	ext4_mb_reinsert_grpinfo(e4b->bd_sb, e4b->bd_info);
> 	ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
> 	mb_check_buddy(e4b);
>=20
> @@ -2345,17 +2535,20 @@ ext4_mb_regular_allocator(struct =
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
> @@ -2650,7 +2843,10 @@ int ext4_mb_add_groupinfo(struct super_block =
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
> @@ -2840,6 +3036,15 @@ int ext4_mb_init(struct super_block *sb)
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
> +	for (i =3D 0; i < MB_NUM_ORDERS(sb); i++)
> +		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
> +	rwlock_init(&sbi->s_mb_rb_lock);
>=20
> 	spin_lock_init(&sbi->s_md_lock);
> 	sbi->s_mb_free_pending =3D 0;
> @@ -2903,6 +3108,7 @@ int ext4_mb_init(struct super_block *sb)
> 	free_percpu(sbi->s_locality_groups);
> 	sbi->s_locality_groups =3D NULL;
> out:
> +	kfree(sbi->s_mb_largest_free_orders);
> 	kfree(sbi->s_mb_offsets);
> 	sbi->s_mb_offsets =3D NULL;
> 	kfree(sbi->s_mb_maxs);
> @@ -2959,6 +3165,7 @@ int ext4_mb_release(struct super_block *sb)
> 		kvfree(group_info);
> 		rcu_read_unlock();
> 	}
> +	kfree(sbi->s_mb_largest_free_orders);
> 	kfree(sbi->s_mb_offsets);
> 	kfree(sbi->s_mb_maxs);
> 	iput(sbi->s_buddy_cache);
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 68111a10cfee..57b44c7320b2 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -166,6 +166,7 @@ struct ext4_allocation_context {
> 	/* copy of the best found extent taken before preallocation =
efforts */
> 	struct ext4_free_extent ac_f_ex;
>=20
> +	ext4_group_t ac_last_optimal_group;
> 	__u16 ac_groups_scanned;
> 	__u16 ac_found;
> 	__u16 ac_tail;
> --
> 2.30.0.365.g02bc693789-goog
>=20


Cheers, Andreas






--Apple-Mail=_716D2D85-C50F-49BD-BF32-F283BCA7B7E8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAVMqEACgkQcqXauRfM
H+AnOA/9EQHQKIIvGJNBa7f7rx+sOfGVWd3eZU4fD6d2d3uP2MD0YwlW4rkMyREl
BLwudIxTrhZd/pzVSh7L74aDtOePtaaKWroCKzguFU+wmHej3krFXB5S7sdW62We
mUJ3MrTxXnAFFOwiET/MNit0tekv8wGGHMNzrdyftkf1L0yNmTf3JSXl9WmyGhhb
aVB/l/7tkUKeUHcA5z80FRNnVVCUZObr6NrEkJZnpZFaust4ICAsrWzUULewlN6W
jCmFS1LsmewL0q/LVUXHEwP2RNgO53zGjznFaGGbUw9BdIUfheBM5FYqMlPc0HiY
x+Iqz4d2QA8eNVSc585zVmttpR/5ISKgpL+KMGMUDp9pv08KjUZrZI8iXqRPQSix
2dKlHXQQcsKvo1ukrjJxPksbQUqeRlxNGW4kBdVS3GYI3Wdp+VwWih7mwM/ss6HA
Idl+9bcvbOSFRaOHzDzqwIAUDIxkJSdbBQ5meis85QqQY6u4482KoEMpUNOTl4q3
Ja1jm7CtfIlLcV5tfqtlPBsMJQL1EOft+EXOCo1xBUlbAROXDO+oiXf1wcDqK1gm
yeEcocK7sOlyWNCwEwirY8Z2S8PlJM/ValcrIgzCH21CZk2Q0zfIoudBTFzagqSa
JCFgEEX2RtqHuhKlG6TWPH5EokslOL4qEZ4/WPPSGUN6cE+IRY8=
=2063
-----END PGP SIGNATURE-----

--Apple-Mail=_716D2D85-C50F-49BD-BF32-F283BCA7B7E8--
