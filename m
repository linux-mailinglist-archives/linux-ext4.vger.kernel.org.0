Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027E434D512
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 18:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhC2Q0k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhC2Q0d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Mar 2021 12:26:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E1C061574
        for <linux-ext4@vger.kernel.org>; Mon, 29 Mar 2021 09:26:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w3so20434788ejc.4
        for <linux-ext4@vger.kernel.org>; Mon, 29 Mar 2021 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7l8YzzGr728XtHAhdgXizJTzI80L/AmCCq60QjxzMP4=;
        b=ajd+VZIaq3cqZGLjY2U8tv9BdgQ2BwRj96HZNeAHAC4GUJ13/kArbEaE6NzwL9zAwf
         i2KucjL5BaKC01SvwevNLlH1OrUywPFBs2BgGgq7Pk9unSfw/1XfKrF6Iiay5KgHSesq
         QI4Pg+t/snVkwUhpqhuR4ggKFQcwdYzbe8hqn+w77hX7YptxBdGKr9CNorWet6tsM3VD
         KJ722Jx/E48z5hI+10WRfmd24tk1hhI+pCol1BfOZLgOotKi38YPkc9Wkwq6JnhAnyiD
         q164PnKDHa4b9GnSteiT9T8FGNlXkiPrlnVI2uGuhIAmbS9aELPW3VCh5CBO20Oblynz
         lacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7l8YzzGr728XtHAhdgXizJTzI80L/AmCCq60QjxzMP4=;
        b=kI6eaoxpsCFXJFXuLPADdM0eSVl/eXBn/VtyGClTtuDr6ULsFj0grapVbphlqe4jdB
         a1WfxxafxaRmwqBA7dEwuU6GU0XOLpsVX+tP7l/ONK3QTYlD0BeYLgDhUrkNr7cuqbgl
         5Rh/GWr66A0hK76FX08j/hirrE5vEvbC08I9XEWu6vjnDW4KXoRO4r8m5Fz36cGj6U0f
         +o28mImNgXgfFiDTZ1L0ueKtFi3qeZFBb5NGAgEtNRWuG377A9yFG0fUr3RnfL8ggEGY
         xm2m+k0LdRnQa/HaUKjBBqH5bptbJQjWUg5bzfM4XKSkveBHkxGkxHn4+IljLoDVjGw7
         bsoQ==
X-Gm-Message-State: AOAM531/+gk9vnmzGvbhYVFs43V2twvI/2aDoYiEy7ZkiBU3tYoaCwSU
        Y41FUv1N+mVGOW0+eG5Mfu7wr/IT+uvkzmsqYbQ=
X-Google-Smtp-Source: ABdhPJwNHSqYrgPCmvC0NVAGlD/NOHtx0aOGuytzcu8qEOWSE9pci/I/RornZKP0YL4A4D5Kt9AKX4X47PxofqL8qGc=
X-Received: by 2002:a17:906:1706:: with SMTP id c6mr29938193eje.223.1617035190661;
 Mon, 29 Mar 2021 09:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
 <20210324231916.2515824-6-harshadshirwadkar@gmail.com> <f34cd26f-60b6-b622-e51b-7f84112e4219@linux.ibm.com>
