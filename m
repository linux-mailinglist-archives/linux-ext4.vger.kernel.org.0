Return-Path: <linux-ext4+bounces-10320-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C61B8D220
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 00:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A784317FD90
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 22:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFBD261388;
	Sat, 20 Sep 2025 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="NASXzWdj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F22571BC
	for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758409156; cv=none; b=Kt9ANvo0BM9yMVCG6pVJ+Silut13dURfSFkO2jmC6awIpEAsAHEVsuWe/umXcQhgLmKWwOjKiFQqw3Wq/53XaJIPAFTmI7//PZ25WbfSFB1cbtnLVFBIWU1xcC50qKiLP/yfkSHNkYI1vEnguUJ66T4KeFgbTmQgrbugqwZxZhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758409156; c=relaxed/simple;
	bh=/AX9alijyFc9rxkmqUgXWsAoXd3e8k2Jcv0ATUaHRLo=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=JKKwkHGQF7c3Wql02OyNy/aNw3zv/jNE3qDia9TpT+BKbMg299TeHfO5MVjhe/HRc7U6ZgQLPetKu2TMcRucQSRW2M9A+lGAs/W3UhXiX2EOPWbr0FRebMJicNmv3CDPgt3hbhQSTwsWH4bVeX5qdyH4XLtWLFpldVoBEZu78Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=NASXzWdj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5229007f31so2460460a12.2
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758409153; x=1759013953; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEz76/Vs41fnvJuc5kakJw4s/0kzYdkfRVOudgrBm3k=;
        b=NASXzWdjfpsicY4HU42PxjtURnPyNu7EcT0OFpG7c6/7EKq9o/trYMgCVGyW+OfsrR
         iyhUvz46IbzrVsOrfEpa/cmAH6uUfhA5zKtmC+Cykx71MP4YgGXEj5wpFvpK+WmnWGpJ
         NzGeGMl2OxbY50Z7yMOa2UmTfzr7dvmuTTWjqkQ4+nSdGGi/qHw8gYEm15slA1A1EGqh
         u3VG8raYcpj7GuHNYGMkD9HkN3S1OLW1HKrCjKZxkOTyOgGX5pG0EQLzdYvYlnBA41/K
         SKiHZuApqRhOdQuteS6JXz7ny/Aukth9+GyCJSZFzCQhLHM++pru4RaNu+c7kyX0Csja
         3nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758409153; x=1759013953;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEz76/Vs41fnvJuc5kakJw4s/0kzYdkfRVOudgrBm3k=;
        b=A3e3V1g0HoElfsm02b/RdUf2nTzeh3Cj6NaVLNImWHx3CwMWTva84RUmQ1kpOyYX7Q
         kWC53R4sfnapXLg8tFcVFlMImO4iNPfkd+ZG/kC+n043ln8EtPKCyGk0rzs5WlYIeHfF
         iR0RyhiwrYlQ55G6+rWQFZ4ce/3T5dXZgemXcdwgZT7xo1tMw2RP1rNoOz64XqHeuyvk
         fphMemKCh1eIfaJ2lcvMShtGacrqOQsZp+/fzXhGMtEixkus5K9iYv3cvTVGH1Cu6ORq
         37w9Vv6IfPXkzcPmmXY0B/iFwGTtL1EZ46gnnexRFZEL2pqmAh/Sv0tXiu2CuIoAU0K2
         PwSw==
X-Gm-Message-State: AOJu0YynE7XZz67/p+6PlPY05lsVFvVCv16ilnNFs6xZPeD3K2e5EMN/
	ANE+z0Egj2PRzGMv5uEiXhrkZ2uBPIbepiZkbIwOcAfn56P4J/j4MBke/G1tBllFSbcXL3Sz89u
	7kJOF
X-Gm-Gg: ASbGnctO1n56K2YKERTLL+CpSZcA5YrZijkvAIXMEhZArLj6W4UEQEtrfkY7SFWFhgu
	JjoDZML3Cy6II4PLDdjupBPU9QRZnYvgUXgItzyBraLQRQ28SAfoubl/sRgwmTE9Oa7y2Q7WmOY
	WljixFXmfnDnjHFzdYmZzfByeuIyWuKxKBpKEf56/yuOnJsEFs5Bai8NlKqFdYr/hIt0uzYq7PP
	S7Uh28aK+1Sn9Y7HXqWCzbkaSSPaR04mzRhjOyrd9hVthZejvUkD5y7GnU4culuVDUS7URrq/GM
	KZvLqfWpGzddEFAj/xXIsricN7BDzUX0ArAy4YhKTotylWowdYPWOqRN91A3fNQvMWadYIpj880
	SGfuJWHDgkH40LRS5gX+URlhcnmWkbovWt3nQYSI7i/N9S08JaQ8QthbwJqdsC/KI4by3PV8=
