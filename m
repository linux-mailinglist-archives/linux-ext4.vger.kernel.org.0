Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83876243172
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 01:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHLXaA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Aug 2020 19:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHLXaA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Aug 2020 19:30:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07085C061383
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 16:29:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e4so1896391pjd.0
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 16:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=lFqzeKGk7dHMHc+JuNTo8490OuMhpogMsgJyKdG1jBY=;
        b=r6pW7ZG1X4ys4a39dLgeWIWvJfv5ifYddmqucep1h/vvT6/l39evWDfV23YIE4i6SS
         /D1NGgueUQBTQUc2ARd7ztyF3T+LMYfG2NduMT2ofqTxy2j0NfD/RfHd2eCNrP4Ba15l
         QO1S8zdNy1cWgGFixU/NNmuGaR1MLHqxkbrcqh6n6FqdWsSLni9cCvizoItnkeks7dJ2
         QGvuiNl5hWsz+/RgIXq/tV0mjJlg3S8FxXm4SsoXxtLc77V449ZAOVkiv0mcz7Qs0Tj4
         Rf4LL25XwuQ5lZMiIw8tKjVrTNOOD4SwKmnfHPdFC3Vit7Re848m3H4RMjs5NHKh8E6X
         l7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=lFqzeKGk7dHMHc+JuNTo8490OuMhpogMsgJyKdG1jBY=;
        b=RLzZgktS2E6f3G/JuAfjA6LmLFLtsictOqAf4LEVylRuIfuozPlCLITibfN5YHS29O
         wAuxAaRod0p7jbOPqm9cTq32EXW0f3mh6KVbdHk75f+ePiyCLlsyK3KAW6L8V9gDgoes
         7q3VwnjaXzRbAdKKumneh+yOJN79vM/NS56AwId4JNcFat1zXFdjbnvVE+oeq3XbjrYH
         RAFcbNtxmLSWXYS0bg1HPeRb8WlyCrgGxPPsoy4CpQNYck4s00hO9zXAKWY/KtKJfULC
         BeFDuMEiURI8etnVKdkKBW0fkVn2YQGlSD11wmEjRCpaPpu5zqQDInL7DhtMTymqxh+H
         sPGg==
X-Gm-Message-State: AOAM530MCG4sAHFGgJxDCnijW4xzAfpvZnyF4bd/ceaLSsy/G79LyphR
        F1NmbeI9ONFa5PoSpVsnRGgCZA==
X-Google-Smtp-Source: ABdhPJyFi0k2NrA8Avr+BKO5H7S0m74mbKnkmI44IYd73rWHAuKgT5wOZtC23lcPB8xGQdq+64yMUQ==
X-Received: by 2002:a17:90a:f481:: with SMTP id bx1mr2345309pjb.172.1597274999331;
        Wed, 12 Aug 2020 16:29:59 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id t25sm3485591pfe.51.2020.08.12.16.29.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 16:29:57 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9FB1F4E5-7B7C-4E09-A415-3C5C888B321F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4C375313-0B45-4022-8504-714A9183C231";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] chattr/lsattr: Support dax attribute
Date:   Wed, 12 Aug 2020 17:29:54 -0600
In-Reply-To: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
References: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4C375313-0B45-4022-8504-714A9183C231
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 27, 2020, at 11:33 PM, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>=20
> Use the letter 'x' to set/get dax attribute on a directory/file.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

