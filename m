Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AF757CC7
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jul 2023 15:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjGRNHF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Jul 2023 09:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjGRNGu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Jul 2023 09:06:50 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1B1736;
        Tue, 18 Jul 2023 06:05:15 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-57026f4bccaso61022587b3.2;
        Tue, 18 Jul 2023 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689685496; x=1692277496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUFE4zZGrAvUM/BoEy+41CZw289243/LNIISiR4wdq4=;
        b=c/hmyYLN8hFspbmTr+69BFqsukonbOs7QK36df1zO/AGKEQwl9VCwiFs8UmiZmGvVL
         J0vBCTE1MVfYxq3VlYndM0Gvz1dsC3uqzowgw+mKFBjlosgFm1iagBtDoDGoH2TTAEmb
         t0lb+iO0UZmgnOauI3mePNhFXktmA6zoBEX3JO9sXN0IkwpGAIEKtBgMoWSxo9WdDzme
         GKjP2U10tSl6M50l6e1+M4oltqHb++IPJ4Um/K/felvpCuDcOBngEWeufUg2QCF/EqfH
         I8ZwoR7BuOrvh7S0WcFTxoDZN8pFbVpttteKEuilhiZKyVX3KzNm0abJPRUSUrxhYCvE
         kiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685496; x=1692277496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUFE4zZGrAvUM/BoEy+41CZw289243/LNIISiR4wdq4=;
        b=Ij5/ghTK8CkIh36M6Taf4a9zwB45tY/9L6g2WIEnTdwh/R6ZmlTwI41uoFoIdrcgIb
         UcQpLP9rsohqzI8Darnnid0JUFDMGVbqC+C499eO2t3VfFJm+WpkuMyBCi9jgDGx3wC+
         DewA2exiYwmAgKQWZILuUlJahXRMRLQsyU8lYGACvcVHfztTlZPgQTiFmVzm8HjBt5tF
         3QtnSf8ban0859UCIrfsAokjhu3ajLLlCY1B3AzI3PO/F/ILG7uWz6bLffDj0N4pRGdZ
         CFOnQBePWDKmdznUPfiV9m0R6FC6ej0rBLa1WFqUWZ7/mD+rgAV2KJM+eXhWi9hvbFxx
         YQVg==
X-Gm-Message-State: ABy/qLZkzd86Nb0hQmnbEjKk6hG9cH4TkwPIAIe0bXjCmBGIvXMy5mHx
        sa9bPJ4OJixvWMi9J0wBa76EeS0i9tHybxrdmUg=
X-Google-Smtp-Source: APBJJlGo6r2SOc2GWzwcOvHjYk8wrh3BVeiVaUH0xXbdA4eoxfhuOLsOeaiAyVyyQi2q8eduXr015bWDuZB5Lt4rRQ0=
X-Received: by 2002:a81:638b:0:b0:57a:75b8:b790 with SMTP id
 x133-20020a81638b000000b0057a75b8b790mr18662345ywb.29.1689685496085; Tue, 18
 Jul 2023 06:04:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7886:b0:31a:16:342c with HTTP; Tue, 18 Jul 2023
 06:04:55 -0700 (PDT)
In-Reply-To: <CAEYzJUGC8Yj1dQGsLADT+pB-mkac0TAC-typAORtX7SQ1kVt+g@mail.gmail.com>
References: <20230717075035.GA9549@tomerius.de> <CAG4Y6eTU=WsTaSowjkKT-snuvZwqWqnH3cdgGoCkToH02qEkgg@mail.gmail.com>
 <20230718053017.GB6042@tomerius.de> <CAEYzJUGC8Yj1dQGsLADT+pB-mkac0TAC-typAORtX7SQ1kVt+g@mail.gmail.com>
From:   "Alan C. Assis" <acassis@gmail.com>
Date:   Tue, 18 Jul 2023 10:04:55 -0300
Message-ID: <CAG4Y6eTN1XbZ_jAdX+t2mkEN=KoNOqprrCqtX0BVfaH6AxkdtQ@mail.gmail.com>
Subject: Re: File system robustness
To:     =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>
Cc:     Kai Tomerius <kai@tomerius.de>, linux-embedded@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Bj=C3=B8rn,

On 7/18/23, Bj=C3=B8rn Forsman <bjorn.forsman@gmail.com> wrote:
> On Tue, 18 Jul 2023 at 08:03, Kai Tomerius <kai@tomerius.de> wrote:
>> I should have mentioned that I'll have a large NAND flash, so ext4
>> might still be the file system of choice. The other ones you mentioned
>> are interesting to consider, but seem to be more fitting for a smaller
>> NOR flash.
>
> If you mean raw NAND flash I would think UBIFS is still the way to go?
> (It's been several years since I was into embedded Linux systems.)
>
> https://elinux.org/images/0/02/Filesystem_Considerations_for_Embedded_Dev=
ices.pdf
> is focused on eMMC/SD Cards, which have built-in controllers that
> enable them to present a block device interface, which is very unlike
> what raw NAND devices have.
>
> Please see https://www.kernel.org/doc/html/latest/filesystems/ubifs.html
> for more info.
>

You are right, for NAND there is an old (but gold) presentation here:

https://elinux.org/images/7/7e/ELC2009-FlashFS-Toshiba.pdf

UBIFS and YAFFS2 are the way to go.

But please note that YAFFS2 needs license payment for commercial
application (something that I only discovered recently when Xiaomi
integrated it into NuttX mainline, bad surprise).

BR,

Alan
