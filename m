Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422DB2C14E1
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 20:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgKWTzo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 14:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgKWTzn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 14:55:43 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC288C0613CF
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 11:55:41 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id o21so25048204ejb.3
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 11:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2DpbiQR09VFypr+YtLed/kgdlEXJxeKkk7Ms6zKLMc=;
        b=tcN3jdvoQrkgnFUslLnK1njbvoaN2w2xindNbCoirmnnrRQwzvQzjXlZzqGjy5+Iqk
         mn/060pP30TWPNzxcsx0zI2vXRJNhRXJJKXMYTqOcfEHFJGpgT0FycXF3YdXbc+LZ6Dr
         Hp4AFyRh6Pw72VFAxTFavv0FZMaMvW6AmbTVwpz08sb81P5DtDdKlc1sZ2lfrvKNUs9t
         e/BkbSAlyYIl16pcEiZAn+QEsDdL6SSu7LLjNOrSBjh1NaAXt5jj3D2M1lSdCcn12VSE
         o/1isB10MHZs06ISDmiKGBesYJN6p4tnUj/MjIYNm3GU8QQyQCcixnFVILgYUk0AeUuq
         IYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2DpbiQR09VFypr+YtLed/kgdlEXJxeKkk7Ms6zKLMc=;
        b=lfh5L/KJXoQT+6A51lCAvNVMSgvidcbjKkdm1LbkHLU0GxCXnbTGx8K0RbAsXjFZse
         0NBK/62jq38nl3L0DM0yXK/VFtUwAGmFr1q+66YrgAJ9zGxcNLsm1meQzBUHtE81eYlW
         qj6saSXsKzuB/K1qspNt2WpDE6uRO6pY3nT7engOAFw+EibwN3YA0ezoSZotAuw7Hx8j
         QpK826nJEwrUKVsSNxZicoK+ibze9lhSyd7i5+opTFT11hNbUA4W49uYwOCyFbaEV8sD
         0Q9fsrucO8N/UUAOcujKDBfEur9Cx0SEsb1kvI4oqDJoE/RNjU2Bxtaz8l1olqBYhX44
         7Iig==
X-Gm-Message-State: AOAM533D2ZOTWPpee+wpL+rQN2K7JWdpyoN+2lJc5uTSffNbiUY54OO1
        8n+KsD95vQIqganLv2LUcVzzx6+E+oKtn+Rn0gE=
X-Google-Smtp-Source: ABdhPJzxEoCx5yzX7nKcWxeiy6+KMjsnBK1pcp8j60ajvrTzxWqRFkFAvM30lnQ0181fiGvTStJ6yaIEXCKrEThQCEI=
X-Received: by 2002:a17:906:71d3:: with SMTP id i19mr1106913ejk.187.1606161340528;
 Mon, 23 Nov 2020 11:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com> <20201118153947.3394530-3-saranyamohan@google.com>
In-Reply-To: <20201118153947.3394530-3-saranyamohan@google.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 23 Nov 2020 11:55:29 -0800
Message-ID: <CAD+ocbziW_Rr90k0RWFZKQJ1czFPpoE5-0VAYvxevs6mU1sHFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/61] e2fsck: copy context when using multi-thread fsck
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the patch. I noticed that this patch doesn't compile. It's
because it needs "global_ctx" to be present in the e2fsck_struct but
it gets added later in the patch series in the patch 1e1b0216
("LU-8465 e2fsck: open io-channel when copying fs"). Given that this
and also a couple of other patches need global_ctx, should we split
1e1b0216 ("LU-8465 e2fsck: open io-channel when copying fs") should we
add global_ctx in this patch or as a separate patch before this?


