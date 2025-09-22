Return-Path: <linux-ext4+bounces-10347-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD8FB93458
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 22:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6632D442595
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178D225EF90;
	Mon, 22 Sep 2025 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="wEBHv3Zq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03C258CDF
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574321; cv=none; b=ND+U7yZirMVEibCDKnhMUD3x8WZqZVmKlwcTYWJMsXRIcX1qkR8r3YcKjGwsm8XCRRNX5PFUHNZdt5GrjCfZJuVX3oWxYmGceSoiRcZtycKW8RXpvpptDB6adFBT/EMTIJkTysB8kW2ubha07QRJ4pT7JoKzBJ+mzBLzJKpv6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574321; c=relaxed/simple;
	bh=CuRjpIsOGe/dIm4nK1ljZv6VvUZXT1BmzFpsFXJF7A8=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=qKRNz1JTUPJ6p6UHJFCh/utkbBCVkND/+2i1ztQsQtqVJPYgIXYruCSsb+P06A8lGsMm1bgxGhg0JV11o6JcEKd3pzOhaf4sRlaf659386RUz2/iK5krCh1sIAfsArygfnCGeOkhXKEkPlO8FkcPNrlazP1Pu4Om4/rSg+fJmag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=wEBHv3Zq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f343231fcso700096b3a.3
        for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758574318; x=1759179118; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GY7MD3kKhhC/hrvKSF0OvHgBIRAonZcjOE6CMrQyhFk=;
        b=wEBHv3ZqXlQ9oxoDmxvV3ew4YI/ha2GN9H6ZfUxagUbyYKf6OIO4nYUIEKIzc4HcP1
         7tkqM1gqYZ1SCz+cG8259xRXFsvx2JMUAl3huon+8mKeY/csHiZAaf1T3FP39cylpUse
         81wKCMrOxPmJ0tT3wyZMA+qhN42xph+SMc+fiuYMyFSZFMsfOQ+kMlUHoyHhYcDbQNd4
         oEtatzamv+C2ZPobyDmazUFO1omudmP250OJ1+D6LIWQK9XAHCBp73zBDx1FSdBh+0Yn
         fDKr8lMS3kcLPsWbn2Ao6vaNKkY1mGfrHQe1hD+K7bGtQ45EcJn8cUXCD5fc/kYnZKjc
         QTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758574318; x=1759179118;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GY7MD3kKhhC/hrvKSF0OvHgBIRAonZcjOE6CMrQyhFk=;
        b=WxU3LeEMb85gxLVpgCd0dIc9a4OwGTcVYcjg9HzWF/xA+yHlzOCxJHFcQgo4hU2cOy
         GVnZnFJzOLEb+PykltB8V3jvg6XyZj3Tp5FZYfSPAqyLIn5jHBeGlE6E9U8UOd0vZfH1
         iL3buv+ySnF4Fr1lNg7HEH7QtxqAyzDUZjvxdKQKeDeMpoSa2UOiWFoBq120BLwmAUEk
         7Dn5NI/HTitak1VeLFyIx58k6kZ+ME5JMR7LJnf5SoOFKQ94MTJDsXrCWjf94YF/TDL2
         HLH1EUMOAbywOFSka67bMQkKX7n5wmiVy/JGOIAUGLUWwGtpef3MwjNkJLb01z64TBLX
         ANpg==
X-Forwarded-Encrypted: i=1; AJvYcCXgFvK6h1jekMeGDcIA8rpkd/5ECZsfy209dF1ArK5xJzRGPMfWS3g7F4pAyWobYFnx6GwDOnwf4KBW@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3x9QEPDYUeYrAyhOVGpaIqVJaAvpSRY3WfU6QtlALGeXHRFQ
	kVMiDDNXi7wXCeUacoud/sXj3SOtG54cyPjBmlJ8AkulmoHleskZZBp9xC9os6xVU80ZtomNtOr
	myR64
X-Gm-Gg: ASbGncuxAjHCI2MDIB7oO7RKeKp399g+7ZL4X29cuOFYhFaYWWmxL2xEC0IrmRZ7ioZ
	koVmC9egqAtdhTDwqc4gRlYEbzCYKzUauca7ROZppoZDfz64UTikARaLcMXZPPB9PFjAVnRPV+a
	kHjxvY99ypPieNtBZ4fbnCoIRC0Q9ErKQ0puIlSApxuuaYJYsfjPARELczuxIFiC80LIn45myMx
	FIwaloZuTHPDYn97Yh48EB/LqQF8KTqOXS6wOaHs43Qcr5V3iUkmV+d+nW6ps9k/mZ/JdZFPlUV
	BB8XLIMGvu1nvIpwZR0arXmkPqLOvqK39dDTTeO9esKhEOQe1wKogCg91NIbsFGULdAMLQ2f/s1
	QyKHbvajs3DXCLb7hE78OZyaty7C2u4t9hVqzoslYOBnkG/31PbAgdMQcihxvE4c5N775WK4=
