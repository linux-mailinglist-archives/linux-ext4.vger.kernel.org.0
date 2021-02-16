Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1989F31C904
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Feb 2021 11:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBPKqN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Feb 2021 05:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBPKqM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Feb 2021 05:46:12 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4C0C061756
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 02:45:32 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f1so15069010lfu.3
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 02:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TeXoHc3k0my4teAQZo1IwYa7PlGpZ4D7xnTWNJMdQJQ=;
        b=k2U/2MCFcgyTUobgjtI1xCEtvzqJq5J0T00tZcW0Dmm2VzZLkVCHcRFcBwQAVhmNMK
         hfp3ni5IxvzHv+kqMz2EfsHHqLR6dHhA2+ehASvDQeYJEpvPmQJds/NVxw87DfYxc+qI
         L2321p5CuLrifYzk3VNrOisSiDaFnwWca0rDj2NvpBP+ZX4HVBo36D0bGc8QxNTFvcHW
         U69bep7inMEW5kXZmEKvsJi/KnAClUuBoTXOmLf/ekue5K0MUnzwzv/BmcUhkDBYQKB6
         h7Z2XG78og1224qww918aeoyVg1ep2hgNSTaAePrqRg4x1lGg5pQazqV3PzKOrET4qCJ
         YXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TeXoHc3k0my4teAQZo1IwYa7PlGpZ4D7xnTWNJMdQJQ=;
        b=HnIvUQ2qhmSGu8Y6q1Z9lDJ9VnFNVeRSel2cdeyJns2IH2V4wNu8eVa9PME31kpXSl
         Yuar6pwNUvNzKl+M52RUggJARDSkz4neck1ptmbj7FpGfKBSwI2dZOgxcjOCgc7+8bYZ
         iPrkwBdAV4fBNY8UlUYXh27crHuvxhRqMzrfWOa/1PeEaGkYzx707xne6OfLl63Pw2LE
         rfZXpQIZFakXHnLX51gPM04dhq4XZLu8VcZIP1qZCx4CRQxBoXqpRM6UE2rFUzXbaJlk
         kKOtgMuleUF69yXn4pkdqLdLn8THltYzPz7+SnrO71h1vKotYqNa+UYYFz1brEJaZtdX
         fmYQ==
X-Gm-Message-State: AOAM531yMOEcIcoMBvB/kN17ViUqHxiq9E2w1lZiLIRjY4VNM7cgEEYi
        RUFmHQslI55NaUv96TsnHX03YSqnwLbRKFo998g=
X-Google-Smtp-Source: ABdhPJy/CFDDhAngcQqg+gBlDoGjKazihG6pAyvjmntfGZ5Zu27O7TSCgMR0hAaDe9WBpF3g1gk+vQ==
X-Received: by 2002:ac2:454d:: with SMTP id j13mr11194004lfm.191.1613472330516;
        Tue, 16 Feb 2021 02:45:30 -0800 (PST)
Received: from [192.168.2.192] ([62.33.36.35])
        by smtp.gmail.com with ESMTPSA id q3sm744844lfm.150.2021.02.16.02.45.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 02:45:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH v2 3/5] ext4: add MB_NUM_ORDERS macro
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20210209202857.4185846-4-harshadshirwadkar@gmail.com>
Date:   Tue, 16 Feb 2021 13:45:26 +0300
Cc:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        bzzz@whamcloud.com, sihara@ddn.com,
        Andreas Dilger <adilger@dilger.ca>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1029810C-1D3F-45ED-9EF3-EF85C31AE81B@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-4-harshadshirwadkar@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Harshad,

I believe there are two places yet there number could be changed to the =
macros

fs/ext4/mballoc.c <<ext4_mb_init_cache>>
             (sb->s_blocksize_bits+2));

fs/ext4/mballoc.c <<ext4_mb_good_group>>
if (ac->ac_2order > ac->ac_sb->s_blocksize_bits+1)

Best regards,
Artem Blagodarenko