In-Reply-To: <f34cd26f-60b6-b622-e51b-7f84112e4219@linux.ibm.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 29 Mar 2021 09:26:19 -0700
Message-ID: <CAD+ocbyK153Kbc+YjEeTCdDBt5CRR0_6ip2YMMbMb2cd-pYU7Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] ext4: improve cr 0 / cr 1 group scanning
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 25, 2021 at 6:50 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
>
>
> On 3/25/21 4:49 AM, Harshad Shirwadkar wrote:
> > Instead of traversing through groups linearly, scan groups in specific
> > orders at cr 0 and cr 1. At cr 0, we want to find groups that have the
> > largest free order >= the order of the request. So, with this patch,
> > we maintain lists for each possible order and insert each group into a
> > list based on the largest free order in its buddy bitmap. During cr 0
> > allocation, we traverse these lists in the increasing order of largest
> > free orders. This allows us to find a group with the best available cr
> > 0 match in constant time. If nothing can be found, we fallback to cr 1
> > immediately.
> >
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
> >
> > There is an opportunity to do optimization at CR2 too. That's because
> > at CR2 we only consider groups where bb_free counter (number of free
> > blocks) is greater than the request extent size. That's left as future
> > work.
> >
> > All the changes introduced in this patch are protected under a new
> > mount option "mb_optimize_scan".
> >
> > With this patchset, following experiment was performed:
> >
> > Created a highly fragmented disk of size 65TB. The disk had no
> > contiguous 2M regions. Following command was run consecutively for 3
> > times:
> >
> > time dd if=/dev/urandom of=file bs=2M count=10
> >
> > Here are the results with and without cr 0/1 optimizations introduced
> > in this patch:
> >
> > |---------+------------------------------+---------------------------|
> > |         | Without CR 0/1 Optimizations | With CR 0/1 Optimizations |
> > |---------+------------------------------+---------------------------|
> > | 1st run | 5m1.871s                     | 2m47.642s                 |
> > | 2nd run | 2m28.390s                    | 0m0.611s                  |
> > | 3rd run | 2m26.530s                    | 0m1.255s                  |
> > |---------+------------------------------+---------------------------|
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> > ---
> >   fs/ext4/ext4.h    |  19 ++-
> >   fs/ext4/mballoc.c | 381 ++++++++++++++++++++++++++++++++++++++++++++--
> >   fs/ext4/mballoc.h |  17 ++-
> >   fs/ext4/super.c   |  28 +++-
> >   fs/ext4/sysfs.c   |   2 +
> >   5 files changed, 432 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 85eeeba3bca3..5930c8cb5159 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -162,7 +162,10 @@ enum SHIFT_DIRECTION {
> >   #define EXT4_MB_USE_RESERVED                0x2000
> >   /* Do strict check for free blocks while retrying block allocation */
> >   #define EXT4_MB_STRICT_CHECK                0x4000
> > -
> > +/* Large fragment size list lookup succeeded at least once for cr = 0 */
> > +#define EXT4_MB_CR0_OPTIMIZED                0x8000
> > +/* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
> > +#define EXT4_MB_CR1_OPTIMIZED                0x00010000
> >   struct ext4_allocation_request {
> >       /* target inode for block we're allocating */
> >       struct inode *inode;
> > @@ -1247,7 +1250,9 @@ struct ext4_inode_info {
> >   #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT     0x00000010 /* Journal fast commit */
> >   #define EXT4_MOUNT2_DAX_NEVER               0x00000020 /* Do not allow Direct Access */
> >   #define EXT4_MOUNT2_DAX_INODE               0x00000040 /* For printing options only */
> > -
> > +#define EXT4_MOUNT2_MB_OPTIMIZE_SCAN 0x00000080 /* Optimize group
> > +                                                 * scanning in mballoc
> > +                                                 */
> >
> >   #define clear_opt(sb, opt)          EXT4_SB(sb)->s_mount_opt &= \
> >                                               ~EXT4_MOUNT_##opt
> > @@ -1527,9 +1532,14 @@ struct ext4_sb_info {
> >       unsigned int s_mb_free_pending;
> >       struct list_head s_freed_data_list;     /* List of blocks to be freed
> >                                                  after commit completed */
> > +     struct rb_root s_mb_avg_fragment_size_root;
> > +     rwlock_t s_mb_rb_lock;
> > +     struct list_head *s_mb_largest_free_orders;
> > +     rwlock_t *s_mb_largest_free_orders_locks;
> >
> >       /* tunables */
> >       unsigned long s_stripe;
> > +     unsigned int s_mb_linear_limit;
> >       unsigned int s_mb_stream_request;
> >       unsigned int s_mb_max_to_scan;
> >       unsigned int s_mb_min_to_scan;
> > @@ -1553,6 +1563,8 @@ struct ext4_sb_info {
> >       atomic_t s_bal_goals;   /* goal hits */
> >       atomic_t s_bal_breaks;  /* too long searches */
> >       atomic_t s_bal_2orders; /* 2^order hits */
> > +     atomic_t s_bal_cr0_bad_suggestions;
> > +     atomic_t s_bal_cr1_bad_suggestions;
> >       atomic64_t s_bal_cX_groups_considered[4];
> >       atomic64_t s_bal_cX_hits[4];
> >       atomic64_t s_bal_cX_failed[4];          /* cX loop didn't find blocks */
> > @@ -3309,11 +3321,14 @@ struct ext4_group_info {
> >       ext4_grpblk_t   bb_free;        /* total free blocks */
> >       ext4_grpblk_t   bb_fragments;   /* nr of freespace fragments */
> >       ext4_grpblk_t   bb_largest_free_order;/* order of largest frag in BG */
> > +     ext4_group_t    bb_group;       /* Group number */
> >       struct          list_head bb_prealloc_list;
> >   #ifdef DOUBLE_CHECK
> >       void            *bb_bitmap;
> >   #endif
> >       struct rw_semaphore alloc_sem;
> > +     struct rb_node  bb_avg_fragment_size_rb;
> > +     struct list_head bb_largest_free_order_node;
> >       ext4_grpblk_t   bb_counters[];  /* Nr of free power-of-two-block
> >                                        * regions, index is order.
> >                                        * bb_counters[3] = 5 means
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 15127d815461..cbf9a89c0ef5 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -127,11 +127,50 @@
> >    * smallest multiple of the stripe value (sbi->s_stripe) which is
> >    * greater than the default mb_group_prealloc.
> >    *
> > + * If "mb_optimize_scan" mount option is set, we maintain in memory group info
> > + * structures in two data structures:
> > + *
> > + * 1) Array of largest free order lists (sbi->s_mb_largest_free_orders)
> > + *
> > + *    Locking: sbi->s_mb_largest_free_orders_locks(array of rw locks)
> > + *
> > + *    This is an array of lists where the index in the array represents the
> > + *    largest free order in the buddy bitmap of the participating group infos of
> > + *    that list. So, there are exactly MB_NUM_ORDERS(sb) (which means total
> > + *    number of buddy bitmap orders possible) number of lists. Group-infos are
> > + *    placed in appropriate lists.
> > + *
> > + * 2) Average fragment size rb tree (sbi->s_mb_avg_fragment_size_root)
> > + *
> > + *    Locking: sbi->s_mb_rb_lock (rwlock)
> > + *
> > + *    This is a red black tree consisting of group infos and the tree is sorted
> > + *    by average fragment sizes (which is calculated as ext4_group_info->bb_free
> > + *    / ext4_group_info->bb_fragments).
> > + *
> > + * When "mb_optimize_scan" mount option is set, mballoc consults the above data
> > + * structures to decide the order in which groups are to be traversed for
> > + * fulfilling an allocation request.
> > + *
> > + * At CR = 0, we look for groups which have the largest_free_order >= the order
> > + * of the request. We directly look at the largest free order list in the data
> > + * structure (1) above where largest_free_order = order of the request. If that
> > + * list is empty, we look at remaining list in the increasing order of
> > + * largest_free_order. This allows us to perform CR = 0 lookup in O(1) time.
> > + *
> > + * At CR = 1, we only consider groups where average fragment size > request
> > + * size. So, we lookup a group which has average fragment size just above or
> > + * equal to request size using our rb tree (data structure 2) in O(log N) time.
> > + *
> > + * If "mb_optimize_scan" mount option is not set, mballoc traverses groups in
> > + * linear order which requires O(N) search time for each CR 0 and CR 1 phase.
> > + *
> >    * The regular allocator (using the buddy cache) supports a few tunables.
> >    *
> >    * /sys/fs/ext4/<partition>/mb_min_to_scan
> >    * /sys/fs/ext4/<partition>/mb_max_to_scan
> >    * /sys/fs/ext4/<partition>/mb_order2_req
> > + * /sys/fs/ext4/<partition>/mb_linear_limit
> >    *
> >    * The regular allocator uses buddy scan only if the request len is power of
> >    * 2 blocks and the order of allocation is >= sbi->s_mb_order2_reqs. The
> > @@ -149,6 +188,16 @@
> >    * can be used for allocation. ext4_mb_good_group explains how the groups are
> >    * checked.
> >    *
> > + * When "mb_optimize_scan" is turned on, as mentioned above, the groups may not
> > + * get traversed linearly. That may result in subsequent allocations being not
> > + * close to each other. And so, the underlying device may get filled up in a
> > + * non-linear fashion. While that may not matter on non-rotational devices, for
> > + * rotational devices that may result in higher seek times. "mb_linear_limit"
> > + * tells mballoc how many groups mballoc should search linearly before
> > + * performing consulting above data structures for more efficient lookups. For
> > + * non rotational devices, this value defaults to 0 and for rotational devices
> > + * this is set to MB_DEFAULT_LINEAR_LIMIT.
> > + *
> >    * Both the prealloc space are getting populated as above. So for the first
> >    * request we will hit the buddy cache which will result in this prealloc
> >    * space getting filled. The prealloc space is then later used for the
> > @@ -299,6 +348,8 @@
> >    *  - bitlock on a group    (group)
> >    *  - object (inode/locality)       (object)
> >    *  - per-pa lock           (pa)
> > + *  - cr0 lists lock         (cr0)
> > + *  - cr1 tree lock          (cr1)
> >    *
> >    * Paths:
> >    *  - new pa
> > @@ -328,6 +379,9 @@
> >    *    group
> >    *        object
> >    *
> > + *  - allocation path (ext4_mb_regular_allocator)
> > + *    group
> > + *    cr0/cr1
> >    */
> >   static struct kmem_cache *ext4_pspace_cachep;
> >   static struct kmem_cache *ext4_ac_cachep;
> > @@ -351,6 +405,9 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
> >                                               ext4_group_t group);
> >   static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
> >
> > +static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
> > +                            ext4_group_t group, int cr);
> > +
> >   /*
> >    * The algorithm using this percpu seq counter goes below:
> >    * 1. We sample the percpu discard_pa_seq counter before trying for block
> > @@ -744,6 +801,251 @@ static void ext4_mb_mark_free_simple(struct super_block *sb,
> >       }
> >   }
> >
> > +static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *new,
> > +                     int (*cmp)(struct rb_node *, struct rb_node *))
> > +{
> > +     struct rb_node **iter = &root->rb_node, *parent = NULL;
> > +
> > +     while (*iter) {
> > +             parent = *iter;
> > +             if (cmp(new, *iter) > 0)
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
> > +     return (num_frags_2 - num_frags_1);
> > +}
> > +
> > +/*
> > + * Reinsert grpinfo into the avg_fragment_size tree with new average
> > + * fragment size.
> > + */
> > +static void
> > +mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
> > +{
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +
> > +     if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
> > +             return;
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
> > +     write_unlock(&sbi->s_mb_rb_lock);
> > +}
> > +
> > +/*
> > + * Choose next group by traversing largest_free_order lists. Return 0 if next
> > + * group was selected optimally. Return 1 if next group was not selected
> > + * optimally. Updates *new_cr if cr level needs an update.
> > + */
> > +static int ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
> > +             int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> > +{
> > +     struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> > +     struct ext4_group_info *iter, *grp;
> > +     int i;
> > +
> > +     if (ac->ac_status == AC_STATUS_FOUND)
> > +             return 1;
> > +
> > +     if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR0_OPTIMIZED))
> > +             atomic_inc(&sbi->s_bal_cr0_bad_suggestions);
> > +
> > +     grp = NULL;
> > +     for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> > +             if (list_empty(&sbi->s_mb_largest_free_orders[i]))
> > +                     continue;
> > +             read_lock(&sbi->s_mb_largest_free_orders_locks[i]);
> > +             if (list_empty(&sbi->s_mb_largest_free_orders[i])) {
> > +                     read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> > +                     continue;
> > +             }
> > +             grp = NULL;
> > +             list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
> > +                                 bb_largest_free_order_node) {
> > +                     if (sbi->s_mb_stats)
> > +                             atomic64_inc(&sbi->s_bal_cX_groups_considered[0]);
> > +                     if (likely(ext4_mb_good_group(ac, iter->bb_group, 0))) {
> > +                             grp = iter;
> > +                             break;
> > +                     }
> > +             }
> > +             read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> > +             if (grp)
> > +                     break;
> > +     }
> > +
> > +     if (!grp) {
> > +             /* Increment cr and search again */
> > +             *new_cr = 1;
> > +     } else {
> > +             *group = grp->bb_group;
> > +             ac->ac_last_optimal_group = *group;
> > +             ac->ac_flags |= EXT4_MB_CR0_OPTIMIZED;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Choose next group by traversing average fragment size tree. Return 0 if next
> > + * group was selected optimally. Return 1 if next group could not selected
> > + * optimally (due to lock contention). Updates *new_cr if cr lvel needs an
> > + * update.
> > + */
> > +static int ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
> > +             int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> > +{
> > +     struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> > +     int avg_fragment_size, best_so_far;
> > +     struct rb_node *node, *found;
> > +     struct ext4_group_info *grp;
> > +
> > +     /*
> > +      * If there is contention on the lock, instead of waiting for the lock
> > +      * to become available, just continue searching lineraly. We'll resume
> > +      * our rb tree search later starting at ac->ac_last_optimal_group.
> > +      */
> > +     if (!read_trylock(&sbi->s_mb_rb_lock))
> > +             return 1;
> > +
> > +     if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
> > +             if (sbi->s_mb_stats)
> > +                     atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
> > +             /* We have found something at CR 1 in the past */
> > +             grp = ext4_get_group_info(ac->ac_sb, ac->ac_last_optimal_group);
> > +             for (found = rb_next(&grp->bb_avg_fragment_size_rb); found != NULL;
> > +                  found = rb_next(found)) {
> > +                     grp = rb_entry(found, struct ext4_group_info,
> > +                                    bb_avg_fragment_size_rb);
> > +                     if (sbi->s_mb_stats)
> > +                             atomic64_inc(&sbi->s_bal_cX_groups_considered[1]);
> > +                     if (likely(ext4_mb_good_group(ac, grp->bb_group, 1)))
> > +                             break;
> > +             }
> > +
> > +             goto done;
> > +     }
> > +
> > +     node = sbi->s_mb_avg_fragment_size_root.rb_node;
> > +     best_so_far = 0;
> > +     found = NULL;
> > +
> > +     while (node) {
> > +             grp = rb_entry(node, struct ext4_group_info,
> > +                            bb_avg_fragment_size_rb);
> > +             avg_fragment_size = 0;
> > +             /*
> > +              * Perform this check without locking, we'll lock later to confirm.
> > +              */
> > +             if (ext4_mb_good_group(ac, grp->bb_group, 1)) {
> > +                     avg_fragment_size = grp->bb_fragments ?
> > +                             grp->bb_free / grp->bb_fragments : 0;
> > +                     if (!best_so_far || avg_fragment_size < best_so_far) {
> > +                             best_so_far = avg_fragment_size;
> > +                             found = node;
> > +                     }
> > +             }
> > +             if (avg_fragment_size > ac->ac_g_ex.fe_len)
> > +                     node = node->rb_right;
> > +             else
> > +                     node = node->rb_left;
> > +     }
> > +
> > +done:
> > +     if (found) {
> > +             grp = rb_entry(found, struct ext4_group_info,
> > +                            bb_avg_fragment_size_rb);
> > +             *group = grp->bb_group;
> > +             ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
> > +     } else {
> > +             *new_cr = 2;
> > +     }
> > +
> > +     read_unlock(&sbi->s_mb_rb_lock);
> > +     ac->ac_last_optimal_group = *group;
> > +     return 0;
> > +}
> > +
> > +/*
> > + * ext4_mb_choose_next_group: choose next group for allocation.
> > + *
> > + * @ac        Allocation Context
> > + * @new_cr    This is an output parameter. If the there is no good group
> > + *            available at current CR level, this field is updated to indicate
> > + *            the new cr level that should be used.
> > + * @group     This is an input / output parameter. As an input it indicates the
> > + *            last group used for allocation. As output, this field indicates
> > + *            the next group that should be used.
> > + * @ngroups   Total number of groups
> > + */
> > +static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
> > +             int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> > +{
> > +     int ret;
> > +
> > +     *new_cr = ac->ac_criteria;
> > +
> > +     if (!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN) ||
> > +         *new_cr >= 2 ||
> > +         !ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> > +             goto inc_and_return;
> > +
> > +     if (ac->ac_groups_linear_remaining) {
> > +             ac->ac_groups_linear_remaining--;
> > +             goto inc_and_return;
> > +     }
> > +
> > +     if (*new_cr == 0) {
> > +             ret = ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
> > +             if (ret)
> > +                     goto inc_and_return;
> > +     }
> > +     if (*new_cr == 1) {
> > +             ret = ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
> > +             if (ret)
> > +                     goto inc_and_return;
> > +     }
> > +     return;
> > +
> > +inc_and_return:
> > +     /*
> > +      * Artificially restricted ngroups for non-extent
> > +      * files makes group > ngroups possible on first loop.
> > +      */
> > +     *group = *group + 1;
>
> hmm, Please help me correct if I am missing something here.
> So, if *new_cr >= 2, then we will directly come here
> increment the group and return to calling function.
> But then we ended up incrementing the group while not
> even searching in the given group to see if we could
> find some blocks.
>
>
>
> > +     if (*group >= ngroups)
> > +             *group = 0;
> > +}
> > +
> >   /*
> >    * Cache the order of the largest free extent we have available in this block
> >    * group.
> > @@ -751,18 +1053,33 @@ static void ext4_mb_mark_free_simple(struct super_block *sb,
> >   static void
> >   mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
> >   {
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> >       int i;
> > -     int bits;
> >
> > +     if (test_opt2(sb, MB_OPTIMIZE_SCAN) && grp->bb_largest_free_order >= 0) {
> > +             write_lock(&sbi->s_mb_largest_free_orders_locks[
> > +                                           grp->bb_largest_free_order]);
> > +             list_del_init(&grp->bb_largest_free_order_node);
> > +             write_unlock(&sbi->s_mb_largest_free_orders_locks[
> > +                                           grp->bb_largest_free_order]);
> > +     }
> >       grp->bb_largest_free_order = -1; /* uninit */
> >
> > -     bits = MB_NUM_ORDERS(sb) - 1;
> > -     for (i = bits; i >= 0; i--) {
> > +     for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--) {
> >               if (grp->bb_counters[i] > 0) {
> >                       grp->bb_largest_free_order = i;
> >                       break;
> >               }
> >       }
> > +     if (test_opt2(sb, MB_OPTIMIZE_SCAN) &&
> > +         grp->bb_largest_free_order >= 0 && grp->bb_free) {
> > +             write_lock(&sbi->s_mb_largest_free_orders_locks[
> > +                                           grp->bb_largest_free_order]);
> > +             list_add_tail(&grp->bb_largest_free_order_node,
> > +                   &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
> > +             write_unlock(&sbi->s_mb_largest_free_orders_locks[
> > +                                           grp->bb_largest_free_order]);
> > +     }
> >   }
> >
> >   static noinline_for_stack
> > @@ -818,6 +1135,7 @@ void ext4_mb_generate_buddy(struct super_block *sb,
> >       period = get_cycles() - period;
> >       atomic_inc(&sbi->s_mb_buddies_generated);
> >       atomic64_add(period, &sbi->s_mb_generation_time);
> > +     mb_update_avg_fragment_size(sb, grp);
> >   }
> >
> >   /* The buddy information is attached the buddy cache inode
> > @@ -1517,6 +1835,7 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
> >
> >   done:
> >       mb_set_largest_free_order(sb, e4b->bd_info);
> > +     mb_update_avg_fragment_size(sb, e4b->bd_info);
> >       mb_check_buddy(e4b);
> >   }
> >
> > @@ -1653,6 +1972,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
> >       }
> >       mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
> >
> > +     mb_update_avg_fragment_size(e4b->bd_sb, e4b->bd_info);
> >       ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
> >       mb_check_buddy(e4b);
> >
> > @@ -2347,17 +2667,21 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> >                * from the goal value specified
> >                */
> >               group = ac->ac_g_ex.fe_group;
> > +             ac->ac_last_optimal_group = group;
>
> Note we start from a goal group or optimal group.
>
> > +             ac->ac_groups_linear_remaining = sbi->s_mb_linear_limit;
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
>
>
> So ext4_mb_choose_next_group() will do group++ _even_ for cr >=2.
> This would mean that we will never start our search from ac_g_ex.fe_group.
> Why is that? Did I miss anything?
Thanks Ritesh, that's a good catch! So group choosing needs to happen
at the start of the group while increment needs to happen at the end.
I'll fix this in the next version.

- Harshad
>
>
> -ritesh
