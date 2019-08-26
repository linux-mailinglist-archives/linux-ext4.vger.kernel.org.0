Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3396E9C78B
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 05:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfHZDNV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 23:13:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34262 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHZDNV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Aug 2019 23:13:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so9674687pgc.1
        for <linux-ext4@vger.kernel.org>; Sun, 25 Aug 2019 20:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=cb+jAyVVPkTS5Gxu9PRQLkHFuj06hZ8Nn6b14q3qHuk=;
        b=YaT0h5/ejMzQ2L9WqFm6IJHoUr+8ssaj/upw0JkW1lVxfmuWME06ekSYlKLayQXve6
         uZMnM+H5gL60Xg2kzWTQcIFdYa0MEaQNfUx8cUrTW79Jiq+dCGz9C5snrnwsT+1iGg9o
         HSTPdcSaRkuqrAU8hJRORC9JXBoklaez60ffSfnYs6WYHA6ihFoSBlDgrvVyUwL8zbtp
         N/J+IInMyK4WFutdMHHAd8wcKdkO6kE3i9gZz97vMn6PzQs/SWH3lgNB2xs/6+wEr3nT
         K9ARDby0oAzrCSKoMG5/EYeMsCZy32UOSfWxG/46eDdadeEbA2i6V5YQ5ccUCXgE5MIa
         N7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=cb+jAyVVPkTS5Gxu9PRQLkHFuj06hZ8Nn6b14q3qHuk=;
        b=fsvuk1GtCYHH4HYzPBhdeVM5LVEbXuHfP5lZDGOs924mF4UudZtKNMOO1BLFfWd4Sw
         VXb7HmEusknGFTfh8mqgcZQt1cTVcHPPUFi5dj4PluV9FI/MC/RxeO1+9fmtvQkfLF3+
         YeJsHRbPs0b8EncQ6tvMQr+XU/0c+rorvRkt+hQQcfodLgPA57KJbO6wFzXQdpySfwtX
         wWIyitJH89T0qXgyAAWQZf+gebKw8AQf/+PtR85jGj9BpEUTVzAq9ul7ujIPIFAxdPzG
         +ZBoLKzrtwGNP7SE73OV6D5lT9X12MecanQOAriS2YU0wETXAMLCnEWemKw93q+YEzYI
         ko/A==
X-Gm-Message-State: APjAAAXUbClWcugkcqJb4HvTJsEkQ9J4OMhfogAGnBiikv1Rl+Apt99l
        jS8CstXbBlKbQ5NbDX6Ix7XLtYzBus7YdQ==
X-Google-Smtp-Source: APXvYqyo9CyesNZki2GV8vHjDc5RJ6+VCfnWWsvbxfEZByUo142ddbB8evlWn60yvtYIApDa+SYmYQ==
X-Received: by 2002:a17:90a:8a11:: with SMTP id w17mr17205686pjn.139.1566789200285;
        Sun, 25 Aug 2019 20:13:20 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id g36sm10123553pgb.78.2019.08.25.20.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 20:13:19 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E1EABF29-7F54-41AD-A8BA-A11538B682DD@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B2C45E8A-19C6-4F14-BF16-BE7DD61A6A76";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 3/4] ext2fs: rename "s_overhead_blocks" to
 "s_overhead_clusters"
Date:   Sun, 25 Aug 2019 21:13:17 -0600
In-Reply-To: <20190822082617.19180-3-dongyangli@ddn.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Dongyang Li <dongyangli@ddn.com>
References: <20190822082617.19180-1-dongyangli@ddn.com>
 <20190822082617.19180-3-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B2C45E8A-19C6-4F14-BF16-BE7DD61A6A76
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 22, 2019, at 2:26 AM, Dongyang Li <dongyangli@ddn.com> wrote:
>=20
> Rename s_overhead_blocks field from struct ext2_super_block to
> make it consistent with the kernel counterpart.
>=20
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

with one minor comment/question below...

