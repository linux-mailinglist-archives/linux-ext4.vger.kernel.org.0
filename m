Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056FA2DDC9C
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Dec 2020 02:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgLRBUL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 20:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLRBUK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 20:20:10 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B819C0617A7
        for <linux-ext4@vger.kernel.org>; Thu, 17 Dec 2020 17:19:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id e25so753792wme.0
        for <linux-ext4@vger.kernel.org>; Thu, 17 Dec 2020 17:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwpXaXkp5WUZqnj5ud35y2XiGvD8v86AvgVy1vafhk0=;
        b=F4Zf8RovtfS37pFN6D9USrbLIw1f4nG+Ivhc1F0c6VjaPgl4w+SUf2JcxhdecguVNk
         mv7BA2PDuTn2xTFsdSk3DhwKE7X043OSnZfF5J9LcjhhqrSjK2DtpN4AWf0vcHIQ7pLf
         ka1dEVNkqqsbcH3OVAeRZBiGYcDjV/DPl0lTBlhDlzKtGf666ITQHBxqRotg460ug8hf
         FWjLvImVi0Tq8WBpvLRqpyQPDdXA5ZffPbCXHpBXE3erljXZWup9P7c+20e7lXFQqN1M
         SuNf6ooHSnRXOeBX7RfAK3BS01HNmQhLg3Od26giKZmgcIFKfP9k07MY8VpaEn1R0zR1
         GfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwpXaXkp5WUZqnj5ud35y2XiGvD8v86AvgVy1vafhk0=;
        b=GnqZRRb2DyMR6om62YNLRQNxFx8p9vvR3kdBwjynKDe5ZERMo3IUJSh/Be6HBxJAVb
         hddHvzxbQ1znl8tzx3xc3V3r8ylXcAOPyTYivfYpMISHUHoZ13cnbeMpMZKVbRA0IzQ8
         NqIkmssZP6MUg3Z+L4TL8FyCN7JChUgd7Xdziu+vW/3zJR1KUFmhzPZDFifhTRgijqyl
         a3MuD+LYeRMxyJrk6bdSvS+NKdXVcoR8yw0+wZ8Sw9SXmLMZnhe3nZUtiDSgphc9ChWf
         Ia5Bac/CwNLRq1SCp9RCaYQXaoZ5cBTn7ANEWQayDq72pGUZnh+sfsnSu35DFOhgxT3g
         QL5g==
X-Gm-Message-State: AOAM533BBkK5r6aar/51s8liWDdK1w5T1XPGf4epPpkNQG7PSP7KTxP9
        XUUiQUO5MdiFuizuInWzLUoCFsWgG8bOPw1phuyFZkcH
X-Google-Smtp-Source: ABdhPJy1ldT8mJeIpEWyve27cUPhPN5yPTYV2NidYwISltgeLUY5N/PNad9/Wt0sbhKY7JegHwhOCgs208I+9pcfXo4=
X-Received: by 2002:a1c:2783:: with SMTP id n125mr1842424wmn.74.1608254368848;
 Thu, 17 Dec 2020 17:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-32-saranyamohan@google.com> <20201218000515.GC6908@magnolia>
In-Reply-To: <20201218000515.GC6908@magnolia>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Fri, 18 Dec 2020 09:19:10 +0800
Message-ID: <CAP9B-Q=Tk7G2zgf3McVKJ9j_dM37e8OUHAcpef+K_QFpyEw8jQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 31/61] e2fsck: split and merge invalid bitmaps
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Saranya Muruganandam <saranyamohan@google.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 18, 2020 at 8:10 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, Nov 18, 2020 at 07:39:17AM -0800, Saranya Muruganandam wrote:
> > From: Wang Shilong <wshilong@ddn.com>
> >
> > Invalid bitmaps are splitted per thread, and we
> > should merge them after thread finish.
>
> For a large filesystem, would it make more sense to merge results
> periodically to reduce the peak memory consumption?  That might not be
> all that high of a peak though since the end merges could be deleting
> records from the per-thread data structure after each succesful
> insertion merge.

That could be possible optimization,  comparing to original memory
usage, pfsck did not increase memory usage too much, it just try
to add some extra structure overhead X number of threads.

And from our benchmarking on PiB filesystem, we saw similar
memory peak numbers for pfsck,  we might post them in
the changelog next time.