X-Google-Smtp-Source: AGHT+IHOQ173ylERx6KZy/Xc7MIg7+ZXbNrrmog1NQNEnWYQ4pjY34TxD81CuKRK1TBa9N61cDuisw==
X-Received: by 2002:a05:6a20:748b:b0:2bc:ac1b:60ab with SMTP id adf61e73a8af0-2cff0df2ed8mr567358637.52.1758574317749;
        Mon, 22 Sep 2025 13:51:57 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b552591eb64sm8927339a12.10.2025.09.22.13.51.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 13:51:56 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <8F227773-BD56-4E6F-BB6A-F24931186D77@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_03294430-5BFB-4E40-8142-C357DAE981D8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4: failed to convert unwritten extents (6.12.31 regression)
Date: Mon, 22 Sep 2025 14:51:52 -0600
In-Reply-To: <BN9PR18MB4219710FC26F8A610F53AF569812A@BN9PR18MB4219.namprd18.prod.outlook.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 linux-ext4 <linux-ext4@vger.kernel.org>
To: Andrea Biardi <Andrea.Biardi@viavisolutions.com>
References: <BN9PR18MB4219FBD6D79413965DDEFA6D9812A@BN9PR18MB4219.namprd18.prod.outlook.com>
 <20250922124128.GD481137@mit.edu>
 <BN9PR18MB4219710FC26F8A610F53AF569812A@BN9PR18MB4219.namprd18.prod.outlook.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_03294430-5BFB-4E40-8142-C357DAE981D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 22, 2025, at 8:00 AM, Andrea Biardi =
<Andrea.Biardi@viavisolutions.com> wrote:
>=20
> On 22-Sep-2025,  "Theodore Ts'o" <tytso@mit.edu> wrote:
>=20
>>> [  174.903010] I/O error, dev vda, sector 167922 op 0x1:(WRITE) =
flags 0x0 phys_seg 2 prio class 0
>>> [  174.903023] I/O error, dev vda, sector 167938 op 0x1:(WRITE) =
flags 0x4000 phys_seg 254 prio class 0
>>> [  174.903027] I/O error, dev vda, sector 169970 op 0x1:(WRITE) =
flags 0x0 phys_seg 2 prio class 0
>>> [  174.903031] EXT4-fs warning (device vda1): ext4_end_bio:353: I/O =
error 10 writing to inode 16 starting block 84985)
>>=20
>> The failure is coming from the block device, which in your case, is
>> the virtio device.  The only causes for this are:
>> 1)  An underlying hardware failure
>> 2)  A bug in the block virtio device
>> 3)  A bug in the VMM (I assume qemu in your case).
>=20
> Thank you for the quick response!
>=20
> You do have a point there, the first reported problem is effectively a =
write failure on vda.
> I tried with virtio-scsi, and can't reproduce the bug. I will try with =
a newer version of qemu first, and then look into virtio-blk.

It _could_ still be a software issue, if these vda errors are caused by =
writes
beyond the end of the block device?  These are showing errors at sector =
167922+
so if the vda=3D/boot filesystem is just below 82MiB=3D83968 =
blocks=3D167936 sectors
in size then this might be the issue?

If adding/removing this specific patch shows/hides this patch then it =
could
also be a bug in how the ext4 extents or uninitialized extent zeroing at =
the
end of the device is handled, assuming that the /boot device is indeed =
82MB.

Have you tried doing a linear read/write of /dev/vda in 1KiB units to =
confirm
that all of the sectors can be read and written?

It might also be a mismatch between /dev/vda size vs. how many block the
filesystem is formatted to use?

Cheers, Andreas






--Apple-Mail=_03294430-5BFB-4E40-8142-C357DAE981D8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmjRtugACgkQcqXauRfM
H+CHYA/+Mylu8UelQX7oQ3lRwnuywq0xmWXA9U80YLdO4saULVcVGPy1DUPd5s0R
IL8tR4hBOrpB1yhe/b81BvEsAqP+zs3jlm+B76Js9zmvtLa/WFCK3hBSR3j8jsWF
2MKfhNYLjX6+CGu5+30cVkM4xN7PDHvsL3C6ZbMJWKy5eMteSYkTCoeCnZLH3NJl
ggPegdA8zvF1cCWv4R5vEGFT8YsswCK1BM+1go/n2+KSeQGbodXgocWvBjSgvgOd
2NoK1v3ByTBc+ktFkp7RcdMf/ixUwIluw8L3/R63D5ITsWqNoAT/H1XKuT59rZUK
s47GoezSUXU6DPL62rO/gl3VICiKgG83547j61hquVhpLxZHaH92a5MAYg+XIVOC
PPcVAcISjkKBdF87kDXzfEaxdOPB6nrZKRcz4m11aBHEOeaYR0N6S/i5ii/irFNJ
jCoa6psZXVTWFl3jWMNUeU2w4NABevIos0g+9sxdjaqpYFT1r6SQ3Qlj+ZEftl1l
DElKmBkXtWzmmvB2kctH15pFg5Q3etTHUY4Bf15TbNn4u++6lL+VoSAB0Tdtombm
/7DhEXlSs3teDx0oATWuLCIWvqgwnnJFN3nsrX533/724kIBJMAHGmFRA/RNxtSF
lDNWn98EH+4vawwt8qtE3uSZ+SCL98AF1G/UE/BRGndAi/Ddzzw=
=KlRV
-----END PGP SIGNATURE-----

--Apple-Mail=_03294430-5BFB-4E40-8142-C357DAE981D8--

