Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008678029C
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 02:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbjHRAOA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 20:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356661AbjHRAN3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 20:13:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128F1FC3
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 17:13:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6887c3aac15so313218b3a.2
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1692317581; x=1692922381;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YFTQ893nTZHRwndUJ5tsNGU8gnCaw+t+1zbu1MM5AV0=;
        b=J75ChfgCsGv7DGBS6kdAECKFBWYDJfQx3FaUzehdlJsS406PxDcK4DE17Wb3pNF+V2
         7/vjhlxl68QmXEtsgHUgZjVJw968bmjBWm0UVRyCn2av7i4rg8pJTYWeRa/g0ZA1mUXm
         53SEO/pSSaT7vsW2H9mWPcaZi3vxv5DmDdTGREJ3Y2IDQYTI1jIS0ZebXMCuPhCdze6x
         GLJzEjcrU67b/myVC/ud8dJNJtMfiCO4y4Il/o0CBG+YJ2Ev3XkdAkVzFtG2MjIRCmay
         Hg3kAhvsZlYWtkAoj76hZegO41UNCj9yD3yS1XHcgHdKhv+Ym/SDLOZXroSA8XONz1XT
         lUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317581; x=1692922381;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFTQ893nTZHRwndUJ5tsNGU8gnCaw+t+1zbu1MM5AV0=;
        b=U2yhydd5zQGbWShx2uRPuyF7eA2stZY3RaIrLRsCdbJIXKDF+dTyUJvmSvuIcNyUS3
         TigMNmUyY+lJ1gSsp1PR5FevZqPDe9ibhPWA84jrWO+fVMyRIGZ+xm9dOqLlnks5xUhl
         8pFrid2QMAnSBh/V2A/nshdp0Qyh+ylFoC9pP0jcje7fk3Dt82S3eyhw2BKa628sXN3f
         +nOVfxOu1lqBUhi9XsXUK9My+31U0uD20uC7crAveelBmCnG+eVRy7lSrjP20PBqS0nr
         A21M+s9UMrxALqRE8aQjlXeJKpmavfyFOXavWBOBSWpMY7bGvCOspHsbApfe/S2blgDe
         ckfA==
X-Gm-Message-State: AOJu0YzkmdQkYW8dpXHDiPzNdVbJXwk+xE9xWZIWeTe8/zYfTtMrvWKe
        ZUbu57VQq6Q0SAwzLE4+CklAVfObGJZ//MVSbAg=
X-Google-Smtp-Source: AGHT+IFfblIUZjip6vvGYIcQJXHgFDNG2dvnZf77HdJFhkRqocMEB+fuIzS6fPg3WrjjSBmuUs636Q==
X-Received: by 2002:a05:6a20:3209:b0:132:8620:8d21 with SMTP id hl9-20020a056a20320900b0013286208d21mr1180873pzc.58.1692317580733;
        Thu, 17 Aug 2023 17:13:00 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170903048a00b001bdb073a830sm342270plb.162.2023.08.17.17.12.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2023 17:12:59 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1352865D-2799-4E5F-A053-E0E3AFC6ACDE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DC62B409-3E9C-4F68-B426-33E20DC757C8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2] ext4: introduce EXT4_BG_TRIMMED to optimize fstrim
Date:   Thu, 17 Aug 2023 18:12:57 -0600
In-Reply-To: <20230817003504.458920-1-dongyangli@ddn.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Shuichi Ihara <sihara@ddn.com>, wangshilong1991@gmail.com
To:     Li Dongyang <dongyangli@ddn.com>
References: <20230817003504.458920-1-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_DC62B409-3E9C-4F68-B426-33E20DC757C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 16, 2023, at 6:35 PM, Li Dongyang <dongyangli@ddn.com> wrote:
>=20
> Currently the flag indicating block group has done fstrim is not
> persistent, and trim status will be lost after remount, as
> a result fstrim can not skip the already trimmed groups, which
> could be slow on very large devices.
>=20
> This patch introduces a new block group flag EXT4_BG_TRIMMED,
> we need 1 extra block group descriptor write after trimming each
> block group.
> When clearing the flag, the block group descriptor is journalled
> already so no extra overhead.
>=20
> Add a new super block flag EXT2_FLAGS_TRACK_TRIM, to indicate if
> we should honour and set EXT4_BG_TRIMMED when doing fstrim.
> The new super block flag can be turned on/off via tune2fs.

