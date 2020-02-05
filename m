Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9C15370C
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2020 18:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBERuY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Feb 2020 12:50:24 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39261 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgBERuX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Feb 2020 12:50:23 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so1305730pjr.4
        for <linux-ext4@vger.kernel.org>; Wed, 05 Feb 2020 09:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=wch0NwIBWqcpKgzOplIJ8H4PujY2Eh2CGiK9mHtsXh4=;
        b=M85WOjU7f4Dl6XPBJAYp6/M+7dwMWhUPP0G9oepBApHLdyL96wfa4BosrFhtUVHCtQ
         kAg30mnwvhquPr6kUhrtafRoav3mBy4wPuL104saErDi4Ln1eotiEAKOZqMjPc0+Spdj
         HvNLpAelGOCnE9SqtJ7gFSrBcObjBucWKmz7anrQ3jcYyeFl0As6ZVpcgmwYRnSft8mw
         UMk8ZBoG0gYvsokB7q3zFHBd54j6KBZlGRrDSxq3y7Hy6b3DG7RnupZ1MtY4fHPmSaBz
         aixzgTSUNvhYiKbVi/XfQoeN/e8lmWiF8mFOLiCMvZF6rRSpEb7IvoVB6s5MKueYOFtA
         JyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=wch0NwIBWqcpKgzOplIJ8H4PujY2Eh2CGiK9mHtsXh4=;
        b=AjGRcNAL0Uuq28RSEdvIk7J79kCmoPWlTxH5Q3HJbcq62Ctm2x3qiJC8ibZWmE23l/
         VFX5keipnP6J6PYQHT/scYXJJ83Yy/z7kH1tR0i1QCJNHkewrCuAwfgLYQAoUq4dHpzQ
         QO5/56GBLfd7FWZmEEe9EZM1Iu90QmW+L61fOqB0qPvzhG0u3rSAD6r9gJrcQbiBb47D
         jsPaiGVTUdyUPvy4WUc4i+/crJYcWXsFZ2BRyZE2RryeZlbW/hX3CvY/07vSO0rw4Dya
         f4O7AW1X9R21W1EL1CI7YfIdzION9DuPeyH1LV9r0+lehvxidxXKPjcxJnHyFApr3fmJ
         zpYQ==
X-Gm-Message-State: APjAAAW2umjLLOymVfqxwVcGKwlo4NiCC0Su1H8Php80CkuP4S/0+oCs
        XNuE/V+/PS7GD46egST3PtlXcg==
X-Google-Smtp-Source: APXvYqztjargN73U6F0ZUAAIpm/0yu+bZ0yPgWJwFwtpShI+9t75I+SApMSOQTJW2mcfBHhNr78gpw==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr37108912pld.58.1580925021539;
        Wed, 05 Feb 2020 09:50:21 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id s124sm146195pfc.57.2020.02.05.09.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 09:50:20 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4182C838-A947-4BA7-939F-16624344D4C4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4D0AAC9A-1760-432A-9353-1AD633900D04";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/3] ext2fs: Implement dir entry creation in htree
 directories
Date:   Wed, 5 Feb 2020 10:50:16 -0700
In-Reply-To: <20200205100138.30053-3-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4 <linux-ext4@vger.kernel.org>
To:     Jan Kara <jack@suse.cz>
References: <20200205100138.30053-1-jack@suse.cz>
 <20200205100138.30053-3-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4D0AAC9A-1760-432A-9353-1AD633900D04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 5, 2020, at 3:01 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Implement proper creation of new directory entries in htree =
directories
> in ext2fs_link(). So far we just cleared EXT2_INDEX_FL and treated
> directory as unindexed however this results in mismatched checksums if
> metadata checksums are in use because checksums are placed in =
different
> places depending on htree node type.

I'm definitely not agains this, as I believe it will also speed up =
e2fsck
for cases where a lot of entries are inserted into lost+found (sometimes
many millions of files).  Currently e2fsck linearly scans the whole dir
for each insert, rather than saving the offset of the last entry.  I =
have
a patch to fix that, but it needed several API changes and got bogged =
down
in performance testing and never made it out to the list.

