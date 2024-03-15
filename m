Return-Path: <linux-ext4+bounces-1669-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72DE87D62F
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 22:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14B31C223B1
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 21:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A525490F;
	Fri, 15 Mar 2024 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="rZS6t+It"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491E55E77
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538333; cv=none; b=ojr8M7IjMqSJ6UeDge3lYXlvREntICswKlFVwYkS8NtBoif5sDrTtXKjnEaVuWv0CJLCliV6kMfQkhjdj3HJ2gnN/HlMJu7r2QYIrLxLXESFNTipf49vMpNntsV1YgJQXm4aMR0eYxi/bLJsFc9Hig50IyN9QwQo6IGHfzBs7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538333; c=relaxed/simple;
	bh=PxYDbUUHX/SWNG2vcJAUweGFByelkaq58ite9ta92GQ=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=uk1mfuZyRzoz+ff35NNsLsjMaSgw8OJZbEbfekAQI+cLTGYAZhRAkNojf+Jbd3ZFItnUPVgcpulXA2no7nEc3SW+pdiTewgyzmv8nrcVcU6ocngwXZvObetEjICDGwwn/fFLWugOS98Tez4SZ8sPbebo/4r3UYCjlNRjZgADWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=rZS6t+It; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1deefb08b9eso7925545ad.3
        for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1710538329; x=1711143129; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYohZrC7Z4w1jpRRXwthp8+UkG//qOdUR1oXsWDT2WQ=;
        b=rZS6t+ItALidvdHfI3E1EAojJhoLYcfDX+O7J+mbazy6S9PUlJg/ZaSw6q69vg/lDd
         xjTMAus0O3nneOJYkOal2lxrcchgfmPGdTaBKwkglYKOqXQRySEeUuga1CBiqpdWcCHq
         NDwI8vB3GWnvOqaJeZCra/U5BU1L8R8VXFgZYe4zroHZD5jcy2m5i2HdlJmj57ITIX6X
         bb02eKEoGDMCFiNrgFyat5IbmAzqsTT0HTzdSb69lZERaNJhxfiNfxeHcqz5LNorsIz7
         HRWJeTEd9kQ5f4V6mfka4lcQklt8Q+X7lUQR77gGOuZN+/PMS0jd+oINMc7hTwO321J1
         JC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710538329; x=1711143129;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYohZrC7Z4w1jpRRXwthp8+UkG//qOdUR1oXsWDT2WQ=;
        b=q+0ribc8pJNt2JrRpsHolrD1+UUZrV6Bp5JdAp38bauNXbXNb4SiC2UNLW7ill21li
         MTcNzexzy1QssbqzIWo7/cbQCedZSoIT1DhCawHhhCKoH0ssP21K8HLiIBBxFPKqDn8K
         htT9Dce+hQR6/rsI6fI8pB8+KvUp/QDNi1rZ79Hv+vMcE9/wdRSqwOyUSN924wXNhjEs
         EpYu0ThSqPm+uL+ewzKA/BILELliKwlH/f2wrJqNX6RcjdmxUAO7toXtD8ZRs4KduJj2
         Qzp+DgdV3gUc4Bsa4moRovrUnMZpxizR8di2jyH5PyPT6CQExLXsoKPnu1FvnUH1Q32H
         2H9Q==
X-Gm-Message-State: AOJu0YyHj7CZSf2jeyvdZl3jkcIrY5xZa5rFWJPYJLT7Q+ZiOxTqRNTe
	UIl0gZDPNAZ3HV5/wR6Efcun9xvGpprMeRhgy7iSBlV0NMbnKM8SQ6VK+LqoLsQ=
X-Google-Smtp-Source: AGHT+IFGDWHcae24JTDVqJrNAH3fO39ZmwRINxzUS46JnFrggZNzpsKsteSvE/9OPvpDfvRmVOcQcg==
X-Received: by 2002:a17:902:6b49:b0:1dd:e008:9b48 with SMTP id g9-20020a1709026b4900b001dde0089b48mr5637062plt.61.1710538328615;
        Fri, 15 Mar 2024 14:32:08 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id u12-20020a170903124c00b001dd66642652sm4353863plh.190.2024.03.15.14.32.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2024 14:32:07 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <CE93B29C-6A50-46D2-95DA-956D1F6A4104@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_BAAAF4DB-3409-42C7-B752-001014B55901";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RESEND PATCH] e2fsprogs: misc/mke2fs.8.in: Correct valid
 cluster-size values
