Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D8A444978
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 21:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhKCUWu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 16:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhKCUWt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Nov 2021 16:22:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB2C061714
        for <linux-ext4@vger.kernel.org>; Wed,  3 Nov 2021 13:20:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o14so3459323plg.5
        for <linux-ext4@vger.kernel.org>; Wed, 03 Nov 2021 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=VR+j2+MtpE3wdfdX/XpCBU+ztWGK7EFwtoPB1XUgTqk=;
        b=NmcW9agOJF1TlXz2Am9n0BkRtvsJcfEhUWMKTaEzK4Lq7aRluPe6Kpr8oCtAYHYbjV
         A+PFpQeSo540qazaFxgJrJ7GcDU/pzW6MyGOEn0hUQXnla6NxbfAyvpSkaK/korgWiha
         FymSpTMjefm4lcQ7q4DFEdkcm7Dc21a+va5SPN5BpkXpLR2RRMRWbKf2/TSXj5xp6PcD
         Jec2qbb/zKGYOR8FslkHrFb/nQMBJFQKZSJVL8WXomCkpornc97e99olBzGyDYoFBNCy
         G5OpHe4gY6Ps8a3tUhnTJryeFeqg+ZX/3W/oAo/B0ZlRq8nLL1NTKpg39YZM0Hp+0tLr
         +Z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=VR+j2+MtpE3wdfdX/XpCBU+ztWGK7EFwtoPB1XUgTqk=;
        b=2k9/1hyTAwhh3MZt2TbR9uiFj2nCNJfIElVH43nd4pjellAvcUSdymBKP0PGS61jiu
         cENBTruf8JVzHFFBD0nNt08yHRQFUfovPc/ptqbRZmBH9jmUTWtJhBj/T81Twfo0yAyI
         mvfoNuvcfed36yzuQ0bA35npSNUw5LTEwM+Yb57q0g04oVTOUzefemfum6piVMOpDxHA
         WPdSTcUjeG7iQ30YbKlg1t6NHR87519MuguPO3ys9+auUF2Z1HLDwn7Rp48CB/PNZA1D
         xvLfIAROHFwAV4Dbv7IZdMNa+wIE2roN1jtKo0+B8JZeqXYR3iidpX/7LOwVw130vOgn
         bHsA==
X-Gm-Message-State: AOAM530Zi0FZTiv8H4s4deU2MrPoYHpgZpRHxeCH5vvq7CeydVE/8lY+
        +NafK3vWBLicmjaxVB0DPn3wOg==
X-Google-Smtp-Source: ABdhPJxI/n0ErN4p1N5UQfMd3QPMvEzIZgD6d68Ask2TdRWw2fAYWpNJ3XsfDjWhf/g1THrJNULqbA==
X-Received: by 2002:a17:90a:a389:: with SMTP id x9mr16999747pjp.167.1635970812101;
        Wed, 03 Nov 2021 13:20:12 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j8sm3013921pfe.105.2021.11.03.13.20.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Nov 2021 13:20:10 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BEFE9A1D-A336-4C19-9B9A-5343EC3D4364@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3E73D08C-3831-44DA-8C02-F90DCC391293";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: Change s_last_trim_minblks type to unsigned
 long
Date:   Wed, 3 Nov 2021 14:20:05 -0600
In-Reply-To: <20211103145122.17338-1-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Lukas Czerner <lczerner@redhat.com>
References: <20211103145122.17338-1-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_3E73D08C-3831-44DA-8C02-F90DCC391293
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 3, 2021, at 8:51 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> There is no good reason for the s_last_trim_minblks to be atomic. =
There is
> no data integrity needed and there is no real danger in setting and
> reading it in a racy manner. Change it to be unsigned long, the same =
type
> as s_clusters_per_group which is the maximum that's allowed.
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Suggested-by: Andreas Dilger <adilger@dilger.ca>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Could also add for reference:

Fixes: 3d56b8d2c74c ("ext4: Speed up FITRIM by recording flags in =
ext4_group_info")

> ---
> fs/ext4/ext4.h    | 2 +-
> fs/ext4/mballoc.c | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 3825195539d7..92a155401f61 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1660,7 +1660,7 @@ struct ext4_sb_info {
> 	struct task_struct *s_mmp_tsk;
>=20
> 	/* record the last minlen when FITRIM is called. */
> -	atomic_t s_last_trim_minblks;
> +	unsigned long s_last_trim_minblks;
>=20
> 	/* Reference to checksum algorithm driver via cryptoapi */
> 	struct crypto_shash *s_chksum_driver;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 72bfac2d6dce..eda550ec3956 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6374,7 +6374,7 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
> 	ext4_lock_group(sb, group);
>=20
> 	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
> -	    minblocks < atomic_read(&EXT4_SB(sb)->s_last_trim_minblks)) =
{
> +	    minblocks < EXT4_SB(sb)->s_last_trim_minblks) {
> 		ret =3D ext4_try_to_trim_range(sb, &e4b, start, max, =
minblocks);
> 		if (ret >=3D 0)
> 			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
> @@ -6475,7 +6475,7 @@ int ext4_trim_fs(struct super_block *sb, struct =
fstrim_range *range)
> 	}
>=20
> 	if (!ret)
> -		atomic_set(&EXT4_SB(sb)->s_last_trim_minblks, minlen);
> +		EXT4_SB(sb)->s_last_trim_minblks =3D minlen;
>=20
> out:
> 	range->len =3D EXT4_C2B(EXT4_SB(sb), trimmed) << =
sb->s_blocksize_bits;
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_3E73D08C-3831-44DA-8C02-F90DCC391293
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmGC7vYACgkQcqXauRfM
H+AiGA//RtyquN9vP8a20nqdfPYyLHz8m7OTUyroI6n4HeEzkGmBpnmY6P3Kq66A
yX9lfSBayq8A0a/2H2f36s80zgRRZWVnd0jawmDEY5toN0bxAbiDNSFx/xnm1t0X
vOsGmWteXhSwFPFliN9+5OVXVUvJaWrMAzSKDqu0KLCVdIhH+rtFD9HPcfhw0AJx
hV3T1oiTyJO+W0NW8PMSXuZm7M7F0jYrM+btYvxq0bquqnsop4/f79S71RokVxTD
3Bl/oJtKHfBv5mBQ1CkKgj+Hd5Ss0vvq8whAo4xbzzlBQ5ts+YldF43FCf6sdfRn
6lP46Wmc4M1bKSKKHr96Qllw3ibrXJ3+1t6+orpfTCTewoFoMe3g4+AnCkg6qSqi
UyPMEd0KVBxoi/TGRqPMkg4u0i6xnoSAlDZ/T1P0cXvCXiOGWod0DxYSR+Kreon0
B/AJO8QrUsbuVKGLjzGWtEuf151wQi6via1H9a2m62KPn4l9skMEc4l0X/H5vfjF
o55vnETmCAlAI1hmARRZLHW//AYbgq3hKKBC/hgN2h3ENsWKofwCgUW3p4N+X5hr
hDlVbC3THdsj7QeHAH+tSEmMsaJixHNuyEg9jtNvN3sjUaCY4wAuNAombXxQusUm
DZu/5Z+zTTmq4xKaX6KOQaLXj1XY54YL/gjxTSd8mNFlFsOvQu4=
=k7r/
-----END PGP SIGNATURE-----

--Apple-Mail=_3E73D08C-3831-44DA-8C02-F90DCC391293--
