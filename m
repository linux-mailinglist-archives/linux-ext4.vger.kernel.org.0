Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2931F229
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Feb 2021 23:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhBRWVN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Feb 2021 17:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhBRWVH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Feb 2021 17:21:07 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4729C061574
        for <linux-ext4@vger.kernel.org>; Thu, 18 Feb 2021 14:20:24 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id a24so2053792plm.11
        for <linux-ext4@vger.kernel.org>; Thu, 18 Feb 2021 14:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7dL31VOPhlVadC559CXIzXukrd2htPN/kcjc/U18jII=;
        b=OJoQlDhkrzzJLeLKHIjTlV13nhjMsuB6mAr9GD03Ae6JsIin+iYjdZGiauYoctAADb
         dOwRofpk9eIvHmP4O8O5VgDMgZutm4sAlrY5NUFiu6TarBaCrf2lNANftzTNRZMdJgm/
         GpBbISwcvRqweGxbYnHAKUYVAXb81b/NAKaBA6x4moLD6SjfkDGWfs3J2kulyU3UvqxR
         wlu7dWfmTewuNuQ5oUeUfRfqSV+R9ea4WdkVNvSY9txGBtrb8kLI35RlJhF2QwIOkoQ6
         Fk8p7JWUYkyPuyGY7xZ+sbrN5WHavSlHXdUeoQ8v1d0r6SWTyQlHRVc7PumvWKn9Octp
         kNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7dL31VOPhlVadC559CXIzXukrd2htPN/kcjc/U18jII=;
        b=RY5w0EVV6zb+j+7YXA9D7DvzlXMiGBlrUPHgvY4kNXgEy832f68v98DpIGl3N5jsPe
         V41NvbtiuV3toXfhGYM8TybdTO7Qs83gd/wtpT4DpuTorz5f9zGyVjzrg0a87PSlpvpl
         7Ue5IzIsXh8bIjxbeGA7FOTI9BzvsaFsoDSqXw78mB64/yRdr5+CV2NfMThdkKcqV0RQ
         NlUpAH6uOlACg0yS1/emMPeh75bU10YQmvqCXI2fy/e2OUfv3U9gFAkU6QakXAgNoTtY
         B0FAoop+colLLCLYrXSIvUhGoMG6DpI5CHNpadtp6xEOuE/NBwMJr3N1yAP89HLT28kf
         hn2A==
X-Gm-Message-State: AOAM531bPqy6wN26ITBddVBEZsvTh6n+Z5z+cmqqWgnKWuWbNg0cV/4h
        nkax7GgjWH2uNydKY9ncpJJIGQ==
X-Google-Smtp-Source: ABdhPJwux4s00nAWV6vOoLrTqoSpMC5IEmAw0aCxzR49O7UbhqwWqzFpH05ZokZ4cySQDW2kLTqnNg==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr2324753pjs.38.1613686824036;
        Thu, 18 Feb 2021 14:20:24 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 6sm6751104pgv.70.2021.02.18.14.20.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 14:20:23 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BF8274AF-A9C6-40F4-8B99-FEBA82878C36@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E2514ABE-4A4F-43EC-9362-AB76336AEC10";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] mmp: do not use O_DIRECT when working with regular
 file
