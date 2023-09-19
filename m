Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4047B7A5670
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 02:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjISAES (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 20:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISAER (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 20:04:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A594A97
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 17:04:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fc9a4ebe9so4625090b3a.2
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 17:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695081850; x=1695686650; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6i+UzDA3Dm/8RKTe9Re7cpzSAKh4qAwnrfiYPqxMXx8=;
        b=AsbgnQNOXBVS0SEycIDyA5ZPZgHqYNv7KtSjwpVMq9tSIb3pNrlmGmE18zT+qbByWu
         HRifUjjCYcVNapV6yoGWRhVXrFSYeZJUAGz4QTgGp47B8ofFdu6T/oaCcxr1zIE2PIGD
         p3Tr9f2Uc6xZPC4IYsHZyQVNPTj0ykE32yeK5FMUqQ/egQG8uImgV+pNV8JM2edlrJE+
         Jc7fBHUtMEjML3cJRY6B5OCIHMIwlKzVds5kXdakZyT7Ud0494qR1iZ7B/Xvm4zVKeOV
         icHean6srNTUAdU31fAdLPyy/ykwg6n8ZIBYZTdV4kAFWlTaHQno4nMSFHzLkuHUqg3A
         VF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695081850; x=1695686650;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6i+UzDA3Dm/8RKTe9Re7cpzSAKh4qAwnrfiYPqxMXx8=;
        b=Ik2NQPdopF3u2/mAvX4nuradNqdntlZ7/oA/oDvQaFjLygww1Tkwsw4QjHMhOGFLqZ
         Ti9ZOUWZQIDJu5aAxzIc/hi2qm4AKtLV4yiiGd/0sulSA6AIVyzNSS63/xtkLO4h5ry5
         +HS4mJ0Nai1Q4Kyyoh+rVeF6dXCj/pS5d4s+TOUZ1h9nJnCj64kXPmRtFaRv7KZuiNyY
         OhwsPT520iW7B6Auu1BXhIALbzinvnmD7kbLRFyu3nX/rXIj9G64i4B5vaUWH04baifp
         RY31vp9hbkRc0BbIzKjbGTupy420rWqjZrAl9VRAoT0jDfFecqZ+dW4c5BJGe9FP+V51
         baYg==
X-Gm-Message-State: AOJu0YxJ1MOh6xK/yQo0JENzLZ32oBaUjNA0/90mM0XGNSIvIetVc8gZ
        xa9q3XeYUdeCIjw1k2TZn1EizhnNVfTmUYO5AmE=
X-Google-Smtp-Source: AGHT+IHW0+9h/8tURFbYVCqtks1xzRKkH2dSjuGapmj1l0NkLStg+cHk5/o23CTuumwyVUUQl1OQ/w==
X-Received: by 2002:a05:6a00:21cd:b0:68f:dcc1:4bef with SMTP id t13-20020a056a0021cd00b0068fdcc14befmr15097541pfj.7.1695081850046;
        Mon, 18 Sep 2023 17:04:10 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78c13000000b0068fcac56a82sm7897657pfd.19.2023.09.18.17.04.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 17:04:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FD9BAC55-489C-4F98-B6DF-58939741ABD8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5437C8EC-ED0A-4C2F-B894-50F702D349A2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/5] deduplicate a buffer_head / kernel device code.
Date:   Mon, 18 Sep 2023 18:04:07 -0600
In-Reply-To: <20220804095618.887684-5-alexey.lyashkov@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
References: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
 <20220804095618.887684-5-alexey.lyashkov@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5437C8EC-ED0A-4C2F-B894-50F702D349A2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 4, 2022, at 3:56 AM, Alexey Lyashkov <alexey.lyashkov@gmail.com> =
wrote:
>=20
> move a buffer_head and device code into libsupport.

Missing Signed-off-by: line, but looks fine otherwise.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
--

This patch was pushed before 1.47.0 was released, so debugfs/journal.c
is still missing the ext4_fc_replay*() code only in e2fsck/journal.c,
but at least it removes much of the duplication between these files.

We _might_ be able to merge the rest of this code into a single file =
with
something tricky, like having the fix_problem() calls handled via =
function
pointers in the journal context for e2fsck_journal_load() and similar,
and do nothing in the debugfs case.  I haven't looked into that yet.

Cheers, Andreas

> ---
> debugfs/journal.c      | 147 -----------------------------------------
> e2fsck/journal.c       | 143 ---------------------------------------
> lib/support/jfs_user.c | 142 +++++++++++++++++++++++++++++++++++++++
> 3 files changed, 142 insertions(+), 290 deletions(-)
>=20
> diff --git a/debugfs/journal.c b/debugfs/journal.c
> index 202312fe..510a0acb 100644
> --- a/debugfs/journal.c
> +++ b/debugfs/journal.c
> @@ -26,8 +26,6 @@
> #include "uuid/uuid.h"
> #include "journal.h"
>=20
> -static int bh_count =3D 0;
> -
> #if EXT2_FLAT_INCLUDES
> #include "blkid.h"
> #else
> @@ -47,151 +45,6 @@ static int bh_count =3D 0;
>  * to use the recovery.c file virtually unchanged from the kernel, so =
we
>  * don't have to do much to keep kernel and user recovery in sync.
>  */
> -int jbd2_journal_bmap(journal_t *journal, unsigned long block,
> -		      unsigned long long *phys)
> -{
> -#ifdef USE_INODE_IO
> -	*phys =3D block;
> -	return 0;
> -#else
> -	struct inode	*inode =3D journal->j_inode;
> -	errcode_t	retval;
> -	blk64_t		pblk;
> -
> -	if (!inode) {
> -		*phys =3D block;
> -		return 0;
> -	}
> -
> -	retval =3D ext2fs_bmap2(inode->i_fs, inode->i_ino,
> -			      &inode->i_ext2, NULL, 0, (blk64_t) block,
> -			      0, &pblk);
> -	*phys =3D pblk;
> -	return (int) retval;
> -#endif
> -}
> -
> -struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
> -			   int blocksize)
> -{
> -	struct buffer_head *bh;
> -	int bufsize =3D sizeof(*bh) + kdev->k_fs->blocksize -
> -		sizeof(bh->b_data);
> -	errcode_t retval;
> -
> -	retval =3D ext2fs_get_memzero(bufsize, &bh);
> -	if (retval)
> -		return NULL;
> -
> -	if (journal_enable_debug >=3D 3)
> -		bh_count++;
> -	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
> -		  blocknr, blocksize, bh_count);
> -
> -	bh->b_fs =3D kdev->k_fs;
> -	if (kdev->k_dev =3D=3D K_DEV_FS)
> -		bh->b_io =3D kdev->k_fs->io;
> -	else
> -		bh->b_io =3D kdev->k_fs->journal_io;
> -	bh->b_size =3D blocksize;
> -	bh->b_blocknr =3D blocknr;
> -
> -	return bh;
> -}
> -
> -int sync_blockdev(kdev_t kdev)
> -{
> -	io_channel	io;
> -
> -	if (kdev->k_dev =3D=3D K_DEV_FS)
> -		io =3D kdev->k_fs->io;
> -	else
> -		io =3D kdev->k_fs->journal_io;
> -
> -	return io_channel_flush(io) ? EIO : 0;
> -}
> -
> -void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
> -		 struct buffer_head *bhp[])
> -{
> -	errcode_t retval;
> -	struct buffer_head *bh;
> -
> -	for (; nr > 0; --nr) {
> -		bh =3D *bhp++;
> -		if (rw =3D=3D REQ_OP_READ && !bh->b_uptodate) {
> -			jfs_debug(3, "reading block %llu/%p\n",
> -				  bh->b_blocknr, (void *) bh);
> -			retval =3D io_channel_read_blk64(bh->b_io,
> -						     bh->b_blocknr,
> -						     1, bh->b_data);
> -			if (retval) {
> -				com_err(bh->b_fs->device_name, retval,
> -					"while reading block %llu\n",
> -					bh->b_blocknr);
> -				bh->b_err =3D (int) retval;
> -				continue;
> -			}
> -			bh->b_uptodate =3D 1;
> -		} else if (rw =3D=3D REQ_OP_WRITE && bh->b_dirty) {
> -			jfs_debug(3, "writing block %llu/%p\n",
> -				  bh->b_blocknr,
> -				  (void *) bh);
> -			retval =3D io_channel_write_blk64(bh->b_io,
> -						      bh->b_blocknr,
> -						      1, bh->b_data);
> -			if (retval) {
> -				com_err(bh->b_fs->device_name, retval,
> -					"while writing block %llu\n",
> -					bh->b_blocknr);
> -				bh->b_err =3D (int) retval;
> -				continue;
> -			}
> -			bh->b_dirty =3D 0;
> -			bh->b_uptodate =3D 1;
> -		} else {
> -			jfs_debug(3, "no-op %s for block %llu\n",
> -				  rw =3D=3D REQ_OP_READ ? "read" : =
"write",
> -				  bh->b_blocknr);
> -		}
> -	}
> -}
> -
> -void mark_buffer_dirty(struct buffer_head *bh)
> -{
> -	bh->b_dirty =3D 1;
> -}
> -
> -static void mark_buffer_clean(struct buffer_head *bh)
> -{
> -	bh->b_dirty =3D 0;
> -}
> -
> -void brelse(struct buffer_head *bh)
> -{
> -	if (bh->b_dirty)
> -		ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
> -	jfs_debug(3, "freeing block %llu/%p (total %d)\n",
> -		  bh->b_blocknr, (void *) bh, --bh_count);
> -	ext2fs_free_mem(&bh);
> -}
> -
> -int buffer_uptodate(struct buffer_head *bh)
> -{
> -	return bh->b_uptodate;
> -}
> -
> -void mark_buffer_uptodate(struct buffer_head *bh, int val)
> -{
> -	bh->b_uptodate =3D val;
> -}
> -
> -void wait_on_buffer(struct buffer_head *bh)
> -{
> -	if (!bh->b_uptodate)
> -		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> -}
> -
>=20
> static void ext2fs_clear_recover(ext2_filsys fs, int error)
> {
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index 728f5a24..9ff1dc94 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -27,8 +27,6 @@
> #include "problem.h"
> #include "uuid/uuid.h"
>=20
> -static int bh_count =3D 0;
> -
> /*
>  * Define USE_INODE_IO to use the inode_io.c / fileio.c codepaths.
>  * This creates a larger static binary, and a smaller binary using
> @@ -42,147 +40,6 @@ static int bh_count =3D 0;
>  * to use the recovery.c file virtually unchanged from the kernel, so =
we
>  * don't have to do much to keep kernel and user recovery in sync.
>  */
> -int jbd2_journal_bmap(journal_t *journal, unsigned long block,
> -		      unsigned long long *phys)
> -{
> -#ifdef USE_INODE_IO
> -	*phys =3D block;
> -	return 0;
> -#else
> -	struct inode 	*inode =3D journal->j_inode;
> -	errcode_t	retval;
> -	blk64_t		pblk;
> -
> -	if (!inode) {
> -		*phys =3D block;
> -		return 0;
> -	}
> -
> -	retval=3D ext2fs_bmap2(inode->i_fs, inode->i_ino,
> -			     &inode->i_ext2, NULL, 0, (blk64_t) block,
> -			     0, &pblk);
> -	*phys =3D pblk;
> -	return -1 * ((int) retval);
> -#endif
> -}
> -
> -struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
> -			   int blocksize)
> -{
> -	struct buffer_head *bh;
> -	int bufsize =3D sizeof(*bh) + kdev->k_fs->blocksize -
> -		sizeof(bh->b_data);
> -	errcode_t retval;
> -
> -	retval =3D ext2fs_get_memzero(bufsize, &bh);
> -	if (retval)
> -		return NULL;
> -
> -	if (journal_enable_debug >=3D 3)
> -		bh_count++;
> -	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
> -		  blocknr, blocksize, bh_count);
> -
> -	bh->b_fs =3D kdev->k_fs;
> -	if (kdev->k_dev =3D=3D K_DEV_FS)
> -		bh->b_io =3D kdev->k_fs->io;
> -	else
> -		bh->b_io =3D kdev->k_fs->journal_io;
> -	bh->b_size =3D blocksize;
> -	bh->b_blocknr =3D blocknr;
> -
> -	return bh;
> -}
> -
> -int sync_blockdev(kdev_t kdev)
> -{
> -	io_channel	io;
> -
> -	if (kdev->k_dev =3D=3D K_DEV_FS)
> -		io =3D kdev->k_fs->io;
> -	else
> -		io =3D kdev->k_fs->journal_io;
> -
> -	return io_channel_flush(io) ? -EIO : 0;
> -}
> -
> -void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
> -		 struct buffer_head *bhp[])
> -{
> -	errcode_t retval;
> -	struct buffer_head *bh;
> -
> -	for (; nr > 0; --nr) {
> -		bh =3D *bhp++;
> -		if (rw =3D=3D REQ_OP_READ && !bh->b_uptodate) {
> -			jfs_debug(3, "reading block %llu/%p\n",
> -				  bh->b_blocknr, (void *) bh);
> -			retval =3D io_channel_read_blk64(bh->b_io,
> -						     bh->b_blocknr,
> -						     1, bh->b_data);
> -			if (retval) {
> -				com_err(bh->b_fs->device_name, retval,
> -					"while reading block %llu\n",
> -					bh->b_blocknr);
> -				bh->b_err =3D (int) retval;
> -				continue;
> -			}
> -			bh->b_uptodate =3D 1;
> -		} else if (rw =3D=3D REQ_OP_WRITE && bh->b_dirty) {
> -			jfs_debug(3, "writing block %llu/%p\n",
> -				  bh->b_blocknr,
> -				  (void *) bh);
> -			retval =3D io_channel_write_blk64(bh->b_io,
> -						      bh->b_blocknr,
> -						      1, bh->b_data);
> -			if (retval) {
> -				com_err(bh->b_fs->device_name, retval,
> -					"while writing block %llu\n",
> -					bh->b_blocknr);
> -				bh->b_err =3D (int) retval;
> -				continue;
> -			}
> -			bh->b_dirty =3D 0;
> -			bh->b_uptodate =3D 1;
> -		} else {
> -			jfs_debug(3, "no-op %s for block %llu\n",
> -				  rw =3D=3D REQ_OP_READ ? "read" : =
"write",
> -				  bh->b_blocknr);
> -		}
> -	}
> -}
> -
> -void mark_buffer_dirty(struct buffer_head *bh)
> -{
> -	bh->b_dirty =3D 1;
> -}
> -
> -void brelse(struct buffer_head *bh)
> -{
> -	if (bh->b_dirty)
> -		ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
> -	jfs_debug(3, "freeing block %llu/%p (total %d)\n",
> -		  bh->b_blocknr, (void *) bh, --bh_count);
> -	ext2fs_free_mem(&bh);
> -}
> -
> -int buffer_uptodate(struct buffer_head *bh)
> -{
> -	return bh->b_uptodate;
> -}
> -
> -void mark_buffer_uptodate(struct buffer_head *bh, int val)
> -{
> -	bh->b_uptodate =3D val;
> -}
> -
> -void wait_on_buffer(struct buffer_head *bh)
> -{
> -	if (!bh->b_uptodate)
> -		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> -}
> -
> -
> static void e2fsck_clear_recover(e2fsck_t ctx, int error)
> {
> 	ext2fs_clear_feature_journal_needs_recovery(ctx->fs->super);
> diff --git a/lib/support/jfs_user.c b/lib/support/jfs_user.c
> index d8a2f842..26f0090b 100644
> --- a/lib/support/jfs_user.c
> +++ b/lib/support/jfs_user.c
> @@ -1,6 +1,8 @@
> #define DEBUGFS
> #include "jfs_user.h"
>=20
> +static int bh_count =3D 0;
> +
> /*
>  * Define USE_INODE_IO to use the inode_io.c / fileio.c codepaths.
>  * This creates a larger static binary, and a smaller binary using
> @@ -60,12 +62,116 @@ errcode_t ext2fs_journal_sb_csum_set(journal_t =
*j,
> 	return 0;
> }
>=20
> +void mark_buffer_dirty(struct buffer_head *bh)
> +{
> +	bh->b_dirty =3D 1;
> +}
> +
> +int buffer_uptodate(struct buffer_head *bh)
> +{
> +	return bh->b_uptodate;
> +}
> +
> +void mark_buffer_uptodate(struct buffer_head *bh, int val)
> +{
> +	bh->b_uptodate =3D val;
> +}
> +
> +void wait_on_buffer(struct buffer_head *bh)
> +{
> +	if (!bh->b_uptodate)
> +		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> +}
>=20
> static void mark_buffer_clean(struct buffer_head * bh)
> {
> 	bh->b_dirty =3D 0;
> }
>=20
> +struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
> +			   int blocksize)
> +{
> +	struct buffer_head *bh;
> +	int bufsize =3D sizeof(*bh) + kdev->k_fs->blocksize -
> +		sizeof(bh->b_data);
> +	errcode_t retval;
> +
> +	retval =3D ext2fs_get_memzero(bufsize, &bh);
> +	if (retval)
> +		return NULL;
> +
> +	if (journal_enable_debug >=3D 3)
> +		bh_count++;
> +	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
> +		  blocknr, blocksize, bh_count);
> +
> +	bh->b_fs =3D kdev->k_fs;
> +	if (kdev->k_dev =3D=3D K_DEV_FS)
> +		bh->b_io =3D kdev->k_fs->io;
> +	else
> +		bh->b_io =3D kdev->k_fs->journal_io;
> +	bh->b_size =3D blocksize;
> +	bh->b_blocknr =3D blocknr;
> +
> +	return bh;
> +}
> +
> +void brelse(struct buffer_head *bh)
> +{
> +	if (bh->b_dirty)
> +		ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
> +	jfs_debug(3, "freeing block %llu/%p (total %d)\n",
> +		  bh->b_blocknr, (void *) bh, --bh_count);
> +	ext2fs_free_mem(&bh);
> +}
> +
> +void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
> +		 struct buffer_head *bhp[])
> +{
> +	errcode_t retval;
> +	struct buffer_head *bh;
> +
> +	for (; nr > 0; --nr) {
> +		bh =3D *bhp++;
> +		if (rw =3D=3D REQ_OP_READ && !bh->b_uptodate) {
> +			jfs_debug(3, "reading block %llu/%p\n",
> +				  bh->b_blocknr, (void *) bh);
> +			retval =3D io_channel_read_blk64(bh->b_io,
> +						     bh->b_blocknr,
> +						     1, bh->b_data);
> +			if (retval) {
> +				com_err(bh->b_fs->device_name, retval,
> +					"while reading block %llu\n",
> +					bh->b_blocknr);
> +				bh->b_err =3D (int) retval;
> +				continue;
> +			}
> +			bh->b_uptodate =3D 1;
> +		} else if (rw =3D=3D REQ_OP_WRITE && bh->b_dirty) {
> +			jfs_debug(3, "writing block %llu/%p\n",
> +				  bh->b_blocknr,
> +				  (void *) bh);
> +			retval =3D io_channel_write_blk64(bh->b_io,
> +						      bh->b_blocknr,
> +						      1, bh->b_data);
> +			if (retval) {
> +				com_err(bh->b_fs->device_name, retval,
> +					"while writing block %llu\n",
> +					bh->b_blocknr);
> +				bh->b_err =3D (int) retval;
> +				continue;
> +			}
> +			bh->b_dirty =3D 0;
> +			bh->b_uptodate =3D 1;
> +		} else {
> +			jfs_debug(3, "no-op %s for block %llu\n",
> +				  rw =3D=3D REQ_OP_READ ? "read" : =
"write",
> +				  bh->b_blocknr);
> +		}
> +	}
> +}
> +
> +
> void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
> 			    int reset, int drop)
> {
> @@ -99,3 +205,39 @@ void ext2fs_journal_release(ext2_filsys fs, =
journal_t *journal,
> 		ext2fs_free_mem(&journal->j_fs_dev);
> 	ext2fs_free_mem(&journal);
> }
> +
> +int jbd2_journal_bmap(journal_t *journal, unsigned long block,
> +		      unsigned long long *phys)
> +{
> +#ifdef USE_INODE_IO
> +	*phys =3D block;
> +	return 0;
> +#else
> +	struct inode	*inode =3D journal->j_inode;
> +	errcode_t	retval;
> +	blk64_t		pblk;
> +
> +	if (!inode) {
> +		*phys =3D block;
> +		return 0;
> +	}
> +
> +	retval =3D ext2fs_bmap2(inode->i_fs, inode->i_ino,
> +			      &inode->i_ext2, NULL, 0, (blk64_t) block,
> +			      0, &pblk);
> +	*phys =3D pblk;
> +	return (int) retval;
> +#endif
> +}
> +
> +int sync_blockdev(kdev_t kdev)
> +{
> +	io_channel	io;
> +
> +	if (kdev->k_dev =3D=3D K_DEV_FS)
> +		io =3D kdev->k_fs->io;
> +	else
> +		io =3D kdev->k_fs->journal_io;
> +
> +	return io_channel_flush(io) ? EIO : 0;
> +}
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_5437C8EC-ED0A-4C2F-B894-50F702D349A2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUI5XcACgkQcqXauRfM
H+COrRAAjnnLcKGslzu3sPbAfQoUzCj0Np7iwHwQG7Z4WSJnT3L55pLBH9GWxfn5
BotclvQHPpaSIPd8pMZZQY2n2Q2uuY9UCosSffb8mD9QI17tKmxsC9V8QB8Df9C2
+5Qkrj0VoaVMnzUuDC3Flho6tT8CxD2hGwfObEPdNypblLUccIW4k+Ltjahb+rES
QodS9vB0wkd7YoxPf3Bl5V9nAcfrl4nJD5As6y0nBE6qifkI34uruoj9Avn5RXdK
BgafUd44yy9AXPbx8p30rv+WzqYUj7/p+5w7l7F0rLGaqzfe61Le0dM4uivzCPm/
883rpjIlPb7YPVH2iLuBXrulCwEj2g87hHeDCLEJPjKgovucoBEu1AIF2eip5Hav
FWZ0P3CH3D/jAYQ5jwrUkbeCT4yXqetwkQGmUBtf1nwo/E2J31s1cbeoDi+Zvg93
J1jwtd6VXWV+KLQefp96af8V1KmLeDL1vj3vi8iiFi5DFQrFZ0/LQwp24qPLi+Fx
K2oU4ZtE+2Ms5VfaORgDad0pBXcQPuVxBKjJau2RZNXKXmhxMtzhDW2MrB5QEY+E
lrg6PXClpxyxOkZ/ynDvlaHtYR7/Pz9I17SzmlIKgFYU035zTeyIGyTb0IMQmkb5
jrs4felY/xo1Bkcba4CyYXFI3mKNByNDUlyZuKqLEjrq2oYjKgk=
=iD9V
-----END PGP SIGNATURE-----

--Apple-Mail=_5437C8EC-ED0A-4C2F-B894-50F702D349A2--
