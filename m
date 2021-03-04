Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8F932C885
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Mar 2021 02:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhCDAuo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Mar 2021 19:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392392AbhCDAOf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Mar 2021 19:14:35 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18937C06175F
        for <linux-ext4@vger.kernel.org>; Wed,  3 Mar 2021 16:10:32 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lr13so45826065ejb.8
        for <linux-ext4@vger.kernel.org>; Wed, 03 Mar 2021 16:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uz00I5lYxs5/k0W7MWDy7T0z+RMjvnEExVhabqSAQX8=;
        b=XVEVEUU9gceMwS6QtlPRl3ruVNZ/JQGrCZL0JMP2xCbHecUesKdp4L56W0UTibONU/
         rz23e6X25tPSjONrfalohnoyU0/mEeXAUFVvAlxKqz0O5zUgZ/nuVL1DQWEKsjNUL2yK
         JoTQh67PkHfFSivwrGsuTpLbMPP9As71nBMCmiYUqf3J4faimKdjWDfdkYXGxSGnP1b7
         CD+vbtv3jdlHCvJB15F1bkfAFh1bfVp4zP2b+uyXphT4OPF1FP+J9AAR0VIZeUt+Hs4g
         8hl/HH+XAODZ23bFINKxD5FYT0adJhJdOi5PVXlfGVVVZpgIKJlntntNNJ3zguKoEs+O
         O8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uz00I5lYxs5/k0W7MWDy7T0z+RMjvnEExVhabqSAQX8=;
        b=hcRER1Fq+pnOlmO6xDKvvMUQHPlElyZX8FwF9N0OjMunG0Cu0mVGWA1+me4ukJBGfR
         urY1pmV8aHCj0D6yS6gLacty/rxp2SY4NiX3xrq0jD7ZYK+xOzuUsDrNM1GvC0PGVvfl
         UgjaXkiyjWIEu6PMJJnnhTMx6tiKsYs5P8to9mUrim9L/jREk3VFrCMMh5SYvdmIO1WL
         S6dA3xcnWrUEuWYMSxQ8weLZgpBRN2rdtyK4pmbYFPzpzqVIqFh5LgZIqAKTsFGijt+5
         vRtmr2BXpgtl8QTpUjebPnz+RDO57S2vt6pUrnlGPOZxs9UuhMmf+LT/cL7unDZTjuqG
         EWMg==
X-Gm-Message-State: AOAM5302yIRJWuOLVgX89s9p+mITAn+UnxQaHRz6y1QXd9oRnfKl/wAK
        aV4juwKgyrhEPiruoC7zkmnfLsK9AZkFpPkK3CE=
X-Google-Smtp-Source: ABdhPJy1Sz10uGHZ/CAgiHpNGLuThdaD1x4nYp9W/z1Gm0o2JuobRw8D1hx7a/jLM8j09YpMkEvKbrxrJybxyn9tSvA=
X-Received: by 2002:a17:906:a099:: with SMTP id q25mr1216774ejy.549.1614816630551;
 Wed, 03 Mar 2021 16:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
 <20210226193612.1199321-5-harshadshirwadkar@gmail.com> <5EAF519D-6998-4CCD-9E88-A1B9F99F189C@gmail.com>
In-Reply-To: <5EAF519D-6998-4CCD-9E88-A1B9F99F189C@gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 3 Mar 2021 16:10:18 -0800
Message-ID: <CAD+ocbx3t=DSfLjYP_Vjaj4Z+Ax5jfTJBv3bPwjtiumycQsnog@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] ext4: improve cr 0 / cr 1 group scanning
To:     =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

Thanks Andreas and Artem for the feedback. I'll incorporate these
suggestions in the next version of the patchset.

In our discussions above, we have been trying to fine tune the flow of
the block allocator based on different use cases. I wonder given the
number of different allocation paths that now exist and given their
own pros and cons, does it make sense to consider adding an eBPF hook
in the allocator path and let the user-space be involved in some of
decisions based on the use case? For example, a system that cares most
about the fragmentation levels and performance can choose to do this
fast path and skip other paths like prealloc, linear search, search by
goal etc.

Having an eBPF hook in the allocator can also allow for following
other enhancements:

1) Allocator behavior can be dynamically configured. For example, if
we reach a threshold fragmentation level, turn off linear allocation.

