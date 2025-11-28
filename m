Return-Path: <linux-ext4+bounces-12067-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F03C1C930DD
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Nov 2025 20:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF5174E1AED
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Nov 2025 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19682BDC0F;
	Fri, 28 Nov 2025 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="W+gfb5kr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16797262FD3
	for <linux-ext4@vger.kernel.org>; Fri, 28 Nov 2025 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764359565; cv=none; b=kncVZxySNF5RJD1zSUME8J+H1pzx1thbJsZDIUHGcBLpRflRT7gNV8l0zuys1PukHV8ERw6rv1Dh99pS2lZB0BGwkNod8F3Hm+m2S0/u4dgPghw0FCB7ef+GSEh4xrOjF/gucVuSyD9fjD1VEF7QSPhXauBzF7V8R5EtdQ1M7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764359565; c=relaxed/simple;
	bh=QNjJ17325mjRtI2PfInMNmWCtgJOpJOn2fdNLzCOoto=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CqdpjXRR/5NUGQl2BlKU2fkoZLWMu2vSQuhX7OqX38dnS1z4vzRCPS+tvi+pXNfJFnEKGWnSjRoKaTtLC5ZYMXoTD9Zn5AF8Ap6ccwNZfk8ed2FTHMpYSdiY2viMzmlJGSFeJQWxRiqiWwEg82cQG3hoXD1wR9LA4GmyTOcq3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=W+gfb5kr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29555b384acso25803845ad.1
        for <linux-ext4@vger.kernel.org>; Fri, 28 Nov 2025 11:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1764359562; x=1764964362; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09OJVfJ97UKabQuKOiULFL7QBPrONfuXDR4nDJd5M38=;
        b=W+gfb5krh4hMdy3m+E3B88JGGTNzGJixN71EAngG4UBUcDQLQMhZWvJFnyFhjkSgEH
         zwcvdrjadTbt512WoHqsI18ye1xDxmhRwr6WLUdawdKJ+sFmvMOXTA/rpfJRjKlz1xJ9
         g+uN5suSbpJ6r+0zQ5SV+AgWTiJbFSLYMi/MxICJ16WSx/89Ld9+g+YQywwUOTThkMXi
         YgiuMFEAmdY1JcQGyY5fY4PYAFIixWVrZW+Giq5xr9uipfHsJtNoRyTsw50+IlFZIAMW
         vN5f0ev8fyu5oa6u8jJge/6SZJQhkFSGQf3ckRj7DIdW1YphARJLvhAJP+m52ZWDzOpv
         VArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764359562; x=1764964362;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09OJVfJ97UKabQuKOiULFL7QBPrONfuXDR4nDJd5M38=;
        b=USAbs+rNRa04jdbHI+CEqBcXdMJMNSPog7Zu9S/qwL0zjAp/YuQNi/byNZMwmKuoK6
         j4qejcF6B1pohAu3ZPjTm3itWtDNzEye2WYHppmHRHXCBQMdxHEyuC2j7F/5BBgioda3
         53X1XUOeXVNNRn/ACvzB2jN6asLPvcbaH1Kkee0k/B0b0I9Z0PVtUoGS51M3WrYuGYep
         1MO5slPyKFnjJWk+b8wizJauYqXOTDDfDVA1e1RwHxRL3R8g1vNSPcucc+fNE8Ue8eXR
         +sDn8DWdI0gljiyvOV2zRfnOErOSLU0CJ1/ziA7UmJ59rnVXM7wPhd4J9Dm2bI77mqFF
         pP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvMOigVNbAY3t8DtRx3VVb1SazRmHNhkImigXw1HMJrgNyUE/3vwNifB6zirpHoIlha6xV/dTHVb8a@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNT7TbsH9/UORKAvMvYRNQq608TbQgoB78dPJxF6LUazlfOrd
	23XLocHVagZqzb6TcZI7gshNphbhWJ4PvhZVJsGeXPDq4I1JhfVc5Ren8ovqqDJhJyk=
