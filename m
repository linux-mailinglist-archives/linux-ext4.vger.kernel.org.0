Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD88FB9C
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2019 09:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfHPHBd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Aug 2019 03:01:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43353 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPHBc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Aug 2019 03:01:32 -0400
Received: by mail-io1-f65.google.com with SMTP id 18so4294482ioe.10
        for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2019 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=1Hl5p3wEkdMbwzkhTxxXdSHoRBVV1a00CNqhsS5oIqs=;
        b=VhWInzPIa9M6cbcjO1LpNPdTV+hd8L+I0N9o6EPYQwPI1qFetDxREbHW0CJ3jSGmMw
         j0NehHFg0k2RJ/ebk048c+1ndqpCvD63Mpq4zcCviFlIJymdg4kFuK+5YVkyOD46Sy/X
         p5cnJCfmfcF+5Mw2MXMY4BmWXW0kTXvbyDmJt8FTQStar5vupBaJvIagd/SrOYcSwI3q
         eZFw7pf0qnFtwLcsno+k5B+CFIMFRPz55v5QDIKjNW0HPXAmsTDM0Wfk+bcO+5OLGfoD
         BwbV9F8uoMMwTvGr+lHDPuNwE8mLsk7N6e5SF8rKSCFhhcUBstsO/GqbKNCwKsPYuM7S
         KjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=1Hl5p3wEkdMbwzkhTxxXdSHoRBVV1a00CNqhsS5oIqs=;
        b=hGEvKm2mWXQd/FaInYHgs2GvPNCFlTwzEZX99AjQr6t6fThr1rt0fK4sqB2u7CapyU
         NjvcaQ6q+RKlj/qmO7sffPkV7Li9hih2iUgXfFjDu3eDRnNLux7D29/QSdDxIqpMRFh0
         v5uzG/Y2NR4vp3X9pXA0Hh/18xQrccVg8DAUDrjjHBTwlD20SXEFg32TbvhHhSGpCkUI
         f8laI1lsCA7BkIVUATN/LhlVBB13P2G2FFKcMPdYXDMWFoJhw0GFLwVV5/I4csnOIhUC
         QXoUuCh5u3uR2jcFoZ+3s719dR3y49WCBpxGD6Ib7h0gu7kmDB+HRbBtNyDERcWeYfeh
         fTiA==
X-Gm-Message-State: APjAAAVu6CUlMT2GqUss31JDwVMVIhNpDvV+bA1y203B5hCClBaqEeNM
        PRde+/qneVFV9uPK6d/ZtxANOQ==
X-Google-Smtp-Source: APXvYqzgDXKrbj2odq6Xc2qIv6xnX/u0FdOui0nDUqY+3TF9Aapv4nUrtGFNojWbN5pFVjF9q8SYEQ==
X-Received: by 2002:a6b:630b:: with SMTP id p11mr342734iog.284.1565938891572;
        Fri, 16 Aug 2019 00:01:31 -0700 (PDT)
Received: from [172.20.10.10] ([24.114.49.8])
        by smtp.gmail.com with ESMTPSA id a6sm5013974ios.20.2019.08.16.00.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 00:01:30 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E85D2BFF-0B55-443B-A529-BA02F07DAE8B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_20A6291E-BB5F-43C5-B76B-C6CE182A1F42";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] mke2fs: set overhead in super block for bigalloc
