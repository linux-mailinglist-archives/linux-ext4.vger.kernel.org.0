Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E57A5644
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 01:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjIRXnh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 19:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXnh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 19:43:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F2690
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 16:43:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5780040cb81so3902981a12.1
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 16:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695080610; x=1695685410; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKGUmdAN1T7BlXk0KPAFU/qENqr+pT/6WSkPAyX8tLM=;
        b=aQWzlMfiO0NGxmzQ8s/MjhJB48peBJq1ND//IOFYAAfjl5L3Db6R4FEZ9oUc/xwuq7
         +zPM36p4KsckSz0jxT9sXUww3T1MX+ZVeaWiEUDAWtN9wX1CbxHXiEmzb56LMZjaAalO
         E48qQFTfTOj4CMNaWJW8lGJJkg/KxZP2ICp4NcZFbXXijhfWI1TDI8KjNw4E8Ja5/GcZ
         dJMwYtt7jIFEjXogYi9vWL8YFZt8Oc4TWseclIlAobcDx7cR6TUIVIs6IU2INoFF/NWW
         RXd19kLSFqSdatjXFpliNHO3hdM/J7hF7KYt4eveclmxsDTFekyxkPdrpfPgc7YdZV5T
         V15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695080610; x=1695685410;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKGUmdAN1T7BlXk0KPAFU/qENqr+pT/6WSkPAyX8tLM=;
        b=sKr7dMk+I6wa0Ud75vRLAxWXb+8hACRezRhr6y1mkSMPQ2g3YNqnTWqu9Xqu3Em/3j
         4RFQiIEmAMloKh0bQLhtLYYg19qC54LzrC4cfuJvt9QgJEIuf3pCfjdcuXIbjaxDHKAt
         dKv6IrX6TLbxBy6tPIDPiSCodRGMsbWoE0OOEUKDb3LalTT4YfW/kjrKsMJaCxMUWkhN
         RT15u1wl8X8xDUGiVdyQJo9cz5CthOV8jhnih/J0CAdJHHGfno82FdhVZYkmSfM65W77
         c13kQOIvj6jKw2rFYg+Tmr7AO2Z+cGEIL1owqVqkNIp/f+6wnamRBXwOBIdQj/LmFjMe
         IAzQ==
X-Gm-Message-State: AOJu0Yx+CF27Q6chzWOYPJyrv/GS5m5E5qBVIuah21pIe+WYOpgoF8Xe
        7KtP+gecJvJJAS9RHsscJZFZAw==
X-Google-Smtp-Source: AGHT+IH4i6qzZ9yPmyKx3NLrZshJHrUw//V/93okB9G9B/2LEySduaMh6WOzXWsbtYPUHEilbIYheg==
X-Received: by 2002:a05:6a20:7f84:b0:154:6480:8588 with SMTP id d4-20020a056a207f8400b0015464808588mr11147359pzj.0.1695080609827;
        Mon, 18 Sep 2023 16:43:29 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u9-20020a63a909000000b0057783b0f102sm7183620pge.40.2023.09.18.16.43.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 16:43:28 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <734A1725-FA62-47F2-845E-9F49D74E7661@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6FAACE5A-50DC-42F1-AC01-D93FE2613FA6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/5] kill a ctx->journal_io
Date:   Mon, 18 Sep 2023 17:43:26 -0600
In-Reply-To: <20220804095618.887684-3-alexey.lyashkov@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
References: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
 <20220804095618.887684-3-alexey.lyashkov@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_6FAACE5A-50DC-42F1-AC01-D93FE2613FA6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 4, 2022, at 3:56 AM, Alexey Lyashkov <alexey.lyashkov@gmail.com> =
wrote:
>=20
> replace a e2fsck own code, with generic one to use
> an fs->journal_io.

Missing Signed-off-by: line, but otherwise looks fine.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>