> On 9 Feb 2021, at 23:28, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> A few arrays in mballoc.c use the total number of valid orders as
> their size. Currently, this value is set as "sb->s_blocksize_bits +
> 2". This makes code harder to read. So, instead add a new macro
> MB_NUM_ORDERS(sb) to make the code more readable.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> ---
> fs/ext4/mballoc.c | 15 ++++++++-------
> fs/ext4/mballoc.h |  5 +++++
> 2 files changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index fffd0770e930..b7f25120547d 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -756,7 +756,7 @@ mb_set_largest_free_order(struct super_block *sb, =
struct ext4_group_info *grp)
>=20
> 	grp->bb_largest_free_order =3D -1; /* uninit */
>=20
> -	bits =3D sb->s_blocksize_bits + 1;
> +	bits =3D MB_NUM_ORDERS(sb) - 1;
> 	for (i =3D bits; i >=3D 0; i--) {
> 		if (grp->bb_counters[i] > 0) {
> 			grp->bb_largest_free_order =3D i;
> @@ -1928,7 +1928,7 @@ void ext4_mb_simple_scan_group(struct =
ext4_allocation_context *ac,
> 	int max;
>=20
> 	BUG_ON(ac->ac_2order <=3D 0);
> -	for (i =3D ac->ac_2order; i <=3D sb->s_blocksize_bits + 1; i++) =
{
> +	for (i =3D ac->ac_2order; i < MB_NUM_ORDERS(sb); i++) {
> 		if (grp->bb_counters[i] =3D=3D 0)
> 			continue;
>=20
> @@ -2314,13 +2314,13 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 	 * We also support searching for power-of-two requests only for
> 	 * requests upto maximum buddy size we have constructed.
> 	 */
> -	if (i >=3D sbi->s_mb_order2_reqs && i <=3D sb->s_blocksize_bits =
+ 2) {
> +	if (i >=3D sbi->s_mb_order2_reqs && i <=3D MB_NUM_ORDERS(sb)) {
> 		/*
> 		 * This should tell if fe_len is exactly power of 2
> 		 */
> 		if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) =3D=3D 0)
> 			ac->ac_2order =3D array_index_nospec(i - 1,
> -							   =
sb->s_blocksize_bits + 2);
> +							   =
MB_NUM_ORDERS(sb));
> 	}
>=20
> 	/* if stream allocation is enabled, use global goal */
> @@ -2850,7 +2850,7 @@ int ext4_mb_init(struct super_block *sb)
> 	unsigned max;
> 	int ret;
>=20
> -	i =3D (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_offsets);
> +	i =3D MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_offsets);
>=20
> 	sbi->s_mb_offsets =3D kmalloc(i, GFP_KERNEL);
> 	if (sbi->s_mb_offsets =3D=3D NULL) {
> @@ -2858,7 +2858,7 @@ int ext4_mb_init(struct super_block *sb)
> 		goto out;
> 	}
>=20
> -	i =3D (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_maxs);
> +	i =3D MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_maxs);
> 	sbi->s_mb_maxs =3D kmalloc(i, GFP_KERNEL);
> 	if (sbi->s_mb_maxs =3D=3D NULL) {
> 		ret =3D -ENOMEM;
> @@ -2884,7 +2884,8 @@ int ext4_mb_init(struct super_block *sb)
> 		offset_incr =3D offset_incr >> 1;
> 		max =3D max >> 1;
> 		i++;
> -	} while (i <=3D sb->s_blocksize_bits + 1);
> +	} while (i < MB_NUM_ORDERS(sb));
> +
>=20
> 	spin_lock_init(&sbi->s_md_lock);
> 	sbi->s_mb_free_pending =3D 0;
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 7597330dbdf8..02861406932f 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -78,6 +78,11 @@
>  */
> #define MB_DEFAULT_MAX_INODE_PREALLOC	512
>=20
> +/*
> + * Number of valid buddy orders
> + */
> +#define MB_NUM_ORDERS(sb)		((sb)->s_blocksize_bits + 2)
> +
> struct ext4_free_data {
> 	/* this links the free block information from sb_info */
> 	struct list_head		efd_list;
> --=20
> 2.30.0.478.g8a0d178c01-goog
>=20

