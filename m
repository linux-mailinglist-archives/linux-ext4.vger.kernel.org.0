Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE291F012B
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 22:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgFEUsW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 16:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgFEUsW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 16:48:22 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C78C08C5C2
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 13:48:22 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f3so5493543pfd.11
        for <linux-ext4@vger.kernel.org>; Fri, 05 Jun 2020 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=JoMhEIq++vyEJkWg9x5VYqW83KCWvnFjhrwFp3pfmFI=;
        b=m+/81+DCWo5EKNmD8IAS3hzzIWmKIGPlWf0wtFD/b2rqbzFqwPIRbtQd4+oSEP50Iy
         g6HsHpMbMTITI07JusYVf2T8m8wCh1Tl3osrjGp113zDuhGB8UCnHGqx4dIUivwEGBp+
         4r44CQaAM/zOwFL/bs5IybpMF/0j5dSYHI1W8tDv0foK/V1mD8c1zERmvRJp0PWnHWrX
         Qotp8kk1eNdkXZKFpMS+eBEPKAuJtSjLWSbZZItqt4+V+hU1Hi6w5vszjdDFv4ygeTJc
         PwwNL0GP1Ffb8voMPYBABkV6dWANxE1wjOvYf/WVN53fzXiSP9Kq42w7PS3NdvTPPG2R
         1Wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=JoMhEIq++vyEJkWg9x5VYqW83KCWvnFjhrwFp3pfmFI=;
        b=Eb3QJO265sQNfjgB1c1ToYVhe5wTc0dVcuJF9Z4nHn0PXsdwXblBqnxhkzj8nHEQfR
         Tuh3sfvWYfeb9f07dgJCxjWutvCCFKaWxc/xFGXO/2Ks0YKsrajVM2D9BkDClcWTEW5g
         W/vitT+lhbVGU57KnhAc+HKOtvY3Ip21e6M8l0Zo+A6W/7HOvPATODaMNN8HTKaeor7v
         fNBHdzSCTgQk5Ob8tNZDpjDsTfzyQAQbE6hpB6KGH6EgArqwPFMh9Lv0WE6x7BQY/2wc
         Z28QCO3YTjsfYd8juTQ86fTuWzBSkHT9zharQ7Aq0/TLU4nob9qyD8CL5o66Kt0NkRXq
         jOdA==
X-Gm-Message-State: AOAM533ZAsgATozoIgy2Kd5IIQT+5ME/IKGf9AFBYYydg4zvSwpfmVf7
        U52tZaP6wgnwN3lVI51/0COOBxzwJ1Y=
X-Google-Smtp-Source: ABdhPJxo5MT5bBZe4U2IkG7bdm1mUKFmnAEaj1pQcsyRjwduTXS9OUPQINdPoplxms26vaTT6gPaTw==
X-Received: by 2002:a63:7c5a:: with SMTP id l26mr10272955pgn.397.1591390101809;
        Fri, 05 Jun 2020 13:48:21 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a2sm340043pgh.81.2020.06.05.13.48.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2020 13:48:20 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3F424937-0988-4EAB-A8D0-09D4430FCC9E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2E472A4B-77CC-4DAE-AA9A-A96745C284B1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/4] ext2fs: remove unused variable 'left'
Date:   Fri, 5 Jun 2020 14:48:16 -0600
In-Reply-To: <20200605081442.13428-4-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
To:     Lukas Czerner <lczerner@redhat.com>
References: <20200605081442.13428-1-lczerner@redhat.com>
 <20200605081442.13428-4-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_2E472A4B-77CC-4DAE-AA9A-A96745C284B1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 5, 2020, at 2:14 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/swapfs.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/lib/ext2fs/swapfs.c b/lib/ext2fs/swapfs.c
> index 5b93b501..bc9f3230 100644
> --- a/lib/ext2fs/swapfs.c
> +++ b/lib/ext2fs/swapfs.c
> @@ -456,12 +456,11 @@ errcode_t ext2fs_dirent_swab_out2(ext2_filsys =
fs, char *buf,
> {
> 	errcode_t	retval;
> 	char		*p, *end;
> -	unsigned int	rec_len, left;
> +	unsigned int	rec_len;
> 	struct ext2_dir_entry *dirent;
>=20
> 	p =3D buf;
> 	end =3D buf + size;
> -	left =3D size;
> 	while (p < end) {
> 		dirent =3D (struct ext2_dir_entry *) p;
> 		retval =3D ext2fs_get_rec_len(fs, dirent, &rec_len);
> --
> 2.21.3
>=20


Cheers, Andreas






--Apple-Mail=_2E472A4B-77CC-4DAE-AA9A-A96745C284B1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7ar5AACgkQcqXauRfM
H+BGExAApgYGaoZyO4HjoHMvQ57w6aKo1bSpWXwOtt3HviM06ojG8Qw2WsGupuCs
RpZOqIFc/6I1aLJq4urBxmLVvHOgzMjZLp2vmoONv9NRX+p1QZ0wp/QA0BDnBY6w
oJCwhCyCsPg5NQkT0HntfugQ5aotozomdx7KtmmKWVG0B7v6nSYssA8SG8iuAjs8
bs6PmscPqYUxs27VAqM6tAG17NDcTohcBDkQjk7RixBAt/C9/JmVTt3TwR+x4EOR
a6CtwNQVg99OrtNCu71jR9PDsB1aLzcSyY4rYPxGPts4x1+jPs3PXXKkxD88EpLs
JYAcaFa30zS4DItyXyxVgH0cnJD+o5cVXG4SY45TEVMiIyFgeZt8zHpYFWBmQpmg
fgbOvR3MCVovIKwgx4kHqJB5GayxwdIV6SC0vd0Y98yrsU7ztLi4DPiU3FEhnqXU
WB3Vpn4ge30YKpQDc3i8I1VjCsONz0TaWiHee55xZpBMwAOmXbp0XlpHl5H2vHg1
SGEjrN09yo/ZhC9xiLo5Qhqfkt8kwaDiLoK2JXl2LkH3T13ZowU7c1u5ohMeGtRt
EIaXOmtp4ki4i2uK1H1Eqr+hNow3WFAmlGDYxv7h8fQrUFgs2x1TM9EC7e366Awk
+RZaqGr1blqgGJumpqz40/j35Nej+npPm2CK+4QZw5A84eJvXZI=
=9nId
-----END PGP SIGNATURE-----

--Apple-Mail=_2E472A4B-77CC-4DAE-AA9A-A96745C284B1--
