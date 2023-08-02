Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D123976DB66
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 01:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjHBXR1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 19:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHBXRX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 19:17:23 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2991FED
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 16:16:50 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bc9de53ee2so362527a34.2
        for <linux-ext4@vger.kernel.org>; Wed, 02 Aug 2023 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1691018209; x=1691623009;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=krDJeQS41Nk6fuWYzP2NFQhqjYNG3cqxOEfauSbAbWY=;
        b=oaYt4iRgvBqglG2WnGBnQ1bOiVrENqcbSEdJKKZrOZdCbXmdY4567Rnsi9NmTREZ6L
         u0Ao9wKqfVeSYASKyZIZvSlrE/jEbtfoXJy80OmuG1LMbrE3yU4KIiui8MwG/V/MYhzZ
         HlccT/yuZE7YnJX96m7rc+g/ZyUmiw7A8xFl4b70SW+DTyYfBaxZ674UaBE7OsEYfTex
         jaBpWDrqwtW3q5tKNQpKCHTpfMYY4N8k9oW09Qfvx7jBhvNvVG3hZ2LyD/3ezVPSTmND
         mRBUxOuuS/q3p/f/cltKPIco4t1eQzvAfmQD0c4UROVHHXgH0hDM/QT3FeEkmPb8twFm
         jfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691018209; x=1691623009;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krDJeQS41Nk6fuWYzP2NFQhqjYNG3cqxOEfauSbAbWY=;
        b=FP8uetMGwM25kLN0b+doG0/Px3233l98kDmACWP/yDLU2raMMca5y9APr7i9FP7XXR
         ZA0BNjmb6fy5AqUM7hSRM9cpXTmGjpgAbBLK9vtnywC9Ltb3ae47QmtSpXVxPBcNnCYR
         lTCjB62OGtUwc+nzoVnGO/KhmopFYVsQ9ugm92xANI+ur1UiQelP9gebzzFbquuaC8yB
         iHDesCF6hF8jYz/JK1RDFdEclTpzVWEAGkHcufgm+5jp+aGD7PTJOi0073TsMwvDRFSp
         ikhzPwN78Dd8OxMqZUz8aSUgLrr1a8IEWJyVTrl3GAE9dDMw259Bmz8k0FcOAcGSHYsT
         dFxw==
X-Gm-Message-State: ABy/qLYWTk7OAKK8GauXYU733bf86fBr3M82U1oxOipBDHs93xHmVeY9
        TUObBM+PMuCgIRmr4YJf8QfsxA==
X-Google-Smtp-Source: APBJJlE6fMUZ5ISX5Q+0J1ohoKR+0R+3lDdf+P3tK6idZLsnnwi0oFnAjyDyssxmSF8pEHu9eRbUWA==
X-Received: by 2002:a05:6830:14d8:b0:6bc:c542:6f75 with SMTP id t24-20020a05683014d800b006bcc5426f75mr1014519otq.0.1691018209106;
        Wed, 02 Aug 2023 16:16:49 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z136-20020a63338e000000b0056001f43726sm11974436pgz.92.2023.08.02.16.16.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2023 16:16:48 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8059282C-0191-4F78-B58D-761C5AD09D02@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7CE6C640-C232-4BB9-90DF-43C64BE9D107";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: optimize metadata allocation for hybrid LUNs
Date:   Wed, 2 Aug 2023 17:16:45 -0600
In-Reply-To: <OS3P286MB056789DF4EBAA7363A4346B5AF06A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Bobi Jam <bobijam@hotmail.com>,
        Roberto Ragusa <mail@robertoragusa.it>
