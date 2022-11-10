Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75D623A97
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 04:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiKJDoY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 22:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKJDoX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 22:44:23 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86242C77E
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 19:44:22 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id q9so2054013ejd.0
        for <linux-ext4@vger.kernel.org>; Wed, 09 Nov 2022 19:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8WZId2TSw8RaIvDs4tBpdJxhCKXLMLpxZx8dLOEdOc=;
        b=DvTzljAhZY8F7i11zs5ZdiEGjjq1vTow1ed31jnFHIvoZVCcKL6wL6TMJpf1sIvgNW
         yUEKLejvIUMUKT8hDVSFhSTy4wYbM2gNiKm+N3iYdShzLhAbEbCc2aUz5PFNbU5FTtmb
         lHpjjJwHZU7sXxgqjd3lXN9oEB+YeEmbTIemlfqL4MHYigDelRBeRHg7NEixHkwtINtj
         xjHW3Wivzyr9NPhw4pr+rJ6Y2E+xF6IbuMMVP5EUDKv2DdQxiOU0+/PDcjm/e4IHv5Z5
         o8IuFUB1nIY4Jr8j7NNRlx+5BnBdy5CTUK+23QEYrYWz00YOy0pNRGpebS5dn9TLeFqV
         XdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8WZId2TSw8RaIvDs4tBpdJxhCKXLMLpxZx8dLOEdOc=;
        b=Vtre3/AQas4qxUYtoVwv8BDGOpwxTdLdtP3Y0ulIhDLsxnKc4JfYMJg1VPIH9KBkfy
         MsE50ZoR6PJ+m/T5mzEf1Apb+rFJpZFFLaShh7EMMRLeu6jrmSnTP2NIh/WcJBJ6Xf4U
         rpLMu8XUyXz2/+zKyO/+BL/67dN9vez1M2z9tJusga3lvx0yepoZkeZ48yCpzJYgBfCC
         i2NzL1OP1PMiLvC0bzmbD305y+MAGk02EDChCMPsPxjhyo7WSbfnQYaQxzcBYKIU98fY
         dV80gPdAvV1HEVyJeGbM4JBUkpf3fQ9a+xeh2Zchqpba1piC0/WoJVXJtJeeNPo8YIDb
         DA8g==
X-Gm-Message-State: ACrzQf2HK57pQtvtBxls82Lg+//vNMrPJGUX5sBhG9AkQnpMYmkc38NX
        ToqjbxD/1lICdsYqgX8D0EyUHpu2JeFkbUOYyZDiKP3wvJ0qIw==
X-Google-Smtp-Source: AMsMyM4KdOvFy93aGZFfGOVZDwH0+BqC4qmWAmKfSL9xeIU7I9w1Aj0enoFg/qhJeucIo4gjJJPQ//iaBHUhsJ3EpSQ=
X-Received: by 2002:a17:907:2bd1:b0:7ae:41e1:cdfa with SMTP id
 gv17-20020a1709072bd100b007ae41e1cdfamr24937130ejc.618.1668051861059; Wed, 09
 Nov 2022 19:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20221109153822.80250-1-sunjunchao2870@gmail.com>
 <Y2vqs7/Djy22B6XE@sol.localdomain> <CAHB1NaidN+FquNh2z-UXW8cycM-X5h+6T=XX=fEFyt2VkwXGvw@mail.gmail.com>
 <Y2xmRmGY7lfg/sbt@sol.localdomain>
In-Reply-To: <Y2xmRmGY7lfg/sbt@sol.localdomain>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Thu, 10 Nov 2022 11:44:08 +0800
Message-ID: <CAHB1NagDSOcpf8kS-K--FDUySrikT6GaFKBneFkSx-D8uyhAgA@mail.gmail.com>
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
>
> > I'd just keep the slab flags the same in this patch.  If any flags do n=
eed to be
> > changed, that should be a separate patch.
> >
> > I think SLAB_RECLAIM_ACCOUNT is meant for for things that are directly
> > reclaimable, such as struct ext4_inode_info.  Inodes are evictable, and=
 when
> > that happens, the corresponding struct ext4_inode_info gets freed.
> >
> > bio_post_read_ctx_cache probably should use SLAB_TEMPORARY instead, sin=
ce it is
> > only used for temporary structures during I/O.
> >
> > That being said, SLAB_TEMPORARY is currently #define'd to SLAB_RECLAIM_=
ACCOUNT,
> > so currently it makes no difference in practice...

Thanks for clarifying. I will send a separate patch to remove
SLAB_RECLAIM_ACCOUNT.

>
> - Eric
