Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AFC149D22
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2020 23:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgAZWGl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jan 2020 17:06:41 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37887 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgAZWGl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Jan 2020 17:06:41 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so2300886pjb.2
        for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2020 14:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=twcO08LKFhdf9qgWgwX6Ct1OdN5kGlBVu1nU7xD+0So=;
        b=y1Fd/JMaaJ0/xhFM9XGQppJxUV8k2sRe7Uqft9MYhzU5ypPkBYNBnNqBAYjTEdHssm
         1n2jBkXfimDhRh5JmcA0ycj1HCzSWvAC3dLZIS3m8vacgP/mvsvKe5OeEJ216+BTrHiX
         +WnV64+oVHYvFRaRdH/PoSyVPAfO/0FUxtSR1NVpsFQe4Nm//VmG5cFYqahPNBCzbU/J
         Z+nH04F+8DGOkEjkQhqzQCKOVk7v+Z26DzxTTuLJBl00/L3GbsEPP/TAQAIjgqP10t2v
         40AHVlSfW/zQWzByTZ6SeqfpUZO2FyRLcSpLmsHZ2um5ZqcWpfm3MV9egkhvJ0gG5FWc
         MXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=twcO08LKFhdf9qgWgwX6Ct1OdN5kGlBVu1nU7xD+0So=;
        b=sQpBRXRjBS5nr9JQ4Q5lYgs1hq7r2O7kZO1kHQf/9kglfage72tzEruQYX5Z+udQOV
         GgJCr8pr3kcqqXNzoaq692HUtibEqxdZBxkV3O5/ykVYRLZ+CRMQeRzb6njnzarkDFNt
         +LfrfrbqfRAniQmIx6lAvek/rrAGO2+ov/CaHYu788EW6HdKWqdi58Ex5WPfNkGHxmSI
         kV+Qia4W074phxpbB8EHBQDZ5LvhL/j9jXL7gX7RcQr2QgUjZPBVNsOr4JiYO3DqkF3v
         rfnzgzbjlRKSA5X8mtG4xL/MX3s8BbQjO/kJZf3dx7RpEvhDM6H+UbesJTGI+thyggRw
         qnBQ==
X-Gm-Message-State: APjAAAUkJ/xGMZn1wTp1gEiAbCvQd3dMQ7vVg2zC6O4AZv11MeoqEKd5
        5GiVSSSfShEkR1Q3WzuI07EoJDQZdMQ=
X-Google-Smtp-Source: APXvYqw5rGsiYBx5QrhxltabMghe71nDLw1H3n+DhZNU747WYr3TzyLzhDlNnuvjvrUhBv2DPacAiw==
X-Received: by 2002:a17:90a:d995:: with SMTP id d21mr11346058pjv.118.1580076400042;
        Sun, 26 Jan 2020 14:06:40 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id b15sm13414371pgh.40.2020.01.26.14.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jan 2020 14:06:39 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D5CCD904-C596-4C05-B665-D28C63844D12@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1EF52DC4-BF54-4741-902E-B0581D096981";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: don't assume that mmp_nodename/bdevname have NUL
Date:   Sun, 26 Jan 2020 15:06:36 -0700
In-Reply-To: <1580076215-1048-1-git-send-email-adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
To:     tytso@mit.edu
References: <1579983942-11927-1-git-send-email-adilger@dilger.ca>
 <1580076215-1048-1-git-send-email-adilger@dilger.ca>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_1EF52DC4-BF54-4741-902E-B0581D096981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 26, 2020, at 3:03 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> Don't assume that the mmp_nodename and mmp_bdevname strings are NUL
> terminated, since they are filled in by snprintf(), which is not
> guaranteed to do so.
>=20
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> ---

NB: this is v2 of the patch, which fixes the checkpatch warnings.

Ted, do you also want an ext4 patch with EXT4_LEN_STR() and a change of =
these
char strings to __u8, along with similar changes to other =
non-NUL-terminated
strings in the superblock, as was done for e2fsprogs?

Cheers, Andreas

