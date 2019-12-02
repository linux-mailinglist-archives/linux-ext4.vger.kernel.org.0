Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC01510F252
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Dec 2019 22:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfLBVqa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Dec 2019 16:46:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41468 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfLBVq3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Dec 2019 16:46:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id bd4so574147plb.8
        for <linux-ext4@vger.kernel.org>; Mon, 02 Dec 2019 13:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=xSY5gL4e7vJw1u+5Lv6y2QUY0BnvKBjjmyyOVsrMn0s=;
        b=qZ7uj1T/g9/YAh/rQTcC4BCJV4rT+MpjA46FqPiytrhiDYWL2LFkeieympdhcC1l0N
         g6R2phYY2uP6meP9LJRJXlB+s9BjwBIhfyZpX0KsIalO7JDRkdIQlslTFPhxTifA33Z8
         scS2OVVRkHRizNBLfh9EQIop96DwwtaBVTnY7aitdQWhX3LdYfU9h+fZ3HgCFYTVP3fL
         AGUs/xPR3hORbDiUCOlllaoGp3aXPKcWnGLvNcGbCv0273feQ6xWvZAaw7Sk4PjM1URh
         JBOjl632RQ3gdaQMmBB3N0gxlOj3Kwygs81lX7W845N6rBXSSDO2jsmh8Qx2GTP9Fo1Z
         rInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=xSY5gL4e7vJw1u+5Lv6y2QUY0BnvKBjjmyyOVsrMn0s=;
        b=N3xePbPqhxWgpfDeiaMVvtvRsAlC1sjNR7eaxnWmZxwllPEjqoDSAYGiI2FP9siaV1
         knpAeds9CzuVMUpX/ovAZNi4c1dST2add8fpFDhX8fH9z8dW4JP74hLY41+y0foZ6S2I
         zZnCWLRUwoSecZJNOCmznj745cMvMeIaJdQ/sc/Q0BsFIcb6yRi63wc+KpLKmaC7Xx5N
         kFtv+VEH/Jv5tQdjajQ2+V9+qPSNA5tiCr4WQcBa6tMVaI5A/rmB6+UByOtlGVL/D77p
         d6w3fg0jtHztYzgyuHPiC6obwtkKNzGNSjHteT+y5h2l2WmrgnmEQi5L0gdEVNIgiLeM
         /PRA==
X-Gm-Message-State: APjAAAWF0cAw+cDgCHAZdpb9zZ1Bl0kNUKSS75oiTjIRih4rbYBDPJK1
        H/q/16iwgKt7y3QH8bnaLsqbRLy3NEsg5g==
X-Google-Smtp-Source: APXvYqwHeB1HKAUEvEYf3J8tBrTnkhWOXcRKBo4yNbri3b1Ni+4Y7TRoTXBDQ5I709elKZ6AjX7uaw==
X-Received: by 2002:a17:90a:2643:: with SMTP id l61mr1441187pje.71.1575323188796;
        Mon, 02 Dec 2019 13:46:28 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id x4sm446835pff.143.2019.12.02.13.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 13:46:27 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F26AB24A-4110-4F5E-B310-1AD69D7910B4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_851AA142-647F-4185-80CD-BC6DEE63616B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] improve mballoc for large filesystems: prefetch bitmaps
Date:   Mon, 2 Dec 2019 14:46:24 -0700
In-Reply-To: <E4874E78-3D87-46A3-A3B3-3128ED8A2ED2@whamcloud.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>
References: <E4874E78-3D87-46A3-A3B3-3128ED8A2ED2@whamcloud.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_851AA142-647F-4185-80CD-BC6DEE63616B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Dec 2, 2019, at 2:08 AM, Alex Zhuravlev <azhuravlev@whamcloud.com> =
wrote:
>=20
> Hi,
>=20
> Here is another patch for prefetching, reworked a bit:
> - flex_bg is taken into account as few bitmaps are supposed to be =
fetched with a single IO
> - limit number of prefetches at cr=3D0 so that mballoc doesn=E2=80=99t =
try to load all bitmaps
>=20
> Thanks, Alex
>=20
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 0b202e00d93f..0bc694c5dcfe 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -404,7 +404,8 @@ static int ext4_validate_block_bitmap(struct =
super_block *sb,
>  * Return buffer_head on success or NULL in case of failure.
>  */
> struct buffer_head *
> -ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t =
block_group)
> +ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t =
block_group,
> +				 int ignore_locked)

(style) should be "bool" I think

> @@ -524,7 +532,7 @@ ext4_read_block_bitmap(struct super_block *sb, =
ext4_group_t block_group)
> 	struct buffer_head *bh;
> 	int err;
>=20
> -	bh =3D ext4_read_block_bitmap_nowait(sb, block_group);
> +	bh =3D ext4_read_block_bitmap_nowait(sb, block_group, 1);

