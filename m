Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028195005D
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2019 05:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfFXDv3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jun 2019 23:51:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38748 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfFXDv3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Jun 2019 23:51:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so3739074pgz.5
        for <linux-ext4@vger.kernel.org>; Sun, 23 Jun 2019 20:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ZRPgvApNcs4ezbwx7YEe0VcSdQZPQ9xjVhok4QMrTWA=;
        b=iURgSdTskOAx7PIWyNmQeuYLqu7TrnTO/ZgqSrE77Q29gm79wkSOfRJFukFvrNm/Ht
         LZelNoEawXnhmc26DsLQSI3w6XurJCWXoz78szo1Pgb0syGDgjqvmC5n0kAhET7GHeYi
         tlgH435gMFM8ujZz7N6zfnyIAg8jo0fUcO0IiDaACuYOoa8C1UwdTR/y0/PjQaVyE9U+
         MTWm8wFwbWN4ELG+Uat3LJt9qNjV4BOvZSRyf1Dowgm4TLuTq3g4PR2436MvDR8/8en8
         5x5/6IyAFHebliVCxyCGGL0D5VH4dmpxDB26B7kdeRo2NnahUK2nbBL3rl4d2x9RE8eC
         odpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ZRPgvApNcs4ezbwx7YEe0VcSdQZPQ9xjVhok4QMrTWA=;
        b=lHkQlwkkMEqvyBtn62n2NoSmmQbbpEw8SRet5spp93KyYUB8jMfv8YfTqWATi03gcJ
         Ml9ZxFEgusKxs922Oe1kFCf1GRjcTHHIvwyvqzLF7hZIiHanqCSky2P57TnTc966KPUg
         0rU8ruuMkzO8il3KYRiUbhY3n25y+zW8y91UEpiiO+TsN3nqVqWNSgthySAJNuKAUsjF
         BhM7whpPsuYp/4sALQeJ2IN2IYjyYoNGaBSJJefSSzvk7Y/SqB1gAE+DevnUEyWY2yBi
         0uW+vGcb8ES8HszpvoXHAEqMNTwFIYXn83FqQ5uV/0qrRJngQXWlqhVaezmE4ZKS/DJU
         voPw==
X-Gm-Message-State: APjAAAV8r73nD/Du8Omv1W+Y1RkRmGR4qlpzR0iSgjwysB0KCKRqGfUs
        J3XK66ebIsA3Ad80pDPZUdb7MQ==
X-Google-Smtp-Source: APXvYqz4ccn3VE0EOYchiz070hMv4Nvl8T1odKSZB9+p3I5FZslKAfncdKLvVr6dPr0nnIYSHszfpA==
X-Received: by 2002:a65:4cce:: with SMTP id n14mr30913346pgt.246.1561348288017;
        Sun, 23 Jun 2019 20:51:28 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id j11sm9950633pfa.2.2019.06.23.20.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 20:51:27 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <962DF4E5-4D71-45BD-A41F-05BDB0A2B599@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_904608D4-9C02-4CC9-A921-9213D219460B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: allow directory holes
Date:   Sun, 23 Jun 2019 21:52:15 -0600
In-Reply-To: <20190621041039.25337-1-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        stable@kernel.org
To:     Theodore Ts'o <tytso@mit.edu>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
References: <20190621041039.25337-1-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_904608D4-9C02-4CC9-A921-9213D219460B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 20, 2019, at 10:10 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> The largedir feature was intended to allow ext4 directories to have
> unmapped directory blocks (e.g., directory holes).  And so the
> released e2fsprogs no longer enforces this for largedir file systems;
> however, the corresponding change to the kernel-side code was not =
made.
>=20
> This commit fixes this oversight.

This should include a label:

Fixes: e08ac99fa2a2 ("ext4: add largedir feature")

> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

I've also added Artem to the CC list, since he submitted the patch.

