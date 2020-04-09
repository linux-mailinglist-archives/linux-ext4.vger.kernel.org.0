Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5556A1A3AC2
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Apr 2020 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDITrG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Apr 2020 15:47:06 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35676 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgDITrF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Apr 2020 15:47:05 -0400
Received: by mail-pj1-f65.google.com with SMTP id mn19so1711250pjb.0
        for <linux-ext4@vger.kernel.org>; Thu, 09 Apr 2020 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=yT5bZALRLc/lRA4mZVfXR6Asi+Bd312Ya11a4KgP+eQ=;
        b=PBm9FPB86lai1Y04SdkMDrkqym1oOztKVd/yuq07Zuc0e39Tm7yZzMlfJ+58qMTC/f
         ocZ57oYMenGozdnRbP/VKat2EiRJ8fJUEtzDNnnvmxK/+4qX5x5HIFi9DOfyIObCdWFZ
         Oh5UsHIXmOX3a1fySeeI3e4KXBdvz9FPAABZxBqmkv1TMn6HPGBhb9ageZDeNApdvB6J
         sHmpf+Otmb9RWEfn+seLuHS4ZNvwjDS9UTVinc0Ll86ZkxnDATFFzXX2101BXSa+Ql75
         WofMl2scyikjrJocMHnNACDqHA5WIDpTvO9qdJV3ru6ryeNjVMkAmtdh8KkPQIedRb0n
         hx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=yT5bZALRLc/lRA4mZVfXR6Asi+Bd312Ya11a4KgP+eQ=;
        b=NK78QQeYdrDFY0zd2PflUFNcsMefSrdcRjWBsOlQ+qH7vdwXBD8TKVgJpINyplC319
         +qkxaOjwcWsxaOSj/AT3+idDA1u9GFiwVYcHaAgfJunDbteAYM5EXGxH4E+R8WznA9VX
         JIhJ4j6Owc2vCNnaoU/CCzaA6/NslPEzQ0KA54Yyo6M+F9a0G/hsll1pjDSpok5HSwIo
         EAK7ftvEGkJB7+BJ1RRWrgnzjsemkVL5UOxtjjW/Br60CgoLHTkHNvOmx1TkqR7bXqrb
         Sc2FBmp9H3tBolaF19wrvjaEqUM4SnErCGwHbtyC7gywRFLwfZHhx63X72dOn6OEJt45
         OBTw==
X-Gm-Message-State: AGi0PuaNGJbx7CyQrUAK6PEdOghvBkqJuh1Q/1QgM+lllU7QiFd2+sf6
        pEWN2PugE/Gd6IBmVCBcKz80bUBS5dE=
X-Google-Smtp-Source: APiQypKRyhPHSLUBpawnQjhdxAl/n3qGUctmv7IVhdRnBUGxj1myWrrPb/DRYggqzv5d9ofxTSm/6g==
X-Received: by 2002:a17:90a:c983:: with SMTP id w3mr1278799pjt.102.1586461624385;
        Thu, 09 Apr 2020 12:47:04 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f5sm19595367pfq.63.2020.04.09.12.47.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 12:47:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BC8BC42B-5914-4E12-A70D-CAE68B1A1CE9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_25DFB18A-EC99-43E0-80A2-33A35B367AA9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v6 02/20] ext4: add handling for extended mount options
Date:   Thu, 9 Apr 2020 13:47:00 -0600
In-Reply-To: <20200408215530.25649-2-harshads@google.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20200408215530.25649-1-harshads@google.com>
 <20200408215530.25649-2-harshads@google.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_25DFB18A-EC99-43E0-80A2-33A35B367AA9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Apr 8, 2020, at 3:55 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> We are running out of mount option bits. Add handling for using
