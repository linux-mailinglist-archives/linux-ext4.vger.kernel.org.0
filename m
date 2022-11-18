Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0562F2AD
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 11:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiKRKen (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 05:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiKRKei (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 05:34:38 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF8922C5
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 02:34:36 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id n18so3044644qvt.11
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBS5sCK3MOcFnE6mt/bBsSMsu0ufq38WRZwvVsjp3C0=;
        b=tOAxsC1knyxe/9kWJpUlnHjCcdLtAt5d9VCueOeprxYSdUzy+iKXWGA80Mzj+XOzti
         l2WNEMegsjbQzIlLQQRyVgdDjrigmhypOfACpvamq3JypQ1u1xLx/dByYRGJiNkOrl0X
         hJKIRgwbnQDD51QniV2A+p+3U0djIa7UyE5WzZQcatYlZgJevopHxg7cCeWlFBA7OUFV
         BLP3DVjn/scLiBJdq/epnNOlgAwJNY8jmx8dcmRBjVt38IKEEngrSQUihfMk+IbuDXVn
         ifoY9zsT57X1srpXzoZ7L6/wNiGWgyRYIKQX7VSzuBXreIpSpHkIjFMfXtrXPYsOVBro
         fdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBS5sCK3MOcFnE6mt/bBsSMsu0ufq38WRZwvVsjp3C0=;
        b=t0KYfQ9AixmkYyLVmhf4Tl62NcN1v2sqdVbMYp+hmnfXZAXR0VnXPMfEpFVSnXiYQS
         gH0GN2UI2BbjoImOd+TfZAySBW5/ssNqXhWsPs3ziJBQ+9i4nLF1VoGIPNFhPXLU1U6T
         VmhNl+lr41s0z/n9LMno9CEmZjjmL2DK/3tgAbyoq+k+cVSq3SAMOQdr3MTvErlhCCLq
         yhwMtvHhJWTMMc35LWkwjFsER23/mIFVFt1PnWDv+JOd21Ui9RwAoSA+fDi4xcI1nlWA
         M7v+CntcQHukALCif9d2/CjR/5OXuNpRgq9jqgDluPesPM2Y7oRMRjoztlikFbn+5ota
         siaQ==
X-Gm-Message-State: ANoB5pksgwqdlv1Um4itBTz1W2fuBGnpe+hcI0nLw8NLeJHQXntOArKw
        MTlLdSwMZ2IDS1Y4/raYETDEYiSl+qhgRU1b
X-Google-Smtp-Source: AA0mqf5sQAi+JR7vcX//kEBKytjd1RC0SchejUNQvsMAQrsJkXpU2twq87zumtysV+fDqnX4hv5kAw==
X-Received: by 2002:a0c:ef81:0:b0:4bb:6295:4e22 with SMTP id w1-20020a0cef81000000b004bb62954e22mr5981978qvr.88.1668767675708;
        Fri, 18 Nov 2022 02:34:35 -0800 (PST)
Received: from smtpclient.apple ([12.184.218.19])
        by smtp.gmail.com with ESMTPSA id ga17-20020a05622a591100b003a6328ee7acsm147795qtb.87.2022.11.18.02.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 02:34:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 01/72] e2fsck: Fix unbalanced mutex unlock for BOUNCE_MTX
Date:   Fri, 18 Nov 2022 04:34:34 -0600
Message-Id: <0F4372E0-A232-4DC8-81CE-54D8C0921D1C@dilger.ca>
References: <febbbd17b3cf4201aaae24e4adb61e4f8a80e9c9.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
In-Reply-To: <febbbd17b3cf4201aaae24e4adb61e4f8a80e9c9.1667822611.git.ritesh.list@gmail.com>
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
> =EF=BB=BFf_crashdisk test failed with UNIX_IO_FORCE_BOUNCE=3Dyes due to un=
balanced
> mutex unlock in below path.
>=20
> This patch fixes it.
>=20
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> lib/ext2fs/unix_io.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
> index e53db333..5b894826 100644
> --- a/lib/ext2fs/unix_io.c
> +++ b/lib/ext2fs/unix_io.c
> @@ -305,7 +305,6 @@ bounce_read:
>    while (size > 0) {
>        actual =3D read(data->dev, data->bounce, align_size);
>        if (actual !=3D align_size) {
> -            mutex_unlock(data, BOUNCE_MTX);

This patch doesn't show enough context, but AFAIK this is jumping before mut=
ex_down()
is called, so this *should* be correct as is?

Cheers, Andreas


>            actual =3D really_read;
>            buf -=3D really_read;
>            size +=3D really_read;
> --=20
> 2.37.3
>=20
