Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857E631A813
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 23:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhBLWvz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 17:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhBLWrI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Feb 2021 17:47:08 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71625C0613D6
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 14:46:27 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e9so602979plh.3
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 14:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=NGCr8onrCTp3J43AJYJ0sm6+PCMxw855p6oC6S9pkv4=;
        b=gcW/IY5CTbeuqOVr2b/VU16FoOwoM7PuCB6GddElmufDKKE/B0dmhRhZrdnCtRw2l1
         Xqfz0EIU0qxXQhfHaD+11CopiJsi0Rw7oSoey8L9OcJpkjU1VBo0xrBiya65Xz5WEsjR
         AUwiB9yLO5UsZwnTdsxhdn7M/FSnWpnQSbsA//s4lCqT47Lh34Mp3QlxAxWX41B6OD+B
         TTesEcATOk4UG8SiU7kafPYgu6Vo8YXuiVzCiom5dHzYBFYL7SY0RlmF61MvdyE1wnu1
         mFF9P/Pge3jxJEkc6BaT7+sE2pmK63AkwVThs3DSTdSzyQvlMUQX0yKBznHjnEHXMiR6
         l0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=NGCr8onrCTp3J43AJYJ0sm6+PCMxw855p6oC6S9pkv4=;
        b=BeiE7feYGx4agLT6uShGBU64GvMxqy6vRXPivCZhQ+nQ8QL1ziy9hMVoUYEkaupstP
         TlaCIVvQXIiBdSJQhAhV0z7ace3G5vThLLfu/+1uIfyHJNzIAmetA1KcAQxvkBLLl0hx
         C3WpsDMgckOKNlL7Ceu7RuN8RpCQ9L7tGl4X1DJFgP66CW/tNye7xAG/nXGSrwgNMteq
         hlXjVALD65ljzXgaCYf9CoApJoMgg0Eb2AiUERgOX2GKd5uO6925568okeRPKV1+hTIr
         g24nbbALZzOFMeSX3Advgi2ZlgleoMjspRxmz3tBGCxcEfEH4bGswjk85qqRfhyJDWua
         ggSw==
X-Gm-Message-State: AOAM531Fb6BOCVWb2wClXTozQnyInUXak7XkZpt6GBylyniqvlRLjtCp
        LyocSQlnOL2oic8dn0vp4kr27g==
X-Google-Smtp-Source: ABdhPJwlrV8+iP+9LVKcHJVP4dXIQo3QfAZtTX0R4cxE2bQk6iMfLaJn3qtcMDIyiJ4EgeDitJkIbA==
X-Received: by 2002:a17:90b:23d4:: with SMTP id md20mr4566552pjb.220.1613169986650;
        Fri, 12 Feb 2021 14:46:26 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a78sm10458190pfa.10.2021.02.12.14.46.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 14:46:25 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FB8E02F2-2602-4758-B39C-E1E28D3B8E9A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0FFA65C1-2C9B-49B4-B482-02887FDDC9EC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 4/5] ext4: improve cr 0 / cr 1 group scanning
Date:   Fri, 12 Feb 2021 15:46:24 -0700
In-Reply-To: <20210209202857.4185846-5-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        artem.blagodarenko@gmail.com, Shuichi Ihara <sihara@ddn.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-5-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0FFA65C1-2C9B-49B4-B482-02887FDDC9EC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 9, 2021, at 1:28 PM, Harshad Shirwadkar =
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

Harshad, if you are going to refresh this patch, I would recommend to
include all or most of what you write in the commit message into the
below comment at the start of mballoc.c, possibly with some editing in
the expectation that "mb_optimized_scan" will become the default so
that the description of the list/rbtree for cr0/cr1 is mentioned first,
and the sequential group scanning is mentioned afterward.

Otherwise, the existing comment only mentions "groups are traversed in
an optimal order" which doesn't really explain much useful to the =
reader.

Cheers, Andreas

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
> --
> 2.30.0.478.g8a0d178c01-goog
>=20


Cheers, Andreas






--Apple-Mail=_0FFA65C1-2C9B-49B4-B482-02887FDDC9EC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAnBUAACgkQcqXauRfM
H+D1bBAAhPMs7p7A//Rxjq9O65p5hCXADm6ma669RB4apfcmwP5GYnKEZMOKhuSx
9LoyIT+8tVuvwzYVvOGTtfz+ZQqW/78uz1+LHBDCJUtc4NbUwL7wjEz3/Uv5wmap
rb2GPSy2exx3icFZqzlKSvO4CVOodoxzAYRk1+3hsqRd3U1jChTKoELheeYb0mJi
xqQMgcqACAiyw5nKDI0URMklRCF1c9hrkgLrvIKQZdwtsp7pz3yPhpzjZb6mUene
y9jYtkFh/OPmip3m3KR8nUI3VjSi9EU4UqMYwqhFrBraA/aHFetH81l3xnjxWI6g
gk/aMvCJt+Wk6DOVJujskSr2yF/M10g6lPw0hGskYWfNNLDBIAK5HN9BnyexfsUt
fmXlP7nakV+aMafr+uvogGBU9CWgltcXly9hhfpOa4dPPFAQ/iyNooR59oBXakqE
skiVnwVjLqp83xrVLZWX3FmvAEjuoIOg1QfsD3oIQ/D/+W7n35eeIzvcfXGRPngK
gOi/k+EhzVKSOrWoyhfj3B+aZ37kswmbmOj/oMTf4TjHp24kCD4SlXZcFxLGydgs
RrXcXjIK+mkYZGmxxt2Y5MD+HbneerPeezc6H4ysPnCFZRF/Y6KrVz3hu4lEbMZ7
7JO5bMG/zZTg9i7SM6fjs506SI7Lud/YkqFEHMBJJ2SH1rsI5u0=
=wBpZ
-----END PGP SIGNATURE-----

--Apple-Mail=_0FFA65C1-2C9B-49B4-B482-02887FDDC9EC--
