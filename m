Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB8031A360
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhBLRQf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 12:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLRQe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Feb 2021 12:16:34 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70640C061574
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 09:15:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q10so578439edt.7
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QTxcX+6hnaJN+qYLxoPKxSbkvl/gM9yrwrh2Duaet+U=;
        b=ahCjFHui+cGXodF7Jc/VsE3SyfSJZA206plEKfZP1k8xAgOoDeezUUVcix7XkM3ieg
         6gxVbJRrOe1tySfbVaPJCCyPdQTMuFTBvfjop72P6j+X74+eGm8X+f7XTwFRt3r9egso
         ve7ApVP9qHJx4t8f3bY2JdetLe9sJHD69rVOKh6DomOeeK4IKV00X4yeKb3LqQiOmUNO
         aEW74vZsqusAblwtCF9TXOwLXRMxxnbvxlmsq4zGBtVfD01Y7keeyq+BpjyL2P2PsKUh
         QjSrP5GBcZGAQI8Eo7rtPd/uI/FWO/ByO81pONlUXdD5W54QZRC3ju6CfnZ8OjUiQkNg
         doyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QTxcX+6hnaJN+qYLxoPKxSbkvl/gM9yrwrh2Duaet+U=;
        b=ThxbxNM5TG4MvN1nmilOFfd98Hi6UL5papZVBlxJ4snnSD+U3CYBYz1Y4RWinahU6d
         KkqmL6RtHMuIvZ4VEo77q1qSNmUfwSskg0JCu8MCynQ2GIeFjWYE7wVxJJxLnYQHerUV
         FTIBlEcx4QYm3Tbm9L7XhL29Rho+g8NgJopKvRag1defUBHLkPCtdsXVpFihzGcrHSqL
         iErXuTPpvjsu72Gy8ad08ERSEbUA6YcaoZMKYh7MdXtqrkspvDYs/lqDyX32/FnWQW2r
         pqA8DbSpkpzNkYTa2CwoL75LrqFNkwevEioyNCah9ZqqEAEFt3BgvSOGicaiXb3dRa3G
         TZ/Q==
X-Gm-Message-State: AOAM530xbBoJ6TRqRSnLBWDbQuvZyRMdcgOqkfcQMb/FMsadG5Xb3yyq
        H7ITnviO81LCvqjpTrQIFUc0qkaImUKrn5TU1p8=
X-Google-Smtp-Source: ABdhPJymmySJ86vlx5MLxVoU2p056ySmHgVqsiYuHwuHf5kpbT0knJhyuuhUul08PxNj/Yrn6mwsBr1auTePM8hqUqQ=
X-Received: by 2002:aa7:c911:: with SMTP id b17mr4384254edt.382.1613150153097;
 Fri, 12 Feb 2021 09:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-3-harshadshirwadkar@gmail.com> <A86257DC-98BF-482B-ADBE-65B220E133E6@gmail.com>
In-Reply-To: <A86257DC-98BF-482B-ADBE-65B220E133E6@gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 12 Feb 2021 09:15:41 -0800
Message-ID: <CAD+ocbwsP+HzsN-Z7Kh3+w+CxseYJ9FjjYZH8UHcPspxOX8wjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ext4: add mballoc stats proc file
To:     =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>, sihara@ddn.com,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Artem for pointing that out. The reason I added
s_bal_groups_considered inside ext4_mb_good_group() was that, in the
next patches in the series, the new allocator structures call
ext4_mb_good_group() before to check if the group looked up using cr0
lists or cr 1 tree is good or not. Having this counter incremented in
ext4_mb_good_group() helps us measure the overhead of the new
structures too. I'd like to keep that. But you're right, even without
those optimizations, ext4_mb_good_group() gets called twice. Which
means, with these optimizations it will get called 3 times. So,
perhaps we can increment s_bal_groups_considered in
ext4_mb_good_group_nolock() as you mentioned, and then we can also
increment it in the following patches just before calling
ext4_mb_good_group(). I'll note that for the next version, thanks!

- Harshad