One potential risk is that if a directory is corrupted in some way, then
the htree index cannot always be trusted to do inserts during e2fsck, so
it might still have to fall back to clearing the flag and doing a linear
insertion.

Cheers, Andreas

>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> lib/ext2fs/link.c | 549 =
++++++++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 497 insertions(+), 52 deletions(-)
>=20
> diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
> index 65dc8877a5c7..034225e348e9 100644
> --- a/lib/ext2fs/link.c
> +++ b/lib/ext2fs/link.c
> @@ -18,6 +18,155 @@
>=20
> #include "ext2_fs.h"
> #include "ext2fs.h"
> +#include "ext2fsP.h"
> +
> +#define EXT2_DX_ROOT_OFF 24
> +
> +struct dx_frame {
> +	void *buf;
> +	blk64_t pblock;
> +	struct ext2_dx_countlimit *head;
> +	struct ext2_dx_entry *entries;
> +	struct ext2_dx_entry *at;
> +};
> +
> +struct dx_lookup_info {
> +	const char *name;
> +	int namelen;
> +	int hash_alg;
> +	__u32 hash;
> +	int levels;
> +	struct dx_frame frames[EXT4_HTREE_LEVEL];
> +};
> +
> +static errcode_t alloc_dx_frame(ext2_filsys fs, struct dx_frame =
*frame)
> +{
> +	return ext2fs_get_mem(fs->blocksize, &frame->buf);
> +}
> +
> +static void dx_release(struct dx_lookup_info *info)
> +{
> +	struct ext2_dx_root_info *root;
> +	int level;
> +
> +	for (level =3D 0; level < info->levels; level++) {
> +		if (info->frames[level].buf =3D=3D NULL)
> +			break;
> +		ext2fs_free_mem(&(info->frames[level].buf));
> +	}
> +	info->levels =3D 0;
> +}
> +
> +static void dx_search_entry(struct dx_frame *frame, int count, __u32 =
hash)
> +{
> +	struct ext2_dx_entry *p, *q, *m;
> +
> +	p =3D frame->entries + 1;
> +	q =3D frame->entries + count - 1;
> +	while (p <=3D q) {
> +		m =3D p + (q - p) / 2;
> +		if (ext2fs_le32_to_cpu(m->hash) > hash)
> +			q =3D m - 1;
> +		else
> +			p =3D m + 1;
> +	}
> +	frame->at =3D p - 1;
> +}
> +
> +static errcode_t load_logical_dir_block(ext2_filsys fs, ext2_ino_t =
dir,
> +					struct ext2_inode *diri, blk64_t =
block,
> +					blk64_t *pblk, void *buf)
> +{
> +	errcode_t errcode;
> +	int ret_flags;
> +
> +	errcode =3D ext2fs_bmap2(fs, dir, diri, NULL, 0, block, =
&ret_flags,
> +			       pblk);
> +	if (errcode)
> +		return errcode;
> +	if (ret_flags & BMAP_RET_UNINIT)
> +		return EXT2_ET_DIR_CORRUPTED;
> +	return ext2fs_read_dir_block4(fs, *pblk, buf, 0, dir);
> +}
> +
> +static errcode_t dx_lookup(ext2_filsys fs, ext2_ino_t dir,
> +			   struct ext2_inode *diri, struct =
dx_lookup_info *info)
> +{
> +	struct ext2_dx_root_info *root;
> +	errcode_t errcode;
> +	int level =3D 0;
> +	int count, limit;
> +	int hash_alg;
> +	int hash_flags =3D diri->i_flags & EXT4_CASEFOLD_FL;
> +	__u32 hash, minor_hash;
> +	struct dx_frame *frame;
> +
> +	errcode =3D alloc_dx_frame(fs, &(info->frames[0]));
> +	if (errcode)
> +		return errcode;
> +	info->levels =3D 1;
> +
> +	errcode =3D load_logical_dir_block(fs, dir, diri, 0,
> +					 &(info->frames[0].pblock),
> +					 info->frames[0].buf);
> +	if (errcode)
> +		goto out_err;
> +	root =3D info->frames[0].buf + EXT2_DX_ROOT_OFF;
> +	hash_alg =3D root->hash_version;
> +	if (hash_alg !=3D EXT2_HASH_TEA && hash_alg !=3D =
EXT2_HASH_HALF_MD4 &&
> +	    hash_alg !=3D EXT2_HASH_LEGACY) {
> +		errcode =3D EXT2_ET_DIRHASH_UNSUPP;
> +		goto out_err;
> +	}
> +	if (hash_alg <=3D EXT2_HASH_TEA &&
> +	    fs->super->s_flags & EXT2_FLAGS_UNSIGNED_HASH)
> +		hash_alg +=3D 3;
> +	if (root->indirect_levels >=3D ext2_dir_htree_level(fs)) {
> +		errcode =3D EXT2_ET_DIR_CORRUPTED;
> +		goto out_err;
> +	}
> +	info->hash_alg =3D hash_alg;
> +
> +	errcode =3D ext2fs_dirhash2(hash_alg, info->name, info->namelen,
> +				  fs->encoding, hash_flags,
> +				  fs->super->s_hash_seed, &info->hash,
> +				  &minor_hash);
> +	if (errcode)
> +		goto out_err;
> +
> +	for (level =3D 0; level <=3D root->indirect_levels; level++) {
> +		frame =3D &(info->frames[level]);
> +		if (level > 0) {
> +			errcode =3D alloc_dx_frame(fs, frame);
> +			if (errcode)
> +				goto out_err;
> +			info->levels++;
> +
> +			errcode =3D load_logical_dir_block(fs, dir, =
diri,
> +				=
ext2fs_le32_to_cpu(info->frames[level-1].at->block) & 0x0fffffff,
> +				&(frame->pblock), frame->buf);
> +			if (errcode)
> +				goto out_err;
> +		}
> +		errcode =3D ext2fs_get_dx_countlimit(fs, frame->buf,
> +						   &(frame->head), =
NULL);
> +		if (errcode)
> +			goto out_err;
> +		count =3D ext2fs_le16_to_cpu(frame->head->count);
> +		limit =3D ext2fs_le16_to_cpu(frame->head->limit);
> +		frame->entries =3D (struct ext2_dx_entry =
*)(frame->head);
> +		if (!count || count > limit) {
> +			errcode =3D EXT2_ET_DIR_CORRUPTED;
> +			goto out_err;
> +		}
> +
> +		dx_search_entry(frame, count, info->hash);
> +	}
> +	return 0;
> +out_err:
> +	dx_release(info);
> +	return errcode;
> +}
>=20
> struct link_struct  {
> 	ext2_filsys	fs;
> @@ -31,7 +180,9 @@ struct link_struct  {
> 	struct ext2_super_block *sb;
> };
>=20
> -static int link_proc(struct ext2_dir_entry *dirent,
> +static int link_proc(ext2_ino_t dir EXT2FS_ATTR((unused)),
> +		     int entru EXT2FS_ATTR((unused)),
> +		     struct ext2_dir_entry *dirent,
> 		     int	offset,
> 		     int	blocksize,
> 		     char	*buf,
> @@ -70,40 +221,6 @@ static int link_proc(struct ext2_dir_entry =
*dirent,
> 		ret =3D DIRENT_CHANGED;
> 	}
>=20
> -	/*
> -	 * Since ext2fs_link blows away htree data, we need to be
> -	 * careful -- if metadata_csum is enabled and we're passed in
> -	 * a dirent that contains htree data, we need to create the
> -	 * fake entry at the end of the block that hides the checksum.
> -	 */
> -
> -	/* De-convert a dx_node block */
> -	if (csum_size &&
> -	    curr_rec_len =3D=3D ls->fs->blocksize &&
> -	    !dirent->inode) {
> -		curr_rec_len -=3D csum_size;
> -		ls->err =3D ext2fs_set_rec_len(ls->fs, curr_rec_len, =
dirent);
> -		if (ls->err)
> -			return DIRENT_ABORT;
> -		t =3D EXT2_DIRENT_TAIL(buf, ls->fs->blocksize);
> -		ext2fs_initialize_dirent_tail(ls->fs, t);
> -		ret =3D DIRENT_CHANGED;
> -	}
> -
> -	/* De-convert a dx_root block */
> -	if (csum_size &&
> -	    curr_rec_len =3D=3D ls->fs->blocksize - EXT2_DIR_REC_LEN(1) =
&&
> -	    offset =3D=3D EXT2_DIR_REC_LEN(1) &&
> -	    dirent->name[0] =3D=3D '.' && dirent->name[1] =3D=3D '.') {
> -		curr_rec_len -=3D csum_size;
> -		ls->err =3D ext2fs_set_rec_len(ls->fs, curr_rec_len, =
dirent);
> -		if (ls->err)
> -			return DIRENT_ABORT;
> -		t =3D EXT2_DIRENT_TAIL(buf, ls->fs->blocksize);
> -		ext2fs_initialize_dirent_tail(ls->fs, t);
> -		ret =3D DIRENT_CHANGED;
> -	}
> -
> 	/*
> 	 * If the directory entry is used, see if we can split the
> 	 * directory entry to make room for the new name.  If so,
> @@ -144,6 +261,343 @@ static int link_proc(struct ext2_dir_entry =
*dirent,
> 	return DIRENT_ABORT|DIRENT_CHANGED;
> }
>=20
> +static errcode_t add_dirent_to_buf(ext2_filsys fs, e2_blkcnt_t =
blockcnt,
> +				   char *buf, ext2_ino_t dir,
> +				   struct ext2_inode *diri, const char =
*name,
> +				   ext2_ino_t ino, int flags, blk64_t =
*pblkp)
> +{
> +	struct dir_context ctx;
> +	struct link_struct ls;
> +	errcode_t retval;
> +
> +	retval =3D load_logical_dir_block(fs, dir, diri, blockcnt, =
pblkp, buf);
> +	if (retval)
> +		return retval;
> +	ctx.errcode =3D 0;
> +	ctx.func =3D link_proc;
> +	ctx.dir =3D dir;
> +	ctx.flags =3D DIRENT_FLAG_INCLUDE_EMPTY;
> +	ctx.buf =3D buf;
> +	ctx.priv_data =3D &ls;
> +
> +	ls.fs =3D fs;
> +	ls.name =3D name;
> +	ls.namelen =3D strlen(name);
> +	ls.inode =3D ino;
> +	ls.flags =3D flags;
> +	ls.done =3D 0;
> +	ls.sb =3D fs->super;
> +	ls.blocksize =3D fs->blocksize;
> +	ls.err =3D 0;
> +
> +	ext2fs_process_dir_block(fs, pblkp, blockcnt, 0, 0, &ctx);
> +	if (ctx.errcode)
> +		return ctx.errcode;
> +	if (ls.err)
> +		return ls.err;
> +	if (!ls.done)
> +		return EXT2_ET_DIR_NO_SPACE;
> +	return 0;
> +}
> +
> +struct dx_hash_map {
> +	__u32 hash;
> +	int size;
> +	int off;
> +};
> +
> +static EXT2_QSORT_TYPE dx_hash_map_cmp(const void *ap, const void =
*bp)
> +{
> +	const struct dx_hash_map *a =3D ap, *b =3D bp;
> +
> +	if (a->hash < b->hash)
> +		return -1;
> +	if (a->hash > b->hash)
> +		return 1;
> +	return 0;
> +}
> +
> +static errcode_t dx_move_dirents(ext2_filsys fs, struct dx_hash_map =
*map,
> +				 int count, void *from, void *to)
> +{
> +	struct ext2_dir_entry *de;
> +	int i;
> +	int rec_len;
> +	errcode_t retval;
> +	int csum_size =3D 0;
> +	void *base =3D to;
> +
> +	if (ext2fs_has_feature_metadata_csum(fs->super))
> +		csum_size =3D sizeof(struct ext2_dir_entry_tail);
> +
> +	for (i =3D 0; i < count; i++) {
> +		de =3D from + map[i].off;
> +		rec_len =3D =
EXT2_DIR_REC_LEN(ext2fs_dirent_name_len(de));
> +		memcpy(to, de, rec_len);
> +		retval =3D ext2fs_set_rec_len(fs, rec_len, to);
> +		if (retval)
> +			return retval;
> +		to +=3D rec_len;
> +	}
> +	/*
> +	 * Update rec_len of the last dir entry to stretch to the end of =
block
> +	 */
> +	to -=3D rec_len;
> +	rec_len =3D fs->blocksize - (to - base) - csum_size;
> +	retval =3D ext2fs_set_rec_len(fs, rec_len, to);
> +	if (retval)
> +		return retval;
> +	if (csum_size)
> +		ext2fs_initialize_dirent_tail(fs,
> +				EXT2_DIRENT_TAIL(base, fs->blocksize));
> +	return 0;
> +}
> +
> +static errcode_t dx_insert_entry(ext2_filsys fs, ext2_ino_t dir,
> +				 struct dx_lookup_info *info, int level,
> +				 __u32 hash, blk64_t lblk)
> +{
> +	int pcount;
> +	struct ext2_dx_entry *top, *new;
> +
> +	pcount =3D ext2fs_le16_to_cpu(info->frames[level].head->count);
> +	top =3D info->frames[level].entries + pcount;
> +	new =3D info->frames[level].at + 1;
> +	memmove(new + 1, new, (char *)top - (char *)new);
> +	new->hash =3D ext2fs_cpu_to_le32(hash);
> +	new->block =3D ext2fs_cpu_to_le32(lblk);
> +	info->frames[level].head->count =3D ext2fs_cpu_to_le16(pcount + =
1);
> +	return ext2fs_write_dir_block4(fs, info->frames[level].pblock,
> +				       info->frames[level].buf, 0, dir);
> +}
> +
> +static errcode_t dx_split_leaf(ext2_filsys fs, ext2_ino_t dir,
> +			       struct ext2_inode *diri,
> +			       struct dx_lookup_info *info, void *buf,
> +			       blk64_t leaf_pblk, blk64_t new_lblk,
> +			       blk64_t new_pblk)
> +{
> +	int hash_flags =3D diri->i_flags & EXT4_CASEFOLD_FL;
> +	struct ext2_dir_entry *de;
> +	void *buf2;
> +	errcode_t retval =3D 0;
> +	int rec_len;
> +	int offset, move_size;
> +	int i, count =3D 0;
> +	struct dx_hash_map *map;
> +	int continued;
> +	__u32 minor_hash;
> +
> +	retval =3D ext2fs_get_mem(fs->blocksize, &buf2);
> +	if (retval)
> +		return retval;
> +	retval =3D ext2fs_get_array(fs->blocksize / 12,
> +				  sizeof(struct dx_hash_map), &map);
> +	if (retval) {
> +		ext2fs_free_mem(&buf2);
> +		return retval;
> +	}
> +	for (offset =3D 0; offset < fs->blocksize; offset +=3D rec_len) =
{
> +		de =3D buf + offset;
> +		retval =3D ext2fs_get_rec_len(fs, de, &rec_len);
> +		if (retval)
> +			goto out;
> +		if (ext2fs_dirent_name_len(de) > 0 && de->inode) {
> +			map[count].off =3D offset;
> +			map[count].size =3D rec_len;
> +			retval =3D ext2fs_dirhash2(info->hash_alg, =
de->name,
> +					ext2fs_dirent_name_len(de),
> +					fs->encoding, hash_flags,
> +					fs->super->s_hash_seed,
> +					&(map[count].hash),
> +					&minor_hash);
> +			if (retval)
> +				goto out;
> +			count++;
> +		}
> +	}
> +	qsort(map, count, sizeof(struct dx_hash_map), dx_hash_map_cmp);
> +	move_size =3D 0;
> +	/* Find place to split block */
> +	for (i =3D count - 1; i >=3D 0; i--) {
> +		if (move_size + map[i].size / 2 > fs->blocksize / 2)
> +			break;
> +		move_size +=3D map[i].size;
> +	}
> +	/* Let i be the first entry to move */
> +	i++;
> +	/* Move selected directory entries to new block */
> +	retval =3D dx_move_dirents(fs, map + i, count - i, buf, buf2);
> +	if (retval)
> +		goto out;
> +	retval =3D ext2fs_write_dir_block4(fs, new_pblk, buf2, 0, dir);
> +	if (retval)
> +		goto out;
> +	/* Repack remaining entries in the old block */
> +	retval =3D dx_move_dirents(fs, map, i, buf, buf2);
> +	if (retval)
> +		goto out;
> +	retval =3D ext2fs_write_dir_block4(fs, leaf_pblk, buf2, 0, dir);
> +	if (retval)
> +		goto out;
> +	/* Update parent node */
> +	continued =3D map[i].hash =3D=3D map[i-1].hash;
> +	retval =3D dx_insert_entry(fs, dir, info, info->levels - 1,
> +				 map[i].hash + continued, new_lblk);
> +out:
> +	ext2fs_free_mem(&buf2);
> +	ext2fs_free_mem(&map);
> +	return retval;
> +}
> +
> +static errcode_t dx_grow_tree(ext2_filsys fs, ext2_ino_t dir,
> +			      struct ext2_inode *diri,
> +			      struct dx_lookup_info *info, void *buf,
> +			      blk64_t leaf_pblk)
> +{
> +	int i;
> +	errcode_t retval;
> +	ext2_off64_t size =3D EXT2_I_SIZE(diri);
> +	blk64_t lblk, pblk;
> +	struct ext2_dir_entry *de;
> +	struct ext2_dx_countlimit *head;
> +	int csum_size =3D 0;
> +	int count;
> +
> +	if (ext2fs_has_feature_metadata_csum(fs->super))
> +		csum_size =3D sizeof(struct ext2_dx_tail);
> +
> +	/* Find level which can accommodate new child */
> +	for (i =3D info->levels - 1; i >=3D 0; i--)
> +		if (ext2fs_le16_to_cpu(info->frames[i].head->count) <
> +		    ext2fs_le16_to_cpu(info->frames[i].head->limit))
> +			break;
> +	/* Need to grow tree depth? */
> +	if (i < 0 && info->levels >=3D ext2_dir_htree_level(fs))
> +		return EXT2_ET_DIR_NO_SPACE;
> +	lblk =3D size / fs->blocksize;
> +	size +=3D fs->blocksize;
> +	retval =3D ext2fs_inode_size_set(fs, diri, size);
> +	if (retval)
> +		return retval;
> +	retval =3D ext2fs_fallocate(fs,
> +			EXT2_FALLOCATE_FORCE_INIT | =
EXT2_FALLOCATE_ZERO_BLOCKS,
> +			dir, diri, 0, lblk, 1);
> +	if (retval)
> +		return retval;
> +	retval =3D ext2fs_write_inode(fs, dir, diri);
> +	if (retval)
> +		return retval;
> +	retval =3D ext2fs_bmap2(fs, dir, diri, NULL, 0, lblk, NULL, =
&pblk);
> +	if (retval)
> +		return retval;
> +	/* Only leaf addition needed? */
> +	if (i =3D=3D info->levels - 1)
> +		return dx_split_leaf(fs, dir, diri, info, buf, =
leaf_pblk,
> +				     lblk, pblk);
> +
> +	de =3D buf;
> +	de->inode =3D 0;
> +	ext2fs_dirent_set_name_len(de, 0);
> +	ext2fs_dirent_set_file_type(de, 0);
> +	retval =3D ext2fs_set_rec_len(fs, fs->blocksize, de);
> +	if (retval)
> +		return retval;
> +	head =3D buf + 8;
> +	count =3D ext2fs_le16_to_cpu(info->frames[i+1].head->count);
> +	/* Growing tree depth? */
> +	if (i < 0) {
> +		struct ext2_dx_root_info *root;
> +
> +		memcpy(head, info->frames[0].entries,
> +		       count * sizeof(struct ext2_dx_entry));
> +		head->limit =3D ext2fs_cpu_to_le16(
> +				(fs->blocksize - (8 + csum_size)) /
> +				sizeof(struct ext2_dx_entry));
> +		/* head->count gets set by memcpy above to correct value =
*/
> +
> +		/* Now update tree root */
> +		info->frames[0].head->count =3D ext2fs_cpu_to_le16(1);
> +		info->frames[0].entries[0].block =3D =
ext2fs_cpu_to_le32(lblk);
> +		root =3D info->frames[0].buf + EXT2_DX_ROOT_OFF;
> +		root->indirect_levels++;
> +	} else {
> +		/* Splitting internal node in two */
> +		int count1 =3D count / 2;
> +		int count2 =3D count - count1;
> +		__u32 split_hash =3D =
ext2fs_le32_to_cpu(info->frames[i+1].entries[count1].hash);
> +
> +		memcpy(head, info->frames[i+1].entries + count1,
> +		       count2 * sizeof(struct ext2_dx_entry));
> +		head->count =3D ext2fs_cpu_to_le16(count2);
> +		head->limit =3D ext2fs_cpu_to_le16(
> +				(fs->blocksize - (8 + csum_size)) /
> +				sizeof(struct ext2_dx_entry));
> +		info->frames[i+1].head->count =3D =
ext2fs_cpu_to_le16(count1);
> +
> +		/* Update parent node */
> +		retval =3D dx_insert_entry(fs, dir, info, i, split_hash, =
lblk);
> +		if (retval)
> +			return retval;
> +
> +	}
> +	/* Writeout split block / updated root */
> +	retval =3D ext2fs_write_dir_block4(fs, info->frames[i+1].pblock,
> +					 info->frames[i+1].buf, 0, dir);
> +	if (retval)
> +		return retval;
> +	/* Writeout new tree block */
> +	retval =3D ext2fs_write_dir_block4(fs, pblk, buf, 0, dir);
> +	if (retval)
> +		return retval;
> +	return 0;
> +}
> +
> +static errcode_t dx_link(ext2_filsys fs, ext2_ino_t dir,
> +			 struct ext2_inode *diri, const char *name,
> +			 ext2_ino_t ino, int flags)
> +{
> +	struct dx_lookup_info dx_info;
> +	errcode_t retval;
> +	void *blockbuf;
> +	int restart =3D 0;
> +	blk64_t leaf_pblk;
> +
> +	retval =3D ext2fs_get_mem(fs->blocksize, &blockbuf);
> +	if (retval)
> +		return retval;
> +
> +	dx_info.name =3D name;
> +	dx_info.namelen =3D strlen(name);
> +again:
> +	retval =3D dx_lookup(fs, dir, diri, &dx_info);
> +	if (retval < 0)
> +		goto free_buf;
> +
> +	retval =3D add_dirent_to_buf(fs,
> +		=
ext2fs_le32_to_cpu(dx_info.frames[dx_info.levels-1].at->block) & =
0x0fffffff,
> +		blockbuf, dir, diri, name, ino, flags, &leaf_pblk);
> +	/*
> +	 * Success or error other than ENOSPC...? We are done. We may =
need upto
> +	 * two tries to add entry. One to split htree node and another =
to add
> +	 * new leaf block.
> +	 */
> +	if (restart >=3D 2 || retval !=3D EXT2_ET_DIR_NO_SPACE)
> +		goto free_frames;
> +	retval =3D dx_grow_tree(fs, dir, diri, &dx_info, blockbuf, =
leaf_pblk);
> +	if (retval)
> +		goto free_frames;
> +	/* Restart everything now that the tree is larger */
> +	restart++;
> +	dx_release(&dx_info);
> +	goto again;
> +free_frames:
> +	dx_release(&dx_info);
> +free_buf:
> +	ext2fs_free_mem(&blockbuf);
> +	return retval;
> +}
> +
> /*
>  * Note: the low 3 bits of the flags field are used as the directory
>  * entry filetype.
> @@ -163,6 +617,12 @@ errcode_t ext2fs_link(ext2_filsys fs, ext2_ino_t =
dir, const char *name,
> 	if (!(fs->flags & EXT2_FLAG_RW))
> 		return EXT2_ET_RO_FILSYS;
>=20
> +	if ((retval =3D ext2fs_read_inode(fs, dir, &inode)) !=3D 0)
> +		return retval;
> +
> +	if (inode.i_flags & EXT2_INDEX_FL)
> +		return dx_link(fs, dir, &inode, name, ino, flags);
> +
> 	ls.fs =3D fs;
> 	ls.name =3D name;
> 	ls.namelen =3D name ? strlen(name) : 0;
> @@ -173,8 +633,8 @@ errcode_t ext2fs_link(ext2_filsys fs, ext2_ino_t =
dir, const char *name,
> 	ls.blocksize =3D fs->blocksize;
> 	ls.err =3D 0;
>=20
> -	retval =3D ext2fs_dir_iterate(fs, dir, =
DIRENT_FLAG_INCLUDE_EMPTY,
> -				    0, link_proc, &ls);
> +	retval =3D ext2fs_dir_iterate2(fs, dir, =
DIRENT_FLAG_INCLUDE_EMPTY,
> +				     NULL, link_proc, &ls);
> 	if (retval)
> 		return retval;
> 	if (ls.err)
> @@ -182,20 +642,5 @@ errcode_t ext2fs_link(ext2_filsys fs, ext2_ino_t =
dir, const char *name,
>=20
> 	if (!ls.done)
> 		return EXT2_ET_DIR_NO_SPACE;
> -
> -	if ((retval =3D ext2fs_read_inode(fs, dir, &inode)) !=3D 0)
> -		return retval;
> -
> -	/*
> -	 * If this function changes to preserve the htree, remove the
> -	 * two hunks in link_proc that shove checksum tails into the
> -	 * former dx_root/dx_node blocks.
> -	 */
> -	if (inode.i_flags & EXT2_INDEX_FL) {
> -		inode.i_flags &=3D ~EXT2_INDEX_FL;
> -		if ((retval =3D ext2fs_write_inode(fs, dir, &inode)) !=3D =
0)
> -			return retval;
> -	}
> -
> 	return 0;
> }
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_4D0AAC9A-1760-432A-9353-1AD633900D04
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl47AFgACgkQcqXauRfM
H+AS5hAAnfuUEAiikiEXswS7S8sy41pacZsxQ74dO77i1zM9riXizrEvfRYah3Zl
O/YT3+WmypvWadClyZmx2gEwE5o43YlsxQNQ4ErMaA25NnZhpGiFXlSSM0jdci/q
M40zDlV2eyRs8JS2bTMzWEoUB6ynEbsOPshblHbnBK9DJuyvOlfyVNe5vaLHAe0P
iuO+em6C2/d5wmB2MW3JupdNrASc7zvfMua97IAAYhu/LTi6X21WS6IovCm5FB1t
yFP4cPn5atZ6sCZQEOIaNi9L6qbHuuq3aUPTELTjg3Zor8DAXle3RddIvTKnzWB/
Cf+C/8X0lyYG501YxNdyuZvENVibsgSMB/EWUX/9AkAOx/8C5nNFNnds5cPJB1ge
+SvvwIhtO4N98pxdUqZUQx3kX7kDroHt5RXIGSeQA322twQB02Muk/sSNPlj0bSo
u2kN1q2tBL4TGwwMCrgW3lgKvnE5xYOaLo5k4vRW7o0QfsabDS+URpDHrPTDszs1
+JRLpnOK1c0FG75G0oBYGZrzuP6F3p0aMwFSsZybCVHKnr5EReFxvdUHQoCndFBy
eNy2dIFgAi5H/TdIcinxDbCkhek1+dQRXlU0s3B8r288XC2qeeBKCPcuy+Ou0BdL
S9+xu9gODv/4GIDTdQwDJvBcaVUpFx/a3aY1xyJ2fTfvBjjjtsA=
=p6Xb
-----END PGP SIGNATURE-----

--Apple-Mail=_4D0AAC9A-1760-432A-9353-1AD633900D04--
