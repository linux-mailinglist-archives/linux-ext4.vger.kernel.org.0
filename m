Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37B103939
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 12:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfKTL5D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Nov 2019 06:57:03 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43975 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbfKTL5D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Nov 2019 06:57:03 -0500
Received: by mail-yb1-f195.google.com with SMTP id r201so10211084ybc.10
        for <linux-ext4@vger.kernel.org>; Wed, 20 Nov 2019 03:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5i3oGi331/3laWWQf2JPpqlzBn8W4onbc2qNS27/wVg=;
        b=kw8QdxWjwT5UQgf8MkKumeaNDmulqhlNQ1KDPvzvJ8syEXMkHsiD3wn7gFsC4+zV8V
         3RhYrhhTsnHMFdNLqBy6itF+cLKnOJgNYFLNVylfTsIm3aedahZdySwwzE7uIbzZScQ4
         xdzu2oXEwHGudruWxxzOMHc/BTVCbXWY2ooIfVq+zx4Kd1sE0zhvcmvY9kb5xcK2VOjB
         9rKW0lvPk1J7Ec67qDkDwcUlRj29UKTRp6IwdQdwL4fN7E2S9SvH70rNqJEzY/qgSm9y
         GIOnrxIXNo1p59fYFL4Z92Vmb4y8VX/6lMCXLzwp9bMa3xr+QReaUKWWE9E1Ja0W7H2C
         hXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5i3oGi331/3laWWQf2JPpqlzBn8W4onbc2qNS27/wVg=;
        b=ANQHdXDW3M01ph/dYSqAfHtRQ1H2HHDDVqxwqo6MpKs/KBdH/Y+58M4gps7NxI7Wes
         k2CN6yWY3qUPiU0DnAPHBSeoEupOaLj8KVzFYf3SlcsRDBeZGBKb6Yh3LRHgDeuuxc9k
         Iwxb28gSB8ccqNzidBFF151Fgc6FUXtMpkMLWwpDIEOuEpDPLh2/jnKNWI8Qd9xV2zjx
         8MG5rfEa5apQR7jmgCb4PVEJVxljNcXQCxYM0tjHW2Hfb3jpix2iP2SBgsO04egQFAfY
         IJIBt9rFi1XwxqrX2YBTGeZXSvoRgA6DE9ToN+SZFceuZRIeysrC9R1W/hfmIfmSbyUt
         HRNQ==
X-Gm-Message-State: APjAAAVCG+kmfMTXzTquC1IFk86KKKGXnG7WSenJ+0FDi9KYZBY13huq
        C9C6FSQegwd/EMUrPAbyAoNj1QQknYqroA==
X-Google-Smtp-Source: APXvYqz2hhBuTUEF3hwP1ECX1hb6C6o2sPsHZaT+zokPyNh9gmkjOCniOo7lTsW+k8CpRel4U8DsnQ==
X-Received: by 2002:a25:764b:: with SMTP id r72mr1620081ybc.173.1574251022315;
        Wed, 20 Nov 2019 03:57:02 -0800 (PST)
Received: from [192.168.65.37] (chippewa-nat.cray.com. [136.162.34.1])
        by smtp.gmail.com with ESMTPSA id j67sm10813273ywf.71.2019.11.20.03.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 03:57:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] improve malloc for large filesystems
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
In-Reply-To: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
Date:   Wed, 20 Nov 2019 14:56:56 +0300
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC2A955C-3E0C-4A4D-879A-38B715A86149@gmail.com>
References: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Alex,

Thank you for this important topic. I am going to test your patch and =
give feedback. But this requires some time.

Now I want to share my thougths about this topic.
Here are slides from LAD2019 =E2=80=9CLdiskfs block allocator and aged =
file system" =
https://www.eofs.eu/_media/events/lad19/14_artem_blagodarenko-ldiskfs_bloc=
k_allocator.pdf
There is also patch https://lists.openwall.net/linux-ext4/2019/03/11/5 =
that was sent here, but it require to be improved.

