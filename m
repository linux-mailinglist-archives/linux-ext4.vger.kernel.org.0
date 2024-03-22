Return-Path: <linux-ext4+bounces-1740-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62288759C
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Mar 2024 00:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309911C22DF7
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 23:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A082C67;
	Fri, 22 Mar 2024 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="WjZ/lCyZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E68288E
	for <linux-ext4@vger.kernel.org>; Fri, 22 Mar 2024 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711148968; cv=none; b=Co+UUVvCZ8sx85HjMBwhg+Y1sDnWfkzu8J7vKLbBz1hNRGLwcomOLSOJg9XflpF5tCi4t99dRPoZ/bbqCiTR+8Y4J1w7YlNsPG4G8h0spdiAysETtMHc9namTeohymerh8EOZsaw6zJmBWncixE1ebX0FdXZVanK8R3tb15jWo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711148968; c=relaxed/simple;
	bh=IXk+hn5C8ZBuwV8PeJ/dsKKtVbY2GWFB3rgI8s27QaY=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=HJsyUBWt9tkCiadUFIeUhmhUMswGfqLoCyjhKL63bOI8fCyoBNUyOxchsnYSJuMuf+DgCQx+Q4TQ4N+Gff9I8X9TQ4pGgbAZO7/32kMNnzGVlitLpA6jt5mvVgP9d9Lyt362HcmJPhV2CeHVe92JgmhBfRk+XRmXYYQGrJRV2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=WjZ/lCyZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso1630694a12.2
        for <linux-ext4@vger.kernel.org>; Fri, 22 Mar 2024 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1711148965; x=1711753765; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LE6o9jQEr5Sxa077DLsHxuCp7ITiyR+GsOpWjc+ets=;
        b=WjZ/lCyZhvuFXTY5H3pcTSOM3jRxkkENLiNBLC2rUWJIR1dve3eMFtPEn9g0s5c5pH
         J9J9OBsnOUgX2IunNzBURgHU3SJszvlCfsE7kikN/X+HnaA2xXCAnz9jQfsDsi91tTGY
         SH7QO9cXF/OSYHUP0hm9Ap/TCNw87wKkR2bZNIqAyCzrAC572ELsG4sZfjngBR+dtnyU
         BDwxHuPlmROfsw1UIKpb9pqggij8SS/NWbGpNhII8fkiOsi18EAjGQ2rwsG0d9XCcpTj
         nuPfqQfacYCztO77LAt5r2qokQE+DZtX5XW99UD3YFnqZqq6dL0iBkZ4vgCKLXmRqqu4
         9kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711148965; x=1711753765;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LE6o9jQEr5Sxa077DLsHxuCp7ITiyR+GsOpWjc+ets=;
        b=uweA3OMpRrHN3lrQBH906tWfpUQO9PIAr7H9CZg2FysAr4KppH5EqfEjr34Ld4XaYa
         ChhiawOP7XcRjscPDrpJjSl1fsqNxoqW9rGThxpZoGsyD/Cey1Cz8Ct0i5OcvXnoVAYm
         ODKIG9wAZ8v6F5uKDJhFSl42OfXObSJba20pVr5AomBF5RDuTYzt5XyULFxyG2aFvKQY
         N8LmEYgqeInW4e9zaCWUwD7QAGb08q58jZCdUaq1yTZw6FiSc00b5RGVvs5WPU9wFZix
         QY1kyB3O0vGWr7+e+oSk1t/G307fDKiW32RUOtGy+A1YDkQj5SyYeX4uy66LTdYmR1MD
         zv3Q==
X-Gm-Message-State: AOJu0Yz4uRtH2lY1ePmwtNAjZGXYvaCkk0A2YOxXpk8hMgyVUmZT1sZ+
	i53wQgKanlAWZhfjetC+93bU1OYPKrxweuoCFegMPbYcDUJkHrJTapvYU4qodCo=
X-Google-Smtp-Source: AGHT+IFihFi9BBM0GmXuqOXOXN2VO77fjha4JLHGVp0xBg/Bjwop4sToCHSr8Q1lnGGEPHphw6nlEQ==
X-Received: by 2002:a17:90a:a404:b0:2a0:1167:bfea with SMTP id y4-20020a17090aa40400b002a01167bfeamr1161535pjp.5.1711148965040;
        Fri, 22 Mar 2024 16:09:25 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090a9a8100b0029e077a9fe6sm6131358pjp.27.2024.03.22.16.09.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2024 16:09:24 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <4A52A838-688F-4B73-AFC9-7863469C5365@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_34579B20-E825-49C3-9ADF-C95778B1B4F8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [External] : Re: [RESEND PATCH] e2fsprogs: misc/mke2fs.8.in:
 Correct valid cluster-size values
Date: Fri, 22 Mar 2024 17:10:15 -0600
In-Reply-To: <DM6PR10MB4347C97E2645B45A66CA0D76A02C2@DM6PR10MB4347.namprd10.prod.outlook.com>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
 Junxiao Bi <junxiao.bi@oracle.com>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
References: <20240314093127.2100974-1-srivathsa.d.dara@oracle.com>
 <CE93B29C-6A50-46D2-95DA-956D1F6A4104@dilger.ca>
 <DM6PR10MB4347C97E2645B45A66CA0D76A02C2@DM6PR10MB4347.namprd10.prod.outlook.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_34579B20-E825-49C3-9ADF-C95778B1B4F8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Mar 19, 2024, at 5:25 AM, Srivathsa Dara =
