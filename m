Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C7E58EA7D
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Aug 2022 12:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiHJKfo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Aug 2022 06:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiHJKfn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Aug 2022 06:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 743C14C615
        for <linux-ext4@vger.kernel.org>; Wed, 10 Aug 2022 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660127741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/wW5w6mMxFEPRssRyiA0roiXaNoP3QA09rbvWBkLo18=;
        b=fB/2xKDNeknt8l6KG4A5hQ4/iPJ6RevPr+ItrkxP9aBpGGMLTv2yGUUCp9cGdcKqYKDoCa
        F/0sk0VhjvpKrcRsD3M+gNb6qfK0n3MnakihSlprEPIWDXU0/2RDRTypJqeWPEWp/lAHxE
        OWM1TOlwbdn4qEfhIRzNkpN5ylND2bw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-I3PpsSPNPouD4ZFlZTyBPQ-1; Wed, 10 Aug 2022 06:35:40 -0400
X-MC-Unique: I3PpsSPNPouD4ZFlZTyBPQ-1
Received: by mail-qk1-f199.google.com with SMTP id n15-20020a05620a294f00b006b5768a0ed0so12155251qkp.7
        for <linux-ext4@vger.kernel.org>; Wed, 10 Aug 2022 03:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=/wW5w6mMxFEPRssRyiA0roiXaNoP3QA09rbvWBkLo18=;
        b=HShI+THkCo87Rn2878KxQBsJuVTkN8srjNsmKqH/MA9J6mH3wPSWW8W8ma6tzJq38c
         EwAD+gwa1nZq66P7MCyKFETvv53xTErVvM9ftvGuIPin5ZobLQfRS+AynN0ca9yiR40w
         tOic6IhrwJvA76tgheNfFEzbBPxvo6e55nWwIRNk+7htUpWunonZm3QqAwoVFyQaTPyj
         sdEuy+eQ2Wp/0oQpyYaVpZOgDRqm2m7r7PXHPS874Lj9lPGCeSX+MdfHWXdq/a6ZINEt
         04+yOWXinD6yyAxM5UobDeZ/cFTDxlvR8aWWCL9HkRbcUO+KoqojuGxfLHCC6KGBOY3w
         o9xw==
X-Gm-Message-State: ACgBeo09atyPTtRe+AXiGypuERXJ9mekTLKsQroZ4+/RhA/lKQz215He
        X44QgBEB5/y5ag+Z69AQMngdsDF/ZlDCOrCgVraq1OHuq5jznxPlCFrSEE6Ezr3JBJu9HTTUhsJ
        PRuO6ubeIpARnzHz072RwRw==
X-Received: by 2002:ac8:5aca:0:b0:342:f363:dc83 with SMTP id d10-20020ac85aca000000b00342f363dc83mr14891982qtd.276.1660127739965;
        Wed, 10 Aug 2022 03:35:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR672faeSBWjEMIIZTWbRN8z5WtgsBmxV60lXj9OL/+FNIziCZkZnW+g14J0G5IqBz/QmzFDWQ==
X-Received: by 2002:ac8:5aca:0:b0:342:f363:dc83 with SMTP id d10-20020ac85aca000000b00342f363dc83mr14891967qtd.276.1660127739756;
        Wed, 10 Aug 2022 03:35:39 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id ci14-20020a05622a260e00b0031ef0081d77sm11753243qtb.79.2022.08.10.03.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 03:35:39 -0700 (PDT)
Message-ID: <a396a94d30132b157860c9e367f9a4354223f7f5.camel@redhat.com>
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
From:   Jeff Layton <jlayton@redhat.com>
To:     JunChao Sun <sunjunchao2870@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        lczerner@redhat.com, bxue@redhat.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Wed, 10 Aug 2022 06:35:38 -0400
In-Reply-To: <CAHB1Nah5ttUCuUUdPZjb9n_1uDTh_-J_N6JaJiwY+oZj7atJeg@mail.gmail.com>
References: <20220805183543.274352-1-jlayton@kernel.org>
         <20220805183543.274352-2-jlayton@kernel.org>
         <CAHB1Nah5ttUCuUUdPZjb9n_1uDTh_-J_N6JaJiwY+oZj7atJeg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 2022-08-10 at 11:00 +0800, JunChao Sun wrote:
> On Sat, Aug 6, 2022 at 2:37 AM Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > From: Jeff Layton <jlayton@redhat.com>
> >=20
> > Claim one of the spare fields in struct statx to hold a 64-bit change
> > >=20
> > > attribute. When statx requests this attribute, do an
> > > inode_query_iversion and fill the result in the field.
>=20
> I guess, is it better to update the corresponding part of the man-pages..=
.?

Yes. If we end up accepting a patch like this, we'll need to update the
statx(2) manpage. We'll probably also want to add support for it to the
/bin/stat coreutils command as well.

