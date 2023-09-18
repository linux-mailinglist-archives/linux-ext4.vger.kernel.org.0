Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA8B7A565E
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 01:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjIRX5l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 19:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRX5k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 19:57:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDA790
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 16:57:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf7423ef3eso37373125ad.3
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695081453; x=1695686253; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKyvWeAGBNEAsKYPRAnIl/zCvGu6OrX5fCeRzWVzEDI=;
        b=vjx9mEFn02LyFvypnfbVHXfLjhpMTKPOW4qp/dQRIIrptvZ/ATaBgqzmOWmAVTQuCH
         QeCun4CCFaw+Kq1UCu4hkKHg1SQmvi6Gmv7VqQXQqyBmQ5qD8IlcT/fGBXNqCiDsb3I3
         2ay+mjx739nsKxJssQzPRKLfuOqY6FLR7n0WNyKsyLk0ueZywIqBwHdV/RdwCyL5lXix
         8RQpLnHcvgMYxCXpn3WtVQYaVbGnLbedNhDNfWjuWCc2Z1PzvohBW9Lob/GFEf58Xybf
         AZiQUB9JdCg2DPpcThTwjbg7u3QyBIZeMjMqkTj6kfAvDjc1rphhwyEnHdErgpQDNUpG
         dSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695081453; x=1695686253;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKyvWeAGBNEAsKYPRAnIl/zCvGu6OrX5fCeRzWVzEDI=;
        b=LmF8p2xMLA3oGtIar7tZOXGn1YTiaCMx/I3Z+MtIHdXKo8pj0psno2sZxq9ktk5Mcf
         LMifkZ+sO0Cckvnw6LUf2ozquAaYVv4XfxDqoZOOMu7XPSKCNJvYoEWdQeGf75EBU8CN
         qNxtw3F50i3DXhGDiSQ5AzfOzdKX9sxXFUDf/defVZfh3h0GEBH6QLvfqPqGAoOaPxxj
         8MrYxaarDWITfpePYgGQv+2C7t5Mne9wRE3lpn2xw9P/Ksu7v74AWqUBWMIbefqb4zA5
         4lN0kutiUxsvVQwoykYr7w3sUTh3GoUQQfvnkaz+YmDLSm5ksCoP9J5y7WsmpOnUj34D
         7J1Q==
X-Gm-Message-State: AOJu0YywAIxUBBpyCgFcg2hp0rhMDSgAPpW32EQ76iPjXLiDMQOcDv95
        /8xZY+hcILkHqeeFRTYWUB5Fqw==
X-Google-Smtp-Source: AGHT+IHieB37CK5R1UEUkc+CzwKtRIV09auUrusIMwgbNxoMQtNHRh7NTHT+6nU7Ki/C3ZwyBQK//A==
X-Received: by 2002:a17:902:e551:b0:1c3:2c2f:1132 with SMTP id n17-20020a170902e55100b001c32c2f1132mr10618275plf.54.1695081452869;
        Mon, 18 Sep 2023 16:57:32 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b001bdbe6c86a9sm8775924pls.225.2023.09.18.16.57.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 16:57:32 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <DF14E0DC-0B1B-47F6-841B-A17CCB141878@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_47ED6092-775A-45E5-B842-2349FA65544B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/5] remove an e2fsck context from bh emulation code.
Date:   Mon, 18 Sep 2023 17:57:30 -0600
In-Reply-To: <20220804095618.887684-4-alexey.lyashkov@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
References: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
 <20220804095618.887684-4-alexey.lyashkov@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_47ED6092-775A-45E5-B842-2349FA65544B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 4, 2022, at 3:56 AM, Alexey Lyashkov <alexey.lyashkov@gmail.com> =
wrote:
>=20
> In order to generalize a journal handing, remove a e2fsck context
> from generic structures like buffer_head, and device.
> But fast commit code want a e2fsck context as well, so move it pointer
> to journal struct.

