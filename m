Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 747239C7ED
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 05:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfHZD33 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 23:29:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37419 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfHZD33 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Aug 2019 23:29:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so9685476pgp.4
        for <linux-ext4@vger.kernel.org>; Sun, 25 Aug 2019 20:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=BOF9u2J03SL6BTYTHr4uUIF4JBfbhHoCASdGl2lTo5E=;
        b=sP1CiWd6ywtMxSDI7dEhvCv+p6YtbMPFEJq2TdQbhVGH3eX9jPFaX4jXE6lbRxC87D
         q6fLZAyBm/sGQhcPg8gT4Bl3VL0HcrvmErQ/SL2SFYt+8iDDMfcrd1VmzVsXzGJWQfRP
         RmgoCCmvW0XmqG5MdK6yh7njxV7eg97QPZUxiuf3bViCeBvfwoYOemVcPwrNMycH5OPY
         8Fs7Jg+DG5FLyjqQDhpFxS4PKtcZowVrZMQEh8BbhjVignAkMxV/ExfjJlyn2xVUN9iZ
         G+mprAtRdn9qYWazzBG99mtJDPPHrIMaaJilkiBwo9fvKL6IRafRxZiH1i56FcNuOZI6
         Qvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=BOF9u2J03SL6BTYTHr4uUIF4JBfbhHoCASdGl2lTo5E=;
        b=qFqz2F56s2WAdKusbiCxRYyqsD3QPOp5gKnAhhvp5cFzmPsElJ1meSDaVHo5Yiw4v1
         h1Lpnv3+V94oMMj2CO6b0CtGGdGlvGumPA9eRxdSLUzF23nAsPPYLNAYxFcN20EcN/h5
         17vV5Qf7g4+Yq9ho1XC2JdDCqN3YBlmOjvpeAHjmLn2RFOBCoWyQgK9iZjR4iX5b2f9s
         xvwq9YpKziYRug8A06N/5Rf2RtEVA3uTW/ETqUck5ayTIz4Ot9Ql/pMQ8MnyO0ZS5Q3G
         or8VRMynfeNIQkb56cSWyVLTiqHrRZxW2Wm0mvruhWwSTaCMB4j12y3wnP/XylhARzj+
         NA8w==
X-Gm-Message-State: APjAAAUGQE4HO/ENtAKMagrV7UBtR//vxZkLBR5eIYYZ1CJrPbWAbFhe
        gta4hh7UcbLbfaZ+5wjogB7hNawEz0YVXQ==
X-Google-Smtp-Source: APXvYqyzqUvYfddblc7pxxnbQXXJxQXSjFrQujiheopV6WjYiha4+Tz57ZXd+tsxpuWATeQ7h3ZH1g==
X-Received: by 2002:a17:90a:db0d:: with SMTP id g13mr17881266pjv.51.1566790168615;
        Sun, 25 Aug 2019 20:29:28 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id l31sm9432745pgm.63.2019.08.25.20.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 20:29:27 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F25195AC-DF10-47E0-9445-074D47DACDB4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2DCB50EC-2581-4621-A641-FC5DC62414BA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 4/4] mke2fs: set overhead in super block for bigalloc
Date:   Sun, 25 Aug 2019 21:29:26 -0600
In-Reply-To: <20190822082617.19180-4-dongyangli@ddn.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Dongyang Li <dongyangli@ddn.com>
References: <20190822082617.19180-1-dongyangli@ddn.com>
 <20190822082617.19180-4-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_2DCB50EC-2581-4621-A641-FC5DC62414BA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 22, 2019, at 2:26 AM, Dongyang Li <dongyangli@ddn.com> wrote:
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
> it every time when it mounts.

It would also be good to get an ext4 patch to save the calculated
overhead to s_overhead_clusters if the kernel finds it unset?
That isn't any less accurate than recomputing it each time, and
avoids extra overhead on each mount for filesystems that did not
get it set at mke2fs time.

> Overhead is s_first_data_block plus internal journal blocks plus
> the block and inode bitmaps, inode table, super block backups and
> group descriptor blocks for every group. This patch introduces
> ext2fs_count_used_clusters(), which calculates the clusters used
> in the block bitmap for the given range.
>=20
> When bad blocks are involved, it gets tricky because the blocks
> counted as overhead and the bad blocks can end up in the same
> allocation cluster.

On the other hand, would it be wrong if the bad blocks are stored
in "s_overhead_clusters"?

