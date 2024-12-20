Return-Path: <linux-ext4+bounces-5783-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9609F8931
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 02:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEF016DCD6
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927614C85;
	Fri, 20 Dec 2024 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="IRBvezM2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA6017C2
	for <linux-ext4@vger.kernel.org>; Fri, 20 Dec 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734657035; cv=none; b=pWeMOEXSxbimGxXodpkxjAFnsxh4XMFUcKeRybSVXyGaYasgdY1HALCD8D4HvJvuwCeqB24z/yiDyF0p7s57FST4hSgJeQksCO4iF/NCrG94Ip5BcqnafKa03/P/G8hx2arUNbEQlY4F7CSPJflEqxlwHXCIkDVlhlQqg8FdV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734657035; c=relaxed/simple;
	bh=Tu0BuqL4uD9NrNYdm/FDBS/IoRLzaEb5d9URQkQoE3M=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=k1JzZxYKgC9ZNVTvPL0h304eyEMkHUv8RPUnptbm8DiHtPh2dPiq5joXsbv6I5N426gAQKa6HYMWgW9xUyR4FuboXuoZOmZiwjJcM4x0c1V1bJZ4WJWxXHA7+S0aYak01dq63c00BL0Rv3ublb+MPP2CdWq+3ClUaxa0Ofa9xb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=IRBvezM2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21661be2c2dso11348715ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 17:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1734657031; x=1735261831; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i4U1yqDN9/bOslq1ZT5mqBJ4NyD0/LWhufm3YYVCRYM=;
        b=IRBvezM2969OJnKkPGIMsh5KJrxhovK1pPTGLeiopUMbDjS07Szqo92yMdXf0ctl28
         2wtlpsNdC6yQq+md1PlfdkjvX9UWwWQ8Oz/B079zg99GYKJs+2q+MewYvQTwIAkihhIt
         ejLZrfOeRuJqA806HAHT4Sn2f2hAxhwxF21jY1/X7ggTm4yLDCmEMa6HpNLU+GbML8Lz
         0Bk3gFoVWwXh9VFZrr5RY13WBfgC2NWYzH1lEd/dHK3J1+VtzfIwHpI2bMnECbgawTVp
         vNC6l1yVVlNDSZQZCoyGFctcoEpOWvTPCO9bLwCppZxPr3OGr+QoBTVvGGyBAM2BLitE
         ecKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734657031; x=1735261831;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4U1yqDN9/bOslq1ZT5mqBJ4NyD0/LWhufm3YYVCRYM=;
        b=bNEU2DpYzF9aNO/pwCi7eqUC4xe+V6SNQCapa27UbFRXyUgHONN6h0uZh/5FiK0FCB
         WWIBE+Bl7jL44qOt1k1bFtamkMeRfNcEJieHfcPJHs/nYn0KqjaIXnv1Pdh5dkklITw+
         km7pbnO8JNSBk3xLecWLzm/2tL5IafUhf69YXuBNSpyUrd10eUf//rZ4kxT1MO7HQy6D
         IF7EzwiGTRWRy7UyCkxE9ZpCKcNTKtgRe+3LFYDiYE0OUHjMFOMhYj/Kj1WhcpYTYQDe
         PQDrW3guVWDSe3/q8BjkI55DMEqPyIt/FhbGuTS0flfNKWP2E2jvs/kO+wy9WvMVe7jl
         F5kg==
X-Forwarded-Encrypted: i=1; AJvYcCX4cMrfcAyNNpf52PMAf0CSxMLQPpMSZ32BNROOPAxkz6g05NU3NpxT0uCUM1mLDUeDlBPPtdJgf4NY@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOUoZWxvuLlNHSSdPZes9D5gUtrGmlsyYvZwrzWgfDFKWVbmm
	GoCBAbYJtt/aXZ2BplgaxmLVjJP2I60g/hEO0sSBHoLhUMfjRKYz/z/pw+/RyjI=
X-Gm-Gg: ASbGnctzN+S99lrb2mBi6LrYR/Qjg38SdxOQt0a9PoAq8zlSIpnLR5fxbuaHg5CqFgs
	YME3d2lkLO36gA6F4fSgYVCMvqDRSF38+I6xS3ybIaE+YgE8oVGo55PEd3ECWCZzRuEzG+OybeW
	1+2KrFqulB6ywLHHlNuU6skFC9TH2RVp3IHL8fU2/lFARwPKV7u/bVIeLOfLfYrEKYmzDA2LmLz
	bhFfNTPDIqm21BGqHOr3HD+L3/NIdok/Q5NreOrGxHuRxhuDPF4vjf5623EvpswB/AG5lP4tK5C
	GpwmSmrc1tBrVny1xJiiIAwqxL3Q6Q==
