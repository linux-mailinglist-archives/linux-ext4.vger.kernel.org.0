Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04157203DB5
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jun 2020 19:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgFVRUw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jun 2020 13:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgFVRUw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jun 2020 13:20:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49120C061573
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jun 2020 10:20:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u14so127082pjj.2
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jun 2020 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=xWQPz9q0eJuX8m55mRZRmPHZOqq1FrkfBkjJy6vPowY=;
        b=xygvMCwidzc3VqmGvt7Gdf/P5a0ol1rZFHQqV1JCW207x5tNM/rxePiRp22tSbofhL
         JiDf/cGN5ZN5YAdEO/Yd/9GIYss6szJkCFZseX1X+593fnbTyS2J1DGKiQsLXlHoKhdh
         6aitBkDutoL+gG7Ly43UVgedMSlHiJzWhDk4yKh8hGru3uJARFVh8gQsfHnihXtFfkBz
         A9wwQILV8n3CJmMCkYuxENGuGxdZSRpK6yY7x/m0+xTG6I5zmk9oI2qeqEVSHlA5ZfTQ
         G+8LdnCDDewWLCkdAX6jUbfCU0ffI5Ymx50RHKPMi4b0TybmdrNrLsdGpL21Ib86Ft9R
         xEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=xWQPz9q0eJuX8m55mRZRmPHZOqq1FrkfBkjJy6vPowY=;
        b=lnBk0mpZ2wVEHZX26hvlaCAVrBw7HBYzIRqA8cN6r7y0yzH6VkHb9SjYSAyEnbXrUE
         gwZ1fnPvXPSrzD2EZZq/vZgqK/YZvSuIv2sGA9ftjNias4ekaxiwdqqM5NFtGucjgnYS
         /DpkzgParNiXQFBHV75V+tGuti7bnqCju3OQeWWGjyIhX3xmnjfSQRqQ1e+OrEeYVdHH
         u9LNL+LhhNYevf0dxdVM9KNc880KqoHW3bzGOfC2O5asDGBEYx9hsB7tfb7nFllsamE8
         /0xicMnrZDf8TQbJTaQfufsyGg/+dKYnBLqvcrRYPG4g49kPH68nXQSVW+StqFX3xBr3
         oiAw==
X-Gm-Message-State: AOAM533Q4rIggmJK5IXC5w+rvvlgrw5CSoT0GpR5n/BK/sd9cHxST+U8
        KOiDfp+MmjGB0pk6RCMPXLITwmBeIiIxWQ==
X-Google-Smtp-Source: ABdhPJySWQhvlfOCmlvkwAL4qtHeGB0lTzrhdhMtmeMybAp6mdIRQFz68RBn/kAMWpWZWZ/ZzEXDcg==
X-Received: by 2002:a17:90a:3608:: with SMTP id s8mr19892279pjb.86.1592846450642;
        Mon, 22 Jun 2020 10:20:50 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id o11sm99536pjq.54.2020.06.22.10.20.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 10:20:49 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <10FBB7E7-A49E-4A21-8CDE-E7374AFE31A3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FE5ECF80-B4D2-4552-B11B-77E497FAE352";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 2/2] ext4: avoid trimming block group if only few
 blocks freed
