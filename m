Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6BF623870
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 01:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKJAxl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 19:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKJAxk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 19:53:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0706C10577
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 16:53:39 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m22so1188626eji.10
        for <linux-ext4@vger.kernel.org>; Wed, 09 Nov 2022 16:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYtXhWZHrD/qbmse2cMtjay8p2XmbwAaU+tbt2qCgho=;
        b=pX2+lLTHGwwXetbe4aP9KJl+l6vXmvY6sHdLVWR/MAQHQ6DT+ni/NDH075VbNbCVer
         13hmJEAndrM4germgohufpnugQQfMzNVKT40z6CLwWhWxh/WMaIOPbr1mD4Fr+M3O7W6
         pELH8SzMdwDTk7HEJIvmQPBrkCVWBZnOYw9xAv+xDZ9IVNROrh6Hnf4L030AziJ6JAkD
         bmp14lRhP6dsLOClpzcgJw09jG/kYM3D3R+bRxeOtYblT+s6cR+6SSxIYo1mHfHHzd8M
         fPxdBMjCryUOXBsav42IbGkMgmxajJYNFJXMZWs2eEPfzaC2rDaZtVni76vB21s+MbUP
         Izcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYtXhWZHrD/qbmse2cMtjay8p2XmbwAaU+tbt2qCgho=;
        b=Hglt8XVrJbd99q3KIbJdLunExhRjJhEWFtAt5ySCSxErhNtZZUMvtUhwvteFzSJi6A
         IDmX7H3c+EaDdeZMHdZwnRyWUv54J6EoT4W1DFgmUrzDdVImU+EqTZfzHD1gN/MZ9+5Y
         AQJ2JBCOX8XWHc7NPuv46/y3lKz5tCkhSiHBxg+88hWjMyRSlKOhwwc2YIi/DE+KUV70
         5rGHbIEN1GrTnrbGfw6y7ESRn4T5YZNKywmInzCmMEDSCP+V4OapQqJG3Xo/xVCgHMjg
         StVerq5+HHr1l3oKxBTpX807EjiG538JmITCKUvoWr3qhgfNVWsVuwHtj7PEVQ1QuGjI
         v+RA==
X-Gm-Message-State: ACrzQf1U88K1nMFejDAzFicJJ8b2Rxd44KHD49gicEGi1z7czxJH+P02
        HEyVwL0dCU62FkHtLoxGZxKGBHEZYB00D+mtsx074Lp8nYN1eA==
X-Google-Smtp-Source: AMsMyM5lEA4zHBBV60VbnlFuSR7MlpZtHSbOmYTMskvY/GZ0kP4ZM9hRUuMB/KZ3Sw1LuHlBunq5SWRDhawdau1KjPU=
X-Received: by 2002:a17:906:cf82:b0:7ae:100a:8dc0 with SMTP id
 um2-20020a170906cf8200b007ae100a8dc0mr1739182ejb.424.1668041617507; Wed, 09
 Nov 2022 16:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20221109153822.80250-1-sunjunchao2870@gmail.com> <Y2vqs7/Djy22B6XE@sol.localdomain>
In-Reply-To: <Y2vqs7/Djy22B6XE@sol.localdomain>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Thu, 10 Nov 2022 08:53:26 +0800
Message-ID: <CAHB1NaidN+FquNh2z-UXW8cycM-X5h+6T=XX=fEFyt2VkwXGvw@mail.gmail.com>
Subject: Re: [PATCH] ext4: replace kmem_cache_create with KMEM_CACHE
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Yeah, maybe we should remove the SLAB_RECLAIM_ACCOUNT flag for static
slab, and 16828088f9e51815 ("ext4: use KMEM_CACHE instead of
kmem_cache_create") have done so. But should we remove
SLAB_RECLAIM_ACCOUNT in this patch or belong to a separate patch?

Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=9B=9B 02:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Nov 09, 2022 at 07:38:22AM -0800, JunChao Sun wrote:
> > diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> > index 3d21eae267fc..773176e7f9f5 100644
> > --- a/fs/ext4/readpage.c
> > +++ b/fs/ext4/readpage.c
> > @@ -410,9 +410,8 @@ int ext4_mpage_readpages(struct inode *inode,
> >
> >  int __init ext4_init_post_read_processing(void)
> >  {
> > -     bio_post_read_ctx_cache =3D
> > -             kmem_cache_create("ext4_bio_post_read_ctx",
> > -                               sizeof(struct bio_post_read_ctx), 0, 0,=
 NULL);
> > +     bio_post_read_ctx_cache =3D KMEM_CACHE(bio_post_read_ctx, SLAB_RE=
CLAIM_ACCOUNT);
> > +
>
> Why use SLAB_RECLAIM_ACCOUNT here?
>
> - Eric