> ---
> debugfs/set_fields.c        | 2 +-
> lib/e2p/ls.c                | 6 +++---
> lib/ext2fs/ext2_fs.h        | 2 +-
> lib/ext2fs/swapfs.c         | 2 +-
> lib/ext2fs/tst_super_size.c | 2 +-
> 5 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/debugfs/set_fields.c b/debugfs/set_fields.c
> index 5142554d..f497bd92 100644
> --- a/debugfs/set_fields.c
> +++ b/debugfs/set_fields.c
> @@ -160,7 +160,7 @@ static struct field_set_info super_fields[] =3D {
> 	{ "usr_quota_inum", &set_sb.s_usr_quota_inum, NULL, 4, =
parse_uint },
> 	{ "grp_quota_inum", &set_sb.s_grp_quota_inum, NULL, 4, =
parse_uint },
> 	{ "prj_quota_inum", &set_sb.s_prj_quota_inum, NULL, 4, =
parse_uint },
> -	{ "overhead_blocks", &set_sb.s_overhead_blocks, NULL, 4, =
parse_uint },
> +	{ "overhead_clusters", &set_sb.s_overhead_clusters, NULL, 4, =
parse_uint },

Should we consider to keep the "overhead_blocks" name for compatibility? =
 It
should be listed second, after "overhead_clusters", maybe with a =
comment.

> 	{ "backup_bgs", &set_sb.s_backup_bgs[0], NULL, 4, parse_uint,
> 	  FLAG_ARRAY, 2 },
> 	{ "checksum", &set_sb.s_checksum, NULL, 4, parse_uint },
> diff --git a/lib/e2p/ls.c b/lib/e2p/ls.c
> index 5a446178..5ca750f6 100644
> --- a/lib/e2p/ls.c
> +++ b/lib/e2p/ls.c
> @@ -272,9 +272,9 @@ void list_super2(struct ext2_super_block * sb, =
FILE *f)
> 	fprintf(f, "Inode count:              %u\n", =
sb->s_inodes_count);
> 	fprintf(f, "Block count:              %llu\n", =
e2p_blocks_count(sb));
> 	fprintf(f, "Reserved block count:     %llu\n", =
e2p_r_blocks_count(sb));
> -	if (sb->s_overhead_blocks)
> -		fprintf(f, "Overhead blocks:          %u\n",
> -			sb->s_overhead_blocks);
> +	if (sb->s_overhead_clusters)
> +		fprintf(f, "Overhead clusters:          %u\n",
> +			sb->s_overhead_clusters);
> 	fprintf(f, "Free blocks:              %llu\n", =
e2p_free_blocks_count(sb));
> 	fprintf(f, "Free inodes:              %u\n", =
sb->s_free_inodes_count);
> 	fprintf(f, "First block:              %u\n", =
sb->s_first_data_block);
> diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
> index cbb44bdb..5737dc61 100644
> --- a/lib/ext2fs/ext2_fs.h
> +++ b/lib/ext2fs/ext2_fs.h
> @@ -742,7 +742,7 @@ struct ext2_super_block {
> /*200*/	__u8	s_mount_opts[64];
> /*240*/	__u32	s_usr_quota_inum;	/* inode number of user =
quota file */
> 	__u32	s_grp_quota_inum;	/* inode number of group quota =
file */
> -	__u32	s_overhead_blocks;	/* overhead blocks/clusters in =
fs */
> +	__u32	s_overhead_clusters;	/* overhead blocks/clusters in =
fs */
> /*24c*/	__u32	s_backup_bgs[2];	/* If sparse_super2 =
enabled */
> /*254*/	__u8	s_encrypt_algos[4];	/* Encryption algorithms =
in use  */
> /*258*/	__u8	s_encrypt_pw_salt[16];	/* Salt used for =
string2key algorithm */
> diff --git a/lib/ext2fs/swapfs.c b/lib/ext2fs/swapfs.c
> index a1560045..63b24330 100644
> --- a/lib/ext2fs/swapfs.c
> +++ b/lib/ext2fs/swapfs.c
> @@ -121,7 +121,7 @@ void ext2fs_swap_super(struct ext2_super_block * =
sb)
> 	/* sb->s_mount_opts is __u8 and does not need swabbing */
> 	sb->s_usr_quota_inum =3D ext2fs_swab32(sb->s_usr_quota_inum);
> 	sb->s_grp_quota_inum =3D ext2fs_swab32(sb->s_grp_quota_inum);
> -	sb->s_overhead_blocks =3D ext2fs_swab32(sb->s_overhead_blocks);
> +	sb->s_overhead_clusters =3D =
ext2fs_swab32(sb->s_overhead_clusters);
> 	sb->s_backup_bgs[0] =3D ext2fs_swab32(sb->s_backup_bgs[0]);
> 	sb->s_backup_bgs[1] =3D ext2fs_swab32(sb->s_backup_bgs[1]);
> 	/* sb->s_encrypt_algos is __u8 and does not need swabbing */
> diff --git a/lib/ext2fs/tst_super_size.c b/lib/ext2fs/tst_super_size.c
> index a932685d..ab38dd59 100644
> --- a/lib/ext2fs/tst_super_size.c
> +++ b/lib/ext2fs/tst_super_size.c
> @@ -135,7 +135,7 @@ int main(int argc, char **argv)
> 	check_field(s_mount_opts, 64);
> 	check_field(s_usr_quota_inum, 4);
> 	check_field(s_grp_quota_inum, 4);
> -	check_field(s_overhead_blocks, 4);
> +	check_field(s_overhead_clusters, 4);
> 	check_field(s_backup_bgs, 8);
> 	check_field(s_encrypt_algos, 4);
> 	check_field(s_encrypt_pw_salt, 16);
> --
> 2.22.1
>=20


Cheers, Andreas






--Apple-Mail=_B2C45E8A-19C6-4F14-BF16-BE7DD61A6A76
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1jTk0ACgkQcqXauRfM
H+AkVw/8CPs5DUOf+EFBr3jcNfBLfI1/qeJRFc5ToQC0ayvDNOowAx5aVzCWpAui
x6nevdG7nSWm77eDHYSXJs2QBcLiFbKHx549j9Ue9L9oG4M1ZrcF1qGg5h6f8NM2
CF1UG6tDn0Ixb2ZYA8niY8MGou8a3N6x9zaGwyRMlBAnjTSp/9qsGZWWhhyhYqJU
8ufORcR13CKX1uNa/ztx6K5goBFfOhA9OKcwel5hyNC3K2tOHn+F7d9pVGk2ps3k
xBpvd9g1wUHeaI5/pQv14YGDkPYOHBGRYaZzZ/PWhEC7fjU1NQhjsxvxH+X3qhhZ
h5KskFYl+BptojEdrkFLcQBeVlKTr4YBLMb8bYomdcjzfTn4OPUHUZPsLLhnuerm
K52FgGEOwb5jXMMZTn+yQOfqoQBXpox3oL3JYpJYJz7eOS81xXP7jyKCcuJEowmr
R2BXHHppdfT/k0qum+Zo5KUSqycuIsWr/+q34KMXfk0jAYMtUzVcD7UIb2VvDudB
HaMbqBfnYQaFDUvEV4mJmE8KJ+rTVjceD0I1qTCoDyPyLs4JEjOPDlhU6hR6OyC3
TBBFYcwvFQI5UWCf4nTCksneyqCCCbfSJGND3PJYKWjTmKmXSwMVfLLs2V5Bra7F
Fom8EIrmnESgWAPyiZdFcKwVI7lZ6gYm3c4TfPulzilui9oYsn4=
=JECV
-----END PGP SIGNATURE-----

--Apple-Mail=_B2C45E8A-19C6-4F14-BF16-BE7DD61A6A76--
