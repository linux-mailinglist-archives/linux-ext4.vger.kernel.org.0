Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE43B255DBE
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Aug 2020 17:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgH1PW3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 11:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgH1PW1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Aug 2020 11:22:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB8BC061264
        for <linux-ext4@vger.kernel.org>; Fri, 28 Aug 2020 08:22:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so2012115eje.7
        for <linux-ext4@vger.kernel.org>; Fri, 28 Aug 2020 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a6bmaykVcebQ/RblEgAnod+AY5dH3cUVVcg/iZ9Y8EE=;
        b=DWuQTkL8YfWbhszpZ0NQ9U1K8S/jzZm9wijxFCfBNJaSzcAbA6c3fxrCuk9DHvQsFv
         4QIo4vI6dBi3Z3g28FLse8IE+huMByfekQq9w8mgsfz/iJ9z5LezL3/eA+GWTj+brG55
         mwwn1mal69/7EqsOUFtdJfMPEiXDjhYI5PME/uUNVyOvGiKcci8kVwjzKOXD3mCuVM8e
         PF0NjUxCjDPfCRRK7/NIN2/UZj/vEU8P1H8nL7HalgS929Azc2HBf2SlkNcLZ77a0uAk
         g6Iu61Rt7NCH/ckEJ0dqzVjfQFXgo3MldntEp+HwZTjL6m/AGFtrYH7fBJhn6RRcoUw4
         +kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a6bmaykVcebQ/RblEgAnod+AY5dH3cUVVcg/iZ9Y8EE=;
        b=AsN/mJIAtMKIN84DpqGFTg7gcZt+af0dcG098fMLmW8QxZkGTr0Eizcq1kFgpBKK7p
         SB1n8Z8Vk77Law2irsYTIpYsPzD3NTSE5UqR+5jyUdifgAOsKl1QQzKCa67XxzFvqMn6
         bEyusEuVL3dUmZ+TbTf2mdkFeYTEQkRlpgIlyDuLx0qxADHbEFPIO9yYE3snTYsmEaVD
         e5Wg81xn35g9dm3MRQLbaAz46kWgku+XxjVVIXEksLKKNKuobGSG9GxB8bErsG8emKt5
         D5N9ktmm0z/qXebT7ZDTSsodCuOgmv6efD2DXtp3MfvkrQr4xcbkGVDuTPXxK/0Hm7lu
         okew==
X-Gm-Message-State: AOAM530T/srvVeP1HgY89zi7QOk5y2CrKaVTSAv9tbpp0n8Nl6lwwsTj
        D4mzOnyimAO663MZnXcs57PFmUOvmZg+2Wmk0rA=
X-Google-Smtp-Source: ABdhPJx4TRk2UFnRtn4KoLvCB2RlrsUGwe7B2F1dmxSINomxXY/Z3ZnXX+55fuYgC9l7CdOOveKVeQpdLNyoCcgDn1U=
X-Received: by 2002:a17:906:f957:: with SMTP id ld23mr2300744ejb.187.1598628143456;
 Fri, 28 Aug 2020 08:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
 <20200819073104.1141705-7-harshadshirwadkar@gmail.com> <F7D72C5D-4C26-4D93-A369-818C87FCF228@gmail.com>
In-Reply-To: <F7D72C5D-4C26-4D93-A369-818C87FCF228@gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 28 Aug 2020 08:22:12 -0700
Message-ID: <CAD+ocbwPsOLj16knR7Qu_4oLuvRsjthoH=KOG2Whdrof3e3jtg@mail.gmail.com>
Subject: Re: [PATCH 6/9] ext4: add memory usage tracker for freespace trees
To:     =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, lyx1209@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Artem for reviewing the patches.