On Fri, Feb 12, 2021 at 8:52 AM =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=
=D1=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC
<artem.blagodarenko@gmail.com> wrote:
>
> Hello Harshad,
>
> Thanks for this great work. I am still testing these patches. Right now I=
 have noticed this flow -
> s_bal_groups_considered is counted twice. It is placed to ext4_mb_good_gr=
oup, that is called twice,
> one time from  ext4_mb_good_group_nolock and again from  ext4_mb_good_gro=
up_nolock.
> I=E2=80=99d rather put s_bal_groups_considered into the ext4_mb_good_grou=
p_nolock().
>
> Here is simple execution (on non-fragmented partition) with old counter l=
ocation
>
> [root@CO82 ~]# dd if=3D/dev/zero of=3D/mnt/file4 bs=3D2M count=3D2 conv=
=3Dfsync
> 2+0 records in
> 2+0 records out
> 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.0137407 s, 305 MB/s
> [root@CO82 ~]# cat /proc/fs/ext4/sda2/mb_stats
> mballoc:
>     reqs: 2
>     success: 1
>     groups_scanned: 2
>     groups_considered: 4
>     extents_scanned: 2
>         goal_hits: 0
>         2^n_hits: 2
>         breaks: 0
>         lost: 0
>     useless_c0_loops: 0
>     useless_c1_loops: 0
>     useless_c2_loops: 0
>     useless_c3_loops: 0
>     buddies_generated: 60/969
>     buddies_time_used: 9178136
>     preallocated: 5612
>     discarded: 0
> [root@CO82 ~]#
>
> And location that suggested
> [root@CO82 ~]# dd if=3D/dev/zero of=3D/mnt/file3 bs=3D2M count=3D2 conv=
=3Dfsync
> 2+0 records in
> 2+0 records out
> 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.0155074 s, 270 MB/s
> [root@CO82 ~]# cat /proc/fs/ext4/sda2/mb_stats
> mballoc:
>     reqs: 3
>     success: 2
>     groups_scanned: 2
>     groups_considered: 2
>     extents_scanned: 2
>         goal_hits: 1
>         2^n_hits: 2
>         breaks: 0
>         lost: 0
>     useless_c0_loops: 0
>     useless_c1_loops: 0
>     useless_c2_loops: 0
>     useless_c3_loops: 0
>     buddies_generated: 60/969
>     buddies_time_used: 2870959
>     preallocated: 5626
>     discarded: 0
> [root@CO82 ~]#
>
> Second looks more rational.
>
> Best regards,
> Artem Blagodarenko.
>
> > On 9 Feb 2021, at 23:28, Harshad Shirwadkar <harshadshirwadkar@gmail.co=
m> wrote:
> >
> > Add new stats for measuring the performance of mballoc. This patch is
> > forked from Artem Blagodarenko's work that can be found here:
> >
> > https://github.com/lustre/lustre-release/blob/master/ldiskfs/kernel_pat=
ches/patches/rhel8/ext4-simple-blockalloc.patch
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> > fs/ext4/ext4.h    |  4 ++++
> > fs/ext4/mballoc.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
> > fs/ext4/mballoc.h |  1 +
> > fs/ext4/sysfs.c   |  2 ++
> > 4 files changed, 57 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 6dd127942208..317b43420ecf 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1549,6 +1549,8 @@ struct ext4_sb_info {
> >       atomic_t s_bal_success; /* we found long enough chunks */
> >       atomic_t s_bal_allocated;       /* in blocks */
> >       atomic_t s_bal_ex_scanned;      /* total extents scanned */
> > +     atomic_t s_bal_groups_considered;       /* number of groups consi=
dered */
> > +     atomic_t s_bal_groups_scanned;  /* number of groups scanned */
> >       atomic_t s_bal_goals;   /* goal hits */
> >       atomic_t s_bal_breaks;  /* too long searches */
> >       atomic_t s_bal_2orders; /* 2^order hits */
> > @@ -1558,6 +1560,7 @@ struct ext4_sb_info {
> >       atomic_t s_mb_preallocated;
> >       atomic_t s_mb_discarded;
> >       atomic_t s_lock_busy;
> > +     atomic64_t s_bal_cX_failed[4];          /* cX loop didn't find bl=
ocks */
> >
> >       /* locality groups */
> >       struct ext4_locality_group __percpu *s_locality_groups;
> > @@ -2808,6 +2811,7 @@ int __init ext4_fc_init_dentry_cache(void);
> > extern const struct seq_operations ext4_mb_seq_groups_ops;
> > extern long ext4_mb_stats;
> > extern long ext4_mb_max_to_scan;
> > +extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
> > extern int ext4_mb_init(struct super_block *);
> > extern int ext4_mb_release(struct super_block *);
> > extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 07b78a3cc421..fffd0770e930 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -2083,6 +2083,7 @@ static bool ext4_mb_good_group(struct ext4_alloca=
tion_context *ac,
> >
> >       BUG_ON(cr < 0 || cr >=3D 4);
> >
> > +     ac->ac_groups_considered++;
> >       if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
> >               return false;
> >
> > @@ -2420,6 +2421,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_=
context *ac)
> >                       if (ac->ac_status !=3D AC_STATUS_CONTINUE)
> >                               break;
> >               }
> > +             /* Processed all groups and haven't found blocks */
> > +             if (sbi->s_mb_stats && i =3D=3D ngroups)
> > +                     atomic64_inc(&sbi->s_bal_cX_failed[cr]);
> >       }
> >
> >       if (ac->ac_b_ex.fe_len > 0 && ac->ac_status !=3D AC_STATUS_FOUND =
&&
> > @@ -2548,6 +2552,48 @@ const struct seq_operations ext4_mb_seq_groups_o=
ps =3D {
> >       .show   =3D ext4_mb_seq_groups_show,
> > };
> >
> > +int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
> > +{
> > +     struct super_block *sb =3D (struct super_block *)seq->private;
> > +     struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> > +
> > +     seq_puts(seq, "mballoc:\n");
> > +     if (!sbi->s_mb_stats) {
> > +             seq_puts(seq, "\tmb stats collection turned off.\n");
> > +             seq_puts(seq, "\tTo enable, please write \"1\" to sysfs f=
ile mb_stats.\n");
> > +             return 0;
> > +     }
> > +     seq_printf(seq, "\treqs: %u\n", atomic_read(&sbi->s_bal_reqs));
> > +     seq_printf(seq, "\tsuccess: %u\n", atomic_read(&sbi->s_bal_succes=
s));
> > +
> > +     seq_printf(seq, "\tgroups_scanned: %u\n",  atomic_read(&sbi->s_ba=
l_groups_scanned));
> > +     seq_printf(seq, "\tgroups_considered: %u\n",  atomic_read(&sbi->s=
_bal_groups_considered));
> > +     seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_ba=
l_ex_scanned));
> > +     seq_printf(seq, "\t\tgoal_hits: %u\n", atomic_read(&sbi->s_bal_go=
als));
> > +     seq_printf(seq, "\t\t2^n_hits: %u\n", atomic_read(&sbi->s_bal_2or=
ders));
> > +     seq_printf(seq, "\t\tbreaks: %u\n", atomic_read(&sbi->s_bal_break=
s));
> > +     seq_printf(seq, "\t\tlost: %u\n", atomic_read(&sbi->s_mb_lost_chu=
nks));
> > +
> > +     seq_printf(seq, "\tuseless_c0_loops: %llu\n",
> > +                (unsigned long long)atomic64_read(&sbi->s_bal_cX_faile=
d[0]));
> > +     seq_printf(seq, "\tuseless_c1_loops: %llu\n",
> > +                (unsigned long long)atomic64_read(&sbi->s_bal_cX_faile=
d[1]));
> > +     seq_printf(seq, "\tuseless_c2_loops: %llu\n",
> > +                (unsigned long long)atomic64_read(&sbi->s_bal_cX_faile=
d[2]));
> > +     seq_printf(seq, "\tuseless_c3_loops: %llu\n",
> > +                (unsigned long long)atomic64_read(&sbi->s_bal_cX_faile=
d[3]));
> > +     seq_printf(seq, "\tbuddies_generated: %u/%u\n",
> > +                atomic_read(&sbi->s_mb_buddies_generated),
> > +                ext4_get_groups_count(sb));
> > +     seq_printf(seq, "\tbuddies_time_used: %llu\n",
> > +                atomic64_read(&sbi->s_mb_generation_time));
> > +     seq_printf(seq, "\tpreallocated: %u\n",
> > +                atomic_read(&sbi->s_mb_preallocated));
> > +     seq_printf(seq, "\tdiscarded: %u\n",
> > +                atomic_read(&sbi->s_mb_discarded));
> > +     return 0;
> > +}
> > +
> > static struct kmem_cache *get_groupinfo_cache(int blocksize_bits)
> > {
> >       int cache_index =3D blocksize_bits - EXT4_MIN_BLOCK_LOG_SIZE;
> > @@ -2968,9 +3014,10 @@ int ext4_mb_release(struct super_block *sb)
> >                               atomic_read(&sbi->s_bal_reqs),
> >                               atomic_read(&sbi->s_bal_success));
> >               ext4_msg(sb, KERN_INFO,
> > -                   "mballoc: %u extents scanned, %u goal hits, "
> > +                   "mballoc: %u extents scanned, %u groups scanned, %u=
 goal hits, "
> >                               "%u 2^N hits, %u breaks, %u lost",
> >                               atomic_read(&sbi->s_bal_ex_scanned),
> > +                             atomic_read(&sbi->s_bal_groups_scanned),
> >                               atomic_read(&sbi->s_bal_goals),
> >                               atomic_read(&sbi->s_bal_2orders),
> >                               atomic_read(&sbi->s_bal_breaks),
> > @@ -3579,6 +3626,8 @@ static void ext4_mb_collect_stats(struct ext4_all=
ocation_context *ac)
> >               if (ac->ac_b_ex.fe_len >=3D ac->ac_o_ex.fe_len)
> >                       atomic_inc(&sbi->s_bal_success);
> >               atomic_add(ac->ac_found, &sbi->s_bal_ex_scanned);
> > +             atomic_add(ac->ac_groups_scanned, &sbi->s_bal_groups_scan=
ned);
> > +             atomic_add(ac->ac_groups_considered, &sbi->s_bal_groups_c=
onsidered);
> >               if (ac->ac_g_ex.fe_start =3D=3D ac->ac_b_ex.fe_start &&
> >                               ac->ac_g_ex.fe_group =3D=3D ac->ac_b_ex.f=
e_group)
> >                       atomic_inc(&sbi->s_bal_goals);
> > diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> > index e75b4749aa1c..7597330dbdf8 100644
> > --- a/fs/ext4/mballoc.h
> > +++ b/fs/ext4/mballoc.h
> > @@ -161,6 +161,7 @@ struct ext4_allocation_context {
> >       /* copy of the best found extent taken before preallocation effor=
ts */
> >       struct ext4_free_extent ac_f_ex;
> >
> > +     __u32 ac_groups_considered;
> >       __u16 ac_groups_scanned;
> >       __u16 ac_found;
> >       __u16 ac_tail;
> > diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> > index 4e27fe6ed3ae..752d1c261e2a 100644
> > --- a/fs/ext4/sysfs.c
> > +++ b/fs/ext4/sysfs.c
> > @@ -527,6 +527,8 @@ int ext4_register_sysfs(struct super_block *sb)
> >                                       ext4_fc_info_show, sb);
> >               proc_create_seq_data("mb_groups", S_IRUGO, sbi->s_proc,
> >                               &ext4_mb_seq_groups_ops, sb);
> > +             proc_create_single_data("mb_stats", 0444, sbi->s_proc,
> > +                             ext4_seq_mb_stats_show, sb);
> >       }
> >       return 0;
> > }
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
>
