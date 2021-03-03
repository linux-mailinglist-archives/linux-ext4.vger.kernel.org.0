Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C5832C89A
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Mar 2021 02:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbhCDAuo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Mar 2021 19:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388004AbhCCUVU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Mar 2021 15:21:20 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C4C061756
        for <linux-ext4@vger.kernel.org>; Wed,  3 Mar 2021 12:20:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g20so14705809plo.2
        for <linux-ext4@vger.kernel.org>; Wed, 03 Mar 2021 12:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7ZdxYTJqQkqST5DFZI61Y7sfP4/AKj3ycOEjkcGuO9U=;
        b=xeQmXdtJZ/ft/xZsT8Y8xGLSrHy4nLf0j/S3/LPM6z9BMelmQOUccOD1YPYA2iHJOC
         OdbhXlIZ/z/V2zU8xiJx5bTPCaBOGdrYeczXPdA/35xUMg40AytQ0+1NGhHW+5guHKvN
         2kzfR1g2Z/R2RpjkvmuGor0jh6ups311cibBT9u3WWhWnOv9xZ77qczuzvU1hv/rQcxk
         VElz71n8sXUtrPs9L6z2Xpv5ZIVMpTvML7EetlyQsm+DggKyoBpdeeFfx6osmr0ibNsl
         fjcdHW+MbcMVryZ5u/78H04v0eV3+0DZnjUI4tYC9iHvLzjdheKeHVC0FhZ5wv72P7II
         51ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7ZdxYTJqQkqST5DFZI61Y7sfP4/AKj3ycOEjkcGuO9U=;
        b=gnUS9YZU6MaU/+/sitJTbjof+lB0uS/cJdRfVKiS9V3Gw5fxKrcmpgikJ2PEyryyp1
         XnUjtkopYa8TpBwAljn8LaPO0bRRWYQIZycUVA8bb2xtDz3vu1YBf2fTdnORBa97TuJ/
         YgXy91vz0pa7RnbWjfl3IuufAwTsVu6ll8S0iV+M+kM+j8fNbvACqMGpGYGxnHsMAJGQ
         YXqfbzOLZ3F2jm3/d4SQboGzwVuRA9quNhnw2Gua6L5rtd1nogZzucPUJ7yzsbK70yi4
         qfTtjYz3gU4UvhhYZ2LkDcoWaA5ZLgBbWLJVmMbYnYG3Po1J2Qy6a1FDk4gyXbdhn4uJ
         m81g==
X-Gm-Message-State: AOAM532VNqotEFsPpXNprnZOcRWzU7nbVDfP+42LkXux20hJeXdG7ZgI
        ROzsmOCXqAgL5prmSYfxkumNY0PWx+ht0D37
X-Google-Smtp-Source: ABdhPJzmPH0hiYPUhdcfga4ur9iKTuJ6+YHVMuTMgFWE+U5hoIT+ZdD4uVzQEqbjR84eGbqutwojTw==
X-Received: by 2002:a17:902:bc87:b029:e3:f6a4:db39 with SMTP id bb7-20020a170902bc87b02900e3f6a4db39mr632621plb.25.1614802839171;
        Wed, 03 Mar 2021 12:20:39 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id y19sm3420115pfo.0.2021.03.03.12.20.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 12:20:37 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F8991EA4-20AB-4785-83A6-8BC159EF3970@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AB2605A8-A13B-4175-B9DA-6F452C1BFACB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] misc: remove useless code in set_inode_xattr()
Date:   Wed, 3 Mar 2021 13:20:33 -0700
In-Reply-To: <0949867f-5ed8-6a51-1b8e-b116b833ef22@huawei.com>
Cc:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        linfeilong <linfeilong@huawei.com>,
        lihaotian <lihaotian9@huawei.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
References: <283210da-b281-2dd7-6ef7-b31e81e72e01@huawei.com>
 <0949867f-5ed8-6a51-1b8e-b116b833ef22@huawei.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_AB2605A8-A13B-4175-B9DA-6F452C1BFACB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On 2021/2/26 9:22, Zhiqiang Liu wrote:
>=20
> In set_inode_xattr(), there are two returns as follows,
> -
>  return retval;
>  return 0;
> -
> Here, we remove useless 'return 0;' code.
>=20
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> misc/create_inode.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/misc/create_inode.c b/misc/create_inode.c
> index 54d8d343..d62e1cb4 100644
> --- a/misc/create_inode.c
> +++ b/misc/create_inode.c
> @@ -234,7 +234,6 @@ static errcode_t set_inode_xattr(ext2_filsys fs, =
ext2_ino_t ino,
> 		retval =3D retval ? retval : close_retval;
> 	}
> 	return retval;
> -	return 0;
> }
> #else /* HAVE_LLISTXATTR */
> static errcode_t set_inode_xattr(ext2_filsys fs EXT2FS_ATTR((unused)),
>=20



Cheers, Andreas






--Apple-Mail=_AB2605A8-A13B-4175-B9DA-6F452C1BFACB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmA/75QACgkQcqXauRfM
H+CC9Q/+MKKSeAFCzBQEaWsBv3LHyHJ53sasd0dxjRVFUZQOTZj5Nr4DUip5uVbc
r9Ie7YfIOxakF2urUX0eE+R5Rnq6+6M+h5g+4DlyZaL42kCM8Qhx5m7fNKGnosgk
RnyMc4CYVWhWumsFzZX6aI0DnTc04EXVPw5GI2WfUNK+nqfzNsAxNe2hcpMJ1ZiO
u7RvU1BxoIIMsKuG470Ld1qUru8DB7s3hWS4p2goYyAcHlKC2XcIQdQ2y+AOT4Q8
ZE/3eVaMNFna6WKk4uj+XIKn67gXQ4s+M9UgagBj/vl2Amm9GekWhSwbSbG8sKqD
eKAMyYdW6ljkMhC31IZzPi4E+LPhnPRScSUPTaL8kENj1KX6VoLescqBjAhX01uI
wZXAXpqSTXXunnjJqtJC84DtEKAX6aaMbvx3Z+cOef32UXOTzXbz0KvnWl50dJ6k
MIQwU1HtoXP5bP4npZepfHcKDVIc8YIcQPsUqa5JlaXvXMjSKIT4kNhn8v6BZ/ML
cClC1Z0TFOIO9VsviRYr08dirKccP9WzigvC6XK6KHdw1TnR+U0mPq3MRQwfbm7R
WPgkzhQPAPR5kIdXEpatukiC8Aino6crCLBcl7Uu470XDoRDPG/enjSpBB+3+0Cq
pAeVpZZNBgJ7FlUhR7VvJAARgjjNldPmzTMd2/tAu7UIrRTSxvI=
=DmQ7
-----END PGP SIGNATURE-----

--Apple-Mail=_AB2605A8-A13B-4175-B9DA-6F452C1BFACB--