We discussed this patch on the ext4 developer concall again today,
and Ted agreed the EXT4_FLAGS_TRACK_TRIM flag was OK, and should be
enabled by default in mke2fs (as it already is), otherwise most users
will not benefit from this feature.  Being able to turn this off in
case of problems is still convenient.

There was some discussion about whether the BG_TRIMMED flag should be
set on groups with BLOCK_UNINIT, because the loading of the block
bitmap during trim would initialize the bitmap itself and clear the
BLOCK_UNINIT flag.

Ted's comment on the previous review was:
>> This patch introduces a new block group flag EXT4_BG_TRIMMED,
>> we need 1 extra block group descriptor write after trimming each
>> block group. When clearing the flag, the block group descriptor
>> is journaled already so no extra overhead.
>=20
> ... we should not try to set the flag if the
> block group is unitialized, and we should actually send the discard in
> that case, since presumably the blocks in question were discard when
> the file system was mkfs'ed.

For newly-formatted filesystems with the BG_TRIMMED support, the flag
is already set at mke2fs on every group after a successful full device
discard, so nothing further is needed I think.

If EXT2_FLAGS_TRACK_TRIM is enabled on an existing filesystem *after*
it is already used, then previous fstrim calls would likely have already
loaded the block bitmap and trimmed the groups so setting BG_TRIMMED
in this case should be fine, regardless of whether BLOCK_UNINIT.

Cheers, Andreas

> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>
> ---
> v1->v2:
> use cpu_to_le32() with the new super flag.
> do not record BG_TRIMMED if TRACK_TRIM is not set in super block.
> ---
> fs/ext4/ext4.h      | 10 ++-----
> fs/ext4/ext4_jbd2.h |  3 ++-
> fs/ext4/mballoc.c   | 63 +++++++++++++++++++++++++++++++++++----------
> 3 files changed, 53 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 0a2d55faa095..a990fb49b24f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -437,6 +437,7 @@ struct flex_groups {
> #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use =
*/
> #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
> #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to =
zero */
> +#define EXT4_BG_TRIMMED		0x0008 /* block group was =
trimmed */
>=20
> /*
>  * Macro-instructions used to manage group descriptors
> @@ -1166,6 +1167,7 @@ struct ext4_inode_info {
> #define EXT2_FLAGS_SIGNED_HASH		0x0001  /* Signed =
dirhash in use */
> #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in =
use */
> #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* to test =
development code */
> +#define EXT2_FLAGS_TRACK_TRIM		0x0008  /* Track trim =
status in each bg */
>=20
> /*
>  * Mount flags set via mount options or defaults
> @@ -3412,7 +3414,6 @@ struct ext4_group_info {
> };
>=20
> #define EXT4_GROUP_INFO_NEED_INIT_BIT		0
> -#define EXT4_GROUP_INFO_WAS_TRIMMED_BIT		1
> #define EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT	2
> #define EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT	3
> #define EXT4_GROUP_INFO_BBITMAP_CORRUPT		\
> @@ -3427,13 +3428,6 @@ struct ext4_group_info {
> 	(test_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT, =
&((grp)->bb_state)))
> #define EXT4_MB_GRP_IBITMAP_CORRUPT(grp)	\
> 	(test_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT, =
&((grp)->bb_state)))
> -
> -#define EXT4_MB_GRP_WAS_TRIMMED(grp)	\
> -	(test_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> -#define EXT4_MB_GRP_SET_TRIMMED(grp)	\
> -	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> -#define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
> -	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> #define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
> 	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, =
&((grp)->bb_state)))
>=20
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 0c77697d5e90..ce529a454b2a 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -120,7 +120,8 @@
> #define EXT4_HT_MOVE_EXTENTS     9
> #define EXT4_HT_XATTR           10
> #define EXT4_HT_EXT_CONVERT     11
> -#define EXT4_HT_MAX             12
> +#define EXT4_HT_FS_TRIM		12
> +#define EXT4_HT_MAX             13
>=20
> /**
>  *   struct ext4_journal_cb_entry - Base structure for callback =
information.
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 21b903fe546e..d537bcdf121d 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3849,15 +3849,6 @@ static void ext4_free_data_in_buddy(struct =
super_block *sb,
> 	rb_erase(&entry->efd_node, &(db->bb_free_root));
> 	mb_free_blocks(NULL, &e4b, entry->efd_start_cluster, =
entry->efd_count);
>=20
> -	/*
> -	 * Clear the trimmed flag for the group so that the next
> -	 * ext4_trim_fs can trim it.
> -	 * If the volume is mounted with -o discard, online discard
> -	 * is supported and the free blocks will be trimmed online.
> -	 */
> -	if (!test_opt(sb, DISCARD))
> -		EXT4_MB_GRP_CLEAR_TRIMMED(db);
> -
> 	if (!db->bb_free_root.rb_node) {
> 		/* No more items in the per group rb tree
> 		 * balance refcounts from ext4_mb_free_metadata()
> @@ -6587,8 +6578,7 @@ static void ext4_mb_clear_bb(handle_t *handle, =
struct inode *inode,
> 					 " group:%u block:%d count:%lu =
failed"
> 					 " with %d", block_group, bit, =
count,
> 					 err);
> -		} else
> -			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
> +		}
>=20
> 		ext4_lock_group(sb, block_group);
> 		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
> @@ -6598,6 +6588,14 @@ static void ext4_mb_clear_bb(handle_t *handle, =
struct inode *inode,
> 	ret =3D ext4_free_group_clusters(sb, gdp) + count_clusters;
> 	ext4_free_group_clusters_set(sb, gdp, ret);
> 	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> +	/*
> +	 * Clear the trimmed flag for the group so that the next
> +	 * ext4_trim_fs can trim it.
> +	 * If the volume is mounted with -o discard, online discard
> +	 * is supported and the free blocks will be trimmed online.
> +	 */
> +	if (!test_opt(sb, DISCARD))
> +		gdp->bg_flags &=3D cpu_to_le16(~EXT4_BG_TRIMMED);
> 	ext4_group_desc_csum_set(sb, block_group, gdp);
> 	ext4_unlock_group(sb, block_group);
>=20
> @@ -6995,10 +6993,19 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
> 		   ext4_grpblk_t minblocks, bool set_trimmed)
> {
> 	struct ext4_buddy e4b;
> +	struct ext4_super_block *es =3D EXT4_SB(sb)->s_es;
> +	struct ext4_group_desc *gdp;
> +	struct buffer_head *gd_bh;
> 	int ret;
>=20
> 	trace_ext4_trim_all_free(sb, group, start, max);
>=20
> +	gdp =3D ext4_get_group_desc(sb, group, &gd_bh);
> +	if (!gdp) {
> +		ret =3D -EIO;
> +		return ret;
> +	}
> +
> 	ret =3D ext4_mb_load_buddy(sb, group, &e4b);
> 	if (ret) {
> 		ext4_warning(sb, "Error %d loading buddy information for =
%u",
> @@ -7008,11 +7015,10 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
>=20
> 	ext4_lock_group(sb, group);
>=20
> -	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
> +	if (!(es->s_flags & cpu_to_le32(EXT2_FLAGS_TRACK_TRIM) &&
> +	      gdp->bg_flags & cpu_to_le16(EXT4_BG_TRIMMED)) ||
> 	    minblocks < EXT4_SB(sb)->s_last_trim_minblks) {
> 		ret =3D ext4_try_to_trim_range(sb, &e4b, start, max, =
minblocks);
> -		if (ret >=3D 0 && set_trimmed)
> -			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
> 	} else {
> 		ret =3D 0;
> 	}
> @@ -7020,6 +7026,35 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
> 	ext4_unlock_group(sb, group);
> 	ext4_mb_unload_buddy(&e4b);
>=20
> +	if (ret > 0 && set_trimmed &&
> +	    es->s_flags & cpu_to_le32(EXT2_FLAGS_TRACK_TRIM)) {
> +		int err;
> +		handle_t *handle;
> +
> +		handle =3D ext4_journal_start_sb(sb, EXT4_HT_FS_TRIM, =
1);
> +		if (IS_ERR(handle)) {
> +			ret =3D PTR_ERR(handle);
> +			goto out_return;
> +		}
> +		err =3D ext4_journal_get_write_access(handle, sb, gd_bh,
> +						    EXT4_JTR_NONE);
> +		if (err) {
> +			ret =3D err;
> +			goto out_journal;
> +		}
> +		ext4_lock_group(sb, group);
> +		gdp->bg_flags |=3D cpu_to_le16(EXT4_BG_TRIMMED);
> +		ext4_group_desc_csum_set(sb, group, gdp);
> +		ext4_unlock_group(sb, group);
> +		err =3D ext4_handle_dirty_metadata(handle, NULL, gd_bh);
> +		if (err)
> +			ret =3D err;
> +out_journal:
> +		err =3D ext4_journal_stop(handle);
> +		if (err)
> +			ret =3D err;
> +	}
> +out_return:
> 	ext4_debug("trimmed %d blocks in the group %d\n",
> 		ret, group);
>=20
> --
> 2.41.0
>=20


Cheers, Andreas






--Apple-Mail=_DC62B409-3E9C-4F68-B426-33E20DC757C8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTet4kACgkQcqXauRfM
H+Ca+Q/+LYqqgMRYaFYpmdXBYcHYclVx9fmHb6zOLBD06yNV7BL9Nfq65dzZT/f8
ITMyncFmHr3w1SpQ9PLu71wNOcBrTkl3Z9tFc9GPlj/cLBNPEX371Ebv83C92TXo
pWdD5e33cHC7wewPTJQGvzRkc+5jzGySRrJhBvYqNEj9TPYpBxOUWWXJxSapjOVr
Yn3AkZFUsjnwUxp0+cQnrCIFMLH5xerVXzttQpkT0671fFwfFZvKwMnE8mEKMcA/
d94iTz1ihVlAUp1aNwlfUMy7k1m8E+oYbTdIuUWbpwvq2Xz+Oh4rE9JJrIKYsKGf
02NoQQ61XuwOPgT8dv1EvqiHoLggAJJk4qmksOyg5DqTIOWWn21+06cyS380rIFm
m0xsV7CEd43mOOgnHRa7WcwIv3t+mcHSjtd5LrEwtAazlhlzVcIw0MMTOm/AYnb7
LM2J1oO6dhM23N/S2H1ksAFVAYTrHTgRqBe+Prl5N/ndJnhjnad9/4ff3htzDx1X
+YZPFXQ7VeeWX7b3ZC86xhdsTd5QLgDOYw7H0AWCPv277mcd9HW5HM8c0jBt9mcY
T1qvI74B0LVF/FtXlDoNOtSbYnQATYoyIAdZvl+CgQGlrZYo08g5a2qFUrFdCJdh
r0Lebh/mqb6lSywteKOabE8eFRBr71u1FHSIOpnYOax9fuGeGng=
=mB8S
-----END PGP SIGNATURE-----

--Apple-Mail=_DC62B409-3E9C-4F68-B426-33E20DC757C8--
