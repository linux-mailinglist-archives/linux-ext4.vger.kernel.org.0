Return-Path: <linux-ext4+bounces-8237-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1CAC83A9
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 23:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F484A42FB
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFEA29292E;
	Thu, 29 May 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="uC3r4OKW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037951D63D8
	for <linux-ext4@vger.kernel.org>; Thu, 29 May 2025 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555072; cv=none; b=IFj2F3Y8slirX9bxmNulY9ysg/K3AAr79Mqv9CQRLYI2zqfJHmFtoYfneB2xqJtcRA+AdyKWy+x4NSmxn9jrl52dmRwAUmXcG18afNFH8AdmqeUx7FIGYGprzt7A5zYHQqYx/2+E3ia85uPtJ6v1dY6Osp7BnqZwPZG4BGWdqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555072; c=relaxed/simple;
	bh=53sFffwn2lLU7v5DP+QQ221kklhDhLpea2BLK+oEyes=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=fZuQhXbAZXVED4Jv+95wGk+VBf/2CjPGl9/Sgzir71KIUFcupeM6s4zAHoQ97WNZ2pLHYGwiEt11D1lmg7IZ7mDkiYl07cpui1dMmTWl+V9OGTHPWk42tsKAwahZW/mSr85wVpgFFtzKmU9ziT5kOFD3+8yqYYaySy+dCnBoS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=uC3r4OKW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742af848148so892787b3a.1
        for <linux-ext4@vger.kernel.org>; Thu, 29 May 2025 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1748555069; x=1749159869; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=84UWnGdEnC7HiveEK2ScM++jsj2dhjCkiP4mv7YXJhg=;
        b=uC3r4OKWnZjAoy4kID9K4S2nwA52So4EFdBZsc3atkd7r19NpeUTxlESVpxUnKFXS/
         GzcynXCn9MdafkekNQ2oak55BE17pmUvbtwTFl98TlfUBZ7ImdO7fLDjIxjDrBrLZaIt
         pRTZsj7HdB8v4q6iUuxmU7TffBAwu5AWADW1mE5V3/phM7q6owWmwe6o8T2CnaqYtE1Y
         zXjPqJZwM6jHh2QS8bgPPUIX4r4WhnqvBDKG1wl5pL7Ta2A8eGu7ido+jEyzGleBLFqS
         eOLwF8wgk/aiWsULwwk4gv6Iwic4ch2WdI0rsd1fb/IoMokk9LxCn7m1bX8MrHvWQosr
         oNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748555069; x=1749159869;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84UWnGdEnC7HiveEK2ScM++jsj2dhjCkiP4mv7YXJhg=;
        b=upAM/WoIu6ag3AdZd+Pmerom+jtSQsVwguE1idHtLOur9YnKc9LAr0iSpguIlAi9Lh
         CB8SgxrNRrn+vC+2F9ix35k15U0bI8WXIBqUhTTv/h9WO36txgQYw//8kCX/mUCYGBXX
         Uh59Rv7hrhkU6Aq5EZv6wzbSHQjV3HasZIXgta2+T4FSSV67XBLCXvwD+2fPO5nXGZik
         6LiEwPq8ChUXpIbqbNDg+8GVKkV6ihwb13tNa96XeFTsRcJyZlLdar7AcRdLDfDDJ0dy
         L/OpYxEKFZhhGxkFOA6+J4Ip2f0SwlnAHtyo/p7FPx0NggkU0MrMWVWrrXvPUiELJ3kA
         69dw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/HbBmB4SQleaK7jzebFRf4ukmIBCbEZN27j1/C/t5wR/HRgnWduJpdMFgShKjc9irZSGT/vOgt6B@vger.kernel.org
X-Gm-Message-State: AOJu0YymWuqJlT37fw/lYxVFLKnmSjttgBbemaCY2Sht/v+DGeknAXJQ
	8s3okvphPO+tKr+luwy9n2ZfHupmIIOtN2W/V5QmJJdKr+NqhyjfK+Dux2Eica5lEkA=
