Return-Path: <linux-ext4+bounces-1809-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B28F894648
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 22:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065281F219C6
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749B537F7;
	Mon,  1 Apr 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="cJ6e9l0V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81CF4CDEC
	for <linux-ext4@vger.kernel.org>; Mon,  1 Apr 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004641; cv=none; b=dXPQ4uoZL+nHGPrMWZ1x07ZY6dxPK+uucJccVNas7tjuLopA/g/aoevogwKbv10g+EEpeQyx2rqGD44LRi4yvB0N4mSh1YMaTKiire9GnMBRYi9FCGJHc7CopnB8EXWR+qEBCjnedy/H1ciasIDHWqttunLlz0yoUcLsOQNw2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004641; c=relaxed/simple;
	bh=Ympyof56IheJno0OJN8/DWfaJJxguKct+yVB0QEVRHE=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=pI9PeWkKrEwUELZYjmyGL0OTKFZfr+RYEQNkBIQkFdD6c9Mag2EDvn6HXUdn00JxDcz2HPLC+tjLS0SVbZCpOMjGpOAfqFPsoH3RKBs47L0lY3WOhF8LtXS4a9nkXX1TS5MNRXLPTsveLq0va0NPRMUB30YKTGWyzDDigDwHOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=cJ6e9l0V; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-221ce6cac3aso1084749fac.2
        for <linux-ext4@vger.kernel.org>; Mon, 01 Apr 2024 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712004637; x=1712609437; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOvmAuZzmL4lUyJ3g6NjWiuTzgby+Jca+SipFyuy3Yw=;
        b=cJ6e9l0VBDVVYFhTu9YTzI1nJDxwMvfcungozvfmlTnzsZeP8MZFEV6+JRwK2Em9b1
         rAGZ6YL92qfaRjyoWi8m7TdlfF/oO94XiJmgJ8bEnRJYaO3DaIHTSb3TqZY2ncFmCccB
         M9m/vrgb0EiAC127AiNYtARoGZbOcHp1+E+0sGidlaDGyUEBgdKQOVwxvtB0d+wbZeoW
         Ko8WSYW2AyZWXVWoY+M07K9eodOZf9k97a2H5j3NAnGWjABfE6Wb1jRi4BnU4YTbvRXw
         PtG9RJcMuIVY6npGXV8OpN+jDoQ2JiCqja0jvXsllWgVyfG03a4ylSRkOmz3pGnHkJnp
         DFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712004637; x=1712609437;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOvmAuZzmL4lUyJ3g6NjWiuTzgby+Jca+SipFyuy3Yw=;
        b=GqNMPU4YKX922Wj4YF9qwU9x4OfyFGy7NMywG4wfFJ97zJ4AX0DyF0tu/XS2BpQaHQ
         KagM8Ht/PP68FQRg4IaZH7PCjnLTHfvGSOCu67/iPDzHyGlZfBCrmT/WRjk0+0dIZNLv
         EPTNwxli7ASnQeAGXBVL68bBbukxDTVO3XI3A4gzumZ/Z97G0ksI31I5ZG/3ikVPz1bN
         JW7IzGiBftTEWRwOe1Q7VvU9foYA/mys39gByDO/HWODZtb+ZlN+Jjqv7oV0aDA2LA1m
         xccdxAtI97wVEstddgc4lECu0EECkm96mwsim9Nwr+9gD/X4L96zi/HP3jucu9fhr5ki
         7Acg==
X-Forwarded-Encrypted: i=1; AJvYcCWhdmWexc2NmeRAUjzKx1ZqT3Ypeqvs07pC26SGK9KURQyMXnxO7KW1pUCvCGhI9bznaVzIizGcYJnIgS0VCngfTuNgkYNVHTqUjg==
X-Gm-Message-State: AOJu0YzXM4+YtS6YwSDXT5RyPJb+eaGPKXejIyg81ZaBVT8/xILCmUDq
	LFnWHHVZpjMBHOkstWZqfyP8IeYZNuhv53MspnwlZ9MsIzL3bnnnCQ9Lbvi0CJVZr1hxaJg4Ihq
	K
X-Google-Smtp-Source: AGHT+IF9OPUfJixJ+BFEGJnSxJSVRb00CFh2oYZpytrkCVsRg7zbaTfOqvyNID1IkHo58sHRZXXxJg==
X-Received: by 2002:a05:6870:512:b0:22a:4b7b:6428 with SMTP id j18-20020a056870051200b0022a4b7b6428mr12422416oao.2.1712004637221;
        Mon, 01 Apr 2024 13:50:37 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id a5-20020a63e405000000b005dc36761ad1sm8290329pgi.33.2024.04.01.13.50.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2024 13:50:36 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <4CCBB8C1-30AD-411F-AED2-781677E89FB7@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F190B5BB-5339-49A2-9CF9-1365BB9E66D9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/4] e2fsck: update quota when deallocating a bad inode
