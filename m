Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F327083A
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 20:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfGVSPL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 14:15:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45918 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfGVSPL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 14:15:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so19525289plr.12
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jul 2019 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=w3DI0BB6GYPm5oWPb+PQZdXIBLTUy6mAYmBlBQD2jtQ=;
        b=0Y9l5k2+5SJ5eKsdOsmn3oqsULEzzYx+Netj4ijTet2bS/Muiu5DK2b17MYjieCC0V
         /yIIhRP7ws6xQM7Uuu2ZR6VlJkW6SOtLhnqWiJljxHsGvbcrdZPNME5WuT8rcQkOW22Z
         VxnPhBPODzYLOsubZzct0zuLrbB7axkwBf+5lX2SfzuRZdayR/TSTaC/7fJ1QDOeAgla
         OO2WRa+OAGJFw6fe8l2yjMFD8aKtZyVtw80ZA111RyGpbHMzjHkz1O7dC6B51Su396JV
         l6O09S3szwTfU7C7lSwvf72uWmQa6oWTZSewaHybZiASYffO32NVOUCt1GwHWoO/ULGp
         CFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=w3DI0BB6GYPm5oWPb+PQZdXIBLTUy6mAYmBlBQD2jtQ=;
        b=DYbXEceg/bPrQQNU9gMTmBLqZn8WV4CaiLlPNYShht++LiDtq/Dhp8EOhHLCdZuycf
         MaMyE4tXDY133J/ypPRDxD20Bx0XJIapMwfffS6RblDYHFuFk0wi49bKvmzlTHw+HCG0
         YUUi6CZDgoQs6ncNYxLly65OyhIsoSehKdAKjPJbBPpa9VOQlM+t7JtujQmY35EN9V4U
         NdJ/WCZ8Vkk3S2EX22g4vnBuo2WpAn1cOIzXmV42OMGGNygR/Hm/f0+fiKdpOrIErtmz
         Xq9JTqFH/fqUEAC3NJHJFE6S8nQRYHDeBao6U3tggWznGuRQxveuNriW/GUAl4i5aOHk
         xmHw==
X-Gm-Message-State: APjAAAWQESidocB04m4jv3EpOs1RsIx6NgziV1y11zPc2D8kcGyoFmwQ
        ShpKD+MotOj6Br1vY9/4TkY=
X-Google-Smtp-Source: APXvYqzzPj56bvQ+YtL1O0AsDzh3GfO8/05saJCprS0YI1t+ib0QJRpZicya4zoeAHPgquYdWC/FhA==
X-Received: by 2002:a17:902:e282:: with SMTP id cf2mr77555069plb.301.1563819310161;
        Mon, 22 Jul 2019 11:15:10 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f64sm42727885pfa.115.2019.07.22.11.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 11:15:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7E851EE6-9C1A-4AAB-8CEA-02923A9A5BCA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