X-Gm-Gg: ASbGnctMYFz0vDZeydhq+7LDhrdlW5xRXWBz5ej1dj/qu5QvkLkEQxD90IkdFueRTvE
	AD9qGh/V9+Imwwr+ktb5a3k0OzvDPVkmppj9eWIn5C1mlRNICI8Z8EJQpSOOiXHmiICFFN3xP4p
	uiGEeXc3/510O/Q4X+KGkUhajj0gpAbwWftfHFStNTiJfMm09esOOtXWFbsNixZpZ4+ODZYvM/d
	KjlX5PnqbTbhEetjtuseW41xVDCzu8COWiA28/6kEyjA9Kb1EBPSx4cnniajxlrLbhzOJ5JNIAO
	ILovEnkDRMf5NvCajk1VhOpxhtS2DqXjhgYq2ZXALq1XuIqICo43asbdNYpTL3oSr9XeR3XGx+o
	NqpqJGoXTeCwDrPvbQ+hrXMGv
X-Google-Smtp-Source: AGHT+IER2B/yPYMGNJx2jPbxohMu4IBkKFfwKwf9z0/UFg91mDs7E1AuHZPmG4Pd5vOqUq8avSeCPg==
X-Received: by 2002:a05:6a00:2d08:b0:742:9fea:a2d1 with SMTP id d2e1a72fcca58-747bda1ad23mr1240074b3a.23.1748555069123;
        Thu, 29 May 2025 14:44:29 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7464sm1785758b3a.180.2025.05.29.14.44.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 May 2025 14:44:28 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <9BA9D25F-A282-4998-9B53-03EDCD0D7C25@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_146F10CE-776D-4F3F-81EB-17840FF5CDF3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] ext4: use kmem_cache for short fname allocation in readdir
Date: Thu, 29 May 2025 15:44:26 -0600
In-Reply-To: <20250529144256.4517-1-00107082@163.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
To: David Wang <00107082@163.com>
References: <20250529144256.4517-1-00107082@163.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_146F10CE-776D-4F3F-81EB-17840FF5CDF3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 29, 2025, at 8:42 AM, David Wang <00107082@163.com> wrote:
>=20
> When searching files, ext4_readdir would kzalloc() a fname
> object for each entry. It would be faster if a dedicated
> kmem_cache is used for fname.
>=20
> But fnames are of variable length.
>=20
> This patch suggests using kmem_cache for fname with short
> length, and resorting to kzalloc when fname needs larger buffer.
> Assuming long file names are not very common.

It may be reasonable to have a cache, but I suspect that 127 bytes
is too large for most common workloads.  Statistics that I've seen
show 99-percentile filename length is <=3D 48 bytes on most filesystems,
so allocating 128 bytes is probably sub-optimal (most is wasted).

That said, kmalloc() is mostly a wrapper for the kmalloc-* slabs, so
creating a 128-byte slab for this doesn't seem super useful?

> Profiling when searching files in kernel code base, with following
> command:
> 	# perf record -g -e cpu-clock --freq=3Dmax bash -c \
> 	"for i in {1..100}; do find ./linux -name notfoundatall > =
/dev/null; done"
> And using sample counts as indicator of performance improvement.
> (The faster, the less samples collected. And the tests are carried out
> when system is under no memory pressure.)
>=20
> Before without the change:
> 	1232868--ext4_readdir
> 		 |
> 		 |--839085--ext4_htree_fill_tree
> 		 |          |
> 		 |           --829223--htree_dirblock_to_tree
> 		 |                     |
> 		 |                     =
|--365869--ext4_htree_store_dirent
> 		 |                     |          |
> 		 |                     |          =
|--43169--0xffffffffa7f8d094
> 		 |                     |          |
> 		 |                     |           =
--21947--0xffffffffa7f8d0f7
> 		 |                     |
> 		 |                     |--213124--ext4fs_dirhash
> 		 |                     |          |
> 		 |                     |           =
--86339--str2hashbuf_signed
> 		 |                     |
> 		 |                     |--145839--__ext4_read_dirblock
>=20
> and with the change, ~3% less samples:
> 	1202922--ext4_readdir

