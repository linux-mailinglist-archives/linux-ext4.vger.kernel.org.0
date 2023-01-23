Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671436773F0
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jan 2023 03:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjAWCLI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Jan 2023 21:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAWCLH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Jan 2023 21:11:07 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A12125A2;
        Sun, 22 Jan 2023 18:11:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v23so10089358plo.1;
        Sun, 22 Jan 2023 18:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgCwbfHUqzSMimmUl+HmnmrlXdLUzZkCtP90K9LBmDA=;
        b=PfcyXdaH9tjRLkzHJNi/eAO06HNhh0jUvKHfHWHKMllH3R9XtQURjdPzmby86O01PS
         fausoC/5p+pJj+lQqmeZdofPx0EghCLr2Nq3LdZLTj8mpAtzHLCrv4ytA79XlJyszNx1
         bt7hoJTS1eA4ptKtpzGLNckn9awtWFWfT0fgMMlgASRCO/IBekoWUq+T78bx+l5SIALG
         iItL82C3ZDdgUG5WSfNcu3h0EOW3Iqa2lnYe4CDHsVL5IRQD5wCeb2epQZAkRGm5jEsK
         3wAfEajQSYlQgGlhWpx10rqH2NeqhmhYJHyooIzfQEuzHs/grxcLT3tfy7ib5Y/rWH1n
         7aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgCwbfHUqzSMimmUl+HmnmrlXdLUzZkCtP90K9LBmDA=;
        b=Jc2+kxvxI1hcAI+U7eFBSA4dFvyNadja/xMEsC5Jw8iuzA+2o2m1ACPtiortvvFoD9
         m1LzVOp4xJOQBIyPkRrBg6zXNWagerVCO2jsm4JbEzmyrUNG0wQ7QrKAPcKpRTdJyGuU
         NckbkDMHurLg8PjCTU3XkTmjR1AIXMRw72GxeqQiJLwFzxmvWircOlXBGzLAUmHris7Q
         n3Rhj0KNKLVwzYdWvSLmu/8EciYa+FrY4Rm3zYc8mqp780eEe5vSD8sCZfkjhiKjYeuV
         7cBP2WG3qvg/LZ1rqXYmrY+0+Xz9yAOp76yjgxWnxUdR6r6yQbnbkSuG8Zg+6iP4yAiR
         uMpQ==
X-Gm-Message-State: AFqh2kqU/7GpAPVIshtjjrA8W7C1Lw+Om2EWCiAhEXB34VA5SZIc+uYr
        0LmRG17Y2cuXG3ISYMMCmYo=
X-Google-Smtp-Source: AMrXdXvzKpxRzl6KdiTqxN1ZHV0dLGbklJ27cUWHuu38ZmnNYcvS/h5O4VPOh9o1IlCxMOr+RhT/pA==
X-Received: by 2002:a17:90b:18a:b0:228:c8a1:3510 with SMTP id t10-20020a17090b018a00b00228c8a13510mr22968510pjs.5.1674439863008;
        Sun, 22 Jan 2023 18:11:03 -0800 (PST)
Received: from debian.me (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id lj10-20020a17090b344a00b002272616d3e1sm5497508pjb.40.2023.01.22.18.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 18:11:02 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id DB3551055BA; Mon, 23 Jan 2023 09:10:58 +0700 (WIB)
Date:   Mon, 23 Jan 2023 09:10:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Diederik de Haas <didi.debian@cknow.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: ext4: Fix full name of the GPL
Message-ID: <Y83sssQr5DMg2KMc@debian.me>
References: <20230122180552.53445-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zNGtea+rj3WwB3Tt"
Content-Disposition: inline
In-Reply-To: <20230122180552.53445-1-didi.debian@cknow.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--zNGtea+rj3WwB3Tt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 22, 2023 at 07:05:51PM +0100, Diederik de Haas wrote:
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

No patch description, really?

> ---
>  Documentation/filesystems/ext4/about.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/filesystems/ext4/about.rst b/Documentation/fil=
esystems/ext4/about.rst
> index cc76b577d2f4..c150519bbf3f 100644
> --- a/Documentation/filesystems/ext4/about.rst
> +++ b/Documentation/filesystems/ext4/about.rst
> @@ -17,7 +17,8 @@ created demonstration filesystems.
> =20
>  License
>  -------
> -This book is licensed under the terms of the GNU Public License, v2.
> +This book is licensed under the terms of the GNU General Public License,
> +v2.

The doc has already SPDX identifier above. Please remmove the sentence above
instead.
=20
In recent days, I have seen the sudden influx of s/GNU Public License/GNU
General Public License/g patches from you, for which many developers ask yo=
u to
replace with SPDX identifier instead (see [1], [2], and [3]). Please do
a tree-wide SPDX patch.

Thanks.

[1]: https://lore.kernel.org/lkml/ad99d227-ce82-319b-6323-b70ac009d0e7@roec=
k-us.net/=09
[2]: https://lore.kernel.org/lkml/6d9053c6-b56e-51f4-db47-79264f1f5672@wana=
doo.fr/
[3]: https://lore.kernel.org/lkml/20230122111707.68ddead6@hermes.local/
 =20
--=20
An old man doll... just what I always wanted! - Clara

--zNGtea+rj3WwB3Tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY83sqgAKCRD2uYlJVVFO
oxLVAQCDkmlPnvmX1rmIBFt/kjjIMljAjJVOHUvSZqg1yxnk9gD/fDOypd3ecfEi
VdlKAtmtiwyYQnLNF1HWRWlG2JtqPAY=
=OAcv
-----END PGP SIGNATURE-----

--zNGtea+rj3WwB3Tt--