Date: Fri, 15 Mar 2024 15:32:17 -0600
In-Reply-To: <20240314093127.2100974-1-srivathsa.d.dara@oracle.com>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 rajesh.sivaramasubramaniom@oracle.com,
 junxiao.bi@oracle.com
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
References: <20240314093127.2100974-1-srivathsa.d.dara@oracle.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_BAAAF4DB-3409-42C7-B752-001014B55901
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 14, 2024, at 3:31 AM, Srivathsa Dara =
<srivathsa.d.dara@oracle.com> wrote:
>=20
> According to the mke2fs man page, the supported cluster-size values
> for an ext4 filesystem are 2048 to 256M bytes. However, this is not
> the case.
>=20
> When mkfs is run to create a filesystem with following specifications:
> * 1k blocksize and cluster-size greater than 32M
> * 2k blocksize and cluster-size greater than 64M
> * 4k blocksize and cluster-size greater than 128M
> mkfs fails with "Invalid argument passed to ext2 library while trying
> to create journal" error. In general, when the cluster-size to =
blocksize
> ratio is greater than 32k, mkfs fails with this error.
>=20
> Went through the code and found out that the function
> `ext2fs_new_range()` is the source of this error. This is because when
> the cluster-size to blocksize ratio exceeds 32k, the length argument
> to the function `ext2fs_new_range()` results in 0. Hence, the error.
>=20
> This patch corrects the valid cluster-size values.
> ---
> misc/mke2fs.8.in | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index e6bfc6d6..b5b02144 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -230,9 +230,9 @@ test is used instead of a fast read-only test.
> .TP
> .B \-C " cluster-size"
> Specify the size of cluster in bytes for filesystems using the =
bigalloc
> -feature.  Valid cluster-size values are from 2048 to 256M bytes per
> -cluster.  This can only be specified if the bigalloc feature is
> -enabled.  (See the
> +feature.  Valid cluster-size values are from 2048 to 128M bytes per
> +cluster based on filesystem blocksize. This can only be specified if =
the
> +bigalloc feature is enabled.  (See the
> .B ext4 (5)


This is an improvement, but doesn't really explain the details of the
limits.  Instead of "based on filesystem blocksize." I think writing
"between 2-32768 times the filesystem blocksize." or similar would be
more clear and explain how the actual limits relate to the blocksize.

Cheers, Andreas






--Apple-Mail=_BAAAF4DB-3409-42C7-B752-001014B55901
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmX0vmIACgkQcqXauRfM
H+BwExAAhZmDFYV8WImXgz+nLLD0QYBtiFmi6gP9jAgy/ugC206chHAqLWU9gpzA
8PgPB31Sn8tTPZLGErDaHx+YKsHjCbSyVYMQqrIBXUQpoj7e1x6xpGse7ZkAd4IZ
xwqdCPintz78ksi/jlUvyZLjC5E0tJb46sOTz/9gpNEUyFNHEF1b2voClJRY8zij
21ELC2j4kNzjP5S+Mi0hK5EypHZUqMH3MFTNJcKazovE5B+OM0mHjyO85pcA42Z+
fQ/iVfv43l0p0zEEcdfa2LHmdpF/PSIW3qNGqypdeo+Gij7S0Xhnm9zi69/RYThL
9abO3IzIYxeDDbSA3OcSCpu2hIP/ViX5BDaM4buBR6U+At8KFvzwbFOn5FHGSzam
gt7OKYMlCh0p6htgFl14gcK/Ba54Dn48Qqm0hHvdhHQLdMOxVdygmjzqwRZ1ob8g
N9DhHhfYd+j6cpHxBPABY4ZjXBYrqLNXQRnEhljKVjok68DejtA+5r616LT3YM18
+5KBbWIn21M5f589OVqwM8IR8HfbQX9Gx+9PgEjzhGLM+vJ9Ycu3ruVEtEhm9wPm
X1oMmdygE1jsC332yFoDda1RUn/fco28xiMMNujU85WLXYZur7xPs3KbdoK0IQDl
mejjqhK1LakRGe3a6N5rGW1rKGl2eGznaRJyo0WxRqkx2BqOkp4=
=AeMZ
-----END PGP SIGNATURE-----

--Apple-Mail=_BAAAF4DB-3409-42C7-B752-001014B55901--

