Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848E82279A2
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 09:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgGUHm6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 03:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgGUHm5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 03:42:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92783C061794
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 00:42:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so9900198pls.4
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pTkiuTEhAfTQY8Mm2vgWMxX9B08nrETAAvz4oNA52cI=;
        b=jGA44H7PDZEJSa1LTCLxvEM5HSTIStvC58VoxY9/hWctkreHt6Op7GkF3sOTu5Hmeu
         x4Oh4hSH2tONAe/9OjgEqFDXQW797Jh9xm3Acc543oPqnZAXVs9ThdlUJuCc9kCB1eiS
         3ocIf8LXXcCaBV9V50aUgsqmWN9tg8HomLC00DuEzkBZZ+uA003xHYhGWd6yqDb6PbmS
         rKLWMFKIFpNe5k7LbRRfwGfAkhzlfZwL+AUGK/v5jV6XDGEMoWD/8cv5ezvuEkvARrrG
         PQ64l+Tb/8l+/zSWMXoU7uFXRiXU32K/VpQ/ie+8XsiIc8N5D8hdXQ86EmzT5BM1Zgyl
         wneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pTkiuTEhAfTQY8Mm2vgWMxX9B08nrETAAvz4oNA52cI=;
        b=NXJERm3hWq3KthHYY1PjlxdcY/+ZnW37piI6+LNTROa4faCYlPa8q67St4cMKrigeZ
         Sfjqh6Gxr7RDpvFVBQe1587p41laeJP23JOCSYKVgCbDFMTE3/nnBv+uPNwWGZ2PFHR8
         kBk5lP+hHFSCEaUieYzh03jeGcq4CtxnvWd7JoRC4yILfidIBdNyd9xmsLDUehcM2cYg
         hYQGZJqgur+Tanu1r0rHQhMxUdMxEnjGSz/OCp/JibNKDf+/VmDTagCTGxt54CEjOOdo
         qqAvOgOrzGJRbGxG0uh30WKz+yOqWrkHX+O3OBwzwEMa/oqcCc0fVypC1m8iLG5SlXd/
         hq7Q==
X-Gm-Message-State: AOAM533kxyED5s7Spmlx0xVO+MlCQskc3rsG2GrnQna/ligk50EkcSuE
        x8ERd3zDZmKUhbhQvbTkW8MNTA==
X-Google-Smtp-Source: ABdhPJwO3qer04Znj/6euua94FfkvkLHBS536SrwPLZJ+ApPUWNPBSXu94hfML0ziACfgd/m65P8UA==
X-Received: by 2002:a17:90a:d56:: with SMTP id 22mr2849417pju.58.1595317376732;
        Tue, 21 Jul 2020 00:42:56 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id l16sm19331493pff.167.2020.07.21.00.42.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 00:42:55 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1F791FDF-75A7-48D9-A0A7-764D5AEC8E4B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_667D4D4E-7900-4B5D-8CB0-36DEA8E631F9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/4] ext4: add prefetching for block allocation bitmaps
Date:   Tue, 21 Jul 2020 01:42:54 -0600
In-Reply-To: <20200717155352.1053040-2-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        Shuichi Ihara <sihara@ddn.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20200717155352.1053040-1-tytso@mit.edu>
 <20200717155352.1053040-2-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_667D4D4E-7900-4B5D-8CB0-36DEA8E631F9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 17, 2020, at 9:53 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> From: Alex Zhuravlev <bzzz@whamcloud.com>
