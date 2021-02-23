Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24A322FC2
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 18:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhBWRlf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Feb 2021 12:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhBWRle (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Feb 2021 12:41:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19734C061574
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:40:54 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id k13so33977747ejs.10
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BaWhqrPlnWJXq/C2BtwiadbxH50QvVQRwNkj439P/6c=;
        b=GMF1JFoiSExkyEcvlN/1HBK7VdH6Fy+8fXUzHHym0SORi78YUnJM/K2P9noY8R9HNV
         jlGPVkhBZjkFpPl34viLDfm+M+5/RoNx6qt44+xif7jLvyjYgMxyOk3JM+JP1GcYPesQ
         Yuavdzd12iHDWMQflAO53fHxTB+2PqD+EKecXQt0JiGMpVxAtKP7BOka9sCOKkl8/Sxo
         yXM+OG4TshjFXWgpy4RIq6Acphe70XhKkrCy2w5B/FdoSywH9XU42yrpOqF+NoM71d69
         kFKo8NGLMDmI4ePW+ocntCtrVYbUsZfRk1vUQS0J/WS2nHNksKS5VC66XE3wewLkhTiM
         JLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BaWhqrPlnWJXq/C2BtwiadbxH50QvVQRwNkj439P/6c=;
        b=kKZRETKoAf9GuFzJXG8DmAg+atSJhfMygKpzalNhW4uMRWlQy7PIEjC6wACuTg70hm
         oVfo+tZSxJg0qXnFyEKWOCRWcaX9e+rSBcn4jWXmYVhb4Ha9CzxsofjmR6vmnhHA7SGH
         9jB3z2ruVH5opwHFUPulw0QCFVuyjhzAjUP+F2rivrus3S9ykDU9ZjP4sDUT28TGUI5X
         DQzTeFFyvG8xIAWhZqDObr1YHwCdFFhI9RlGfkVPNenpl2xHa2I95L9H5QtuCXk/bQTG
         BQHCNOkxAc6tF0cblF7Oe0cPRWrIroOVQQjjAGyYeRH8Fw0e6+WuN/pYrgm6aNSCye0r
         I/KQ==
X-Gm-Message-State: AOAM531VKnj7PEuq7Vsr1MltWJa4ToCk5LENhq75wTbJjc+RabhsAQxh
        t2U1V9mFiCTx0pjYnEo9oKRxD0kVn9G1Ycb8L/DBPkuqVtE=
X-Google-Smtp-Source: ABdhPJz1pN5hYMRcauXvYGToQrixlpFuBUqSD6N1tiRI2RrxOkP94RZTlJQ7w9hmoC7Pl3jMmIsWZfumskUKVzQhcEk=
X-Received: by 2002:a17:907:9483:: with SMTP id dm3mr27034787ejc.120.1614102052771;
 Tue, 23 Feb 2021 09:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20210219210333.1439525-1-harshads@google.com> <CAADEDFF-59C9-411A-93F3-BE1AEBE1CE39@gmail.com>
In-Reply-To: <CAADEDFF-59C9-411A-93F3-BE1AEBE1CE39@gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 23 Feb 2021 09:40:41 -0800
Message-ID: <CAD+ocbzJRWg+iErcTmNhfsLiVPCs9dno6mWOE+1f7ekaCFs7LA@mail.gmail.com>
Subject: Re: [PATCH 1/4] e2fsck: don't ignore return values in e2fsck_rewrite_extent_tree
To:     =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Artem, will fix this in V2.

- Harshad

On Sat, Feb 20, 2021 at 12:58 AM =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=
=D1=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC
<artem.blagodarenko@gmail.com> wrote:
>
> Hello Harshad,
>
> ext2fs_iblk_set in the same e2fsck_rewrite_extent_tee returns a return co=
de, but code is ignored.
> Could you also add check there?
>
> Best regards,
> Artem Blagodarenko
>
> > On 20 Feb 2021, at 00:03, Harshad Shirwadkar <harshadshirwadkar@gmail.c=
om> wrote:
> >
> > From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > Don't ignore return values of ext2fs_read/write_inode_full() in
> > e2fsck_rewrite_extent_tree.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> > e2fsck/extents.c | 12 ++++++------
> > 1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/e2fsck/extents.c b/e2fsck/extents.c
> > index 600dbc97..f48f14ff 100644
> > --- a/e2fsck/extents.c
> > +++ b/e2fsck/extents.c
> > @@ -290,8 +290,10 @@ errcode_t e2fsck_rewrite_extent_tree(e2fsck_t ctx,=
 struct extent_list *list)
> >       errcode_t err;
> >
> >       memset(&inode, 0, sizeof(inode));
> > -     ext2fs_read_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
> > -                             sizeof(inode));
> > +     err =3D ext2fs_read_inode_full(ctx->fs, list->ino, EXT2_INODE(&in=
ode),
> > +                                  sizeof(inode));
> > +     if (err)
> > +             return err;
> >
> >       /* Skip deleted inodes and inline data files */
> >       if (inode.i_flags & EXT4_INLINE_DATA_FL)
> > @@ -306,10 +308,8 @@ errcode_t e2fsck_rewrite_extent_tree(e2fsck_t ctx,=
 struct extent_list *list)
> >       if (err)
> >               return err;
> >       ext2fs_iblk_set(ctx->fs, EXT2_INODE(&inode), blk_count);
> > -     ext2fs_write_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
> > -             sizeof(inode));
> > -
> > -     return 0;
> > +     return ext2fs_write_inode_full(ctx->fs, list->ino, EXT2_INODE(&in=
ode),
> > +                                    sizeof(inode));
> > }
> >
> > errcode_t e2fsck_read_extents(e2fsck_t ctx, struct extent_list *extents=
)
> > --
> > 2.30.0.617.g56c4b15f3c-goog
> >
>