On Fri, Aug 28, 2020 at 6:57 AM =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=
=D1=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC
<artem.blagodarenko@gmail.com> wrote:
>
> Hello Harshad,
>
> Thank you for these useful patches. I am still reviewing them. This one l=
ooks good for me, but one place looks strange. See bellow.
>
> > On 19 Aug 2020, at 10:31, Harshad Shirwadkar <harshadshirwadkar@gmail.c=
om> wrote:
> >
> > Freespace trees can occupy a lot of memory with as the fragmentation
> > increases. This patch adds a sysfs file to monitor the memory usage of
> > the freespace tree allocator. Also, added a sysfs config to control
> > maximum memory that the allocator can use. If the allocator exceeds
> > this threshold, file system enters "FRSP_MEM_CRUNCH" state. The next
> > patch in the series performs LRU eviction when this state is reached.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> > fs/ext4/ext4.h    |  8 ++++++++
> > fs/ext4/mballoc.c | 20 ++++++++++++++++++++
> > fs/ext4/mballoc.h |  4 ++++
> > fs/ext4/sysfs.c   | 11 +++++++++++
> > 4 files changed, 43 insertions(+)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 8cfe089ebea6..45fc3b230357 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1206,6 +1206,12 @@ struct ext4_inode_info {
> >                                                   * allocator off)
> >                                                   */
> >
> > +#define EXT4_MOUNT2_FRSP_MEM_CRUNCH  0x00000040 /*
> > +                                                 * Freespace tree allo=
cator
> > +                                                 * is in a tight memor=
y
> > +                                                 * situation.
> > +                                                 */
> > +
> > #define clear_opt(sb, opt)            EXT4_SB(sb)->s_mount_opt &=3D \
> >                                               ~EXT4_MOUNT_##opt
> > #define set_opt(sb, opt)              EXT4_SB(sb)->s_mount_opt |=3D \
> > @@ -1589,6 +1595,8 @@ struct ext4_sb_info {
> >       atomic_t s_mb_num_frsp_trees_cached;
> >       struct list_head s_mb_uncached_trees;
> >       u32 s_mb_frsp_cache_aggression;
> > +     atomic_t s_mb_num_fragments;
> > +     u32 s_mb_frsp_mem_limit;
> >
> >       /* workqueue for reserved extent conversions (buffered io) */
> >       struct workqueue_struct *rsv_conversion_wq;
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index fa027b626abe..aada6838cafd 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -869,6 +869,7 @@ void ext4_mb_frsp_print_tree_len(struct super_block=
 *sb,
> > static struct ext4_frsp_node *ext4_mb_frsp_alloc_node(struct super_bloc=
k *sb)
> > {
> >       struct ext4_frsp_node *node;
> > +     struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> >
> >       node =3D kmem_cache_alloc(ext4_freespace_node_cachep, GFP_NOFS);
> >       if (!node)
> > @@ -877,13 +878,31 @@ static struct ext4_frsp_node *ext4_mb_frsp_alloc_=
node(struct super_block *sb)
> >       RB_CLEAR_NODE(&node->frsp_node);
> >       RB_CLEAR_NODE(&node->frsp_len_node);
> >
> > +     atomic_inc(&sbi->s_mb_num_fragments);
> > +
> > +     if (sbi->s_mb_frsp_mem_limit &&
> > +             atomic_read(&sbi->s_mb_num_fragments) >
> > +             EXT4_FRSP_MEM_LIMIT_TO_NUM_NODES(sb))
> > +             set_opt2(sb, FRSP_MEM_CRUNCH);
> > +     else
> > +             clear_opt2(sb, FRSP_MEM_CRUNCH);
> > +
> > +
>
> Why FRSP_MEM_CRUNCH is cleared here? Are any cases when a node allocating=
 can reduce fragments numbers?
The reason why I have this here is to handle the case when the memory
limit gets updated by a sysfs tunable. So, once the sysfs tunable
tunable "mb_frsm_max_mem" was increased, then the next allocation
request would clear the MEM_CRUNCH flag. Without this, the FS would
evict a tree in LRU fashion (implemented in the next patch) which
shouldn't be necessary. Other option would be to update the MEM_CRUNCH
option right at the time when sysfs tunable is updated.
>
> >       return node;
> > }
> >
> > static void ext4_mb_frsp_free_node(struct super_block *sb,
> >               struct ext4_frsp_node *node)
> > {
> > +     struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> > +
> >       kmem_cache_free(ext4_freespace_node_cachep, node);
> > +     atomic_dec(&sbi->s_mb_num_fragments);
> > +
> > +     if (!sbi->s_mb_frsp_mem_limit ||
> > +             atomic_read(&sbi->s_mb_num_fragments) <
> > +             EXT4_FRSP_MEM_LIMIT_TO_NUM_NODES(sb))
> > +             clear_opt2(sb, FRSP_MEM_CRUNCH);
> > }
>
> If there are some reasons to clear FRSP_MEM_CRUNCH in ext4_mb_frsp_alloc_=
node, should we also set FRSP_MEM_CRUNCH here?
Thanks, I think we can do that. If the memory limit decreases, it'd be
good to set MEM_CRUNCH here. In my testing, I have found that
decreasing the memory limit to be very slow to take effect. Perhaps
this might be one of the reasons.

Thanks,
Harshad
>
> >
> > /* Evict a tree from memory */
> > @@ -1607,6 +1626,7 @@ int ext4_mb_init_freespace_trees(struct super_blo=
ck *sb)
> >       }
> >       rwlock_init(&sbi->s_mb_frsp_lock);
> >       atomic_set(&sbi->s_mb_num_frsp_trees_cached, 0);
> > +     atomic_set(&sbi->s_mb_num_fragments, 0);
> >
> >       return 0;
> > }
> > diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> > index ac65f7eac611..08cac358324d 100644
> > --- a/fs/ext4/mballoc.h
> > +++ b/fs/ext4/mballoc.h
> > @@ -88,6 +88,10 @@ struct ext4_frsp_node {
> >       struct rb_node frsp_node;
> >       struct rb_node frsp_len_node;
> > };
> > +
> > +#define EXT4_FRSP_MEM_LIMIT_TO_NUM_NODES(__sb)                        =
       \
