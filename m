Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7551E8379
	for <lists+linux-ext4@lfdr.de>; Fri, 29 May 2020 18:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgE2QT2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 May 2020 12:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2QT2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 May 2020 12:19:28 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E9CC03E969
        for <linux-ext4@vger.kernel.org>; Fri, 29 May 2020 09:19:27 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r2so3050705ila.4
        for <linux-ext4@vger.kernel.org>; Fri, 29 May 2020 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DsLzsvB07QPF3wkN9aJBEGg7reFPpVrEyotwJAhMp3E=;
        b=absBnlLYUtF9gCIvFsdqS46SIrZGbq3eIX5HV4FKKfOrwgx5PLqpcpENb/5oqtbkHC
         lcL8EUJKWOiQ/iG2O75Jsvoj41JCO4h3OjljbzsezzcIJaiQJdYQ14km7/lX9/i0qvIA
         ggbjbf8Ei1DjGEvhSmEHi4LYqeRsOWBTf1Wbr7CAjCbhqB/TLDquOxTA6wLW8LWB5o8n
         5IuB8JuvUdoZeQp7ytKSW0s+mZTTkoWjwExyqkZA/kcJQvpUC2ub5kYNZYL4XC/pE2bU
         AcAd4zI5OiRP3XHsn8C2vjDmmRsprT4ViUWPLYenY2DZYkXmHalxUMpgDJiNtgk+kyTA
         UgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DsLzsvB07QPF3wkN9aJBEGg7reFPpVrEyotwJAhMp3E=;
        b=VSPW7aJd22vl3LlFfgc64cLm7SIuz2B8KCOlTj4fKl24Gt9MMuWEhaq9OZPLVQZDT8
         hlBxofXibQocwyrk/hmB+VYyNqoh630nyCnSvntmVts+nq51bL71HhK9d0z/uuxN6N+a
         PHOp6wMCg3kD17DctYwEH2NCdTK8yD0ef5PLmJKG4wzsYb1j/vWtVs2sEb7mpw3fceyf
         GNNx/qQrPhfFHRfb44uVgKW3uKFQRVy0HgaAFUaIItcxUkLIKWRcAffxcZEYRoTZ1Umw
         hVWOEWnQh0FfTxObbPV6DMQ2T7Q0sfKm7B+4Psn3+t/N9RqMAj53ifKdY5hxlEXIR3/l
         GlvA==
X-Gm-Message-State: AOAM531A6oh78i1391JlmyDZ/WX1esHR8aOPnZotHEoAc5FuQzjLQJQX
        uQCwCzzfZIpB4j0ud7x3m5VqoqarQajpYQ==
X-Google-Smtp-Source: ABdhPJx+vVzn1CeNqWElc/NFcEzEoS7ZChehnsDUMHn+PLLtRG7RIhLQQ2RSnRUEzvJcDfHBhqyRkA==
X-Received: by 2002:a05:6e02:ecb:: with SMTP id i11mr8090705ilk.169.1590769167113;
        Fri, 29 May 2020 09:19:27 -0700 (PDT)
Received: from [172.25.16.115] (seattle-nat.cray.com. [136.162.66.1])
        by smtp.gmail.com with ESMTPSA id x13sm4897681ilq.48.2020.05.29.09.19.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 09:19:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <262A2973-9B2D-4DBE-8752-67E91D52C632@whamcloud.com>
Date:   Fri, 29 May 2020 19:19:22 +0300
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90289086-E2DD-469A-86E2-3BB72CAC59E0@gmail.com>
References: <262A2973-9B2D-4DBE-8752-67E91D52C632@whamcloud.com>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Alex,

Some remarks bellow, after code quote.

Also, we have encountered directory creating rate drop with this (not =
exact this, but Lustre FS version) patch. =46rom 70-80K to 30-40K.
Excluding this patch restore rates to the original values.
I am investigating it now. Alex, do you expect this optimisation has =
impact to names creation?
Is plenty of files and directories creation corner case for this =
optimisation?

Thanks,
Best regards,
Artem Blagodarenko.

