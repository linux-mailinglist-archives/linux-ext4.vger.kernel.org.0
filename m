Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C632DDC98
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Dec 2020 02:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgLRBOZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 20:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgLRBOZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 20:14:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08916C0617A7
        for <linux-ext4@vger.kernel.org>; Thu, 17 Dec 2020 17:13:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v14so666729wml.1
        for <linux-ext4@vger.kernel.org>; Thu, 17 Dec 2020 17:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxVq7ktOF8QY5ZNPkGkFxqSEvUCzsrwWqmuPLFI4HTE=;
        b=ZnjgjDf94p3zSOEsvyb1AQ+fLfhu0a5YoppuF34ecMrpmhHP05ka89Rg8DQlCfmhy7
         8cEgZf7ff+SS7KnMuKNd5WzEXAni0qaXxYPAyXiWcZhU37KW8+YOB3cCwNaUmIebfSlj
         n9LFm9+P5zkcOQgZxLEKrOjy7P8iKesBUk3huETgmmExfAiYoG0TPVG5kbLv8w7xXS4h
         GuqRhn5waywoO6psPtnihF/98TD3Q6o+DB8I3A5JZ9F6v8qBCrINkTekY/OMA1hTXI3o
         Rl9idj/P4QNBAV4CALbGoIizKrbki5nTWFzxe2i7AYyBnWtIpPS+WUcCI7W61jnKgwBg
         v8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxVq7ktOF8QY5ZNPkGkFxqSEvUCzsrwWqmuPLFI4HTE=;
        b=k8udlkMW4Echls9r9QlGPNomHeAoFsVImJCKozIFC/ndzaeB8KauKAp2RpRdg7kjwr
         WGRzWRhpKUVRtF2z/5nrgqSPto7sih9FXaVXhZNfEIVaQ7kK7kF4HLhbOzafGF4U6naa
         iHrGJ1gRkm/veusOQSccHcDVfEbtOavbPT0RNy3DfBUfpGA46oF23CKZVCiJf2Tl1cj8
         LgFal1Bm3Qvuys3vXa+Pr3ncVQFn+r42QEOgl7yy6v2BokZJauHB98pejus+8D9TdV56
         svGHd/m+o+3zvncsMbrG9DIiDxN/sX9oT1rh0L8Y/k8T9wLcQkCymozJhWiFSZcWwyIY
         B1+Q==
X-Gm-Message-State: AOAM531noRijr6WQy5QbhXGZur9nmdbQzEwnvk0pJvkFBSHg5vpTLTgl
        LwZLnuoqnPJ4xihJ6ofoOo9RWTaJ8ql5nub5F50=
X-Google-Smtp-Source: ABdhPJw9xUkaRaU2Qn7kU75iiItX0aMOetXJVTuHbkzgFy5ujo8xkJ3jLchCaoG6Co5RuSe0Cid13FHxWA49qixvPHQ=
X-Received: by 2002:a1c:f715:: with SMTP id v21mr1887234wmh.2.1608254023624;
 Thu, 17 Dec 2020 17:13:43 -0800 (PST)
