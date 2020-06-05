Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953251F0118
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgFEUmn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 16:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgFEUmn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 16:42:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD24C08C5C2
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 13:42:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nm22so3137925pjb.4
        for <linux-ext4@vger.kernel.org>; Fri, 05 Jun 2020 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7QEGzQkTAGb+6Gg90xlTqvBigNYj6eWP5+WbNCR9Q5E=;
        b=Zkp9CI7a88UBQ/MXbMxpUxynh41Ub5R4ZGbfdn+cuSR7wvvE7M8z5756ENCsPUtdJl
         StxIl6QY1Nu3F+JDavc0rhn92kIg1r69ydvQSlvjDc0imE18Ru3CUT7kegYdyW52+lpC
         Ucha+c/lFR3bZ/NeT6bN/7nW8EQfZjNvugX7aozI7TzxIQQ9708TBQd/67OqF7E/Df4q
         sbHXMi5Hzo7bYcKoazLw1XfBainC8sogAzlhrNWCDudZa5DG3azeFA8+O3AcZXiNe+m7
         IwnXUxXK6as/ksfbJ11SKNAI4Argd/z6wBGYBSW8TLGhMK4Rvfp+OAcjMFOY+upbQV4I
         TWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7QEGzQkTAGb+6Gg90xlTqvBigNYj6eWP5+WbNCR9Q5E=;
        b=Wr0XZsb3vONAhZodDJ3Gb6OdjDfJZXM13FYOd10LJNbQ8Ea/l+e6JwYHLnTn2tuw0e
         IUo6uIqhDUh1HYvQN09Ac8gtdqp8OWFwm0D04VcR3PM2FTRGwrM0vYK9PI3v7g7eykpe
         pJYSxrVf4ROKoMqei//kRlbB3IRMDuxOb+WTrY5MOOQuQiw/X62PnnKTZJRa1Kl75JzI
         zfVw564skesCizOA9+EJ/H1dxsFcws7jSobxa1pa2bziu4Yk792E5ip+ETS40lGjUbo3
         DrI1QafbWimhe7ScZtfxvp7uZASINuKjxk6gWAaD9OA5itbJaAMu3bxnacVfSOog5sRp
         YFmQ==
X-Gm-Message-State: AOAM533XGwOkiWnbaH0MSBUvZXDU4TFGaw9EcMZOkOYcR2IfohvQTipJ
        6LL48jUhV23jAkvvkDXTR5Yfz68LZfk=
X-Google-Smtp-Source: ABdhPJwGd9aZBLpv3TQkXLTGsBc9VwbXqOnAH8/2wLJDVuWpxS+7XgF9zZ1P6cxlQdADWn6eoi7oMw==
X-Received: by 2002:a17:90a:e7cf:: with SMTP id kb15mr5192796pjb.86.1591389761730;
        Fri, 05 Jun 2020 13:42:41 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x8sm4567478pje.31.2020.06.05.13.42.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2020 13:42:40 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <2CD269AE-08F3-46AD-B230-A2F5F4F93AE0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_46B3D440-1117-430A-AF22-E58736EEF4D4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/4] e2fsck: use the right conversion specifier in
 e2fsck_allocate_memory()
Date:   Fri, 5 Jun 2020 14:42:37 -0600
In-Reply-To: <20200605081442.13428-3-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
To:     Lukas Czerner <lczerner@redhat.com>
References: <20200605081442.13428-1-lczerner@redhat.com>
 <20200605081442.13428-3-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_46B3D440-1117-430A-AF22-E58736EEF4D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 5, 2020, at 2:14 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> e2fsck/util.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/e2fsck/util.c b/e2fsck/util.c
> index 88e0ea8a..79916928 100644
> --- a/e2fsck/util.c
> +++ b/e2fsck/util.c
> @@ -123,10 +123,10 @@ void *e2fsck_allocate_memory(e2fsck_t ctx, =
unsigned long size,
> 	char buf[256];
>=20
> #ifdef DEBUG_ALLOCATE_MEMORY
> -	printf("Allocating %u bytes for %s...\n", size, description);
> +	printf("Allocating %lu bytes for %s...\n", size, description);
> #endif
> 	if (ext2fs_get_memzero(size, &ret)) {
> -		sprintf(buf, "Can't allocate %u bytes for %s\n",
> +		sprintf(buf, "Can't allocate %lu bytes for %s\n",
> 			size, description);
> 		fatal_error(ctx, buf);
> 	}
> --
> 2.21.3
>=20


Cheers, Andreas






--Apple-Mail=_46B3D440-1117-430A-AF22-E58736EEF4D4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7arj0ACgkQcqXauRfM
H+DYJQ//fC4FviH93gdwB7X8kiypnkebFg0sgVz7N0zX1RfkU79DcMdFZgrw7g3P
AMTDDfUxIdU2NaFtN2S4cX91EqtMG0OIrWQeAL+HfHBNjMyeY49GEPIn4Zgjg0Hg
o07+QbuuUWpgh7vzPnSH0/d9Bj9sfWS0Zy7OCctVp0FI59bEHVpCPe16sh3Mo04i
Z5MTL4KDV3696BrkiHpXt+1lKI+tGLZgoms+tNNOdeR8TUbXqe08h+8DCpDXF//K
nNglhGe6kWSgW7f8XDHVYrm1JMcms2fnllHOzIc6K7pRRe/WPhzq2XHqh+yqN4a3
V/HajQ4v5dH8oheGlBp1wEgYFhHSjIBpyGUxxYw1JAyFtcUQB3wcwVQBFoLOCltD
uJWlekhAL3MEj5vz5aY/pjwh5VePeUt0lQ/Wmivu2Kq7uhNwoAdVa2RoKywqDB6E
Uo9u25FmyTSzxZ3UvUhjaNlDI2uatPaPFfZK//Ao5LMuRIVowLqmc/m+lrtdteFM
0MthC+E0GcWCuVi3D9i2zUsvWX1kP1lV7oNQTgVpVHfOKT62IBWSRkiQ9S8XqkYJ
kOKd/hf4qN/qiAUVBMWUN9RxTK818aNLLFa+lHnDOkMg7ZJ/BxL2m2ruoiUAc9fw
2avlExgkWducTGVBdsop2h0Z/P64BmIJ/aUEYh/eDN3DYDaKV2c=
=MobU
-----END PGP SIGNATURE-----

--Apple-Mail=_46B3D440-1117-430A-AF22-E58736EEF4D4--
