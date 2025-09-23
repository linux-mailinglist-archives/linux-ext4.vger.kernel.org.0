Return-Path: <linux-ext4+bounces-10376-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBCAB97296
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 20:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161091882220
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5382F9DAD;
	Tue, 23 Sep 2025 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="h3if5QOI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF52F657A
	for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650688; cv=none; b=WfwRl8cR0LygpxpAoG3wqWxagkweYeDsdVLPAzHzYoKl52kfFoUlbPGh+c/MJfVoBDvrTStHx8qqTLokXSfvTDH2cRwRKnr3qsxbdz3fOGnehldyzzDmwyqNk5aw3SlWLZlUvMJrIf5C6Mqk7IggBxSTOSArCKTx/dFYqP7t+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650688; c=relaxed/simple;
	bh=zWVO+vdlkeWjOprOFQ9kDIhYZ18s87bOMBP3TGItuQA=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=D98ITMq7GGNTv9d1NFZ4JEhho2naI/y6CzLxq3B1UdX7R5n1YiFVjSzQckKSFa22eqvG5gFYVErHQkTzUq/faQxVq75Ng9KP2eMT89Age6pBI42RiWlQBxl0cNqXNmp5Z7gyLOInqyTswDRZBQKmXUJogte+kjh+kXHqPIHYP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=h3if5QOI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2570bf605b1so74508035ad.2
        for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758650685; x=1759255485; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qpm9WHJ+yd9aCLrvP7toHm/LbnR1ONBYhtIYo04cF9A=;
        b=h3if5QOI/35lIxBgu8M9K++wh9+upuAuZy4tjJkv/Jv+qtSNqPcMtK94IJFSFuskcL
         XqTDPiJCQ/YtdLjnmiPp9G+iAqkBvHxghrYMaDWtWL4KO6dHnjlpXkT6YfnV2o6EOxdb
         rT5jFip4LWV41T4RAH4isxwCw2xYTn9WGk1qGkafheCNMnwj/clSdH0zkmaGA/peFZn4
         2/LvzbPFIB8Mj4Nv8e8ZP5uIFXUpC89rpruQZcQq8caAGpHWVm2n16wCHm2uoQGO8GYo
         ni/RkPKfwHICX/npRDaRJKdQLCnWzcQe/LuM2qHqr0RmNMEI+4ZRUrbMakH9KRja7tZQ
         TzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650685; x=1759255485;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpm9WHJ+yd9aCLrvP7toHm/LbnR1ONBYhtIYo04cF9A=;
        b=rnFTXhC8qaUC7ulpWIJUua3ohEZzkJ46tGqVzXGa5tQNS6h/MSgEk0Nmlfoy3+pAnf
         gE22kaHSw5XQm4h3qeT0NCWapozhtgN0ZCe0Kcmy0n0UtX43X2PmdKvpCnF+6v2bZ9sJ
         7Z8eF+naBwyr66v3VcY18qzahYpBbb2qDKqgjl81B3UHLljyWiV1U8PHfwWdMsKJRt9M
         OuAtH0RTRS+Yap/TqU57Rkup/ilHevd/NZDrMMyf0SIF6zEFYFqJ9FqUFgmyN6dKOwXy
         WzbvW1+eF6zvopi4XdojoCpMQ+lbqhlne3FSf7eiAai2C/wUcugqOO9kQWHKhnWxs/vw
         FeGg==
X-Forwarded-Encrypted: i=1; AJvYcCXMtid8Z22dEkPcmAIcR6ZPp9JS9n1tfuscRP9uh0o9rfRsOZ12XN1SacQXglrbiymju7Yvt2gqfJiw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vsop7yw+FOk8Y1BvqpnONATo1sE4FjfN+E5gh87hce8J35fS
	MU5EWoeLVsKLPZ2tf3fU3ZgKmieArUWgFbHLXAdMUE4GBacmBxpRUqXhMW2eQVkidKU=
X-Gm-Gg: ASbGncuoFwUVzUZvHgSNnNocazossYoE02Wm+p4lz00tqWr4GN0laKd6hJVVq7wtHk/
	MEsIGFuA7LHc+7bkdM0xAya2iEydpt00UT1Oi58Ae1EwVV1rLnAi1IaXfbXENHPpEW6CK3yHxBw
	clhDDzpp9ksZxxJbp5XP93EhAHDz2O/xNE4xR/ne9Y0ZoMNfZBDA9IZcAbKFJ475BzUA5h6ChVl
	X4sXfxfmyYFUpHdGvZqtxLC5xvdWqOqIQM6GzbCKPm+ASx65WvV+4IRHkMqQWoIMLjXdpY/Ru3u
	qoUkrpHLdt2DVttdaP6nbx8BzdQbqqEPeR3neDbjmA//GNnn3xrAHoUlNjzLqL/uGKPfy0i5xrW
	UcfcfZ5WzhXaHP2ysBfgW/96R657y8+jB2jcdIhkoYMS0ug9VJikckUEBweBXz/OLf0fpQZ+OIb
	wUjNanag==