X-Google-Smtp-Source: AGHT+IH0PETUbD0pVxxjARtBP3LTXsBcRQZ3wLgsiAei0+x9QVnILHeCdjIAE7RBRfY0SN7Q4RWcrQ==
X-Received: by 2002:a17:902:c948:b0:216:2a36:5b2e with SMTP id d9443c01a7336-219e6ec0a15mr11192045ad.32.1734657031130;
        Thu, 19 Dec 2024 17:10:31 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d0asm18567895ad.53.2024.12.19.17.10.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2024 17:10:30 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <8554AB6E-55CA-4F61-BE34-1260555785D1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5BB9CF6E-164D-44F6-B024-3A896C99C2C6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/6] ext4: remove unneeded bits mask in dx_get_block()
Date: Thu, 19 Dec 2024 18:10:24 -0700
In-Reply-To: <20241219110027.1440876-3-shikemeng@huaweicloud.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-3-shikemeng@huaweicloud.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_5BB9CF6E-164D-44F6-B024-3A896C99C2C6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 19, 2024, at 4:00 AM, Kemeng Shi <shikemeng@huaweicloud.com> =
wrote:
>=20
> As high four bits of block in dx_entry is not used by any feature for =
now, we can remove unneeded bits mask in dx_get_block() and add it back
> when it's really needed.

Actually, the opposite is true.  This mask protects the *CURRENT* code
from any future use for these bits, so removing it now means that they
could never be used in the future, since the block number would be
taken as all 32 bits instead of only the bottom 28 bits.  I don't think
we are in any danger of having a 16TB single directory any time soon.

However, the top bits were intended to store a "fullness" for the index
blocks, to optimize online directory shrinking without having to scan
each of the blocks for how many entries are currently in the block.
This would allow the dirent removal to easily see "this block and the
previous/next block are only 1/3 full and could be merged".

See the following thread for a prototype patch and discussion on this:
=
https://patchwork.ozlabs.org/project/linux-ext4/patch/20190821182740.97127=
-1-harshadshirwadkar@gmail.com/

I think removing this mask has a negative effect on future usefulness,
and virtually no benefit to the code today, so I would object to landing
it.

Cheers, Andreas

>=20
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
> fs/ext4/namei.c | 7 +------
> 1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index adec145b6f7d..8ff840ef4730 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -561,14 +561,9 @@ ext4_next_entry(struct ext4_dir_entry_2 *p, =
unsigned long blocksize)
> 		ext4_rec_len_from_disk(p->rec_len, blocksize));
> }
>=20
> -/*
> - * Future: use high four bits of block for coalesce-on-delete flags
> - * Mask them off for now.
> - */
> -
> static inline ext4_lblk_t dx_get_block(struct dx_entry *entry)
> {
> -	return le32_to_cpu(entry->block) & 0x0fffffff;
> +	return le32_to_cpu(entry->block);
> }
>=20
> static inline void dx_set_block(struct dx_entry *entry, ext4_lblk_t =
value)
> --
> 2.30.0
>=20


Cheers, Andreas






--Apple-Mail=_5BB9CF6E-164D-44F6-B024-3A896C99C2C6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmdkxAEACgkQcqXauRfM
H+AgGxAAi0K/XllJmNW954pdEgxe+D3UBeew1w/X0TGQhPYVLGdtEwoFrZ5McUsB
X0raYGX607bghCuHkEiSye/Ft0YXGwkMw7YjwI7vjXX0BrO/x/0TChcQ4Csw7Idu
LoOEWS+EV+BR1Mnx6737w2vdkzLGUR/qKnGurMl6j+UZKzHbfR0WRvPl9V3BrBxe
bXELaiDC5oQuJbS35e9y0JwwXw0V5gjDCIchFzKK6x4SxraguPGzHTU+X96KIYgn
TzUuWOY9KjJwKRLiO4SXQ3qANl4jB7yVoynVRwt5OHYHWoZOhBvvGEkhaE6zeME4
HtuRgZU5elCppI/GeDeQDBOAcTYwkTbV+3px8MAJzeGR6vOJwy57CbolqvUI61Nc
M5yVZfmpKT7T48KhvZOHsnWwR5pMEgDoeGaznmbZdQtagx+g+jIFNY1UzzR8aGNJ
DfJEd/XThUmzSoixvkADTviTAjNLgYtkrl6qCWTN0HkUTyaitcv3JbclQsTlibXx
PQQ2ONbrDweacFcsCBJPJA0zr38qt30CcrwTzV7lAenmGnjQi5ow8iTV4l4vHyWU
D0aHsvLzrk8atILRYoSF7fiQCaIsfxHTGOntuRKwuqJF3pJlZoabUVBbRIr4Cfhx
AFceu7hqz6hkCTjs5xbTUasRJetoWxpy+Vo1Imd5tqh3nQfCNfY=
=3zJ8
-----END PGP SIGNATURE-----

--Apple-Mail=_5BB9CF6E-164D-44F6-B024-3A896C99C2C6--

