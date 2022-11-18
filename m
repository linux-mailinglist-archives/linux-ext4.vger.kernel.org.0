Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F8A62F5EE
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 14:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiKRN1A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 08:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241877AbiKRN0s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 08:26:48 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FCD85A30
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:26:47 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1322d768ba7so5919296fac.5
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itG8b//YOq75gT62xpAyk8RXEwd+3JmaY27D/lebmwQ=;
        b=qWCqAFAYS0xZmjntf+3DPv79iQyufWxDGQRZt/yEb+2BSfxDeJ5CilLQwm9TA3xkOJ
         lc9w7X1KnbrJKv18XKOA20he3srL/BHmgOp1LBZRETvX1MwlNB+yPtK2tJuITq0cBqA2
         /DXI5lmAPBNBp65Y9zEbz6e3jppgIOW53SNoho6BsfdKdq8BrGKXO2H6uGfUvSuhEfmc
         qO/sOkdxOvwCONtftQQXp6UhP1Gu9gH18X5BeawOmIfyBko7e7QtG6h6y6fypIMDLjb2
         17N9ytX1cUO7a+kdiY/P3M58UGPPE9grxrKFVjTABHt+ub3FYpJdmXlgBg9Gol/TMzr/
         n4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itG8b//YOq75gT62xpAyk8RXEwd+3JmaY27D/lebmwQ=;
        b=00iIhzAD+TV5sl9iu+mHTvwGM/4MyN85wDbm+orBfhuVz06ucnO3QniYDh13aHOIPw
         bVANTYS2jeV4uMbBoUEbqxCmDjkCmPYwdPr6I/1ES6LBMXM25W1K49UaLvuSDwRusLUk
         06b3s/eF6QTpzcFDUPwoUNfYlDMZYrePGpSUWbXpXu4C7wn3ZQevyUcXPd/vGMnxoe5S
         94T3N/E2R6xo3BsVFbC60R5jYNfLbh2/E0o6xliIuG/4LGrdvLcPbkyOXogPKyGLeiQQ
         m3jXnVX0lEYmdqeyK6iRedbuRIF/U6YzLa5Is6yOUoqcPXs4FdfxE7g83G+YhnlTaKpj
         VBMg==
X-Gm-Message-State: ANoB5plvTkN04cfrSpPYUUyjYuE+XHUs3HHZZxf225TpSJyhdQpAo2rC
        T07C2+Vs/obLqGtd23yKKqvDntrNs3/Da/Jn
X-Google-Smtp-Source: AA0mqf6fXz+lRCFTqQNcvrTqK5F2FDYfIUHskrEnQDNtIx2pf7aStLhzSWEDNBXbrdsKni+Bl5LEtg==
X-Received: by 2002:a05:6870:9d85:b0:13b:c2c7:8c54 with SMTP id pv5-20020a0568709d8500b0013bc2c78c54mr6786406oab.242.1668778006432;
        Fri, 18 Nov 2022 05:26:46 -0800 (PST)
Received: from smtpclient.apple ([205.169.26.81])
        by smtp.gmail.com with ESMTPSA id z5-20020a056870d68500b0011e37fb5493sm1924625oap.30.2022.11.18.05.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:26:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 04/72] badblocks: Remove unused badblocks_flags
Date:   Fri, 18 Nov 2022 07:26:45 -0600
Message-Id: <6224109F-2412-4D0C-9665-6B13E72699AF@dilger.ca>
References: <3b00feafe3b640cc230582eeff4a194a5ba5838b.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
In-Reply-To: <3b00feafe3b640cc230582eeff4a194a5ba5838b.1667822611.git.ritesh.list@gmail.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: iPhone Mail (19H12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Nov 7, 2022, at 06:22, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote=
:
>=20
> =EF=BB=BFbadblocks_flags is not used anywhere. So just remove it.
>=20
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/badblocks.c | 6 +-----
> lib/ext2fs/ext2fsP.h   | 1 -
> 2 files changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/lib/ext2fs/badblocks.c b/lib/ext2fs/badblocks.c
> index a306bc06..345168e0 100644
> --- a/lib/ext2fs/badblocks.c
> +++ b/lib/ext2fs/badblocks.c
> @@ -81,11 +81,7 @@ errcode_t ext2fs_u32_copy(ext2_u32_list src, ext2_u32_l=
ist *dest)
> {
>    errcode_t    retval;
>=20
> -    retval =3D make_u32_list(src->size, src->num, src->list, dest);
> -    if (retval)
> -        return retval;
> -    (*dest)->badblocks_flags =3D src->badblocks_flags;
> -    return 0;
> +    return make_u32_list(src->size, src->num, src->list, dest);
> }
>=20
> errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
> diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
> index a20a0502..d2045af8 100644
> --- a/lib/ext2fs/ext2fsP.h
> +++ b/lib/ext2fs/ext2fsP.h
> @@ -34,7 +34,6 @@ struct ext2_struct_u32_list {
>    int    num;
>    int    size;
>    __u32    *list;
> -    int    badblocks_flags;
> };
>=20
> struct ext2_struct_u32_iterate {
> --=20
> 2.37.3
>=20
