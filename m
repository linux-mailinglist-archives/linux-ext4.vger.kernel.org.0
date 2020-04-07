Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB351A121D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgDGQv6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Apr 2020 12:51:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34130 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgDGQv5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Apr 2020 12:51:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id l14so2013391pgb.1
        for <linux-ext4@vger.kernel.org>; Tue, 07 Apr 2020 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ksBgA/y7WIpU+/tRiyx2EOTsj9BCGBDEJNB7KKcI7Y8=;
        b=LOzc/ElSpF5e8MnWpNr1m8qcnHE24b1Wvrs25qzSZ4a6RBclLjoDTnJx3NBx5+cvet
         3AJ8rYFPGTofXERiQW6xuzmAm+2bsbBhTC4Ykcb+eRkwjl53GoHtmC4myl/ann6yFfM9
         QC7R6wqkVwFipLRBOnZSPiUcEgsazBWFXsLLv0jlmh+CcCKk+LLrI/lykALvs0G9So13
         JzzsctQoFOG2CmYkel0s3YieBYv1vUHw1DZiWIZ+BqtypNFPQhYvN9yLhyOXXU8p8UGG
         Uew7i+3B43faPfCbaEGH/Ep3+qAw4w2M0WNYoVMf0FKkKhEscSnB9QYYNuAuuU5QeFZh
         7Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ksBgA/y7WIpU+/tRiyx2EOTsj9BCGBDEJNB7KKcI7Y8=;
        b=HZRL+mE/bBvSPLMGLB1VR8x5f5Drm6T0FLJjO32saNx+QKCIZGmSfjgsnDXR60QUQY
         xEiPhY1JxSy+inhBpxbhmRB9Xc2Hnfhy5ZVZ61gPCZrii5PjsD37+Ar4zYxljjNTJo0o
         kspmZuALk3Ubjznb+Hyhy7OgOhVq7ImUpyhAuSNuhY3bz5ZqlbrBNz6MyiKmuUkWfeem
         oeQ+4aHZNPySqmI9/gGIAVJ4VDznbBGVszI+RSXLFjRGoL+MlWGVvNqkm27qw3pDjJbC
         Y3PYo7mbTLq1/0lhDbgvHfZxu2s1n+atEtjy6yLODpE//jPS9Rgte7c+pGdTaFdbbdTt
         B85A==
X-Gm-Message-State: AGi0PuYmcQehdbtBYTHwFkMLRhuGS9mf53djb/hUlyNp0L9T9Rk2ArfM
        aTCoFDLN2bb1cjiz0keSPVt6ZA==
X-Google-Smtp-Source: APiQypJwBzyeXm1NFLRH4VSUxFVi3qS6T2nuoz3AL7iLsFOsQFOSzZ1wPhXa1ADBcjL2Eb49uMnXVQ==
X-Received: by 2002:a62:7d4e:: with SMTP id y75mr3415325pfc.32.1586278316821;
        Tue, 07 Apr 2020 09:51:56 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id w8sm183182pfi.103.2020.04.07.09.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 09:51:55 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <930A5754-5CE6-4567-8CF0-62447C97825C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CFA4496A-819A-4469-8EBC-4B9F93C19A82";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 2/3] ext4: shrink directories on dentry delete