> Cc: stable@kernel.org
> ---
> fs/ext4/dir.c   |  8 --------
> fs/ext4/namei.c | 35 +++++++++++++++++++++++++++--------
> 2 files changed, 27 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 770a1e6d4672..935dc52380fc 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -112,7 +112,6 @@ static int ext4_readdir(struct file *file, struct =
dir_context *ctx)
> 	struct inode *inode =3D file_inode(file);
> 	struct super_block *sb =3D inode->i_sb;
> 	struct buffer_head *bh =3D NULL;
> -	int dir_has_error =3D 0;
> 	struct fscrypt_str fstr =3D FSTR_INIT(NULL, 0);
>=20
> 	if (IS_ENCRYPTED(inode)) {
> @@ -179,13 +178,6 @@ static int ext4_readdir(struct file *file, struct =
dir_context *ctx)
> 		}
>=20
> 		if (!bh) {
> -			if (!dir_has_error) {
> -				EXT4_ERROR_FILE(file, 0,
> -						"directory contains a "
> -						"hole at offset %llu",
> -					   (unsigned long long) =
ctx->pos);
> -				dir_has_error =3D 1;
> -			}

> 			/* corrupt size?  Maybe no more blocks to read =
*/
> 			if (ctx->pos > inode->i_blocks << 9)
> 				break;
>                         ctx->pos +=3D sb->s_blocksize - offset;

It seems that ext4_map_blocks() will return m_len with the length of the =
hole,
so it would make sense to skip all of the blocks in the hole rather than =
trying
to read all of them, in case the directory is mostly sparse.  This could =
avoid
a bunch of kernel spinning.

Also, there is a separate question of whether ext4_map_blocks() will =
return 0
in the case of a hole, according to the function comment:

 * It returns 0 if plain look up failed (blocks have not been =
allocated), in
 * that case, @map is returned as unmapped but we still do fill =
map->m_len to
 * indicate the length of a hole starting at map->m_lblk.

in which case "bh" is not reset from the previous loop?

> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 4909ced4e672..f3140ff330c6 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -83,7 +83,7 @@ static int ext4_dx_csum_verify(struct inode *inode,
> 			       struct ext4_dir_entry *dirent);
>=20
> typedef enum {
> -	EITHER, INDEX, DIRENT
> +	EITHER, INDEX, DIRENT, DIRENT_HTREE

It would be useful to put these one-per-line with a comment explaining =
each.

> } dirblock_type_t;
>=20
> #define ext4_read_dirblock(inode, block, type) \
> @@ -109,11 +109,14 @@ static struct buffer_head =
*__ext4_read_dirblock(struct inode *inode,
>=20
> 		return bh;
> 	}
> -	if (!bh) {
> +	if (!bh && (type =3D=3D INDEX || type =3D=3D DIRENT_HTREE)) {
> 		ext4_error_inode(inode, func, line, block,
> -				 "Directory hole found");
> +				 "Directory hole found for htree %s =
block",
> +				 (type =3D=3D INDEX) ? "index" : =
"leaf");
> 		return ERR_PTR(-EFSCORRUPTED);
> 	}
> +	if (!bh)
> +		return NULL;
> 	dirent =3D (struct ext4_dir_entry *) bh->b_data;
> 	/* Determine whether or not we have an index block */
> 	if (is_dx(inode)) {
> @@ -980,7 +983,7 @@ static int htree_dirblock_to_tree(struct file =
*dir_file,
>=20
> 	dxtrace(printk(KERN_INFO "In htree dirblock_to_tree: block =
%lu\n",
> 							(unsigned =
long)block));
> -	bh =3D ext4_read_dirblock(dir, block, DIRENT);
> +	bh =3D ext4_read_dirblock(dir, block, DIRENT_HTREE);
> 	if (IS_ERR(bh))
> 		return PTR_ERR(bh);
>=20
> @@ -1619,7 +1622,7 @@ static struct buffer_head * =
ext4_dx_find_entry(struct inode *dir,
> 		return (struct buffer_head *) frame;
> 	do {
> 		block =3D dx_get_block(frame->at);
> -		bh =3D ext4_read_dirblock(dir, block, DIRENT);
> +		bh =3D ext4_read_dirblock(dir, block, DIRENT_HTREE);
> 		if (IS_ERR(bh))
> 			goto errout;
>=20
> @@ -2203,6 +2206,11 @@ static int ext4_add_entry(handle_t *handle, =
struct dentry *dentry,
> 	blocks =3D dir->i_size >> sb->s_blocksize_bits;
> 	for (block =3D 0; block < blocks; block++) {
> 		bh =3D ext4_read_dirblock(dir, block, DIRENT);
> +		if (bh =3D=3D NULL) {
> +			bh =3D ext4_bread(handle, dir, block,
> +					EXT4_GET_BLOCKS_CREATE);
> +			goto add_to_new_block;
> +		}
> 		if (IS_ERR(bh)) {
> 			retval =3D PTR_ERR(bh);
> 			bh =3D NULL;
> @@ -2223,6 +2231,7 @@ static int ext4_add_entry(handle_t *handle, =
struct dentry *dentry,
> 		brelse(bh);
> 	}
> 	bh =3D ext4_append(handle, dir, &block);
> +add_to_new_block:
> 	if (IS_ERR(bh)) {
> 		retval =3D PTR_ERR(bh);
> 		bh =3D NULL;
> @@ -2267,7 +2276,7 @@ static int ext4_dx_add_entry(handle_t *handle, =
struct ext4_filename *fname,
> 		return PTR_ERR(frame);
> 	entries =3D frame->entries;
> 	at =3D frame->at;
> -	bh =3D ext4_read_dirblock(dir, dx_get_block(frame->at), DIRENT);
> +	bh =3D ext4_read_dirblock(dir, dx_get_block(frame->at), =
DIRENT_HTREE);
> 	if (IS_ERR(bh)) {
> 		err =3D PTR_ERR(bh);
> 		bh =3D NULL;
> @@ -2815,7 +2824,10 @@ bool ext4_empty_dir(struct inode *inode)
> 		EXT4_ERROR_INODE(inode, "invalid size");
> 		return true;
> 	}
> -	bh =3D ext4_read_dirblock(inode, 0, EITHER);
> +	/* The first directory block must not be a hole,
> +	 * so treat it as DIRENT_HTREE
> +	 */
> +	bh =3D ext4_read_dirblock(inode, 0, DIRENT_HTREE);
> 	if (IS_ERR(bh))
> 		return true;
>=20
> @@ -2837,6 +2849,10 @@ bool ext4_empty_dir(struct inode *inode)
> 			brelse(bh);
> 			lblock =3D offset >> EXT4_BLOCK_SIZE_BITS(sb);
> 			bh =3D ext4_read_dirblock(inode, lblock, =
EITHER);
> +			if (bh =3D=3D NULL) {
> +				offset +=3D sb->s_blocksize;
> +				continue;
> +			}
> 			if (IS_ERR(bh))
> 				return true;
> 			de =3D (struct ext4_dir_entry_2 *) bh->b_data;
> @@ -3402,7 +3418,10 @@ static struct buffer_head =
*ext4_get_first_dir_block(handle_t *handle,
> 	struct buffer_head *bh;
>=20
> 	if (!ext4_has_inline_data(inode)) {
> -		bh =3D ext4_read_dirblock(inode, 0, EITHER);
> +		/* The first directory block must not be a hole, so
> +		 * treat it as DIRENT_HTREE
> +		 */
> +		bh =3D ext4_read_dirblock(inode, 0, DIRENT_HTREE);
> 		if (IS_ERR(bh)) {
> 			*retval =3D PTR_ERR(bh);
> 			return NULL;
> --
> 2.22.0
>=20


Cheers, Andreas






--Apple-Mail=_904608D4-9C02-4CC9-A921-9213D219460B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl0QSO8ACgkQcqXauRfM
H+BaJhAAvHPGVu2WKTOxFwgmQygFl0xQoczbtx2g8dFckGoYyscU0FdlgPF79p++
zAD1A9pB4qjWHW6ZFaT6yPh8+giuhjchfJAppG4mxQ0B4J+SECx2LB6J+y6+np5a
qjPXVmydzgnBmJVyS9wQG4lea6P5+krgPjHsfW2wLklspNP1vzDYHN36of3WCjmp
w4uRjsdFJME94g18nRuIASuQeXaCc7ql/PmK3oY9QTCGh6YI6Sr9ZWpxvyBuoguu
BXUiavLqxjbi+/PdyadGWEinZvHpGobfQuOZlPij30FyfFvr5FJFXiJlFHLQ5STR
A2xhRP98ibJ7hKj2wy0takKBwnHM1Ouq1KjzZd36/mHjQHXSkhvz3lKDD5ZiswjZ
D7l0od/FXuCBCb1VPvfsO+kMXWb2wt8b4XHKsFPIp8HvzNer2L0/8Bb4lbgoFL0w
6VKmTW2O7kFc4Q2XhVMzlLKV7l0uiXtnf+OJv9fiG+PY9Qyx4pmdUGIHTzw3wxT8
vIRGeFbqGDLEYUFIioviJiI8XmHZupaXGc79EHE0oBbaOd3vsjNxZjnys9yvqx03
wgNT5jvRrrRQcp5ZctWU9WEb/cmh8QVnajHeZoKfsT2qQU0qIRFeXPFw7GWnx0OH
HlMb32GRcZX+sJAaKzNfzVJiGyrIe96dCZGWcZG0yy6fpsKNAxk=
=0vtY
-----END PGP SIGNATURE-----

--Apple-Mail=_904608D4-9C02-4CC9-A921-9213D219460B--
