Return-Path: <linux-ext4+bounces-831-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EAA82FC55
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 23:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B188528F606
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 22:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B425115;
	Tue, 16 Jan 2024 20:47:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2B24B4F;
	Tue, 16 Jan 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438068; cv=none; b=NcXCCsYZIU1zcw+YoLBMgJVCBGzJygE5qE7PUelFVnCEvumT7w1mGTEzTUGR0wzVrZaOxZrx7Fva2U3PScIxNYQLXXP9ffzczgBse/+WFI5I4xVnaEfZ3cyJFE7I3YEGjFn5bnjKuT6RtTXfa5QH7GLEzw1Q5uZ/9Ko3YLULLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438068; c=relaxed/simple;
	bh=YAynCo2jCo1SBMeSdNvw/ZTOAkwEklo1Cis4GBlNb8w=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=rw8isBgEtY5aLXZiJPA2LLEtWqPHJqF4FtetoV+EOl5K19SHW6YqdmWRYa5kCeoYoyzdVr1rR9bXd8D9sCNoyBhx6T8ZnOGFOyO3UHRf1LTPIAx0ZhwySxO9hlMDVyhXB/LtlY6q0C+4+PD72ks/jweXmqUXHjsk2kk8nLp1hu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 717211C007D; Tue, 16 Jan 2024 21:47:45 +0100 (CET)
Date: Tue, 16 Jan 2024 21:47:44 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 08/14] ext4: enable dioread_nolock as default
 for bs < ps case
Message-ID: <ZabrcCOi/hIsKk5I@duo.ucw.cz>
References: <20240116010642.218876-1-sashal@kernel.org>
 <20240116010642.218876-8-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PokFs8UU5Lo898VR"
Content-Disposition: inline
In-Reply-To: <20240116010642.218876-8-sashal@kernel.org>


--PokFs8UU5Lo898VR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> [ Upstream commit e89fdcc425b6feea4dfb33877e9256757905d763 ]
>=20
> dioread_nolock was originally disabled as a default option for bs < ps
> scenarios due to a data corruption issue. Since then, we've had some
> fixes in this area which address such issues. Enable dioread_nolock by
> default and remove the experimental warning message for bs < ps path.
>=20
> dioread for bs < ps has been tested on a 64k pagesize machine using:
>=20
> kvm-xfstest -C 3 -g auto
>=20
> with the following configs:
>=20
> 64k adv bigalloc_4k bigalloc_64k data_journal encrypt
> dioread_nolock dioread_nolock_4k ext3 ext3conv nojournal
>=20
> And no new regressions were seen compared to baseline kernel.

But no fixes, either, so not suitable for stable.

BR,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PokFs8UU5Lo898VR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZabrcAAKCRAw5/Bqldv6
8pEoAJ9B7sSIOwhORDquvlzFSPG1vIO9KQCfbSnHoQRHfgdwGANc61ccILgvHAw=
=ZMOC
-----END PGP SIGNATURE-----

--PokFs8UU5Lo898VR--

