Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3664C2E6B
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfJAHvb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:51:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40545 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbfJAHvb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:51:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id y39so10724637ota.7
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Srg4JOGn+asJMQx+sa1DferIgGtjxffvlXQRBP5U/dE=;
        b=PFV6uHu+Hoh3o52anpAdqIW8NeQpOeyE8lh8y+h8FyuJfCVIZrlKRJD3pp8T3X4gDP
         nZrCFWrWF0NHBw4uXWHNpNRvHoFzM2slQUpArixHB0CT2BZP3B411J9pifEYh8ZzLZ1v
         xnRRQfPkRsqk7WIS29rLPrVwBDOv1OETGMZHLcQX19ux4OUEom1ZVqNWqtDpD0nVKf0F
         gUFO9mgWFAUar8FIhxlZ/noYLuFpzc+xDsC21eR0YpQ2OFrEkDOcJVOlV7ET+2FAQas2
         ed1Y1R2v1M332OguWSGhAbWrgXIJEzlLoC3Qlw/oJkxP6+4ZEYLF3Qym0lIqNWNCdqac
         dAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Srg4JOGn+asJMQx+sa1DferIgGtjxffvlXQRBP5U/dE=;
        b=hgMGvcMzMelFfq0aCAfmO2M4pF5f7mSLSsO6CFlEpufODEMtPgCkSKHVJrtR0MZUNB
         MY+w6rM15y50GzC2Fbj7QczazR5+XbM7HCv2Vt/wgZHo3dEixrZc4rgoilWjZPwEcDoB
         46KUblB6Yy3n8pI460/a3g1az8dhCIgPEJnO3jMM6qJFMkx7b0GkRr6JCWc3eLeJziuj
         GrEUb0RR2EWPCMnv7Ys2rEiWUW5D0KjH8Ypg34KBslTdyKu6ppMOXzkYd9KV/iyKeRRT
         HtEtLalgiWmGPtcLN1zTWKCDdsFeKpMmn9Yb8SlM4vZxZt/erO6RKorhKJ1/xWB6iaZt
         KLYQ==
X-Gm-Message-State: APjAAAWcPooL75IiSydmnlQcCs6x9Kdt9OiEb+wS/xYcRH96/2kv6cwA
        gducf6WJ1iszhkxPYzBW6X+J1+Q+rsXLpwFnrxs=
X-Google-Smtp-Source: APXvYqwecTy/MDG5vH142+Aso9uEHAUK04w1sHDtGV/EfEHG4L4EhgG6ZeSOJfgjtmy1DWjSAc4GCDvBKTrVs1wV+dA=
X-Received: by 2002:a9d:7450:: with SMTP id p16mr16200058otk.141.1569916290523;
 Tue, 01 Oct 2019 00:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-9-harshadshirwadkar@gmail.com> <BC4620C8-1AC6-4543-BBE8-012067ED3CEA@dilger.ca>
In-Reply-To: <BC4620C8-1AC6-4543-BBE8-012067ED3CEA@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 1 Oct 2019 00:51:19 -0700
Message-ID: <CAD+ocbyP2WzNyEa5Pgpk3ViahuSNUQ2bSB_OEBOze4DdBiHNsw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] ext4: track changed files for fast commit
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, done in V3.

On Fri, Aug 9, 2019 at 2:46 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > For fast commit, we need to remember all the files that have changed
> > since last fast commit / full commit. For changes that are fast commit
> > incompatible, we mark the file system fast commit incompatible. This
> > patch adds code to either remember files that have changed or to mark
> > ext4 as fast commit ineligible. We inspect every ext4_mark_inode_dirty
> > calls and decide whether that particular file change is fast
> > compatible or not.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> Some minor code style cleanups.
>
> > @@ -759,6 +761,8 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
> >
> >       ext4_write_unlock_xattr(inode, &no_expand);
> >       brelse(iloc.bh);
> > +     ext4_fc_enqueue_inode(ext4_journal_current_handle(),
> > +                                        inode);
>
> (style) "inode" doesn't need to be split to a separate line
>
> >       mark_inode_dirty(inode);
> > out:
> >       return copied;
> > @@ -974,6 +978,8 @@ int ext4_da_write_inline_data_end(struct inode *inode, loff_t pos,
> >        * ordering of page lock and transaction start for journaling
> >        * filesystems.
> >        */
> > +     ext4_fc_enqueue_inode(ext4_journal_current_handle(),
> > +                                        inode);
>
> (style) "inode" doesn't need to be split to a separate line
>
> > @@ -5697,6 +5719,8 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
> >
> >       if (!error) {
> >               setattr_copy(inode, attr);
> > +             ext4_fc_enqueue_inode(ext4_journal_current_handle(),
> > +                                                inode);
>
> (style) "inode" doesn't need to be split to a separate line
>
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 0b833e9b61c1..c7bb52bdaf6e 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1129,6 +1129,16 @@ static void ext4_destroy_inode(struct inode *inode)
> >                               true);
> >               dump_stack();
> >       }
> > +     if (!list_empty(&(EXT4_I(inode)->i_fc_list))) {
> > +#ifdef EXT4FS_DEBUG
> > +             if (EXT4_SB(inode->i_sb)->s_fc_eligible) {
> > +                     pr_warn("%s: INODE %ld in FC List with FC allowd",
> > +                             __func__, inode->i_ino);
>
> (style) this should use ext4fs_debug(), since pr_warn() is not really
> used in the ext4 code
>
> > +                     dump_stack();
> > +             }
> > +#endif
> > +             ext4_fc_del(inode);
> > +     }
> > }
>
>
> Cheers, Andreas
>
>
>
>
>
