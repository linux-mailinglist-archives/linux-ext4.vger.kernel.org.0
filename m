Return-Path: <linux-ext4+bounces-5274-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC019D39EA
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2024 12:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1759B29D73
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2024 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F331B5EB0;
	Wed, 20 Nov 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="p+r+nVnF";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="GETYacWD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C91AA790;
	Wed, 20 Nov 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103307; cv=fail; b=pSRiTJdR8EW7ZyRXL+6LwjBGeg+SUQN39kahiN7INlnJdaXMhGPk6VzP5S04y7EUywsPjAquYKzhS7lPwfFJeTjqbs1B7VlyAnUmoK8oXQDwUZ4X9KbXMkUvuqD7AE7QW/er6BGj1ZZEbvaY7sK6ro0u8Iej5TQF5bXYdhMg3qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103307; c=relaxed/simple;
	bh=kAQ20iHHLxfM3Ywx9tlQoAh5V0d0VALHNQd/Kux4B9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mi0II8YFwXMhXHxHRu1Z0InKptK1gUc+Xe5SVIda5Kpu747RNg2xhV3nJsEmin0tb27OwZ9rE9fd3OaWey/IjubuV+tDZFLgqCDjSs3buoTEWTijOCD4Gwwt0GUux7yg5/ZaKlR+NX34RgjfRLUa3EIlh0Km2Oo6tlp2zzgNGWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=p+r+nVnF; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=GETYacWD; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 371EE4800BA;
	Wed, 20 Nov 2024 06:48:25 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1732103305;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=kAQ20iHHLxfM3Ywx9tlQoAh5V0d0VALHNQd/Kux4B9g=;
 b=p+r+nVnFlJwKFYjqOcDPQHGMydKzsWhV4KigpmpN6X6E48YN4x+9rdjU7S36LC7VSLJA+
 5BxoA2k/VZfPtGMAA==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1732103305;
	cv=none; b=PUS7pDwp/PJc+JhM8Yj6yl8dhyoOVPtZobImghPFWnL1vv9cDXMoKCqR3q7XWMh659co9SHMAcG7ib79bVIstjUuoy8Jt931PGs5OUNgvdgP3fmw9XNJMiS4jHtP8zE3FmeVsjsYj1UI73AQ3ycFb3B7BuFK+1+LA48GrIygMQukLmWseFHLpIOER2K9bYsO7AeDRUQaBspvP1SI8MQ3b7FKy5CIX/CVcMDkKEIm5ypQVP89/XH9JYcDG3LjV4ijxZgKXql+cmuRt4qZ7LX9LJL/DIRLK0ehoXSln1DxemMjqwI3ss1l3HZVfUxhT5wAfGRs0v031P6fwAJZBXme2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1732103305; c=relaxed/simple;
	bh=kAQ20iHHLxfM3Ywx9tlQoAh5V0d0VALHNQd/Kux4B9g=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=YfCnMcgm/dv5ivzTP+aJt/w5NMgx3GQy2u8SHxoP0AYybLGM5kXYuZ9mIZr/56az6LYFGGxjx/0EJRc4jVrJPwK63+60rxW8pgl29t6oY0PPrdVLGfK8b+dohDcl6ggJNacwlmhsQ3us2k6wUw8o19qHwS8x2g0YJ3HIPk38cubUL4rtsPyb42y9me2VT04/CzRx4p+E6U2MzcRmUaqgdOcjgqF6E+/osAJi6KQaDEZLi+09PmZMgy+UME1qDRBtxyHX2m3CyjIhlKgOp+I6w2SJMj6Fyau8l0xxXo99SoRcilcdFclSh/1nQ+bYHheidncVgUGDn9SHVOqQ8Iyopw==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1732103305;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=kAQ20iHHLxfM3Ywx9tlQoAh5V0d0VALHNQd/Kux4B9g=;
 b=GETYacWDvFirwKIccC550c/RPtQx8Ht8vGWRVkJMmX6pKsGmn5b7Kc95F1UuDOvEgA6Bd
 1mbG2Mwoi57QoPCnsF5eLWPPytHfX2R50Q8GRkOpu6XwiAGq837hLk6l+yUrxHHxyNHhn+l
 bGklYALsTQcZShB+wCon4OTtYeFYwzvZaWqJSi6UfAf9E7HegufESBqoSy52FtL2OionfSb
 D8fVnKt+yu+xiHfcijkdkRQ3S3I6TAqxM/m6LtbD2uMcCkkHx+kJV0teCwEii9K67NbFwFW
 3IM4sDX0Fl5xe4q6SvjsP/n29zBDz1R0KFas6vJw0G3gC/y1g5N40POR2YqA==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id 0F9B9280047;
	Wed, 20 Nov 2024 06:48:25 -0500 (EST)
Message-ID: <47f9d3cd5ebce7f043a41abba1a55658f23c6c83.camel@sapience.com>
Subject: Re: md-raid 6.11.8 page fault oops - *bad memory* please ignore
From: Genes Lists <lists@sapience.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca
Cc: linux@leemhuis.info, "yukuai (C)" <yukuai3@huawei.com>,
 yi.zhang@huawei.com,  "libaokun (A)" <libaokun1@huawei.com>,
 linux-ext4@vger.kernel.org
Date: Wed, 20 Nov 2024 06:48:24 -0500
In-Reply-To: <2a620925-1715-5fc6-86bb-783cf3cb6ebf@huaweicloud.com>
References: <0b579808e848171fc64e04f0629e24735d034d32.camel@sapience.com>
	 <34333c67f5490cda041bc0cbe4336b94271d5b49.camel@sapience.com>
	 <2a620925-1715-5fc6-86bb-783cf3cb6ebf@huaweicloud.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-0dd7lmti3aELo2rYVoDC"
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-0dd7lmti3aELo2rYVoDC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-11-18 at 09:14 +0800, Yu Kuai wrote:
>=20
Since there were 2 somewhat different crashes I got suspicious and ran
memory test and found indeed that there is some bad memory on this
machine.=C2=A0

My apologies - please do not spend any more time on this. After memory
has been replaced I will report back if there are any further problems.

Again, my apologies.

--=20
Gene


--=-0dd7lmti3aELo2rYVoDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZz3MiAAKCRA5BdB0L6Ze
200YAQDe75SdWeqPD34IGjoKIwEYGkr4SBopb7vjSAautwMHQAEArCISHLpXBkLy
3rxv9m1B4aYnk3f/8aQbnxkP4aPJHQE=
=rX4k
-----END PGP SIGNATURE-----

--=-0dd7lmti3aELo2rYVoDC--

