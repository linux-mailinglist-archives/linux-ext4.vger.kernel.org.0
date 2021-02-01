Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20EE30B3A3
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 00:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhBAXiu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 18:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBAXis (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 18:38:48 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E4BC061573
        for <linux-ext4@vger.kernel.org>; Mon,  1 Feb 2021 15:38:08 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id sa23so10792714ejb.0
        for <linux-ext4@vger.kernel.org>; Mon, 01 Feb 2021 15:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=seh19/fDPQIb+UD6hs/+gM4GGQ9L+AqRZxlW0219j8k=;
        b=HZfW8RR5Y/YAuxzjw4yBGJYG33CgQGtK6kXB1CPQMWoweTVSG6CtNwacFqPguWxgbd
         eNe1SGhzxUh+JC3Q/tq6bFoBdJsQY7U+vuwNzhZbCVBKRA8TiwQ6YjSIeAPbOv+4Exep
         gcayNebwSz9Mb7NCnCm2zpAFxM5xTkKexhhfmdjzfLjfmLoIRWeIPR/a7GTOYkj/Cb0g
         n0xUAKjdgxV/0GZikOZ2mwEfT+OERK3HmjH6IyiiE3tImc8UmQy7JqyYC8OtIX/Xc6P5
         kQoipMzW1q1GUotPRkr8vFXRX6BDEa5bYDk86nYKbCGpj5m6/NP70NmnxQP9aQN48eL3
         XKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=seh19/fDPQIb+UD6hs/+gM4GGQ9L+AqRZxlW0219j8k=;
        b=VMz9o7jToODYUIWmYZPhKwfAWUjpNZhr6uidOOOvO2LsWhTmrQxK38zRtrkOpTXyBi
         IH5RP3KbCFmbZtBZnMllVkgb2GYIQ0xgoOR/TJfY+KzqVr73rsKtrXHE5FuAm6UudhGG
         wIisWokZh+lq1cmOGTqE7CzcJXs8p0+H7c8R6TFjU/6EwkTbf4tQMxxJFr0wMUoAKCDN
         DNV7fK9U8vtschPFK/EuFLUgVWe6kTkn19fs+qHBbDPmjb9WFE00lOF9cxJs9LIWT/op
         mXKqvTqCy/F11Jz4KmDn8frUui8Gctynf0dgQ5weDfM6y8MwjVjPNFib7gfl3QR9K73h
         c5eQ==
X-Gm-Message-State: AOAM531qAWogDIq6CuYjruL/+hmqKyaP2AnRj/QJolxCH/ANONNJ7Oi1
        d6ZxjO9VBfuA5w+RmU2LzOvU2zNq+jzmbGak7Xn1qiylZD0=
X-Google-Smtp-Source: ABdhPJxfZ8O5Nnjd9obWs+doL2NYLf/JN9T2wvkYYRvXC8UkkD7xSm5nUm7YwvXHXWxQBhUI0d2Q8YQSnn+JYgvHWP8=
X-Received: by 2002:a17:906:a115:: with SMTP id t21mr19799609ejy.549.1612222686693;
 Mon, 01 Feb 2021 15:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
 <20210129222931.623008-5-harshadshirwadkar@gmail.com> <D99BC3ED-A31C-49A9-9EE0-F0BC75D78FAE@dilger.ca>
In-Reply-To: <D99BC3ED-A31C-49A9-9EE0-F0BC75D78FAE@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 1 Feb 2021 15:37:55 -0800
Message-ID: <CAD+ocbwaOeo_8Gruq7J+oL3p-A3Mahqwv1Jfe5mYakK9buvskg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ext4: add proc files to monitor new structures
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

I see. That makes sense. Also as you mentioned it would be good to
have a summary file that shows a summary of the structures. In fact,
looking at the contents of mb_groups and if we add a summary file, I
think we probably should just get rid of these verbose files.
mb_groups has information about largest free order and fragment size,
using which, we can reconstruct these data structures and we can then
verify the correctness using the summary file.

On Sat, Jan 30, 2021 at 2:58 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Jan 29, 2021, at 3:29 PM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > This patch adds a new file "mb_structs" which allows us to see the
> > largest free order lists and the serialized average fragment tree.
>
> It might make sense to split these two structs into separate files.
> On large filesystems, there will be millions of groups, so having
> to dump both structs to find out information about one or the other
> would be a lot of overhead.
>
> Also, while the "mb_groups" file can be large (one line per group)
> for millions of groups, the files added here may have millions of
> groups on the same line.  Text processing tools are used to dealing
> with many lines in a file, but are relatively poor at dealing with
> millions of characters on a single line...
>
> It would be good to have a "summary" file that dumps general info
> about these structs (e.g. the number of groups at each list order,
> depth of the rbtree).  That could be maintained easily for the c0
> lists at least, since the list is locked whenever a group is added
> and removed.
>
> In Artem's patch to improve mballoc for large filesystems (which
> didn't land, but was useful anyway), there was an "mb_alloc_stats"
> file added:
>
> https://github.com/lustre/lustre-release/blob/master/ldiskfs/kernel_patches/patches/rhel8/ext4-simple-blockalloc.patch#L102
>
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:mballoc:
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   blocks: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   reqs: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   success: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   extents_scanned: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:           goal_hits: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:           2^n_hits: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:           breaks: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:           lost: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   useless_c1_loops: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   useless_c2_loops: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   useless_c3_loops: 163
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   skipped_c1_loops: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   skipped_c2_loops: 1230
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   skipped_c3_loops: 0
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   buddies_generated: 6305
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   buddies_time_used: 20165523
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   preallocated: 9943702
> /proc/fs/ldiskfs/dm-2/mb_alloc_stats:   discarded: 10506
>
> that would still be useful to maintain, since only a few of the lines
> are specific to his patch ({useless,skipped}_c[123]_loops)
I agree, this is very useful to have! it gives us a way to benchmark
efficiency of mballoc. I'll add mb_alloc_stats here.

Thanks,
Harshad
>
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> > fs/ext4/ext4.h    |  1 +
> > fs/ext4/mballoc.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++
> > fs/ext4/sysfs.c   |  2 ++
> > 3 files changed, 82 insertions(+)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index da12a083bf52..835e304e3113 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -2809,6 +2809,7 @@ int __init ext4_fc_init_dentry_cache(void);
> >
> > /* mballoc.c */
> > extern const struct seq_operations ext4_mb_seq_groups_ops;
> > +extern const struct seq_operations ext4_mb_seq_structs_ops;
> > extern long ext4_mb_stats;
> > extern long ext4_mb_max_to_scan;
> > extern int ext4_mb_init(struct super_block *);
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 413259477b03..ec4656903bd4 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -2741,6 +2741,85 @@ const struct seq_operations ext4_mb_seq_groups_ops = {
> >       .show   = ext4_mb_seq_groups_show,
> > };
> >
> > +static void *ext4_mb_seq_structs_start(struct seq_file *seq, loff_t *pos)
> > +{
> > +     struct super_block *sb = PDE_DATA(file_inode(seq->file));
> > +     unsigned long position;
> > +
> > +     read_lock(&EXT4_SB(sb)->s_mb_rb_lock);
> > +
> > +     if (*pos < 0 || *pos >= MB_NUM_ORDERS(sb) + ext4_get_groups_count(sb))
> > +             return NULL;
> > +     position = *pos + 1;
> > +     return (void *) ((unsigned long) position);
> > +}
> > +
> > +static void *ext4_mb_seq_structs_next(struct seq_file *seq, void *v, loff_t *pos)
> > +{
> > +     struct super_block *sb = PDE_DATA(file_inode(seq->file));
> > +     unsigned long position;
> > +
> > +     ++*pos;
> > +     if (*pos < 0 || *pos >= MB_NUM_ORDERS(sb) + ext4_get_groups_count(sb))
> > +             return NULL;
> > +     position = *pos + 1;
> > +     return (void *) ((unsigned long) position);
> > +}
> > +
> > +static int ext4_mb_seq_structs_show(struct seq_file *seq, void *v)
> > +{
> > +     struct super_block *sb = PDE_DATA(file_inode(seq->file));
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +     unsigned long position = ((unsigned long) v);
> > +     struct ext4_group_info *grpinfo;
> > +     struct rb_node *n;
> > +     int i;
> > +
> > +     position--;
> > +
> > +     if (position >= MB_NUM_ORDERS(sb)) {
> > +             position -= MB_NUM_ORDERS(sb);
> > +             if (position == 0)
> > +                     seq_puts(seq, "Group, Avg Fragment Size\n");
> > +             n = rb_first(&sbi->s_mb_avg_fragment_size_root);
> > +             for (i = 0; n && i < position; i++)
> > +                     n = rb_next(n);
> > +             if (!n)
> > +                     return 0;
> > +             grpinfo = rb_entry(n, struct ext4_group_info, bb_avg_fragment_size_rb);
> > +             seq_printf(seq, "%d, %d\n",
> > +                        grpinfo->bb_group,
> > +                        grpinfo->bb_fragments ? grpinfo->bb_free / grpinfo->bb_fragments : 0);
> > +             return 0;
> > +     }
> > +
> > +     if (position == 0)
> > +             seq_puts(seq, "Largest Free Order Lists:\n");
> > +
> > +     seq_printf(seq, "[%ld]: ", position);
> > +     list_for_each_entry(grpinfo, &sbi->s_mb_largest_free_orders[position],
> > +                         bb_largest_free_order_node) {
> > +             seq_printf(seq, "%d ", grpinfo->bb_group);
> > +     }
> > +     seq_puts(seq, "\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static void ext4_mb_seq_structs_stop(struct seq_file *seq, void *v)
> > +{
> > +     struct super_block *sb = PDE_DATA(file_inode(seq->file));
> > +
> > +     read_unlock(&EXT4_SB(sb)->s_mb_rb_lock);
> > +}
> > +
> > +const struct seq_operations ext4_mb_seq_structs_ops = {
> > +     .start  = ext4_mb_seq_structs_start,
> > +     .next   = ext4_mb_seq_structs_next,
> > +     .stop   = ext4_mb_seq_structs_stop,
> > +     .show   = ext4_mb_seq_structs_show,
> > +};
> > +
> > static struct kmem_cache *get_groupinfo_cache(int blocksize_bits)
> > {
> >       int cache_index = blocksize_bits - EXT4_MIN_BLOCK_LOG_SIZE;
> > diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> > index 4e27fe6ed3ae..828d58b98310 100644
> > --- a/fs/ext4/sysfs.c
> > +++ b/fs/ext4/sysfs.c
> > @@ -527,6 +527,8 @@ int ext4_register_sysfs(struct super_block *sb)
> >                                       ext4_fc_info_show, sb);
> >               proc_create_seq_data("mb_groups", S_IRUGO, sbi->s_proc,
> >                               &ext4_mb_seq_groups_ops, sb);
> > +             proc_create_seq_data("mb_structs", 0444, sbi->s_proc,
> > +                             &ext4_mb_seq_structs_ops, sb);
> >       }
> >       return 0;
> > }
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