>
> --D
>
> > Signed-off-by: Wang Shilong <wshilong@ddn.com>
> > Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> > ---
> >  e2fsck/pass1.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >
> > diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> > index 49bdba21..29954e88 100644
> > --- a/e2fsck/pass1.c
> > +++ b/e2fsck/pass1.c
> > @@ -2379,6 +2379,62 @@ out:
> >       return retval;
> >  }
> >
> > +static void e2fsck_pass1_copy_invalid_bitmaps(e2fsck_t global_ctx,
> > +                                           e2fsck_t thread_ctx)
> > +{
> > +     dgrp_t i, j;
> > +     dgrp_t grp_start = thread_ctx->thread_info.et_group_start;
> > +     dgrp_t grp_end = thread_ctx->thread_info.et_group_end;
> > +     dgrp_t total = grp_end - grp_start;
> > +
> > +     thread_ctx->invalid_inode_bitmap_flag =
> > +                     e2fsck_allocate_memory(global_ctx, sizeof(int) * total,
> > +                                             "invalid_inode_bitmap");
> > +     thread_ctx->invalid_block_bitmap_flag =
> > +                     e2fsck_allocate_memory(global_ctx, sizeof(int) * total,
> > +                                            "invalid_block_bitmap");
> > +     thread_ctx->invalid_inode_table_flag =
> > +                     e2fsck_allocate_memory(global_ctx, sizeof(int) * total,
> > +                                            "invalid_inode_table");
> > +
> > +     memcpy(thread_ctx->invalid_block_bitmap_flag,
> > +            &global_ctx->invalid_block_bitmap_flag[grp_start],
> > +            total * sizeof(int));
> > +     memcpy(thread_ctx->invalid_inode_bitmap_flag,
> > +            &global_ctx->invalid_inode_bitmap_flag[grp_start],
> > +            total * sizeof(int));
> > +     memcpy(thread_ctx->invalid_inode_table_flag,
> > +            &global_ctx->invalid_inode_table_flag[grp_start],
> > +            total * sizeof(int));
> > +
> > +     thread_ctx->invalid_bitmaps = 0;
> > +     for (i = grp_start, j = 0; i < grp_end; i++, j++) {
> > +             if (thread_ctx->invalid_block_bitmap_flag[j])
> > +                     thread_ctx->invalid_bitmaps++;
> > +             if (thread_ctx->invalid_inode_bitmap_flag[j])
> > +                     thread_ctx->invalid_bitmaps++;
> > +             if (thread_ctx->invalid_inode_table_flag[j])
> > +                     thread_ctx->invalid_bitmaps++;
> > +     }
> > +}
> > +
> > +static void e2fsck_pass1_merge_invalid_bitmaps(e2fsck_t global_ctx,
> > +                                            e2fsck_t thread_ctx)
> > +{
> > +     dgrp_t i, j;
> > +     dgrp_t grp_start = thread_ctx->thread_info.et_group_start;
> > +     dgrp_t grp_end = thread_ctx->thread_info.et_group_end;
> > +     dgrp_t total = grp_end - grp_start;
> > +
> > +     memcpy(&global_ctx->invalid_block_bitmap_flag[grp_start],
> > +            thread_ctx->invalid_block_bitmap_flag, total * sizeof(int));
> > +     memcpy(&global_ctx->invalid_inode_bitmap_flag[grp_start],
> > +            thread_ctx->invalid_inode_bitmap_flag, total * sizeof(int));
> > +     memcpy(&global_ctx->invalid_inode_table_flag[grp_start],
> > +            thread_ctx->invalid_inode_table_flag, total * sizeof(int));
> > +     global_ctx->invalid_bitmaps += thread_ctx->invalid_bitmaps;
> > +}
> > +
> >  static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx,
> >                                            int thread_index, int num_threads)
> >  {
> > @@ -2455,6 +2511,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
> >               goto out_fs;
> >       }
> >       *thread_ctx = thread_context;
> > +     e2fsck_pass1_copy_invalid_bitmaps(global_ctx, thread_context);
> >       return 0;
> >  out_fs:
> >       ext2fs_free_mem(&thread_fs);
> > @@ -2589,6 +2646,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
> >       ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
> >       ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
> >       quota_ctx_t qctx = global_ctx->qctx;
> > +     int *invalid_block_bitmap_flag = global_ctx->invalid_block_bitmap_flag;
> > +     int *invalid_inode_bitmap_flag = global_ctx->invalid_inode_bitmap_flag;
> > +     int *invalid_inode_table_flag  = global_ctx->invalid_inode_table_flag;
> > +     int invalid_bitmaps = global_ctx->invalid_bitmaps;
> >
> >  #ifdef HAVE_SETJMP_H
> >       jmp_buf          old_jmp;
> > @@ -2667,6 +2728,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
> >                                             thread_ctx->qctx);
> >       if (retval)
> >               return retval;
> > +     global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
> > +     global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
> > +     global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
> > +     global_ctx->invalid_bitmaps = invalid_bitmaps;
> > +     e2fsck_pass1_merge_invalid_bitmaps(global_ctx, thread_ctx);
> >
> >       retval = e2fsck_pass1_merge_bitmap(global_fs,
> >                               &thread_ctx->inode_used_map,
> > @@ -2739,6 +2805,9 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
> >       if (thread_ctx->dirs_to_hash)
> >               ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
> >       quota_release_context(&thread_ctx->qctx);
> > +     ext2fs_free_mem(&thread_ctx->invalid_block_bitmap_flag);
> > +     ext2fs_free_mem(&thread_ctx->invalid_inode_bitmap_flag);
> > +     ext2fs_free_mem(&thread_ctx->invalid_inode_table_flag);
> >       ext2fs_free_mem(&thread_ctx);
> >
> >       return retval;
> > @@ -2752,6 +2821,8 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
> >       int                              i;
> >       struct e2fsck_thread_info       *pinfo;
> >
> > +     /* merge invalid bitmaps will recalculate it */
> > +     global_ctx->invalid_bitmaps = 0;
> >       for (i = 0; i < num_threads; i++) {
> >               pinfo = &infos[i];
> >
> > --
> > 2.29.2.299.gdc1121823c-goog
> >