X-Gm-Gg: ASbGncvHPZQ+90CJf6D/PYBFxZyzlZNBJg6obM4CnedY0PLWmgPnxrTs93I2GV5wMiy
	uae3Wm7KMOUfQNT9SI0bkvsjcxLdTWNGaBQ7iLK0Cwc7xXfqliwoal+fH6CTzTTKUV4CXVD23yW
	zSDGMu0MAAmPtsBFZow++PVwKGJQGL5vDpazzXg9dzLKNQQURVJifHAYp3c6YaEmDEOI/UnHvec
	gVXxowo1pOC01xDAZNcq+ofn9ZrHdxcwbZdXi9QIVY09pD+NpmM92ojg2Q1dLDua4nwG5KDrtc5
	b3arHpp2HSdIo7ViULPXZsqqbGxF4zWs+ORxfdPdu6HElEX8dP8Apa9BkZQEsG7x+/GtKBS2cwu
	j2KUzmbPqrD858v8upO47zve2L5u1uEhSbISS4UKLI6Ih/DGTE7Pak0LJ9MJP/W5PKCXQMGuE3S
	mCyUbPpBXLfKnMPmwA/Uf3GxgZfV3DgNMhZDN7qcFpmcv6bmr4aOoMQAJg30Y3PsD4Aw==
X-Google-Smtp-Source: AGHT+IH+LZpGLfpZNHB94Ngyv5YvKJcnHKiQIq9ka28q7FaIcylsGWBr+RDX+PhpRHHOmWzrvQi33Q==
X-Received: by 2002:a17:903:b4f:b0:295:5613:c19f with SMTP id d9443c01a7336-29b6c68d7dfmr342650285ad.42.1764359562244;
        Fri, 28 Nov 2025 11:52:42 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb40ac4sm53065025ad.77.2025.11.28.11.52.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Nov 2025 11:52:41 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v2 03/13] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <i3voptrv4rm3q3by7gksrgmgy2n5flchuveugjll5cchustm4z@qvixahynpize>
Date: Fri, 28 Nov 2025 12:52:30 -0700
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
 Zhang Yi <yi.zhang@huaweicloud.com>,
 linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 tytso@mit.edu,
 yi.zhang@huawei.com,
 yizhang089@gmail.com,
 libaokun1@huawei.com,
 yangerkun@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DDB4CC13-C509-478E-81C3-F37240016A69@dilger.ca>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
 <yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq>
 <aSlPFohdm8IfB7r7@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <i3voptrv4rm3q3by7gksrgmgy2n5flchuveugjll5cchustm4z@qvixahynpize>
To: Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3864.100.1.1.5)



> On Nov 28, 2025, at 4:14=E2=80=AFAM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Fri 28-11-25 12:58:22, Ojaswin Mujoo wrote:
>> On Thu, Nov 27, 2025 at 02:41:52PM +0100, Jan Kara wrote:
>>> Good catch on the data exposure issue! First I'd like to discuss =
whether
>>> there isn't a way to fix these problems in a way that doesn't make =
the
>>> already complex code even more complex. My observation is that
>>> EXT4_EXT_MAY_ZEROOUT is only set in =
ext4_ext_convert_to_initialized() and
>>> in ext4_split_convert_extents() which both call ext4_split_extent(). =
The
>>> actual extent zeroing happens in ext4_split_extent_at() and in
>>> ext4_ext_convert_to_initialized(). I think the code would be much =
clearer
>>> if we just centralized all the zeroing in ext4_split_extent(). At =
that
>>> place the situation is actually pretty simple:
>>=20
>> This is exactly what I was playing with in my local tree to refactor =
this
>> particular part of code :). I agree that ext4_split_extent() is a =
much
>> better place to do the zeroout and it looks much cleaner but I agree
>> with Yi that it might be better to do it after fixing the stale
>> exposures so backports are straight forward.=20
>>=20
>> Am I correct in understanding that you are suggesting to zeroout
>> proactively if we are below max_zeroout before even trying to extent
>> split (which seems be done in ext4_ext_convert_to_initialized() as =
well)?
>=20
> Yes. I was suggesting to effectively keep the behavior from
> ext4_ext_convert_to_initialized().
>=20
>> In this case, I have 2 concerns:
>>=20
>>>=20
>>> 1) 'ex' is unwritten, 'map' describes part with already written data =
which
>>> we want to convert to initialized (generally IO completion =
situation) =3D> we
>>> can zero out boundaries if they are smaller than max_zeroout or if =
extent
>>> split fails.
>>=20
>> Firstly, I know you mentioned in another email that zeroout of small =
ranges
>> gives us a performance win but is it really faster on average than
>> extent manipulation?
>=20
> I guess it depends on the storage and the details of the extent tree. =
But
> it definitely does help in cases like when you have large unwritten =
extent
> and then start writing randomly 4k blocks into it because this zeroout
> logic effectively limits the fragmentation of the extent tree. Overall
> sequentially writing a few blocks more of zeros is very cheap =
practically
> with any storage while fragmenting the extent tree becomes expensive =
rather
> quickly (you generally get deeper extent tree due to smaller extents =
etc.).

