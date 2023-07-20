Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F64475BAB1
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 00:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGTWhp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 18:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGTWho (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 18:37:44 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE69171E
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 15:37:38 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-345d6dc271dso7372805ab.0
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1689892658; x=1690497458;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzNX7toFBjdxFDfCMcF3m1jE/Osw9x3xbUEU94TVUdo=;
        b=yja8kyi0h6ZkQ6GEePHbazjKVL+sR6jjVmVN+lweDQrCaDtBnLidPZJmyxgr+ge2XY
         e6FHSaPRxgDJ9Fk0r5z2tfFFNljqkNJtKhHWMuef0R2wbsByT1rJswqAUSr+WfsB+oR/
         T9e7SFS/gVQ9b3rW/d0rV+pP66MfjoKHi64TtdQz8yFKTHHzNavSoBohb+NZSvvii8qX
         4VgsK63Mx9lijSsEqAvpC5CjKsXrGgzR5I8423+zrGAODKvZWMWC9yInWoltzVCjX9tv
         nMH/R3Go59csE/YWToG9HVAQcEJcGu8ySLR+Npas9dQJrtoST5ys4CuyjgPBHyFB+hpy
         4eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689892658; x=1690497458;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzNX7toFBjdxFDfCMcF3m1jE/Osw9x3xbUEU94TVUdo=;
        b=PyknEk3fjF/fKDrLkVUhVqKxPYSW6g9uZdRfzSvcUA3h4Xg6I6PjYwtNvN+g1/e+64
         b5gQb4/dqa8n7ymMYy2z7jEJdjZXE5ZsitO8wKIZzFZmE3I+JztO1pPAleLcNivCeLMV
         QzrXOPYGVbC/eRf8a27L+V+QGZC+rfQtDlFec3iqicgBeB9Jy2NJEO03CoxBvvG1NzS1
         8UD04f0lkHtkXNdQc2bufAqlfjfbmcoH+Db0AxYTIgwQBHLM7hsn2XyvZb300twA3TKm
         ZZY3bwhXDY7QGzTKUr3bTPNVoFisJvdMxVoBVteeIK1cDLz9/lDSU+w0eRaE7SEjBTrj
         ysPw==
X-Gm-Message-State: ABy/qLZf+btgFazc2C/BZMtmwuQFb+9KFwTtWxKMo2pYzsCA9N6qJwtx
        uLAKfYw6ohRRZZeY+5RtjXVoqPOY6qzGFu8+kCg=
X-Google-Smtp-Source: APBJJlGNgv6oxfc6QNys0KkSQN4vxfjX9Qc7jtURov4IOXqcLdrJfJ8P5vJ2GZ8tu0gPXx6NAejkNA==
X-Received: by 2002:a92:d651:0:b0:348:8041:8914 with SMTP id x17-20020a92d651000000b0034880418914mr321378ilp.1.1689892658117;
        Thu, 20 Jul 2023 15:37:38 -0700 (PDT)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090a660100b00260cce91d20sm1405098pjj.33.2023.07.20.15.37.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 15:37:37 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6A5FDFE2-4A97-47D4-906E-C5609FC2E9E6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C40FB397-DA31-4328-8B31-1F5FBF80CF28";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] merge extent blocks when possible
Date:   Thu, 20 Jul 2023 16:39:07 -0600
In-Reply-To: <7746B8CB-D759-47A2-8564-624B5263B5C3@whamcloud.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>
References: <7746B8CB-D759-47A2-8564-624B5263B5C3@whamcloud.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C40FB397-DA31-4328-8B31-1F5FBF80CF28
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 19, 2023, at 12:49 PM, Alex Zhuravlev <azhuravlev@whamcloud.com> =
wrote:
>=20
> In some cases when a lot of extents are created initially by sparse =
file
> writes, they get merged over time, but there is no way to merge blocks =
in
> different indexes.
>=20
> For example, if a file is written synchronously, all even blocks =
first,
> then odd blocks.  The resulting extents tree looks like the following =
in
> "debugfs stat" output, often with only a single block in each =
index/leaf:
>=20
>   EXTENTS:
>   (ETB0):33796
>   (ETB1):33795
>   (0-677):2588672-2589349
>   (ETB1):2590753
>   (678):2589350
>   (ETB1):2590720
>   (679-1357):2589351-2590029
>   (ETB1):2590752
>   (1358):2590030
>   (ETB1):2590721
>   (1359-2037):2590031-2590709
>   (ETB1):2590751
>   (2038):2590710
>   (ETB1):2590722
>   :
>   :
>=20
> With the patch applied the index and lead blocks are properly merged
> (0.6% slower under this random sync write workload, but later read
> IOPS are greatly reduced):
>=20
>   EXTENTS:
>   (ETB0):33796
>   (ETB1):2590736
>   (0-2047):2588672-2590719
>   (2048-11999):2592768-2602719
>=20
> Originally the problem was hit with a real application operating on
> huge datasets and with just 27371 extents
>=20
>     inode has invalid extent depth: 6
>=20
> problem occurred.  With the patch applied the application succeeded
> having finally 73637 extents in 3-level tree.
>=20
> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/extents.c     | 185 ++++++++++++++++++++++++++++++++++++++++--
> fs/jbd2/transaction.c |   1 +
> 2 files changed, 180 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e4115d338f10..5b0e05cd5595 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1885,7 +1885,7 @@ static void ext4_ext_try_to_merge_up(handle_t =
*handle,
>  * This function tries to merge the @ex extent to neighbours in the =
tree, then
>  * tries to collapse the extent tree into the inode.
>  */
> -static void ext4_ext_try_to_merge(handle_t *handle,
> +static int ext4_ext_try_to_merge(handle_t *handle,
> 				  struct inode *inode,
> 				  struct ext4_ext_path *path,
> 				  struct ext4_extent *ex)
> @@ -1902,9 +1902,178 @@ static void ext4_ext_try_to_merge(handle_t =
*handle,
> 		merge_done =3D ext4_ext_try_to_merge_right(inode, path, =
ex - 1);
>=20
> 	if (!merge_done)
> -		(void) ext4_ext_try_to_merge_right(inode, path, ex);
> +		merge_done =3D ext4_ext_try_to_merge_right(inode, path, =
ex);
>=20
> 	ext4_ext_try_to_merge_up(handle, inode, path);
> +
> +	return merge_done;
> +}
> +
> +/*
> + * This function tries to merge blocks from @path into @npath
> + */
> +static int ext4_ext_merge_blocks(handle_t *handle,
> +				struct inode *inode,
> +				struct ext4_ext_path *path,
> +				struct ext4_ext_path *npath)
> +{
> +	unsigned int depth =3D ext_depth(inode);
> +	int used, nused, free, i, k, err;
> +	ext4_lblk_t next;
> +
> +	if (path[depth].p_hdr =3D=3D npath[depth].p_hdr)
> +		return 0;
> +
> +	used =3D le16_to_cpu(path[depth].p_hdr->eh_entries);
> +	free =3D le16_to_cpu(npath[depth].p_hdr->eh_max) -
> +		le16_to_cpu(npath[depth].p_hdr->eh_entries);
> +	if (free < used)
> +		return 0;
> +
> +	err =3D ext4_ext_get_access(handle, inode, path + depth);
> +	if (err)
> +		return err;
> +	err =3D ext4_ext_get_access(handle, inode, npath + depth);
> +	if (err)
> +		return err;
> +
> +	/* move entries from the current leave to the next one */
> +	nused =3D le16_to_cpu(npath[depth].p_hdr->eh_entries);
> +	memmove(EXT_FIRST_EXTENT(npath[depth].p_hdr) + used,
> +		EXT_FIRST_EXTENT(npath[depth].p_hdr),
> +		nused * sizeof(struct ext4_extent));
> +	memcpy(EXT_FIRST_EXTENT(npath[depth].p_hdr),
> +		EXT_FIRST_EXTENT(path[depth].p_hdr),
> +		used * sizeof(struct ext4_extent));
> +	le16_add_cpu(&npath[depth].p_hdr->eh_entries, used);
> +	le16_add_cpu(&path[depth].p_hdr->eh_entries, -used);
> +	ext4_ext_try_to_merge_right(inode, npath,
> +					=
EXT_FIRST_EXTENT(npath[depth].p_hdr));
> +
> +	err =3D ext4_ext_dirty(handle, inode, path + depth);
> +	if (err)
> +		return err;
> +	err =3D ext4_ext_dirty(handle, inode, npath + depth);
> +	if (err)
> +		return err;
> +
> +	/* otherwise the index won't get corrected */
> +	npath[depth].p_ext =3D EXT_FIRST_EXTENT(npath[depth].p_hdr);
> +	err =3D ext4_ext_correct_indexes(handle, inode, npath);
> +	if (err)
> +		return err;
> +
> +	for (i =3D depth - 1; i >=3D 0; i--) {
> +
> +		next =3D ext4_idx_pblock(path[i].p_idx);
> +		ext4_free_blocks(handle, inode, NULL, next, 1,
> +				EXT4_FREE_BLOCKS_METADATA |
> +				EXT4_FREE_BLOCKS_FORGET);
> +		err =3D ext4_ext_get_access(handle, inode, path + i);
> +		if (err)
> +			return err;
> +		le16_add_cpu(&path[i].p_hdr->eh_entries, -1);
> +		if (le16_to_cpu(path[i].p_hdr->eh_entries) =3D=3D 0) {
> +			/* whole index block collapsed, go up */
> +			continue;
> +		}
> +		/* remove index pointer */
> +		used =3D EXT_LAST_INDEX(path[i].p_hdr) - path[i].p_idx + =
1;
> +		memmove(path[i].p_idx, path[i].p_idx + 1,
> +			used * sizeof(struct ext4_extent_idx));
> +
> +		err =3D ext4_ext_dirty(handle, inode, path + i);
> +		if (err)
> +			return err;
> +
> +		if (path[i].p_hdr =3D=3D npath[i].p_hdr)
> +			break;
> +
> +		/* try to move index pointers */
> +		used =3D le16_to_cpu(path[i].p_hdr->eh_entries);
> +		free =3D le16_to_cpu(npath[i].p_hdr->eh_max) -
> +			le16_to_cpu(npath[i].p_hdr->eh_entries);
> +		if (used > free)
> +			break;
> +		err =3D ext4_ext_get_access(handle, inode, npath + i);
> +		if (err)
> +			return err;
> +		memmove(EXT_FIRST_INDEX(npath[i].p_hdr) + used,
> +			EXT_FIRST_INDEX(npath[i].p_hdr),
> +			npath[i].p_hdr->eh_entries * sizeof(struct =
ext4_extent_idx));
> +		memcpy(EXT_FIRST_INDEX(npath[i].p_hdr), =
EXT_FIRST_INDEX(path[i].p_hdr),
> +			used * sizeof(struct ext4_extent_idx));
> +		le16_add_cpu(&path[i].p_hdr->eh_entries, -used);
> +		le16_add_cpu(&npath[i].p_hdr->eh_entries, used);
> +		err =3D ext4_ext_dirty(handle, inode, path + i);
> +		if (err)
> +			return err;
> +		err =3D ext4_ext_dirty(handle, inode, npath + i);
> +		if (err)
> +			return err;
> +
> +		/* correct index above */
> +		for (k =3D i; k > 0; k--) {
> +			err =3D ext4_ext_get_access(handle, inode, npath =
+ k - 1);
> +			if (err)
> +				return err;
> +			npath[k-1].p_idx->ei_block =3D
> +				=
EXT_FIRST_INDEX(npath[k].p_hdr)->ei_block;
> +			err =3D ext4_ext_dirty(handle, inode, npath + k =
- 1);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	/*
> +	 * TODO: given we've got two paths, it should be possible to
> +	 * collapse those two blocks into the root one in some cases
> +	 */
> +	return 1;
> +}
> +
> +static int ext4_ext_try_to_merge_blocks(handle_t *handle,
> +		struct inode *inode,
> +		struct ext4_ext_path *path)
> +{
> +	struct ext4_ext_path *npath =3D NULL;
> +	unsigned int depth =3D ext_depth(inode);
> +	ext4_lblk_t next;
> +	int used, rc =3D 0;
> +
> +	if (depth =3D=3D 0)
> +		return 0;
> +
> +	used =3D le16_to_cpu(path[depth].p_hdr->eh_entries);
> +	/* don't be too agressive as checking space in
> +	 * the next block is not free */
> +	if (used > ext4_ext_space_block(inode, 0) / 4)
> +		return 0;
> +
> +	/* try to merge to the next block */
> +	next =3D ext4_ext_next_leaf_block(path);
> +	if (next =3D=3D EXT_MAX_BLOCKS)
> +		return 0;
> +	npath =3D ext4_find_extent(inode, next, NULL, 0);
> +	if (IS_ERR(npath))
> +		return 0;
> +	rc =3D ext4_ext_merge_blocks(handle, inode, path, npath);
> +	ext4_ext_drop_refs(npath);
> +	kfree(npath);
> +	if (rc)
> +		return rc > 0 ? 0 : rc;
> +
> +	/* try to merge with the previous block */
> +	if (EXT_FIRST_EXTENT(path[depth].p_hdr)->ee_block =3D=3D 0)
> +		return 0;
> +	next =3D EXT_FIRST_EXTENT(path[depth].p_hdr)->ee_block - 1;
> +	npath =3D ext4_find_extent(inode, next, NULL, 0);
> +	if (IS_ERR(npath))
> +		return 0;
> +	rc =3D ext4_ext_merge_blocks(handle, inode, npath, path);
> +	ext4_ext_drop_refs(npath);
> +	kfree(npath);
> +	return rc > 0 ? 0 : rc;
> }
>=20
> /*
> @@ -1976,6 +2145,7 @@ int ext4_ext_insert_extent(handle_t *handle, =
struct inode *inode,
> 	int depth, len, err;
> 	ext4_lblk_t next;
> 	int mb_flags =3D 0, unwritten;
> +	int merged =3D 0;
>=20
> 	if (gb_flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
> 		mb_flags |=3D EXT4_MB_DELALLOC_RESERVED;
> @@ -2167,8 +2337,7 @@ int ext4_ext_insert_extent(handle_t *handle, =
struct inode *inode,
> merge:
> 	/* try to merge extents */
> 	if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
> -		ext4_ext_try_to_merge(handle, inode, path, nearex);
> -
> +		merged =3D ext4_ext_try_to_merge(handle, inode, path, =
nearex);
>=20
> 	/* time to correct all indexes above */
> 	err =3D ext4_ext_correct_indexes(handle, inode, path);
> @@ -2176,6 +2345,8 @@ int ext4_ext_insert_extent(handle_t *handle, =
struct inode *inode,
> 		goto cleanup;
>=20
> 	err =3D ext4_ext_dirty(handle, inode, path + path->p_depth);
> +	if (!err && merged)
> +		err =3D ext4_ext_try_to_merge_blocks(handle, inode, =
path);
>=20
> cleanup:
> 	ext4_free_ext_path(npath);
> @@ -3765,7 +3936,8 @@ static int =
ext4_convert_unwritten_extents_endio(handle_t *handle,
> 	/* note: ext4_ext_correct_indexes() isn't needed here because
> 	 * borders are not changed
> 	 */
> -	ext4_ext_try_to_merge(handle, inode, path, ex);
> +	if (ext4_ext_try_to_merge(handle, inode, path, ex))
> +		ext4_ext_try_to_merge_blocks(handle, inode, path);
>=20
> 	/* Mark modified extent as dirty */
> 	err =3D ext4_ext_dirty(handle, inode, path + path->p_depth);
> @@ -3828,7 +4000,8 @@ convert_initialized_extent(handle_t *handle, =
struct inode *inode,
> 	/* note: ext4_ext_correct_indexes() isn't needed here because
> 	 * borders are not changed
> 	 */
> -	ext4_ext_try_to_merge(handle, inode, path, ex);
> +	if (ext4_ext_try_to_merge(handle, inode, path, ex))
> +		ext4_ext_try_to_merge_blocks(handle, inode, path);
>=20
> 	/* Mark modified extent as dirty */
> 	err =3D ext4_ext_dirty(handle, inode, path + path->p_depth);
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 18611241f451..7421f2af9cf2 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -513,6 +513,7 @@ handle_t *jbd2__journal_start(journal_t *journal, =
int nblocks, int rsv_blocks,
> 		}
> 		rsv_handle->h_reserved =3D 1;
> 		rsv_handle->h_journal =3D journal;
> +		rsv_handle->h_revoke_credits =3D revoke_records;
> 		handle->h_rsv_handle =3D rsv_handle;
> 	}
> 	handle->h_revoke_credits =3D revoke_records;
> --
> 2.40.1
>=20


Cheers, Andreas






--Apple-Mail=_C40FB397-DA31-4328-8B31-1F5FBF80CF28
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmS5t4sACgkQcqXauRfM
H+CuWA/7Br1w5GPzC3PzoUo+dKA0PXJMA62ZYrxieb7ADwit64zJRtEOS0398jxt
1bh1/NfbC+Tq6ezwOzjWLlT/F0H8pz4IMYPoX2v7U3bpp7TQovEmUEgQJAxzqzR7
6JYn7EXDfSjMwFpzQ2rjS0LG90ggvRBLPwlN9Ku7ZK34gCJB3zSnDHErLxdVW5N3
4jE6Yx9S2+XQsWn0SoOiQjpgdszBgFY6A+3qUxxBUCeh+3TtZBr/H0ys3fqomttj
dKK5vAFwSUudoJdViSE+xeMZvhkpanuJk9wZYFkR+s7aXDRiyg4QtOXz5vk6P0ym
+G5UIJOd4gNVXbPRurX8hhKeVEJ0ibZfVgC7rZFMnF9edb4Ur+6Vo/3nlXHJQWzy
HdIj1LZo9P+A0bLixl0OnwedsqT7bQ4zn1HyGqNRy/Kt+0cR6V5PA6r+V0ZLAUlk
7d6uwI9tDrFXxeimEX7kWFh8HxqIkW+QbrPahGCeTUWSR6Nl/83GaQ0/O2Yjzc1G
09h1vGbEW137zwREApTz3z029odlZnR1/eODMbxE54XDRxnTeEMtXJGKzT3x4cnO
MmqhZd3bXBuCcGp2UYSt5ssAcPL+UAiS49n1nNo5VTHkEx7WjsNinHeWTRn9ODM2
kLFyuIWxEFu80da1D4VfEei1JtB0eYtb2RDrhEWrNr6uOtSohZg=
=6jzy
-----END PGP SIGNATURE-----

--Apple-Mail=_C40FB397-DA31-4328-8B31-1F5FBF80CF28--