2) Different allocation paths can be used for different regions of the disk=
.

3) The userspace can have a say in how files are laid on the disk. On
a rotational disk, mysql can choose to keep its files together, while
directing any non-mysql files to be written farther away from mysql
files. Also, different applications can have a different allocation
path based on their latency requirements.

Having said that, I'm not sure what kind of performance impact we'll
see by putting an eBPF hook in the allocation path. Also, given that
we don't yet have an ecosystem around eBPF in Ext4 (or file systems in
general), this is really a far-fetched idea and may take a long time
to become mature enough to be usable in production.

This is just an idea that I wanted to share, this patch series doesn't
do or intend to do anything that's mentioned above.

Thanks,
Harshad



On Wed, Mar 3, 2021 at 3:31 AM =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=
=D1=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC
<artem.blagodarenko@gmail.com> wrote:
>
> Hello Harshad,
>
> Thank you for the new patchset. Everything looks good for me.
> One comment below.
>
> > On 26 Feb 2021, at 22:36, Harshad Shirwadkar <harshadshirwadkar@gmail.c=
om> wrote:
> >
> > Instead of traversing through groups linearly, scan groups in specific
> > orders at cr 0 and cr 1. At cr 0, we want to find groups that have the
> > largest free order >=3D the order of the request. So, with this patch,
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
> > For cr >=3D 2, we just perform the linear search as before. Also, in
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
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > fs/ext4/ext4.h    |  14 +-
> > fs/ext4/mballoc.c | 374 ++++++++++++++++++++++++++++++++++++++++++++--
> > fs/ext4/mballoc.h |  14 ++
> > fs/ext4/super.c   |   6 +-
> > fs/ext4/sysfs.c   |   2 +
> > 5 files changed, 397 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 3e906a3d553a..d792418c39ca 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -162,6 +162,8 @@ enum SHIFT_DIRECTION {
> > #define EXT4_MB_USE_RESERVED          0x2000
> > /* Do strict check for free blocks while retrying block allocation */
> > #define EXT4_MB_STRICT_CHECK          0x4000
> > +/* Avg fragment size rb tree lookup succeeded at least once for cr =3D=
 1 */
> > +#define EXT4_MB_CR1_OPTIMIZED                0x8000
> >
> > struct ext4_allocation_request {
> >       /* target inode for block we're allocating */
> > @@ -1247,7 +1249,9 @@ struct ext4_inode_info {
> > #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT       0x00000010 /* Journal fas=
t commit */
> > #define EXT4_MOUNT2_DAX_NEVER         0x00000020 /* Do not allow Direct=
 Access */
> > #define EXT4_MOUNT2_DAX_INODE         0x00000040 /* For printing option=
s only */
> > -
> > +#define EXT4_MOUNT2_MB_OPTIMIZE_SCAN 0x00000080 /* Optimize group
> > +                                                 * scanning in mballoc
> > +                                                 */
> >
> > #define clear_opt(sb, opt)            EXT4_SB(sb)->s_mount_opt &=3D \
> >                                               ~EXT4_MOUNT_##opt
> > @@ -1527,9 +1531,14 @@ struct ext4_sb_info {
> >       unsigned int s_mb_free_pending;
> >       struct list_head s_freed_data_list;     /* List of blocks to be f=
reed
> >                                                  after commit completed=
 */
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
> > @@ -3308,11 +3317,14 @@ struct ext4_group_info {
> >       ext4_grpblk_t   bb_free;        /* total free blocks */
> >       ext4_grpblk_t   bb_fragments;   /* nr of freespace fragments */
> >       ext4_grpblk_t   bb_largest_free_order;/* order of largest frag in=
 BG */
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
> >                                        * bb_counters[3] =3D 5 means
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 161412070fef..bcfd849bc61e 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -127,11 +127,50 @@
> >  * smallest multiple of the stripe value (sbi->s_stripe) which is
> >  * greater than the default mb_group_prealloc.
> >  *
> > + * If "mb_optimize_scan" mount option is set, we maintain in memory gr=
oup info
> > + * structures in two data structures:
> > + *
> > + * 1) Array of largest free order lists (sbi->s_mb_largest_free_orders=
)
> > + *
> > + *    Locking: sbi->s_mb_largest_free_orders_locks(array of rw locks)
> > + *
> > + *    This is an array of lists where the index in the array represent=
s the
> > + *    largest free order in the buddy bitmap of the participating grou=
p infos of
> > + *    that list. So, there are exactly MB_NUM_ORDERS(sb) (which means =
total
> > + *    number of buddy bitmap orders possible) number of lists. Group-i=
nfos are
> > + *    placed in appropriate lists.
> > + *
> > + * 2) Average fragment size rb tree (sbi->s_mb_avg_fragment_size_root)
> > + *
> > + *    Locking: sbi->s_mb_rb_lock (rwlock)
> > + *
> > + *    This is a red black tree consisting of group infos and the tree =
is sorted
> > + *    by average fragment sizes (which is calculated as ext4_group_inf=
o->bb_free
> > + *    / ext4_group_info->bb_fragments).
> > + *
> > + * When "mb_optimize_scan" mount option is set, mballoc consults the a=
bove data
> > + * structures to decide the order in which groups are to be traversed =
for
> > + * fulfilling an allocation request.
> > + *
> > + * At CR =3D 0, we look for groups which have the largest_free_order >=
=3D the order
> > + * of the request. We directly look at the largest free order list in =
the data
> > + * structure (1) above where largest_free_order =3D order of the reque=
st. If that
> > + * list is empty, we look at remaining list in the increasing order of
> > + * largest_free_order. This allows us to perform CR =3D 0 lookup in O(=
1) time.
> > + *
> > + * At CR =3D 1, we only consider groups where average fragment size > =
request
> > + * size. So, we lookup a group which has average fragment size just ab=
ove or
> > + * equal to request size using our rb tree (data structure 2) in O(log=
 N) time.
> > + *
> > + * If "mb_optimize_scan" mount option is not set, mballoc traverses gr=
oups in
> > + * linear order which requires O(N) search time for each CR 0 and CR 1=
 phase.
> > + *
> >  * The regular allocator (using the buddy cache) supports a few tunable=
s.
> >  *
> >  * /sys/fs/ext4/<partition>/mb_min_to_scan
> >  * /sys/fs/ext4/<partition>/mb_max_to_scan
> >  * /sys/fs/ext4/<partition>/mb_order2_req
> > + * /sys/fs/ext4/<partition>/mb_linear_limit
> >  *
> >  * The regular allocator uses buddy scan only if the request len is pow=
er of
> >  * 2 blocks and the order of allocation is >=3D sbi->s_mb_order2_reqs. =
The
> > @@ -149,6 +188,16 @@
> >  * can be used for allocation. ext4_mb_good_group explains how the grou=
ps are
> >  * checked.
> >  *
> > + * When "mb_optimize_scan" is turned on, as mentioned above, the group=
s may not
> > + * get traversed linearly. That may result in subsequent allocations b=
eing not
> > + * close to each other. And so, the underlying device may get filled u=
p in a
> > + * non-linear fashion. While that may not matter on non-rotational dev=
ices, for
>
> Actually I believe this matters even for non-rotational devices. Flash-fr=
iendly filesystems
> (such as F2FS for instance) try to escape rewriting and fill a device seq=
uentially to prolong device lifetime.
> Ext4 starts searching from a goal block. For empty disk next good group w=
ould be located near previous one.
> For a filled filesystem, I agree, this doesn=E2=80=99t matter.
>
> > + * rotational devices that may result in higher seek times. "mb_linear=
_limit"
> > + * tells mballoc how many groups mballoc should search linearly before
> > + * performing consulting above data structures for more efficient look=
ups. For
> > + * non rotational devices, this value defaults to 0 and for rotational=
 devices
> > + * this is set to MB_DEFAULT_LINEAR_LIMIT.
>
> Concerning the comment above are we going to set non-0 for non-rotational=
 devices?
>
> > + *
> >  * Both the prealloc space are getting populated as above. So for the f=
irst
> >  * request we will hit the buddy cache which will result in this preall=
oc
> >  * space getting filled. The prealloc space is then later used for the
> > @@ -299,6 +348,8 @@
> >  *  - bitlock on a group      (group)
> >  *  - object (inode/locality) (object)
> >  *  - per-pa lock             (pa)
> > + *  - cr0 lists lock         (cr0)
> > + *  - cr1 tree lock          (cr1)
> >  *
> >  * Paths:
> >  *  - new pa
> > @@ -328,6 +379,9 @@
> >  *    group
> >  *        object
> >  *
> > + *  - allocation path (ext4_mb_regular_allocator)
> > + *    group
> > + *    cr0/cr1
> >  */
> > static struct kmem_cache *ext4_pspace_cachep;
> > static struct kmem_cache *ext4_ac_cachep;
> > @@ -351,6 +405,9 @@ static void ext4_mb_generate_from_freelist(struct s=
uper_block *sb, void *bitmap,
> >                                               ext4_group_t group);
> > static void ext4_mb_new_preallocation(struct ext4_allocation_context *a=
c);
> >
> > +static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
> > +                            ext4_group_t group, int cr);
> > +
> > /*
> >  * The algorithm using this percpu seq counter goes below:
> >  * 1. We sample the percpu discard_pa_seq counter before trying for blo=
ck
> > @@ -744,6 +801,243 @@ static void ext4_mb_mark_free_simple(struct super=
_block *sb,
> >       }
> > }
> >
> > +static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *ne=
w,
> > +                     int (*cmp)(struct rb_node *, struct rb_node *))
> > +{
> > +     struct rb_node **iter =3D &root->rb_node, *parent =3D NULL;
> > +
> > +     while (*iter) {
> > +             parent =3D *iter;
> > +             if (cmp(new, *iter))
> > +                     iter =3D &((*iter)->rb_left);
> > +             else
> > +                     iter =3D &((*iter)->rb_right);
> > +     }
> > +
> > +     rb_link_node(new, parent, iter);
> > +     rb_insert_color(new, root);
> > +}
> > +
> > +static int
> > +ext4_mb_avg_fragment_size_cmp(struct rb_node *rb1, struct rb_node *rb2=
)
> > +{
> > +     struct ext4_group_info *grp1 =3D rb_entry(rb1,
> > +                                             struct ext4_group_info,
> > +                                             bb_avg_fragment_size_rb);
> > +     struct ext4_group_info *grp2 =3D rb_entry(rb2,
> > +                                             struct ext4_group_info,
> > +                                             bb_avg_fragment_size_rb);
> > +     int num_frags_1, num_frags_2;
> > +
> > +     num_frags_1 =3D grp1->bb_fragments ?
> > +             grp1->bb_free / grp1->bb_fragments : 0;
> > +     num_frags_2 =3D grp2->bb_fragments ?
> > +             grp2->bb_free / grp2->bb_fragments : 0;
> > +
> > +     return (num_frags_1 < num_frags_2);
> > +}
> > +
> > +/*
> > + * Reinsert grpinfo into the avg_fragment_size tree with new average
> > + * fragment size.
> > + */
> > +static void
> > +mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_=
info *grp)
> > +{
> > +     struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> > +
> > +     if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free =3D=3D 0)
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
> > + * Choose next group by traversing largest_free_order lists. Return 0 =
if next
> > + * group was selected optimally. Return 1 if next group was not select=
ed
> > + * optimally. Updates *new_cr if cr level needs an update.
> > + */
> > +static int ext4_mb_choose_next_group_cr0(struct ext4_allocation_contex=
t *ac,
> > +             int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> > +{
> > +     struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> > +     struct ext4_group_info *iter, *grp;
> > +     int i;
> > +
> > +     if (ac->ac_status =3D=3D AC_STATUS_FOUND)
> > +             return 1;
> > +
> > +     grp =3D NULL;
> > +     for (i =3D ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> > +             if (list_empty(&sbi->s_mb_largest_free_orders[i]))
> > +                     continue;
> > +             read_lock(&sbi->s_mb_largest_free_orders_locks[i]);
> > +             if (list_empty(&sbi->s_mb_largest_free_orders[i])) {
> > +                     read_unlock(&sbi->s_mb_largest_free_orders_locks[=
i]);
> > +                     continue;
> > +             }
> > +             grp =3D NULL;
> > +             list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[=
i],
> > +                                 bb_largest_free_order_node) {
> > +                     ac->ac_groups_considered++;
> > +                     if (likely(ext4_mb_good_group(ac, iter->bb_group,=
 0))) {
> > +                             grp =3D iter;
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
> > +             *new_cr =3D 1;
> > +     } else {
> > +             *group =3D grp->bb_group;
> > +             ac->ac_last_optimal_group =3D *group;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Choose next group by traversing average fragment size tree. Return =
0 if next
> > + * group was selected optimally. Return 1 if next group could not sele=
cted
> > + * optimally (due to lock contention). Updates *new_cr if cr lvel need=
s an
> > + * update.
> > + */
> > +static int ext4_mb_choose_next_group_cr1(struct ext4_allocation_contex=
t *ac,
> > +             int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> > +{
> > +     struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> > +     int avg_fragment_size, best_so_far;
> > +     struct rb_node *node, *found;
> > +     struct ext4_group_info *grp;
> > +
> > +     /*
> > +      * If there is contention on the lock, instead of waiting for the=
 lock
> > +      * to become available, just continue searching lineraly. We'll r=
esume
> > +      * our rb tree search later starting at ac->ac_last_optimal_group=
.
> > +      */
> > +     if (!read_trylock(&sbi->s_mb_rb_lock))
> > +             return 1;
> > +
> > +     if (ac->ac_flags & EXT4_MB_CR1_OPTIMIZED) {
> > +             /* We have found something at CR 1 in the past */
> > +             grp =3D ext4_get_group_info(ac->ac_sb, ac->ac_last_optima=
l_group);
> > +             for (found =3D rb_next(&grp->bb_avg_fragment_size_rb); fo=
und !=3D NULL;
> > +                  found =3D rb_next(found)) {
> > +                     grp =3D rb_entry(found, struct ext4_group_info,
> > +                                    bb_avg_fragment_size_rb);
> > +                     ac->ac_groups_considered++;
> > +                     if (likely(ext4_mb_good_group(ac, grp->bb_group, =
1)))
> > +                             break;
> > +             }
> > +
> > +             goto done;
> > +     }
> > +
> > +     node =3D sbi->s_mb_avg_fragment_size_root.rb_node;
> > +     best_so_far =3D 0;
> > +     found =3D NULL;
> > +
> > +     while (node) {
> > +             grp =3D rb_entry(node, struct ext4_group_info,
> > +                            bb_avg_fragment_size_rb);
> > +             avg_fragment_size =3D 0;
> > +             /*
> > +              * Perform this check without locking, we'll lock later t=
o confirm.
> > +              */
> > +             if (ext4_mb_good_group(ac, grp->bb_group, 1)) {
> > +                     avg_fragment_size =3D grp->bb_fragments ?
> > +                             grp->bb_free / grp->bb_fragments : 0;
> > +                     if (!best_so_far || avg_fragment_size < best_so_f=
ar) {
> > +                             best_so_far =3D avg_fragment_size;
> > +                             found =3D node;
> > +                     }
> > +             }
> > +             if (avg_fragment_size > ac->ac_g_ex.fe_len)
> > +                     node =3D node->rb_right;
> > +             else
> > +                     node =3D node->rb_left;
> > +     }
> > +
> > +done:
> > +     if (found) {
> > +             grp =3D rb_entry(found, struct ext4_group_info,
> > +                            bb_avg_fragment_size_rb);
> > +             *group =3D grp->bb_group;
> > +             ac->ac_flags |=3D EXT4_MB_CR1_OPTIMIZED;
> > +     } else {
> > +             *new_cr =3D 2;
> > +     }
> > +
> > +     read_unlock(&sbi->s_mb_rb_lock);
> > +     ac->ac_last_optimal_group =3D *group;
> > +     return 0;
> > +}
> > +
> > +/*
> > + * ext4_mb_choose_next_group: choose next group for allocation.
> > + *
> > + * @ac        Allocation Context
> > + * @new_cr    This is an output parameter. If the there is no good gro=
up available
> > + *            at current CR level, this field is updated to indicate t=
he new cr
> > + *            level that should be used.
> > + * @group     This is an input / output parameter. As an input it indi=
cates the last
> > + *            group used for allocation. As output, this field indicat=
es the
> > + *            next group that should be used.
> > + * @ngroups   Total number of groups
> > + */
> > +static void ext4_mb_choose_next_group(struct ext4_allocation_context *=
ac,
> > +             int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> > +{
> > +     int ret;
> > +
> > +     *new_cr =3D ac->ac_criteria;
> > +
> > +     if (!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN) ||
> > +         *new_cr >=3D 2 ||
> > +         !ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> > +             goto inc_and_return;
> > +
> > +     if (ac->ac_groups_linear_remaining) {
> > +             ac->ac_groups_linear_remaining--;
> > +             goto inc_and_return;
> > +     }
> > +
> > +     if (*new_cr =3D=3D 0) {
> > +             ret =3D ext4_mb_choose_next_group_cr0(ac, new_cr, group, =
ngroups);
> > +             if (ret)
> > +                     goto inc_and_return;
> > +     }
> > +     if (*new_cr =3D=3D 1) {
> > +             ret =3D ext4_mb_choose_next_group_cr1(ac, new_cr, group, =
ngroups);
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
> > +     *group =3D *group + 1;
> > +     if (*group >=3D ngroups)
> > +             *group =3D 0;
> > +}
> > +
> > /*
> >  * Cache the order of the largest free extent we have available in this=
 block
> >  * group.
> > @@ -751,18 +1045,33 @@ static void ext4_mb_mark_free_simple(struct supe=
r_block *sb,
> > static void
> > mb_set_largest_free_order(struct super_block *sb, struct ext4_group_inf=
o *grp)
> > {
> > +     struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> >       int i;
> > -     int bits;
> >
> > +     if (test_opt2(sb, MB_OPTIMIZE_SCAN) && grp->bb_largest_free_order=
 >=3D 0) {
> > +             write_lock(&sbi->s_mb_largest_free_orders_locks[
> > +                                           grp->bb_largest_free_order]=
);
> > +             list_del_init(&grp->bb_largest_free_order_node);
> > +             write_unlock(&sbi->s_mb_largest_free_orders_locks[
> > +                                           grp->bb_largest_free_order]=
);
> > +     }
> >       grp->bb_largest_free_order =3D -1; /* uninit */
> >
> > -     bits =3D MB_NUM_ORDERS(sb) - 1;
> > -     for (i =3D bits; i >=3D 0; i--) {
> > +     for (i =3D MB_NUM_ORDERS(sb) - 1; i >=3D 0; i--) {
> >               if (grp->bb_counters[i] > 0) {
> >                       grp->bb_largest_free_order =3D i;
> >                       break;
> >               }
> >       }
> > +     if (test_opt2(sb, MB_OPTIMIZE_SCAN) &&
> > +         grp->bb_largest_free_order >=3D 0 && grp->bb_free) {
> > +             write_lock(&sbi->s_mb_largest_free_orders_locks[
> > +                                           grp->bb_largest_free_order]=
);
> > +             list_add_tail(&grp->bb_largest_free_order_node,
> > +                   &sbi->s_mb_largest_free_orders[grp->bb_largest_free=
_order]);
> > +             write_unlock(&sbi->s_mb_largest_free_orders_locks[
> > +                                           grp->bb_largest_free_order]=
);
> > +     }
> > }
> >
> > static noinline_for_stack
> > @@ -818,6 +1127,7 @@ void ext4_mb_generate_buddy(struct super_block *sb=
,
> >       period =3D get_cycles() - period;
> >       atomic_inc(&sbi->s_mb_buddies_generated);
> >       atomic64_add(period, &sbi->s_mb_generation_time);
> > +     mb_update_avg_fragment_size(sb, grp);
> > }
> >
> > /* The buddy information is attached the buddy cache inode
> > @@ -1517,6 +1827,7 @@ static void mb_free_blocks(struct inode *inode, s=
truct ext4_buddy *e4b,
> >
> > done:
> >       mb_set_largest_free_order(sb, e4b->bd_info);
> > +     mb_update_avg_fragment_size(sb, e4b->bd_info);
> >       mb_check_buddy(e4b);
> > }
> >
> > @@ -1653,6 +1964,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, s=
truct ext4_free_extent *ex)
> >       }
> >       mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
> >
> > +     mb_update_avg_fragment_size(e4b->bd_sb, e4b->bd_info);
> >       ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
> >       mb_check_buddy(e4b);
> >
> > @@ -2346,17 +2658,21 @@ ext4_mb_regular_allocator(struct ext4_allocatio=
n_context *ac)
> >                * from the goal value specified
> >                */
> >               group =3D ac->ac_g_ex.fe_group;
> > +             ac->ac_last_optimal_group =3D group;
> > +             ac->ac_groups_linear_remaining =3D sbi->s_mb_linear_limit=
;
> >               prefetch_grp =3D group;
> >
> > -             for (i =3D 0; i < ngroups; group++, i++) {
> > -                     int ret =3D 0;
> > +             for (i =3D 0; i < ngroups; i++) {
> > +                     int ret =3D 0, new_cr;
> > +
> >                       cond_resched();
> > -                     /*
> > -                      * Artificially restricted ngroups for non-extent
> > -                      * files makes group > ngroups possible on first =
loop.
> > -                      */
> > -                     if (group >=3D ngroups)
> > -                             group =3D 0;
> > +
> > +                     ext4_mb_choose_next_group(ac, &new_cr, &group, ng=
roups);
> > +
> > +                     if (new_cr !=3D cr) {
> > +                             cr =3D new_cr;
> > +                             goto repeat;
> > +                     }
> >
> >                       /*
> >                        * Batch reads of the block allocation bitmaps
> > @@ -2696,7 +3012,10 @@ int ext4_mb_add_groupinfo(struct super_block *sb=
, ext4_group_t group,
> >       INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
> >       init_rwsem(&meta_group_info[i]->alloc_sem);
> >       meta_group_info[i]->bb_free_root =3D RB_ROOT;
> > +     INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
> > +     RB_CLEAR_NODE(&meta_group_info[i]->bb_avg_fragment_size_rb);
> >       meta_group_info[i]->bb_largest_free_order =3D -1;  /* uninit */
> > +     meta_group_info[i]->bb_group =3D group;
> >
> >       mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
> >       return 0;
> > @@ -2886,6 +3205,22 @@ int ext4_mb_init(struct super_block *sb)
> >               i++;
> >       } while (i < MB_NUM_ORDERS(sb));
> >
> > +     sbi->s_mb_avg_fragment_size_root =3D RB_ROOT;
> > +     sbi->s_mb_largest_free_orders =3D
> > +             kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head)=
,
> > +                     GFP_KERNEL);
> > +     if (!sbi->s_mb_largest_free_orders)
> > +             goto out;
> > +     sbi->s_mb_largest_free_orders_locks =3D
> > +             kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
> > +                     GFP_KERNEL);
> > +     if (!sbi->s_mb_largest_free_orders_locks)
> > +             goto out;
> > +     for (i =3D 0; i < MB_NUM_ORDERS(sb); i++) {
> > +             INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
> > +             rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
> > +     }
> > +     rwlock_init(&sbi->s_mb_rb_lock);
> >
> >       spin_lock_init(&sbi->s_md_lock);
> >       sbi->s_mb_free_pending =3D 0;
> > @@ -2938,6 +3273,20 @@ int ext4_mb_init(struct super_block *sb)
> >               spin_lock_init(&lg->lg_prealloc_lock);
> >       }
> >
> > +     if (blk_queue_nonrot(bdev_get_queue(sb->s_bdev)))
> > +             sbi->s_mb_linear_limit =3D 0;
> > +     else
> > +             sbi->s_mb_linear_limit =3D MB_DEFAULT_LINEAR_LIMIT;
> > +#ifndef CONFIG_EXT4_DEBUG
> > +     /*
> > +      * Disable mb_optimize scan if we don't have enough groups. If
> > +      * CONFIG_EXT4_DEBUG is set, we don't disable this MB_OPTIMIZE_SC=
AN even
> > +      * for small file systems. This allows us to test correctness on =
small
> > +      * file systems.
> > +      */
> > +     if (ext4_get_groups_count(sb) < MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
> > +             clear_opt2(sb, MB_OPTIMIZE_SCAN);
> > +#endif
> >       /* init file for buddy data */
> >       ret =3D ext4_mb_init_backend(sb);
> >       if (ret !=3D 0)
> > @@ -2949,6 +3298,8 @@ int ext4_mb_init(struct super_block *sb)
> >       free_percpu(sbi->s_locality_groups);
> >       sbi->s_locality_groups =3D NULL;
> > out:
> > +     kfree(sbi->s_mb_largest_free_orders);
> > +     kfree(sbi->s_mb_largest_free_orders_locks);
> >       kfree(sbi->s_mb_offsets);
> >       sbi->s_mb_offsets =3D NULL;
> >       kfree(sbi->s_mb_maxs);
> > @@ -3005,6 +3356,7 @@ int ext4_mb_release(struct super_block *sb)
> >               kvfree(group_info);
> >               rcu_read_unlock();
> >       }
> > +     kfree(sbi->s_mb_largest_free_orders);
> >       kfree(sbi->s_mb_offsets);
> >       kfree(sbi->s_mb_maxs);
> >       iput(sbi->s_buddy_cache);
> > diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> > index 02861406932f..5c0275f832a0 100644
> > --- a/fs/ext4/mballoc.h
> > +++ b/fs/ext4/mballoc.h
> > @@ -78,6 +78,18 @@
> >  */
> > #define MB_DEFAULT_MAX_INODE_PREALLOC 512
> >
> > +/*
> > + * Number of groups to search linearly before performing group scannin=
g
> > + * optimization.
> > + */
> > +#define MB_DEFAULT_LINEAR_LIMIT              4
> > +
> > +/*
> > + * Minimum number of groups that should be present in the file system =
to perform
> > + * group scanning optimizations.
> > + */
> > +#define MB_DEFAULT_LINEAR_SCAN_THRESHOLD     16
> > +
> > /*
> >  * Number of valid buddy orders
> >  */
> > @@ -166,8 +178,10 @@ struct ext4_allocation_context {
> >       /* copy of the best found extent taken before preallocation effor=
ts */
> >       struct ext4_free_extent ac_f_ex;
> >
> > +     ext4_group_t ac_last_optimal_group;
> >       __u32 ac_groups_considered;
> >       __u16 ac_groups_scanned;
> > +     __u16 ac_groups_linear_remaining;
> >       __u16 ac_found;
> >       __u16 ac_tail;
> >       __u16 ac_buddy;
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 071d131fadd8..aa92d3ebe13d 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -154,6 +154,7 @@ static inline void __ext4_read_bh(struct buffer_hea=
d *bh, int op_flags,
> >       clear_buffer_verified(bh);
> >
> >       bh->b_end_io =3D end_io ? end_io : end_buffer_read_sync;
> > +
> >       get_bh(bh);
> >       submit_bh(REQ_OP_READ, op_flags, bh);
> > }
> > @@ -1687,7 +1688,7 @@ enum {
> >       Opt_dioread_nolock, Opt_dioread_lock,
> >       Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> >       Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> > -     Opt_prefetch_block_bitmaps,
> > +     Opt_prefetch_block_bitmaps, Opt_mb_optimize_scan,
> > #ifdef CONFIG_EXT4_DEBUG
> >       Opt_fc_debug_max_replay, Opt_fc_debug_force
> > #endif
> > @@ -1788,6 +1789,7 @@ static const match_table_t tokens =3D {
> >       {Opt_nombcache, "nombcache"},
> >       {Opt_nombcache, "no_mbcache"},  /* for backward compatibility */
> >       {Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
> > +     {Opt_mb_optimize_scan, "mb_optimize_scan"},
> >       {Opt_removed, "check=3Dnone"},    /* mount option from ext2/3 */
> >       {Opt_removed, "nocheck"},       /* mount option from ext2/3 */
> >       {Opt_removed, "reservation"},   /* mount option from ext2/3 */
> > @@ -2008,6 +2010,8 @@ static const struct mount_opts {
> >       {Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> >       {Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
> >        MOPT_SET},
> > +     {Opt_mb_optimize_scan, EXT4_MOUNT2_MB_OPTIMIZE_SCAN,
> > +      MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
> > #ifdef CONFIG_EXT4_DEBUG
> >       {Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
> >        MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
> > diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> > index 59ca9d73b42f..16b8a838f631 100644
> > --- a/fs/ext4/sysfs.c
> > +++ b/fs/ext4/sysfs.c
> > @@ -213,6 +213,7 @@ EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs=
);
> > EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> > EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> > EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
> > +EXT4_RW_ATTR_SBI_UI(mb_linear_limit, s_mb_linear_limit);
> > EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
> > EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> > EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.in=
terval);
> > @@ -260,6 +261,7 @@ static struct attribute *ext4_attrs[] =3D {
> >       ATTR_LIST(mb_stream_req),
> >       ATTR_LIST(mb_group_prealloc),
> >       ATTR_LIST(mb_max_inode_prealloc),
> > +     ATTR_LIST(mb_linear_limit),
> >       ATTR_LIST(max_writeback_mb_bump),
> >       ATTR_LIST(extent_max_zeroout_kb),
> >       ATTR_LIST(trigger_fs_error),
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
>
> Best regards,
> Artem Blagodarenko.
>