Date:   Mon, 22 Jul 2019 12:15:11 -0600
In-Reply-To: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_7E851EE6-9C1A-4AAB-8CEA-02923A9A5BCA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Unless I missed it, this patch series needs a 00/11 email that describes
*what* "fast commit" is, and why we want it.  This should include some
benchmark results, since (I'd assume) that the "fast" part of the =
feature
name implies a performance improvement?

Cheers, Andreas

> On Jul 21, 2019, at 10:00 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> We are running out of mount option bits. This patch adds handling for
> using s_mount_opt2 and also adds ability to turn on / off the fast
> commit feature. In order to use fast commits, new version e2fsprogs
> needs to set the fast feature commit flag. This also makes sure that
> we have fast commit compatible e2fsprogs before starting to use the
> feature. Mount flag "no_fastcommit", introuced in this patch, can be
> passed to disable the feature at mount time.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
> fs/ext4/ext4.h       |  4 ++++
> fs/ext4/super.c      | 27 ++++++++++++++++++++++-----
> include/linux/jbd2.h |  5 ++++-
> 3 files changed, 30 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index bf660aa7a9e0..becbda38b7db 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1146,6 +1146,8 @@ struct ext4_inode_info {
> #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User =
explicitly
> 						specified journal =
checksum */
>=20
> +#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal =
fast commit */
> +
> #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &=3D \
> 						~EXT4_MOUNT_##opt
> #define set_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt |=3D \
> @@ -1643,6 +1645,7 @@ static inline void ext4_clear_state_flags(struct =
ext4_inode_info *ei)
> #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
> #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
> #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
> +#define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
>=20
> #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
> #define EXT4_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
> @@ -1743,6 +1746,7 @@ EXT4_FEATURE_COMPAT_FUNCS(xattr,		=
EXT_ATTR)
> EXT4_FEATURE_COMPAT_FUNCS(resize_inode,		RESIZE_INODE)
> EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
> EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
> +EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		FAST_COMMIT)
>=20
> EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
> EXT4_FEATURE_RO_COMPAT_FUNCS(large_file,	LARGE_FILE)
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4079605d437a..e376ac040cce 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1455,6 +1455,7 @@ enum {
> 	Opt_dioread_nolock, Opt_dioread_lock,
> 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> +	Opt_no_fastcommit
> };
>=20
> static const match_table_t tokens =3D {
> @@ -1537,6 +1538,7 @@ static const match_table_t tokens =3D {
> 	{Opt_init_itable, "init_itable=3D%u"},
> 	{Opt_init_itable, "init_itable"},
> 	{Opt_noinit_itable, "noinit_itable"},
> +	{Opt_no_fastcommit, "no_fastcommit"},
> 	{Opt_max_dir_size_kb, "max_dir_size_kb=3D%u"},
> 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
> 	{Opt_nombcache, "nombcache"},
> @@ -1659,6 +1661,7 @@ static int clear_qf_name(struct super_block *sb, =
int qtype)
> #define MOPT_NO_EXT3	0x0200
> #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
> #define MOPT_STRING	0x0400
> +#define MOPT_2		0x0800
>=20
> static const struct mount_opts {
> 	int	token;
> @@ -1751,6 +1754,8 @@ static const struct mount_opts {
> 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
> 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
> 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> +	{Opt_no_fastcommit, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
> +	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
> 	{Opt_err, 0, 0}
> };
>=20
> @@ -1858,8 +1863,9 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
> 			set_opt2(sb, EXPLICIT_DELALLOC);
> 		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
> 			set_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM);
> -		} else
> +		} else if (m->mount_opt) {
> 			return -1;
> +		}
> 	}
> 	if (m->flags & MOPT_CLEAR_ERR)
> 		clear_opt(sb, ERRORS_MASK);
> @@ -2027,10 +2033,17 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
> 			WARN_ON(1);
> 			return -1;
> 		}
> -		if (arg !=3D 0)
> -			sbi->s_mount_opt |=3D m->mount_opt;
> -		else
> -			sbi->s_mount_opt &=3D ~m->mount_opt;
> +		if (m->flags & MOPT_2) {
> +			if (arg !=3D 0)
> +				sbi->s_mount_opt2 |=3D m->mount_opt;
> +			else
> +				sbi->s_mount_opt2 &=3D ~m->mount_opt;
> +		} else {
> +			if (arg !=3D 0)
> +				sbi->s_mount_opt |=3D m->mount_opt;
> +			else
> +				sbi->s_mount_opt &=3D ~m->mount_opt;
> +		}
> 	}
> 	return 1;
> }
> @@ -3733,6 +3746,9 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> #ifdef CONFIG_EXT4_FS_POSIX_ACL
> 	set_opt(sb, POSIX_ACL);
> #endif
> +	if (ext4_has_feature_fast_commit(sb))
> +		set_opt2(sb, JOURNAL_FAST_COMMIT);
> +
> 	/* don't forget to enable journal_csum when metadata_csum is =
enabled. */
> 	if (ext4_has_metadata_csum(sb))
> 		set_opt(sb, JOURNAL_CHECKSUM);
> @@ -4334,6 +4350,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 		sbi->s_def_mount_opt &=3D ~EXT4_MOUNT_JOURNAL_CHECKSUM;
> 		clear_opt(sb, JOURNAL_CHECKSUM);
> 		clear_opt(sb, DATA_FLAGS);
> +		clear_opt2(sb, JOURNAL_FAST_COMMIT);
> 		sbi->s_journal =3D NULL;
> 		needs_recovery =3D 0;
> 		goto no_journal;
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index df03825ad1a1..b7eed49b8ecd 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -288,6 +288,7 @@ typedef struct journal_superblock_s
> #define JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT	0x00000004
> #define JBD2_FEATURE_INCOMPAT_CSUM_V2		0x00000008
> #define JBD2_FEATURE_INCOMPAT_CSUM_V3		0x00000010
> +#define JBD2_FEATURE_INCOMPAT_FAST_COMMIT	0x00000020
>=20
> /* See "journal feature predicate functions" below */
>=20
> @@ -298,7 +299,8 @@ typedef struct journal_superblock_s
> 					JBD2_FEATURE_INCOMPAT_64BIT | \
> 					=
JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT | \
> 					JBD2_FEATURE_INCOMPAT_CSUM_V2 | =
\
> -					JBD2_FEATURE_INCOMPAT_CSUM_V3)
> +					JBD2_FEATURE_INCOMPAT_CSUM_V3 | =
\
> +					=
JBD2_FEATURE_INCOMPAT_FAST_COMMIT)
>=20
> #ifdef __KERNEL__
>=20
> @@ -1235,6 +1237,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(64bit,		=
64BIT)
> JBD2_FEATURE_INCOMPAT_FUNCS(async_commit,	ASYNC_COMMIT)
> JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
> JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
> +JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
>=20
> /*
>  * Journal flag definitions
> --
> 2.22.0.657.g960e92d24f-goog
>=20


Cheers, Andreas






--Apple-Mail=_7E851EE6-9C1A-4AAB-8CEA-02923A9A5BCA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl01/S8ACgkQcqXauRfM
H+DQjg/9Gu/wpMn6Fw2X9KgRng1eLIaBeFQPpo12TxBSLcbrElzTGnjhp8A0mVHV
xZapXO+rDlA4JayKG7S1xaqMokyVrTf2Acc3Ly3dvFTgCEqjdpwZBQL/swaOGGX6
95peZn8q9M7KWpiS0QfuIY+o8D0pkyWEKgCNhIDrnMFyu9Q7lHsFQAJ5lEdAnlKZ
Ey9j+PTlTn+uEA77kQsENmJlurWTN4pDmghG/3B6p81avf3Qm2jxv8lI8ZEveEgO
+YbIJp67JcEUPyJ6G2E7uzLTvYaYt5k791qsqx1VEFb9L0EOJ5TNAlJ6cKKKoALm
EyfxMVyyfqjHFnhvgJgJgN4QrslPoh8truBNXQVi5X0LMEr1isp9J9MNnU5L1EIR
EE0zUrxG0NnQrxveJOn3RBfTHh0cpjrALYBoDjmNYBZLrymZmHMZOo5hQhUTgFdA
ipkV4+R0mPwK1bDDH8lTDOZH+BKMv6IZRUWzLBF0uDhaPAYyfGXIBGAdlAgJX8AI
AqyAHx0/HzXRxrPRhrE595To5qN3pbdSZqTH1g0ggAMf348QzfmyZlmDl4uMayOU
BrHTyKwqoULIPv1xNwGinP6d77x4cBT9qR9AiSMJusWunGmqax3H0CjiupddJ61J
oHL1hCgU3t0LA11v5eVTCp4jXRiuFtwkUBjoOk9IT+SVSZRgNRE=
=vv1O
-----END PGP SIGNATURE-----

--Apple-Mail=_7E851EE6-9C1A-4AAB-8CEA-02923A9A5BCA--
