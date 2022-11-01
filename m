Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF3761471C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Nov 2022 10:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKAJrb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Nov 2022 05:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKAJra (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Nov 2022 05:47:30 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803E3DF74
        for <linux-ext4@vger.kernel.org>; Tue,  1 Nov 2022 02:47:28 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-369426664f9so130872857b3.12
        for <linux-ext4@vger.kernel.org>; Tue, 01 Nov 2022 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQK9cDcWduz/dLcwHXixCwGXujy6Ax6AFiKhQvUzS9U=;
        b=srKNisKzyuGIqetmi+mqbbm0HcwFlZ/5vA019zrv5puWhb5LKw10Ex84BT+kKmZ0p9
         9VlRxxC7uVDYO7DDet9zrP1v8cS0TiHZMZq3VfRiNrmipJbhW77dRRByrzCbtd76ZMA5
         udcrAYkcWwDoNPPKVPS+b1Vn8zPY0l7+WOWPxh93v0qej0+PnCfqaJwcnRP2sTAw9l1Q
         2n0e/kcR0rq0K/m6kgVUndfzaSD2knxm0y9z66Rgg7FJ78upYt8BkspRCIQ2/L6uZSDH
         8tKJ28XvUCxCDTtK3CzOz5p2mAravrMwfSMapdFYJje+Gg8jH/c0bnZCSEA9tc6+JoDV
         V63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQK9cDcWduz/dLcwHXixCwGXujy6Ax6AFiKhQvUzS9U=;
        b=QtLuIJFNGj+MjB+apqWYQ9/fSTKy6sGrN2uBMrCFJk/cUXXvAsQ7xsnLcMjyUTOdYd
         dR7Hg1qiDkuuW3JuQc7NEni3PUUCQ/nZWBEyLtGSCivKMXNEyWkjA/eTJlBFKHQBwwZ0
         mj1dqlvvjQ1Z07t0AlpocRYykoZRwMjGd+usnf7RBcUp7Mz91cwJ4nzJVfZxaHMyLWRA
         mWcau7lCcsP7qiJ6U/g/dl9T9V7UPzZ7PS0yjMxQ1zHUokLlbmbEjGt2yG4LyE1yAbtY
         idkneq+F/dKl9kK1PL09xyKdv9iTIZrdQAfQ1yVuaGu+49K099p/R035QWpXIDBN8sUC
         Rg8w==
X-Gm-Message-State: ACrzQf2GRwUVhB1ldkq/J6KqKrmaaapcF/xPcMIobC5cKGCxu3YtagOU
        dAqS7HRm8yB0fOxXjUsv/NhC5fVR9dSeLI8yfNBprD31rEh156+8
X-Google-Smtp-Source: AMsMyM4kW75qYAGWq6jJM1iWSqW5xr8AoF1JiLndCjKBJdX7RqjCy2s/1HBrElqogROD8qPQjFXm8n3tUruBGkla4S4=
X-Received: by 2002:a81:7051:0:b0:367:2bd4:bc4a with SMTP id
 l78-20020a817051000000b003672bd4bc4amr17010064ywc.517.1667296047704; Tue, 01
 Nov 2022 02:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221008120518.74870-1-changfengnan@bytedance.com>
In-Reply-To: <20221008120518.74870-1-changfengnan@bytedance.com>
From:   changfengnan <changfengnan@bytedance.com>
Date:   Tue, 1 Nov 2022 17:47:17 +0800
Message-ID: <CAPFOzZvJS36j5DxN19Tr-G5EER=jxB0gEez82TK6PV4Smj3-pA@mail.gmail.com>
Subject: Re: [PATCH] ext4: split ext4_journal_start trace for debug
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

friendly ping...

changfengnan <changfengnan@bytedance.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=88=
8=E6=97=A5=E5=91=A8=E5=85=AD 20:05=E5=86=99=E9=81=93=EF=BC=9A
>
> we might want to know why jbd2 thread using high io for detail,
> split ext4_journal_start trace to ext4_journal_start_sb and
> ext4_journal_start_inode, show ino and handle type when possible.
>
> Signed-off-by: changfengnan <changfengnan@bytedance.com>
> ---
>  fs/ext4/ext4_jbd2.c         | 14 ++++++---
>  fs/ext4/ext4_jbd2.h         | 10 +++----
>  fs/ext4/ialloc.c            |  4 +--
>  include/trace/events/ext4.h | 57 ++++++++++++++++++++++++++++++-------
>  4 files changed, 63 insertions(+), 22 deletions(-)
>
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 0fd0c42a4f7d..50651aad988b 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -86,15 +86,21 @@ static int ext4_journal_check_start(struct super_bloc=
k *sb)
>         return 0;
>  }
>
> -handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int l=
ine,
> +handle_t *__ext4_journal_start_sb(struct inode *inode,
> +                                 struct super_block *sb, unsigned int li=
ne,
>                                   int type, int blocks, int rsv_blocks,
>                                   int revoke_creds)
>  {
>         journal_t *journal;
>         int err;
> -
> -       trace_ext4_journal_start(sb, blocks, rsv_blocks, revoke_creds,
> -                                _RET_IP_);
> +       if (inode)
> +               trace_ext4_journal_start_inode(inode, blocks, rsv_blocks,
> +                                       revoke_creds, type,
> +                                       _RET_IP_);
> +       else
> +               trace_ext4_journal_start_sb(sb, blocks, rsv_blocks,
> +                                       revoke_creds, type,
> +                                       _RET_IP_);
>         err =3D ext4_journal_check_start(sb);
>         if (err < 0)
>                 return ERR_PTR(err);
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 00dc668e052b..5693f1edd63c 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -263,9 +263,9 @@ int __ext4_handle_dirty_super(const char *where, unsi=
gned int line,
>  #define ext4_handle_dirty_super(handle, sb) \
>         __ext4_handle_dirty_super(__func__, __LINE__, (handle), (sb))
>
> -handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int l=
ine,
> -                                 int type, int blocks, int rsv_blocks,
> -                                 int revoke_creds);
> +handle_t *__ext4_journal_start_sb(struct inode *inode, struct super_bloc=
k *sb,
> +                                 unsigned int line, int type, int blocks=
,
> +                                 int rsv_blocks, int revoke_creds);
>  int __ext4_journal_stop(const char *where, unsigned int line, handle_t *=
handle);
>
>  #define EXT4_NOJOURNAL_MAX_REF_COUNT ((unsigned long) 4096)
> @@ -305,7 +305,7 @@ static inline int ext4_trans_default_revoke_credits(s=
truct super_block *sb)
>  }
>
>  #define ext4_journal_start_sb(sb, type, nblocks)                       \
> -       __ext4_journal_start_sb((sb), __LINE__, (type), (nblocks), 0,   \
> +       __ext4_journal_start_sb(NULL, (sb), __LINE__, (type), (nblocks), =
0,\
>                                 ext4_trans_default_revoke_credits(sb))
>
>  #define ext4_journal_start(inode, type, nblocks)                       \
> @@ -325,7 +325,7 @@ static inline handle_t *__ext4_journal_start(struct i=
node *inode,
>                                              int blocks, int rsv_blocks,
>                                              int revoke_creds)
>  {
> -       return __ext4_journal_start_sb(inode->i_sb, line, type, blocks,
> +       return __ext4_journal_start_sb(inode, inode->i_sb, line, type, bl=
ocks,
>                                        rsv_blocks, revoke_creds);
>  }
>
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index b215c564bc31..5951899fd7ec 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1073,8 +1073,8 @@ struct inode *__ext4_new_inode(handle_t *handle, st=
ruct inode *dir,
>
>                 if ((!(sbi->s_mount_state & EXT4_FC_REPLAY)) && !handle) =
{
>                         BUG_ON(nblocks <=3D 0);
> -                       handle =3D __ext4_journal_start_sb(dir->i_sb, lin=
e_no,
> -                                handle_type, nblocks, 0,
> +                       handle =3D __ext4_journal_start_sb(NULL, dir->i_s=
b,
> +                                line_no, handle_type, nblocks, 0,
>                                  ext4_trans_default_revoke_credits(sb));
>                         if (IS_ERR(handle)) {
>                                 err =3D PTR_ERR(handle);
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index b14314fcf732..33e36c4c58e4 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -1795,18 +1795,19 @@ TRACE_EVENT(ext4_load_inode,
>                   (unsigned long) __entry->ino)
>  );
>
> -TRACE_EVENT(ext4_journal_start,
> +TRACE_EVENT(ext4_journal_start_sb,
>         TP_PROTO(struct super_block *sb, int blocks, int rsv_blocks,
> -                int revoke_creds, unsigned long IP),
> +                int revoke_creds, int type, unsigned long IP),
>
> -       TP_ARGS(sb, blocks, rsv_blocks, revoke_creds, IP),
> +       TP_ARGS(sb, blocks, rsv_blocks, revoke_creds, type, IP),
>
>         TP_STRUCT__entry(
> -               __field(        dev_t,  dev                     )
> -               __field(unsigned long,  ip                      )
> -               __field(          int,  blocks                  )
> -               __field(          int,  rsv_blocks              )
> -               __field(          int,  revoke_creds            )
> +               __field(        dev_t,          dev             )
> +               __field(        unsigned long,  ip              )
> +               __field(        int,            blocks          )
> +               __field(        int,            rsv_blocks      )
> +               __field(        int,            revoke_creds    )
> +               __field(        int,            type            )
>         ),
>
>         TP_fast_assign(
> @@ -1815,11 +1816,45 @@ TRACE_EVENT(ext4_journal_start,
>                 __entry->blocks          =3D blocks;
>                 __entry->rsv_blocks      =3D rsv_blocks;
>                 __entry->revoke_creds    =3D revoke_creds;
> +               __entry->type            =3D type;
> +       ),
> +
> +       TP_printk("dev %d,%d blocks %d, rsv_blocks %d, revoke_creds %d,"
> +                 " type %d, caller %pS", MAJOR(__entry->dev),
> +                 MINOR(__entry->dev), __entry->blocks, __entry->rsv_bloc=
ks,
> +                 __entry->revoke_creds, __entry->type, (void *)__entry->=
ip)
> +);
> +
> +TRACE_EVENT(ext4_journal_start_inode,
> +       TP_PROTO(struct inode *inode, int blocks, int rsv_blocks,
> +                int revoke_creds, int type, unsigned long IP),
> +
> +       TP_ARGS(inode, blocks, rsv_blocks, revoke_creds, type, IP),
> +
> +       TP_STRUCT__entry(
> +               __field(        unsigned long,  ino             )
> +               __field(        dev_t,          dev             )
> +               __field(        unsigned long,  ip              )
> +               __field(        int,            blocks          )
> +               __field(        int,            rsv_blocks      )
> +               __field(        int,            revoke_creds    )
> +               __field(        int,            type            )
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->dev             =3D inode->i_sb->s_dev;
> +               __entry->ip              =3D IP;
> +               __entry->blocks          =3D blocks;
> +               __entry->rsv_blocks      =3D rsv_blocks;
> +               __entry->revoke_creds    =3D revoke_creds;
> +               __entry->type            =3D type;
> +               __entry->ino             =3D inode->i_ino;
>         ),
>
> -       TP_printk("dev %d,%d blocks %d, rsv_blocks %d, revoke_creds %d, "
> -                 "caller %pS", MAJOR(__entry->dev), MINOR(__entry->dev),
> -                 __entry->blocks, __entry->rsv_blocks, __entry->revoke_c=
reds,
> +       TP_printk("dev %d,%d blocks %d, rsv_blocks %d, revoke_creds %d,"
> +                 " type %d, ino %lu, caller %pS", MAJOR(__entry->dev),
> +                 MINOR(__entry->dev), __entry->blocks, __entry->rsv_bloc=
ks,
> +                 __entry->revoke_creds, __entry->type, __entry->ino,
>                   (void *)__entry->ip)
>  );
>
> --
> 2.32.1 (Apple Git-133)
>
