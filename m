Return-Path: <linux-ext4+bounces-10316-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B47B8CF06
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 20:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5BA7C772C
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 18:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4773831352D;
	Sat, 20 Sep 2025 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="BtSRkdbQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48992AD31
	for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758394365; cv=none; b=VvPcfNm2+qlKaXL9meuqIRpt++RlgK0/Y5Om4aos68NXUDaZa+AbUNOeOa4ZW+wOP9t/uHhLIhmqIHrQUWvWEuvFTMTNk9jSL048ssPGnSV4a/Q1PROBs1nlWrkn6SUrbpJPV4TUCD0MLf5pvgzHOn69yt6sBRTdjy0tPc0GqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758394365; c=relaxed/simple;
	bh=z2cUo209xLYDY5RoGZpyYdNVUF709CfffeQN+p3BAsY=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=p8r0DSTZIiKuTyWYGFcLMoNHxmOaai35tx3nWh1pDpuD8fEWyo069XtwSpp91Fx9KBfjxTzaQthaTGMHKh0m70PK8Lld0R+T/u2sqPrsmblGMbDoD46cGAcq0JwKdgNSM6PCoV3NWpCxxkrdsVmFBHmzKMZ/mKmT+JmeMyY26Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=BtSRkdbQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24458272c00so35025245ad.3
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758394362; x=1758999162; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/97B2AXC0guHtYyEhZgUte7KqepeTioRQdawVbUe+Hs=;
        b=BtSRkdbQMfiLTBCPjJWm7QqrNCAou+PitoBh5rNNTa+B+2ORyJjY+OB8h4vd8Ls4UY
         Ofd0d6pFHXsPtYZyY2YHg4L9LymxIK2XSiFFCLF1p8agR210FxaZjftFY/6pEOX8NeA7
         Mzid1zxJhk6WBfxKfFo297Fsc5d90hBJ1imGuGjvyYbpv7aX8BHyiiJh3BdN5ySkbGLS
         U2Ag6z13a6HzVIFmftryIetvjPg9ujvNCaywjY+MhGMd9Oot5w/2dP+r/Llsfwe0M5LU
         2q7ebJaj8ZuuKfMS2+CkoU+BwncLM6Hdr+eW+S98qqGQyd4iW+MgMy7uYKVLrVW0viTR
         DgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758394362; x=1758999162;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/97B2AXC0guHtYyEhZgUte7KqepeTioRQdawVbUe+Hs=;
        b=CxGil5tKCu7xjKlLcmYRaXcUTBQkavy05Q1I4AEzeqAzUTVACQczdYumMYH4twK6v7
         q7X9MK8iM5nGk4vHELaMAdBCp5YMQbGeCtceDE5CXBU5/7hkDNgWuwxCmPL0aR4Izl7d
         6Un2iLtHXoDit2AeldRr70Up8Wfxvb6m7WaHML6p4pXP6Z/CNuEY/US6LZaYeUmCJ8zO
         ej8XEQ2MuQctnG58j9SyscThZlZoI5qrcc2QlTgGq+9tTW/zYInIYbqa2XThknHvtorV
         ZLsF3j07ULK82o2SSFdKAxLG6jFfcWVpbLyl7qRWmvjeIEy0ihuTxwp2ZgUU8NqISylK
         JfxQ==
X-Gm-Message-State: AOJu0Yx0oX7Pg47SIUKgmtXYsvh/9C219RcpU3Jh/zaeOzU2PsKHNQTP
	37H1GClNwfM+lY6t02cKxi+lnd3j8Clgjt4niTBuDvDjdBz9gYL64YIsBJ9snhWA1yLPQi1IZIp
	gQTTD
X-Gm-Gg: ASbGncs3o46BdtAKmZt3CspR5NYJ3qH82RuRTgU8cBWp+UTGQhpvQs4kJbQla7bBiGU
	+7ndqpvdzUlDneKHgkR9Z6vpNT7mjfMLkBSaDO7MAqj6Lqd0xPa5QkA5gDpniBjuZL8q1Jq0628
	KeRTxXVBtSlwmsuRfUNAHC3X8XcFf9U5Ts9S1n2+Z44PkLbp5BqTUZdvIpKXoJ7HA+FWWzeBAym
	rgg5bYdWIYgKnCBJXCxvfwgvACzpvCCTRbjsHCgbPflkA0/u4ak3yHhPQsLrv2oJLfDlJSI5rs6
	Z2QtyeZZTGGrOsfwOZg3zEbHoxTBB7mW2rG9BmYdjzbJpx3YlFHhM+SgUXsHXlMx/JWbKFZtWea
	UVrICdx6q9kuIVEjB69Nn2JgoFyCpEK9xp4pmWLXEpa6BEy70NAGE3y8AN0TXRxsqsL95SIc=