MIME-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-3-saranyamohan@google.com> <20201217235638.GB6908@magnolia>
In-Reply-To: <20201217235638.GB6908@magnolia>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Fri, 18 Dec 2020 09:13:25 +0800
Message-ID: <CAP9B-QkipnMyxJ83WZd9Lhz2KDUh_6RMFnhzG8OoV_jJpqveYg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/61] e2fsck: copy context when using multi-thread fsck
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Saranya Muruganandam <saranyamohan@google.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 18, 2020 at 8:01 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, Nov 18, 2020 at 07:38:48AM -0800, Saranya Muruganandam wrote:
> > From: Li Xi <lixi@ddn.com>
> >
> > This patch only copy the context to a new one when -m is enabled.
> > It doesn't actually start any thread. When pass1 test finishes,
> > the new context is copied back to the original context.
> >
> > Since the signal handler only changes the original context, so
> > add global_ctx in "struct e2fsck_struct" and use that to check
> > whether there is any signal of canceling.
> >
> > This patch handles the long jump properly so that all the existing
> > tests can be passed even the context has been copied. Otherwise,
> > test f_expisize_ea_del would fail when aborting.
> >
> > Signed-off-by: Li Xi <lixi@ddn.com>
> > Signed-off-by: Wang Shilong <wshilong@ddn.com>
> > Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> > ---
> >  e2fsck/pass1.c | 114 +++++++++++++++++++++++++++++++++++++++++++++----
> >  e2fsck/unix.c  |   1 +
> >  2 files changed, 107 insertions(+), 8 deletions(-)
> >
> > diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> > index 8eecd958..64d237d3 100644
> > --- a/e2fsck/pass1.c
> > +++ b/e2fsck/pass1.c
> > @@ -1144,7 +1144,22 @@ static int quota_inum_is_reserved(ext2_filsys fs, ext2_ino_t ino)
> >       return 0;
> >  }
> >
> > -void e2fsck_pass1(e2fsck_t ctx)
> > +static int e2fsck_should_abort(e2fsck_t ctx)
> > +{
> > +     e2fsck_t global_ctx;
> > +
> > +     if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> > +             return 1;
> > +
> > +     if (ctx->global_ctx) {
> > +             global_ctx = ctx->global_ctx;
> > +             if (global_ctx->flags & E2F_FLAG_SIGNAL_MASK)
> > +                     return 1;
> > +     }
> > +     return 0;
> > +}
> > +
> > +void e2fsck_pass1_thread(e2fsck_t ctx)
> >  {
> >       int     i;
> >       __u64   max_sizes;
> > @@ -1360,7 +1375,7 @@ void e2fsck_pass1(e2fsck_t ctx)
> >               if (ino > ino_threshold)
> >                       pass1_readahead(ctx, &ra_group, &ino_threshold);
> >               ehandler_operation(old_op);
> > -             if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> > +             if (e2fsck_should_abort(ctx))
> >                       goto endit;
> >               if (pctx.errcode == EXT2_ET_BAD_BLOCK_IN_INODE_TABLE) {
> >                       /*
> > @@ -1955,7 +1970,7 @@ void e2fsck_pass1(e2fsck_t ctx)
> >               if (process_inode_count >= ctx->process_inode_size) {
> >                       process_inodes(ctx, block_buf);
> >
> > -                     if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> > +                     if (e2fsck_should_abort(ctx))
> >                               goto endit;
> >               }
> >       }
> > @@ -2068,6 +2083,89 @@ endit:
> >       else
> >               ctx->invalid_bitmaps++;
> >  }
> > +
> > +static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
> > +{
> > +     errcode_t       retval;
> > +     e2fsck_t        thread_context;
> > +
> > +     retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
>
> Hm, so I guess the strategy here is that parallel e2fsck makes
> per-thread copies of the ext2_filsys and e2fsck_t global contexts?
> And then after the threaded parts complete, each thread merges its
> per-thread contexts back into the global one, right?

Yes.

>
> This means that we have to be careful to track which fields in those
> cloned contexts have been updated by the thread so that we can copy them
> back and not lose any data.
>
> I'm wondering if for future maintainability it would be better to track
> the per-thread data in a separate structure to make it very explicit
> which data (sub)structures are effectively per-thread and hence don't
> require locking?

Maybe use a per-thread structure is better maintained, but i am not sure
we could remove locking completely.

Locking is mostly used for fix, because fixing is serialized now
and for some global structure which could be used seldomly
but could simplify codes.

>
> (I ask that mostly because I'm having a hard time figuring out which
> fields are supposed to be shared and which ones aren't...)
>
> --D
>
> > +     if (retval) {
> > +             com_err(global_ctx->program_name, retval, "while allocating memory");