,,, which means this should be "true"

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f8578caba40d..4a7f4ccd8641 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1485,6 +1485,8 @@ struct ext4_sb_info {
> 	/* where last allocation was done - for stream allocation */
> 	unsigned long s_mb_last_group;
> 	unsigned long s_mb_last_start;
> +	unsigned int s_mb_prefetch;
> +	unsigned int s_mb_prefetch_limit;

(style) please add brief comments for these fields

> @@ -2339,7 +2341,8 @@ extern struct ext4_group_desc * =
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
> +						int ignore_locked);

(style) bool

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 7c6c34fd8e1c..e4d93c9a6b77 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -861,7 +861,7 @@ static int ext4_mb_init_cache(struct page *page, =
char *incore, gfp_t gfp)
> 			bh[i] =3D NULL;
> 			continue;
> 		}
> -		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group);
> +		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group, 0);

... should then be false

> +/*
> + * each allocation context (i.e. a thread doing allocation) has own
> + * sliding prefetch window of @s_mb_prefetch size which starts at the
> + * very first goal and moves ahead of scaning.
> + * a side effect is that subsequent allocations will likely find
> + * the bitmaps in cache or at least in-flight.
> + */
> +static void

(style) return type should be on the same line as the function =
declaration
unless it can't fit, which isn't the case here

> +ext4_mb_prefetch(struct ext4_allocation_context *ac,
> +		    ext4_group_t start)

(style) align after '(' on previous line