Date:   Tue, 7 Apr 2020 10:51:52 -0600
In-Reply-To: <20200407064616.221459-2-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20200407064616.221459-1-harshadshirwadkar@gmail.com>
 <20200407064616.221459-2-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_CFA4496A-819A-4469-8EBC-4B9F93C19A82
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 7, 2020, at 12:46 AM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch adds shrinking support for htree based directories. The
> high level algorithm is as follows:
>=20
> * If after dentry removal the dirent block (let's call it B) becomes
>  empty, then remove its references in its dx parent.
> * Swap its contents with that of the last block (L) in directory.
> * Update L's parents to point to B instead.
> * Remove L
> * Repeat this for all the ancestors of B.
>=20
> We add variants of dx_probe that allow us perform reverse lookups from
> a logical block to its dx parents.
>=20
> Ran kvm-xfstests smoke and verified that no new failures are
> introduced. Ran shrinking for directories with following number of
> files and then deleted files one by one:
> * 1000 (size before deletion 36K, after deletion 4K)
> * 10000 (size before deletion 196K, after deletion 4K)
> * 100000 (size before deletion 2.1M, after deletion 4K)
> * 200000 (size before deletion 4.2M, after deletion 4K)
>=20
> In all cases directory shrunk significantly. We fallback to linear
> directories if the directory becomes empty.
>=20
> But note that most of the shrinking happens during last 1-2% deletions
> in an average case. Therefore, the next step here is to merge dx nodes
> when possible. That can be achieved by storing the fullness index in
> htree nodes.
>=20
> Performance Testing:
> -------------------
>=20
> Created 1 million files and unlinked all of them. Did this with and =
without
> directory shrinking. Journalling was on. Used ftrace to measure time
> spent in ext4_unlink:
>=20
> * Without directory shrinking
>=20
>  Size Before: 22M     /mnt/1
>  1000000 files created and deleted.
>  Average Total Elapsed Time (across 3 runs): 43.787s
>  Size After: 22M     /mnt/1
>=20
>  useconds          #count
>  ------------------------
>  0-9                3690
>  10-19           2790131
>  20-29            179209
>  30-39             14270
>  40-49              7981
>  50-59              2212
>  60-69              1132
>  70-79               703
>  80-89               403
>  90-99               274
>=20
>  Num samples > 40us: 12615
>=20
> * With directory shrinking
>=20
>  Size Before: 22M     /mnt/1
>  1000000 files created and deleted.
>  Average Total Elapsed Time(across 3 runs): 44.230s
>  Size After: 4.0K    /mnt/1
>=20
>  useconds         #count
>  -----------------------
>  0-9                3316
>  10-19           2786451
>  20-29            172015
>  30-39             13259
>  40-49             17847
>  50-59              4843
>  60-69               924
>  70-79               569
>  80-89               390
>  90-99               389
>=20
>  Num samples > 40us: 24962
>=20
>  We see doubled number of samples of >40us in case of directory =
shrinking.
>  Because these constitute to < 1% of total samples, the overall effect =
of
>  direcotry shrinking on unlink / rmdir performance is negligible. =
There
>  was no notable difference in cpu usage.
>=20
> This patch supersedes the other directory shrinking patch sent in Aug
> 2019 ("ext4: attempt to shrink directory on dentry removal").
>=20
> Changes since V1:
>  * ext4_remove_dx_entry(), dx_probe_dx_node() fixes
>  * dx_probe_dirent_blk() continuation fix
>  * Added performance evaluation
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Some *very* minor cleanups *iff* the patch is refreshed, but otherwise =
LGTM.
Thanks also for the good performance numbers, that makes it pretty clear
there is very little downside to enabling this all the time.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h      |   3 +-
> fs/ext4/ext4_jbd2.h |   7 +
> fs/ext4/inline.c    |   2 +-
> fs/ext4/namei.c     | 357 ++++++++++++++++++++++++++++++++++++++++++--
> 4 files changed, 356 insertions(+), 13 deletions(-)
>=20
> @@ -820,7 +826,9 @@ dx_probe(struct ext4_filename *fname, struct inode =
*dir,
> 	dxtrace(printk("Look up %x", hash));
> 	while (1) {
> 		count =3D dx_get_count(entries);
> -		if (!count || count > dx_get_limit(entries)) {
> +		/* If we are called from the shrink path */
> +		if (count > dx_get_limit(entries) ||
> +		    (strict && !count)) {

(minor) I was wondering if (strict && !count) should be kept first, =
since it
is a simpler check, but then realized this whole check should be marked
unlikely(), since it should never happen unless the filesystem is =
corrupted.

> + * This function tries to remove the entry of a dirent block (which =
was just
> + * emptied by the caller) from the dx frame. It does so by reducing =
the count by

(very minor) could move "by" to next line to balance line length... :-)

> + * 1 and left shifting all the entries after the deleted entry.
> + * ext4_remove_dx_entry() does NOT mark dx_frame dirty, that's left =
to the
> + * caller. The reason for doing this is that this function removes =
entry from
> + * a dx_node and can potentially leave dx_node with no entries. Since =
older
> + * kernels don't allow dx_parent nodes to have 0 count, the caller =
should
> + * only mark buffer dirty when we are sure that we won't leave =
dx_node
> + * with 0 count.
> + */
> +int
> +ext4_remove_dx_entry(handle_t *handle, struct inode *dir,

(style) normally the return type is on the same line as the function
declaration, unless (like dx_probe()) it is so long as to consume a
lot of space.  That isn't the case here.

> +/*
> + * Checks if dirent block is empty. If de is passed, we
> + * skip directory entries before de in the block.
> + */
> +static inline bool is_empty_dirent_block(struct inode *dir,
> +					struct buffer_head *bh,
> +					 struct ext4_dir_entry_2 *de)
> +{
> +	if (!de)
> +		de =3D (struct ext4_dir_entry_2 *)bh->b_data;
> +	while ((u8 *)de < (u8 *)bh->b_data + dir->i_sb->s_blocksize) {
> +		if (de->inode)
> +			return false;
> +		de =3D ext4_next_entry(de, dir->i_sb->s_blocksize);
> +	}
> +	return true;
> +}
> +
> @@ -2486,6 +2643,9 @@ int ext4_generic_delete_entry(handle_t *handle,
> 					blocksize);
> 			else
> 				de->inode =3D 0;
> +			if (empty)
> +				*empty =3D is_empty_dirent_block(dir, =
bh,
> +								pde ? =
pde : de);

Nice.  I was going to say that this shouldn't re-check the whole block,
but it doesn't do that.  is_empty_dirent_block() only checks entries =
after
the removed entry, exits early if any non-empty dirent is found, and =
only
checks if we care whether the block is empty or not, and which is ideal.

Cheers, Andreas






--Apple-Mail=_CFA4496A-819A-4469-8EBC-4B9F93C19A82
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6Mr6kACgkQcqXauRfM
H+AD+w/+OU2KUkXqoDkAnzk448pnTN0BykJe+zGVbl68uXvoi0p4SGhar4gydo6z
xFOP1VGDz3KuzjuobqJJsYYW8JB8B2sWHfk19j5LtgkCJ1as9yehTroIDzkoNql+
Cc2C9M51Ov3nkfl0YihSIvGTvLocF6Q0AfbYD2jH6S1Cksck8GXtktULSjQPjQDb
andMYhSwKEXHYgBQC77lWC82dxCSRHcrZV486nHpUd90aSD7YrqjdpS45pJURRra
gQFMioynLPcbuPdinZl7uoPatQwSF6yfAn/aAQbtct+7XIPW86RgtDg7boG8kkTc
ILFROCeaWMzqgoXkraqwrag0ebhospLHIkbQk/VNCpjjSwKXHilqbV/m/kIVt0RM
BPL9hGYY2bmpFECmmMC4e6P6CgHT+pg/QhwAhEyqGVagkY610lrR3z53AbmavbY+
4HPY9kacyvPeVRnGtFq3/EAywd8PB4vo3jVAGXibv5IoOFyVIceeaazZgviY8m5l
FqyF4L7PAcKJ4AluNl9bYEzN5UNtPLro2lQnQ7BmmMP12auzyK28gugL3Q/UCcn3
NOEK10KcrOEFCuhmBz032T+qGInzx5ryL8yTh3+G+FQJKuGj27nLLCCBMGYTPgVQ
XaQmELzRJTJukbtI4xTdnj3vN2w263TTy2qWHzZoQbF1zT3l2IM=
=qxT+
-----END PGP SIGNATURE-----

--Apple-Mail=_CFA4496A-819A-4469-8EBC-4B9F93C19A82--