>=20
> This should significantly improve bitmap loading, especially for flex
> groups as it tries to load all bitmaps within a flex.group instead of
> one by one synchronously.
>=20
> Prefetching is done in 8 * flex_bg groups, so it should be 8 =
read-ahead
> reads for a single allocating thread. At the end of allocation the
> thread waits for read-ahead completion and initializes buddy =
information
> so that read-aheads are not lost in case of memory pressure.
>=20
> At cr=3D0 the number of prefetching IOs is limited per allocation =
context
> to prevent a situation when mballoc loads thousands of bitmaps looking
> for a perfect group and ignoring groups with good chunks.
>=20
> Together with the patch "ext4: limit scanning of uninitialized groups"
> the mount time (which includes few tiny allocations) of a 1PB =
filesystem
> is reduced significantly:
>=20
>               0% full    50%-full unpatched    patched
>  mount time       33s                9279s       563s
>=20
> [ Restructured by tytso; removed the state flags in the allocation
>  context, so it can be used to lazily prefetch the allocation bitmaps
>  immediately after the file system is mounted.  Skip prefetching
>  block groups which are unitialized.  Finally pass in the REQ_RAHEAD
>  flag to the block layer while prefetching. ]
>=20
> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
> Reviewed-by: Andreas Dilger <adilger@whamcloud.com>

I re-reviewed the patch with the changes, and it looks OK.  I see that
you reduced the prefetch limit from 32 to 4 group blocks, presumably to
keep the latency low?  It would be useful to see what impact that has
on the mount time and IO performance of a large filesystem.

Shuichi, do you have a properly populated large OST that you could test
this?  Since it is a tunable (/sys/fs/ext4/<dev>/mb_prefetch_limit), it
should be possible to see the effect on allocation performance at least
without recompiling the module, though this tunable only appears after
mount, so you will have a chance to change it right after mount to see
the effect. Given the long mount time with a bad parameter, this should
not be hard to observe.

Cheers, Andreas

> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> fs/ext4/balloc.c  |  14 +++--
> fs/ext4/ext4.h    |   8 ++-
> fs/ext4/mballoc.c | 132 +++++++++++++++++++++++++++++++++++++++++++++-
> fs/ext4/sysfs.c   |   4 ++
> 4 files changed, 152 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 1ba46d87cdf1..aaa9ec5212c8 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -413,7 +413,8 @@ static int ext4_validate_block_bitmap(struct =
super_block *sb,
>  * Return buffer_head on success or an ERR_PTR in case of failure.
>  */
> struct buffer_head *
> -ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t =
block_group)
> +ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t =
block_group,
> +			      bool ignore_locked)
> {
> 	struct ext4_group_desc *desc;
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> @@ -441,6 +442,12 @@ ext4_read_block_bitmap_nowait(struct super_block =
*sb, ext4_group_t block_group)
> 		return ERR_PTR(-ENOMEM);
> 	}
>=20
> +	if (ignore_locked && buffer_locked(bh)) {
> +		/* buffer under IO already, return if called for =
prefetching */
> +		put_bh(bh);
> +		return NULL;
> +	}
> +
> 	if (bitmap_uptodate(bh))
> 		goto verify;
>=20
> @@ -490,7 +497,8 @@ ext4_read_block_bitmap_nowait(struct super_block =
*sb, ext4_group_t block_group)
> 	trace_ext4_read_block_bitmap_load(sb, block_group);
> 	bh->b_end_io =3D ext4_end_bitmap_read;
> 	get_bh(bh);
> -	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
> +	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO |
> +		  ignore_locked ? REQ_RAHEAD : 0, bh);
> 	return bh;
> verify:
> 	err =3D ext4_validate_block_bitmap(sb, desc, block_group, bh);
> @@ -534,7 +542,7 @@ ext4_read_block_bitmap(struct super_block *sb, =
ext4_group_t block_group)
> 	struct buffer_head *bh;
> 	int err;
>=20
> -	bh =3D ext4_read_block_bitmap_nowait(sb, block_group);
> +	bh =3D ext4_read_block_bitmap_nowait(sb, block_group, false);
> 	if (IS_ERR(bh))
> 		return bh;
> 	err =3D ext4_wait_block_bitmap(sb, block_group, bh);
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 42f5060f3cdf..7451662e092a 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1505,6 +1505,8 @@ struct ext4_sb_info {
> 	/* where last allocation was done - for stream allocation */
> 	unsigned long s_mb_last_group;
> 	unsigned long s_mb_last_start;
> +	unsigned int s_mb_prefetch;
> +	unsigned int s_mb_prefetch_limit;
>=20
> 	/* stats for buddy allocator */
> 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
> @@ -2446,7 +2448,8 @@ extern struct ext4_group_desc * =
ext4_get_group_desc(struct super_block * sb,
> extern int ext4_should_retry_alloc(struct super_block *sb, int =
*retries);
>=20
> extern struct buffer_head *ext4_read_block_bitmap_nowait(struct =
super_block *sb,
> -						ext4_group_t =
block_group);
> +						ext4_group_t =
block_group,
> +						bool ignore_locked);
> extern int ext4_wait_block_bitmap(struct super_block *sb,
> 				  ext4_group_t block_group,
> 				  struct buffer_head *bh);
> @@ -3145,6 +3148,7 @@ struct ext4_group_info {
> 	(1 << EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT)
> #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
> 	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
> +#define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
>=20
> #define EXT4_MB_GRP_NEED_INIT(grp)	\
> 	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
> @@ -3159,6 +3163,8 @@ struct ext4_group_info {
> 	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> #define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
> 	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> +#define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
> +	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, =
&((grp)->bb_state)))
>=20
> #define EXT4_MAX_CONTENTION		8
> #define EXT4_CONTENTION_THRESHOLD	2
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c0a331e2feb0..8a1e6e03c088 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -922,7 +922,7 @@ static int ext4_mb_init_cache(struct page *page, =
char *incore, gfp_t gfp)
> 			bh[i] =3D NULL;
> 			continue;
> 		}
> -		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group);
> +		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group, =
false);
> 		if (IS_ERR(bh[i])) {
> 			err =3D PTR_ERR(bh[i]);
> 			bh[i] =3D NULL;
> @@ -2209,12 +2209,93 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
> 	return ret;
> }
>=20
> +/*
> + * Start prefetching @nr block bitmaps starting at @group.
> + * Return the next group which needs to be prefetched.
> + */
> +static ext4_group_t
> +ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
> +		 unsigned int nr, int *cnt)
> +{
> +	ext4_group_t ngroups =3D ext4_get_groups_count(sb);
> +	struct buffer_head *bh;
> +	struct blk_plug plug;
> +
> +	blk_start_plug(&plug);
> +	while (nr-- > 0) {
> +		struct ext4_group_desc *gdp =3D ext4_get_group_desc(sb, =
group,
> +								  NULL);
> +		struct ext4_group_info *grp =3D ext4_get_group_info(sb, =
group);
> +
> +		/*
> +		 * Prefetch block groups with free blocks; but don't
> +		 * bother if it is marked uninitialized on disk, since
> +		 * it won't require I/O to read.  Also only try to
> +		 * prefetch once, so we avoid getblk() call, which can
> +		 * be expensive.
> +		 */
> +		if (!EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
> +		    EXT4_MB_GRP_NEED_INIT(grp) &&
> +		    ext4_free_group_clusters(sb, gdp) > 0 &&
> +		    !(ext4_has_group_desc_csum(sb) &&
> +		      (gdp->bg_flags & =
cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
> +			bh =3D ext4_read_block_bitmap_nowait(sb, group, =
true);
> +			if (bh && !IS_ERR(bh)) {
> +				if (!buffer_uptodate(bh) && cnt)
> +					(*cnt)++;
> +				brelse(bh);
> +			}
> +		}
> +		if (++group >=3D ngroups)
> +			group =3D 0;
> +	}
> +	blk_finish_plug(&plug);
> +	return group;
> +}
> +
> +/*
> + * Prefetching reads the block bitmap into the buffer cache; but we
> + * need to make sure that the buddy bitmap in the page cache has been
> + * initialized.  Note that ext4_mb_init_group() will block if the I/O
> + * is not yet completed, or indeed if it was not initiated by
> + * ext4_mb_prefetch did not start the I/O.
> + *
> + * TODO: We should actually kick off the buddy bitmap setup in a work
> + * queue when the buffer I/O is completed, so that we don't block
> + * waiting for the block allocation bitmap read to finish when
> + * ext4_mb_prefetch_fini is called from ext4_mb_regular_allocator().
> + */
> +static void
> +ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
> +		      unsigned int nr)
> +{
> +	while (nr-- > 0) {
> +		struct ext4_group_desc *gdp =3D ext4_get_group_desc(sb, =
group,
> +								  NULL);
> +		struct ext4_group_info *grp =3D ext4_get_group_info(sb, =
group);
> +
> +		if (!group)
> +			group =3D ext4_get_groups_count(sb);
> +		group--;
> +		grp =3D ext4_get_group_info(sb, group);
> +
> +		if (EXT4_MB_GRP_NEED_INIT(grp) &&
> +		    ext4_free_group_clusters(sb, gdp) > 0 &&
> +		    !(ext4_has_group_desc_csum(sb) &&
> +		      (gdp->bg_flags & =
cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
> +			if (ext4_mb_init_group(sb, group, GFP_NOFS))
> +				break;
> +		}
> +	}
> +}
> +
> static noinline_for_stack int
> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> {
> -	ext4_group_t ngroups, group, i;
> +	ext4_group_t prefetch_grp =3D 0, ngroups, group, i;
> 	int cr =3D -1;
> 	int err =3D 0, first_err =3D 0;
> +	unsigned int nr =3D 0, prefetch_ios =3D 0;
> 	struct ext4_sb_info *sbi;
> 	struct super_block *sb;
> 	struct ext4_buddy e4b;
> @@ -2282,6 +2363,7 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 		 * from the goal value specified
> 		 */
> 		group =3D ac->ac_g_ex.fe_group;
> +		prefetch_grp =3D group;
>=20
> 		for (i =3D 0; i < ngroups; group++, i++) {
> 			int ret =3D 0;
> @@ -2293,6 +2375,29 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 			if (group >=3D ngroups)
> 				group =3D 0;
>=20
> +			/*
> +			 * Batch reads of the block allocation bitmaps
> +			 * to get multiple READs in flight; limit
> +			 * prefetching at cr=3D0/1, otherwise mballoc =
can
> +			 * spend a lot of time loading imperfect groups
> +			 */
> +			if ((prefetch_grp =3D=3D group) &&
> +			    (cr > 1 ||
> +			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
> +				unsigned int curr_ios =3D prefetch_ios;
> +
> +				nr =3D sbi->s_mb_prefetch;
> +				if (ext4_has_feature_flex_bg(sb)) {
> +					nr =3D (group / =
sbi->s_mb_prefetch) *
> +						sbi->s_mb_prefetch;
> +					nr =3D nr + sbi->s_mb_prefetch - =
group;
> +				}
> +				prefetch_grp =3D ext4_mb_prefetch(sb, =
group,
> +							nr, =
&prefetch_ios);
> +				if (prefetch_ios =3D=3D curr_ios)
> +					nr =3D 0;
> +			}
> +
> 			/* This now checks without needing the buddy =
page */
> 			ret =3D ext4_mb_good_group_nolock(ac, group, =
cr);
> 			if (ret <=3D 0) {
> @@ -2367,6 +2472,10 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags =
0x%x, cr %d ret %d\n",
> 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
> 		 ac->ac_flags, cr, err);
> +
> +	if (nr)
> +		ext4_mb_prefetch_fini(sb, prefetch_grp, nr);
> +
> 	return err;
> }
>=20
> @@ -2613,6 +2722,25 @@ static int ext4_mb_init_backend(struct =
super_block *sb)
> 			goto err_freebuddy;
> 	}
>=20
> +	if (ext4_has_feature_flex_bg(sb)) {
> +		/* a single flex group is supposed to be read by a =
single IO */
> +		sbi->s_mb_prefetch =3D 1 << =
sbi->s_es->s_log_groups_per_flex;
> +		sbi->s_mb_prefetch *=3D 8; /* 8 prefetch IOs in flight =
at most */
> +	} else {
> +		sbi->s_mb_prefetch =3D 32;
> +	}
> +	if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
> +		sbi->s_mb_prefetch =3D ext4_get_groups_count(sb);
> +	/* now many real IOs to prefetch within a single allocation at =
cr=3D0
> +	 * given cr=3D0 is an CPU-related optimization we shouldn't try =
to
> +	 * load too many groups, at some point we should start to use =
what
> +	 * we've got in memory.
> +	 * with an average random access time 5ms, it'd take a second to =
get
> +	 * 200 groups (* N with flex_bg), so let's make this limit 4 */
> +	sbi->s_mb_prefetch_limit =3D sbi->s_mb_prefetch * 4;
> +	if (sbi->s_mb_prefetch_limit > ext4_get_groups_count(sb))
> +		sbi->s_mb_prefetch_limit =3D ext4_get_groups_count(sb);
> +
> 	return 0;
>=20
> err_freebuddy:
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 6c9fc9e21c13..31e0db726d21 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -240,6 +240,8 @@ EXT4_RO_ATTR_ES_STRING(last_error_func, =
s_last_error_func, 32);
> EXT4_ATTR(first_error_time, 0444, first_error_time);
> EXT4_ATTR(last_error_time, 0444, last_error_time);
> EXT4_ATTR(journal_task, 0444, journal_task);
> +EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
> +EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
>=20
> static unsigned int old_bump_val =3D 128;
> EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -283,6 +285,8 @@ static struct attribute *ext4_attrs[] =3D {
> #ifdef CONFIG_EXT4_DEBUG
> 	ATTR_LIST(simulate_fail),
> #endif
> +	ATTR_LIST(mb_prefetch),
> +	ATTR_LIST(mb_prefetch_limit),
> 	NULL,
> };
> ATTRIBUTE_GROUPS(ext4);
> --
> 2.24.1
>=20


Cheers, Andreas






--Apple-Mail=_667D4D4E-7900-4B5D-8CB0-36DEA8E631F9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8WnH4ACgkQcqXauRfM
H+Adtw/+IcvlYipXiBmIFSBVVrYeo8AzaIp14HQcdDrXJxnvmjBhc18/DBTy267E
5eoqeow5I115yGsDAw86PhiQ2/CfvjN1f8Opb7chdMVRuWyzzcnZXpDCQ44uZylC
jELRwA1nLkgMncD7HEUzGh6C14ZZ8WYqs4roVNRoqduxR8USV+fG0Orhkt+ZTfil
6IIF8N1V56QIoBsKiqtdGBOFXw4dH+WDCBBGt1rpN3QhKKd9rv9IJ8lAJrUezAO5
+vJp4Aoy3U08layeWhl8Xt3IQ4xlWvTKeK64vrCMfjAZm43/ym01HjFskduVO31H
EirRwC2LCfaIyk8O9tQOpRnTqOjj7ZcRgNHi0dEXznSOFpnoAi/kXDtqX9VWDypx
vxyxn0DUSQP/7zD1Purmcma0YSr3bfJKtjVyRS1p0yuH0rwL6tYZw6V0P2K4jkss
L0Y22Y5RkIwppWzvwVssiNbvoSm0Q8N8L/4aaEWHmx7wHo1QLNIiE8MUnz1Bu/RJ
Jcfa3Sf2ut+rSj3H8GghterSOY21M8n8R0Ly3QpyE5nfog3as98TIP4GHryMy2AP
qYbL393geazNiLEqXm25uFafNASXWZq+Q8u3h4GC1LjenebAnXgM1mchKMwnY0Td
muEg83mZeeZSOk1gyBeSdbtbxqA4GG5pLSPutfZtK8jfSmhQbRg=
=kQo9
-----END PGP SIGNATURE-----

--Apple-Mail=_667D4D4E-7900-4B5D-8CB0-36DEA8E631F9--