> +{
> +	struct super_block *sb =3D ac->ac_sb;
> +	ext4_group_t ngroups =3D ext4_get_groups_count(sb);
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	struct ext4_group_info *grp;
> +	ext4_group_t group =3D start;
> +	struct buffer_head *bh;
> +	int nr;
> +
> +	/* limit prefetching at cr=3D0, otherwise mballoc can
> +	 * spend a lot of time loading imperfect groups */
> +	if (!ac->ac_criteria && ac->ac_prefetch_ios >=3D =
sbi->s_mb_prefetch_limit)
> +		return;
> +
> +	/* batch prefetching to get few READs in flight */
> +	nr =3D ac->ac_prefetch - group;
> +	if (ac->ac_prefetch < group)
> +		/* wrapped to the first groups */
> +		nr +=3D ngroups;
> +	if (nr > 0)
> +		return;

This is a bit non-obvious.  Clearly, if ac_prefetch < group implies that
"nr" is negative, and adding ngroups will make it positive again, but =
this
would be more clear for the reader if written as:

	if (nr < 0)	/* ac_prefetch wrapped to the first groups */
		nr +=3D ngroups;

> +	BUG_ON(nr < 0);
> +
> +	nr =3D sbi->s_mb_prefetch;
> +	if (ext4_has_feature_flex_bg(ac->ac_sb)) {
> +		/* align to flex_bg to get more bitmas with a single IO =
*/
> +		nr =3D (group / sbi->s_mb_prefetch) * =
sbi->s_mb_prefetch;

This is more commonly written today as, since s_mb_prefetch is not =
always
a power-of-two value:

		nr =3D roundup(group, sbi->s_mb_prefetch);

> +		nr =3D nr + sbi->s_mb_prefetch - group;
> +	}
> +	while (nr-- > 0) {
> +		grp =3D ext4_get_group_info(sb, group);
> +		/* ignore empty groups - those will be skipped
> +		 * during the scanning as well */
> +		if (grp->bb_free > 0 && EXT4_MB_GRP_NEED_INIT(grp)) {

Should this also skip groups that we know will not be accepted in this =
pass
(e.g. if cr < 2 and bb_free < number of blocks being allocated), and =
leave
fetching the lousy groups to a later pass if they are actually needed?

There is a bit of a balance between fetching all groups actually being
faster due to contiguous reads, vs. skipping groups that are not =
useful...

> +			bh =3D ext4_read_block_bitmap_nowait(sb, group, =
1);
> +			if (bh && !IS_ERR(bh)) {
> +				if (!buffer_uptodate(bh))
> +					ac->ac_prefetch_ios++;
> +				brelse(bh);
> +			}
> +		}
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

This should probably be a function block comment, maybe s/last/most =
recent/?

> +	nr =3D ac->ac_prefetch_ios;
> +	if (nr > EXT4_SB(ac->ac_sb)->s_mb_prefetch)
> +		nr =3D EXT4_SB(ac->ac_sb)->s_mb_prefetch;
> +	group =3D ac->ac_prefetch;
> +	while (nr-- > 0) {
> +		grp =3D ext4_get_group_info(ac->ac_sb, group);
> +		if (grp->bb_free > 0 && EXT4_MB_GRP_NEED_INIT(grp)) {
> +			rc =3D ext4_mb_init_group(ac->ac_sb, group, =
GFP_NOFS);
> +			if (rc)
> +				break;
> +		}
> +		if (group-- =3D=3D 0)
> +			group =3D ext4_get_groups_count(ac->ac_sb) - 1;
> +	}
> +}
> +
> static noinline_for_stack int
> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> {
> @@ -2175,7 +2256,8 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 		 * searching for the right group start
> 		 * from the goal value specified
> 		 */
> -		group =3D ac->ac_g_ex.fe_group;
> +		group =3D ac->ac_g_ex.fe_group + 1;
> +		ac->ac_prefetch =3D group;
>=20
> 		for (i =3D 0; i < ngroups; group++, i++) {
> 			int ret =3D 0;
> @@ -2187,6 +2269,8 @@ ext4_mb_regular_allocator(struct =
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
> @@ -2259,6 +2343,8 @@ ext4_mb_regular_allocator(struct =
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
> @@ -2880,6 +2966,22 @@ void ext4_process_freed_data(struct super_block =
*sb, tid_t commit_tid)
> 			bio_put(discard_bio);
> 		}
> 	}
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
> +	if (sbi->s_mb_prefetch >=3D ext4_get_groups_count(sb) >> 2)
> +		sbi->s_mb_prefetch =3D ext4_get_groups_count(sb) >> 2;
> +	/* now many real IOs to prefetch within a single allocation at =
cr=3D0
> +	 * given cr=3D0 is an CPU-related optimization we shouldn't try =
to
> +	 * load too many groups, at some point we should start to use =
what
> +	 * we've got in memory.
> +	 * with an average random access time 5ms, it'd take a second to =
get
> +	 * 200 groups (* N with flex_bg), so let's make this limit 256 =
*/
> +	sbi->s_mb_prefetch_limit =3D sbi->s_mb_prefetch * 256;

This seems a bit on the high side?  For a flex_bg size of 256 this works
out to prefetching 524k bitmaps, which is 64TiB worth of block =
allocation
(10% of the current "large" 640TiB filesystems).  Without the flex_bg
multiplier this is 256 * 8 =3D 2048 bitmaps to scan ahead =3D 8MB which =
is OK,
but with a flex_bg size of 256 this would be 2GB of bitmaps.  There
should probably be some fixed upper limit, maybe 32768 bitmaps =3D 128MB
regardless of the flex_bg size?  That is still 4TiB of space to allocate
from, and the sliding window will still keep the bitmaps loading in the
background if the first groups do not have enough free space.

Ideally, s_mb_prefetch_limit would be set by the amount of time it takes
until the first prefetched bitmaps are actually loaded and can be =
checked.
Once the prefetch pipeline is full, there is no need to prefetch even =
more
bitmaps that are in danger of being evicted.

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

"initialized" ?

> #define AC_STATUS_CONTINUE	1
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index eb1efad0e20a..a14ce23c1444 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -186,6 +186,8 @@ EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, =
s_mb_min_to_scan);
> EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
> EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> +EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
> +EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
> EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
> EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, =
s_err_ratelimit_state.interval);
> @@ -215,6 +217,8 @@ static struct attribute *ext4_attrs[] =3D {
> 	ATTR_LIST(mb_order2_req),
> 	ATTR_LIST(mb_stream_req),
> 	ATTR_LIST(mb_group_prealloc),
> +	ATTR_LIST(mb_prefetch),
> +	ATTR_LIST(mb_prefetch_limit),
> 	ATTR_LIST(max_writeback_mb_bump),
> 	ATTR_LIST(extent_max_zeroout_kb),
> 	ATTR_LIST(trigger_fs_error),

Cheers, Andreas






--Apple-Mail=_851AA142-647F-4185-80CD-BC6DEE63616B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3lhjEACgkQcqXauRfM
H+AnTBAAquvwIHrhg8zzyT7kmFAPZR5CQxBIFa8L/31XhwLmm4JZuwWTUqD0pZ+A
h4F1gfOcwQD4ATFIyyIJcW3Ao1HIhzMn+E+paq7xvVAM3tk1HBs3u37/aevRuG3P
Gy3x9fO1OFtJUJnHfDWJRlt8WFIbQMB2ipY6BdbCXzWxcN2UUx9Fcr7KqsqbhocM
kIAJfis09IZAQMeMaW+au6D+1PGWmQBrMa3PLV+WAPqFwnSovEvEFVclQ1BkjroB
EiyKDnX0U5uriLshFQ1ikhr3E8IEUCPVGpLPhQp3uSdfVT/xP/ODvpe80Htr0MZz
s8ozAx43bEKOeCNZFXt4z34KBBEOYyP3CkEeEC0gdosx49A0auzrh+DQv86DdvM5
VNH7uDi74y75c8Qo78vmIz0T3FIO068VuU6Mu92fzG4WEP3OyWkAafxhbN5EZZYS
C6ZtITq7UgIyEiYhrNtDVNjXPL1gz47TbLz/YdZISopqqqF3lwILH1cDIUGaL++d
5pQqOzz0wjq5uqktzT+1QknOA6g6EN/u59MZfgQK4CdJ5GLG3OY/uyzXiR5H8jV6
LmOJLVHgaUIZl7J7KBHxVauQjZFT1xbST6Rn7mJpLIThoesvl8AhFk9MJmSn3A/A
P3lEmjVl2Pq7wTGTVpIo0xBF/JUmaOdD7swPx5Q7jC9uQbLWRHg=
=aMJe
-----END PGP SIGNATURE-----

--Apple-Mail=_851AA142-647F-4185-80CD-BC6DEE63616B--