To:     Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
References: <OS3P286MB056789DF4EBAA7363A4346B5AF06A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_7CE6C640-C232-4BB9-90DF-43C64BE9D107
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 27, 2023, at 5:45 PM, Bobi Jam <bobijam@hotmail.com> wrote:
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
> cr 0 on largest free order IOPS group list
> cr 1 on average fragment size IOPS group list
> cr 0 on largest free order non-IOPS group list
> cr 1 on average fragment size non-IOPS group list
> cr >=3D 2 perform the linear search as before
>=20
> Non-metadata block allocation does not allocate from the IOPS groups.
>=20
> Add for mke2fs an option to mark which blocks are in the IOPS region
> of storage at format time:
>=20
>  -E iops=3D0-1024G,4096-8192G
>=20
> so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
> group descriptors to decide which groups to allocate dynamic =
filesystem
> metadata.

Ted, Ritesh, Ojaswin,
I would appreciate your review and comments on these two patches.

They are a followup to the discussion about hybrid LVM devices  a few
weeks ago in https://www.spinics.net/lists/linux-ext4/msg90237.html
"packed_meta_blocks=3D1 incompatible with resize2fs?".

The 2/2 patch adds an option to mke2fs to mark groups on the SSD/NVMe
storage with the "EXT4_BG_IOPS" flag.  Together with mke2fs using the
existing sparse_super2, flex_bg, and packed_meta_blocks, this would
allocate all static metadata to the start of the device.  The 1/2 patch
changes mballoc to keep two separate allocation lists/trees based on
the IOPS flag on each group.

This has the dual benefit that all filesystem metadata (typically 4KiB
fragmented allocation/read/write) is on fast storage, and these blocks
also do not interfere with (usually larger) data allocation/read/write
(both in terms of allocation fragmentation and contending IOPS/seeks).
This should help both normal IO usage, as well as e2fsck significantly
(virtually all e2fsck IO would go to the SSD/NVMe storage).


The implementation is relatively simple as you can see.  Currently it
has a flag in the superblock to indicate that IOPS groups are available
during block allocation, but even that is not strictly needed (it could
be detected at GDT reading time).  Metadata allocations prefer to use
the IOPS groups (if available), otherwise fall back to regular groups.

For our usage, this is a "soft" feature that does not affect =
compatibility.
It would be mostly harmless if the filesystem was mounted with an older
kernel.  At worst some performance loss that would disappear again over
time, but this would happen rarely I think.


This doesn't *directly* address filesystem resize that Roberto was =
asking
about, but having IOPS groups used only for metadata would make it =
easier
to resize later (if only adding HDD capacity).  Alternately, because the
individual groups are marked with the IOPS flag, a second (third, =
fourth)
flash region could be added at the end of the current filesystem to hold
the new bitmaps and inode tables would be relatively straight forward to
add on top of this.  There might be some work needed for mke2fs to honor
the "resize" option with packed_meta_blocks, but maybe not much more.

We basically never resize filesystems, so this is not of any interest to
implement at this point.

Cheers, Andreas