<srivathsa.d.dara@oracle.com> wrote:
>=20
> On March 16, 2024 3:02 AM, Andreas Dilger <adilger@dilger.ca> wrote:
>>=20
>> On Mar 14, 2024, at 3:31 AM, Srivathsa Dara =
<srivathsa.d.dara@oracle.com> wrote:
>>>=20
>>> According to the mke2fs man page, the supported cluster-size values
>>> for an ext4 filesystem are 2048 to 256M bytes. However, this is not
>>> the case.
>>>=20
>>> When mkfs is run to create a filesystem with following =
specifications:
>>> * 1k blocksize and cluster-size greater than 32M
>>> * 2k blocksize and cluster-size greater than 64M
>>> * 4k blocksize and cluster-size greater than 128M mkfs fails with
>>> "Invalid argument passed to ext2 library while trying to create
>>> journal" error. In general, when the cluster-size to blocksize ratio
>>> is greater than 32k, mkfs fails with this error.
>>>=20
>>> Went through the code and found out that the function
>>> `ext2fs_new_range()` is the source of this error. This is because =
when
>>> the cluster-size to blocksize ratio exceeds 32k, the length argument
>>> to the function `ext2fs_new_range()` results in 0. Hence, the error.
>>>=20
>>> This patch corrects the valid cluster-size values.
>>> ---
>>> misc/mke2fs.8.in | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in index
>>> e6bfc6d6..b5b02144 100644
>>> --- a/misc/mke2fs.8.in
>>> +++ b/misc/mke2fs.8.in
>>> @@ -230,9 +230,9 @@ test is used instead of a fast read-only test.
>>> .TP
>>> .B \-C " cluster-size"
>>> Specify the size of cluster in bytes for filesystems using the
>>> bigalloc -feature.  Valid cluster-size values are from 2048 to 256M
>>> bytes per -cluster.  This can only be specified if the bigalloc
>>> feature is -enabled.  (See the
>>> +feature.  Valid cluster-size values are from 2048 to 128M bytes per
>>> +cluster based on filesystem blocksize. This can only be specified =
if
>>> +the bigalloc feature is enabled.  (See the
>>> .B ext4 (5)
>>=20
>>=20
>> This is an improvement, but doesn't really explain the details of the =
limits.
>> Instead of "based on filesystem blocksize." I think writing "between =
2-32768
>> times the filesystem blocksize." or similar would be more clear and =
explain
>> how the actual limits relate to the blocksize.
>=20
> Hi, Andreas. Thank you for the comment. Here are the details:

Thank you for this added information, but I guess my comment wasn't very =
clear.
*I* understand the background here.  My email was directed at your =
change to
the *man page*, where users who *do not* know the details go for =
information.

> The function ext2fs_new_range() is causing the error. This function =
gets
> called while creating the journal inode.
>=20
> Failure cases:
> ------------------------------------------
> A   | B   | C   | D   | E   | F     | len
> ------------------------------------------
> 1k    64m   0     16    16    65535    0
> 1k   128m   0     17    17    131071   0
> 1k   256m   0     18    18    262143   0
> 2k   128m   1     17    16    65535    0
> 2k   256m   1     18    17    131071   0
> 4k   256m   2     18    16    65535    0
>=20
> successful cases:
>=20
> 1k   32m    0     15    15    32767   32768
> 2k   64m    1     16    15    32767   32768
> 4k   128m   2     17    15    32767   32768

Basically, what I was asking is that your patch for the man page be =
updated to
include just a fraction of this information, specifically that it =
includes that
"the cluster size must be between 2-32768 times the filesystem =
blocksize" and
not just "based on the filesystem blocksize".

Cheers, Andreas






--Apple-Mail=_34579B20-E825-49C3-9ADF-C95778B1B4F8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmX+D9cACgkQcqXauRfM
H+C9zQ/9EelvM4hKBSa4zvy2KmYt7Vw2KWQQaJNxYbmrAceBr3OCt3104A56IGLC
NySr+9Glq+xqQUjGw21QfoNxE4PQNBOQiB1uKTI7wteMVqSyC+6tNAJmaLN+Hwrd
E/R25BGaoMTXDskgX4OWeXj4m/Y1V+Xt9/K4nWiMFgHwXIFNdaRQR/wUS4mT3kBd
DfgTdoSsxeVY9yaSYlT1UZSgvlzeOKypxrtljmeQlzBVOGpac5kJ3ZapDGjRhv5j
5WEFit0b2yQfmRqeCC4PNj2vy6Y8Oi84L1Bs2ct8w/L8RCDqPY2pSRTCUls2zWdI
DKFA1sK9796fPYKVKhFCOMx8Sc8i6LjyrRpdwsuZjqFW9isSc/dCZsB1OUfT69/G
qfZfdgHWvcCsq7fMRbSCg6fP60ZXWR2F68tAaeJt1CzlpW865ENICPvWD6Qoe0kL
4h+HbIz276f4H5e72A/k0ZQknTcTCTEZWoUWj068kaOFcTfHbmUZhMk/Zr+rq+Wt
aKP7Pvq+4zXbxdmX6borqRsflXu5goCw5z5UJZWX3lCH7gosaoGm28e3bn8bc/tA
ikB+D1lYUamv1idvsCUOtp5PCfZkoQcuOGhjO+UzWNIWri91qdr40ulmUJqTfawd
XlIotGissmU2SdPd4pvHlk9JuKkcI32+h5DDUHcta8O9ecywfUY=
=EGia
-----END PGP SIGNATURE-----

--Apple-Mail=_34579B20-E825-49C3-9ADF-C95778B1B4F8--

