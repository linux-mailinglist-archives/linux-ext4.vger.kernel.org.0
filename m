Return-Path: <linux-ext4+bounces-10406-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B9DB9C972
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 01:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6FC1BC4234
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 23:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD0286D55;
	Wed, 24 Sep 2025 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="aO7GILTo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49921DF75B
	for <linux-ext4@vger.kernel.org>; Wed, 24 Sep 2025 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756803; cv=none; b=kpv/cXXkeUlg7IA9fIdI9RAo7B2X8Drnuv/654JkhPaIdi7nZ9v7Ieb/Aptp5E+yHnlgJM6/0s3awjxCckXXroGJ65cy3Yl+MOxkcHGA7fgKXCvDxbBoC2fML0RuvLm4hsZIh40elARUxMRpCKP9cf4I/gTiDpNLu8fiKvy6KXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756803; c=relaxed/simple;
	bh=BexvBLWe9ilLyfjQx7lfSxdU87TTc4v75SbAwVdNq3M=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=Nr4mqRRR8lTau73BlTmAWPrurkjZQ26ZxgEXVch5d+oEKsZPKH97HqXgN7TKbp0DA7KrJayG0YYPGJqkqsZClKCRFoWbwB7vC+4ObGqNSKo79EqMSG/hdJJRoPc+nz9OEXv/ic2UmYoK01NwUhPP4LcvAwfyAoDp/KAlbFX19zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=aO7GILTo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26c209802c0so4194615ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 24 Sep 2025 16:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758756800; x=1759361600; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M13+AL5iaWUxovfWXVCx02kI2l71HfeV5Z/VI+kVLQI=;
        b=aO7GILToMkYEct6DtBRpGUTBHsLIv63pfOYkpzetm1mRbz2E7+odJiET1UIR9ZdTxI
         A3HaDnP9StsazNVHfUACn+FQe1mMJDal6vAypgErjoHwFa6vrbdYzEYAGhcNxCDmUIvq
         K3LGriXYzp4XY6Boyxbi9ap1ENgUu4ShdnmBeZ3RrSG5JAABiN4v1DEvnWpDoh6/7tOk
         yB+21D8u589SMVCCWUrLkb4FXbBAxuKZZ05rB3z3eRvlpbOEIdTSZmEokl8zGLxkMErj
         iQO/vhO2/lj+66x4Mxqlm/hdUXRahlO0JXQ9Og3apvKtamr5nuhdHJoC7xgXFTzr+fV+
         Gcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756800; x=1759361600;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M13+AL5iaWUxovfWXVCx02kI2l71HfeV5Z/VI+kVLQI=;
        b=So/OJb826U5iFrQS4KWLJJ/8Qde1n81oLwHOgQuTQTpuMPkOdcAa2D2P0yW+r4KLmy
         3/BoHdzdvSixqgThzX7NF8AGnFx5egNFTy/rASW/4PLqoePsXzWuRw9bnGcDD5w20RHj
         jcWKaZgQK3dwpVwn3g/bmTG4Kdqf1WZJBdcxvwhlkSineRqojw1eAcxxSmcY6JHDw/4U
         2uWOhHIVTqYJYsG6ltG6FOTNXX+zhctZr0wom9mHQJAc+A2jG4p3KS02Ptp8JjiCL3xM
         SJkQ0wTXyAJYocUiDTLxNz0JzbjvLaAEZ/MGeiGb90NlGMLllxkJccOpu7daO+UY5HwV
         ybgw==
X-Forwarded-Encrypted: i=1; AJvYcCVw6D0Yv2BTQz1+hjD8yXbUDrTyAcPrsSKwz7rPQneJZrW6b1TBz8P/9reqOu6e3qbBxndPb/ZXRzPW@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+d4Le5FB9keRUgTaha2ffDMsBwN5YDWtEVIfpSo2EvC1Vbog
	NE1x8ys9Mf271fNytLLTbl41y82d+If9O+p2mUFUH6LqrTNiIttV0kYmDgLdttVmvSbbNHmCw5J
	zAOospQc=
X-Gm-Gg: ASbGnct71ErVbHNbrE7WBBQt21arv+XgWZuE7TyJdmg32kwwHxtMtsqJqPVI9BFM7i0
	IA2PGLh8U4BIidpqwbySDut+SJpSMiavUZMX8NLwvxpQzk+o64wvYm88eVEFwul9psvjHUZfR7I
	/Hple8uXmOgYf/++EILW77K/een9HCFfFKHppsjLgyuJf43+I7AKI7i9x7Ide7t9kq4j98UxvAq
	sN9jBpDSZgXyWCMWKqYyJdjCAQaeeFDGZlDQRFrlHgl+jVJ5EXmhxaR5O/BKWJN5aQ//w6jR+zk
	crmuIf57blPjjtvN0eNEJSGTVkAPMyFbA8OAOHCCmts/ASNUDIfUsBuYyEhO0SBjNKegWuVw1y1
	uJoRmylhyWWUk5A6I9udVfAQAFq0QCXXJ8ld1ArZEG34uNkD6fEBjG1p7pIlvHp1flJj+yv8=