Missing Signed-off-by: line.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> e2fsck/journal.c        | 46 ++++++++++++++++++++---------------------
> lib/ext2fs/jfs_compat.h |  2 ++
> lib/support/jfs_user.h  | 12 -----------
> 3 files changed, 25 insertions(+), 35 deletions(-)
>=20
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index 682d82a4..728f5a24 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -58,7 +58,7 @@ int jbd2_journal_bmap(journal_t *journal, unsigned =
long block,
> 		return 0;
> 	}
>=20
> -	retval=3D ext2fs_bmap2(inode->i_ctx->fs, inode->i_ino,
> +	retval=3D ext2fs_bmap2(inode->i_fs, inode->i_ino,
> 			     &inode->i_ext2, NULL, 0, (blk64_t) block,
> 			     0, &pblk);
> 	*phys =3D pblk;
> @@ -70,11 +70,12 @@ struct buffer_head *getblk(kdev_t kdev, unsigned =
long long blocknr,
> 			   int blocksize)
> {
> 	struct buffer_head *bh;
> -	int bufsize =3D sizeof(*bh) + kdev->k_ctx->fs->blocksize -
> +	int bufsize =3D sizeof(*bh) + kdev->k_fs->blocksize -
> 		sizeof(bh->b_data);
> +	errcode_t retval;
>=20
> -	bh =3D e2fsck_allocate_memory(kdev->k_ctx, bufsize, "block =
buffer");
> -	if (!bh)
> +	retval =3D ext2fs_get_memzero(bufsize, &bh);
> +	if (retval)
> 		return NULL;
>=20
> 	if (journal_enable_debug >=3D 3)
> @@ -82,11 +83,11 @@ struct buffer_head *getblk(kdev_t kdev, unsigned =
long long blocknr,
> 	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
> 		  blocknr, blocksize, bh_count);
>=20
> -	bh->b_ctx =3D kdev->k_ctx;
> +	bh->b_fs =3D kdev->k_fs;
> 	if (kdev->k_dev =3D=3D K_DEV_FS)
> -		bh->b_io =3D kdev->k_ctx->fs->io;
> +		bh->b_io =3D kdev->k_fs->io;
> 	else
> -		bh->b_io =3D kdev->k_ctx->fs->journal_io;
> +		bh->b_io =3D kdev->k_fs->journal_io;
> 	bh->b_size =3D blocksize;
> 	bh->b_blocknr =3D blocknr;
>=20
> @@ -98,9 +99,9 @@ int sync_blockdev(kdev_t kdev)
> 	io_channel	io;
>=20
> 	if (kdev->k_dev =3D=3D K_DEV_FS)
> -		io =3D kdev->k_ctx->fs->io;
> +		io =3D kdev->k_fs->io;
> 	else
> -		io =3D kdev->k_ctx->fs->journal_io;
> +		io =3D kdev->k_fs->journal_io;
>=20
> 	return io_channel_flush(io) ? -EIO : 0;
> }
> @@ -120,7 +121,7 @@ void ll_rw_block(int rw, int op_flags =
EXT2FS_ATTR((unused)), int nr,
> 						     bh->b_blocknr,
> 						     1, bh->b_data);
> 			if (retval) {
> -				com_err(bh->b_ctx->device_name, retval,
> +				com_err(bh->b_fs->device_name, retval,
> 					"while reading block %llu\n",
> 					bh->b_blocknr);
> 				bh->b_err =3D (int) retval;
> @@ -135,7 +136,7 @@ void ll_rw_block(int rw, int op_flags =
EXT2FS_ATTR((unused)), int nr,
> 						      bh->b_blocknr,
> 						      1, bh->b_data);
> 			if (retval) {
> -				com_err(bh->b_ctx->device_name, retval,
> +				com_err(bh->b_fs->device_name, retval,
> 					"while writing block %llu\n",
> 					bh->b_blocknr);
> 				bh->b_err =3D (int) retval;
> @@ -223,7 +224,7 @@ static int process_journal_block(ext2_filsys fs,
> static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
> 				int off, tid_t expected_tid)
> {
> -	e2fsck_t ctx =3D j->j_fs_dev->k_ctx;
> +	e2fsck_t ctx =3D j->j_ctx;
> 	struct e2fsck_fc_replay_state *state;
> 	int ret =3D JBD2_FC_REPLAY_CONTINUE;
> 	struct ext4_fc_add_range ext;
> @@ -796,7 +797,7 @@ static int ext4_fc_handle_del_range(e2fsck_t ctx, =
__u8 *val)
> static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
> 				enum passtype pass, int off, tid_t =
expected_tid)
> {
> -	e2fsck_t ctx =3D journal->j_fs_dev->k_ctx;
> +	e2fsck_t ctx =3D journal->j_ctx;
> 	struct e2fsck_fc_replay_state *state =3D &ctx->fc_replay_state;
> 	int ret =3D JBD2_FC_REPLAY_CONTINUE;
> 	struct ext4_fc_tl tl;
> @@ -924,10 +925,11 @@ static errcode_t e2fsck_get_journal(e2fsck_t =
ctx, journal_t **ret_journal)
> 	}
> 	dev_journal =3D dev_fs+1;
>=20
> -	dev_fs->k_ctx =3D dev_journal->k_ctx =3D ctx;
> +	dev_fs->k_fs =3D dev_journal->k_fs =3D ctx->fs;
> 	dev_fs->k_dev =3D K_DEV_FS;
> 	dev_journal->k_dev =3D K_DEV_JOURNAL;
>=20
> +	journal->j_ctx =3D ctx;
> 	journal->j_dev =3D dev_journal;
> 	journal->j_fs_dev =3D dev_fs;
> 	journal->j_inode =3D NULL;
> @@ -945,7 +947,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, =
journal_t **ret_journal)
> 			goto errout;
> 		}
>=20
> -		j_inode->i_ctx =3D ctx;
> +		j_inode->i_fs =3D ctx->fs;
> 		j_inode->i_ino =3D sb->s_journal_inum;
>=20
> 		if ((retval =3D ext2fs_read_inode(ctx->fs,
> @@ -1186,9 +1188,8 @@ static errcode_t =
e2fsck_journal_fix_bad_inode(e2fsck_t ctx,
> }
>=20
> #define V1_SB_SIZE	0x0024
> -static void clear_v2_journal_fields(journal_t *journal)
> +static void clear_v2_journal_fields(e2fsck_t ctx, journal_t *journal)
> {
> -	e2fsck_t ctx =3D journal->j_dev->k_ctx;
> 	struct problem_context pctx;
>=20
> 	clear_problem_context(&pctx);
> @@ -1203,9 +1204,8 @@ static void clear_v2_journal_fields(journal_t =
*journal)
> }
>=20
>=20
> -static errcode_t e2fsck_journal_load(journal_t *journal)
> +static errcode_t e2fsck_journal_load(e2fsck_t ctx, journal_t =
*journal)
> {
> -	e2fsck_t ctx =3D journal->j_dev->k_ctx;
> 	journal_superblock_t *jsb;
> 	struct buffer_head *jbh =3D journal->j_sb_buffer;
> 	struct problem_context pctx;
> @@ -1231,14 +1231,14 @@ static errcode_t e2fsck_journal_load(journal_t =
*journal)
> 		    jsb->s_feature_incompat ||
> 		    jsb->s_feature_ro_compat ||
> 		    jsb->s_nr_users)
> -			clear_v2_journal_fields(journal);
> +			clear_v2_journal_fields(ctx, journal);
> 		break;
>=20
> 	case JBD2_SUPERBLOCK_V2:
> 		journal->j_format_version =3D 2;
> 		if (ntohl(jsb->s_nr_users) > 1 &&
> 		    uuid_is_null(ctx->fs->super->s_journal_uuid))
> -			clear_v2_journal_fields(journal);
> +			clear_v2_journal_fields(ctx, journal);
> 		if (ntohl(jsb->s_nr_users) > 1) {
> 			fix_problem(ctx, PR_0_JOURNAL_UNSUPP_MULTIFS, =
&pctx);
> 			return EXT2_ET_JOURNAL_UNSUPP_VERSION;
> @@ -1425,7 +1425,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t =
ctx)
> 		return retval;
> 	}
>=20
> -	retval =3D e2fsck_journal_load(journal);
> +	retval =3D e2fsck_journal_load(ctx, journal);
> 	if (retval) {
> 		if ((retval =3D=3D EXT2_ET_CORRUPT_JOURNAL_SB) ||
> 		    ((retval =3D=3D EXT2_ET_UNSUPP_FEATURE) &&
> @@ -1543,7 +1543,7 @@ static errcode_t recover_ext3_journal(e2fsck_t =
ctx)
> 	if (retval)
> 		return retval;
>=20
> -	retval =3D e2fsck_journal_load(journal);
> +	retval =3D e2fsck_journal_load(ctx, journal);
> 	if (retval)
> 		goto errout;
>=20
> diff --git a/lib/ext2fs/jfs_compat.h b/lib/ext2fs/jfs_compat.h
> index e11cf494..bfafae12 100644
> --- a/lib/ext2fs/jfs_compat.h
> +++ b/lib/ext2fs/jfs_compat.h
> @@ -41,6 +41,7 @@ typedef struct kdev_s *kdev_t;
>=20
> struct buffer_head;
> struct inode;
> +struct e2fsck_struct;
>=20
> typedef unsigned int gfp_t;
> #define GFP_KERNEL	0
> @@ -98,6 +99,7 @@ struct journal_s
> 	struct jbd2_revoke_table_s *j_revoke_table[2];
> 	tid_t			j_failed_commit;
> 	__u32			j_csum_seed;
> +	struct e2fsck_struct *	j_ctx;
> 	int (*j_fc_replay_callback)(struct journal_s *journal,
> 				    struct buffer_head *bh,
> 				    enum passtype pass, int off,
> diff --git a/lib/support/jfs_user.h b/lib/support/jfs_user.h
> index b9c2fa54..bb392811 100644
> --- a/lib/support/jfs_user.h
> +++ b/lib/support/jfs_user.h
> @@ -40,11 +40,7 @@
> #endif
>=20
> struct buffer_head {
> -#ifdef DEBUGFS
> 	ext2_filsys	b_fs;
> -#else
> -	e2fsck_t	b_ctx;
> -#endif
> 	io_channel	b_io;
> 	int		b_size;
> 	int		b_err;
> @@ -55,21 +51,13 @@ struct buffer_head {
> };
>=20
> struct inode {
> -#ifdef DEBUGFS
> 	ext2_filsys	i_fs;
> -#else
> -	e2fsck_t	i_ctx;
> -#endif
> 	ext2_ino_t	i_ino;
> 	struct ext2_inode i_ext2;
> };
>=20
> struct kdev_s {
> -#ifdef DEBUGFS
> 	ext2_filsys	k_fs;
> -#else
> -	e2fsck_t	k_ctx;
> -#endif
> 	int		k_dev;
> };
>=20
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_47ED6092-775A-45E5-B842-2349FA65544B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUI4+oACgkQcqXauRfM
H+DHfw/+MsQRssGqnioxS+BLKVk/9oLJUSuGFFmI5gqlPAXAzupt/DtyMtCe39qd
Kf0S92ulLfsxgMxltXzRQrNMs23Vl4o6doBymrLlu+FGdAcEk7pqBua9tnaBkr8l
HljiqykuvpCjp4Ggq6DrYhvsI+ChiWmZJ4kNTv20oVnXeEPMNTjQcrswA3Xtm9fC
Q7+lu4TeKwhc0TDpKvh0MRUXAOKLEtH+xJ6LHm72S+rPW+KSL9QomwEw2W/j1PY2
MhjB8WXLIDTyGsw7v3rK1Km8t3SYsxHHXjmp3z5JBNpFhTbvmsnHpdlxNaSS8GkA
PzsNAcGg7O8MDzqTLErst2Znb/gy48fBZm25eBcOZPy+KVDYq2LRuD2VMhlJ35Tl
LFrc89GBALoG59XfDrE55cBkrXUR/Hg9xcnK/LOhWB5fTmcCE9BJUwQC7/s72pFn
lE1uzu+bxm2Evud9ZUq8XxpYSRDsbU/0skQFM6/DMAwOisJ9nZzMlZqvMcqTKhBm
86QpdJ3JnewzDLy4jXTzlYWrhBcB785n5sVs2wcVF/g/vsZZBYgTCScvpgyxe8xO
IMNp6c7jyVr5rBa7p28mjDYL4KSKvO6wU8cshAViTD+PRQ9MkPS+LHLbEdBRfbO4
rqEPVypgvSl1RmquJz9Qi89yGMWQT5jO2NisnCdVx7YC0ICV+nQ=
=ttk9
-----END PGP SIGNATURE-----

--Apple-Mail=_47ED6092-775A-45E5-B842-2349FA65544B--
