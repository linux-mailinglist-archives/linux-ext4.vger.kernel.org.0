Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48E664D1D3
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 22:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLNVcV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 16:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLNVcU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 16:32:20 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD2396F2
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:32:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so658723pjd.0
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUYtmNoLdStfOMqqva02bajbc6pz/bojyYRr2IhzhAY=;
        b=lJcukMKnp7am4vqCQohHxmpQwJG7r8/GTRsygFr/VUjMymttiAdb7fvUW9mm6UKOXs
         NgpFDylQjPinkzvatXEjGFg7zWAZfgkuxlePBarWV1mXzkR+82JP7FmG14FZXPjo24r5
         mw1p/mfTPtO44lfc8EuFDtDnp0kdO/jwQgtqymTwhFjHLQTjY7JcW0lI+2z/UZwnYadY
         AF09uS91E89BCIDZ/enTMp8vH9+G5hkgORjuqv/gxB8C1k0mLknhweLsqQfSY92dWEHU
         adVuYs/PI3l+W+/OeaO5tnmx51tKMN5X68/0yy3JvT5KUW4TLXIUdxJVFFA+vjqpqfIh
         TFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUYtmNoLdStfOMqqva02bajbc6pz/bojyYRr2IhzhAY=;
        b=jkdHhzAUSyOx0NeIs2z6B0mdslcG6CxFa9BZcWvADJfV0UHfYRlbx2Rm7+A/oiMI61
         NAFVnsH+dzujyGqEP5WYr56AnKuzSCU8v2X9i6eTgND7DRg4vbNs5lW6UJBEbmd2TP3J
         h7UTfI4iVSTHTYlEmBLMOS0ZyEkEfvNq5rAuvOIk18gXPQYTqk5xGemmxEGL0Xpg4Skk
         BcRfoo5coNoCX8EKTLD1B3uCCyiwJtxWhVYg3ZlTCW9P4VXMcSkY9/AkUenJU3xu4Tl2
         V2uU/GH3MkyWEDk3X3tKLGbEM+BN5FIe4lW6vKhrfAZ59mq99yetO+s0mYLZx/iRJpON
         /kKg==
X-Gm-Message-State: ANoB5pkRZs0tzxYhasONONmlXZCyunRGh2QMjRjD9gxJm2ey/T1oKWcH
        EXq4eRfAY1VxfUbp4xuOp6Y4lA==
X-Google-Smtp-Source: AA0mqf4bBxeiHzd1bFXyeHJNyHQtzHka6Glb+MvRVk9yQCFumDBx7nCwdUottP6MvBCV2MvCf4gExQ==
X-Received: by 2002:a17:90a:4a97:b0:213:d3e4:67b3 with SMTP id f23-20020a17090a4a9700b00213d3e467b3mr25963607pjh.21.1671053537853;
        Wed, 14 Dec 2022 13:32:17 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id nn11-20020a17090b38cb00b00212cf2fe8c3sm4585434pjb.1.2022.12.14.13.32.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 13:32:17 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <DEE6E02A-8AEC-400F-814B-7D7A6173BFFE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3E79795F-7D55-4288-BA90-7176671DD6BF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFCv1 21/72] e2fsck: add -m option for multithread
Date:   Wed, 14 Dec 2022 14:32:14 -0700
In-Reply-To: <935d3652155338e793325acd5f8b900728a56bd9.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wangshilong1991@gmail.com>, Li Xi <lixi@ddn.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <935d3652155338e793325acd5f8b900728a56bd9.1667822611.git.ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_3E79795F-7D55-4288-BA90-7176671DD6BF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 7, 2022, at 5:21 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> From: Li Xi <lixi@ddn.com>
>=20
> -m option is added but no actual functionality is added. This
> patch only adds the logic that when -m is specified, one of
> -p/-y/-n options should be specified. And when -m is specified,
> -C shouldn't be specified and the completion progress report won't
> be triggered by sending SIGUSR1/SIGUSR2 signals. This simplifies
> the implementation of multi-thread fsck in the future.
>=20
> Completion progress support with multi-thread fsck will be added
> back after multi-thread fsck implementation is finished. Right
> now, disable it to simplify the implementation of multi-thread fsck.
>=20
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Minor nit below, but looks OK otherwise:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index e5b672a2..1ee27f6a 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -854,7 +855,8 @@ static errcode_t PRS(int argc, char *argv[], =
e2fsck_t *ret_ctx)
>=20
> 	phys_mem_kb =3D get_memory_size() / 1024;
> 	ctx->readahead_kb =3D ~0ULL;
> -	while ((c =3D getopt(argc, argv, =
"panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) !=3D EOF)
> +
> +	while ((c =3D getopt(argc, argv, =
"pamnyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) !=3D EOF)

I find it easier to find/add options when these are sorted in =
alphabetical order, but
that is not solely the fault of this patch.  At least 'm' is added in =
order relative
to most other lower-case options.

Cheers, Andreas






--Apple-Mail=_3E79795F-7D55-4288-BA90-7176671DD6BF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmOaQN8ACgkQcqXauRfM
H+Cs0hAAgDAX3PI8QjwxZSXiAAyXMcHpLyH6QdajKzm7N0Z+Sd5ST3uM2P8wfNpH
8MKRNvMaV+/G11yPYgqHjOwdZMTGtMH/JLmgNx2YUO9I6FYLNi2m1W8imWyCch1E
/WC3W+7dgYzGM5g9pZ5qUzwDh/zgEYyptK+gD2fBsgjThomS3F7XSvjje32ABo7A
/t1H/j2Cg/tPn0wqXNyd6q4uWsVid9cZxip7IGZAUXf1+tEIgbuNK45Mk4FoyZBW
mlpFGySIJ10ZDoH5uhm/fubDGybcFFjapwGqhsgql/WhuYJMIWYlt6qp33fxfgDp
rnlZXYKEmwCYXUf3vRDgdFQ4HI1CC/79U5eaF6S6WKlbYTcgIF2AnAzcBed/+JoU
xtMDDPUr67i+3Ncuq0ze7TXwPibM3jUkBswxeIlPCBfL6TDjEOQ+VM9i863UOnGN
W7oqsAkh0mPV3GFWPzEfaVnMJNRTPPVeL4z8/BmIM55O7l7gss3WCCTSRSXO2bo2
ADrbb+Sy7AqC6SDBJcLWcZtKOYNCj0bQxV0uFWKDVPQi9UaI+8F/9pRGHJaJEGev
RnbOBn4pI0TA1wb/cSK2bHhJrVtTMmasYfMxkZEC8k/gU4v8IRmwpPPxZhBfp9fN
u5CgTZCeOw7FGLBv07b3/KVy71v6dnmgzwX8iZkbEBHpfIb9uIw=
=a9MC
-----END PGP SIGNATURE-----

--Apple-Mail=_3E79795F-7D55-4288-BA90-7176671DD6BF--