At this point, I'm trying to put together some xfstests so we can ensure
that this feature doesn't regress (if we take it).

> >=20
> >=20
> > Also update the test-statx.c program to fetch the change attribute as
> > well.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/stat.c                 | 7 +++++++
> >  include/linux/stat.h      | 1 +
> >  include/uapi/linux/stat.h | 3 ++-
> >  samples/vfs/test-statx.c  | 4 +++-
> >  4 files changed, 13 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 9ced8860e0f3..976e0a59ab23 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/compat.h>
> > +#include <linux/iversion.h>
> >=20
> >  #include <linux/uaccess.h>
> >  #include <asm/unistd.h>
> > @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, str=
uct kstat *stat,
> >         stat->attributes_mask |=3D (STATX_ATTR_AUTOMOUNT |
> >                                   STATX_ATTR_DAX);
> >=20
> > +       if ((request_mask & STATX_CHGATTR) && IS_I_VERSION(inode)) {
> > +               stat->result_mask |=3D STATX_CHGATTR;
> > +               stat->chgattr =3D inode_query_iversion(inode);
> > +       }
> > +
> >         mnt_userns =3D mnt_user_ns(path->mnt);
> >         if (inode->i_op->getattr)
> >                 return inode->i_op->getattr(mnt_userns, path, stat,
> > @@ -611,6 +617,7 @@ cp_statx(const struct kstat *stat, struct statx __u=
ser *buffer)
> >         tmp.stx_dev_major =3D MAJOR(stat->dev);
> >         tmp.stx_dev_minor =3D MINOR(stat->dev);
> >         tmp.stx_mnt_id =3D stat->mnt_id;
> > +       tmp.stx_chgattr =3D stat->chgattr;
> >=20
> >         return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
> >  }
> > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > index 7df06931f25d..4a17887472f6 100644
> > --- a/include/linux/stat.h
> > +++ b/include/linux/stat.h
> > @@ -50,6 +50,7 @@ struct kstat {
> >         struct timespec64 btime;                        /* File creatio=
n time */
> >         u64             blocks;
> >         u64             mnt_id;
> > +       u64             chgattr;
> >  };
> >=20
> >  #endif
> > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > index 1500a0f58041..b45243a0fbc5 100644
> > --- a/include/uapi/linux/stat.h
> > +++ b/include/uapi/linux/stat.h
> > @@ -124,7 +124,7 @@ struct statx {
> >         __u32   stx_dev_minor;
> >         /* 0x90 */
> >         __u64   stx_mnt_id;
> > -       __u64   __spare2;
> > +       __u64   stx_chgattr;    /* Inode change attribute */
> >         /* 0xa0 */
> >         __u64   __spare3[12];   /* Spare space for future expansion */
> >         /* 0x100 */
> > @@ -152,6 +152,7 @@ struct statx {
> >  #define STATX_BASIC_STATS      0x000007ffU     /* The stuff in the nor=
mal stat struct */
> >  #define STATX_BTIME            0x00000800U     /* Want/got stx_btime *=
/
> >  #define STATX_MNT_ID           0x00001000U     /* Got stx_mnt_id */
> > +#define STATX_CHGATTR          0x00002000U     /* Want/git stx_chgattr=
 */
> >=20
> >  #define STATX__RESERVED                0x80000000U     /* Reserved for=
 future struct statx expansion */
> >=20
> > diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
> > index 49c7a46cee07..767208d2f564 100644
> > --- a/samples/vfs/test-statx.c
> > +++ b/samples/vfs/test-statx.c
> > @@ -109,6 +109,8 @@ static void dump_statx(struct statx *stx)
> >                 printf(" Inode: %-11llu", (unsigned long long) stx->stx=
_ino);
> >         if (stx->stx_mask & STATX_NLINK)
> >                 printf(" Links: %-5u", stx->stx_nlink);
> > +       if (stx->stx_mask & STATX_CHGATTR)
> > +               printf(" Change Attr: 0x%llx", stx->stx_chgattr);
> >         if (stx->stx_mask & STATX_TYPE) {
> >                 switch (stx->stx_mode & S_IFMT) {
> >                 case S_IFBLK:
> > @@ -218,7 +220,7 @@ int main(int argc, char **argv)
> >         struct statx stx;
> >         int ret, raw =3D 0, atflag =3D AT_SYMLINK_NOFOLLOW;
> >=20
> > -       unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME;
> > +       unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME | STATX_C=
HGATTR;
> >=20
> >         for (argv++; *argv; argv++) {
> >                 if (strcmp(*argv, "-F") =3D=3D 0) {
> > --
> > 2.37.1
> >=20
>=20

--=20
Jeff Layton <jlayton@redhat.com>

