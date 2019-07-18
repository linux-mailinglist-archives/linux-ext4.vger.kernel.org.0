Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0626C951
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2019 08:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfGRGae (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jul 2019 02:30:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43462 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRGae (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jul 2019 02:30:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so12104107pfg.10
        for <linux-ext4@vger.kernel.org>; Wed, 17 Jul 2019 23:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=PAmsVhslI2Erfeuhth9sWEJ7oLGYFaRziAJNwCQoI8s=;
        b=ntJJLwuWnIRohABELg7T4qWG/3zo4ghZvUwFBTTTHOSo1WVgtUxcTmIkUNl4D7s5O3
         4jFwi78PVmS+/LPUGm7hwPWf0tGDH9QssmXQJ6KMXUji+5O7q+iPJXwAd6JaSJyrzBRt
         xdmd0DBshbmvf+2+AU6hL7VSnkMEqncYxe9uUaDILcEe3XJIdeOKTDFC4GFN1MMNsuPd
         PNFsRLNcN1kP2Si8VkU5V2WnBRvmU8G3GkuYq9nwXeFlK+ebuLNvgCM8JMz+MQUqN30i
         QnUBXRyQOjQVl0PIt0SxQyX5ENBtEsRbvr91W92WfFc6yVZ89VRTJvNTt7MCSpKb4ZS6
         PYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=PAmsVhslI2Erfeuhth9sWEJ7oLGYFaRziAJNwCQoI8s=;
        b=ZKzsF4XgqPiIE8gkuAVc//EaTwIe6/L75mfg63X6W9kkVq+7Uo4S5xplh2hPPKEuV7
         Lp0J1ZLySbaJEjt2XG3l0KZqF960iGDW03DlPNgO6QcgMFoiLk6VgrOT9uebxhYzjmH/
         BrSrYfkid3NcI1ktOKlMQZQXjU+YsDcH9taNxJSH37y+T5ohiZKiXT5HAKFGn2M9tsgA
         YPqxmv8q1bvC2vm02VTd5RDVbydG342tb2hXP32ukzW3IGoLFunTaAUEZI74EMdql74E
         A1MXzkCtRyHRPOkDVaMZmNHm2L24I9JV3dum1XXDnjxCIo/PGbo8TxKNFHEY4M0lsctK
         6TgA==
X-Gm-Message-State: APjAAAXICN49zFQkRjpYPveomE982+xe2MLiyin7eFQy6TWk1PwMth8N
        nNZNtu4tUn6RA2ktc2fZYnYqHMDvHWI=
X-Google-Smtp-Source: APXvYqwN1afkhT2tj2ATWaoJeoTW1/3/IHck/ndIOthcvg61wZYsV3odcFUYWsNk0EvowynbL6z3cg==
X-Received: by 2002:a17:90a:8d0d:: with SMTP id c13mr47509414pjo.137.1563431433389;
        Wed, 17 Jul 2019 23:30:33 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id s24sm26847627pfh.133.2019.07.17.23.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 23:30:32 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9AB08A26-272F-4CB8-BAF8-90B3E1957E47@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AFE0E2D2-15BF-46CE-A6A6-94A2E36D0B15";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH -v2] ext4: allow directory holes
Date:   Thu, 18 Jul 2019 00:30:31 -0600
In-Reply-To: <20190702211132.26626-1-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        artem.blagodarenko@gmail.com, stable@kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
References: <20190702200459.GF3032@mit.edu>
 <20190702211132.26626-1-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_AFE0E2D2-15BF-46CE-A6A6-94A2E36D0B15
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 2, 2019, at 3:11 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> The largedir feature was intended to allow ext4 directories to have
> unmapped directory blocks (e.g., directory holes).  And so the
> released e2fsprogs no longer enforces this for largedir file systems;
> however, the corresponding change to the kernel-side code was not =
made.
>=20
> This commit fixes this oversight.
>=20
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> Cc: stable@kernel.org
> ---
> fs/ext4/dir.c   | 19 +++++++++----------
> fs/ext4/namei.c | 45 +++++++++++++++++++++++++++++++++++++--------
> 2 files changed, 46 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 770a1e6d4672..3a77b7affd09 100644
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
> @@ -148,8 +147,6 @@ static int ext4_readdir(struct file *file, struct =
dir_context *ctx)
> 			return err;
> 	}
>=20
> -	offset =3D ctx->pos & (sb->s_blocksize - 1);
> -
> 	while (ctx->pos < inode->i_size) {
> 		struct ext4_map_blocks map;
>=20
> @@ -158,9 +155,18 @@ static int ext4_readdir(struct file *file, struct =
dir_context *ctx)
> 			goto errout;
> 		}
> 		cond_resched();
> +		offset =3D ctx->pos & (sb->s_blocksize - 1);
> 		map.m_lblk =3D ctx->pos >> EXT4_BLOCK_SIZE_BITS(sb);
> 		map.m_len =3D 1;
> 		err =3D ext4_map_blocks(NULL, inode, &map, 0);
> +		if (err =3D=3D 0) {
> +			/* m_len should never be zero but let's avoid
> +			 * an infinite loop if it somehow is */
> +			if (map.m_len =3D=3D 0)
> +				map.m_len =3D 1;
> +			ctx->pos +=3D map.m_len * sb->s_blocksize;
> +			continue;
> +		}
> 		if (err > 0) {
> 			pgoff_t index =3D map.m_pblk >>
> 					(PAGE_SHIFT - inode->i_blkbits);
> @@ -179,13 +185,6 @@ static int ext4_readdir(struct file *file, struct =
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
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 4909ced4e672..0cda080f3fd5 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -82,8 +82,18 @@ static struct buffer_head *ext4_append(handle_t =
*handle,
> static int ext4_dx_csum_verify(struct inode *inode,
> 			       struct ext4_dir_entry *dirent);
>=20
> +/*
> + * Hints to ext4_read_dirblock regarding whether we expect a =
directory
> + * block being read to be an index block, or a block containing
> + * directory entries (and if the latter, whether it was found via a
> + * logical block in an htree index block).  This is used to control
> + * what sort of sanity checkinig ext4_read_dirblock() will do on the
> + * directory block read from the storage device.  EITHER will means
> + * the caller doesn't know what kind of directory block will be read,
> + * so no specific verification will be done.
> + */
> typedef enum {
> -	EITHER, INDEX, DIRENT
> +	EITHER, INDEX, DIRENT, DIRENT_HTREE
> } dirblock_type_t;
>=20
> #define ext4_read_dirblock(inode, block, type) \
> @@ -109,11 +119,14 @@ static struct buffer_head =
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
> @@ -980,7 +993,7 @@ static int htree_dirblock_to_tree(struct file =
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
> @@ -1619,7 +1632,7 @@ static struct buffer_head * =
ext4_dx_find_entry(struct inode *dir,
> 		return (struct buffer_head *) frame;
> 	do {
> 		block =3D dx_get_block(frame->at);
> -		bh =3D ext4_read_dirblock(dir, block, DIRENT);
> +		bh =3D ext4_read_dirblock(dir, block, DIRENT_HTREE);
> 		if (IS_ERR(bh))
> 			goto errout;
>=20
> @@ -2203,6 +2216,11 @@ static int ext4_add_entry(handle_t *handle, =
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
> @@ -2223,6 +2241,7 @@ static int ext4_add_entry(handle_t *handle, =
struct dentry *dentry,
> 		brelse(bh);
> 	}
> 	bh =3D ext4_append(handle, dir, &block);
> +add_to_new_block:
> 	if (IS_ERR(bh)) {
> 		retval =3D PTR_ERR(bh);
> 		bh =3D NULL;
> @@ -2267,7 +2286,7 @@ static int ext4_dx_add_entry(handle_t *handle, =
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
> @@ -2815,7 +2834,10 @@ bool ext4_empty_dir(struct inode *inode)
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
> @@ -2837,6 +2859,10 @@ bool ext4_empty_dir(struct inode *inode)
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
> @@ -3402,7 +3428,10 @@ static struct buffer_head =
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






--Apple-Mail=_AFE0E2D2-15BF-46CE-A6A6-94A2E36D0B15
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl0wEgcACgkQcqXauRfM
H+Cljw/9EKwxz+sQHLhlKeaQerajNlMan6rIMbcnnfPp5HEUEu2Hc+GToKFwrq1M
c4luNlUWgxhmUMgqF1J64oSBydRLu2pVuxmA1sTDdW1UEMVuAQLcwqy70N5FD1ll
53adz3PCgUV/CObyFHeKn1fcHiEft8MNsh3k3NLe4n+sXxm1sSiSvyCSBJD8L/fa
LFD8Soh751KnHR4KRIHHiZliCEwOoiwdUiCgPcSkiRw5dHTsAUT1xJt/kzW+ad8v
Qn1jKONNxKUrChhNluIMTO1Ud0mdRltohk7pTQFLzjkTZz0o2EARzQ1KmCBNiLTc
A+9IZsLvEnbXpUwzU+mGGSVMVIJxQTIuqwaexHWXrduiueZiKncW7axLzyljl+Eh
4rkvmjckLcFesSF+l6tV3Lied7pQu40MLEkN0yYftJAEzSO3XxN7idJZ+kXIoTY6
B3AX/6fdIRue887bQkC/OgAuM6S33HPZa4Op7+f9z7wN8v3RWgMKzYNIMtt24TJ/
4Cj7w+jp3nku8PwEPIP95FovH0qn4GLGqHi6CJgWTp3MEHiVngoaCoPWvb9zNV29
o6SqrnPnZhSVA1VuBxQe/HO3MdNJ6FVxyv7uo7bhLhhcFIGD3Qg5kJXVbpSb0Z59
0BsQlzsa2IzipA00soZwAUJP67898EWzVHpqJlP/MynnRBilNfw=
=fUfR
-----END PGP SIGNATURE-----

--Apple-Mail=_AFE0E2D2-15BF-46CE-A6A6-94A2E36D0B15--
