Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B08592D22
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Aug 2022 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbiHOJWU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Aug 2022 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbiHOJVn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Aug 2022 05:21:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EB269;
        Mon, 15 Aug 2022 02:21:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so6073244pgs.3;
        Mon, 15 Aug 2022 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=TPo4myNvedxf2zJziNLj/Kjv2Ce8wy378bNxAOqAgGs=;
        b=HcsZiMic2kGmXl+Ny2fECbX3sMem0/SLa9bpatg9QGLYIDIAZZoSh5yOviRybn4I19
         VZMXJLtpgkL731A6sepmW/tcHEO4HabXJTPt6+qJpAC1Uj0szPzJYfaNd1Iy4CRpuZhV
         Kmu7OP4Eo3Lt2F65IlEgcSc1z7ntVXzpc8PfU/HYAu8CTxi+tgmAKmxZfUSSdETNpZYQ
         rCV+eWCxTKfaVfUxOrv28xIr1JaLRwgrjrYkqN8447UowBlkknD/T+anLQSJ+gdJTI6O
         xVMks3xkdfASQWPxSMvM2WrHJlDUDgwDjoaMd68df76kjAg4mldXqKpuqneAjOWcH83M
         JAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=TPo4myNvedxf2zJziNLj/Kjv2Ce8wy378bNxAOqAgGs=;
        b=FeudICjZG5A3j8rK88W8OvRLxM0+ytFYulskphqSoQ8tudZd5xAxjtFZ9Ett34sIiU
         umAZuGWWcftbF2vHaxwS6YqqI2GyvyJA0NimFbnNILUmZzb7nn80oxjwP7wbnjZEomVr
         EY3ux73vL12vMiTv1PdmZJ+RD1ECdcRj7+raaylzeBN94EFGFBUVF5/6eOui89Ly9wKV
         kDzmLW5qjHfumSEMYpthddmwtKjM4zLdHs/1hKrML5bWq9vWEvUzKovvD6ijSDwAzEG6
         lkH5FN9JITMrzrfcnLwN8D9J85GrMrVJjzAsszqmph1DHUsNzP2yrtTn2U2sdW9LkXBk
         YTTw==
X-Gm-Message-State: ACgBeo15NfvyP9QPclgDarc3MDNe1JniF8b4EMwDNKJGT1Y0ec/vBnjt
        x72W6tTNudPDag2gFrSqPls=
X-Google-Smtp-Source: AA6agR5+Kf1N9dgRiucGStDKUErlRK8bV+X2mSNkdWlZWahHc0C5G9ZelFNGzk2GTT/y4aRiMJ1fiw==
X-Received: by 2002:a63:cc51:0:b0:41f:12f5:675b with SMTP id q17-20020a63cc51000000b0041f12f5675bmr12775932pgi.69.1660555302430;
        Mon, 15 Aug 2022 02:21:42 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-81.three.co.id. [180.214.233.81])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a660b00b001f510175984sm4141895pjj.41.2022.08.15.02.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:21:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F1C45100014; Mon, 15 Aug 2022 16:21:38 +0700 (WIB)
Date:   Mon, 15 Aug 2022 16:21:38 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     JunChao Sun <sunjunchao2870@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        tytso@mit.edu, corbet@lwn.net
Subject: Re: [PATCH] Documentation: ext4: correct the document about
 superblock
Message-ID: <YvoQIvIlMsADeG2H@debian.me>
References: <20220814090016.3160-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C0wGcx6yGLwGR1Gt"
Content-Disposition: inline
In-Reply-To: <20220814090016.3160-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--C0wGcx6yGLwGR1Gt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 14, 2022 at 02:00:16AM -0700, JunChao Sun wrote:
> Correct some questions like this:
> s_lastcheck_hi field should be upper 8 bits of the
> s_lastcheck field, rather than itself.
>=20
> diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/fil=
esystems/ext4/super.rst
> index 268888522e35..0152888cac29 100644
> --- a/Documentation/filesystems/ext4/super.rst
> +++ b/Documentation/filesystems/ext4/super.rst
> @@ -456,15 +456,15 @@ The ext4 superblock is laid out as follows in
>     * - 0x277
>       - __u8
>       - s_lastcheck_hi
> -     - Upper 8 bits of the s_lastcheck_hi field.
> +     - Upper 8 bits of the s_lastcheck field.
>     * - 0x278
>       - __u8
>       - s_first_error_time_hi
> -     - Upper 8 bits of the s_first_error_time_hi field.
> +     - Upper 8 bits of the s_first_error_time field.
>     * - 0x279
>       - __u8
>       - s_last_error_time_hi
> -     - Upper 8 bits of the s_last_error_time_hi field.
> +     - Upper 8 bits of the s_last_error_time field.
>     * - 0x27A
>       - __u8
>       - s_pad[2]

The diff looks OK, but the description should be:
"The description of s_lastcheck_hi, s_first_error_time_hi, and
s_last_error_time_hi fields refer to themselves, while these means
referring to upper 8 bits (byte) of corresponding fields (s_lastcheck,
s_first_error_time, and s_last_error_time). Correct the mistake."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--C0wGcx6yGLwGR1Gt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYvoQGgAKCRD2uYlJVVFO
o8oJAP97K4ZlgfWXsNm5/qWKaC8pdT9u15ITW3FP3IOOfqdZ1QD/ReUqmfzowVR1
j997tJPJsMkXr5EFR7kDt+LXBKUv6wA=
=aUqt
-----END PGP SIGNATURE-----

--C0wGcx6yGLwGR1Gt--
