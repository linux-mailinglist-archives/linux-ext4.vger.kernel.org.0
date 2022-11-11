Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4545E6265AD
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Nov 2022 00:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiKKXnE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Nov 2022 18:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiKKXnD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Nov 2022 18:43:03 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD41082929
        for <linux-ext4@vger.kernel.org>; Fri, 11 Nov 2022 15:43:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bj12so15790562ejb.13
        for <linux-ext4@vger.kernel.org>; Fri, 11 Nov 2022 15:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxZ7NEhcX63L9xJbt2v7OnQeiJYF8h9UrKoAVgAtQVE=;
        b=T/5dI6wUDSuIlZd3tJljUW0B56wmgh8eLqbH0wsnfOlM1Qa6/mSJY5Loi7VkyAX/Lu
         hoQ2hx7Q4iDgMtj8pKL+T2YkUNsXNL5yLac6T0cP9P5kazMXiM7IPTOZHKkJHLJtmV1e
         w2T+/g2Ud3bviR3NQk0Hb47CvZozwiKmdcNavPqCof5NHfsKeRSjBezR6BXTMl835dCO
         4WjsUkbCtpNYgQWU0Z2C9y69kym7D8XwNoW5F1Diybpb3PeZpR2VvhwNrGkRlZHoNpmT
         D9r4xh0TZVzgi38+P18GxsxdUSSHROQgCUnld5h1GnSuEYkvuOvyjGSVZDexB6wpFcGM
         zCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxZ7NEhcX63L9xJbt2v7OnQeiJYF8h9UrKoAVgAtQVE=;
        b=r9RljeCb1a3mOlhRmaCf/t1e0WWy8z6Aco22Bjd/QATzztpLF6ns47DnYL/lHBT9nC
         dwzGGnS57+XIhPGsBivu/xoucazSz7gdLAhHvLFgyCVTrE/4WX9bBP6vl3paX/vaIdJK
         Too/yiX8+9U4KbWZ6+HtNDSd/q6x/8Vdqmyb19PUV52pcf/p6RtjaTDXnn/FghHbsdn2
         fYZa9YFCTNnqesSKzOhAao3ISxnnPcZtkyk9TK/xarQP7YX+QzcRq35ymkxzQ+4sIEVA
         YHX710mk6EUfOyM+q/4dQ+j8K7/pIoZsUJcLXjaeWqJGojEwr3W7EvpRVC4b8hzWz9gm
         7z4g==
X-Gm-Message-State: ANoB5pnCZfnBjNIMjDeOjc4yt0Kfc7/YP2a44Ygg/0XqwvV9+w4MdRzs
        gROxzvBBnbVLimcA11HdgAGmTdI0H2ixHUVof2omEL4j0T/Wzw==
X-Google-Smtp-Source: AA0mqf7FD+i0owEbvyJTGdOG51VsWYH7e3OF8mBSIAE2wXKJgSbUdtbscJ0ajbZ0rpraTsiiaYD0E2ntcLd0NA75B+U=
X-Received: by 2002:a17:907:11c7:b0:7ad:821f:a3e5 with SMTP id
 va7-20020a17090711c700b007ad821fa3e5mr3571046ejb.554.1668210181351; Fri, 11
 Nov 2022 15:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20221109153822.80250-1-sunjunchao2870@gmail.com>
 <Y2vqs7/Djy22B6XE@sol.localdomain> <CAHB1NaidN+FquNh2z-UXW8cycM-X5h+6T=XX=fEFyt2VkwXGvw@mail.gmail.com>
 <Y2xmRmGY7lfg/sbt@sol.localdomain>
In-Reply-To: <Y2xmRmGY7lfg/sbt@sol.localdomain>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Sat, 12 Nov 2022 07:42:49 +0800
Message-ID: <CAHB1NahjGJds+FU+JRL=YbB-6vo+H_1Gb5pn8G_wYzf+4-HPZw@mail.gmail.com>
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

Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=9B=9B 10:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 10, 2022 at 08:53:26AM +0800, JunChao Sun wrote:
> > Yeah, maybe we should remove the SLAB_RECLAIM_ACCOUNT flag for static
> > slab, and 16828088f9e51815 ("ext4: use KMEM_CACHE instead of
> > kmem_cache_create") have done so. But should we remove
> > SLAB_RECLAIM_ACCOUNT in this patch or belong to a separate patch?
>
> I'd just keep the slab flags the same in this patch.  If any flags do nee=
d to be
> changed, that should be a separate patch.
>
>
> > I think SLAB_RECLAIM_ACCOUNT is meant for for things that are directly
> > reclaimable, such as struct ext4_inode_info.  Inodes are evictable, and=
 when
> > that happens, the corresponding struct ext4_inode_info gets freed.
> >
> > bio_post_read_ctx_cache probably should use SLAB_TEMPORARY instead, sin=
ce it is
> > only used for temporary structures during I/O.
How to decide whether to use SLAB_RECLAIM_ACCOUNT or not when creating
a slab cache? Is it based on whether the object is reclaimable or
evictable, or the amount of memory the object may use? If the first,
how to know whether an object is reclaimable or evictable?
Btw, I saw that ext4 called ext4_es_register_shrinker() to register
shrinker for struct extent_status, so SLAB_RECLAIM_ACCOUNT should be
used when creating ext4_es_cachep, right?
>
> That being said, SLAB_TEMPORARY is currently #define'd to SLAB_RECLAIM_AC=
COUNT,
> so currently it makes no difference in practice...
>
> - Eric