X-Google-Smtp-Source: AGHT+IEtWQ1QTX1M89/TECCFICwm6LwgWv3M6DU1IP9VD5DMl9NzhikI5HymUukPib8wY5SGEFXyEg==
X-Received: by 2002:a17:902:db0e:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-269ba5762dfmr88888755ad.61.1758394362133;
        Sat, 20 Sep 2025 11:52:42 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053e77sm89128555ad.7.2025.09.20.11.52.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Sep 2025 11:52:41 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <F29BC06C-B943-4D2A-ACDB-2DE9FC015280@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C3B1D6A5-F642-48D6-BD10-D1B9EAEA5476";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 1/4] mke2fs: document the hash_seed option
Date: Sat, 20 Sep 2025 12:52:38 -0600
In-Reply-To: <20250910-mke2fs-small-fixes-v2-1-55c9842494e0@linaro.org>
Cc: linux-ext4@vger.kernel.org
To: Ralph Siemsen <ralph.siemsen@linaro.org>
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
 <20250910-mke2fs-small-fixes-v2-1-55c9842494e0@linaro.org>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_C3B1D6A5-F642-48D6-BD10-D1B9EAEA5476
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 10, 2025, at 7:51 AM, Ralph Siemsen <ralph.siemsen@linaro.org> =
wrote:
>=20
> For reproducible builds, it is necessary to control the random seed =
used
> for hashing. Document the extended option for this feature.
>=20
> Fixes: e1f71006 ("AOSP: mke2fs, libext2fs: make filesystem image =
reproducible")
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> misc/mke2fs.8.in | 4 ++++
> misc/mke2fs.c    | 1 +
> 2 files changed, 5 insertions(+)
>=20
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index 13ddef47..14bae326 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -320,6 +320,10 @@ In the default configuration, the
> .I strict
> flag is disabled.
> .TP
> +.BI hash_seed=3D UUID
> +Use the specified UUID as the seed for hashing, rather than =
generating a
> +random seed each time. Intended for use with reproducible builds.
> +.TP
> .B lazy_itable_init\fR[\fB=3D \fI<0 to disable, 1 to enable>\fR]
> If enabled and the uninit_bg feature is enabled, the inode table will
> not be fully initialized by
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index 7f81a513..3a8ff5b1 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -1180,6 +1180,7 @@ static void parse_extended_opts(struct =
ext2_super_block *param,
> 			"\trevision=3D<revision>\n"
> 			"\tencoding=3D<encoding>\n"
> 			"\tencoding_flags=3D<flags>\n"
> +			"\thash_seed=3D<UUID for hash seed>\n"
> 			"\tquotatype=3D<quota type(s) to be enabled>\n"
> 			"\tassume_storage_prezeroed=3D<0 to disable, 1 =
to enable>\n\n"),
> 			badopt ? badopt : "");
>=20
> --
> 2.45.2.121.gc2b3f2b3cd
>=20
>=20


Cheers, Andreas






--Apple-Mail=_C3B1D6A5-F642-48D6-BD10-D1B9EAEA5476
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmjO9/cACgkQcqXauRfM
H+CIDg/9F87lKSmg3ZHnOLVbSDe6jvxmWgfcQ2QumCoXaUmQu/Viypi0MWPIX/Wk
RT9KNDMcBDDTorQHGqRoj7rsbF5TrJnApwU08LkxBhdqA+ZyJHrdj2mWRYjoyqTw
p1U/r3mStoJOPdMjitY5bjVylRHpkyJoNtADnYy+z7C3RHGzl4wkFp4lN4YnY2ZX
kjjBE1XGx9+uuU6+l/SKNvBWG50JDhYJScQ7CVrMQuH4hKWt2PujY7rLnOf4uZ/X
E+3MxE77USiS0axdtZayulsTMIJYqejlXL3WCefvT160ZzhFRmveS7GdiwOd4aPH
hjkH71rb1PXASZNTwKBP9GF3uPTR3rfWZV8MgZxMNLwdWLCSfqXne8wb8Z3brI8G
Z6zemJYV7yBE2N8bP7x6m58AJEKVSzcSEb4WQKfWAf58ufhZ2j8yi+zQoYQp9nA/
aN/SloNvOJxkiTSHnZmIowXhDoxguPwzM7kMrKTc6u9EDuzAE9nUCdawubBWqpIj
P3RqHqGJED6l5qHg7CEXUKEgTEflGxx4gJlsF3oXZ5U3o0xUtfdqBxvO5HkfUGmw
vqL06AaEvelZP6HnMaX2kYJ5Tr7WZSjESxr5PRmX5wkTlc9kf+yEzIQAnBdSyklB
ulP303atuMLeJpAvMb4OilC4y0IaPWjZppj3Zh6DkbIlhcpjmiw=
=aa31
-----END PGP SIGNATURE-----

--Apple-Mail=_C3B1D6A5-F642-48D6-BD10-D1B9EAEA5476--