> fs/ext4/mmp.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 2305b43..9d00e0d 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -120,10 +120,10 @@ void __dump_mmp_msg(struct super_block *sb, =
struct mmp_struct *mmp,
> {
> 	__ext4_warning(sb, function, line, "%s", msg);
> 	__ext4_warning(sb, function, line,
> -		       "MMP failure info: last update time: %llu, last =
update "
> -		       "node: %s, last update device: %s",
> -		       (long long unsigned int) =
le64_to_cpu(mmp->mmp_time),
> -		       mmp->mmp_nodename, mmp->mmp_bdevname);
> +		       "MMP failure info: last update time: %llu, last =
update node: %.*s, last update device: %.*s",
> +		       (unsigned long long)le64_to_cpu(mmp->mmp_time),
> +		       (int)sizeof(mmp->mmp_nodename), =
mmp->mmp_nodename,
> +		       (int)sizeof(mmp->mmp_bdevname), =
mmp->mmp_bdevname);
> }
>=20
> /*
> @@ -154,6 +154,7 @@ static int kmmpd(void *data)
> 	mmp_check_interval =3D max(EXT4_MMP_CHECK_MULT * =
mmp_update_interval,
> 				 EXT4_MMP_MIN_CHECK_INTERVAL);
> 	mmp->mmp_check_interval =3D cpu_to_le16(mmp_check_interval);
> +	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
> 	bdevname(bh->b_bdev, mmp->mmp_bdevname);
>=20
> 	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
> @@ -375,7 +376,8 @@ int ext4_multi_mount_protect(struct super_block =
*sb,
> 	/*
> 	 * Start a kernel thread to update the MMP block periodically.
> 	 */
> -	EXT4_SB(sb)->s_mmp_tsk =3D kthread_run(kmmpd, mmpd_data, =
"kmmpd-%s",
> +	EXT4_SB(sb)->s_mmp_tsk =3D kthread_run(kmmpd, mmpd_data, =
"kmmpd-%.*s",
> +					     =
(int)sizeof(mmp->mmp_bdevname),
> 					     bdevname(bh->b_bdev,
> 						      =
mmp->mmp_bdevname));
> 	if (IS_ERR(EXT4_SB(sb)->s_mmp_tsk)) {
> --
> 1.8.0
>=20


Cheers, Andreas






--Apple-Mail=_1EF52DC4-BF54-4741-902E-B0581D096981
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4uDWwACgkQcqXauRfM
H+C0sRAAjDsJnz5H/dxITWweK97Roh0D/3D83pVN1fb7ZzvqIe16APR45SoYszjx
zK7sVXvTCSWfS31FIFJ6q5lw+9bJKxohU/WkkCQDH73fO5PyNVjYZo/73ggWAiyZ
Sl8FhWvaCMxQKDBOuBqU11VQiY85VtKtXm9mgFNUrBSwf/15q3Kv/Yl2Eu8MYUzq
QvxWNeHQc0n0cAX7QIcm3q58J4PI3+bwpKyl8GWVccswW5QpPjzBzkcAZ1xff4R7
ds9trXOaGZWilJLnmTezwHrH33dRKNFV6h39f5SBE/uHn6/v0Xtr+Ilsr+ooTWl+
e46NcWcg9oBg19AqQqHOc86x5jbvu0UdK675yGMWKZbH4U6Cp0K1nTAMaCHCQf9g
MaX5mHMzrwZ/tFrpkdlFpIhhxgguI11wxR0Iohw7MK2euAgtxzIrp1LMjKLUu4K1
h1LvYtew2u1YoCcFjtgqgm2/LW4XrIhwzdffwUejjcbtmx3ODvLQI/qaiLxk7iyt
4dscBGQxROT07dTiHnnvzwGGn0CpwRNpbjXAvHr7JpB8VnU52t5sM1cb4eJ1hQcl
BJ4OXMdrp0J/g9EYw1/nvwV9oGjJYUBOiXLpJnD7jlf4fXJuyAeRcqLa1U1iRbsH
pxyuadpI1pb8pDRsV/ttXHxgWsHoKjyaSfwphClR7ccfprAIXrs=
=kq50
-----END PGP SIGNATURE-----

--Apple-Mail=_1EF52DC4-BF54-4741-902E-B0581D096981--