> In this case we will unmark the bad blocks from
> the block bitmap, covert to cluster bitmap and get the overhead,

(typo) "convert"

> then mark the bad blocks back in the cluster bitmap.

In this case, should the bad block numbers be converted to
clusters during the second iteration?

> Signed-off-by: Li Dongyang <dongyangli@ddn.com>
> ---
> lib/ext2fs/ext2fs.h       |  2 ++
> lib/ext2fs/gen_bitmap64.c | 35 +++++++++++++++++++++++++++
> misc/mke2fs.c             | 50 ++++++++++++++++++++++++++++++++++++++-
> 3 files changed, 86 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 59fd9742..a8ddb9e4 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1437,6 +1437,8 @@ errcode_t =
ext2fs_set_generic_bmap_range(ext2fs_generic_bitmap bmap,
> 					void *in);
> errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
> 					   ext2fs_block_bitmap *bitmap);
> +errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
> +				     blk64_t end, blk64_t *out);
>=20
> /* get_num_dirs.c */
> extern errcode_t ext2fs_get_num_dirs(ext2_filsys fs, ext2_ino_t =
*ret_num_dirs);
> diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
> index f1dd1891..b2370667 100644
> --- a/lib/ext2fs/gen_bitmap64.c
> +++ b/lib/ext2fs/gen_bitmap64.c
> @@ -940,3 +940,38 @@ errcode_t =
ext2fs_find_first_set_generic_bmap(ext2fs_generic_bitmap bitmap,
>=20
> 	return ENOENT;
> }
> +
> +errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
> +				     blk64_t end, blk64_t *out)
> +{
> +	blk64_t		next;
> +	blk64_t		tot_set =3D 0;
> +	errcode_t	retval;
> +
> +	while (start < end) {
> +		retval =3D =
ext2fs_find_first_set_block_bitmap2(fs->block_map,
> +							start, end, =
&next);
> +		if (retval) {
> +			if (retval =3D=3D ENOENT)
> +				retval =3D 0;
> +			break;
> +		}
> +		start =3D next;
> +
> +		retval =3D =
ext2fs_find_first_zero_block_bitmap2(fs->block_map,
> +							start, end, =
&next);
> +		if (retval =3D=3D 0) {
> +			tot_set +=3D next - start;
> +			start  =3D next + 1;
> +		} else if (retval =3D=3D ENOENT) {
> +			retval =3D 0;
> +			tot_set +=3D end - start + 1;
> +			break;
> +		} else
> +			break;
> +	}
> +
> +	if (!retval)
> +		*out =3D EXT2FS_NUM_B2C(fs, tot_set);
> +	return retval;
> +}
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index 30e353d3..1928c9bf 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -2912,6 +2912,8 @@ int main (int argc, char *argv[])
> 	errcode_t	retval =3D 0;
> 	ext2_filsys	fs;
> 	badblocks_list	bb_list =3D 0;
> +	badblocks_iterate	bb_iter;
> +	blk_t		blk;
> 	unsigned int	journal_blocks =3D 0;
> 	unsigned int	i, checkinterval;
> 	int		max_mnt_count;
> @@ -2922,6 +2924,7 @@ int main (int argc, char *argv[])
> 	char		opt_string[40];
> 	char		*hash_alg_str;
> 	int		itable_zeroed =3D 0;
> +	blk64_t		overhead;
>=20
> #ifdef ENABLE_NLS
> 	setlocale(LC_MESSAGES, "");
> @@ -3213,6 +3216,23 @@ int main (int argc, char *argv[])
> 	if (!quiet)
> 		printf("%s", _("done                            \n"));
>=20
> +	/*
> +	 * Unmark bad blocks to calculate overhead, because metadata
> + 	 * blocks and bad blocks can land on the same allocation =
cluster.
> + 	 */
> +	if (bb_list) {
> +		retval =3D ext2fs_badblocks_list_iterate_begin(bb_list,
> +							     &bb_iter);
> +		if (retval) {
> +			com_err("ext2fs_badblocks_list_iterate_begin", =
retval,
> +				"%s", _("while unmarking bad blocks"));
> +			exit(1);
> +		}
> +		while (ext2fs_badblocks_list_iterate(bb_iter, &blk))
> +			ext2fs_unmark_block_bitmap2(fs->block_map, blk);
> +		ext2fs_badblocks_list_iterate_end(bb_iter);
> +	}
> +
> 	retval =3D ext2fs_convert_subcluster_bitmap(fs, &fs->block_map);
> 	if (retval) {
> 		com_err(program_name, retval, "%s",
> @@ -3220,6 +3240,28 @@ int main (int argc, char *argv[])
> 		exit(1);
> 	}
>=20
> +	retval =3D ext2fs_count_used_clusters(fs, =
fs->super->s_first_data_block,
> +					ext2fs_blocks_count(fs->super) - =
1,
> +					&overhead);
> +	if (retval) {
> +		com_err(program_name, retval, "%s",
> +			_("while calculating overhead"));
> +		exit(1);
> +	}
> +
> +	if (bb_list) {
> +		retval =3D ext2fs_badblocks_list_iterate_begin(bb_list,
> +							     &bb_iter);
> +		if (retval) {
> +			com_err("ext2fs_badblocks_list_iterate_begin", =
retval,
> +				"%s", _("while marking bad blocks as =
used"));
> +			exit(1);
> +		}
> +		while (ext2fs_badblocks_list_iterate(bb_iter, &blk))
> +			ext2fs_mark_block_bitmap2(fs->block_map, blk);
> +		ext2fs_badblocks_list_iterate_end(bb_iter);
> +	}
> +
> 	if (super_only) {
> 		check_plausibility(device_name, CHECK_FS_EXIST, NULL);
> 		printf(_("%s may be further corrupted by superblock =
rewrite\n"),
> @@ -3317,6 +3359,7 @@ int main (int argc, char *argv[])
> 		free(journal_device);
> 	} else if ((journal_size) ||
> 		   ext2fs_has_feature_journal(&fs_param)) {
> +		overhead +=3D EXT2FS_NUM_B2C(fs, journal_blocks);
> 		if (super_only) {
> 			printf("%s", _("Skipping journal creation in =
super-only mode\n"));
> 			fs->super->s_journal_inum =3D EXT2_JOURNAL_INO;
> @@ -3359,8 +3402,13 @@ no_journal:
> 			       fs->super->s_mmp_update_interval);
> 	}
>=20
> -	if (ext2fs_has_feature_bigalloc(&fs_param))
> +	overhead +=3D fs->super->s_first_data_block;
> +
> +	if (ext2fs_has_feature_bigalloc(&fs_param)) {
> +		if (!super_only)
> +			fs->super->s_overhead_clusters =3D overhead;
> 		fix_cluster_bg_counts(fs);
> +	}

Should we consider to always store the overhead value into the =
superblock,
regardless of whether bigalloc is enabled or not?

Cheers, Andreas






--Apple-Mail=_2DCB50EC-2581-4621-A641-FC5DC62414BA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1jUhYACgkQcqXauRfM
H+D1IQ//ZA1mou9T2ZWYFQ1nxG1Af3/Rq7FRDsrOF9CSafxZKQOShQ6vBM+aUZDA
HFuJQea6XkZra+hPJLBY2BL7yLAcmnLzD+HwuWz9szXvyMTTwGkFNBp25zT7Um2D
3K9eyw3EUSUwORYWZOHHZ0KRlnvfzU1vhwwy0weuryOIRl3J9ZgbQwHmRlJOl5sC
LYA3mWz3V95tcZq9cYVEt1oj5N8HscnZVgZpMsZXxsg1vX40CA36yXgF01VmFEUQ
zypthCUg87qvgyuSuh8/+eXpTYaViQphS0o6TIDCEitPbnnYX6lx4+ct2J4J9Bxl
IagM8IRuaZutRLX+h399PayBkZm7YNAkdNhk20cYL5iyNQ6m/icGd7+14oszblPG
8cBsssqABKOEll+hiosrkC5Whks35lNviA+5+byf4V5i9Evr4TW/beYZLRLhsTp9
k2QWGThczT1MZIW346vXrDDvbP9CXsL6LsZm5JzhD+8YBkhwTtSnGT/aNvN+dd3d
llwgiI6Ol8bXMdkf6hs4lhII8Xr94oMKNEr6lsW8g6fojI00pwMPs/Xr1otDKxeD
IZMXtKeeuH9IDvPGcCH2trBsM3t7jAlNAy4NCCBhAlNAbNdnwysmsMp4vfD3SghY
UlJiV2v53cq2fkjpggxtKzOsKlriUPMezltNJ6R719QSXp1CUqo=
=O0jz
-----END PGP SIGNATURE-----

--Apple-Mail=_2DCB50EC-2581-4621-A641-FC5DC62414BA--
