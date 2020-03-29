Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC5196A2D
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 01:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgC2ALJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 20:11:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35395 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgC2ALJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 20:11:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id c12so2280221plz.2
        for <linux-ext4@vger.kernel.org>; Sat, 28 Mar 2020 17:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=m3IIXaok1mlnP58ZyOoBrKQ2Q9MybBOnEC9ZyN9UEYI=;
        b=S4z4bs8UmE1mLktnBE93Xu9Wqa4wliQzOSVnSC1hxrBP+9sa3nmNvy7nCbzsLnRBnH
         o3ZzoWD+f+KmzCIThMWg6tqdK5WSttU7jzCMyhDsHWFBXf1KaqHfbl+Jdz+eR03hbNKV
         DcRx4sMxMrwaOKXTMNH2fw9vxkkuJLFs4eypbm0ixD3wgRvc4mUQ4Kbpj48wVhGYGG9g
         aHI4cAfaqJZBwBF+znP0PKJfKxup+9gRhQqC6cBT5XHVvvczJqerXykHRTIdMWVgbfb+
         fKVZX0Bzoc6WYsmrf365iAsOm5zGMokVXsSdY13k0lxD09Ete9i8/LPDUzF2p11h6nOR
         LDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=m3IIXaok1mlnP58ZyOoBrKQ2Q9MybBOnEC9ZyN9UEYI=;
        b=W2GAPbaRWNtCP/Pd+zCVkgr4mlz5tyO0VdU82qa4teQstyErgXL7HnldKgVpc5D9rF
         Gdr6oEvQMm+XH+TFIDgzUkpp4RgnYw/dFqsEXEiM+lFammNnf0U6CzG41d8hi+IfbFZ2
         6DtB7A7FRrbStiydOwZeHsgXgzu0r+hk1uQekRGBEqQd8sfy9//VAJO7IYB3JuUUmbnN
         YlQGznCvzIIPCHYmqIlIen0jBikLv+wC7Tp8W03wg3cPKFQNKzLcnItnLXkTAwtQv9A6
         uPPoV0DO2r3tzXfNgR6tr34UwLo6tmwn3lTBAYXszXHzr81BhgWI4FIngU3yfL23PpgG
         NPcg==
X-Gm-Message-State: ANhLgQ1XFfvm+kqP+ANuIq0e09DX64jleDQ2rmUQXBAm7czDl7U3A2k6
        hM1Yd6upJK1vsMFwhr4nD+1+1w==
X-Google-Smtp-Source: ADFU+vuR8gj+QxbQC4ohUiQPzgRhWu4l3hbnAi32Cgd25oBaBtJ6UOMopi1MHhHIeAHrFXZC2NWnug==
X-Received: by 2002:a17:902:c595:: with SMTP id p21mr6044148plx.17.1585440668255;
        Sat, 28 Mar 2020 17:11:08 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id q80sm4325780pfc.17.2020.03.28.17.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 17:11:07 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6E5C5364-4659-4EE4-87A6-A4A90FF3BE47@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E06348CF-6ECA-4914-A92E-6A337DB8E42C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: Fix incorrect group count in ext4_fill_super
 error message
Date:   Sat, 28 Mar 2020 18:11:06 -0600
In-Reply-To: <28c22b1845796e52b5fe2832432e859af023ee1b.1585438486.git.josh@joshtriplett.org>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
To:     Josh Triplett <josh@joshtriplett.org>
References: <28c22b1845796e52b5fe2832432e859af023ee1b.1585438486.git.josh@joshtriplett.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E06348CF-6ECA-4914-A92E-6A337DB8E42C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Mar 28, 2020, at 5:43 PM, Josh Triplett <josh@joshtriplett.org> =
wrote:
>=20
> ext4_fill_super doublechecks the number of groups before mounting; if
> that check fails, the resulting error message prints the group count
> from the ext4_sb_info sbi, which hasn't been set yet. Move the
> assignment to sbi->s_groups_count above its use in the error message.
>=20
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> Fixes: 4ec1102813798 ("ext4: Add sanity checks for the superblock =
before mounting the filesystem")

Much better, thanks.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> v2: Rather than using the computed group count value in blocks_count,
> move the assignment to sbi->s_groups_count up and keep using that. =
That
> makes the code, and the patch, simpler to read and understand.
>=20
> fs/ext4/super.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0c7c4adb664e..6692bc48520a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4285,6 +4285,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 			le32_to_cpu(es->s_first_data_block) +
> 			EXT4_BLOCKS_PER_GROUP(sb) - 1);
> 	do_div(blocks_count, EXT4_BLOCKS_PER_GROUP(sb));
> +	sbi->s_groups_count =3D blocks_count;
> 	if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) =
{
> 		ext4_msg(sb, KERN_WARNING, "groups count too large: %u "
> 		       "(block count %llu, first data block %u, "
> @@ -4294,7 +4295,6 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 		       EXT4_BLOCKS_PER_GROUP(sb));
> 		goto failed_mount;
> 	}
> -	sbi->s_groups_count =3D blocks_count;
> 	sbi->s_blockfile_groups =3D min_t(ext4_group_t, =
sbi->s_groups_count,
> 			(EXT4_MAX_BLOCK_FILE_PHYS / =
EXT4_BLOCKS_PER_GROUP(sb)));
> 	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=3D
> --
> 2.26.0
>=20


Cheers, Andreas






--Apple-Mail=_E06348CF-6ECA-4914-A92E-6A337DB8E42C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5/55oACgkQcqXauRfM
H+AMBBAAj/LTh6Lrtt4OLeNDp8cLpEbYJB9ZBhvtDN0S5GVtI1QSolGejY4Oyxnz
E6kwyPccmveo9fQZf6ljfIqlCfa+noVXoHocgLLa8Ky6jZokcpXsF1Dx6qjJHhfD
7DIRxiyMXRJj3hAimAVpscUGpDD+URTVFvDqdHyFy2mVPe7/5vAFPin82L69MTwj
qMUH1B55k42dcgRPeMSsguuxW/AJeMyEj8zaw0R1zjOj/Itl/rHJbWHEzgMKrAIh
QEcqjhHy+kk/5MPKyfWS/tseNN7nCr0sAQWTxxeJTBh8/Ut8ZQyWGOuNejVyS5T7
wje9AcHbqc+ZFnPYXg9XE+/f9uzgiY/i+AlDasLOJVhig3Prcn/iqA03p/BUlXW0
C81ZwERlWnriwh1Rq31LRfGELl5SBawsSQimkceUNt+fpLFYKw8enIV55uxHip5i
+VFLzuj22xrBmcycQGHxh+J9oVU6974QKcP4GGDnPhg22VDqiTj20pKuCusR1y2B
QXlYZmONh+WPlzkEbvkdjiCrMitqjO807n12unAbwjdjILgmhXwlu2YGle839RQ+
97EAW7pG8+9VivFJjfXbKni3GUZtzq6BiY2iN5bYyL/a1iL/aZvpG+cVJ8YnWYXg
YGOZaIgjFOo9QsNI2+3RUIRDMrJbfsG8JcqiD+zR2VRYwaHk9lA=
=LAwm
-----END PGP SIGNATURE-----

--Apple-Mail=_E06348CF-6ECA-4914-A92E-6A337DB8E42C--
