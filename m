Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB47A5539
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 23:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjIRVrR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 17:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjIRVrQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 17:47:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57788E
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 14:47:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fbd31d9deso4592185b3a.3
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695073627; x=1695678427; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RV8zkwD3RKzOd6OysYXzgKeGXrBIBZWp7s2eTP1WoKU=;
        b=RPXncRzeCQaCTLyNbJz7FS0LY4uoxe2y47t/aJZhvu8j6cBpaqVVaYJq/W+ftOIOfS
         adp0abidoqByMogmfuQ3Zbao5YCm2mKlM2XmyY6aRQrixRxeAxGjnxiYZ1wwnjH3QfIO
         Os8py3v5nmr2dNnAOdvDPKbqL3Rli/cjp5l/8NQ92x/Bq6iCr4Qk/9JBViCPtNQ/IU1H
         5GE/oidSxBXkXRao6cXjLwJ5wmWzjWK1wpHCjH+3OtwMicVG1+Kg4R2ek63sLucKjz84
         4qYrcS09eI9FjyLu5cxWah8xmFC+A2J6z3a8Fciu/Ml5DgMu737vP5yEd4LNZQ60dxDa
         nvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695073627; x=1695678427;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RV8zkwD3RKzOd6OysYXzgKeGXrBIBZWp7s2eTP1WoKU=;
        b=DVjRpMzqTS2DrLO+2Nmjb6cOSh85X9uIOB+g3ZTFvBS3csgemuWCMJ7g5RCPlGQwcc
         H1W3AthFM79Pq1Fudxy27T/cHwnjc5eTuEApt2avVAKnOJ0+knajYRzJwxfpgaP0b3NW
         y3bbkdFCE2Ao4uXXj1Gbn58c5AySXcF7KdcIL/eIIsSlDInFFsKiHN7hxlZy9hVR1W4v
         anFCez7CAQfmdPwPFlw0WeuU1Gys0t0CwbUnnxaoXEQdxWJoqspd+qPNYhsV0WkDLFke
         BjMs6gBPHZr1FkHONH8c702Eud2OhPPcj7TLU+BiJPHZIDjhxLKpGvrMgzzgUNVGQY81
         Frug==
X-Gm-Message-State: AOJu0Yw38hQEuLpVjJiRTQ6N5/j7+RZaEb5qJAeSWapSZttEkuO+Eukj
        eB0MA4AJkDkXW+53MuFURtMovIItc67oBI/3hkQ=
X-Google-Smtp-Source: AGHT+IFWrY2kGL1JgelpNMRTNLgiTY+8+z3GsmPIFlUvKCjxVix4x7kMKGCSmBsF9oCboRCmmPb4yw==
X-Received: by 2002:a05:6a00:813:b0:68e:39b5:7e63 with SMTP id m19-20020a056a00081300b0068e39b57e63mr10751032pfk.16.1695073627199;
        Mon, 18 Sep 2023 14:47:07 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78e10000000b00682669dc19bsm7506549pfr.201.2023.09.18.14.47.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 14:47:06 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9470959E-7683-4834-A4F5-34093A600F37@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C1924739-5FDD-47A4-A413-6065C473C625";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] ext4: optimize metadata allocation for hybrid LUNs