Best  regards,
Artem Blagodarenko

> On 20 Nov 2019, at 13:35, Alex Zhuravlev <azhuravlev@whamcloud.com> =
wrote:
>=20
> Hi,
>=20
> We=E2=80=99ve seen few reports where a huge fragmented filesystem =
spends a lot of time looking for a good chunks of free space.
> Two issues have been identified so far:
> 1) mballoc tries too hard to find the best chunk which is =
counterproductive - it makes sense to limit this process
> 2) during scanning the bitmaps are loaded one by one, synchronously  - =
it makes sense to prefetch few groups at once
> Here is a patch for comments, not really tested at scale, but it=E2=80=99=
d be great to see the comments.
>=20
> Thanks in advance, Alex
>=20
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 0b202e00d93f..76547601384b 100644
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
> {
> 	struct ext4_group_desc *desc;
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> @@ -435,6 +436,13 @@ ext4_read_block_bitmap_nowait(struct super_block =
*sb, ext4_group_t block_group)
> 	if (bitmap_uptodate(bh))
> 		goto verify;
>=20
> +	if (ignore_locked && buffer_locked(bh)) {
> +		/* buffer under IO already, do not wait
> +		 * if called for prefetching */
> +		err =3D 0;
> +		goto out;
> +	}
> +
> 	lock_buffer(bh);
> 	if (bitmap_uptodate(bh)) {
> 		unlock_buffer(bh);
> @@ -524,7 +532,7 @@ ext4_read_block_bitmap(struct super_block *sb, =
ext4_group_t block_group)
> 	struct buffer_head *bh;
> 	int err;
>=20
> -	bh =3D ext4_read_block_bitmap_nowait(sb, block_group);
> +	bh =3D ext4_read_block_bitmap_nowait(sb, block_group, 1);
> 	if (IS_ERR(bh))
> 		return bh;
> 	err =3D ext4_wait_block_bitmap(sb, block_group, bh);
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 03db3e71676c..2320d7e2f8d6 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1480,6 +1480,9 @@ struct ext4_sb_info {
> 	/* where last allocation was done - for stream allocation */
> 	unsigned long s_mb_last_group;
> 	unsigned long s_mb_last_start;
> +	unsigned int s_mb_toscan0;
> +	unsigned int s_mb_toscan1;
> +	unsigned int s_mb_prefetch;
>=20
> 	/* stats for buddy allocator */
> 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
> @@ -2333,7 +2336,8 @@ extern struct ext4_group_desc * =
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
> extern int ext4_wait_block_bitmap(struct super_block *sb,
> 				  ext4_group_t block_group,
> 				  struct buffer_head *bh);
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a3e2767bdf2f..eac4ee225527 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -861,7 +861,7 @@ static int ext4_mb_init_cache(struct page *page, =
char *incore, gfp_t gfp)
> 			bh[i] =3D NULL;
> 			continue;
> 		}
> -		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group);
> +		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group, 0);
> 		if (IS_ERR(bh[i])) {
> 			err =3D PTR_ERR(bh[i]);
> 			bh[i] =3D NULL;
> @@ -2095,10 +2095,52 @@ static int ext4_mb_good_group(struct =
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
> +	ext4_group_t ngroups =3D ext4_get_groups_count(ac->ac_sb);
> +	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> +	struct ext4_group_info *grp;
> +	ext4_group_t group =3D start;
> +	struct buffer_head *bh;
> +	int nr;
> +
> +	/* batch prefetching to get few READs in flight */
> +	if (group + (sbi->s_mb_prefetch >> 1) < ac->ac_prefetch)
> +		return;
> +
> +	nr =3D sbi->s_mb_prefetch;
> +	while (nr > 0) {
> +		if (++group >=3D ngroups)
> +			group =3D 0;
> +		if (unlikely(group =3D=3D start))
> +			break;
> +		grp =3D ext4_get_group_info(ac->ac_sb, group);
> +		/* ignore empty groups - those will be skipped
> +		 * during the scanning as well */
> +		if (grp->bb_free =3D=3D 0)
> +			continue;
> +		nr--;
> +		if (!EXT4_MB_GRP_NEED_INIT(grp))
> +			continue;
> +		bh =3D ext4_read_block_bitmap_nowait(ac->ac_sb, group, =
1);
> +		brelse(bh);
> +	}
> +	ac->ac_prefetch =3D group;
> +}
> +
> static noinline_for_stack int
> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> {
> -	ext4_group_t ngroups, group, i;
> +	ext4_group_t ngroups, toscan, group, i;
> 	int cr;
> 	int err =3D 0, first_err =3D 0;
> 	struct ext4_sb_info *sbi;
> @@ -2160,6 +2202,9 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 	 * cr =3D=3D 0 try to get exact allocation,
> 	 * cr =3D=3D 3  try to get anything
> 	 */
> +
> +	ac->ac_prefetch =3D ac->ac_g_ex.fe_group;
> +
> repeat:
> 	for (; cr < 4 && ac->ac_status =3D=3D AC_STATUS_CONTINUE; cr++) =
{
> 		ac->ac_criteria =3D cr;
> @@ -2169,7 +2214,15 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 		 */
> 		group =3D ac->ac_g_ex.fe_group;
>=20
> -		for (i =3D 0; i < ngroups; group++, i++) {
> +		/* limit number of groups to scan at the first two =
rounds
> +		 * when we hope to find something really good */
> +		toscan =3D ngroups;
> +		if (cr =3D=3D 0)
> +			toscan =3D sbi->s_mb_toscan0;
> +		else if (cr =3D=3D 1)
> +			toscan =3D sbi->s_mb_toscan1;
> +
> +		for (i =3D 0; i < toscan; group++, i++) {
> 			int ret =3D 0;
> 			cond_resched();
> 			/*
> @@ -2179,6 +2232,8 @@ ext4_mb_regular_allocator(struct =
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
> @@ -2872,6 +2927,9 @@ void ext4_process_freed_data(struct super_block =
*sb, tid_t commit_tid)
> 			bio_put(discard_bio);
> 		}
> 	}
> +	sbi->s_mb_toscan0 =3D 1024;
> +	sbi->s_mb_toscan1 =3D 4096;
> +	sbi->s_mb_prefetch =3D 32;
>=20
> 	list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
> 		ext4_free_data_in_buddy(sb, entry);
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 88c98f17e3d9..9ba5c75e6490 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -175,6 +175,7 @@ struct ext4_allocation_context {
> 	struct page *ac_buddy_page;
> 	struct ext4_prealloc_space *ac_pa;
> 	struct ext4_locality_group *ac_lg;
> +	ext4_group_t ac_prefetch;
> };
>=20
> #define AC_STATUS_CONTINUE	1
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index eb1efad0e20a..4476d828439b 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -198,6 +198,9 @@ EXT4_RO_ATTR_ES_UI(errors_count, s_error_count);
> EXT4_ATTR(first_error_time, 0444, first_error_time);
> EXT4_ATTR(last_error_time, 0444, last_error_time);
> EXT4_ATTR(journal_task, 0444, journal_task);
> +EXT4_RW_ATTR_SBI_UI(mb_toscan0, s_mb_toscan0);
> +EXT4_RW_ATTR_SBI_UI(mb_toscan1, s_mb_toscan1);
> +EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
>=20
> static unsigned int old_bump_val =3D 128;
> EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -228,6 +231,9 @@ static struct attribute *ext4_attrs[] =3D {
> 	ATTR_LIST(first_error_time),
> 	ATTR_LIST(last_error_time),
> 	ATTR_LIST(journal_task),
> +	ATTR_LIST(mb_toscan0),
> +	ATTR_LIST(mb_toscan1),
> +	ATTR_LIST(mb_prefetch),
> 	NULL,
> };
> ATTRIBUTE_GROUPS(ext4);
>=20