Date:   Thu, 18 Feb 2021 15:20:20 -0700
In-Reply-To: <20210218095146.265302-1-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
References: <20210212093719.162065-1-lczerner@redhat.com>
 <20210218095146.265302-1-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E2514ABE-4A4F-43EC-9362-AB76336AEC10
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 18, 2021, at 2:51 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> Currently the mmp block is read using O_DIRECT to avoid any caching =
that
> may be done by the VM. However when working with regular files this
> creates alignment issues when the device of the host file system has
> sector size larger than the blocksize of the file system in the file
> we're working with.
>=20
> This can be reproduced with t_mmp_fail test when run on the device =
with
> 4k sector size because the mke2fs fails when trying to read the mmp
> block.
>=20
> Fix it by disabling O_DIRECT when working with regular files. I don't
> think there is any risk of doing so since the file system layer, =
unlike
> shared block device, should guarantee cache consistency.
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Reviewed-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> v2: Fix comment - it avoids problems when the sector size is larger =
not
>    smaller than blocksize
>=20
> lib/ext2fs/mmp.c | 22 +++++++++++-----------
> 1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
> index c21ae272..cca2873b 100644
> --- a/lib/ext2fs/mmp.c
> +++ b/lib/ext2fs/mmp.c
> @@ -57,21 +57,21 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t =
mmp_blk, void *buf)
> 	 * regardless of how the io_manager is doing reads, to avoid =
caching of
> 	 * the MMP block by the io_manager or the VM.  It needs to be =
fresh. */
> 	if (fs->mmp_fd <=3D 0) {
> +		struct stat st;
> 		int flags =3D O_RDWR | O_DIRECT;
>=20
> -retry:
> +		/*
> +		 * There is no reason for using O_DIRECT if we're =
working with
> +		 * regular file. Disabling it also avoids problems with
> +		 * alignment when the device of the host file system has =
sector
> +		 * size larger than blocksize of the fs we're working =
with.
> +		 */
> +		if (stat(fs->device_name, &st) =3D=3D 0 &&
> +		    S_ISREG(st.st_mode))
> +			flags &=3D ~O_DIRECT;
> +
> 		fs->mmp_fd =3D open(fs->device_name, flags);
> 		if (fs->mmp_fd < 0) {
> -			struct stat st;
> -
> -			/* Avoid O_DIRECT for filesystem image files if =
open
> -			 * fails, since it breaks when running on tmpfs. =
*/
> -			if (errno =3D=3D EINVAL && (flags & O_DIRECT) &&
> -			    stat(fs->device_name, &st) =3D=3D 0 &&
> -			    S_ISREG(st.st_mode)) {
> -				flags &=3D ~O_DIRECT;
> -				goto retry;
> -			}
> 			retval =3D EXT2_ET_MMP_OPEN_DIRECT;
> 			goto out;
> 		}
> --
> 2.26.2
>=20


Cheers, Andreas






--Apple-Mail=_E2514ABE-4A4F-43EC-9362-AB76336AEC10
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAu6CQACgkQcqXauRfM
H+AfrA/6AlAX/kkYCPnCcpYYpst5OnhqVuognTepTiqomM6muVFmDvgGx4R4EsQC
Fh3CkrWzmieqSg6VeocYJ78zqei2+nfyng6dAWCJBjXwyQSQw5OFdffV6pUNMduZ
Sbq35k1ChjLLgiFOjG9zy5eezbhnbsKiB7E0FDCthAXMX0QjOPQr/GUyvEm9yUb0
nincySQSIBg1kIyRs4sYyVeHoxflEuMmvgHdCcXD6NmOFoSS/VRN6XfQTYqnsC7l
FAgrC8wUB8h9iPZezjuF9TRtmFcrtyjQEcVRKm3CiN0hdE+ZFnJXRLmK58AVww1p
w33F8Zu52Wap+P6TGkFgvQcQR/KpFGvIIfcfu5ze7hWyOu70TMXkeQjKL21sfCtc
8rVKBjR++jxF+g8QM/Lgc48qOMuUTCJXN9yRk6+NFlgRt7TcbG/vAqfciwrtZa5w
GBS1w8VWXXc42N+0bWG9L10zYvFTDxYV/qowl7aVjFyKtLyrsT2Qr8Gh23iI4nuK
dbem1yuv0mmciI0xzQnImLGKtAOdT0In/mHO8xOQjhSv0aT0XEWecHMCftyMHYWr
xcslkd/MIEu0hqCzya2nZa9nE6uzaVjTcZmyYxdN/U8xPLbGyqCdWfwjmTM81Gde
ZgqxsqOARuvPIGDNBSiof2yqyyk61YQLX3DnLBxVgxQx7aNKJyg=
=VClU
-----END PGP SIGNATURE-----

--Apple-Mail=_E2514ABE-4A4F-43EC-9362-AB76336AEC10--