Date: Mon, 1 Apr 2024 14:52:23 -0600
In-Reply-To: <20240328172940.1609-3-luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
References: <20240328172940.1609-1-luis.henriques@linux.dev>
 <20240328172940.1609-3-luis.henriques@linux.dev>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_F190B5BB-5339-49A2-9CF9-1365BB9E66D9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 28, 2024, at 11:29 AM, Luis Henriques (SUSE) =
<luis.henriques@linux.dev> wrote:
>=20
> If a bad inode is found it will be deallocated.  However, if the
> filesystem has quota enabled, the quota information isn't being =
updated
> accordingly.  This issue was detected by running fstest ext4/019.
>=20
> This patch fixes the issue by decreasing the inode count from the =
quota
> and, if blocks are also being released, also subtract them as well.

I was wondering about the safety of this patch, since "bad inode"
usually means corrupted inode with random garbage, and continuing to
process it is as likely to introduce problems as it is to fix them.

The only caller of deallocate_inode() is e2fsck_process_bad_inode()
when the file type is bad or not matching the inode content.  This
appears it would mostly affect only the inode quota, though in some
rare cases it might affect the block quota (xattr or long symlink).

Looking at the history of deallocate_inode(), it appears risky that
it processes blocks from a corrupt inode at all.  The saving grace
is that it should only "undo" the blocks marked in-use by pass1 so
that a second e2fsck run is not needed to fix up the bitmaps and
counters.  It looks like the same is true with the quota accounting,
that deallocate_inode() is only updating the in-memory inode/block
counters for the UID/GID/PRJID but not messing with any on-disk data
until on-disk quotas are updated in pass5.

It wouldn't be terrible to update the comment before deallocate_inode()
to explain this more clearly, since "This function deallocates an inode"
doesn't really give the reader much more insight than the function name
"deallocate_inode()".  Maybe something more useful like:

/*
 * This function reverts various counters and bitmaps incremented in
 * pass1 for the inode, blocks, and quotas before it was decided the
 * inode was corrupt and needed to be cleared.  This avoids the need
 * to run e2fsck a second time (or have it restart itself) to repair
 * these counters.
 *
 * It does not modify any on-disk state, so even if the inode is bad
 * it _should_ reset in-memory state to before the inode was first
 * processed.
 */

... would be helpful to readers in the future.  In either case, you
can add my:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas

>=20
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
> e2fsck/pass2.c | 33 +++++++++++++++++++++++----------
> 1 file changed, 23 insertions(+), 10 deletions(-)
>=20
> diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
> index b91628567a7f..e16b488af643 100644
> --- a/e2fsck/pass2.c
> +++ b/e2fsck/pass2.c
> @@ -1859,12 +1859,13 @@ static int deallocate_inode_block(ext2_filsys =
fs,
> static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* =
block_buf)
> {
> 	ext2_filsys fs =3D ctx->fs;
> -	struct ext2_inode	inode;
> +	struct ext2_inode_large	inode;
> 	struct problem_context	pctx;
> 	__u32			count;
> 	struct del_block	del_block;
>=20
> -	e2fsck_read_inode(ctx, ino, &inode, "deallocate_inode");
> +	e2fsck_read_inode_full(ctx, ino, EXT2_INODE(&inode),
> +			       sizeof(inode), "deallocate_inode");
> 	clear_problem_context(&pctx);
> 	pctx.ino =3D ino;
>=20
> @@ -1874,29 +1875,29 @@ static void deallocate_inode(e2fsck_t ctx, =
ext2_ino_t ino, char* block_buf)
> 	e2fsck_read_bitmaps(ctx);
> 	ext2fs_inode_alloc_stats2(fs, ino, -1, =
LINUX_S_ISDIR(inode.i_mode));
>=20
> -	if (ext2fs_file_acl_block(fs, &inode) &&
> +	if (ext2fs_file_acl_block(fs, EXT2_INODE(&inode)) &&
> 	    ext2fs_has_feature_xattr(fs->super)) {
> 		pctx.errcode =3D ext2fs_adjust_ea_refcount3(fs,
> -				ext2fs_file_acl_block(fs, &inode),
> +				ext2fs_file_acl_block(fs, =
EXT2_INODE(&inode)),
> 				block_buf, -1, &count, ino);
> 		if (pctx.errcode =3D=3D EXT2_ET_BAD_EA_BLOCK_NUM) {
> 			pctx.errcode =3D 0;
> 			count =3D 1;
> 		}
> 		if (pctx.errcode) {
> -			pctx.blk =3D ext2fs_file_acl_block(fs, &inode);
> +			pctx.blk =3D ext2fs_file_acl_block(fs, =
EXT2_INODE(&inode));
> 			fix_problem(ctx, PR_2_ADJ_EA_REFCOUNT, &pctx);
> 			ctx->flags |=3D E2F_FLAG_ABORT;
> 			return;
> 		}
> 		if (count =3D=3D 0) {
> 			ext2fs_block_alloc_stats2(fs,
> -				  ext2fs_file_acl_block(fs, &inode), =
-1);
> +				  ext2fs_file_acl_block(fs, =
EXT2_INODE(&inode)), -1);
> 		}
> -		ext2fs_file_acl_block_set(fs, &inode, 0);
> +		ext2fs_file_acl_block_set(fs, EXT2_INODE(&inode), 0);
> 	}
>=20
> -	if (!ext2fs_inode_has_valid_blocks2(fs, &inode))
> +	if (!ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(&inode)))
> 		goto clear_inode;
>=20
> 	/* Inline data inodes don't have blocks to iterate */
> @@ -1921,10 +1922,22 @@ static void deallocate_inode(e2fsck_t ctx, =
ext2_ino_t ino, char* block_buf)
> 		ctx->flags |=3D E2F_FLAG_ABORT;
> 		return;
> 	}
> +
> +	if ((ino !=3D quota_type2inum(PRJQUOTA, fs->super)) &&
> +	    (ino !=3D fs->super->s_orphan_file_inum) &&
> +	    (ino =3D=3D EXT2_ROOT_INO || ino >=3D =
EXT2_FIRST_INODE(ctx->fs->super)) &&
> +	    !(inode.i_flags & EXT4_EA_INODE_FL)) {
> +		if (del_block.num > 0)
> +			quota_data_sub(ctx->qctx, &inode, ino,
> +				       del_block.num * =
EXT2_CLUSTER_SIZE(fs->super));
> +		quota_data_inodes(ctx->qctx, (struct ext2_inode_large =
*)&inode,
> +				  ino, -1);
> +	}
> +
> clear_inode:
> 	/* Inode may have changed by block_iterate, so reread it */
> -	e2fsck_read_inode(ctx, ino, &inode, "deallocate_inode");
> -	e2fsck_clear_inode(ctx, ino, &inode, 0, "deallocate_inode");
> +	e2fsck_read_inode(ctx, ino, EXT2_INODE(&inode), =
"deallocate_inode");
> +	e2fsck_clear_inode(ctx, ino, EXT2_INODE(&inode), 0, =
"deallocate_inode");
> }
>=20
> /*


Cheers, Andreas






--Apple-Mail=_F190B5BB-5339-49A2-9CF9-1365BB9E66D9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYLHocACgkQcqXauRfM
H+Dm1g/+OfdtfqUUzpgDlAdc4OYdEXiXh1AhyNqb2favrIE6MY39XByin+PAyh7I
qLrGh1ZNffwT4lE9EVRaWjfDerFS71oHIBL2g0IkFEHoVqtpVOqtMqVPTx5yfUsc
Xk+Wu5dVR/f1UuPIvGWKywPMrYXkKWsZZ2MXmgpWKObqM6cnNlrAmLyRVYrLiCgE
W+WUtnnV1UM5z5qwNA6/uTTfWKUCRS1A9xvH2pKHzN5b3hNguO27nx+PIkFM2eBs
VTelNxd79nFJ6cp+wv+/QIQiaNrKrzk/AID39Znt9Fv91I1fPrFxMpXoDqEuxLpv
HJvDZ83nAVTr3TV52zodkMATedm/7+buPDgAhRlu4sa61jyX2y48c89EQPt63m7y
1YU41UOcDOCYNzUw30u9VpQg1VKAfSBJgDPMD/fXuDK6l8wd0c5NlxgLWJn9hfwD
qtQcVC3rCOFY++w8mmImGzhnSVV1USIWFC1EcDUS6LJVGLaphYpuwTSgqG/1B+Ux
hLAGoLwZfuuu7heCjkNwiRV9bXXtb3npEpQ70jHsYMtbf2rTnZrYUQNxoYckzrHS
20pNeIzJtBR9Dt98TVXN69TxSM7O6es5nT2umSHQUMkVzWTSNJv2OcqSGns1JqXH
pKsrQONQX4Nvk/FFt2VdUfaNewUhSrsxOX2fvibsEgimFnVzylE=
=KWun
-----END PGP SIGNATURE-----

--Apple-Mail=_F190B5BB-5339-49A2-9CF9-1365BB9E66D9--