One minor nit below, but otherwise looks OK.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> diff --git a/lib/e2p/pf.c b/lib/e2p/pf.c
> index 0c6998c4..e59cccff 100644
> --- a/lib/e2p/pf.c
> +++ b/lib/e2p/pf.c
> @@ -44,6 +44,7 @@ static struct flags_name flags_array[] =3D {
> 	{ EXT2_TOPDIR_FL, "T", "Top_of_Directory_Hierarchies" },
> 	{ EXT4_EXTENTS_FL, "e", "Extents" },
> 	{ FS_NOCOW_FL, "C", "No_COW" },
> +	{ FS_DAX_FL, "x", "Dax" },

Should this be "DAX" ?  That is how it is commonly used in the kernel.

> 	{ EXT4_CASEFOLD_FL, "F", "Casefold" },
> 	{ EXT4_INLINE_DATA_FL, "N", "Inline_Data" },
> 	{ EXT4_PROJINHERIT_FL, "P", "Project_Hierarchy" },
> diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
> index 6c20ea77..88f510a3 100644
> --- a/lib/ext2fs/ext2_fs.h
> +++ b/lib/ext2fs/ext2_fs.h
> @@ -335,6 +335,7 @@ struct ext2_dx_tail {
> /* EXT4_EOFBLOCKS_FL 0x00400000 was here */
> #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
> #define EXT4_SNAPFILE_FL		0x01000000  /* Inode is a =
snapshot */
> +#define FS_DAX_FL			0x02000000 /* Inode is DAX */
> #define EXT4_SNAPFILE_DELETED_FL	0x04000000  /* Snapshot is being =
deleted */
> #define EXT4_SNAPFILE_SHRUNK_FL		0x08000000  /* Snapshot =
shrink has completed */
> #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline =
data */
> diff --git a/misc/chattr.1.in b/misc/chattr.1.in
> index ff2fcf00..5a4928a5 100644
> --- a/misc/chattr.1.in
> +++ b/misc/chattr.1.in
> @@ -23,13 +23,13 @@ chattr \- change file attributes on a Linux file =
system
> .B chattr
> changes the file attributes on a Linux file system.
> .PP
> -The format of a symbolic mode is +-=3D[aAcCdDeFijPsStTu].
> +The format of a symbolic mode is +-=3D[aAcCdDeFijPsStTux].
> .PP
> The operator '+' causes the selected attributes to be added to the
> existing attributes of the files; '-' causes them to be removed; and =
'=3D'
> causes them to be the only attributes that the files have.
> .PP
> -The letters 'aAcCdDeFijPsStTu' select the new attributes for the =
files:
> +The letters 'aAcCdDeFijPsStTux' select the new attributes for the =
files:
> append only (a),
> no atime updates (A),
> compressed (c),
> @@ -45,7 +45,8 @@ secure deletion (s),
> synchronous updates (S),
> no tail-merging (t),
> top of directory hierarchy (T),
> -and undeletable (u).
> +undeletable (u),
> +and direct access for files (x).
> .PP
> The following attributes are read-only, and may be listed by
> .BR lsattr (1)
> @@ -210,6 +211,14 @@ saved.  This allows the user to ask for its =
undeletion.  Note: please
> make sure to read the bugs and limitations section at the end of this
> document.
> .TP
> +.B x
> +The 'x' attribute can be set on a directory or file.  If the =
attribute
> +is set on an existing directory, it will be inherited by all files =
and
> +subdirectories that are subsequently created in the directory.  If an
> +existing directory has contained some files and subdirectories, =
modifying
> +the attribute on the parent directory doesn't change the attributes =
on
> +these files and subdirectories.
> +.TP
> .B V
> A file with the 'V' attribute set has fs-verity enabled.  It cannot be
> written to, and the filesystem will automatically verify all data read
> diff --git a/misc/chattr.c b/misc/chattr.c
> index a5d60170..c0337f86 100644
> --- a/misc/chattr.c
> +++ b/misc/chattr.c
> @@ -86,7 +86,7 @@ static unsigned long sf;
> static void usage(void)
> {
> 	fprintf(stderr,
> -		_("Usage: %s [-pRVf] [-+=3DaAcCdDeijPsStTuF] [-v =
version] files...\n"),
> +		_("Usage: %s [-pRVf] [-+=3DaAcCdDeijPsStTuFx] [-v =
version] files...\n"),
> 		program_name);
> 	exit(1);
> }
> @@ -112,6 +112,7 @@ static const struct flags_char flags_array[] =3D {
> 	{ EXT2_NOTAIL_FL, 't' },
> 	{ EXT2_TOPDIR_FL, 'T' },
> 	{ FS_NOCOW_FL, 'C' },
> +	{ FS_DAX_FL, 'x' },
> 	{ EXT4_CASEFOLD_FL, 'F' },
> 	{ 0, 0 }
> };
> --
> 2.21.0
>=20
>=20
>=20


Cheers, Andreas






--Apple-Mail=_4C375313-0B45-4022-8504-714A9183C231
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl80e3IACgkQcqXauRfM
H+BcQg//WflHl5J7vxigu5aI1WmpsJYxt+oSlROIJhrZE2CfCjWtja95knGX+dWL
Z6g1r9Ck7iSEcDpHI1ChB2zmRHKazRmlOzi8ANNSlMz5RtEVGf/2ug9NQT9c5sfn
5I0mqAfNMS2WBzp855Q7S8oku74ksqqL8KjCvMVX1BRW+lHUwiyZNjxtJxMTLU2x
Gc0Ck2YXshiFkxs7HDgUeu+KJySDrvPNEYAijiOeOMJ2kG0BSZClSQZsb2pWy+e2
R5ulCaSW1ChSWlmdejCITXg914WSj/EyVlnQEhvJQMYMs9m5sERw6rLDQkUom3mN
83bfRACoy7exleuQaytxxpZe6jd2iWZIsZjhYcBCxB+MyTWHpyDc5K0LQiv61/HZ
6Hz0pcMsNsPdRBJyNmgUzbfXEiR6GRhTZHC61Kd2DLiV7rC2rj3DDn80ryoTsjnA
yhBDE42r9IKCycfg2mvcwPoWDcSoD+phb1ictKho8HZFFbEM+/qHv3q7ZmC2kBnV
EkR6GutBXULLHslSzAa8tYu4iyUN18JyUoTpSvMphpitudA3IZIe2Tw0paqPYHD8
k50URaC2jDVQtE9lOHSeymf7/cBwV1+Kd6FVaqSqFc4j7R5Qklhnv5Bu7qtmf5wC
b3Dtnv3kTzZp+cGmRXIqC3fJ+0wNK0ZsRApNc5Wsa81uhGhH3sk=
=zyVc
-----END PGP SIGNATURE-----

--Apple-Mail=_4C375313-0B45-4022-8504-714A9183C231--