X-Google-Smtp-Source: AGHT+IHrf/fFd6VIegG3nlmHmbRRevDnQaITsbK7dyzLoVqitycl0QpxaLZ5UAv8wQee8BzV4NI6EQ==
X-Received: by 2002:a17:902:ce01:b0:271:479d:3ddc with SMTP id d9443c01a7336-27ed4a1a371mr14270405ad.15.1758756799797;
        Wed, 24 Sep 2025 16:33:19 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3ac4sm4542475ad.5.2025.09.24.16.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Sep 2025 16:33:19 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <294A93D3-4FBA-46E7-8814-1C7E0CC82359@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F14A5A4F-4995-4DD7-853B-9A5FD1AB60CB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Wed, 24 Sep 2025 17:33:15 -0600
In-Reply-To: <20250924011600.1095949-1-kartikey406@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
To: Deepanshu Kartikey <kartikey406@gmail.com>
References: <20250924011600.1095949-1-kartikey406@gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_F14A5A4F-4995-4DD7-853B-9A5FD1AB60CB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 23, 2025, at 7:16 PM, Deepanshu Kartikey <kartikey406@gmail.com> =
wrote:
>=20
> Fix WARNING in __alloc_pages_slowpath() when =
ext4_discard_preallocations()
> is called during memory pressure.
>=20
> The issue occurs when __GFP_NOFAIL is used during memory reclaim =
context,
> which can lead to allocation warnings. Avoid using __GFP_NOFAIL when
> the current process is already in memory allocation context to prevent
> potential deadlocks and warnings.

This quiets the memory allocation warning, but will result in a =
filesystem
error being generated (read-only or panic) if the allocation fails, if =
you
follow the code a few lines further down.  That is not good error =
handling
for a memory allocation failure during cache cleanup.

When __GFP_NOFAIL was *always* passed, then the error could never be =
hit,
which is why it was put there in the first place.

It looks like this function can return an error and the caller will =
retry,
so that would be preferable to causing the filesystem to abort in this =
case.

Cheers, Andreas

>=20
> Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> Tested-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
> ---
> fs/ext4/mballoc.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5898d92ba19f..61ee009717f1 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5656,9 +5656,11 @@ void ext4_discard_preallocations(struct inode =
*inode)
> 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
> 		BUG_ON(pa->pa_type !=3D MB_INODE_PA);
> 		group =3D ext4_get_group_number(sb, pa->pa_pstart);
> +		gfp_t flags =3D GFP_NOFS;
> +		if (!(current->flags & PF_MEMALLOC))
> +			flags |=3D __GFP_NOFAIL;
>=20
> -		err =3D ext4_mb_load_buddy_gfp(sb, group, &e4b,
> -					     GFP_NOFS|__GFP_NOFAIL);
> +		err =3D ext4_mb_load_buddy_gfp(sb, group, &e4b, flags);
> 		if (err) {
> 			ext4_error_err(sb, -err, "Error %d loading buddy =
information for %u",
> 				       err, group);
> --
> 2.43.0
>=20


Cheers, Andreas






--Apple-Mail=_F14A5A4F-4995-4DD7-853B-9A5FD1AB60CB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmjUf7sACgkQcqXauRfM
H+A+2Q/+KhJn/qn6CJFMmsDY7t2UYqBz99PI3ZQiloG9zhN8TiA1Dm1sVIBfgjBO
y97wluHI1O+Jg4ZvAsfXGDeCXazItLhxWaBSeV4BZcmQTZLXB71VfP9KNgMWkaLe
h8zNtri+m3zE1/+KHr9K82HnufpLwg1jjOIrl3TBHElR8coCHb7QrQdvyvXlU30n
2HN5kSwxCMdB4VbUxND0IQuTaIC928T2zDB4b+8A65cyBt6Fc5BqfaL/p0rhTZyh
lqna+ssQ6U2ONnNY4/u2uDo/GfYzvWIKMn0uUjeK+ITFurr3keqtY9vveHFT7mol
5eJsfzfM2ArYscESF4N8T5uEyBvN9nO2V++wpn76vK/uStlmN3miRP1YX24/Cw6N
T/AtSLblEWP3+zYFkRp4As/1ZmktUCvm6XAT/XFvtjvQP6g50ZL/bOxRxMhVvvN4
7lr0Pz0FtlkQIkkOZiJR5DlpUT+VK3msa2G7rr4CbB+gsC0vUZ9IkWVC+388rthT
oCTu2Z5scLiaZAo54VOOELRL17h1iGi5vCT+eXEGrBbbtz/du0WAkbnUqrKSacps
/x8invmHwsTVImMzX8bAJVy4klP+Ch5ntqna0NTjEfgV+nt6f1Q4bkRnDRKafyrE
elZX8EiaAviMlq4xiPh2CRL+2drmqI48dQPQV5MWDSo4e8taIOc=
=lAjr
-----END PGP SIGNATURE-----

--Apple-Mail=_F14A5A4F-4995-4DD7-853B-9A5FD1AB60CB--