Date:   Mon, 18 Sep 2023 15:47:04 -0600
In-Reply-To: <OS3P286MB056790B5527B8DD75F1B21B7AFF1A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
Cc:     linux-ext4@vger.kernel.org
To:     Bobi Jam <bobijam@hotmail.com>
References: <OS3P286MB056789DF4EBAA7363A4346B5AF06A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
 <OS3P286MB056790B5527B8DD75F1B21B7AFF1A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C1924739-5FDD-47A4-A413-6065C473C625
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 12, 2023, at 12:59 AM, Bobi Jam <bobijam@hotmail.com> wrote:
>=20
> With LVM it is possible to create an LV with SSD storage at the
> beginning of the LV and HDD storage at the end of the LV, and use that
> to separate ext4 metadata allocations (that need small random IOs)
> from data allocations (that are better suited for large sequential
> IOs) depending on the type of underlying storage.  Between 0.5-1.0% of
> the filesystem capacity would need to be high-IOPS storage in order to
> hold all of the internal metadata.
>=20
> This would improve performance for inode and other metadata access,
> such as ls, find, e2fsck, and in general improve file access latency,
> modification, truncate, unlink, transaction commit, etc.
>=20
> This patch split largest free order group lists and average fragment
> size lists into other two lists for IOPS/fast storage groups, and
> cr 0 / cr 1 group scanning for metadata block allocation in following
> order:
>=20
> if (allocate metadata blocks)
>      if (cr =3D=3D 0)
>              try to find group in largest free order IOPS group list
>      if (cr =3D=3D 1)
>              try to find group in fragment size IOPS group list
>      if (above two find failed)
>              fall through normal group lists as before
> if (allocate data blocks)
>      try to find group in normal group lists as before
>      if (failed to find group in normal group && mb_enable_iops_data)
>              try to find group in IOPS groups
>=20
> Non-metadata block allocation does not allocate from the IOPS groups
> if non-IOPS groups are not used up.

Hi Ritesh,
I believe this updated version of the patch addresses your original
request that it is possible to allocate blocks from the IOPS block
groups if the non-IOPS groups are full.  This is currently disabled
by default, because in cases where the IOPS groups make up only a
small fraction of the space (e.g. < 1% of total capacity) having data
blocks allocated from this space would not make a big improvement
to the end-user usage of the filesystem, but would semi-permanently
hurt the ability to allocate metadata into the IOPS groups.