> On 15 May 2020, at 13:07, Alex Zhuravlev <azhuravlev@whamcloud.com> =
wrote:
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
> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
> Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
> ---
> fs/ext4/balloc.c  |  12 ++++-
> fs/ext4/ext4.h    |   8 +++-
> fs/ext4/mballoc.c | 116 +++++++++++++++++++++++++++++++++++++++++++++-
> fs/ext4/mballoc.h |   2 +
> fs/ext4/sysfs.c   |   4 ++
> 5 files changed, 138 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index a32e5f7b5385..6712146195ed 100644
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
> +				 bool ignore_locked)
> {
> 	struct ext4_group_desc *desc;
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> @@ -444,6 +445,13 @@ ext4_read_block_bitmap_nowait(struct super_block =
*sb, ext4_group_t block_group)
> 	if (bitmap_uptodate(bh))
> 		goto verify;
>=20
> +	if (ignore_locked && buffer_locked(bh)) {
> +		/* buffer under IO already, do not wait
> +		 * if called for prefetching */
> +		put_bh(bh);
> +		return NULL;
> +	}
> +
> 	lock_buffer(bh);
> 	if (bitmap_uptodate(bh)) {
> 		unlock_buffer(bh);
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
> index 91eb4381cae5..521fbcd8efc7 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1483,6 +1483,8 @@ struct ext4_sb_info {
> 	/* where last allocation was done - for stream allocation */
> 	unsigned long s_mb_last_group;
> 	unsigned long s_mb_last_start;
> +	unsigned int s_mb_prefetch;
> +	unsigned int s_mb_prefetch_limit;
>=20
> 	/* stats for buddy allocator */
> 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
> @@ -2420,7 +2422,8 @@ extern struct ext4_group_desc * =
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
> @@ -3119,6 +3122,7 @@ struct ext4_group_info {
> 	(1 << EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT)
> #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
> 	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
> +#define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
>=20
> #define EXT4_MB_GRP_NEED_INIT(grp)	\
> 	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
> @@ -3133,6 +3137,8 @@ struct ext4_group_info {
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
> index afb8bd9a10e9..ebfe258bfd0f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -861,7 +861,7 @@ static int ext4_mb_init_cache(struct page *page, =
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
> @@ -2127,6 +2127,96 @@ static int ext4_mb_good_group(struct =
ext4_allocation_context *ac,
> 	return 0;
> }
>=20
> +/*
> + * each allocation context (i.e. a thread doing allocation) has own
> + * sliding prefetch window of @s_mb_prefetch size which starts at the
> + * very first goal and moves ahead of scaning.
> + * a side effect is that subsequent allocations will likely find
> + * the bitmaps in cache or at least in-flight.
> + */
> +static void
> +ext4_mb_prefetch(struct ext4_allocation_context *ac,
> +		    ext4_group_t start)
> +{
> +	struct super_block *sb =3D ac->ac_sb;
> +	ext4_group_t ngroups =3D ext4_get_groups_count(sb);
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	struct ext4_group_info *grp;
> +	ext4_group_t nr, group =3D start;
> +	struct buffer_head *bh;
> +

Can be useful giving an ability to disable this optimisation? As option, =
by setting s_mb_prefetch to zero.
Now 0 at s_mb_prefetch allows to skip the optimisation for cr=3D0 and =
cr=3D1.=20

Something like.

If (sbi->s_mb_prefetch =3D=3D 0)
	return;

Some changes in ext4_mb_prefetch_fini() are also probably required.

> +	/* limit prefetching at cr=3D0, otherwise mballoc can
> +	 * spend a lot of time loading imperfect groups */
> +	if (ac->ac_criteria < 2 && ac->ac_prefetch_ios >=3D =
sbi->s_mb_prefetch_limit)
> +		return;

A comment above says prefetching is limited for cr=3D0 but code limit it =
for cr=3D0 and cr=3D1.
Do you need change the comment or code?

> +
> +	/* batch prefetching to get few READs in flight */
> +	nr =3D ac->ac_prefetch - group;
> +	if (ac->ac_prefetch < group)
> +		/* wrapped to the first groups */
> +		nr +=3D ngroups;
> +	if (nr > 0)
> +		return;
> +	BUG_ON(nr < 0);
> +
> +	nr =3D sbi->s_mb_prefetch;
> +	if (ext4_has_feature_flex_bg(sb)) {
> +		/* align to flex_bg to get more bitmas with a single IO =
*/
> +		nr =3D (group / sbi->s_mb_prefetch) * =
sbi->s_mb_prefetch;
> +		nr =3D nr + sbi->s_mb_prefetch - group;
> +	}
> +	while (nr-- > 0) {
> +		grp =3D ext4_get_group_info(sb, group);
> +
> +		/* prevent expensive getblk() on groups w/ IO in =
progress */
> +		if (EXT4_MB_GRP_TEST_AND_SET_READ(grp))
> +			goto next;
> +
> +		/* ignore empty groups - those will be skipped
> +		 * during the scanning as well */
> +		if (grp->bb_free > 0 && EXT4_MB_GRP_NEED_INIT(grp)) {
> +			bh =3D ext4_read_block_bitmap_nowait(sb, group, =
true);
> +			if (bh && !IS_ERR(bh)) {
> +				if (!buffer_uptodate(bh))
> +					ac->ac_prefetch_ios++;
> +				brelse(bh);
> +			}
> +		}
> +next:
> +		if (++group >=3D ngroups)
> +			group =3D 0;
> +	}
> +	ac->ac_prefetch =3D group;
> +}
> +
> +static void
> +ext4_mb_prefetch_fini(struct ext4_allocation_context *ac)
> +{
> +	struct ext4_group_info *grp;
> +	ext4_group_t group;
> +	int nr, rc;
> +
> +	/* initialize last window of prefetched groups */
> +	nr =3D ac->ac_prefetch_ios;
> +	if (nr > EXT4_SB(ac->ac_sb)->s_mb_prefetch)
> +		nr =3D EXT4_SB(ac->ac_sb)->s_mb_prefetch;
> +	group =3D ac->ac_prefetch;
> +	if (!group)
> +		group =3D ext4_get_groups_count(ac->ac_sb);
> +	group--;
> +	while (nr-- > 0) {
> +		grp =3D ext4_get_group_info(ac->ac_sb, group);
> +		if (grp->bb_free > 0 && EXT4_MB_GRP_NEED_INIT(grp)) {
> +			rc =3D ext4_mb_init_group(ac->ac_sb, group, =
GFP_NOFS);
> +			if (rc)
> +				break;
> +		}
> +		if (!group)
> +			group =3D ext4_get_groups_count(ac->ac_sb);
> +		group--;
> +	}
> +}
> +
> static noinline_for_stack int
> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> {
> @@ -2200,6 +2290,7 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 		 * from the goal value specified
> 		 */
> 		group =3D ac->ac_g_ex.fe_group;
> +		ac->ac_prefetch =3D group;
>=20
> 		for (i =3D 0; i < ngroups; group++, i++) {
> 			int ret =3D 0;
> @@ -2211,6 +2302,8 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 			if (group >=3D ngroups)
> 				group =3D 0;
>=20
> +			ext4_mb_prefetch(ac, group);
> +
> 			/* This now checks without needing the buddy =
page */
> 			ret =3D ext4_mb_good_group(ac, group, cr);
> 			if (ret <=3D 0) {
> @@ -2283,6 +2376,8 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> out:
> 	if (!err && ac->ac_status !=3D AC_STATUS_FOUND && first_err)
> 		err =3D first_err;
> +	/* use prefetched bitmaps to init buddy so that read info is not =
lost */
> +	ext4_mb_prefetch_fini(ac);
> 	return err;
> }
>=20
> @@ -2542,6 +2637,25 @@ static int ext4_mb_init_backend(struct =
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

Do you mean =E2=80=9Chow many=E2=80=9D here? At cr=3D0 and cr=3D1?

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
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 88c98f17e3d9..c96a2bd81f72 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -175,6 +175,8 @@ struct ext4_allocation_context {
> 	struct page *ac_buddy_page;
> 	struct ext4_prealloc_space *ac_pa;
> 	struct ext4_locality_group *ac_lg;
> +	ext4_group_t ac_prefetch;
> +	int ac_prefetch_ios; /* number of initialied prefetch IO */
> };
>=20
> #define AC_STATUS_CONTINUE	1
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 04bfaf63752c..5f443f9d54b8 100644
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
> --=20
> 2.21.3
>=20

