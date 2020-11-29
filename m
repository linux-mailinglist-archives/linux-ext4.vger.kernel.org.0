Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32252C7B6C
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Nov 2020 22:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgK2Vj6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Nov 2020 16:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgK2Vj6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Nov 2020 16:39:58 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F41C0613CF
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 13:39:12 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so8833601pga.7
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 13:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=gqMMGCwx0UeUP2eTz/0/aDqd2b097efVtaK//OXH1Cg=;
        b=ywqTYRWdL8UEo1UBQVFAcCTW0BdkuN9WBOC2/o/80Aebyu6RmBu+eiTxoAArTyYCY9
         pi4lr2Sw/PQGtbNdxG2mHnqdOypyw+Y1dRjF0cPJKd7vTIEb0PHF8hukRqIqHYm03V2F
         m8286QQwWtUPfMsnv++HqdPkoLGrQSWTTXm3ydi//A4Q2xOk2IO+GgoN2v8MLQ1cp9ig
         DC2hVRhtnAwaZ8NUzj3ZDhPfKTnLlzB3uB5VmnmXiuM4rUeR3Tjlt+FxEDH3Qxxd99si
         wasHYGvsK+3CcVoxXHEgBPWEOW43OHopIRVWggNrZropQxhXrREoYe8/2zz/MUpiqYoB
         xlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=gqMMGCwx0UeUP2eTz/0/aDqd2b097efVtaK//OXH1Cg=;
        b=hM+fbkO1u343QFDzdydz77PdIQBKtOdqgtetg496OgtR/RQ3kBsyc6lHlF++A+EEGe
         /bOQmakw8NmG5HCMTgLAJ5I6uBPYgyllvYZl4YUDilYe3qnmcuB1A+10HXuo7D+tP5EX
         cS0XukhZ4FkU+o9zFsEunv6KijGrdFRIAFmp+/Xf560E84TB46KA+QaCK5kSofw/zniZ
         vtScyR83oekESmym7GWMIJxyd/LKN5BXvJn1GN4zei+ntsMUB+PFsS3k2BQF069zMNLt
         kCSKyF+cjsE7kl5VziTaSFj7F+7wW+MPgQyJeLxOYnIzb+LYNH+o0Ep4rqq0DqcP2wyQ
         UX5g==
X-Gm-Message-State: AOAM530tITSlNG/o0ITF+lZjsw/ethCpIETCvjTGAOtWSqNr/aooQuzQ
        OH8zhUjIpuWmOM4PfEJ03KWpew==
X-Google-Smtp-Source: ABdhPJwS51EFAJKNCo3xg6EfUGT8U51nzmWbp9uBjTREwWhfDF2i2e4G+i3Q28OaAi3yfTInT+BIXQ==
X-Received: by 2002:aa7:8052:0:b029:196:4dbb:99fe with SMTP id y18-20020aa780520000b02901964dbb99femr6544054pfm.11.1606685951754;
        Sun, 29 Nov 2020 13:39:11 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id v1sm19541791pjs.16.2020.11.29.13.39.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 13:39:11 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BD3A18FD-0FEA-4252-9DAC-81DA9F9F160A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5EF2FD0D-AF00-4DDA-AA85-B57DAA6ACAFD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 03/12] ext4: Standardize error message in
 ext4_protect_reserved_inode()
Date:   Sun, 29 Nov 2020 14:39:08 -0700
In-Reply-To: <20201127113405.26867-4-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-4-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5EF2FD0D-AF00-4DDA-AA85-B57DAA6ACAFD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 27, 2020, at 4:33 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> We use __ext4_error() when ext4_protect_reserved_inode() finds
> filesystem corruption. However EXT4_ERROR_INODE_ERR() is perfectly
> capable of reporting all the needed information. So just use that.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

I'm not a big fan of EXT4_ERROR_INODE_ERR() vs. ext4_error_inode_err() =
and
some of the error macros being upper-case vs. lower case, but that is =
not
the fault of this patch... :-)

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/block_validity.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 8e6ca23ed172..13ffda871227 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -176,12 +176,10 @@ static int ext4_protect_reserved_inode(struct =
super_block *sb,
> 			err =3D add_system_zone(system_blks, map.m_pblk, =
n, ino);
> 			if (err < 0) {
> 				if (err =3D=3D -EFSCORRUPTED) {
> -					__ext4_error(sb, __func__, =
__LINE__,
> -						     -err, map.m_pblk,
> -						     "blocks %llu-%llu =
from inode %u overlap system zone",
> -						     map.m_pblk,
> -						     map.m_pblk + =
map.m_len - 1,
> -						     ino);
> +					EXT4_ERROR_INODE_ERR(inode, =
-err,
> +						"blocks %llu-%llu from =
inode overlap system zone",
> +						map.m_pblk,
> +						map.m_pblk + map.m_len - =
1);
> 				}
> 				break;
> 			}
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_5EF2FD0D-AF00-4DDA-AA85-B57DAA6ACAFD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/EFP0ACgkQcqXauRfM
H+CwBw//SW1/uYD62YGxlhSR8crKT3VLH9cI6Ib9rf9DErtLEPLnuNhM7FYikn2W
1bE829aQhsJmSwgAicl3zxc94fMuZLg/2JcFR2eQjg5X5cC6UspRcxMfCLCEvK5e
rARDN8rF3DRkQxPgzQT3Z26XGx7nhnysVCPd4xPUzr+qhIQKs6wf95+47eNccGyU
akeBaiEUGPqk26Elav/d2IAv6abER7AApmD1Q5+8Lorn7USfnasAy4opnUJonwj3
868wLFVcxiyZyLEPgUK+uhtMZMS0U8I1VSdLfFR78wjVX9kwnsPNHk4KLt12iwnR
wKEHEbqDsqzmYORpuqtYhBZ5BY5SEkFm0RPXvhhsdEbJPK0IbxjnNmhZBRNIbFLi
YUApbYxDfCCOMuxMGPyl+emy1IH9pQkDDgrPFbPOVOOJaIXUReoTA9NuwMWEIoj8
FOINOLZJQjB7fzkGuhrWcmSUaGt/ai41Oo7S3MTXBCPWJgN/kaV2OowcxHng+hCm
74LdIOrZ78UFyKAQUz7Bog+c73K/X9dLjaUNINtUmOhGODfjgu7PGday6OUU9bBI
+C5bsMoPigLMUzO2RMXn121luE7T0ATvGztFoYxRhRiUNH0bQnxuTpj85BISByz2
qjVpSuq71jVECnf8AjP0BdXY40xfkPAGa+4DICw26+6V9MQtot8=
=cmtl
-----END PGP SIGNATURE-----

--Apple-Mail=_5EF2FD0D-AF00-4DDA-AA85-B57DAA6ACAFD--