> 		 |
> 		 |--805105--ext4_htree_fill_tree
> 		 |          |
> 		 |           --795055--htree_dirblock_to_tree
> 		 |                     |
> 		 |                     =
|--328876--ext4_htree_store_dirent
> 		 |                     |          |
> 		 |                     |          =
|--123207--kmem_cache_alloc_noprof
> 		 |                     |          |          |
> 		 |                     |          |          =
|--26453--__alloc_tagging_slab_alloc_hook
> 		 |                     |          |          |
> 		 |                     |          |           =
--20413--__slab_alloc.isra.0
> 		 |                     |          |
> 		 |                     |           =
--31566--rb_insert_color
> 		 |                     |
> 		 |                     |--212915--ext4fs_dirhash
> 		 |                     |          |
> 		 |                     |           =
--86004--str2hashbuf_signed
> 		 |                     |
> 		 |                     |--149146--__ext4_read_dirblock
>=20
> readdir() would have sigfinicant improvement, but the overall
> improvements for searching files is only ~0.5%, might be more
> sigfinicant if the system is under some memory pressures.
>=20
> The slab stats after the test:
> ext4_dir_fname      1242   1242    176   23    1 : tunables    0    0  =
  0 : slabdata     54     54      0
>=20
> Signed-off-by: David Wang <00107082@163.com>
> ---
> fs/ext4/dir.c   | 47 ++++++++++++++++++++++++++++++++++++++++++++---
> fs/ext4/ext4.h  |  4 ++++
> fs/ext4/super.c |  3 +++
> 3 files changed, 51 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index d4164c507a90..3adfa0d038cd 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -424,6 +424,48 @@ struct fname {
> 	char		name[] __counted_by(name_len);
> };
>=20
> +#define EXT4_DIR_FNAME_SHORT_LENGTH 127
> +static struct kmem_cache *ext4_dir_fname_cachep;
> +
> +void __init ext4_init_dir(void)
> +{
> +	ext4_dir_fname_cachep =3D =
kmem_cache_create_usercopy("ext4_dir_fname",
> +			struct_size_t(struct fname, name,  =
EXT4_DIR_FNAME_SHORT_LENGTH + 1),
> +			0, SLAB_RECLAIM_ACCOUNT,
> +			offsetof(struct fname, name), =
EXT4_DIR_FNAME_SHORT_LENGTH + 1,
> +			NULL);
> +}
> +
> +void ext4_exit_dir(void)
> +{
> +	if (ext4_dir_fname_cachep)
> +		kmem_cache_destroy(ext4_dir_fname_cachep);
> +}
> +
> +static struct fname *rb_node_fname_zalloc(__u8 name_len)
> +{
> +	struct fname *p;
> +	if (ext4_dir_fname_cachep && name_len <=3D =
EXT4_DIR_FNAME_SHORT_LENGTH)
> +		p =3D kmem_cache_alloc(ext4_dir_fname_cachep, =
GFP_KERNEL);
> +	else
> +		p =3D kmalloc(struct_size(p, name, name_len + 1), =
GFP_KERNEL);
> +	if (p) {
> +		/* no need to fill name with zeroes*/
> +		memset(p, 0, offsetof(struct fname, name));
> +		p->name[name_len] =3D 0;
> +	}
> +	return p;
> +}
> +
> +static void rb_node_fname_free(struct fname *p) {
> +	if (!p)
> +		return;
> +	if (ext4_dir_fname_cachep && p->name_len <=3D =
EXT4_DIR_FNAME_SHORT_LENGTH)
> +		kmem_cache_free(ext4_dir_fname_cachep, p);
> +	else
> +		kfree(p);
> +}
> +
> /*
>  * This function implements a non-recursive way of freeing all of the
>  * nodes in the red-black tree.
> @@ -436,7 +478,7 @@ static void free_rb_tree_fname(struct rb_root =
*root)
> 		while (fname) {
> 			struct fname *old =3D fname;
> 			fname =3D fname->next;
> -			kfree(old);
> +			rb_node_fname_free(old);
> 		}
>=20
> 	*root =3D RB_ROOT;
> @@ -479,8 +521,7 @@ int ext4_htree_store_dirent(struct file *dir_file, =
__u32 hash,
> 	p =3D &info->root.rb_node;
>=20
> 	/* Create and allocate the fname structure */
> -	new_fn =3D kzalloc(struct_size(new_fn, name, ent_name->len + 1),
> -			 GFP_KERNEL);
> +	new_fn =3D rb_node_fname_zalloc(ent_name->len);
> 	if (!new_fn)
> 		return -ENOMEM;
> 	new_fn->hash =3D hash;
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a20e9cd7184..33ab97143000 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3795,6 +3795,10 @@ extern void ext4_orphan_file_block_trigger(
> 				struct buffer_head *bh,
> 				void *data, size_t size);
>=20
> +/* dir.c */
> +extern void __init ext4_init_dir(void);
> +extern void ext4_exit_dir(void);
> +
> /*
>  * Add new method to test whether block and inode bitmaps are properly
>  * initialized. With uninit_bg reading the block from disk is not =
enough
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 181934499624..21ce3d78912a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -7457,6 +7457,8 @@ static int __init ext4_init_fs(void)
> 	if (err)
> 		goto out;
>=20
> +	ext4_init_dir();
> +
> 	return 0;
> out:
> 	unregister_as_ext2();
> @@ -7497,6 +7499,7 @@ static void __exit ext4_exit_fs(void)
> 	ext4_exit_post_read_processing();
> 	ext4_exit_es();
> 	ext4_exit_pending();
> +	ext4_exit_dir();
> }
>=20
> MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas =
Dilger, Theodore Ts'o and others");
> --
> 2.39.2
>=20


Cheers, Andreas






--Apple-Mail=_146F10CE-776D-4F3F-81EB-17840FF5CDF3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmg41ToACgkQcqXauRfM
H+ATTBAAhetj5Wxizo3F4M2wY1N0aZqiXk9n/1K6oMSGiIOdM1eOGW8tkeLxMARi
AqCGlpVQZvEQx5aeeoNDNOO+V+l6xdbaIJ1qx/bEVWNNoN8x0xDOShGrMRYIHf50
iJaVHXT96ACa+htDy/9I2pnS4t6/K4JExMHPCyYHiUs93ooi/01kyVxmgMKX0uBU
jPaou+lbTlkE6noIWTYyha/3DLgZ/BnD7/a/XdqUB/PeQMtcvv/qFPYVe9ZcHoll
PCBFr3uzDxPZeZRURGg3Eqpqs7zdLOH1mTPSpuB1aqeZYm/j9E6pdqPKddkHV1UH
c3g/VmOSHg1+y2kTGp+qfKXlzp3WnAK329QcA2nJgYeTa/Gws4cVqhR0lu7cu69l
XRXZe9JxOK5q5quLC+lqTaAQc/fjLKcHunfCliwSSldyV675QSvwFnODgo5dNyhD
rYgmM1zbbv7Xu+CwL6opr5ac61z26KiHEQ29Kkqfvjq7qTt64Ymwk/XZY7kjk7gw
BEY4LsHWPHNdpNmnwp5b7cVQ4PxHGu72WFJ0ehcqV6Rn3n+t1n69BT6HuWVx+ej8
SiY2MX59uogGPyfUSKSrEC7Iv0MupO9vCLmnDEKfKOk1YGudtfJzwamEmp05JXP6
zBWrRRix+0+22LuBel8LwD7GHcIWYq4P/gWGWhLcnR99G53wgKM=
=chcN
-----END PGP SIGNATURE-----

--Apple-Mail=_146F10CE-776D-4F3F-81EB-17840FF5CDF3--

