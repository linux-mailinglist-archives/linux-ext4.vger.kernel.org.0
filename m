Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0632D5BB4F9
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Sep 2022 02:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIQAZ6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 20:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIQAZ5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 20:25:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FF7BB6B1;
        Fri, 16 Sep 2022 17:25:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bj12so52782681ejb.13;
        Fri, 16 Sep 2022 17:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bv85PrfeqSiLdB0owbHCwQouOWeeWIQPgZptUWMQhCg=;
        b=HlcLKg4rqj3yNtjjTHhKVg2iJy1U8qek3tfv6askXxSLdy7sJM57Ctm6LS3SlcYHhk
         J3K4k4bRQM7oLaFFy49VYBaZZo49VK0VDlNaZ1fHMYZELZKD4BV9/+Urrl4sap4cPX1S
         8UhldSBL/6PNbsjY19ITune+lgoqS91EwA5l3+y2GB+FDzhNsyV8Tj1e2JV04pB6blCp
         x6xsRCYTApMlew5E0lbR3O1ImvJciBEaYu4lwaaK2FpQrq/TuK7BhdMzO2BZKIgxdqrO
         g/4zVqw1LMe226rnXt3r/uDacddBdkoDgeqQmu8IFbQvVr2CE0jd6cy29e2m516SoqZS
         nXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bv85PrfeqSiLdB0owbHCwQouOWeeWIQPgZptUWMQhCg=;
        b=4hUtNCMxX0zCVE6MifshE+67rJp7vvXSO5jP4HaH351w8Qv97M424VCmIGFVMeLvFZ
         2j9yZeSqEiZ9FkKFdc2ZuBSfQloiUehLml+Zz6aiHV7ZQGn3qb4AHBEXACgd/Y2Vmwq4
         Bs/L4K9qai586zyeqUs/qzouRiBYJkdBLRohld19K8Oh3PsSH37j66r4E6nvXj3+cOFo
         TKwn7HxpIrAw+n/9vcryGOkqXgWjCao91DfJX/a9nPvYH+hfAHnNcKJ4hYA3WmZn+mYn
         KyRBx83D6yU+n9mvBvDmpSBYB1kyCjMUwy8CyPn6PZpkTPod749Kj9gEkt4KvL/A7Zi8
         lfSQ==
X-Gm-Message-State: ACrzQf0fDJnqtjyuxpN/UBBE1wDQSxKVGU/oWHZzYSMW3/gzyJoe3wsf
        tjvE+ykoHoxFbj3dG2uaLTqFdsKnRgFB0iu44NI1F18Y
X-Google-Smtp-Source: AMsMyM6gHzwMnRY0VnZQGnZ9Yucsuo7A4PnjQjK7vhZlr2lKBtztDZreFYWcHRVAkiOsAPT0D3rCSvCDG1wM8PXgUmA=
X-Received: by 2002:a17:907:75e1:b0:73c:2333:7135 with SMTP id
 jz1-20020a17090775e100b0073c23337135mr4842111ejc.495.1663374354853; Fri, 16
 Sep 2022 17:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220909044727.2622256-1-floridsleeves@gmail.com> <Yxxe/X14BiltT352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
In-Reply-To: <Yxxe/X14BiltT352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Fri, 16 Sep 2022 17:25:44 -0700
Message-ID: <CAMEuxRqbLuVeC_daXjGEAVEBi9_ikSC=Bf2PFea_GeMtDvCEHw@mail.gmail.com>
Subject: Re: [PATCH v1] fs/ext4/xattr: check the return value of ext4_xattr_inode_dec_ref()
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 10, 2022 at 2:55 AM Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
>
> On Thu, Sep 08, 2022 at 09:47:27PM -0700, Li Zhong wrote:
> > Check the return value of ext4_xattr_inode_dec_ref(), which could return
> > error code and need to be warned.
> >
> > Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> > ---
> >  fs/ext4/xattr.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index 533216e80fa2..76141ed12bc2 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -1540,7 +1540,9 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
> >
> >       err = ext4_xattr_inode_write(handle, ea_inode, value, value_len);
> >       if (err) {
> > -             ext4_xattr_inode_dec_ref(handle, ea_inode);
> > +             err = ext4_xattr_inode_dec_ref(handle, ea_inode);
> Hey Li,
>
> My only concern here is in case ext4_xattr_inode_dec_ref() fails, we
> overwrite the err value and the actual err from ext4_xattr_inode_write()
> is lost.
>
> I feel the ext4_xattr_inode_write() error code would be more valuable
> for the calling function hence that is the one we should propogate.
> Maybe we can just print the warning without overwriting err?
>
Thanks for pointing this out! I'll fix it in v2 patch.
>
> Regards,
> Ojaswin
> > +             if (err)
> > +                     ext4_warning_inode(ea_inode, "cleanup dec ref error %d", err);
> >               iput(ea_inode);
> >               return err;
> >       }
> > --
> > 2.25.1
> >