Date:   Fri, 16 Aug 2019 01:01:31 -0600
In-Reply-To: <20190816034834.29439-2-dongyangli@ddn.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Dongyang Li <dongyangli@ddn.com>
References: <20190816034834.29439-1-dongyangli@ddn.com>
 <20190816034834.29439-2-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_20A6291E-BB5F-43C5-B76B-C6CE182A1F42
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 15, 2019, at 9:49 PM, Dongyang Li <dongyangli@ddn.com> wrote:
>=20
> If overhead is not recorded in the super block, it is caculated
> during mount in kernel, for bigalloc file systems the it takes
> O(groups**2) in time.
> For a 1PB deivce with 32K cluste size it takes ~12 mins to
> mount, with most of the time spent on figuring out overhead.
>=20
> While we can not improve the overhead algorithm in kernel
> due to the nature of bigalloc, we can work out the overhead
> during mke2fs and set it in the super block, avoiding calculating
> it every time during mounting.
>=20
> Overhead is s_first_data_block plus internal journal blocks plus
> the block and inode bitmaps, inode table, super block backups and
> group descriptor blocks for every group. With the patch we calculate
> the overhead when converting the block bitmap to cluster bitmap.
>=20
> When bad blocks are involved, it gets tricky because the blocks
> counted as overhead and the bad blocks can end up in the same
> allocation cluster. In this case we will unmark the bad blocks from
> the block bitmap, covert to cluster bitmap and get the overhead,
> then mark the bad blocks back in the cluster bitmap.
>=20
> Fix a bug in handle_bad_blocks(), don't covert the bad block to
> cluster when marking it as used, the bitmap is still a block bitmap,
> will be coverted to cluster bitmap later.
>=20
> Note: in kernel the overhead is the s_overhead_clusters field from
> struct ext4_super_block, it's named s_overhead_blocks in e2fsprogs.
>=20
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/ext2fs.h       |  4 +++
> lib/ext2fs/gen_bitmap64.c | 61 ++++++++++++++++++++++++++++++++++-----
> misc/mke2fs.c             | 15 ++++++++--
> 3 files changed, 69 insertions(+), 11 deletions(-)
>=20
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 59fd9742..a70924b3 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1437,6 +1437,10 @@ errcode_t =
ext2fs_set_generic_bmap_range(ext2fs_generic_bitmap bmap,
> 					void *in);
> errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
> 					   ext2fs_block_bitmap *bitmap);
> +errcode_t ext2fs_convert_subcluster_bitmap_overhead(ext2_filsys fs,
> +						    ext2fs_block_bitmap =
*bitmap,
> +						    badblocks_list =
bb_list,
> +						    unsigned int =
*count);
>=20
> /* get_num_dirs.c */
> extern errcode_t ext2fs_get_num_dirs(ext2_filsys fs, ext2_ino_t =
*ret_num_dirs);
> diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
> index 97601232..0f67f9c4 100644
> --- a/lib/ext2fs/gen_bitmap64.c
> +++ b/lib/ext2fs/gen_bitmap64.c
> @@ -794,18 +794,46 @@ void ext2fs_warn_bitmap32(ext2fs_generic_bitmap =
gen_bitmap, const char *func)
> #endif
> }
>=20
> -errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
> -					   ext2fs_block_bitmap *bitmap)
> +errcode_t ext2fs_convert_subcluster_bitmap_overhead(ext2_filsys fs,
> +						    ext2fs_block_bitmap =
*bitmap,
> +						    badblocks_list =
bb_list,
> +						    unsigned int *count)
> {
> 	ext2fs_generic_bitmap_64 bmap, cmap;
> 	ext2fs_block_bitmap	gen_bmap =3D *bitmap, gen_cmap;
> 	errcode_t		retval;
> -	blk64_t			i, next, b_end, c_end;
> +	blk64_t			blk, next, b_end, c_end;
> +	unsigned int		clusters =3D 0;
> +	blk_t			super_and_bgd, bblk;
> +	badblocks_iterate	bb_iter;
> +	dgrp_t			i;
> 	int			ratio;
>=20
> 	bmap =3D (ext2fs_generic_bitmap_64) gen_bmap;
> -	if (fs->cluster_ratio_bits =3D=3D =
ext2fs_get_bitmap_granularity(gen_bmap))
> +	if (fs->cluster_ratio_bits =3D=3D
> +				ext2fs_get_bitmap_granularity(gen_bmap)) =
{
> +		if (count) {
> +			for (i =3D 0; i < fs->group_desc_count; i++) {
> +				ext2fs_super_and_bgd_loc2(fs, i, NULL, =
NULL,
> +							  NULL,
> +							  =
&super_and_bgd);
> +				clusters +=3D super_and_bgd +
> +					    fs->inode_blocks_per_group + =
2;
> +			}
> +			*count =3D clusters;
> +		}
> 		return 0;	/* Nothing to do */
> +	}
> +
> +	if (bb_list) {
> +		retval =3D ext2fs_badblocks_list_iterate_begin(bb_list,
> +							     &bb_iter);
> +		if (retval)
> +			return retval;
> +		while (ext2fs_badblocks_list_iterate(bb_iter, &bblk))
> +			ext2fs_unmark_block_bitmap2(gen_bmap, bblk);
> +		bb_iter->ptr =3D 0;
> +	}
>=20
> 	retval =3D ext2fs_allocate_block_bitmap(fs, "converted cluster =
bitmap",
> 					      &gen_cmap);
> @@ -813,27 +841,44 @@ errcode_t =
ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
> 		return retval;
>=20
> 	cmap =3D (ext2fs_generic_bitmap_64) gen_cmap;
> -	i =3D bmap->start;
> +	blk =3D bmap->start;
> 	b_end =3D bmap->end;
> 	bmap->end =3D bmap->real_end;
> 	c_end =3D cmap->end;
> 	cmap->end =3D cmap->real_end;
> 	ratio =3D 1 << fs->cluster_ratio_bits;
> -	while (i < bmap->real_end) {
> +	while (blk < bmap->real_end) {
> 		retval =3D ext2fs_find_first_set_block_bitmap2(gen_bmap,
> -						i, bmap->real_end, =
&next);
> +						blk, bmap->real_end, =
&next);
> 		if (retval)
> 			break;
> 		ext2fs_mark_block_bitmap2(gen_cmap, next);
> -		i =3D bmap->start + roundup(next - bmap->start + 1, =
ratio);
> +		blk =3D bmap->start + roundup(next - bmap->start + 1, =
ratio);
> +		clusters++;
> 	}
> 	bmap->end =3D b_end;
> 	cmap->end =3D c_end;
> 	ext2fs_free_block_bitmap(gen_bmap);
> +
> +	if (bb_list) {
> +		while (ext2fs_badblocks_list_iterate(bb_iter, &bblk))
> +			ext2fs_mark_block_bitmap2(gen_cmap, bblk);
> +		ext2fs_badblocks_list_iterate_end(bb_iter);
> +	}
> +
> 	*bitmap =3D (ext2fs_block_bitmap) cmap;
> +	if (count)
> +		*count =3D clusters;
> 	return 0;
> }
>=20
> +errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
> +					   ext2fs_block_bitmap *bitmap)
> +{
> +	return ext2fs_convert_subcluster_bitmap_overhead(fs, bitmap,
> +							 NULL, NULL);
> +}
> +
> errcode_t ext2fs_find_first_zero_generic_bmap(ext2fs_generic_bitmap =
bitmap,
> 					      __u64 start, __u64 end, =
__u64 *out)
> {
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index d7cf257e..baa87b36 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -344,7 +344,7 @@ _("Warning: the backup superblock/group =
descriptors at block %u contain\n"
> 		exit(1);
> 	}
> 	while (ext2fs_badblocks_list_iterate(bb_iter, &blk))
> -		ext2fs_mark_block_bitmap2(fs->block_map, EXT2FS_B2C(fs, =
blk));
> +		ext2fs_mark_block_bitmap2(fs->block_map, blk);
> 	ext2fs_badblocks_list_iterate_end(bb_iter);
> }
>=20
> @@ -2913,6 +2913,7 @@ int main (int argc, char *argv[])
> 	ext2_filsys	fs;
> 	badblocks_list	bb_list =3D 0;
> 	unsigned int	journal_blocks =3D 0;
> +	unsigned int	overhead;
> 	unsigned int	i, checkinterval;
> 	int		max_mnt_count;
> 	int		val, hash_alg;
> @@ -3213,7 +3214,9 @@ int main (int argc, char *argv[])
> 	if (!quiet)
> 		printf("%s", _("done                            \n"));
>=20
> -	retval =3D ext2fs_convert_subcluster_bitmap(fs, &fs->block_map);
> +	retval =3D ext2fs_convert_subcluster_bitmap_overhead(fs, =
&fs->block_map,
> +							   bb_list,
> +							   &overhead);
> 	if (retval) {
> 		com_err(program_name, retval, "%s",
> 			_("\n\twhile converting subcluster bitmap"));
> @@ -3317,6 +3320,7 @@ int main (int argc, char *argv[])
> 		free(journal_device);
> 	} else if ((journal_size) ||
> 		   ext2fs_has_feature_journal(&fs_param)) {
> +		overhead +=3D EXT2FS_B2C(fs, journal_blocks);
> 		if (super_only) {
> 			printf("%s", _("Skipping journal creation in =
super-only mode\n"));
> 			fs->super->s_journal_inum =3D EXT2_JOURNAL_INO;
> @@ -3359,8 +3363,13 @@ no_journal:
> 			       fs->super->s_mmp_update_interval);
> 	}
>=20
> -	if (ext2fs_has_feature_bigalloc(&fs_param))
> +	overhead +=3D fs->super->s_first_data_block;
> +
> +	if (ext2fs_has_feature_bigalloc(&fs_param)) {
> 		fix_cluster_bg_counts(fs);
> +		if (!super_only)
> +			fs->super->s_overhead_blocks =3D overhead;
> +	}
> 	if (ext2fs_has_feature_quota(&fs_param))
> 		create_quota_inodes(fs);
>=20
> --
> 2.22.1
>=20


Cheers, Andreas






--Apple-Mail=_20A6291E-BB5F-43C5-B76B-C6CE182A1F42
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1WVMsACgkQcqXauRfM
H+DaXQ//Re8W0DVONI/cOXV6yN2vNOPyxf9HsCiWDS7AlUVktw7mdIla12+Q6J6t
I58ouYgFlvyQP+ngxpNuRBxa6Q6rnBUIS4ZQgzEt6j9KEt/1oGGB6UPPbdga1dav
2i9AxLMPccehzIdWHE7Kjr0/HKV4bRkkJSFi6fR+WN6Q4/WQVaGyjs3zo2AFokNa
KUfJyRwXeEAQWjcu4z7jgk7GXi1XD4NuvdfQKYBB6pvLIShyG/wVsqJ8XeVRHy9g
C+enecOZry5nMMZU4nvJtAwLbXUJBGEpOKfD1Q00LREVbPNItYMEK9tlGLd8Jcpo
C6skDQIL52PWzuFLhW0f+B2Cw0jvKM6ZIGteD3ulcLmwAGiNoyNl6aPghrLyykbV
gJl99OOQzcXMZS8oYvzQPBdTZO5VJIniiIqRU2oHBgwhFhj6AGZTRIXOj2be5CDx
SCONnvczi9mu3+LwzKmtgRiu11j0XlqFPMauKjPZayKXJGcvqvlX93Lh1K3lhNJq
XflUQ821wciQgzQUa6Tb98YE3h8wgq37qjHH5ebeavlfIHhhuFCx6h/p+JYmM9p3
pGYlP0RQRH5AlWy8Zq3UZ3LeJzujsy8xDO6Vl7QKGmGdup9x6v0Lgol2bJmIn4Vn
GC8rMP68yLndkP59VtX8dEAPQYRTzddxvN8G9erZEw9yYvLu75M=
=Ovrc
-----END PGP SIGNATURE-----

--Apple-Mail=_20A6291E-BB5F-43C5-B76B-C6CE182A1F42--