> s_mount_opt2. Add ability to turn on / off the fast commit
> feature and to turn on / off fast commit soft consistency option.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h  |  7 +++++++
> fs/ext4/super.c | 23 +++++++++++++++++++----
> 2 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 91eb4381cae5..7c3d89007eca 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1172,6 +1172,13 @@ struct ext4_inode_info {
> #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User =
explicitly
> 						specified journal =
checksum */
>=20
> +#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal =
fast commit */
> +
> +#define EXT4_MOUNT2_JOURNAL_FC_SOFT_CONSISTENCY	0x00000020 /* =
Soft consistency
> +							    * mode for =
fast
> +							    * commits
> +							    */
> +
> #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &=3D \
> 						~EXT4_MOUNT_##opt
> #define set_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt |=3D \
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9728e7b0e84f..70aaea283a63 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1523,6 +1523,7 @@ enum {
> 	Opt_dioread_nolock, Opt_dioread_lock,
> 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> +	Opt_no_fc, Opt_fc_soft_consistency
> };
>=20
> static const match_table_t tokens =3D {
> @@ -1606,6 +1607,8 @@ static const match_table_t tokens =3D {
> 	{Opt_init_itable, "init_itable=3D%u"},
> 	{Opt_init_itable, "init_itable"},
> 	{Opt_noinit_itable, "noinit_itable"},
> +	{Opt_no_fc, "no_fc"},
> +	{Opt_fc_soft_consistency, "fc_soft_consistency"},
> 	{Opt_max_dir_size_kb, "max_dir_size_kb=3D%u"},
> 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
> 	{Opt_nombcache, "nombcache"},
> @@ -1728,6 +1731,7 @@ static int clear_qf_name(struct super_block *sb, =
int qtype)
> #define MOPT_NO_EXT3	0x0200
> #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
> #define MOPT_STRING	0x0400
> +#define MOPT_2		0x0800
>=20
> static const struct mount_opts {
> 	int	token;
> @@ -1820,6 +1824,10 @@ static const struct mount_opts {
> 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
> 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
> 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> +	{Opt_no_fc, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
> +	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
> +	{Opt_fc_soft_consistency, =
EXT4_MOUNT2_JOURNAL_FC_SOFT_CONSISTENCY,
> +	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
> 	{Opt_err, 0, 0}
> };
>=20
> @@ -2110,10 +2118,17 @@ static int handle_mount_opt(struct super_block =
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
> --
> 2.26.0.110.g2183baf09c-goog
>=20


Cheers, Andreas






--Apple-Mail=_25DFB18A-EC99-43E0-80A2-33A35B367AA9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6Pe7UACgkQcqXauRfM
H+DHfRAAhilmuWK8dZmyqvJCGfIjy1vIr0Z8SaRBe6GJVVGw5PzrdI8DHBlONdG3
VGPKXDgFu4Xj30b9b08yK/u2Ll9OlkGZ6S+PHEJzUZVJFUU/I5UX7BPuEzLejKiM
13de/KDL9AarWLk35QWhaZq9Kpn1q14QXHdG5vZCZx5gTLTZtaogIM0duZ6xlyCZ
CHF5Si55DI/yAl7Y8MKHDKQv2PmzK7d7p7IvMlSIzzzYn7h6KYEbgUZC7XgRafdH
P7FMwmPJDBWAAl8149wiT/PXMyPaIhdVR33vqucCeS8xEaulH5H5BYagHWAD2wYg
K/nYW4XfFC+enoLX1m5HkvWzT3e7Er0xtACg+5xI5+0jCwf79ToqS8Q4b9hYvq7W
jvXj/8n8Dypo6CG/wVyhY3Rh1FJ/yG3Tfe8ifyIs4jUBLbJjnzHzSnHa+zU4zmWf
vDoPwF0fjh9UDZA2yi4JtOufp34dWLREktgCNbXemfIWipyehkrP+y1TIIr6Ys0I
Uh7sZ3q+NSG2wa9NGNL91OUPqttsL41s68b3M0ZgS7uCwownLFkFQllV1jlmdj8j
f7/L8xweyYJtpDO16GFftkqTPg/lKyFYLOqWSPyRIUB4xzhHHSJugQ2v2V8lTXEO
pA5hG9ZE1Rf7qhHfboDqRueWhF7+TCbAmn9Uv4NKKcec9YzQKFQ=
=Nhx5
-----END PGP SIGNATURE-----

--Apple-Mail=_25DFB18A-EC99-43E0-80A2-33A35B367AA9--
