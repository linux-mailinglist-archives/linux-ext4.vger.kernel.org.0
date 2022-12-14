Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C91564D1A5
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 22:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLNVPl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 16:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLNVPk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 16:15:40 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AAD2678
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:15:38 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w26so5366728pfj.6
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq/OXWhveT600Zka3PCUJcilEAuPz6WcTRNKviwQwxY=;
        b=xg4XLa/kcKmhkZehr5A4FHa6odgnm0O+apWXQpg997lmyBPUPo1dHZCMtO92gP97y3
         8RDuw+2hF++yGFGaoJi6QOdHL1GWPgNRxGwkTWYCx2yXrXe6wyYuebzapJg7OFx7U8AJ
         ZeM/ESVU58+ZDALlLJ5r/mb1EWhL8oZjmypGEJRFwrv+iIIYnnnNrM+AdXeh5sMzAgsa
         1BvWxmGijFk7OWf9Uab57c98PjoC7ObtWKAYvIVBAwh6MxK91FRQ7Psk8XBszh8xHGIx
         MADaX1EB/SA8OphWnV9WpKhjTPIpV6MrjVZjdp1gXj3mjCOcYBXNb50w1qSwxelZ1bWb
         0opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq/OXWhveT600Zka3PCUJcilEAuPz6WcTRNKviwQwxY=;
        b=tw/eTyhXXA2STdAg9JMMwhTXx/wYzGIz1Xal5IYiQRgC0tvyI59bp0lVSGDt2WbQF1
         2WGbetwXpwjJ8i4YUx5dI7hgebSY6KHWIcXMzu+UuLGX1fKNNSB2FO5e34rh/VAwCauU
         XMfdgcN/ZESSB4AEDJhrhNgNwWOTSfc2njnsk8uAeKsLLKlYbgTlfENc+UCwIYarHiCk
         Y269apQZnjYJiGLwTpXWhmdxT3RdKANqM8Qn0FpgNm4EJQzlP11ARITiidN2Mlf/5Uw1
         YhLs4vEEDoW/oTtnDzqMC709I4fANTekF0rGU4KFwVWd5IMFA7byDkftVwWQrWJjYoG/
         8JWA==
X-Gm-Message-State: ANoB5plQ9/4sy1VBLWVf18gG+8jwgXlEfRgANDlbjtodPpnzwZtwdXNw
        OGKr75ThuPN+avoTB5b2L32EZg==
X-Google-Smtp-Source: AA0mqf6NFpoErvFtdsfr4MxkkeMTLWOqBuCZdGT65kMz9OzlzogWgYk5NWViks307A7Q04RXqetWLQ==
X-Received: by 2002:a62:6495:0:b0:56e:d365:f96d with SMTP id y143-20020a626495000000b0056ed365f96dmr23681719pfb.5.1671052537636;
        Wed, 14 Dec 2022 13:15:37 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i31-20020a63221f000000b004792ff8ab61sm258041pgi.80.2022.12.14.13.15.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 13:15:36 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <AFE1174E-74AD-4EA3-ADFC-E7512BEC60AE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1B60113F-EF13-4D54-9208-04934C2C0691";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFCv1 15/72] tst_bitmaps_pthread: Add merge bitmaps test using
 pthreads
Date:   Wed, 14 Dec 2022 14:15:30 -0700
In-Reply-To: <c66b3b734a5a98297728786df5fca21a234d5872.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wangshilong1991@gmail.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <c66b3b734a5a98297728786df5fca21a234d5872.1667822611.git.ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_1B60113F-EF13-4D54-9208-04934C2C0691
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 7, 2022, at 5:21 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> This patch adds a test to verify the core bitmaps merge APIs
> for rbtree bitmap type.
>=20
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> +/*
> + * Note we use EXT2FS_BMAP64_BITARRAY always for used_bitmap, this is =
because
> + * EXT2FS_BMAP64_RBTREE does not support parallel scan due to rcursor
> + * optimization.
> + */

Is this going to be a problem in the future?  I think for pass1/pass5 =
there
are no rbtree bitmaps that are *source* bitmaps for multi-threaded =
operation,
but I suspect that once we try to parallelize pass2 this could break.

Is there any check in the code that prevents multi-thread access to an =
rbtree
bitmap?  Making a copy for each thread, or ideally copying the rcursor =
for
each thread, to allow at least multi-threaded reads.  I don't think =
there is
a high need for multi-threaded write

Cheers, Andreas






--Apple-Mail=_1B60113F-EF13-4D54-9208-04934C2C0691
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmOaPPIACgkQcqXauRfM
H+Bizg/+IDtVNo6CpS4FM6uXdtGOsGF46b1I9SQXRZbKCkjo6lKClYFIQwX0rHtO
DbmrtZpTfqns6+kOIC8vGpKUQYfSzsPjtXF2lHEB+4mcazSQI9cBQwRz5BQWNYf/
FiHUyEwXLUG1j/B0R2RebauGDnqG10Jx7I7ewh82Bw2HGnW77SZiMwsNpBN8e7Tg
MeUjfGHQ/wBTqriuEP3edDRK4Rk4U3G0mijYui7mvlnRXer7XWaPjgzLwZ3PEBQk
6uwNwWYaJwoZW14EJa4mNNPnmrOPZF5zfQmtX8cf633njMd/COaCRUBrfDFGsYqN
4ynmdY8HPTav9c+0CWmm9VqG5iS3o4iJO9vYh2oaTeoDrsCeAZsxCCqEW4RjPynf
zKK6UqsK4fO6PqZiiafX499zA1M+EfauSPGMLzEsXdAhU7OKBNZEePSkD4VdgLym
JghnaQCBquDnQuNOPnmJfzDWsrk5E7OfF4hL/9K2SzADzSl+UBsxm2XwRxoBg83+
o4P5enOEOb8Dwl907QMsfxF31IvYLGPF9hqaEYuMp6jXNYy+uunWdUnSknXwPQjA
2kNfRGBKVdTd3qA8wRggAeczi3SjOAFKoLGHCGq+19IY/MKcL/b1eR66rE9z4K43
iiVzhXg4dik00AlBg1vq82wcG5HD7Wort+sTNx8z+1EX/Lidb78=
=Mmza
-----END PGP SIGNATURE-----

--Apple-Mail=_1B60113F-EF13-4D54-9208-04934C2C0691--
