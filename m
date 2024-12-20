Return-Path: <linux-ext4+bounces-5832-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA69F9B2E
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 21:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CA87A4074
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 20:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894A8222D44;
	Fri, 20 Dec 2024 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="cSiJwqAx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102941A0B0E
	for <linux-ext4@vger.kernel.org>; Fri, 20 Dec 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734727139; cv=none; b=jdeDF/NFDZfL+zpkraQgWrHs/3NshgvBV5ZW0W/OSTDai5MBiWYD0x0WOZ4bcMafUuKyNn/cb/5Pe3SmJX/GAI3N98PrsAfGr24n3f4m0Uu76vxyUmWYIiR5Akr7HAkrYeqNInwaZE4cnzjDZHsNNByVwjw/Xse2l0ifmErbKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734727139; c=relaxed/simple;
	bh=uW+BnCg+MD0W3pPnds8IVy7HPuxeyOGZ5MaD0HcyV0E=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=UzXkNVSEUQ1YJutTcblHNoAdgI+Fd04BYOkEyYIHGQJedenPtySL6TUdGrSqmI/82KthTfpnwiExaB/d9ZCt93X2Do6wErHvjHWsw0sSsIBG9SSNQzZqD0Dl8LVqvnh+MdGlM8VxWC7t3cEOUhSgBdJ60/ubEHoUUSF2mGXZ7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=cSiJwqAx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2165448243fso25738295ad.1
        for <linux-ext4@vger.kernel.org>; Fri, 20 Dec 2024 12:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1734727136; x=1735331936; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GTpIjtU80fKN8lxRAkU/2Vv3ZeJhE7hGW4NFMYEIb5Q=;
        b=cSiJwqAxFLZdXB01ClG3HAMiJn06U1fR0eN6Is/JIk068n7xEP/JJ8jNcpmHWLyT3X
         UcV9UUJ2FInNp233vZdKsemqqNYwyb+dcypORz7iYvcdvIOLObJzDXN3qyN9DFES8PhY
         CJK0oqF/2AkUwtXabEZbeFWHSzGK/esP7kfuWY6WvNyN6fNURdjvFgDv88FyUqsyO53q
         db6YSF0N8c4AhC3kzV6PnltcPLozY6rTfdO9Ajt/Mp/aLsOgRPeZim6HZkrGLs1C7AdA
         ytikRaGnm5P1CJpDpz9R42eRSkt6nGJc2r00f1AXKtUMZlPKX33sd8RfwKu6f4Hf01WY
         Rl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734727136; x=1735331936;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTpIjtU80fKN8lxRAkU/2Vv3ZeJhE7hGW4NFMYEIb5Q=;
        b=l31DfyltdHvLtbgX+fR0S6wrDriIQlO+olZ8+Le1VadSWi5W4iQTnvQWprT8GPpKB4
         V10IU724IU0XRr9U9/YKTSccaQnqjshrc7HKshxZtGpy21P1229rRlB2CgaiEgzvYXOh
         zzMRgjQv2rjkQ3CV/qhK+IR6T2V5W6DeBdayg6jy2xXcnvuKdg0/04tbqGPIjGR/nRf8
         hQyFItBB44EWCSAVoID7pdTGKEHp4Qsr4H2NMKyXfBazQeZfiUKX3meEkF31UejXkRp4
         qW5iasZc2uejo/E7/aPtmGsteya0NL1oUGxnkUaR5a1Ai1N6CLRQ5PzjZ+52A3w5G18a
         Jb+w==
X-Forwarded-Encrypted: i=1; AJvYcCUXM/rtoF0kOVbg+HgbboB+shNAUNTqghxGhUJzaGBrMe6x+R5QUIHR1BYFi/7liKVXtmBjSF9GqZAh@vger.kernel.org
X-Gm-Message-State: AOJu0YwO9TQz/PCuDSAdLLPEEXxFawqbON6mgOAyQw4tMediLM/Lo9n7
	KZhjTmWHjSj5PtaYzVSs7Iqb9XqebMsYP605UYxJK3g84ls/hhZgzuvKDwnV8aI=
X-Gm-Gg: ASbGncvXkeYGv+1+wOPiDEb7t0sOc3U/NV8emTnhJ6ZsHvFLl69GQmmjHMdtnXqNlQ9
	H64uzRhedI+53IwIQsGvi2nslKZXXh9x9KlV1L9akrMLUmzeiTWN0dzNg0K1URweVfkZ/7gRVsj
	SS9RCEVtxQY1CwXenic0WNe2XPFurqjARS/e09gOHRhgQ7CL6ofutkaGnNoUxKvU28Z3j+Aj2rI
	V3u4pIItaCtf/8Mw7ezv4RCvG4L1wmfBPPEzUQmMpYvbeACHrvUEPIj47Le0EyJmmmTjwbhnS9i
	C9XpiK2VRojakozzE6qbKitsduvQ8g==