> ---
> debugfs/journal.c      | 34 ---------------------------
> e2fsck/e2fsck.c        |  6 +----
> e2fsck/e2fsck.h        |  1 -
> e2fsck/journal.c       | 53 +++++++-----------------------------------
> lib/support/jfs_user.c | 39 +++++++++++++++++++++++++++++++
> lib/support/jfs_user.h |  2 ++
> 6 files changed, 50 insertions(+), 85 deletions(-)
>=20
> diff --git a/debugfs/journal.c b/debugfs/journal.c
> index dac17800..202312fe 100644
> --- a/debugfs/journal.c
> +++ b/debugfs/journal.c
> @@ -590,40 +590,6 @@ static errcode_t ext2fs_journal_load(journal_t =
*journal)
> 	return 0;
> }
>=20
> -static void ext2fs_journal_release(ext2_filsys fs, journal_t =
*journal,
> -				   int reset, int drop)
> -{
> -	journal_superblock_t *jsb;
> -
> -	if (drop)
> -		mark_buffer_clean(journal->j_sb_buffer);
> -	else if (fs->flags & EXT2_FLAG_RW) {
> -		jsb =3D journal->j_superblock;
> -		jsb->s_sequence =3D htonl(journal->j_tail_sequence);
> -		if (reset)
> -			jsb->s_start =3D 0; /* this marks the journal as =
empty */
> -		ext2fs_journal_sb_csum_set(journal, jsb);
> -		mark_buffer_dirty(journal->j_sb_buffer);
> -	}
> -	brelse(journal->j_sb_buffer);
> -
> -	if (fs && fs->journal_io) {
> -		if (fs->io !=3D fs->journal_io)
> -			io_channel_close(fs->journal_io);
> -		fs->journal_io =3D NULL;
> -		free(fs->journal_name);
> -		fs->journal_name =3D NULL;
> -	}
> -
> -#ifndef USE_INODE_IO
> -	if (journal->j_inode)
> -		ext2fs_free_mem(&journal->j_inode);
> -#endif
> -	if (journal->j_fs_dev)
> -		ext2fs_free_mem(&journal->j_fs_dev);
> -	ext2fs_free_mem(&journal);
> -}
> -
> /*
>  * This function makes sure that the superblock fields regarding the
>  * journal are consistent.
> diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
> index 1e295e3e..421ef4a9 100644
> --- a/e2fsck/e2fsck.c
> +++ b/e2fsck/e2fsck.c
> @@ -83,11 +83,7 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
> 		ext2fs_free_icount(ctx->inode_link_info);
> 		ctx->inode_link_info =3D 0;
> 	}
> -	if (ctx->journal_io) {
> -		if (ctx->fs && ctx->fs->io !=3D ctx->journal_io)
> -			io_channel_close(ctx->journal_io);
> -		ctx->journal_io =3D 0;
> -	}
> +
> 	if (ctx->fs && ctx->fs->dblist) {
> 		ext2fs_free_dblist(ctx->fs->dblist);
> 		ctx->fs->dblist =3D 0;
> diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
> index 2db216f5..33334781 100644
> --- a/e2fsck/e2fsck.h
> +++ b/e2fsck/e2fsck.h
> @@ -380,7 +380,6 @@ struct e2fsck_struct {
> 	/*
> 	 * ext3 journal support
> 	 */
> -	io_channel	journal_io;
> 	char	*journal_name;
>=20
> 	/*
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index 46a9bcb7..682d82a4 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -86,7 +86,7 @@ struct buffer_head *getblk(kdev_t kdev, unsigned =
long long blocknr,
> 	if (kdev->k_dev =3D=3D K_DEV_FS)
> 		bh->b_io =3D kdev->k_ctx->fs->io;
> 	else
> -		bh->b_io =3D kdev->k_ctx->journal_io;
> +		bh->b_io =3D kdev->k_ctx->fs->journal_io;
> 	bh->b_size =3D blocksize;
> 	bh->b_blocknr =3D blocknr;
>=20
> @@ -100,7 +100,7 @@ int sync_blockdev(kdev_t kdev)
> 	if (kdev->k_dev =3D=3D K_DEV_FS)
> 		io =3D kdev->k_ctx->fs->io;
> 	else
> -		io =3D kdev->k_ctx->journal_io;
> +		io =3D kdev->k_ctx->fs->journal_io;
>=20
> 	return io_channel_flush(io) ? -EIO : 0;
> }
> @@ -156,11 +156,6 @@ void mark_buffer_dirty(struct buffer_head *bh)
> 	bh->b_dirty =3D 1;
> }
>=20
> -static void mark_buffer_clean(struct buffer_head * bh)
> -{
> -	bh->b_dirty =3D 0;
> -}
> -
> void brelse(struct buffer_head *bh)
> {
> 	if (bh->b_dirty)
> @@ -1011,7 +1006,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t =
ctx, journal_t **ret_journal)
> 		io_ptr =3D inode_io_manager;
> #else
> 		journal->j_inode =3D j_inode;
> -		ctx->journal_io =3D ctx->fs->io;
> +		ctx->fs->journal_io =3D ctx->fs->io;
> 		if ((ret =3D jbd2_journal_bmap(journal, 0, &start)) !=3D =
0) {
> 			retval =3D (errcode_t) (-1 * ret);
> 			goto errout;
> @@ -1058,12 +1053,12 @@ static errcode_t e2fsck_get_journal(e2fsck_t =
ctx, journal_t **ret_journal)
>=20
>=20
> 		retval =3D io_ptr->open(journal_name, flags,
> -				      &ctx->journal_io);
> +				      &ctx->fs->journal_io);
> 	}
> 	if (retval)
> 		goto errout;
>=20
> -	io_channel_set_blksize(ctx->journal_io, ctx->fs->blocksize);
> +	io_channel_set_blksize(ctx->fs->journal_io, ctx->fs->blocksize);
>=20
> 	if (ext_journal) {
> 		blk64_t maxlen;
> @@ -1397,38 +1392,6 @@ static errcode_t =
e2fsck_journal_fix_corrupt_super(e2fsck_t ctx,
> 	return 0;
> }
>=20
> -static void e2fsck_journal_release(e2fsck_t ctx, journal_t *journal,
> -				   int reset, int drop)
> -{
> -	journal_superblock_t *jsb;
> -
> -	if (drop)
> -		mark_buffer_clean(journal->j_sb_buffer);
> -	else if (!(ctx->options & E2F_OPT_READONLY)) {
> -		jsb =3D journal->j_superblock;
> -		jsb->s_sequence =3D htonl(journal->j_tail_sequence);
> -		if (reset)
> -			jsb->s_start =3D 0; /* this marks the journal as =
empty */
> -		ext2fs_journal_sb_csum_set(journal, jsb);
> -		mark_buffer_dirty(journal->j_sb_buffer);
> -	}
> -	brelse(journal->j_sb_buffer);
> -
> -	if (ctx->journal_io) {
> -		if (ctx->fs && ctx->fs->io !=3D ctx->journal_io)
> -			io_channel_close(ctx->journal_io);
> -		ctx->journal_io =3D 0;
> -	}
> -
> -#ifndef USE_INODE_IO
> -	if (journal->j_inode)
> -		ext2fs_free_mem(&journal->j_inode);
> -#endif
> -	if (journal->j_fs_dev)
> -		ext2fs_free_mem(&journal->j_fs_dev);
> -	ext2fs_free_mem(&journal);
> -}
> -
> /*
>  * This function makes sure that the superblock fields regarding the
>  * journal are consistent.
> @@ -1475,7 +1438,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t =
ctx)
> 		    (!fix_problem(ctx, PR_0_JOURNAL_UNSUPP_VERSION, =
&pctx))))
> 			retval =3D e2fsck_journal_fix_corrupt_super(ctx, =
journal,
> 								  =
&pctx);
> -		e2fsck_journal_release(ctx, journal, 0, 1);
> +		ext2fs_journal_release(ctx->fs, journal, 0, 1);
> 		return retval;
> 	}
>=20
> @@ -1556,7 +1519,7 @@ no_has_journal:
> 		mark_buffer_dirty(journal->j_sb_buffer);
> 	}
>=20
> -	e2fsck_journal_release(ctx, journal, reset, 0);
> +	ext2fs_journal_release(ctx->fs, journal, reset, 0);
> 	return retval;
> }
>=20
> @@ -1605,7 +1568,7 @@ errout:
> 	jbd2_journal_destroy_revoke(journal);
> 	jbd2_journal_destroy_revoke_record_cache();
> 	jbd2_journal_destroy_revoke_table_cache();
> -	e2fsck_journal_release(ctx, journal, 1, 0);
> +	ext2fs_journal_release(ctx->fs, journal, 1, 0);
> 	return retval;
> }
>=20
> diff --git a/lib/support/jfs_user.c b/lib/support/jfs_user.c
> index 4ff1b5c1..d8a2f842 100644
> --- a/lib/support/jfs_user.c
> +++ b/lib/support/jfs_user.c
> @@ -60,3 +60,42 @@ errcode_t ext2fs_journal_sb_csum_set(journal_t *j,
> 	return 0;
> }
>=20
> +
> +static void mark_buffer_clean(struct buffer_head * bh)
> +{
> +	bh->b_dirty =3D 0;
> +}
> +
> +void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
> +			    int reset, int drop)
> +{
> +	journal_superblock_t *jsb;
> +
> +	if (drop)
> +		mark_buffer_clean(journal->j_sb_buffer);
> +	else if (fs->flags & EXT2_FLAG_RW) {
> +		jsb =3D journal->j_superblock;
> +		jsb->s_sequence =3D htonl(journal->j_tail_sequence);
> +		if (reset)
> +			jsb->s_start =3D 0; /* this marks the journal as =
empty */
> +		ext2fs_journal_sb_csum_set(journal, jsb);
> +		mark_buffer_dirty(journal->j_sb_buffer);
> +	}
> +	brelse(journal->j_sb_buffer);
> +
> +	if (fs && fs->journal_io) {
> +		if (fs->io !=3D fs->journal_io)
> +			io_channel_close(fs->journal_io);
> +		fs->journal_io =3D NULL;
> +		free(fs->journal_name);
> +		fs->journal_name =3D NULL;
> +	}
> +
> +#ifndef USE_INODE_IO
> +	if (journal->j_inode)
> +		ext2fs_free_mem(&journal->j_inode);
> +#endif
> +	if (journal->j_fs_dev)
> +		ext2fs_free_mem(&journal->j_fs_dev);
> +	ext2fs_free_mem(&journal);
> +}
> diff --git a/lib/support/jfs_user.h b/lib/support/jfs_user.h
> index 8bdbf85b..b9c2fa54 100644
> --- a/lib/support/jfs_user.h
> +++ b/lib/support/jfs_user.h
> @@ -217,6 +217,8 @@ int ext2fs_journal_verify_csum_type(journal_t *j, =
journal_superblock_t *jsb);
> __u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb);
> int ext2fs_journal_sb_csum_verify(journal_t *j, journal_superblock_t =
*jsb);
> errcode_t ext2fs_journal_sb_csum_set(journal_t *j, =
journal_superblock_t *jsb);
> +void ext2fs_journal_release(ext2_filsys fs, journal_t *journal, int =
reset,
> +			    int drop);
>=20
> /*
>  * Kernel compatibility functions are defined in journal.c
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_6FAACE5A-50DC-42F1-AC01-D93FE2613FA6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUI4J4ACgkQcqXauRfM
H+AO8w/+IfEfQsOy7dhU2JeV6o8Kkpv8IS3WHxB+HuBgnKasXVvl/wxhcHQtslxT
zZtl2K+v6RPYwUNbjd0Ccld05E/aly1/yzPcba2UqGm55jSDRgJiULUKF7lkiT2l
ioTDAvCE7XkUBjC6NnaRcmv9Zw45iShJeXag337QN7xMHRewhSo9Wsp6LMn2I/K4
AYPRrCxswrOySdXCJkLd7SvjDUDoKxcLw3Fetj9ZI5QAYiOu55SaBpGw+mTDWFb+
BAg1r2kX1fmMhlyt8NAXHTT6k0mQEhX5DCZ8624IseEvYnvd1w0F01C/O0m1mwbN
i2HynhoCWvrqEOfK0vCNmAgQr53OmWdpfFr9hjl+EcOjQqghHAWQglgkdTh2oq+4
1YsH9LLCKswq8EbihwxEMGfO1je8RopVru5tB7fMQtgCMKyX6FLFhdnYQwnezaFh
g0IQjM9xVkP6/Ooub1kf2/NiCRotBUreb7E4cfa4dXj8DzOQ3/X8p/Ml4fPgRLeh
FQ8zhNUB2wb/RqHfuwStHZgrrQpDs9acOgcoPUFxkwoieRGHqFn6H9+1nccdPLLs
ih/K8TSZmP8w5RcytL0OYKSCJSt1bwgSL1K62tzKvaYDzUhS/LXcqDo0M37OK6/R
oTMznDkhLnebXigQjZVsyLAQExi4zr4uhuwXoUUSAUk2UHgdd3w=
=tBYJ
-----END PGP SIGNATURE-----

--Apple-Mail=_6FAACE5A-50DC-42F1-AC01-D93FE2613FA6--
