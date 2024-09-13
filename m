Return-Path: <linux-ext4+bounces-4132-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2889776B5
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Sep 2024 04:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B46B23F09
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Sep 2024 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC631D27AD;
	Fri, 13 Sep 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4MOevAp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197871C2325;
	Fri, 13 Sep 2024 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192977; cv=none; b=keQC+AV6is1PZ+eq2ZW5nSO3BEWCThKufJn24JKGyRxwwQggOY3q9xD33yBjaXT9Xq1c2+SPA25Li+1EyJcWXiAhFeh5lQwQ/sK+EBmgZb5/hQzI6QbFgBi3yBoVjrCPvjuKeqUyGJEOhnOO9sDT0wCywlw+Xtqgs1i8b2LwqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192977; c=relaxed/simple;
	bh=4MThY4qvJ1Ab6BupHVMJxh9rEHrKqVI39dBQQzwYzlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REwwZ/o+vFCGuMIUDPxI8Uxo3aDeNz09p+WcaIQ2/6e8chEnDl7H0H3Enxwj9ZWkvDa/EXsiTv339HKfMTkDqu2mt6Dvp/hc8p4WLUr5Kw2cd1Ko9QplMcevOcOZXT0CGb4IMQcg2OtmZwc1mwEl+DWJ/fx5I3HisbwhGZ5yr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4MOevAp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53654d716d1so170039e87.2;
        Thu, 12 Sep 2024 19:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726192972; x=1726797772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QY/gsuvkOGtdcCqciSaAEue2D/lSI91a7bbyTdP4bHg=;
        b=I4MOevAp08QF5iLxLdlNhA2yKI3IENjQspbOIx8SuktxmOGWhmVGHqL+hQpgN3wSIt
         9Wze6PpYAZ1OB2UUCOlRvB8LGRIMDra++DTnYBcEGRnz4q+DkA6WUHboWUpOg/qBwz9y
         EbTXbzblaljw+brdfnF7UoG7/ET2eiBvXo9U/kwZLvilKgvx+GlfF6Aof1sjz5G9hQ4Z
         HoNLNfJjLZBzGFUdlyzAc5wzyu0hDtgzAjyAKjcoxsTEn+uDnZuPS8QB7DgcA7TWHCYs
         wP9D8odq2wzX8nsFavBNwEc1NPnGEQM/TBk6xDhe3CbQ1ojWEM1dEUnUQNjJNzuj0gFJ
         cPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726192972; x=1726797772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QY/gsuvkOGtdcCqciSaAEue2D/lSI91a7bbyTdP4bHg=;
        b=drvIXOY484oZyWkkvEcYrKpRwi2mqam1i2dwUrAbiGZatZp5Uj6tQsi3MBWUyRDBzt
         fmVKy2b5IomLgCHG32sETcoHuaBVu80Qr1r/jdhMvROZqyqWucy1q/t5/3psW2mPgize
         6rgpED924aOQUv3ddTaXKlXHzaOj2UbSITqfAIhAa8b2UK/LEIhz7CkacEgTR77NyxPl
         rDlpE/3eqa6U/Z4eiAThZ1HUgjXwCeDtsUNSvABCBnf3g8UEZw+tEQR7kfKql+sqdHla
         +q+tbzIVhWD2LPCedmpCJyfs40H5dTfaDZJ1tD1ZRHHJv89jZKIFB/cwWudCSehS0AhB
         owOg==
X-Forwarded-Encrypted: i=1; AJvYcCUTJqA74XIMowVDzaD1yOV7OYiPKT/KgnNQp/2HMTBeqTsZDQggltSPoyz25YU7lyqgkxzdTq8eHmpNxkp1@vger.kernel.org, AJvYcCUnVUj+S/7p8YR5+iCreirA0FHvag9qstNsxbRS+tO+ToWUDXbfQPrBkyQlHCvFiErCax6U/xzmVbwd@vger.kernel.org
X-Gm-Message-State: AOJu0YwWG0k7ZU7E0Fo7B1RD5CZWcPeDgiHrO7Ejm092pXioqcnO5qcB
	HSsyAz1V3iHwtSGmnu3NdyvNisfMvdAZnxaA4xJXjkicQbjXedDgz8vlbisGiTTjiQ+pzjLPIln
	dHZjZh7ytoxzYo47jPMV7dLHDAx0=