On Wed, Nov 18, 2020 at 7:43 AM Saranya Muruganandam
<saranyamohan@google.com> wrote:
>
> From: Li Xi <lixi@ddn.com>
>
> This patch only copy the context to a new one when -m is enabled.
> It doesn't actually start any thread. When pass1 test finishes,
> the new context is copied back to the original context.
>
> Since the signal handler only changes the original context, so
> add global_ctx in "struct e2fsck_struct" and use that to check
> whether there is any signal of canceling.
>
> This patch handles the long jump properly so that all the existing
> tests can be passed even the context has been copied. Otherwise,
> test f_expisize_ea_del would fail when aborting.
>
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> ---
>  e2fsck/pass1.c | 114 +++++++++++++++++++++++++++++++++++++++++++++----
>  e2fsck/unix.c  |   1 +
>  2 files changed, 107 insertions(+), 8 deletions(-)
>
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index 8eecd958..64d237d3 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -1144,7 +1144,22 @@ static int quota_inum_is_reserved(ext2_filsys fs, ext2_ino_t ino)
>         return 0;
>  }
>
> -void e2fsck_pass1(e2fsck_t ctx)
> +static int e2fsck_should_abort(e2fsck_t ctx)
> +{
> +       e2fsck_t global_ctx;
> +
> +       if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +               return 1;
> +
> +       if (ctx->global_ctx) {
> +               global_ctx = ctx->global_ctx;
> +               if (global_ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +                       return 1;
> +       }
> +       return 0;
> +}
> +
> +void e2fsck_pass1_thread(e2fsck_t ctx)
>  {
>         int     i;
>         __u64   max_sizes;
> @@ -1360,7 +1375,7 @@ void e2fsck_pass1(e2fsck_t ctx)
>                 if (ino > ino_threshold)
>                         pass1_readahead(ctx, &ra_group, &ino_threshold);
>                 ehandler_operation(old_op);
> -               if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +               if (e2fsck_should_abort(ctx))
>                         goto endit;
>                 if (pctx.errcode == EXT2_ET_BAD_BLOCK_IN_INODE_TABLE) {
>                         /*
> @@ -1955,7 +1970,7 @@ void e2fsck_pass1(e2fsck_t ctx)
>                 if (process_inode_count >= ctx->process_inode_size) {
>                         process_inodes(ctx, block_buf);
>
> -                       if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +                       if (e2fsck_should_abort(ctx))
>                                 goto endit;
>                 }
>         }
> @@ -2068,6 +2083,89 @@ endit:
>         else
>                 ctx->invalid_bitmaps++;
>  }
> +
> +static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
> +{
> +       errcode_t       retval;
> +       e2fsck_t        thread_context;
> +
> +       retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
> +       if (retval) {
> +               com_err(global_ctx->program_name, retval, "while allocating memory");
> +               return retval;
> +       }
> +       memcpy(thread_context, global_ctx, sizeof(struct e2fsck_struct));
> +       thread_context->fs->priv_data = thread_context;
> +       thread_context->global_ctx = global_ctx;
> +
> +       *thread_ctx = thread_context;
> +       return 0;
> +}
> +
> +static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
> +{
> +       int     flags = global_ctx->flags;
> +#ifdef HAVE_SETJMP_H
> +       jmp_buf old_jmp;
> +
> +       memcpy(old_jmp, global_ctx->abort_loc, sizeof(jmp_buf));
> +#endif
> +       memcpy(global_ctx, thread_ctx, sizeof(struct e2fsck_struct));
> +#ifdef HAVE_SETJMP_H
> +       memcpy(global_ctx->abort_loc, old_jmp, sizeof(jmp_buf));
> +#endif
> +       /* Keep the global singal flags*/
> +       global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
> +                            (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
> +
> +       global_ctx->fs->priv_data = global_ctx;
> +       ext2fs_free_mem(&thread_ctx);
> +       return 0;
> +}
> +
> +void e2fsck_pass1_multithread(e2fsck_t ctx)
> +{
> +       errcode_t       retval;
> +       e2fsck_t        thread_ctx;
> +
> +       retval = e2fsck_pass1_thread_prepare(ctx, &thread_ctx);
> +       if (retval) {
> +               com_err(ctx->program_name, 0,
> +                       _("while preparing pass1 thread\n"));
> +               ctx->flags |= E2F_FLAG_ABORT;
> +               return;
> +       }
> +
> +#ifdef HAVE_SETJMP_H
> +       /*
> +        * When fatal_error() happens, jump to here. The thread
> +        * context's flags will be saved, but its abort_loc will
> +        * be overwritten by original jump buffer for the later
> +        * tests.
> +        */
> +       if (setjmp(thread_ctx->abort_loc)) {
> +               thread_ctx->flags &= ~E2F_FLAG_SETJMP_OK;
> +               e2fsck_pass1_thread_join(ctx, thread_ctx);
> +               return;
> +       }
> +       thread_ctx->flags |= E2F_FLAG_SETJMP_OK;
> +#endif
> +
> +       e2fsck_pass1_thread(thread_ctx);
> +       retval = e2fsck_pass1_thread_join(ctx, thread_ctx);
> +       if (retval) {
> +               com_err(ctx->program_name, 0,
> +                       _("while joining pass1 thread\n"));
> +               ctx->flags |= E2F_FLAG_ABORT;
> +               return;
> +       }
> +}
> +
> +void e2fsck_pass1(e2fsck_t ctx)
> +{
> +       e2fsck_pass1_multithread(ctx);
> +}
> +
>  #undef FINISH_INODE_LOOP
>
>  /*
> @@ -2130,7 +2228,7 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
>                 ehandler_operation(buf);
>                 check_blocks(ctx, &pctx, block_buf,
>                              &inodes_to_process[i].ea_ibody_quota);
> -               if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +               if (e2fsck_should_abort(ctx))
>                         break;
>         }
>         ctx->stashed_inode = old_stashed_inode;
> @@ -3300,7 +3398,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
>         inlinedata_fs = ext2fs_has_feature_inline_data(ctx->fs->super);
>
>         if (check_ext_attr(ctx, pctx, block_buf, &ea_block_quota)) {
> -               if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +               if (e2fsck_should_abort(ctx))
>                         goto out;
>                 pb.num_blocks += EXT2FS_B2C(ctx->fs, ea_block_quota.blocks);
>         }
> @@ -3355,7 +3453,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
>         }
>         end_problem_latch(ctx, PR_LATCH_BLOCK);
>         end_problem_latch(ctx, PR_LATCH_TOOBIG);
> -       if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +       if (e2fsck_should_abort(ctx))
>                 goto out;
>         if (pctx->errcode)
>                 fix_problem(ctx, PR_1_BLOCK_ITERATE, pctx);
> @@ -3836,7 +3934,7 @@ static int process_bad_block(ext2_filsys fs,
>                                 *block_nr = 0;
>                                 return BLOCK_CHANGED;
>                         }
> -                       if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +                       if (e2fsck_should_abort(ctx))
>                                 return BLOCK_ABORT;
>                 } else
>                         mark_block_used(ctx, blk);
> @@ -3933,7 +4031,7 @@ static int process_bad_block(ext2_filsys fs,
>                         *block_nr = 0;
>                         return BLOCK_CHANGED;
>                 }
> -               if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +               if (e2fsck_should_abort(ctx))
>                         return BLOCK_ABORT;
>                 return 0;
>         }
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index 051b31a5..42f616e2 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -1445,6 +1445,7 @@ int main (int argc, char *argv[])
>         }
>         reserve_stdio_fds();
>
> +       ctx->global_ctx = NULL;
>         set_up_logging(ctx);
>         if (ctx->logf) {
>                 int i;
> --
> 2.29.2.299.gdc1121823c-goog
>
