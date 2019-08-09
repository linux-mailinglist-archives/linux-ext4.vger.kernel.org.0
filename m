Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D0D88363
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHITlo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 15:41:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33224 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfHITlo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 15:41:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so46572749pfq.0
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=K/cd8Q9TKcLiHkNe6ODLNBY1PW91LJH+yavRg1HngcY=;
        b=b8DLkVkDQaI6ZHT4QznCmDmtnMxxj+GDv8P5K1qEx40Gw57RNYi1i5gk2gYeb8+8Ej
         ahsceWdT8wx/irk63OeXp/WqWYIh1wLLn5xSVkDecr+A+gG8oVSyqL/QevNM+YY6I93P
         Kn/WX/pB+ZSfJ8TRbPp6oJ9zjRCvY+5XZE0OkkU1NzKpzXjmffbgH9KI9WHvbisTmaFR
         YvWTEefzC+48oeBDrPdHfCAv0YWRN6ElPgPcFy+NrzOlkOaGcWGvK1dwM9W3MstxgqK6
         CaS6eYxZ82mVioiL6whxBNz36nuNQur3TB0ZakNM/UoCfZpK6mF65wuZGiU9MFA/0+nZ
         /c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=K/cd8Q9TKcLiHkNe6ODLNBY1PW91LJH+yavRg1HngcY=;
        b=VGfDXWr8gskTC/9KLVzW2z9NOEc72YSgvAyUNHpwy9ED+bmewRtZCWqT4tv3mRPJaE
         3MSgl1O3JYkKtVfb4Fi26Neaw+BLNHV/bEfOH2z6J4f3ev79o6KIrs/SWo33tqpDmM1A
         Dydotck7NjzYvjwaKFnLtb/Gg+gFxer5/zTKfPhbhbT1hNEIm7A+w3OhNDjXZzYXSJt1
         BOVqPSyqCPIGk7YN/81ztA7X8/FB+g0Qx5IK+28GQvhVBDm/fT2kPjx/gmRMo571tLQK
         QU8wSVoyfPWLmR95fVKBxnKI58siOGtuNJDGSzNXUJJ2EVKq4dMvkzxp9FQtxESEDaIu
         ka0g==
X-Gm-Message-State: APjAAAXuB7f7xkURKgIWDmPMXHfpRm1gOygOrW8MCNrfn4yWsh854G+K
        Zp+Rj+6IcJq1+XSCzsslSZ4I6Q==
X-Google-Smtp-Source: APXvYqy+BnRcj3MxKDQyqTg1E7pqZaDP8NgImpScdkU/k4HBb2ji/rQOGJiYvKaB560Ve1TDVHIHXw==
X-Received: by 2002:a17:90a:37a7:: with SMTP id v36mr5569489pjb.3.1565379703479;
        Fri, 09 Aug 2019 12:41:43 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id v6sm3006801pff.78.2019.08.09.12.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 12:41:42 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <696DB21C-EDF8-4F00-AF42-F32AFE0B355E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_573741A4-0F6C-41FA-9673-55E8F22FFA37";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 01/12] ext4: add handling for extended mount options
Date:   Fri, 9 Aug 2019 13:41:37 -0600
In-Reply-To: <20190809034552.148629-2-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-2-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_573741A4-0F6C-41FA-9673-55E8F22FFA37
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar =
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

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

>=20
> ---
> Changelog:
>=20
> V2: No changes since V1
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
> 2.23.0.rc1.153.gdeed80330f-goog
>=20


Cheers, Andreas






--Apple-Mail=_573741A4-0F6C-41FA-9673-55E8F22FFA37
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1NzHEACgkQcqXauRfM
H+BCeA/7Bi+fjVyboAt5fedCyez9jnF1Amxkzh7elVsss5E1K4DDdIK840DCIK8C
GY6W+64svJHTWl6T4Jirw/akV5O6qY/47/DeAFsPqc8UlVzgeIXo9Ai+eTm/+BDz
5Y7UQxgf0rekkZ8iL5I13uxcJkCfV0SLxhFcpxJVJyGFbOYGjHB0Jj3pTmzWyO+C
Sly0iTcZhHTrv2B+DcRGlJmHmOHXCLkw3cxucROP1ZrOphja/iqRoJ7Qf5WI6ofg
mqPR4xzx0jeoi+PGoQEPDHSN6CxBNIeNc3N4uS4i3i9ipoCTzWQHp+TW6vJQWCM4
HGA8OZVgBf2oFdG01qGQ0GER5yzPvGkjM8kH6nK60XN8v1sK2dQdL7UT/0prB51t
ZcW+FpOt8xudBT1K81Yrb3Bg0C1urTaVeYmQLbXyz9KeC0pWNqwNQmQ4B46/avjB
aNv+B6fm9yfezeniuT6vu7Jw9Kllwi2bDJt/H6HWlrdgWv+vUJMrRqp0b4MTvD+O
imIwVodJ9CMXOxWywZW56ssDNrnjRNp5CE1pyhs+We8IFNGMLb/lQsuC97Ay2OlV
AtrVqmIa+JkXm6mjCJMfg8x1ySewK/0oMHHBT9Tp/uxtGH7dVwRJEHJJbRXN+7LW
OKKl+LyrLAZLTWDpCpG9HgOg+4qJtpaKhrPc1uGdS9MisWd8Zj8=
=PGBC
-----END PGP SIGNATURE-----

--Apple-Mail=_573741A4-0F6C-41FA-9673-55E8F22FFA37--