X-Google-Smtp-Source: AGHT+IGrJuDG02PCG4dEENnexjrncMmBCSoLaB2YMVJxFV1gKI9S8xqofKhSZ5zvkpp0iF7rb03Y0mYGa3ZFRO8vt9A=
X-Received: by 2002:a2e:bc15:0:b0:2f4:f3e7:2a36 with SMTP id
 38308e7fff4ca-2f787d9e80cmr7624221fa.3.1726192971742; Thu, 12 Sep 2024
 19:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904075300.1148836-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240904075300.1148836-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 13 Sep 2024 10:02:40 +0800
Message-ID: <CAGWkznF0LvqP59edcrs_wxpbUAnK6mZWY-ovE0CPBBXNysUUtg@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] fs: ext4: Don't use CMA for buffer_head
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <steve.kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

loop in jan kara

On Wed, Sep 4, 2024 at 3:54=E2=80=AFPM zhaoyang.huang <zhaoyang.huang@uniso=
c.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> cma_alloc() keep failed in our system which thanks to a jh->bh->b_page
> can not be migrated out of CMA area[1] as the jh has one cp_transaction
> pending on it because of j_free > j_max_transaction_buffers[2][3][4][5][6=
].
> We temporarily solve this by launching jbd2_log_do_checkpoint forcefully
> somewhere. Since journal is common mechanism to all JFSs and
> cp_transaction has a little fewer opportunity to be launched, the
> cma_alloc() could be affected under the same scenario. This patch
> would like to have buffer_head of ext4 not use CMA pages when doing
> sb_getblk.
>
> [1]
> crash_arm64_v8.0.4++> kmem -p|grep ffffff808f0aa150(sb->s_bdev->bd_inode-=
>i_mapping)
> fffffffe01a51c00  e9470000 ffffff808f0aa150        3  2 8000000008020 lru=
,private
> fffffffe03d189c0 174627000 ffffff808f0aa150        4  2 2004000000008020 =
lru,private
> fffffffe03d88e00 176238000 ffffff808f0aa150      3f9  2 2008000000008020 =
lru,private
> fffffffe03d88e40 176239000 ffffff808f0aa150        6  2 2008000000008020 =
lru,private
> fffffffe03d88e80 17623a000 ffffff808f0aa150        5  2 2008000000008020 =
lru,private
> fffffffe03d88ec0 17623b000 ffffff808f0aa150        1  2 2008000000008020 =
lru,private
> fffffffe03d88f00 17623c000 ffffff808f0aa150        0  2 2008000000008020 =
lru,private
> fffffffe040e6540 183995000 ffffff808f0aa150      3f4  2 2004000000008020 =
lru,private
>
> [2] page -> buffer_head
> crash_arm64_v8.0.4++> struct page.private fffffffe01a51c00 -x
>       private =3D 0xffffff802fca0c00
>
> [3] buffer_head -> journal_head
> crash_arm64_v8.0.4++> struct buffer_head.b_private 0xffffff802fca0c00
>   b_private =3D 0xffffff8041338e10,
>
> [4] journal_head -> b_cp_transaction
> crash_arm64_v8.0.4++> struct journal_head.b_cp_transaction 0xffffff804133=
8e10 -x
>   b_cp_transaction =3D 0xffffff80410f1900,
>
> [5] transaction_t -> journal
> crash_arm64_v8.0.4++> struct transaction_t.t_journal 0xffffff80410f1900 -=
x
>   t_journal =3D 0xffffff80e70f3000,
>
> [6] j_free & j_max_transaction_buffers
> crash_arm64_v8.0.4++> struct journal_t.j_free,j_max_transaction_buffers 0=
xffffff80e70f3000 -x
>   j_free =3D 0x3f1,
>   j_max_transaction_buffers =3D 0x100,
>
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v3: switch to use getblk_unmoveable as suggested by Theodore Ts'o
> ---
> ---
>  fs/ext4/inode.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 941c1c0d5c6e..a0f48840c5c1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -869,7 +869,14 @@ struct buffer_head *ext4_getblk(handle_t *handle, st=
ruct inode *inode,
>         if (nowait)
>                 return sb_find_get_block(inode->i_sb, map.m_pblk);
>
> -       bh =3D sb_getblk(inode->i_sb, map.m_pblk);
> +       /*
> +        * Since bh could introduce extra ref count such as referred by
> +        * journal_head etc. Try to avoid using __GFP_MOVABLE here
> +        * as it may fail the migration when journal_head remains.
> +        */
> +       bh =3D getblk_unmovable(inode->i_sb->s_bdev, map.m_pblk,
> +                               inode->i_sb->s_blocksize);
> +
>         if (unlikely(!bh))
>                 return ERR_PTR(-ENOMEM);
>         if (map.m_flags & EXT4_MAP_NEW) {
> --
> 2.25.1
>