We discussed on the ext4 concall various options to make this more
useful (e.g. allowing the root user to allocate from the IOPS groups
if the filesystem is out of space, having a heuristic to balance IOPS
vs. non-IOPS allocations for small files, having a BPF rule that can
specify which UID/GID/procname/filename/etc. can access this space,
but everyone was reluctant to put any complex policy into the kernel
to make any decision, since this eventually is wrong for some usage.

For now, there is just a simple on/off switch, and if this is enabled
the IOPS groups are only used when all of the non-IOPS groups are full.
Any more complex policy can be deferred to a separate patch, I think.

It has worked well so far in our testing.

Cheers, Andreas

> Add for mke2fs an option to mark which blocks are in the IOPS region
> of storage at format time (usually only one IOPS region is needed):
>=20
>  -E iops=3D0-1024G,4096-8192G
>=20
> so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
> group descriptors to decide which groups to allocate dynamic
> filesystem metadata.
>=20
> Signed-off-by: Bobi Jam <bobijam@hotmail.com
>=20
> --
> v2->v3: add sysfs mb_enable_iops_data to enable data block allocation
>        from IOPS groups.
> v1->v2: for metadata block allocation, search in IOPS list then normal
>        list.
> ---
> fs/ext4/balloc.c   |   2 +-
> fs/ext4/ext4.h     |  13 +++
> fs/ext4/extents.c  |   5 +-
> fs/ext4/indirect.c |   5 +-
> fs/ext4/mballoc.c  | 229 +++++++++++++++++++++++++++++++++++++++++----
> fs/ext4/sysfs.c    |   4 +
> 6 files changed, 234 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index c1edde817be8..7b1b3ec2650c 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -739,7 +739,7 @@ ext4_fsblk_t ext4_new_meta_blocks(handle_t =
*handle, struct inode *inode,
> 	ar.inode =3D inode;
> 	ar.goal =3D goal;
> 	ar.len =3D count ? *count : 1;
> -	ar.flags =3D flags;
> +	ar.flags =3D flags | EXT4_MB_HINT_METADATA;
>=20
> 	ret =3D ext4_mb_new_blocks(handle, &ar, errp);
> 	if (count)
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8104a21b001a..a8f21f63f5ff 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -382,6 +382,7 @@ struct flex_groups {
> #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use =
*/
> #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
> #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to =
zero */
> +#define EXT4_BG_IOPS		0x0010 /* In IOPS/fast storage */
>=20
> /*
>  * Macro-instructions used to manage group descriptors
> @@ -1112,6 +1113,8 @@ struct ext4_inode_info {
> #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in =
use */
> #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* to test =
development code */
>=20
> +#define EXT2_FLAGS_HAS_IOPS		0x0080	/* has IOPS storage */
> +
> /*
>  * Mount flags set via mount options or defaults
>  */
> @@ -1514,8 +1517,12 @@ struct ext4_sb_info {
> 	atomic_t s_retry_alloc_pending;
> 	struct list_head *s_mb_avg_fragment_size;
> 	rwlock_t *s_mb_avg_fragment_size_locks;
> +	struct list_head *s_avg_fragment_size_list_iops;  /* =
avg_frament_size for IOPS groups */
> +	rwlock_t *s_avg_fragment_size_locks_iops;
> 	struct list_head *s_mb_largest_free_orders;
> 	rwlock_t *s_mb_largest_free_orders_locks;
> +	struct list_head *s_largest_free_orders_list_iops; /* =
largest_free_orders for IOPS grps */
> +	rwlock_t *s_largest_free_orders_locks_iops;
>=20
> 	/* tunables */
> 	unsigned long s_stripe;
> @@ -1532,6 +1539,7 @@ struct ext4_sb_info {
> 	unsigned long s_mb_last_start;
> 	unsigned int s_mb_prefetch;
> 	unsigned int s_mb_prefetch_limit;
> +	unsigned int s_mb_enable_iops_data;
>=20
> 	/* stats for buddy allocator */
> 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
> @@ -3366,6 +3374,7 @@ struct ext4_group_info {
> #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
> 	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
> #define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
> +#define EXT4_GROUP_INFO_IOPS_BIT		5
>=20
> #define EXT4_MB_GRP_NEED_INIT(grp)	\
> 	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
> @@ -3382,6 +3391,10 @@ struct ext4_group_info {
> 	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> #define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
> 	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, =
&((grp)->bb_state)))
> +#define EXT4_MB_GRP_TEST_IOPS(grp)	\
> +	(test_bit(EXT4_GROUP_INFO_IOPS_BIT, &((grp)->bb_state)))
> +#define EXT4_MB_GRP_SET_IOPS(grp)	\
> +	(set_bit(EXT4_GROUP_INFO_IOPS_BIT, &((grp)->bb_state)))
>=20
> #define EXT4_MAX_CONTENTION		8
> #define EXT4_CONTENTION_THRESHOLD	2
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 35703dce23a3..6bfa784a3dad 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4272,11 +4272,12 @@ int ext4_ext_map_blocks(handle_t *handle, =
struct inode *inode,
> 	ar.len =3D EXT4_NUM_B2C(sbi, offset+allocated);
> 	ar.goal -=3D offset;
> 	ar.logical -=3D offset;
> -	if (S_ISREG(inode->i_mode))
> +	if (S_ISREG(inode->i_mode) &&
> +	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
> 		ar.flags =3D EXT4_MB_HINT_DATA;
> 	else
> 		/* disable in-core preallocation for non-regular files =
*/
> -		ar.flags =3D 0;
> +		ar.flags =3D EXT4_MB_HINT_METADATA;
> 	if (flags & EXT4_GET_BLOCKS_NO_NORMALIZE)
> 		ar.flags |=3D EXT4_MB_HINT_NOPREALLOC;
> 	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index c68bebe7ff4b..e1042c4e8ce6 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -610,8 +610,11 @@ int ext4_ind_map_blocks(handle_t *handle, struct =
inode *inode,
> 	memset(&ar, 0, sizeof(ar));
> 	ar.inode =3D inode;
> 	ar.logical =3D map->m_lblk;
> -	if (S_ISREG(inode->i_mode))
> +	if (S_ISREG(inode->i_mode) &&
> +	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
> 		ar.flags =3D EXT4_MB_HINT_DATA;
> +	else
> +		ar.flags =3D EXT4_MB_HINT_METADATA;
> 	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
> 		ar.flags |=3D EXT4_MB_DELALLOC_RESERVED;
> 	if (flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 20f67a260df5..a676d26eccbc 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -828,6 +828,8 @@ static void
> mb_update_avg_fragment_size(struct super_block *sb, struct =
ext4_group_info *grp)
> {
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	rwlock_t *afs_locks;
> +	struct list_head *afs_list;
> 	int new_order;
>=20
> 	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free =3D=3D 0)
> @@ -838,20 +840,24 @@ mb_update_avg_fragment_size(struct super_block =
*sb, struct ext4_group_info *grp)
> 	if (new_order =3D=3D grp->bb_avg_fragment_size_order)
> 		return;
>=20
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> +	    EXT4_MB_GRP_TEST_IOPS(grp)) {
> +		afs_locks =3D sbi->s_avg_fragment_size_locks_iops;
> +		afs_list =3D sbi->s_avg_fragment_size_list_iops;
> +	} else {
> +		afs_locks =3D sbi->s_mb_avg_fragment_size_locks;
> +		afs_list =3D sbi->s_mb_avg_fragment_size;
> +	}
> +
> 	if (grp->bb_avg_fragment_size_order !=3D -1) {
> -		write_lock(&sbi->s_mb_avg_fragment_size_locks[
> -					=
grp->bb_avg_fragment_size_order]);
> +		write_lock(&afs_locks[grp->bb_avg_fragment_size_order]);
> 		list_del(&grp->bb_avg_fragment_size_node);
> -		write_unlock(&sbi->s_mb_avg_fragment_size_locks[
> -					=
grp->bb_avg_fragment_size_order]);
> +		=
write_unlock(&afs_locks[grp->bb_avg_fragment_size_order]);
> 	}
> 	grp->bb_avg_fragment_size_order =3D new_order;
> -	write_lock(&sbi->s_mb_avg_fragment_size_locks[
> -					=
grp->bb_avg_fragment_size_order]);
> -	list_add_tail(&grp->bb_avg_fragment_size_node,
> -		=
&sbi->s_mb_avg_fragment_size[grp->bb_avg_fragment_size_order]);
> -	write_unlock(&sbi->s_mb_avg_fragment_size_locks[
> -					=
grp->bb_avg_fragment_size_order]);
> +	write_lock(&afs_locks[new_order]);
> +	list_add_tail(&grp->bb_avg_fragment_size_node, =
&afs_list[new_order]);
> +	write_unlock(&afs_locks[new_order]);
> }
>=20
> /*
> @@ -986,6 +992,95 @@ next_linear_group(struct ext4_allocation_context =
*ac, int group, int ngroups)
> 	return group + 1 >=3D ngroups ? 0 : group + 1;
> }
>=20
> +static bool ext4_mb_choose_next_iops_group_cr0(
> +			struct ext4_allocation_context *ac, ext4_group_t =
*group)
> +{
> +	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> +	struct ext4_group_info *iter, *grp;
> +	int i;
> +
> +	if (unlikely(sbi->s_mb_stats && ac->ac_flags & =
EXT4_MB_CR0_OPTIMIZED))
> +		atomic_inc(&sbi->s_bal_cr0_bad_suggestions);
> +
> +	grp =3D NULL;
> +	for (i =3D ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> +		if =
(list_empty(&sbi->s_largest_free_orders_list_iops[i]))
> +			continue;
> +		read_lock(&sbi->s_largest_free_orders_locks_iops[i]);
> +		if =
(list_empty(&sbi->s_largest_free_orders_list_iops[i])) {
> +			=
read_unlock(&sbi->s_largest_free_orders_locks_iops[i]);
> +			continue;
> +		}
> +		grp =3D NULL;
> +		list_for_each_entry(iter,
> +				    =
&sbi->s_largest_free_orders_list_iops[i],
> +				    bb_largest_free_order_node) {
> +			if (sbi->s_mb_stats)
> +				=
atomic64_inc(&sbi->s_bal_cX_groups_considered[0]);
> +			if (likely(ext4_mb_good_group(ac, =
iter->bb_group, 0))) {
> +				grp =3D iter;
> +				break;
> +			}
> +		}
> +		read_unlock(&sbi->s_largest_free_orders_locks_iops[i]);
> +		if (grp)
> +			break;
> +	}
> +
> +	if (grp) {
> +		*group =3D grp->bb_group;
> +		ac->ac_flags |=3D EXT4_MB_CR0_OPTIMIZED;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool ext4_mb_choose_next_iops_group_cr1(
> +			struct ext4_allocation_context *ac, ext4_group_t =
*group)
> +{
> +	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> +	struct ext4_group_info *grp =3D NULL, *iter;
> +	int i;
> +
> +	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
> +		if (sbi->s_mb_stats)
> +			atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
> +	}
> +
> +	for (i =3D mb_avg_fragment_size_order(ac->ac_sb, =
ac->ac_g_ex.fe_len);
> +	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> +		if (list_empty(&sbi->s_avg_fragment_size_list_iops[i]))
> +			continue;
> +		read_lock(&sbi->s_avg_fragment_size_locks_iops[i]);
> +		if (list_empty(&sbi->s_avg_fragment_size_list_iops[i])) =
{
> +			=
read_unlock(&sbi->s_avg_fragment_size_locks_iops[i]);
> +			continue;
> +		}
> +		list_for_each_entry(iter,
> +				    =
&sbi->s_avg_fragment_size_list_iops[i],
> +				    bb_avg_fragment_size_node) {
> +			if (sbi->s_mb_stats)
> +				=
atomic64_inc(&sbi->s_bal_cX_groups_considered[1]);
> +			if (likely(ext4_mb_good_group(ac, =
iter->bb_group, 1))) {
> +				grp =3D iter;
> +				break;
> +			}
> +		}
> +		read_unlock(&sbi->s_avg_fragment_size_locks_iops[i]);
> +		if (grp)
> +			break;
> +	}
> +
> +	if (grp) {
> +		*group =3D grp->bb_group;
> +		ac->ac_flags |=3D EXT4_MB_CR1_OPTIMIZED;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> /*
>  * ext4_mb_choose_next_group: choose next group for allocation.
>  *
> @@ -1002,6 +1097,10 @@ next_linear_group(struct =
ext4_allocation_context *ac, int group, int ngroups)
> static void ext4_mb_choose_next_group(struct ext4_allocation_context =
*ac,
> 		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> {
> +	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> +	bool alloc_metadata =3D ac->ac_flags & EXT4_MB_HINT_METADATA;
> +	bool ret =3D false;
> +
> 	*new_cr =3D ac->ac_criteria;
>=20
> 	if (!should_optimize_scan(ac) || ac->ac_groups_linear_remaining) =
{
> @@ -1009,11 +1108,37 @@ static void ext4_mb_choose_next_group(struct =
ext4_allocation_context *ac,
> 		return;
> 	}
>=20
> +	if (alloc_metadata && sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) =
{
> +		if (*new_cr =3D=3D 0)
> +			ret =3D ext4_mb_choose_next_iops_group_cr0(ac, =
group);
> +		if (!ret && *new_cr < 2)
> +			ret =3D ext4_mb_choose_next_iops_group_cr1(ac, =
group);
> +		if (ret)
> +			return;
> +		/*
> +		 * Cannot get metadata group from IOPS storage, fall =
through
> +		 * to slow storage.
> +		 */
> +		cond_resched();
> +	}
> +
> 	if (*new_cr =3D=3D 0) {
> 		ext4_mb_choose_next_group_cr0(ac, new_cr, group, =
ngroups);
> 	} else if (*new_cr =3D=3D 1) {
> 		ext4_mb_choose_next_group_cr1(ac, new_cr, group, =
ngroups);
> 	} else {
> +		/*
> +		 * Cannot get data group from slow storage, try IOPS =
storage
> +		 */
> +		if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> +		    !alloc_metadata && sbi->s_mb_enable_iops_data &&
> +		    *new_cr =3D=3D 3) {
> +			if (ac->ac_2order)
> +				ret =3D =
ext4_mb_choose_next_iops_group_cr0(ac,
> +									 =
group);
> +			if (!ret)
> +				ext4_mb_choose_next_iops_group_cr1(ac, =
group);
> +		}
> 		/*
> 		 * TODO: For CR=3D2, we can arrange groups in an rb tree =
sorted by
> 		 * bb_free. But until that happens, we should never come =
here.
> @@ -1030,6 +1155,8 @@ static void
> mb_set_largest_free_order(struct super_block *sb, struct =
ext4_group_info *grp)
> {
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	rwlock_t *lfo_locks;
> +	struct list_head *lfo_list;
> 	int i;
>=20
> 	for (i =3D MB_NUM_ORDERS(sb) - 1; i >=3D 0; i--)
> @@ -1042,21 +1169,25 @@ mb_set_largest_free_order(struct super_block =
*sb, struct ext4_group_info *grp)
> 		return;
> 	}
>=20
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> +	    EXT4_MB_GRP_TEST_IOPS(grp)) {
> +		lfo_locks =3D sbi->s_largest_free_orders_locks_iops;
> +		lfo_list =3D sbi->s_largest_free_orders_list_iops;
> +	} else {
> +		lfo_locks =3D sbi->s_mb_largest_free_orders_locks;
> +		lfo_list =3D sbi->s_mb_largest_free_orders;
> +	}
> +
> 	if (grp->bb_largest_free_order >=3D 0) {
> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
> -					      =
grp->bb_largest_free_order]);
> +		write_lock(&lfo_locks[grp->bb_largest_free_order]);
> 		list_del_init(&grp->bb_largest_free_order_node);
> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
> -					      =
grp->bb_largest_free_order]);
> +		write_unlock(&lfo_locks[grp->bb_largest_free_order]);
> 	}
> 	grp->bb_largest_free_order =3D i;
> 	if (grp->bb_largest_free_order >=3D 0 && grp->bb_free) {
> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
> -					      =
grp->bb_largest_free_order]);
> -		list_add_tail(&grp->bb_largest_free_order_node,
> -		      =
&sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
> -					      =
grp->bb_largest_free_order]);
> +		write_lock(&lfo_locks[i]);
> +		list_add_tail(&grp->bb_largest_free_order_node, =
&lfo_list[i]);
> +		write_unlock(&lfo_locks[i]);
> 	}
> }
>=20
> @@ -2498,6 +2629,10 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
> 		goto out;
> 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
> 		goto out;
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> +	    (ac->ac_flags & EXT4_MB_HINT_DATA) && =
EXT4_MB_GRP_TEST_IOPS(grp) &&
> +	    !sbi->s_mb_enable_iops_data)
> +		goto out;
> 	if (should_lock) {
> 		__acquire(ext4_group_lock_ptr(sb, group));
> 		ext4_unlock_group(sb, group);
> @@ -3150,6 +3285,9 @@ int ext4_mb_add_groupinfo(struct super_block =
*sb, ext4_group_t group,
> 	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
> 	init_rwsem(&meta_group_info[i]->alloc_sem);
> 	meta_group_info[i]->bb_free_root =3D RB_ROOT;
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> +	    desc->bg_flags & EXT4_BG_IOPS)
> +		EXT4_MB_GRP_SET_IOPS(meta_group_info[i]);
> 	INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
> 	INIT_LIST_HEAD(&meta_group_info[i]->bb_avg_fragment_size_node);
> 	meta_group_info[i]->bb_largest_free_order =3D -1;  /* uninit */
> @@ -3423,6 +3561,26 @@ int ext4_mb_init(struct super_block *sb)
> 		INIT_LIST_HEAD(&sbi->s_mb_avg_fragment_size[i]);
> 		rwlock_init(&sbi->s_mb_avg_fragment_size_locks[i]);
> 	}
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) {
> +		sbi->s_avg_fragment_size_list_iops =3D
> +			kmalloc_array(MB_NUM_ORDERS(sb),
> +				      sizeof(struct list_head), =
GFP_KERNEL);
> +		if (!sbi->s_avg_fragment_size_list_iops) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
> +		sbi->s_avg_fragment_size_locks_iops =3D
> +			kmalloc_array(MB_NUM_ORDERS(sb), =
sizeof(rwlock_t),
> +				      GFP_KERNEL);
> +		if (!sbi->s_avg_fragment_size_locks_iops) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
> +		for (i =3D 0; i < MB_NUM_ORDERS(sb); i++) {
> +			=
INIT_LIST_HEAD(&sbi->s_avg_fragment_size_list_iops[i]);
> +			=
rwlock_init(&sbi->s_avg_fragment_size_locks_iops[i]);
> +		}
> +	}
> 	sbi->s_mb_largest_free_orders =3D
> 		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct =
list_head),
> 			GFP_KERNEL);
> @@ -3441,6 +3599,27 @@ int ext4_mb_init(struct super_block *sb)
> 		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
> 		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
> 	}
> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) {
> +		sbi->s_largest_free_orders_list_iops =3D
> +			kmalloc_array(MB_NUM_ORDERS(sb),
> +				      sizeof(struct list_head), =
GFP_KERNEL);
> +		if (!sbi->s_largest_free_orders_list_iops) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
> +		sbi->s_largest_free_orders_locks_iops =3D
> +			kmalloc_array(MB_NUM_ORDERS(sb), =
sizeof(rwlock_t),
> +				      GFP_KERNEL);
> +		if (!sbi->s_largest_free_orders_locks_iops) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
> +		for (i =3D 0; i < MB_NUM_ORDERS(sb); i++) {
> +			INIT_LIST_HEAD(
> +				=
&sbi->s_largest_free_orders_list_iops[i]);
> +			=
rwlock_init(&sbi->s_largest_free_orders_locks_iops[i]);
> +		}
> +	}
>=20
> 	spin_lock_init(&sbi->s_md_lock);
> 	sbi->s_mb_free_pending =3D 0;
> @@ -3481,6 +3660,8 @@ int ext4_mb_init(struct super_block *sb)
> 			sbi->s_mb_group_prealloc, sbi->s_stripe);
> 	}
>=20
> +	sbi->s_mb_enable_iops_data =3D 0;
> +
> 	sbi->s_locality_groups =3D alloc_percpu(struct =
ext4_locality_group);
> 	if (sbi->s_locality_groups =3D=3D NULL) {
> 		ret =3D -ENOMEM;
> @@ -3512,8 +3693,12 @@ int ext4_mb_init(struct super_block *sb)
> out:
> 	kfree(sbi->s_mb_avg_fragment_size);
> 	kfree(sbi->s_mb_avg_fragment_size_locks);
> +	kfree(sbi->s_avg_fragment_size_list_iops);
> +	kfree(sbi->s_avg_fragment_size_locks_iops);
> 	kfree(sbi->s_mb_largest_free_orders);
> 	kfree(sbi->s_mb_largest_free_orders_locks);
> +	kfree(sbi->s_largest_free_orders_list_iops);
> +	kfree(sbi->s_largest_free_orders_locks_iops);
> 	kfree(sbi->s_mb_offsets);
> 	sbi->s_mb_offsets =3D NULL;
> 	kfree(sbi->s_mb_maxs);
> @@ -3582,8 +3767,12 @@ int ext4_mb_release(struct super_block *sb)
> 	}
> 	kfree(sbi->s_mb_avg_fragment_size);
> 	kfree(sbi->s_mb_avg_fragment_size_locks);
> +	kfree(sbi->s_avg_fragment_size_list_iops);
> +	kfree(sbi->s_avg_fragment_size_locks_iops);
> 	kfree(sbi->s_mb_largest_free_orders);
> 	kfree(sbi->s_mb_largest_free_orders_locks);
> +	kfree(sbi->s_largest_free_orders_list_iops);
> +	kfree(sbi->s_largest_free_orders_locks_iops);
> 	kfree(sbi->s_mb_offsets);
> 	kfree(sbi->s_mb_maxs);
> 	iput(sbi->s_buddy_cache);
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 3042bc605bbf..86ab6c4ed3b8 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -245,6 +245,7 @@ EXT4_ATTR(journal_task, 0444, journal_task);
> EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
> EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
> EXT4_RW_ATTR_SBI_UL(last_trim_minblks, s_last_trim_minblks);
> +EXT4_RW_ATTR_SBI_UI(mb_enable_iops_data, s_mb_enable_iops_data);
>=20
> static unsigned int old_bump_val =3D 128;
> EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -295,6 +296,7 @@ static struct attribute *ext4_attrs[] =3D {
> 	ATTR_LIST(mb_prefetch),
> 	ATTR_LIST(mb_prefetch_limit),
> 	ATTR_LIST(last_trim_minblks),
> +	ATTR_LIST(mb_enable_iops_data),
> 	NULL,
> };
> ATTRIBUTE_GROUPS(ext4);
> @@ -318,6 +320,7 @@ EXT4_ATTR_FEATURE(fast_commit);
> #if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
> EXT4_ATTR_FEATURE(encrypted_casefold);
> #endif
> +EXT4_ATTR_FEATURE(iops);
>=20
> static struct attribute *ext4_feat_attrs[] =3D {
> 	ATTR_LIST(lazy_itable_init),
> @@ -338,6 +341,7 @@ static struct attribute *ext4_feat_attrs[] =3D {
> #if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
> 	ATTR_LIST(encrypted_casefold),
> #endif
> +	ATTR_LIST(iops),
> 	NULL,
> };
> ATTRIBUTE_GROUPS(ext4_feat);
> --
> 2.42.0
>=20


Cheers, Andreas






--Apple-Mail=_C1924739-5FDD-47A4-A413-6065C473C625
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUIxVgACgkQcqXauRfM
H+AhiQ/+I4vSwRP4fXFZrNX64VeIWsTgLTYwXvyrtHc++4Axs8KV15z6lgftFySV
WN3ECJJhinzCYB7YJDLSyDNU+Nt1U63XtCxyEp5sIbWkY+s1MBEG6NhDkzOesRX8
xZrYYPlSZq3VTIkBRBudsSPXzr7Cqek7h53udTIr4cc9qCYp7q9Ya3Q2t0oFkVBw
OkfUo3kM913BJup8ZjbT4w2FQY1egStYmj+CiogoWU/tqMNVcIscaBxd0RZRKiHl
EjJGmL8xGtcQV+C1cgCFoLBdg4Qcy2ZODtsbf4VqZ0olQ99SDjJr/sYBtSPTH0hd
yo4dj+Ve+Ux0HHRNZ28OzRhzt6W03hFjPHxfRWx8XGgoXn0YbsG1SFOn46B2NBnc
cF1FZDO4ZEaekh7BaZ/48MfgLwQNIHAge0f+FOMfnCUg9rLUKisVVX9rHFbpm3SM
XHUpB3vR3vZnzwYgKIgOBJe/BVxKAZrd0NvAAbJXhleSUhvLZ9+36y/FWvrVmK1r
paWBJnuU+wCdhDrZNwof5P2KH75x1p+8ihiTN0rhXxA8J/TAHwEBW1tx1uG80kzl
Q9jqys52A74m2HB53g+1gZvm1Xmrwwl8AkMKfeBRForjdoInvrod1RB2MmoKLss9
NK6ArtP83TlleSHYMh5aLY2aXX0DALxern9cUj0ygr4zvJpCHO4=
=X6cc
-----END PGP SIGNATURE-----

--Apple-Mail=_C1924739-5FDD-47A4-A413-6065C473C625--
