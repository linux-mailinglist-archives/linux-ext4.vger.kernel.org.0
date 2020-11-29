Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFED92C7B9F
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Nov 2020 23:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgK2WLz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Nov 2020 17:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2WLy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Nov 2020 17:11:54 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5223FC0613CF
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 14:11:08 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id e5so36358pjt.0
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 14:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=+Up3CEUqKdqzMHtk9NSK2HSFzqY0pkmdIxMPbg+GdfQ=;
        b=SeaoWnZoGa7YVtvgLAzX1yFdUpbqhPZj/v9iah2St/B2OxV0BuKLkNlw+8KvLkbujG
         yaa5fryVAig2pHbXhbhNOJINrPBiPlC/SegBcGCZRIxXqZR/WBmlsAc+89r+tauPBkyw
         MAZiC/NR5liIErGnbZxM9LZ+PLRfMZ4x/ycXr0WjSNBjPnz2bmQS03Ca+3fylPOGw8SN
         r4WfOK29m9No7TOVvH4k2WZUYHt5uCY4n7RuCtpKVfH3RRjczcgyHTNdk3Wgn/rbJPHn
         g4V2IypznahECYYqUo+dsnYAhUOpYdiwGd+itHozu4j/ijVmW4ZYFmyuthj7JXPfvuWa
         aDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=+Up3CEUqKdqzMHtk9NSK2HSFzqY0pkmdIxMPbg+GdfQ=;
        b=H9As7tbXOC2SGRAiIU0BscnbvGR4+sFKH4rzi22duuacAGwlo4fnWsqWihwEne9jAS
         EbkxNoiIstnpyNG6q0BmqaiPbvcJ8JEfM6T7RRW9BSnCmzIEXDTm666R9qStdjMADnbj
         BGicvzNg4iN3x60+vyrt6ra71bHHcZxEtfSFbjericX5CCMCXDQirnIMnEUD8TGvD+sD
         fovWXRn4FLPmnjJf2TLPosB6JpTPA1MgCrOrUftCxeDN/DhCqwtOpRJckWyyyIC80OY/
         cJsAUqKRpxkxbuh4ONI3m0G7PO8GSNzv5uTDgiY1YmEGyfQUHEOO7nxmraIEzeUC438K
         +7Qg==
X-Gm-Message-State: AOAM5301N7RRgH9QfApJy8juFk3pMulGD+7aHKpqj322c2az6Hq64GbB
        fD3tvVAhCcMxTYjU6umAQ6qj3Q==
X-Google-Smtp-Source: ABdhPJyF4iVvgD5fR7kMCkEsz30mfNfFufRSHSy60BVeFDwk09Ul45LD39lu7eRsXy51ZuIw8cWdOg==
X-Received: by 2002:a17:902:ba8b:b029:d9:d8b9:f2d7 with SMTP id k11-20020a170902ba8bb02900d9d8b9f2d7mr15927253pls.77.1606687867689;
        Sun, 29 Nov 2020 14:11:07 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id h3sm13888397pfo.170.2020.11.29.14.11.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 14:11:07 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <301139FC-B346-4199-B26E-1FF0CB970746@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_ED5ED905-F146-475E-98D2-1344244DB32A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 02/12] ext4: Remove redundant sb checksum recomputation
Date:   Sun, 29 Nov 2020 15:11:05 -0700
In-Reply-To: <20201127113405.26867-3-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>, Eric Biggers <ebiggers@kernel.org>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-3-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_ED5ED905-F146-475E-98D2-1344244DB32A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 27, 2020, at 4:33 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Superblock is written out either through ext4_commit_super() or =
through
> ext4_handle_dirty_super(). In both cases we recompute the checksum so =
it
> is not necessary to recompute it after updating superblock free inodes =
&
> blocks counters.

I searched through the code to see where s_sbh is being used, and it
looks like there is one case that doesn't update the checksum using
ext4_handle_dirty_super(), namely:

ext4_file_ioctl(cmd=3DFS_IOC_GET_ENCRYPTION_PWSALT)
{
                        err =3D ext4_journal_get_write_access(handle, =
sbi->s_sbh);
                        if (err)
                                goto pwsalt_err_journal;
                        =
generate_random_uuid(sbi->s_es->s_encrypt_pw_salt);
                        err =3D ext4_handle_dirty_metadata(handle, NULL,
                                                         sbi->s_sbh);

I don't think that is a problem with this patch, per se, but looks like
a bug that could be hit in rare cases with fscrypt + metadata_csum.  It
would only happen once per filesystem, and would normally be hidden by
later superblock updates, but should probably be fixed anyway.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> fs/ext4/super.c | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 2b08b162075c..61e6e5f156f3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5004,13 +5004,11 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	block =3D ext4_count_free_clusters(sb);
> 	ext4_free_blocks_count_set(sbi->s_es,
> 				   EXT4_C2B(sbi, block));
> -	ext4_superblock_csum_set(sb);
> 	err =3D percpu_counter_init(&sbi->s_freeclusters_counter, block,
> 				  GFP_KERNEL);
> 	if (!err) {
> 		unsigned long freei =3D ext4_count_free_inodes(sb);
> 		sbi->s_es->s_free_inodes_count =3D cpu_to_le32(freei);
> -		ext4_superblock_csum_set(sb);
> 		err =3D percpu_counter_init(&sbi->s_freeinodes_counter, =
freei,
> 					  GFP_KERNEL);
> 	}
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_ED5ED905-F146-475E-98D2-1344244DB32A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/EHHkACgkQcqXauRfM
H+DFow//RXl5F8obvKmq/HvaMSE5plxp8lYH94frxS0Kx1ewPD1yuVa06i+wALOQ
KQ13sC9WNi6BSJELUhtzEsc/bNvaKiaPLZBm7chO2Xp6QT6lK5wyxj/LZyS85ek+
JsSMVkKpVD75tffvD6QgoNSmnJqDyDMIOoWVXtnEv9FEAcaCyKV1QbQJSmQKodjI
+Drt7XS73bFm5BcgHbOCYGhNGG1Vuk2j9UbCOS/fK7jXfK+QazbptPDH5G3p12a/
ArAtcH6zSqJIYL1Y0bRMY3cQ7eAT17skzAIrCs1tXd0zUWtRR5GLAyBeNPmtRRce
a9NdWyb5trCtPPKZ/jSxWvzm2S2AYRlMtro90AWfM+8GVDysUnYY0uQuQVGfYctr
blQ+Zq6fspShMKvtVjAzJpeei5A5X4wC1U1Ujk/F4fbT19X7oM1NmbtWgFTCEM85
4cdXmFzutmMXbRegJO9LRafO9gdyKud5I01wd3HRpcmTVI+25Z9/JChNjuFhHxqi
fXmj88T6TUlO7YTGTHauF8yRvG78HEbp+SL4M5o1RhE4XGRfoYdnAI2Qov2P8nWp
t+NW1nvpzc14+HezsVKxLQuBXpavNcdQz3/rYPKbFhKuvznQMhiPfpUwCNq7CuW7
32H0bqLk6ccWFh9uMDqxEZq9BWxAruSyJkhJ7537q5AYCqG0o0Y=
=TvG7
-----END PGP SIGNATURE-----

--Apple-Mail=_ED5ED905-F146-475E-98D2-1344244DB32A--
