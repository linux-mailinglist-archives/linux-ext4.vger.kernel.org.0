Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D055D7B0
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jun 2022 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiF1Jxy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jun 2022 05:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344416AbiF1Jxi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Jun 2022 05:53:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0192ED6D
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 02:53:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j21so21368737lfe.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iKu/ouP1l0WbARS0G+oP+eMzUDW5MVCVwhdXx/QkrZc=;
        b=kk0vSjf+/xEJmKcjkeyzE9FxaulJk/PHGBC4+SSFW7YpwOLJ29+54pL232OQ7PlaKm
         2dV8tykYzm+BL+YCVLVatonMpp+dBwAtjLcyhkHHEeFgrIi0qelNlp9qbknE1EIRuLc2
         FCI6DpN3H88k/rVwtwLNkKLiR3j1PZ209KmZ9uHs+3XBNSIn2XrDriwq7a7qppX9kP1Q
         Qdc2w39o4JbzlYqu6LgB6Td8YEQ7n0Z/xm6QGk1g+nRNWfChd9kzHPj0v7msLTPWwLc3
         AVh8bcuen6iYfPQtdNv01MUQFqS/bAZTacqXN+gcJfojbMEkoFMro4WiO+NKfFMtewHr
         qgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iKu/ouP1l0WbARS0G+oP+eMzUDW5MVCVwhdXx/QkrZc=;
        b=SeusUj+sDAps4SiSmCVE4BPUOjdZQXN9cEptmoundy2pZOwA06CTtHfdobmkW8Z52x
         /s5jD1NPpifivR+xOyhlD9GA1VClGBlF3gu3Oy0SWB9R6V0fJ0hNBWWf918a6w96dHDO
         nI96/BCJ7A3gFHnTuWaQR5p3Ttrs0FCx//LHL7H7TmNuLRVoEpZsl3BaJIZDDL7uuITB
         PmMwS4bp9nU+w6iQaBL9NxGf3GRRcDLrq/dTRK26X8jTTzxieQxu/Zj8s1jzlYW3Q1od
         Pd64ZIG4MkAum2nksYjLAcfQ2SKZTKz6MfcWiC6PArIu2v8OZI57PeQ6KgL4a2Oz7pow
         i1Mg==
X-Gm-Message-State: AJIora9/HH01selJiUeU437VbYnprwKblAGmWXXizwABQoJnYuEUEy3l
        SuFB74ctK6UjqMX8Ox4MXXGGVXRehbmL9sBN3wTAUR61ucY=
X-Google-Smtp-Source: AGRyM1tyXmAbAsdw+IBFaG5vxaRqti957nE86sfQIwxV0nSYp+Kgu6uFZwapitpJ7v4ho9ZMJ0yiSXwVrF40HZLFldg=
X-Received: by 2002:a05:6512:3f12:b0:47f:51de:d067 with SMTP id
 y18-20020a0565123f1200b0047f51ded067mr11018202lfa.146.1656410013625; Tue, 28
 Jun 2022 02:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220628033446.285207-1-openglfreak@googlemail.com> <9b675cca-7ace-4f5f-a57b-ebddb091bf75@huawei.com>
In-Reply-To: <9b675cca-7ace-4f5f-a57b-ebddb091bf75@huawei.com>
From:   Torge Matthies <openglfreak@googlemail.com>
Date:   Tue, 28 Jun 2022 11:53:22 +0200
Message-ID: <CAKtYR9O9+dMdzid2s1uthKkv5x4bU9J3rbfe_YdGVsDtQFNh4g@mail.gmail.com>
Subject: Re: [PATCH] ext4: Read inlined symlink targets using ext4_readpage_inline.
To:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Yi,

