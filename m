Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B33309893
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Jan 2021 23:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhA3WLE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Jan 2021 17:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3WLB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Jan 2021 17:11:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AB0C061573
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 14:10:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f1so14629299edr.12
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 14:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGz0prLqWPpJPATb321tq01Ok0ttZaH+L3Y6izdsqXQ=;
        b=Xrr3F83As7hKODxwWFearsBX+v5aynyuiJJF5QCHvjAhSJM2sPvX8dsko6lapesgPg
         LR/dcC+twHsqI164DeMkbvh8h8+CT3soWlhozlkkk7weJWcPTjHnnWe4WaZdgIA//Ni+
         ILlYOq+F7AhBtvEwgYvbLs7c6LPvIAuQUS3Ej1jlg5tFw1JWYAYhBJgoq3psFg93wTgz
         1oD/RNc66mpL1/QrSDn+sx0aoLqoB8ZB9jJrZzoeazV19jRF9vzvfA+JQLLWLFJ9T79F
         Qba4UU6oa2s5JLD8yDgai9ZsFoEUM1PYu9leitbCXqc+icENAfpPk+sQpiTCOi4pB1dY
         FCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGz0prLqWPpJPATb321tq01Ok0ttZaH+L3Y6izdsqXQ=;
        b=cyHJW21p+GIffaDe5ybbBYWsF5k7NRNUSM2fbbV/CgBK55lfQ/3S1h/yII29HOfxLs
         pDm8g0XtCspZd0Bo1o2hlrF47ya1MGMbV6oc+mNh3OG/cjb1DORMP3VPrpldJ0ZUSpXY
         Zm2sNOTAJAc8pYhx2c5q3TwQe7Meo2O5+f2JcnlzfaqZK/YBS/WL76+CxEgdS4d6dcZD
         VZueyaoLDFR6401zrF03SfdZ3YC2zVvvdGqq2a7O5fEc+2Wdw24rb6HrubWoMsN6jMCX
         3RTcc52qhzl4ovqPqgqUnZTKnHGzvtRPKOn05vJ9Z5KFxNeNMHgXlXcVzScBJTOGIWbf
         eEWQ==
X-Gm-Message-State: AOAM530SITz2DyK9pLIyhRD4MtWq8XKjHk2Ad88KqAYGpPE/BdSU1Ipb
        mDf4wmiQ4cUgdzD0ZkCRHgefNskG95Try3J0IR0=
X-Google-Smtp-Source: ABdhPJxKpbb1Jz0KxXzPvCM65qm4E6Jv6D/uHq1EsbBX7ddomrVvny3TyBkj2cFGx5N7B7l7SfGpRUoOmUHbHJf1VSw=
X-Received: by 2002:aa7:c58e:: with SMTP id g14mr3577821edq.362.1612044619474;
 Sat, 30 Jan 2021 14:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
 <20210129222931.623008-4-harshadshirwadkar@gmail.com> <8D9E6541-296F-48ED-A1E1-B6E17C08448B@dilger.ca>