X-Google-Smtp-Source: AGHT+IEItlVuDb479mjlIw/m/zL9hJVhA1B8sMgNqMSMIqeBWJo9dTSvNVGcKAS+oa6NlcFVXJJeRg==
X-Received: by 2002:a17:903:24e:b0:215:5625:885b with SMTP id d9443c01a7336-219e6f28552mr52002765ad.52.1734727136319;
        Fri, 20 Dec 2024 12:38:56 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821da75sm2795286a12.36.2024.12.20.12.38.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2024 12:38:55 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <CFF7E7F5-FCF4-4F79-9A12-CF5937BB93AC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DFA50C14-A996-4A59-A3B5-57D31B461495";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 6/6] ext4: calculate rec_len of ".." with correct name
 length 2
Date: Fri, 20 Dec 2024 13:38:47 -0700
In-Reply-To: <0fee3433-1255-42ab-80c6-63a1d9f9d47b@web.de>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
References: <20241219110027.1440876-7-shikemeng@huaweicloud.com>
 <0fee3433-1255-42ab-80c6-63a1d9f9d47b@web.de>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_DFA50C14-A996-4A59-A3B5-57D31B461495
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Dec 20, 2024, at 6:52 AM, Markus Elfring <Markus.Elfring@web.de> =
wrote:
>=20
>> The rec_len of directory ".." should be ext4_dir_rec_len(2, NULL) =
instead
>> of ext4_dir_rec_len(1, NULL). Although ext4_dir_rec_len return the =
same
>> number either with name_len 1 or name_len 2, it's better use the =
right
>> name_len to make code more intuitive.
>=20
> Do you try to point a correctness issue out here?
>=20
> How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D =
and =E2=80=9CCc=E2=80=9D) accordingly?
> =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc3#n145

The patch is a no-op in terms of functionality.  Dirent lengths are =
rounded up to a multiple of 4 bytes, so "1" and "2" give the same value.

I was looking back at the changes to this code, and it has existed
since at least when ext4 was cloned from ext3.  In older versions
of the code this calculation was done *before* the

I also realized that the original code with "1" is actually correct.
This code is calculating the dirent length of the ".." entry, but
this is actually "the rest of the block minus the the '.' dirent size",
so passing "1" is correct in this case.

So this patch should not be applied.


Cheers, Andreas






--Apple-Mail=_DFA50C14-A996-4A59-A3B5-57D31B461495
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmdl1dgACgkQcqXauRfM
H+Dt9hAAlmWKS0EPwWZ0PO0r1ThLi4pC6pBUlykxp/3QjGM8+qltTl3yIp27Ycc5
bD5LS7F0lUdCMRvQxg7BOkHYMIcvWDKfjy06GDN8/p1TzvZIlRewpTySySkY1LLK
R5oyS7Nn7GIdbgzKmoKDt6zGrLGdiHQEcDV4X2tLoizbWaOACWyu6Z5CwvfGpY+Z
19DUUBXtj5y0g5icSdH/xJlZIEX/85hUXBp4Qy5Rz2cVVMa5hZdWeGIuNVAvHeKc
Cnk5fwJgncg+0hDpmHuZEkO0ogRquVicE2Ks0fm44O1pK827wvX/ve/4K+nwEhrj
yAIATzbN6n/efkcGge83sUd4rd779QX9c6rrMIKS4dsX2eugeo0I7tfeO2FsnExd
Q28rvQINqobfOjlJCjVTWhaBT1zNpYUxaKCEIjZKA+dFOm2GBW/XlVhWv/jbWY7N
PtIgxNrRHrysTwh/9RNfmFCeCd1WZJhE6zM3maQ0hPNV5mvI74lof5l7Br9RDBxz
jaHHfBbqv1GJc2RQ7qhwlGESQdUTFmvo1XJa7w74wCgF+3DFkZkYGcuDId8M6//W
Fq2eDurbdUwQXWP3K/sTb6ankywNFB2pQwCXaS7nbgSix7uhKQQtnK1u77Ib5OGX
ux9OqZ4CPZNjNi5iK1US3dmCkup2EVsRD4Gpnuihva4+i8WDTBs=
=nbvo
-----END PGP SIGNATURE-----

--Apple-Mail=_DFA50C14-A996-4A59-A3B5-57D31B461495--

