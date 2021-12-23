Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3747DDD1
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 03:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345966AbhLWCor (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Dec 2021 21:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345963AbhLWCoq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Dec 2021 21:44:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48050C061401;
        Wed, 22 Dec 2021 18:44:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so15727814edd.8;
        Wed, 22 Dec 2021 18:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4jPq2pw+PTiHlL/hTZBeJotK5UYVBBCWawKPHqgffE=;
        b=n5LXwVC03oImLYI1xcsiWVbwWsq3qnn4rQzW55QNyXjs+y6kNg6lcjvH8O7DWIsXVW
         8rXu6BpNIYakkOiH0viNy6JFpLGI2qwGRm8OTdlvlNZOvhxTSZRHA9JdOnbss/DOoazn
         7dQbt8dfRRmVX93hjhSBcLCmC0EkVODUxJG1yEp0DXCjB8lf0pWnAVy+BDO20x5PYuMQ
         BOMj4peQVPKl2uzdepyQoNoZpL2S/Ko+KI/gP02p/Rhf6q65cdfD1eFX7JcxX1jakcaS
         tKBEUTpR0BqpEyf9clLtXhwUb+qrluzN/iReUoipDh64tkG7mo8Eedrt5rKK7WLRgUVS
         DMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4jPq2pw+PTiHlL/hTZBeJotK5UYVBBCWawKPHqgffE=;
        b=wYb/vM9fjUlBreIaBGaR5/YWucByB0nI8ScE0PQOb+KAtNp51vmHG4U9H+Mdiz/gRU
         w5mCNPEcHYxJ+BkEBbaG1ZbfF5oHm2uR/q/OtD86kHIf3BETTQxSF7kWOEL+xa/k7FAq
         gmfOgLCyroNMvGlGN9+RAGloESbJdByqJIVHH5+ZbnsQYo+GxWfD4M0INgU1DdBCGHLv
         x+/qnmPa9iARmKuCrMST5XMCVvne5H8p3YTH4PRAmNPdXDsBknXkYySPMn4/X8IyDaJk
         d7g4p73Q/ABknIFEzjheuzSoCuDhfene9/+E0BEj3lkYOi/J5LROhOwL5aXaOYKIlrW+
         dzEQ==
X-Gm-Message-State: AOAM530jEtYaLNhE/O3ujRH12Of/LI5/lxbivi9MG2U7OIHz451LEQ3D
        90yqalVYEubFJAprz489pFtMrYMw9x0b3iDVBfs=
X-Google-Smtp-Source: ABdhPJyFTkczcsccFrzxIAQdmRL7cKTyK2B9g272glowgs5lurtIekzTpvLZi5I/QOrnazJzjDoYITI0TP/frw9/0Uc=
X-Received: by 2002:a17:907:948d:: with SMTP id dm13mr416078ejc.607.1640227484776;
 Wed, 22 Dec 2021 18:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20211216080303.388139-1-yinxin.x@bytedance.com> <CAD+ocbzWryj6FnHR4naiBvNHN4WqyuGo_n-52J_42jpLVLeAew@mail.gmail.com>
In-Reply-To: <CAD+ocbzWryj6FnHR4naiBvNHN4WqyuGo_n-52J_42jpLVLeAew@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 22 Dec 2021 18:44:33 -0800
Message-ID: <CAD+ocbx=e14c1wwv7zpp2N7v=kSHPD=muBC37PcRrdUDqtDKCA@mail.gmail.com>
Subject: Re: [PATCH] ext4: call fallocate may cause process to hang when using
 fast commit
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Once the patch series "ext4 fast commit API cleanup" gets merged in
(https://patchwork.ozlabs.org/project/linux-ext4/list/?series=277672),
this patch won't be required anymore. So, I'll undo my review in favor
of merging the API cleanup patch series first.

- Harshad

On Fri, Dec 17, 2021 at 12:17 PM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Thanks for the patch Xin, it looks good to me. I think there are a few
> other places where we are not stopping the transaction before calling
> commit. I'm trying to find them out.
>
> Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> On Thu, Dec 16, 2021 at 12:04 AM Xin Yin <yinxin.x@bytedance.com> wrote:
> >
> > If open a file with O_SYNC, and call fallocate with mode=0.when using
> > fast commit, will cause the process to hang.
> >
> > During the fast_commit procedure, it will wait for inode update done.
> > call ext4_fc_stop_update() before ext4_fc_commit() to mark inode
> > complete update.
> >
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > ---
> >  fs/ext4/extents.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index 4108896d471b..92db33887b6c 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -4707,8 +4707,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >                 goto out;
> >
> >         if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
> > +               ext4_fc_stop_update(inode);
> >                 ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
> >                                         EXT4_I(inode)->i_sync_tid);
> > +               inode_unlock(inode);
> > +               trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
> > +               return ret;
> >         }
> >  out:
> >         inode_unlock(inode);
> > --
> > 2.20.1
> >