The zeroout logic is not primarily an issue with the extent tree =
complexity.
I agree with Ojaswin that in the common case the extent split would not
cause a new index block to be written, though it can become unwieldy in =
the
extreme case.

As Jan wrote, the main performance win is to avoid writing a bunch of
small discontiguous blocks.  For HDD *and* flash, the overhead of =
writing
several separate small blocks is much higher than writing a single 32KiB
or 64KiB block to the storage.  Multiple separate blocks means more =
items
in the queue and submitted to storage, separate seeks on an HDD and/or =
read-
modify-write on a RAID controller, or erase blocks on a flash device.

It also defers the conversion of those unwritten extents to a later =
time,
when they would need to be processed again anyway if the blocks were =
written.

I was also considering whether the unwritten blocks would save on reads,
but I suspect that would not be the case either.  Doing sequential reads
would need to submit multiple small reads to the device and then zeroout
the unwritten blocks instead of a single 32KiB or 64KiB read (which is
basically free once the request is processed.

>=20
>> For example, for case 1 where both zeroout and splitting need
>> journalling, I understand that splitting has high journal overhead in
>> worst case, where tree might grow, but more often than not we would =
be
>> manipulating within the same leaf so journalling only 1 bh (same as
>> zeroout). In which case seems like zeroout might be slower no matter
>> how fast the IO can be done. So proactive zeroout might be for =
beneficial
>> for case 3 than case 1.
>=20
> I agree that initially while the split extents still fit into the same =
leaf
> block, zero out is likely to be somewhat slower but over the longer =
term
> the gains from less extent fragmentation win.

I doubt that writing a single contiguous 32KiB chunk is ever going to be
slower than writing 2 or 3 separate 4KiB chunks to the storage.  _Maybe_
if it was NVRAM, but I don't think that would be the common case?

>>> 2) 'ex' is unwritten, 'map' describes part we are preparing for =
write (IO
>>> submission) =3D> the split is opportunistic here, if we cannot split =
due to
>>> ENOSPC, just go on and deal with it at IO completion time. No =
zeroing
>>> needed.
>>>=20
>>> 3) 'ex' is written, 'map' describes part that should be converted to
>>> unwritten =3D> we can zero out the 'map' part if smaller than =
max_zeroout or
>>> if extent split fails.
>>=20
>> Proactive zeroout before trying split does seem benficial to help us
>> avoid journal overhead for split. However, judging from
>> ext4_ext_convert_to_initialized(), max zeroout comes from
>> sbi->s_extent_max_zeroout_kb which is hardcoded to 32 irrespective of
>> the IO device, so that means theres a chance a zeroout might be =
pretty
>> slow if say we are doing it on a device than doesn't support =
accelerated
>> zeroout operations. Maybe we need to be more intelligent in setting
>> s_extent_max_zeroout_kb?
>=20
> You can also tune the value in sysfs. I'm not 100% sure how the kernel
> could do a better guess. Also I think 32k works mostly because it is =
small
> enough to be cheap to write but already large enough to noticeably =
reduce
> fragmentation for some pathological workloads (you can easily get 1/4 =
of
> the extents than without this logic). But I'm open to ideas if you =
have
> some.

Aligning this size with the flash erase block size might be a win?
It may be that 32KiB is still large enough today (I've heard of 16KiB
sector flash devices arriving soon, and IIRC 64KiB sectors are the
norm for HDDs if anyone still cares).  Having this tuned automatically
by the physical device characteristics (like max(32KiB, sector size) or
similar if the flash erase block size is available somehow in the =
kernel)
would future proof this as device sizes continue to grow.


Cheers, Andreas






