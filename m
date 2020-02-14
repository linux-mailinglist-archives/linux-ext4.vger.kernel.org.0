Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7548915F6D7
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2020 20:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbgBNT2c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Feb 2020 14:28:32 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43150 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgBNT2b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Feb 2020 14:28:31 -0500
Received: by mail-yb1-f194.google.com with SMTP id b141so5298979ybg.10
        for <linux-ext4@vger.kernel.org>; Fri, 14 Feb 2020 11:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=kyAp1Cl4An9xXHIWaPMNLdZYqrrBlwFKLJsn9VAoJEk=;
        b=OATd9etqzTy/BLE1XRf2cY7zMBX+MoR0fIXSI4eve48vl1wXHx8YYClK2QBPzKITJV
         7LoSOene4PI6T6fg1Ln7ofp4cZeTiHMwBnzuSko6xZ1Wf3FA5Q6mqDY591nT6l0yk9uK
         np0InBFiTkJ5t++fpgvJvKjzhrK526wE/qsl0szG005xkziqxoSn49SBbGT8vaGwwv4b
         QWZuFIXqt+5LZCUkflCUHlPiAxFlU43XniK6I4h42tgSy/20BPAHWM1q/IxLbteVz/4/
         txftkyzwxx38We35x5RB9XSUrYrxTBIpLrobu38t4feuuq8g8gXOcUZnQWyUuD8mqBFg
         TF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=kyAp1Cl4An9xXHIWaPMNLdZYqrrBlwFKLJsn9VAoJEk=;
        b=crk7QPKQgF1f/12nvjayFWbrIPxRv2hyTQU/nTXBJVoHvtxPyi4cVO2m2g2VxtjjjN
         8uxjtmkGbfLForTKkNu9GJYdHqXIza3LPz8R/nFf5vivk6DVbD2QnHnhgETAsJI1a768
         /OVjctUxZlysuXh3Y3x1zzQnueqfittq8Qkbf7Yg/0/DHGeWKO1Oyqivs+CNn+SfS85k
         Eh3QbXdvkOXNWE4psw2C6qcddSW+uozS37zTO7orVJWsFyR0r1Xodt5QimR+mdywN667
         2bbHp3UHwvqXqD6fex5lw7eOH7nUeg/MmWC3H6c9ySmV7Lx0l4U8NKP7Dje/4KVgbF6B
         UW2g==
X-Gm-Message-State: APjAAAV17ALn8xQLDFlk4pHxy0IZG/AgNxiuY6Vvsctep+DFv7veL0qg
        sywPYgp/Ei3wkFVvcxrFhleSrg==
X-Google-Smtp-Source: APXvYqxVk2zcCo3gjMCxLPYpDJ4qXxgSgSF6ObjUnTP/NC4mKSTqfwfOYU/s6Rnknj+k+8q0I/Y8Gw==
X-Received: by 2002:a05:6902:6c1:: with SMTP id m1mr4404565ybt.491.1581708510758;
        Fri, 14 Feb 2020 11:28:30 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id g190sm2782568ywd.85.2020.02.14.11.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 11:28:30 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <56FB428F-761C-4387-8323-BEA399412A76@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D177D16E-21ED-44A6-B446-6CEF76F116E9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/7] e2fsck: Fix indexed dir rehash failure with
 metadata_csum enabled
Date:   Fri, 14 Feb 2020 12:28:28 -0700
In-Reply-To: <20200213101602.29096-3-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-3-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_D177D16E-21ED-44A6-B446-6CEF76F116E9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 13, 2020, at 3:15 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> E2fsck directory rehashing code can fail with ENOSPC due to a bug in
> ext2fs_htree_intnode_maxrecs() which fails to take metadata checksum
> into account and thus e.g. e2fsck can decide to create 1 indirect =
level
> of index tree when two are actually needed. Fix the logic to account =
for
> metadata checksum.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/ext2fs.h | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 93ecf29c568d..5fde3343b1f1 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1783,7 +1783,6 @@ extern blk_t =
ext2fs_group_first_block(ext2_filsys fs, dgrp_t group);
> extern blk_t ext2fs_group_last_block(ext2_filsys fs, dgrp_t group);
> extern blk_t ext2fs_inode_data_blocks(ext2_filsys fs,
> 				      struct ext2_inode *inode);
> -extern int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks);
> extern unsigned int ext2fs_div_ceil(unsigned int a, unsigned int b);
> extern __u64 ext2fs_div64_ceil(__u64 a, __u64 b);
> extern int ext2fs_dirent_name_len(const struct ext2_dir_entry *entry);
> @@ -2015,9 +2014,14 @@ _INLINE_ blk_t =
ext2fs_inode_data_blocks(ext2_filsys fs,
> 	return (blk_t) ext2fs_inode_data_blocks2(fs, inode);
> }
>=20
> -_INLINE_ int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks)
> +static inline int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int =
blocks)
> {
> -	return blocks * ((fs->blocksize - 8) / sizeof(struct =
ext2_dx_entry));
> +	int csum_size =3D 0;
> +
> +	if (ext2fs_has_feature_metadata_csum(fs->super))
> +		csum_size =3D sizeof(struct ext2_dx_tail);
> +	return blocks * ((fs->blocksize - (8 + csum_size)) /
> +						sizeof(struct =
ext2_dx_entry));
> }
>=20
> /*
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_D177D16E-21ED-44A6-B446-6CEF76F116E9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5G9NwACgkQcqXauRfM
H+BQpw//W3NYnLQcPSMrJfgIFlh+nST1mudK4rQtF6Uxdo1k8yPEisDXdQjeY9lz
91JYzmqGjXVEHcbgY9lNreRLWQVP1+aQ0yrWrBbngPimO7jPonJ8lJlkRsgRdftd
Egt+tz9RMVje++sBif7rdpCzwkPnKZQpYaRBKjASBDDbDrG9mgFTmdsn1KEoRLQs
X2tHkuBTJLeKfAZMZKOkAAqc5LIVWm7Mu0WCDYJd/bMGO7N3p39nkuEY9PzrfsUV
6o3J3DOGnhhPALtilpR5FVAPAxN7/t4lXGVKzuEebmrFxUsTXHJiJzzu1fheqK9h
p0EAZDaAY2VGr61DwtNi2G+lDp/RJH2ipS23X6OkYwSSwaXLFDSPIEnLLOobl4TG
Nm2Hl4F1OtSx9W5Hr8VLPn++QWZFD+coEKqEHaFGevhkqrLGDW9VPkjRV89/Lp5u
m9dLzY4ChqwuokApgA085kYZDUMF0CRSS5uye+VCpBTvcX2ij87taqWb8FRT61Ek
NJNWgTWBeLVJdjDCx6K1ppzwiMdo+sczNpw4WJhjcs1Z+1g4YdsSermfnbUWiwa3
GNhHryfew2Jyq0hQ7Q1HLpoTElB1KG4cIgvzKIJZs/+QyIZkO5Q2Wim7HSaCK05b
k9DG3Xsw2RL6p7Ho5rRLxmFuc7gOUPPu4cPzBndh+bzS2zzE9LA=
=xM5i
-----END PGP SIGNATURE-----

--Apple-Mail=_D177D16E-21ED-44A6-B446-6CEF76F116E9--