> > +     ((sbi->s_mb_frsp_mem_limit / sizeof(struct ext4_frsp_node)))
> > +
> > struct ext4_free_data {
> >       /* this links the free block information from sb_info */
> >       struct list_head                efd_list;
> > diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> > index 31e0db726d21..d23cb51635c3 100644
> > --- a/fs/ext4/sysfs.c
> > +++ b/fs/ext4/sysfs.c
> > @@ -8,6 +8,7 @@
> >  *
> >  */
> >
> > +#include "mballoc.h"
> > #include <linux/time.h>
> > #include <linux/fs.h>
> > #include <linux/seq_file.h>
> > @@ -24,6 +25,7 @@ typedef enum {
> >       attr_session_write_kbytes,
> >       attr_lifetime_write_kbytes,
> >       attr_reserved_clusters,
> > +     attr_frsp_tree_usage,
> >       attr_inode_readahead,
> >       attr_trigger_test_error,
> >       attr_first_error_time,
> > @@ -205,6 +207,7 @@ EXT4_ATTR_FUNC(delayed_allocation_blocks, 0444);
> > EXT4_ATTR_FUNC(session_write_kbytes, 0444);
> > EXT4_ATTR_FUNC(lifetime_write_kbytes, 0444);
> > EXT4_ATTR_FUNC(reserved_clusters, 0644);
> > +EXT4_ATTR_FUNC(frsp_tree_usage, 0444);
> >
> > EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
> >                ext4_sb_info, s_inode_readahead_blks);
> > @@ -242,6 +245,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
> > EXT4_ATTR(journal_task, 0444, journal_task);
> > EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
> > EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
> > +EXT4_RW_ATTR_SBI_UI(mb_frsp_max_mem, s_mb_frsp_mem_limit);
> >
> > static unsigned int old_bump_val =3D 128;
> > EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> > @@ -251,6 +255,7 @@ static struct attribute *ext4_attrs[] =3D {
> >       ATTR_LIST(session_write_kbytes),
> >       ATTR_LIST(lifetime_write_kbytes),
> >       ATTR_LIST(reserved_clusters),
> > +     ATTR_LIST(frsp_tree_usage),
> >       ATTR_LIST(inode_readahead_blks),
> >       ATTR_LIST(inode_goal),
> >       ATTR_LIST(mb_stats),
> > @@ -287,6 +292,7 @@ static struct attribute *ext4_attrs[] =3D {
> > #endif
> >       ATTR_LIST(mb_prefetch),
> >       ATTR_LIST(mb_prefetch_limit),
> > +     ATTR_LIST(mb_frsp_max_mem),
> >       NULL,
> > };
> > ATTRIBUTE_GROUPS(ext4);
> > @@ -369,6 +375,11 @@ static ssize_t ext4_attr_show(struct kobject *kobj=
,
> >               return snprintf(buf, PAGE_SIZE, "%llu\n",
> >                               (unsigned long long)
> >                               atomic64_read(&sbi->s_resv_clusters));
> > +     case attr_frsp_tree_usage:
> > +             return snprintf(buf, PAGE_SIZE, "%llu\n",
> > +                             (unsigned long long)
> > +                             atomic_read(&sbi->s_mb_num_fragments) *
> > +                             sizeof(struct ext4_frsp_node));
> >       case attr_inode_readahead:
> >       case attr_pointer_ui:
> >               if (!ptr)
> > --
> > 2.28.0.220.ged08abb693-goog
> >
>
> Best regards,
> Artem Blagodarenko.
>
>