X-Google-Smtp-Source: AGHT+IFtIPnSuzZ1EbUTVRWqG/Mp/YEyCCt9bC6lckSTRWP77Ngf27Y0cm392QAotGY08DCfFA4yWg==
X-Received: by 2002:a17:90b:3a4f:b0:32b:d089:5c12 with SMTP id 98e67ed59e1d1-3309838e042mr10161409a91.33.1758409153447;
        Sat, 20 Sep 2025 15:59:13 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea101ef2fsm6512118a91.5.2025.09.20.15.59.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Sep 2025 15:59:12 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <728E8839-CC3D-4316-9FD6-7819CCE0DC07@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_76DB856E-4AD7-4D3C-9B59-9B25FFBCD0CB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 4/4] mke2fs: fix missing .TP in man page
Date: Sat, 20 Sep 2025 16:59:10 -0600
In-Reply-To: <20250910-mke2fs-small-fixes-v2-4-55c9842494e0@linaro.org>
Cc: linux-ext4@vger.kernel.org
To: Ralph Siemsen <ralph.siemsen@linaro.org>
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
 <20250910-mke2fs-small-fixes-v2-4-55c9842494e0@linaro.org>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_76DB856E-4AD7-4D3C-9B59-9B25FFBCD0CB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 10, 2025, at 7:51 AM, Ralph Siemsen <ralph.siemsen@linaro.org> =
wrote:
>=20
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Looks fine.  I found a related formatting issue with a duplicate .TP =
marker
in another part of mke2fs.8.in, and have submitted a separate patch for =
that.

It looks like this patch could have:
Fixes: 3fffe9dd6be5 ("tune2fs: replace the -r option with -E =
revision=3D<fs-rev>")

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> misc/mke2fs.8.in | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index ffe02eb0..94d82082 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -739,6 +739,7 @@ the manual page
> Quiet execution.  Useful if
> .B mke2fs
> is run in a script.
> +.TP
> .B \-S
> Write superblock and group descriptors only.  This is an extreme
> measure to be taken only in the very unlikely case that all of
>=20
> --
> 2.45.2.121.gc2b3f2b3cd
>=20
>=20


Cheers, Andreas






--Apple-Mail=_76DB856E-4AD7-4D3C-9B59-9B25FFBCD0CB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmjPMb4ACgkQcqXauRfM
H+ARBRAApR+hAzVcCqAuXxtcY2y8B6ldxH5oSp3j8UuFdmRTa/o6hMw6t1WUp4OE
7AD7KimA/hvibHG3hDHVZLMzWL7NO5/faLemS2UPMBqxStx3qkz8umyuUp0MqYP2
HC1cRahaERwrYXd0kd309gPzXMxz2YlVEOS+/6M8CMOY3jT9CPIOhQWJbuGV4h9j
1nefhYYqrJvTBuFtSGvRYC6+22uK2dfuFvsXihln1l3oOIrKUAWdkQcYPBKbvGIJ
oNyZe5QNRh55CewSA/Jg2sFlYc3lsggRy4yfqAf/FncOFWtrkWpeo7d0BVOxIhCS
W+Nkg14kEWRb0lrpTbliI/uC9L5PdQCAUYs0cSsUddjGaMpRQEjT3gPy1WmFxALH
LHYxRxFeX2jWtI28C2krRsQ/o4QY/f8BmOvjXHZTx5EQHMXmxt3g7eqeXgyCF2zM
A1WGHr4JCT84BTUgc1CNaHs+tvrE0MGlWEzUfivbfx2S+8xe2V59cWbNzkJvo0MF
8Kq2bAgedDAk7AYuuhr4e7afUIDgbOvdUqe9iXpulpbM4Ipl5Jyf07jaZOJgWg3P
hZ3wssFq10Wj/WgUhRdVS78XCMjSR14Lh+igehKS9w1A2WKRlDGTw2ixlDVm0070
hMoO6dUntm5o1jQiepOKe6FHUeOwRRxBSCZ7zi8N+aLAf8oZVCE=
=Ueam
-----END PGP SIGNATURE-----

--Apple-Mail=_76DB856E-4AD7-4D3C-9B59-9B25FFBCD0CB--