> Signed-off-by: Bobi Jam <bobijam@hotmail.com>
> ---
> fs/ext4/balloc.c  |   2 +-
> fs/ext4/ext4.h    |  12 +++++
> fs/ext4/mballoc.c | 154 =
++++++++++++++++++++++++++++++++++++++++++------------
> 3 files changed, 134 insertions(+), 34 deletions(-)
>=20
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index c1edde8..7b1b3ec 100644
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
> index 8104a21..3444b6e 100644
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
> @@ -3366,6 +3373,7 @@ struct ext4_group_info {
> #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
> 	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
> #define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
> +#define EXT4_GROUP_INFO_IOPS_BIT		5
>=20
> #define EXT4_MB_GRP_NEED_INIT(grp)	\
> 	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
> @@ -3382,6 +3390,10 @@ struct ext4_group_info {
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
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 20f67a2..6d218af 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -828,6 +828,8 @@ static int mb_avg_fragment_size_order(struct =
super_block *sb, ext4_grpblk_t len)
> mb_update_avg_fragment_size(struct super_block *sb, struct =
ext4_group_info *grp)
> {
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	rwlock_t *afs_locks;
> +	struct list_head *afs_list;
> 	int new_order;
>=20
> 	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free =3D=3D 0)
> @@ -838,20 +840,23 @@ static int mb_avg_fragment_size_order(struct =
super_block *sb, ext4_grpblk_t len)
> 	if (new_order =3D=3D grp->bb_avg_fragment_size_order)
> 		return;
>=20
> +	if (EXT4_MB_GRP_TEST_IOPS(grp)) {
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
> @@ -863,6 +868,10 @@ static void ext4_mb_choose_next_group_cr0(struct =
ext4_allocation_context *ac,
> {
> 	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> 	struct ext4_group_info *iter, *grp;
> +	bool iops =3D ac->ac_flags & EXT4_MB_HINT_METADATA &&
> +		    ac->ac_sb->s_flags & EXT2_FLAGS_HAS_IOPS;
> +	rwlock_t *lfo_locks;
> +	struct list_head *lfo_list;
> 	int i;
>=20
> 	if (ac->ac_status =3D=3D AC_STATUS_FOUND)
> @@ -871,17 +880,25 @@ static void ext4_mb_choose_next_group_cr0(struct =
ext4_allocation_context *ac,
> 	if (unlikely(sbi->s_mb_stats && ac->ac_flags & =
EXT4_MB_CR0_OPTIMIZED))
> 		atomic_inc(&sbi->s_bal_cr0_bad_suggestions);
>=20
> +	if (iops) {
> +		lfo_locks =3D sbi->s_largest_free_orders_locks_iops;
> +		lfo_list =3D sbi->s_largest_free_orders_list_iops;
> +	} else {
> +		lfo_locks =3D sbi->s_mb_largest_free_orders_locks;
> +		lfo_list =3D sbi->s_mb_largest_free_orders;
> +	}
> +
> 	grp =3D NULL;
> 	for (i =3D ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> -		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
> +		if (list_empty(&lfo_list[i]))
> 			continue;
> -		read_lock(&sbi->s_mb_largest_free_orders_locks[i]);
> -		if (list_empty(&sbi->s_mb_largest_free_orders[i])) {
> -			=
read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> +		read_lock(&lfo_locks[i]);
> +		if (list_empty(&lfo_list[i])) {
> +			read_unlock(&lfo_locks[i]);
> 			continue;
> 		}
> 		grp =3D NULL;
> -		list_for_each_entry(iter, =
&sbi->s_mb_largest_free_orders[i],
> +		list_for_each_entry(iter, &lfo_list[i],
> 				    bb_largest_free_order_node) {
> 			if (sbi->s_mb_stats)
> 				=
atomic64_inc(&sbi->s_bal_cX_groups_considered[0]);
> @@ -890,7 +907,7 @@ static void ext4_mb_choose_next_group_cr0(struct =
ext4_allocation_context *ac,
> 				break;
> 			}
> 		}
> -		read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> +		read_unlock(&lfo_locks[i]);
> 		if (grp)
> 			break;
> 	}
> @@ -913,6 +930,10 @@ static void ext4_mb_choose_next_group_cr1(struct =
ext4_allocation_context *ac,
> {
> 	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> 	struct ext4_group_info *grp =3D NULL, *iter;
> +	bool iops =3D ac->ac_flags & EXT4_MB_HINT_METADATA &&
> +		    ac->ac_sb->s_flags & EXT2_FLAGS_HAS_IOPS;
> +	rwlock_t *afs_locks;
> +	struct list_head *afs_list;
> 	int i;
>=20
> 	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
> @@ -920,16 +941,24 @@ static void ext4_mb_choose_next_group_cr1(struct =
ext4_allocation_context *ac,
> 			atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
> 	}
>=20
> +	if (iops) {
> +		afs_locks =3D sbi->s_avg_fragment_size_locks_iops;
> +		afs_list =3D sbi->s_avg_fragment_size_list_iops;
> +	} else {
> +		afs_locks =3D sbi->s_mb_avg_fragment_size_locks;
> +		afs_list =3D sbi->s_mb_avg_fragment_size;
> +	}
> +
> 	for (i =3D mb_avg_fragment_size_order(ac->ac_sb, =
ac->ac_g_ex.fe_len);
> 	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> -		if (list_empty(&sbi->s_mb_avg_fragment_size[i]))
> +		if (list_empty(&afs_list[i]))
> 			continue;
> -		read_lock(&sbi->s_mb_avg_fragment_size_locks[i]);
> -		if (list_empty(&sbi->s_mb_avg_fragment_size[i])) {
> -			=
read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
> +		read_lock(&afs_locks[i]);
> +		if (list_empty(&afs_list[i])) {
> +			read_unlock(&afs_locks[i]);
> 			continue;
> 		}
> -		list_for_each_entry(iter, =
&sbi->s_mb_avg_fragment_size[i],
> +		list_for_each_entry(iter, &afs_list[i],
> 				    bb_avg_fragment_size_node) {
> 			if (sbi->s_mb_stats)
> 				=
atomic64_inc(&sbi->s_bal_cX_groups_considered[1]);
> @@ -938,7 +967,7 @@ static void ext4_mb_choose_next_group_cr1(struct =
ext4_allocation_context *ac,
> 				break;
> 			}
> 		}
> -		read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
> +		read_unlock(&afs_locks[i]);
> 		if (grp)
> 			break;
> 	}
> @@ -947,7 +976,15 @@ static void ext4_mb_choose_next_group_cr1(struct =
ext4_allocation_context *ac,
> 		*group =3D grp->bb_group;
> 		ac->ac_flags |=3D EXT4_MB_CR1_OPTIMIZED;
> 	} else {
> -		*new_cr =3D 2;
> +		if (iops) {
> +			/* cannot find proper group in IOPS storage,
> +			 * fall back to cr0 for non-IOPS groups.
> +			 */
> +			ac->ac_flags &=3D ~EXT4_MB_HINT_METADATA;
> +			*new_cr =3D 0;
> +		} else {
> +			*new_cr =3D 2;
> +		}
> 	}
> }
>=20
> @@ -1030,6 +1067,8 @@ static void ext4_mb_choose_next_group(struct =
ext4_allocation_context *ac,
> mb_set_largest_free_order(struct super_block *sb, struct =
ext4_group_info *grp)
> {
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	rwlock_t *lfo_locks;
> +	struct list_head *lfo_list;
> 	int i;
>=20
> 	for (i =3D MB_NUM_ORDERS(sb) - 1; i >=3D 0; i--)
> @@ -1042,21 +1081,24 @@ static void ext4_mb_choose_next_group(struct =
ext4_allocation_context *ac,
> 		return;
> 	}
>=20
> +	if (EXT4_MB_GRP_TEST_IOPS(grp)) {
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
> @@ -3150,6 +3192,8 @@ int ext4_mb_add_groupinfo(struct super_block =
*sb, ext4_group_t group,
> 	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
> 	init_rwsem(&meta_group_info[i]->alloc_sem);
> 	meta_group_info[i]->bb_free_root =3D RB_ROOT;
> +	if (desc->bg_flags & EXT4_BG_IOPS)
> +		EXT4_MB_GRP_SET_IOPS(meta_group_info[i]);
> 	INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
> 	INIT_LIST_HEAD(&meta_group_info[i]->bb_avg_fragment_size_node);
> 	meta_group_info[i]->bb_largest_free_order =3D -1;  /* uninit */
> @@ -3423,6 +3467,24 @@ int ext4_mb_init(struct super_block *sb)
> 		INIT_LIST_HEAD(&sbi->s_mb_avg_fragment_size[i]);
> 		rwlock_init(&sbi->s_mb_avg_fragment_size_locks[i]);
> 	}
> +	sbi->s_avg_fragment_size_list_iops =3D
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct =
list_head),
> +			      GFP_KERNEL);
> +	if (!sbi->s_avg_fragment_size_list_iops) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +	sbi->s_avg_fragment_size_locks_iops =3D
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
> +			      GFP_KERNEL);
> +	if (!sbi->s_avg_fragment_size_locks_iops) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +	for (i =3D 0; i < MB_NUM_ORDERS(sb); i++) {
> +		INIT_LIST_HEAD(&sbi->s_avg_fragment_size_list_iops[i]);
> +		rwlock_init(&sbi->s_avg_fragment_size_locks_iops[i]);
> +	}
> 	sbi->s_mb_largest_free_orders =3D
> 		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct =
list_head),
> 			GFP_KERNEL);
> @@ -3441,6 +3503,24 @@ int ext4_mb_init(struct super_block *sb)
> 		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
> 		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
> 	}
> +	sbi->s_largest_free_orders_list_iops =3D
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct =
list_head),
> +			      GFP_KERNEL);
> +	if (!sbi->s_largest_free_orders_list_iops) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +	sbi->s_largest_free_orders_locks_iops =3D
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
> +			      GFP_KERNEL);
> +	if (!sbi->s_largest_free_orders_locks_iops) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +	for (i =3D 0; i < MB_NUM_ORDERS(sb); i++) {
> +		=
INIT_LIST_HEAD(&sbi->s_largest_free_orders_list_iops[i]);
> +		rwlock_init(&sbi->s_largest_free_orders_locks_iops[i]);
> +	}
>=20
> 	spin_lock_init(&sbi->s_md_lock);
> 	sbi->s_mb_free_pending =3D 0;
> @@ -3512,8 +3592,12 @@ int ext4_mb_init(struct super_block *sb)
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
> @@ -3582,8 +3666,12 @@ int ext4_mb_release(struct super_block *sb)
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
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_7CE6C640-C232-4BB9-90DF-43C64BE9D107
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTK490ACgkQcqXauRfM
H+AqMQ//ZANU99yY4s4YTzt24uy13ndobY2aq3t4Q45LxD8v5PcAPohNjVU2iEoJ
DTDtCVnLfOtk0c2RN2bFKTEChShbX2wJJN1oKFB0opf8pb4QyX/lA6YPtMGMHyoX
eQdFMNnKelp1c49ESLu5/tu+w3loC5XFABiFQf3jfNpRLKzLw6pHlTIpB2ZdB+nC
1o40cH6Gd6YWSHCd5tN87oPo5JVe6aeqIJmFyBlj4Uw6kzdrTIiJ+/tFcz7vJ0YJ
tnYhnuQgcW9LO1eWi4hOqBDekYVnuuI7ezpIY6wVJkIR5Gx1qgVaZUCHohqlxp0t
6M8joaoYFnBrerAwCL1rNfTihYcXlQE4svNr6ZSgOUghV3fPqfP2XxjJ/8T55qxU
qkHNANAe40aev+zQOeNdefDCR8jfw7g7hgmgguXEet4zRd5ys+FWq0YKaTdF3NuI
wNZx9Hb5q4i61utEl5FUZJVrE7bagZU2RlDg2VRRVbycrdkh3M0tVTJzw3vqYsgK
1o1LeueB2rtXJd8JSfRh5hwl5XITvF3pI/+AdiLZqfSpOqJtwj8mRtqbu9eF+e79
AuA9jgBJk1Sj66dNWmww69OD899xnCScuzqFMcBUOBesUxNdyo/SEutC12xmGCJ3
z+B6Zw3UIMITqW7Vc09S9CicIg27XtFn5EjdwqKVDtUzGQvJFLg=
=YZM/
-----END PGP SIGNATURE-----

--Apple-Mail=_7CE6C640-C232-4BB9-90DF-43C64BE9D107--
