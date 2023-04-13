Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031E86E040A
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Apr 2023 04:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDMCTP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 22:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDMCTP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 22:19:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D19184
        for <linux-ext4@vger.kernel.org>; Wed, 12 Apr 2023 19:19:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q23so24195933ejz.3
        for <linux-ext4@vger.kernel.org>; Wed, 12 Apr 2023 19:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681352352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No6030XYMGd/sB+PVl8RM2xeqN0GETQkBUls8NTi6oA=;
        b=nKSfB0iTWB3+FXph7n18GMEH8SJKIPvR93aG6qEQcRGFCxcShAKniYoy3MwNhiO/xp
         IAxt1tNNVeHuvNq3EMyoUl+n1qAZgh6/VfakaZK4Nyvdt9tT1AZKB3DBwXdx9QPddsX0
         v8SVX/iD8P7Y+KoB+dtR5Sy0XK96/giVrZW0WVgf/fQOkb5NJNINERBvtwYwmhiI5UNi
         l1eG9rWa71UkKdoZ/sUXT0DmoqPrSUpDaslSHbMKVVks+goMiNzigQCoYkiQL+2zUbqn
         kF1BmwSPGWz/0sEKOcUyXDU1dVVKGQWSaTbwOvYqXWrORQs1+SEhKpFxVBdxxwpaLECv
         o1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681352352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No6030XYMGd/sB+PVl8RM2xeqN0GETQkBUls8NTi6oA=;
        b=S5jWmy35sfQZzDNv9uMZw2KbnCp0EOItwHdX6retX8+wMlPwbCg4uzaCWwwbf9m3C8
         JAuMuQI9qAp0SV0g6ZAd5zn0RQ3bMIhlXfie2crbrgrgoEwVwD9KM2xspm4odfjDhdqY
         /kuYt6r9R3316uCvcU4TFDo+diPXgwaBNSKsSQynr4H3e7sIfU8M9yKo/wsOom1OZu+G
         2xoHnDUR77GtvQAxP0ygVeH+aUfuB4xifbRebtNYoNgQSaukTl/MB37RAwPIwHP3f2wh
         UDnbLwgYVaPZcZzaEIg0Nrgq5EdyxvUo/G9XKdzdqX3PNnqjmH3vIXOb2Zphx1FrYGAX
         NIRw==
X-Gm-Message-State: AAQBX9cca4j27yzzYP25YXtRVB7FufmmSJ+31KjHyZ9qzfr0mKL58iTl
        44MeSdYlAOgrQ5CJQ+8MiLMiEoo1wCECwhRZoY4=
X-Google-Smtp-Source: AKy350Zrszm5DQ6U0RBnWnbwnysU4y/lA5g4IJmum6D/hQ+7jo22KYE+sBGC+g3kUBFRR0jyLpkTMq7VjguWYgL9fqk=
X-Received: by 2002:a17:906:d057:b0:94a:98a1:75d3 with SMTP id
 bo23-20020a170906d05700b0094a98a175d3mr444626ejb.12.1681352352055; Wed, 12
 Apr 2023 19:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230412074737.5769-1-sunjunchao2870@gmail.com> <20230412104547.7uaqukrrhvxuy5xi@quack3>
In-Reply-To: <20230412104547.7uaqukrrhvxuy5xi@quack3>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Thu, 13 Apr 2023 10:19:00 +0800
Message-ID: <CAHB1Nag8uRkBMGv6q2M6C-pSTVxju8im8YRhQwXgEnPVQfscgQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: remove BUG_ON which will be triggered in race scenario
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, yi.zhang@huawei.com,
        sunjunchao <sunjunchao@yanrongyun.com>
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

Jan Kara <jack@suse.cz> =E4=BA=8E2023=E5=B9=B44=E6=9C=8812=E6=97=A5=E5=91=
=A8=E4=B8=89 18:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed 12-04-23 00:47:37, JunChao Sun wrote:
> > From: sunjunchao <sunjunchao@yanrongyun.com>
> >
> > There is a BUG_ON statement which will be triggered in the
> > following scenario, let's remove it.
> >
> > thread0                                         thread1
> > ext4_write_begin(inode0)
> >     ->ext4_try_to_write_inline_data()
> >         written some bits successfully
> > ext4_write_end(inode0)
> >     ->ext4_write_inline_data_end()
> >                                             ext4_write_begin(inode0)
> >                                                 ->ext4_try_to_write_inl=
ine_data()
> >                                                     ->ext4_convert_inli=
ne_data_to_extent()
> >                                                         ->ext4_write_lo=
ck_xattr()
> >                                                             ->ext4_dest=
roy_inline_data_nolock()
> >                                                                 ->ext4_=
clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
> >                                                         ->ext4_write_un=
lock_xattr()
> >         ->ext4_write_lock_xattr()
> >         ->BUG_ON(!ext4_has_inline_data()) will be triggered
> >
> > The problematic logic is that ext4_write_end() test ext4_has_inline_dat=
a()
> > without holding xattr_sem, and ext4_write_inline_data_end() test it aga=
in using
> > a BUG_ON() with holding xattr_sem.
>
>
> > Were you able to actually hit this? Because inode->i_rwsem should be
> > protecting us from races like this so I don't think the above described
> > scenario can happen.

Yes, you are right. The write_begin() and write_end() were protected
by inode->i_rwsem. And then I checked the operations to
EXT4_INODE_INLINE_DATA, but didn't find any race. I didn't hit that, I
was reading code and recognized that there may be a race, but wasn't
aware of the inode->i_rwsem due to my carelessness. Sorry for that.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