Date:   Mon, 22 Jun 2020 11:20:47 -0600
In-Reply-To: <1592835419-7841-1-git-send-email-wangshilong1991@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
References: <1592831677-13945-2-git-send-email-wangshilong1991@gmail.com>
 <1592835419-7841-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_FE5ECF80-B4D2-4552-B11B-77E497FAE352
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 22, 2020, at 8:16 AM, Wang Shilong <wangshilong1991@gmail.com> =
wrote:
>=20
> From: Wang Shilong <wshilong@ddn.com>
>=20
> Now WAS_TRIMMED flag will be cleared if there are any blocks
> freed in this block group, this might be not good idea if there
> are only few blocks freed, since most of freed blocks have been
> issued discard before.
>=20
> So this patch tries to introduce another counter which record
> how many blocks freed since last time trimmed, WAS_TRIMMED flag
> will be only cleared if there are enough free blocks(default 128).
>=20
> Also expose a new sys interface min_freed_blocks_to_trim to tune
> default behavior.
>=20
> Cc: Shuichi Ihara <sihara@ddn.com>
> Cc: Andreas Dilger <adilger@dilger.ca>
> Cc: Wang Shilong <wangshilong1991@gmail.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> changelog v1->v2:
> init bb_freed_last_trimmed to be zero during setup
> ---
> fs/ext4/ext4.h    |  7 +++++++
> fs/ext4/mballoc.c | 18 ++++++++++++++++--
> fs/ext4/sysfs.c   |  2 ++
> 3 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 252754da2f1b..2da86d1ebe3f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1240,6 +1240,9 @@ extern void ext4_set_bits(void *bm, int cur, int =
len);
> /* Metadata checksum algorithm codes */
> #define EXT4_CRC32C_CHKSUM		1
>=20
> +/* Default min freed blocks which we could clear TRIMMED flags */
> +#define DEFAULT_MIN_FREED_BLOCKS_TO_TRIM	128
> +
> /*
>  * Structure of the super block
>  */
> @@ -1533,6 +1536,9 @@ struct ext4_sb_info {
> 	/* the size of zero-out chunk */
> 	unsigned int s_extent_max_zeroout_kb;
>=20
> +	/* Min freed blocks per group that we could run trim on it*/
> +	unsigned long s_min_freed_blocks_to_trim;
> +
> 	unsigned int s_log_groups_per_flex;
> 	struct flex_groups * __rcu *s_flex_groups;
> 	ext4_group_t s_flex_groups_allocated;
> @@ -3125,6 +3131,7 @@ struct ext4_group_info {
> 	struct rb_root  bb_free_root;
> 	ext4_grpblk_t	bb_first_free;	/* first free block */
> 	ext4_grpblk_t	bb_free;	/* total free blocks */
> +	ext4_grpblk_t	bb_freed_last_trimmed; /* total free blocks =
since last trimmed*/
> 	ext4_grpblk_t	bb_fragments;	/* nr of freespace fragments */
> 	ext4_grpblk_t	bb_largest_free_order;/* order of largest frag =
in BG */
> 	struct          list_head bb_prealloc_list;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 235a316584d0..52ab9ac5be86 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2558,6 +2558,7 @@ int ext4_mb_add_groupinfo(struct super_block =
*sb, ext4_group_t group,
> 	init_rwsem(&meta_group_info[i]->alloc_sem);
> 	meta_group_info[i]->bb_free_root =3D RB_ROOT;
> 	meta_group_info[i]->bb_largest_free_order =3D -1;  /* uninit */
> +	meta_group_info[i]->bb_freed_last_trimmed =3D 0;
>=20
> 	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
> 	return 0;
> @@ -2763,6 +2764,8 @@ int ext4_mb_init(struct super_block *sb)
> 			sbi->s_mb_group_prealloc, sbi->s_stripe);
> 	}
>=20
> +	sbi->s_min_freed_blocks_to_trim =3D =
DEFAULT_MIN_FREED_BLOCKS_TO_TRIM;
> +
> 	sbi->s_locality_groups =3D alloc_percpu(struct =
ext4_locality_group);
> 	if (sbi->s_locality_groups =3D=3D NULL) {
> 		ret =3D -ENOMEM;
> @@ -5091,8 +5094,18 @@ void ext4_free_blocks(handle_t *handle, struct =
inode *inode,
> 	 * If the volume is mounted with -o discard, online discard
> 	 * is supported and the free blocks will be trimmed online.
> 	 */
> -	if (!test_opt(sb, DISCARD))
> -		EXT4_MB_GDP_CLEAR_TRIMMED(gdp);
> +	if (!test_opt(sb, DISCARD)) {
> +		e4b.bd_info->bb_freed_last_trimmed +=3D count;
> +		/*
> +		 * Only clear the WAS_TRIMMED flag if there are
> +		 * several blocks freed, or if the group becomes
> +		 * totally 'empty'(free < num_itable_blocks + 2).
> +		 */
> +		if (e4b.bd_info->bb_freed_last_trimmed >=3D
> +		    sbi->s_min_freed_blocks_to_trim ||
> +		    e4b.bd_info->bb_free < (sbi->s_itb_per_group + 2))
> +			EXT4_MB_GDP_CLEAR_TRIMMED(gdp);
> +	}
> 	ext4_group_desc_csum_set(sb, block_group, gdp);
> 	ext4_unlock_group(sb, block_group);
>=20
> @@ -5425,6 +5438,7 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
> 		}
> 		ext4_lock_group(sb, group);
> 		EXT4_MB_GDP_SET_TRIMMED(gdp);
> +		e4b.bd_info->bb_freed_last_trimmed =3D 0;
> 		ext4_group_desc_csum_set(sb, group, gdp);
> 		ext4_unlock_group(sb, group);
> 		err =3D ext4_handle_dirty_metadata(handle, NULL, =
gdp_bh);
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 6c9fc9e21c13..8ee4e7e3f125 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -216,6 +216,7 @@ EXT4_RW_ATTR_SBI_UI(mb_order2_req, =
s_mb_order2_reqs);
> EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
> +EXT4_RW_ATTR_SBI_UI(min_freed_blocks_to_trim, =
s_min_freed_blocks_to_trim);
> EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, =
s_err_ratelimit_state.interval);
> EXT4_RW_ATTR_SBI_UI(err_ratelimit_burst, s_err_ratelimit_state.burst);
> @@ -259,6 +260,7 @@ static struct attribute *ext4_attrs[] =3D {
> 	ATTR_LIST(mb_group_prealloc),
> 	ATTR_LIST(max_writeback_mb_bump),
> 	ATTR_LIST(extent_max_zeroout_kb),
> +	ATTR_LIST(min_freed_blocks_to_trim),
> 	ATTR_LIST(trigger_fs_error),
> 	ATTR_LIST(err_ratelimit_interval_ms),
> 	ATTR_LIST(err_ratelimit_burst),
> --
> 2.25.4
>=20


Cheers, Andreas






--Apple-Mail=_FE5ECF80-B4D2-4552-B11B-77E497FAE352
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7w6G8ACgkQcqXauRfM
H+CQQBAAhpYBdX6l61XrMTebHtAdhUAxmOgcqgLjoE6qxupk+B9DNwsQuN7y3/cU
sVnkRRsHNJNuNn8172iAFITh9Dm2/GGtJAuWubXp8kPxA5uJRaYjoZZ9M+Vwfk/Q
7nA93ugEMsan980QpFiqtx+WUo8jh570wWnChA6fuYRWJK/LiKRtmWsLw2hlrvxK
rjJOBaWu5rBLAXDV+2W6w27H6+lsEz+vX3b5Tj5/npT/UV9m4XY2a69/lbIqYWb7
19YxqtzaCNbVxFYZ5KfvdBinc41pC7+EAPusOeOM0rg4LH5FFavloP2ed7YPF038
pwzhtO7XRmMb+afZfIfVqsJe9JdVgMp/Zq7x2H5xi4mNoeZDqBtShof0gG7F7cFI
negy7bbSiy8rR1KkfemZmICK91FKVfRx2knyzkOFoHEF8Fip91bGXGf30NrO2eZF
zGrU/pWLsxx3s8Z9zxfwffgcbTzSIZDeO8p2VDxVEa2dVECDskGj1Aw93ugv43Bt
FAEOXRBfMJRb74AoZrkCIZ+UGQBGKdLDnsOSN969nkseQjIHOPD/vjVV42iNbxwM
/ov9XkVdPtUl0rgO6PNk3nC1QUofY/FFow1YTsAZIUn/71emwGwS3KaedZvVPDRF
fbSwvNXrV6Cj7eRnD5qY3KVLJfZFHThW+PtX2vN1IcIYlyyH7No=
=tytZ
-----END PGP SIGNATURE-----

--Apple-Mail=_FE5ECF80-B4D2-4552-B11B-77E497FAE352--