On Tue, 28 Jun 2022 at 10:40, Zhang Yi <yi.zhang@huawei.com> wrote:
>
> Hi, Torge.
>
> On 2022/6/28 11:34, Torge Matthies wrote:
> > Instead of using ext4_bread/ext4_getblk.
> >
> > When I was trying out Linux 5.19-rc3 some symlinks became inaccessible to
> > me, with the error "Structure needs cleaning" and the following printed in
> > the kernel message log:
> >
> > EXT4-fs error (device nvme0n1p1): ext4_map_blocks:599: inode #7351350:
> > block 774843950: comm readlink: lblock 0 mapped to illegal pblock
> > 774843950 (length 1)
> >
> > It looks like the ext4_get_link function introduced in commit 6493792d3299
> > ("ext4: convert symlink external data block mapping to bdev") does not
> > handle links with inline data correctly. I added explicit handling for this
> > case using ext4_readpage_inline. This fixes the bug and the affected
> > symlinks become accessible again.
> >
> > Fixes: 6493792d3299 ("ext4: convert symlink external data block mapping to bdev")
> > Signed-off-by: Torge Matthies <openglfreak@googlemail.com>
>
> Thanks for the fix patch! I missed the inline_data case for the symlink inode
> in commit 6493792d3299.
>
> > ---
> >  fs/ext4/symlink.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
> > index d281f5bcc526..ec4fc2d23efc 100644
> > --- a/fs/ext4/symlink.c
> > +++ b/fs/ext4/symlink.c
> > @@ -19,7 +19,10 @@
> >   */
> >
> >  #include <linux/fs.h>
> > +#include <linux/gfp.h>
> > +#include <linux/mm.h>
> >  #include <linux/namei.h>
> > +#include <linux/pagemap.h>
> >  #include "ext4.h"
> >  #include "xattr.h"
> >
> > @@ -65,6 +68,37 @@ static int ext4_encrypted_symlink_getattr(struct user_namespace *mnt_userns,
> >       return fscrypt_symlink_getattr(path, stat);
> >  }
> >
> > +static void ext4_free_link_inline(void *folio)
> > +{
> > +     folio_unlock(folio);
> > +     folio_put(folio);
> > +}
> > +
> > +static const char *ext4_get_link_inline(struct inode *inode,
> > +                                     struct delayed_call *callback)
> > +{
> > +     struct folio *folio;
> > +     char *ret;
> > +     int err;
> > +
> > +     folio = folio_alloc(GFP_NOFS, 0)> +     if (!folio)
> > +             return ERR_PTR(-ENOMEM);
> > +     folio_lock(folio);
> > +     folio->index = 0;
> > +
> > +     err = ext4_readpage_inline(inode, &folio->page);
> > +     if (err) {
> > +             folio_put(folio);
> > +             return ERR_PTR(err);
> > +     }
> > +
>
> We need to handle the case of RCU walk in pick_link(), almost all above
> functions could sleep. The inline_data is a left over case, we cannot create
> new inline symlink now, maybe we can just disable the RCU walk for simple?
> or else we have to introduce some other no sleep helpers to get raw inode's
> cached buffer_head.

I'mma be honest, I don't know what most of that means, I barely managed
to scrape together this patch with the limited kernel knowledge I have.
If you know how to fix these things I'd prefer if you (or someone else)
could  send a proper fix in. Consider my first mail as just a bug
report, I was prepared to fix simple problems with my patch, but this
is out of my league.

> BTW, why not just open code by calling ext4_read_inline_data()? The folio
> conversion seems unnecessary.

This way I didn't have to export ext4_read_inline_data from its file.
Feel free to improve this.

-Torge

> Thanks,
> Yi.
>
> > +     set_delayed_call(callback, ext4_free_link_inline, folio);
> > +     ret = folio_address(folio);
> > +     nd_terminate_link(ret, inode->i_size, inode->i_sb->s_blocksize - 1);
> > +     return ret;
> > +}
> > +
> >  static void ext4_free_link(void *bh)
> >  {
> >       brelse(bh);
> > @@ -75,6 +109,9 @@ static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
> >  {
> >       struct buffer_head *bh;
> >
> > +     if (ext4_has_inline_data(inode))
> > +             return ext4_get_link_inline(inode, callback);
> > +
> >       if (!dentry) {
> >               bh = ext4_getblk(NULL, inode, 0, EXT4_GET_BLOCKS_CACHED_NOWAIT);
> >               if (IS_ERR(bh))
> >