In-Reply-To: <8D9E6541-296F-48ED-A1E1-B6E17C08448B@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sat, 30 Jan 2021 14:10:08 -0800
Message-ID: <CAD+ocbySnkthy9W6gVmHjiWFMse0ApWvsQzkU--KpwDaAPxw6g@mail.gmail.com>
Subject: Re: [PATCH 3/4] ext4: improve cr 0 / cr 1 group scanning
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jan 30, 2021 at 2:19 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Jan 29, 2021, at 3:29 PM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > Instead of traversing through groups linearly,
>
> For linear IO writes to a file, before checking any of the lists,
> it makes sense to still check the current and next group to see
> if they have free extents of the proper size?  That would preserve
> linearity of writes to a file in the common few-threads-writing case.
>
> That would reduce contention on the list locks (as you mention later)
> compared to *every* thread checking the list each time, as well as
> improve the sequential allocation for files.  The cr0/cr1 list/tree
> would only be used for finding a new allocation group if the current
> and next groups fail.
Yes, it would make sense to do that. But I think that logic should
reside outside of this code. And perhaps be combined with
ext4_mb_find_by_goal()? Keeping that logic out of this would keep this
code simple.
>
> > scan groups in specific
> > orders at cr 0 and cr 1. At cr 0, we want to find groups that have the
> > largest free order >= the order of the request. So, with this patch,
> > we maintain all the ext4_group_info structs in lists for each possible
> > order.
>
> This would be more clear like (if I'm describing this correctly):
>
>    we maintain lists for each possible order and insert each group
>    into a list based on the largest free order in its buddy bitmap.
Yes, that's much better, I'll incorporate this in the commit message
in the next version.
>
> > During cr 0 allocation, we traverse these lists in the
> > increasing order of largest free orders. This allows us to find a
> > group with the best available cr 0 match in constant time. If nothing
> > can be found, we fallback to cr 1 immediately.
>
> Just to clarify, if allocating, say, an 8MB extent, this would jump
> straight to the 8MB group list to look for groups that have free
> extents in their 8MB buddy bitmap, and if that list is empty it will
> go to the 16MB list to look for a group, repeat as necessary until an
> extent is found (and split) or there are no larger extents and the
> cr0 pass is finished?
Yes that's right.
>
> > At CR1, the story is slightly different. We want to traverse in the
> > order of increasing average fragment size. For CR1, we maintain a rb
> > tree of groupinfos which is sorted by average fragment size. Instead
> > of traversing linearly, at CR1, we traverse in the order of increasing
> > average fragment size, starting at the most optimal group. This brings
> > down cr 1 search complexity to log(num groups).
> >
> > For cr >= 2, we just perform the linear search as before. Also, in
> > case of lock contention, we intermittently fallback to linear search
> > even in CR 0 and CR 1 cases. This allows us to proceed during the
> > allocation path even in case of high contention.
>
> Did you look at separate locks for each order of the cr0 list to
> reduce contention?  It might be possible to opportunistically avoid
> locking any of the list heads when *checking* if the list is empty
> or not. I don't think there are serious issues with races if the
> list is already empty.
Ah, yes that's a good idea.

In general, I kept only one lock because these structures get accessed
together, but as you point out there's an opportunity to do better. As
you mentioned below, we can have one lock for the tree and perhaps
lock for each list.
>
> Having multiple list locks is fine if there is a specific locking
> order (larger to smaller) when multiple locks are taken.  If there
> is a group with the correct order it only needs a single list lock,
> and if a higher order group is needed (requiring the extent to be
> split) then the next lower list would be locked to insert the group,
> which can be taken without dropping the higher-order list lock.
So, I think we can live without having to take multiple list locks.
Mainly because these structures (rb tree and lists) are more of a
"hint" and thus have some tolerance for inaccuracy. For example, in
the case that you mentioned above, let's say we have 2 threads and
both of them need the same higher order group. Also, let's assume that
both will end up splitting the extent. In that case, our function
ext4_mb_choose_next_group() will still make both the threads use the
same group. However, eventually only one of them will win (because
only one of them will be able to lock the groupinfo) and would update
our structures accordingly. After that the thread that lost, would be
able to find another right group by looking up our structures.

So, to summarize, I like the idea of having locks for each list since
that would reduce contention that we would otherwise see on one lock.
Also, these structures are not designed to be always in sync with
ext4_group_info i.e. it may happen that a group is found in the list
which isn't the right order for the group or a part of the rb tree is
not sorted, and that is okay. Such states would always be temporary
and would eventually get fixed. Allowing for this small inaccuracy,
allows us to not hold contentious locks for a long time and thereby it
increases the performance. It also simplifies the locking.
>
> When inserting groups back into the list, assuming that each thread
> will stick with the same group for some number of allocations (rather
> than having to re-lookup the same group each time), does it make more
> sense to put the group at the *end* of the list so that the next
> thread doing a lookup will find a different group than another thread
> was just allocating from?
That's a good idea.
>
> Is there any particular requirement why the rb lock and the list
> lock(s) need to be the same lock?  I'd imagine that they do not,
> since a thread will be using either one list or the other.  Making
> these separate locks and reducing the lock hold time would allow
> more threads to be doing useful work instead of spinning.
I agree, I'll do this in the next version.

Thanks,
Harshad
>
> Cheers, Andreas
>
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> > fs/ext4/ext4.h    |   6 ++
> > fs/ext4/mballoc.c | 223 ++++++++++++++++++++++++++++++++++++++++++++--
> > fs/ext4/mballoc.h |   1 +
> > 3 files changed, 222 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 6dd127942208..da12a083bf52 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1527,6 +1527,9 @@ struct ext4_sb_info {
> >       unsigned int s_mb_free_pending;
> >       struct list_head s_freed_data_list;     /* List of blocks to be freed
> >                                                  after commit completed */
> > +     struct rb_root s_mb_avg_fragment_size_root;
> > +     struct list_head *s_mb_largest_free_orders;
> > +     rwlock_t s_mb_rb_lock;
> >
> >       /* tunables */
> >       unsigned long s_stripe;
> > @@ -3304,11 +3307,14 @@ struct ext4_group_info {
> >       ext4_grpblk_t   bb_free;        /* total free blocks */
> >       ext4_grpblk_t   bb_fragments;   /* nr of freespace fragments */
> >       ext4_grpblk_t   bb_largest_free_order;/* order of largest frag in BG */
> > +     ext4_group_t    bb_group;       /* Group number */
> >       struct          list_head bb_prealloc_list;
> > #ifdef DOUBLE_CHECK
> >       void            *bb_bitmap;
> > #endif
> >       struct rw_semaphore alloc_sem;
> > +     struct rb_node  bb_avg_fragment_size_rb;
> > +     struct list_head bb_largest_free_order_node;
> >       ext4_grpblk_t   bb_counters[];  /* Nr of free power-of-two-block
> >                                        * regions, index is order.
> >                                        * bb_counters[3] = 5 means
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 11c56b0e6f35..413259477b03 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -744,6 +744,193 @@ static void ext4_mb_mark_free_simple(struct super_block *sb,
> >       }
> > }
> >
> > +static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *new,
> > +                     int (*cmp)(struct rb_node *, struct rb_node *))
> > +{
> > +     struct rb_node **iter = &root->rb_node, *parent = NULL;
> > +
> > +     while (*iter) {
> > +             parent = *iter;
> > +             if (cmp(new, *iter))
> > +                     iter = &((*iter)->rb_left);
> > +             else
> > +                     iter = &((*iter)->rb_right);
> > +     }
> > +
> > +     rb_link_node(new, parent, iter);
> > +     rb_insert_color(new, root);
> > +}
> > +
> > +static int
> > +ext4_mb_avg_fragment_size_cmp(struct rb_node *rb1, struct rb_node *rb2)
> > +{
> > +     struct ext4_group_info *grp1 = rb_entry(rb1,
> > +                                             struct ext4_group_info,
> > +                                             bb_avg_fragment_size_rb);
> > +     struct ext4_group_info *grp2 = rb_entry(rb2,
> > +                                             struct ext4_group_info,
> > +                                             bb_avg_fragment_size_rb);
> > +     int num_frags_1, num_frags_2;
> > +
> > +     num_frags_1 = grp1->bb_fragments ?
> > +             grp1->bb_free / grp1->bb_fragments : 0;
> > +     num_frags_2 = grp2->bb_fragments ?
> > +             grp2->bb_free / grp2->bb_fragments : 0;
> > +
> > +     return (num_frags_1 < num_frags_2);
> > +}
> > +
> > +/*
> > + * Reinsert grpinfo into the avg_fragment_size tree and into the appropriate
> > + * largest_free_order list.
> > + */
> > +static void
> > +ext4_mb_reinsert_grpinfo(struct super_block *sb, struct ext4_group_info *grp)
> > +{
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +
> > +     write_lock(&sbi->s_mb_rb_lock);
> > +     if (!RB_EMPTY_NODE(&grp->bb_avg_fragment_size_rb)) {
> > +             rb_erase(&grp->bb_avg_fragment_size_rb,
> > +                             &sbi->s_mb_avg_fragment_size_root);
> > +             RB_CLEAR_NODE(&grp->bb_avg_fragment_size_rb);
> > +     }
> > +
> > +     ext4_mb_rb_insert(&sbi->s_mb_avg_fragment_size_root,
> > +             &grp->bb_avg_fragment_size_rb,
> > +             ext4_mb_avg_fragment_size_cmp);
> > +
> > +     list_del_init(&grp->bb_largest_free_order_node);
> > +     if (grp->bb_largest_free_order >= 0)
> > +             list_add(&grp->bb_largest_free_order_node,
> > +                      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
> > +     write_unlock(&sbi->s_mb_rb_lock);
> > +}
> > +
> > +/*
> > + * ext4_mb_choose_next_group: choose next group for allocation.
> > + *
> > + * @ac        Allocation Context
> > + * @new_cr    This is an output parameter. If the there is no good group available
> > + *            at current CR level, this field is updated to indicate the new cr
> > + *            level that should be used.
> > + * @group     This is an input / output parameter. As an input it indicates the last
> > + *            group used for allocation. As output, this field indicates the
> > + *            next group that should be used.
> > + * @ngroups   Total number of groups
> > + */
> > +static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
> > +             int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> > +{
> > +     struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> > +     int avg_fragment_size, best_so_far, i;
> > +     struct rb_node *node, *found;
> > +     struct ext4_group_info *grp;
> > +
> > +     *new_cr = ac->ac_criteria;
> > +     if (*new_cr >= 2 ||
> > +         !ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> > +             goto inc_and_return;
> > +
> > +     /*
> > +      * If there is contention on the lock, instead of waiting for the lock
> > +      * to become available, just continue searching lineraly.
> > +      */
> > +     if (!read_trylock(&sbi->s_mb_rb_lock))
> > +             goto inc_and_return;
> > +
> > +     if (*new_cr == 0) {
> > +             grp = NULL;
> > +
> > +             if (ac->ac_status == AC_STATUS_FOUND)
> > +                     goto inc_and_return;
> > +
> > +             for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> > +                     if (list_empty(&sbi->s_mb_largest_free_orders[i]))
> > +                             continue;
> > +                     grp = list_first_entry(&sbi->s_mb_largest_free_orders[i],
> > +                                            struct ext4_group_info,
> > +                                            bb_largest_free_order_node);
> > +                     break;
> > +             }
> > +
> > +             if (grp) {
> > +                     *group = grp->bb_group;
> > +                     goto done;
> > +             }
> > +             /* Increment cr and search again */
> > +             *new_cr = 1;
> > +     }
> > +
> > +     /*
> > +      * At CR 1, if enough groups are not loaded, we just fallback to
> > +      * linear search
> > +      */
> > +     if (atomic_read(&sbi->s_mb_buddies_generated) <
> > +         ext4_get_groups_count(ac->ac_sb)) {
> > +             read_unlock(&sbi->s_mb_rb_lock);
> > +             goto inc_and_return;
> > +     }
> > +
> > +     if (*new_cr == 1) {
> > +             if (ac->ac_f_ex.fe_len > 0) {
> > +                     /* We have found something at CR 1 in the past */
> > +                     grp = ext4_get_group_info(ac->ac_sb, ac->ac_last_optimal_group);
> > +                     found = rb_next(&grp->bb_avg_fragment_size_rb);
> > +                     if (found) {
> > +                             grp = rb_entry(found, struct ext4_group_info,
> > +                                            bb_avg_fragment_size_rb);
> > +                             *group = grp->bb_group;
> > +                     } else {
> > +                             *new_cr = 2;
> > +                     }
> > +                     goto done;
> > +             }
> > +
> > +             /* This is the first time we are searching in the tree */
> > +             node = sbi->s_mb_avg_fragment_size_root.rb_node;
> > +             best_so_far = 0;
> > +             found = NULL;
> > +
> > +             while (node) {
> > +                     grp = rb_entry(node, struct ext4_group_info,
> > +                             bb_avg_fragment_size_rb);
> > +                     avg_fragment_size = grp->bb_fragments ?
> > +                             grp->bb_free / grp->bb_fragments : 0;
> > +                     if (avg_fragment_size > ac->ac_g_ex.fe_len) {
> > +                             if (!best_so_far || avg_fragment_size < best_so_far) {
> > +                                     best_so_far = avg_fragment_size;
> > +                                     found = node;
> > +                             }
> > +                     }
> > +                     if (avg_fragment_size > ac->ac_g_ex.fe_len)
> > +                             node = node->rb_right;
> > +                     else
> > +                             node = node->rb_left;
> > +             }
> > +             if (found) {
> > +                     grp = rb_entry(found, struct ext4_group_info,
> > +                             bb_avg_fragment_size_rb);
> > +                     *group = grp->bb_group;
> > +             } else {
> > +                     *new_cr = 2;
> > +             }
> > +     }
> > +done:
> > +     read_unlock(&sbi->s_mb_rb_lock);
> > +     ac->ac_last_optimal_group = *group;
> > +     return;
> > +
> > +inc_and_return:
> > +     /*
> > +      * Artificially restricted ngroups for non-extent
> > +      * files makes group > ngroups possible on first loop.
> > +      */
> > +     *group = *group + 1;
> > +     if (*group >= ngroups)
> > +             *group = 0;
> > +}
> > +
> > /*
> >  * Cache the order of the largest free extent we have available in this block
> >  * group.
> > @@ -818,6 +1005,7 @@ void ext4_mb_generate_buddy(struct super_block *sb,
> >       period = get_cycles() - period;
> >       atomic_inc(&sbi->s_mb_buddies_generated);
> >       atomic64_add(period, &sbi->s_mb_generation_time);
> > +     ext4_mb_reinsert_grpinfo(sb, grp);
> > }
> >
> > /* The buddy information is attached the buddy cache inode
> > @@ -1517,6 +1705,7 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
> >
> > done:
> >       mb_set_largest_free_order(sb, e4b->bd_info);
> > +     ext4_mb_reinsert_grpinfo(sb, e4b->bd_info);
> >       mb_check_buddy(e4b);
> > }
> >
> > @@ -1653,6 +1842,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
> >       }
> >       mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
> >
> > +     ext4_mb_reinsert_grpinfo(e4b->bd_sb, e4b->bd_info);
> >       ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
> >       mb_check_buddy(e4b);
> >
> > @@ -2345,17 +2535,20 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> >                * from the goal value specified
> >                */
> >               group = ac->ac_g_ex.fe_group;
> > +             ac->ac_last_optimal_group = group;
> >               prefetch_grp = group;
> >
> > -             for (i = 0; i < ngroups; group++, i++) {
> > -                     int ret = 0;
> > +             for (i = 0; i < ngroups; i++) {
> > +                     int ret = 0, new_cr;
> > +
> >                       cond_resched();
> > -                     /*
> > -                      * Artificially restricted ngroups for non-extent
> > -                      * files makes group > ngroups possible on first loop.
> > -                      */
> > -                     if (group >= ngroups)
> > -                             group = 0;
> > +
> > +                     ext4_mb_choose_next_group(ac, &new_cr, &group, ngroups);
> > +
> > +                     if (new_cr != cr) {
> > +                             cr = new_cr;
> > +                             goto repeat;
> > +                     }
> >
> >                       /*
> >                        * Batch reads of the block allocation bitmaps
> > @@ -2650,7 +2843,10 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
> >       INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
> >       init_rwsem(&meta_group_info[i]->alloc_sem);
> >       meta_group_info[i]->bb_free_root = RB_ROOT;
> > +     INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
> > +     RB_CLEAR_NODE(&meta_group_info[i]->bb_avg_fragment_size_rb);
> >       meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
> > +     meta_group_info[i]->bb_group = group;
> >
> >       mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
> >       return 0;
> > @@ -2840,6 +3036,15 @@ int ext4_mb_init(struct super_block *sb)
> >               i++;
> >       } while (i < MB_NUM_ORDERS(sb));
> >
> > +     sbi->s_mb_avg_fragment_size_root = RB_ROOT;
> > +     sbi->s_mb_largest_free_orders =
> > +             kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
> > +                     GFP_KERNEL);
> > +     if (!sbi->s_mb_largest_free_orders)
> > +             goto out;
> > +     for (i = 0; i < MB_NUM_ORDERS(sb); i++)
> > +             INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
> > +     rwlock_init(&sbi->s_mb_rb_lock);
> >
> >       spin_lock_init(&sbi->s_md_lock);
> >       sbi->s_mb_free_pending = 0;
> > @@ -2903,6 +3108,7 @@ int ext4_mb_init(struct super_block *sb)
> >       free_percpu(sbi->s_locality_groups);
> >       sbi->s_locality_groups = NULL;
> > out:
> > +     kfree(sbi->s_mb_largest_free_orders);
> >       kfree(sbi->s_mb_offsets);
> >       sbi->s_mb_offsets = NULL;
> >       kfree(sbi->s_mb_maxs);
> > @@ -2959,6 +3165,7 @@ int ext4_mb_release(struct super_block *sb)
> >               kvfree(group_info);
> >               rcu_read_unlock();
> >       }
> > +     kfree(sbi->s_mb_largest_free_orders);
> >       kfree(sbi->s_mb_offsets);
> >       kfree(sbi->s_mb_maxs);
> >       iput(sbi->s_buddy_cache);
> > diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> > index 68111a10cfee..57b44c7320b2 100644
> > --- a/fs/ext4/mballoc.h
> > +++ b/fs/ext4/mballoc.h
> > @@ -166,6 +166,7 @@ struct ext4_allocation_context {
> >       /* copy of the best found extent taken before preallocation efforts */
> >       struct ext4_free_extent ac_f_ex;
> >
> > +     ext4_group_t ac_last_optimal_group;
> >       __u16 ac_groups_scanned;
> >       __u16 ac_found;
> >       __u16 ac_tail;
> > --
> > 2.30.0.365.g02bc693789-goog
> >
>
>
> Cheers, Andreas
>
>
>
>
>