X-Google-Smtp-Source: AGHT+IGJm3sa4UBJu7Sxalsaz8xraWlExs99kKjgwwF/l8jbkU55MnumMfmIjjrJqbjXH0MyuTwtug==
X-Received: by 2002:a17:902:eb83:b0:246:441f:f144 with SMTP id d9443c01a7336-27cc76e22b6mr39263695ad.56.1758650684953;
        Tue, 23 Sep 2025 11:04:44 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980310ff8sm164722315ad.110.2025.09.23.11.04.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 11:04:44 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <AB6112E6-A3CE-4232-83C6-9099463A7AA4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A21F9726-7867-490E-AA14-21DFD1F033FA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: validate ea_ino and size in check_xattrs
Date: Tue, 23 Sep 2025 12:04:42 -0600
In-Reply-To: <20250923133245.1091761-1-kartikey406@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 linux-ext4 <linux-ext4@vger.kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
References: <20250923133245.1091761-1-kartikey406@gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_A21F9726-7867-490E-AA14-21DFD1F033FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 23, 2025, at 7:32 AM, Deepanshu Kartikey <kartikey406@gmail.com> =
wrote:
>=20
> During xattr block validation, check_xattrs() processes xattr entries
> without validating that entries claiming to use EA inodes have =
non-zero
> sizes. Corrupted filesystems may contain xattr entries where =
e_value_size
> is zero but e_value_inum is non-zero, indicating invalid xattr data.
>=20
> Add validation in check_xattrs() to detect this corruption pattern =
early
> and return -EFSCORRUPTED, preventing invalid xattr entries from =
causing
> issues throughout the ext4 codebase.

This should also have a corresponding check and fix in e2fsck, otherwise
the kernel will fail but there is no way to repair such a filesystem.

Cheers, Andreas

> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=3D4c9d23743a2409b80293
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> ---
> Changes in v2:
> - Moved validation from ext4_xattr_move_to_block() to check_xattrs() =
as suggested by Theodore Ts'o
> - This provides broader coverage and may address other similar syzbot =
reports
>=20
> fs/ext4/xattr.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 5a6fe1513fd2..d621e77c8c4d 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -251,6 +251,10 @@ check_xattrs(struct inode *inode, struct =
buffer_head *bh,
> 			err_str =3D "invalid ea_ino";
> 			goto errout;
> 		}
> +		if (ea_ino && !size) {
> +			err_str =3D "invalid size in ea xattr";
> +			goto errout;
> +		}
> 		if (size > EXT4_XATTR_SIZE_MAX) {
> 			err_str =3D "e_value size too large";
> 			goto errout;
> --
> 2.43.0
>=20


Cheers, Andreas






--Apple-Mail=_A21F9726-7867-490E-AA14-21DFD1F033FA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmjS4ToACgkQcqXauRfM
H+A+Cg//dBCfBgzxfBfc7nGRbY7D4FN+yGjzvlXL+i3jcZXFNiLhvo6z7fq3ciuY
uRFWWcKyrYSS/MWbBB3hZAWHRKxpEwTAp2Y7n8jOu8dc3ElIjJ9zbdsgxUsSLxY8
s/TJ3jBeGZqTEv1qLP+imuuf9bOa46FYz0wmp3LSVa1Dbo8voihDVmLQNVH3mljS
e8MfkyuT2Zm5y040v/nP/ttHryBYZcnUegOaJDMAhTeVjbauGnD3911IA44dIqzG
4bfZ+wL3/cOg9vzJywAtXN1V4LJ85PrRa/Kb0JLPXqUyXnY4c/Iqu/HRKAuOEJKo
XGws8Sc5qkRufO535K8nTdi9tb4FPNrMYSXF7sSw0bUs9SqN8Hp6PUmTbTCcb45d
vyNPwOrMMg4QDWrV0uOdO2bXYlLxjheFvwD8yiTizR82JNuebmnjbU4r7YAOGFe3
hfU9y2KNyT8E6IeBjhY6f6TCYUji0XpgMsfpq1Ja35dpsOY0JxeOrUJrEtK65lZB
a6xvnGEt0LGoHBGhBIAPsKX88PsxlpADBlQ9Rh8izjNVTjAbEIGV+OwGghp3Pltm
pMRiXjKuVgAdsursst1SSb7lb1Z+pKvYgnhnnj9WjXCqIsbLqOF6aoAZ0r+//zzn
mZ5ypTmCI3xIHalWUASb5n3Yxb5DXbYXMKwwrrSkoONg7jCAog8=
=xulb
-----END PGP SIGNATURE-----

--Apple-Mail=_A21F9726-7867-490E-AA14-21DFD1F033FA--

