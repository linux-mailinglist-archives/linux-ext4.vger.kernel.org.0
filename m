Return-Path: <linux-ext4+bounces-1741-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFA88759E
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Mar 2024 00:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AAE1F23E10
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 23:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971CB82892;
	Fri, 22 Mar 2024 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="LGFiwTyg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335A82893
	for <linux-ext4@vger.kernel.org>; Fri, 22 Mar 2024 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711148997; cv=none; b=qEFLZret46bDW8EzRtfLocVDhgRiSbvnMFNWID7xUbwdMlvkEXR3mhu9xim8qoBz6/ZTzKOhmz/JGRx0Y0ns82OZwNEdR+S8EraEvBdoQEFbr+XZ63J+MzVG6GDS2SHda1pMtOZACmoPrf1UEtW0UXrAir/aKJVNxoY6m1E3cFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711148997; c=relaxed/simple;
	bh=jeRa4DLXFpSDpuRSoBN3nhwwrFS7Vdvq6WsBPRRQVYA=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=IyHKdMHwvlijtSIoaSNe+I5phA9sPNzfjorO6j1/1uOsCAlo1BYUzJQWQodlA61RSG6NSYFHzSo3q7aWDahhreqwFKRrrSl7F56M310Lk1oS86uYy/WJpuBUlvRXB3rYCwpsshlLyWIMittJgME9DMG5Oqp7w/ePOiYevjrQc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=LGFiwTyg; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430ca04b09bso19291901cf.1
        for <linux-ext4@vger.kernel.org>; Fri, 22 Mar 2024 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1711148993; x=1711753793; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UgF3TbhMPygJT52i6+DbefarjcSqH9PqI9CndRYXlNM=;
        b=LGFiwTygt0n3GVdKf5Tnb/sPtgAFF+XR7zYZXAS24EPpZd5RsaCSxmCUQ8Silrgd/+
         9uRqKR19DgZTpleDoOCJEkf07WH7nYgpqpPYXXtgNJ2fuWoQk1aXr9AG5SdU4swZnF5A
         jFTgnoeZ1YnoXDjP1fRfO4nAqMcREOY0adQoDF6dxkA+dK/t3DzzCaxZjgGXlOpUGOQy
         qe2mgiM+3zzXhbVt9ttD1opq4pe4q86CT6s7nyKbRMMMrAyVi3NR6S+6rHr2vJf7UFA2
         Vk9Xyq6r8o7TMhrJcCWdaAe2PeF9hzgSiQ9evd4dopWaAgxufbVrDiYuuR485SpDKAb6
         SrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711148993; x=1711753793;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgF3TbhMPygJT52i6+DbefarjcSqH9PqI9CndRYXlNM=;
        b=i7jtzZO2zddr4bojIeFNSRsgrgsWJJ7kM86yCOp5zEApszhg2HIVPnmi+61V0G4a6N
         HS2iCl5Ly4RinlebA6cvLp7uH7E24U6WGMoRM6Exd8soDOOHgOY2+3/O1w3XAC+daSlr
         hQ+LsrwZ319fMYHX7FHe0d5lyI+iEfsX2P4Z92Pgw9bwaI7RgECTUXJxQqSS356GKNap
         oTX6MLo52kI25VPOBWBCwgwcntUWGWR3F3qIhmR3rmcKYUbYxfyf7VVNAQo1Dy2lR5L6
         Zzh4FYZHNvyDZmoUAiH3Q0cR/vVTFRUc93ZlxYr0pYvsO/xYfnHrxosYiyWw4UBaSU9S
         DXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBrFg68/6bYMdqxGRCy69SedwTj1t1+Ora4NavyB3NVy4oox1wPye67UCB9OB3I/38z4+a4lgQ7W3Ii20SvTZlnvpHjkz48gR1yA==
X-Gm-Message-State: AOJu0YxhExRTyI273qzX39LcrCh/dF5yly2M+OFofuOBI0YNmpRoibMM
	qzrH5qeDBBFzgKEx/bcCqVEcTblih9YkeKlLbUydj/MFOcnJTRON/cKXABnwLvFlNhwyYZEBDbk
	e
X-Google-Smtp-Source: AGHT+IHspXHKhz8WInyW4vAxHJQUDuGtWZzH6YtVqtNIFEMIDwzLF/84EH/yEaD/1c+LSyHKkBcfGA==
X-Received: by 2002:a05:6a21:33a2:b0:1a1:48aa:2827 with SMTP id yy34-20020a056a2133a200b001a148aa2827mr1151796pzb.39.1711148534968;
        Fri, 22 Mar 2024 16:02:14 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id t184-20020a625fc1000000b006e7243bbd35sm304301pfb.172.2024.03.22.16.02.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2024 16:02:13 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <157E2709-34C2-4C45-BF68-BF55780480A6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9A948BF3-167F-40B7-B1E4-3D6BCCDB7976";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Date: Fri, 22 Mar 2024 17:03:03 -0600
In-Reply-To: <20240315035308.3563511-4-kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
 <20240315035308.3563511-4-kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_9A948BF3-167F-40B7-B1E4-3D6BCCDB7976
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 14, 2024, at 9:53 PM, Kent Overstreet <kent.overstreet@linux.dev> =
wrote:
>=20
> the new sysfs path ioctl lets us get the /sys/fs/ path for a given
> filesystem in a fs agnostic way, potentially nudging us towards
> standarizing some of our reporting.

I find it ironic that we are adding an ioctl to be able to get the
sysfs path, which was originally created to avoid adding ioctls...
But, the days of jumping through hoops to find stuff in sysfs for
each filesystem arrived long ago, so we may as well make it easier. :-)

Cheers, Andreas

>=20
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: linux-ext4@vger.kernel.org
> ---
> fs/ext4/super.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index f5e5a44778cf..cb82b23a4d98 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5346,6 +5346,7 @@ static int __ext4_fill_super(struct fs_context =
*fc, struct super_block *sb)
> 	sb->s_quota_types =3D QTYPE_MASK_USR | QTYPE_MASK_GRP | =
QTYPE_MASK_PRJ;
> #endif
> 	super_set_uuid(sb, es->s_uuid, sizeof(es->s_uuid));
> +	super_set_sysfs_name_bdev(sb);
>=20
> 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
> 	mutex_init(&sbi->s_orphan_lock);
> --
> 2.43.0
>=20


Cheers, Andreas






--Apple-Mail=_9A948BF3-167F-40B7-B1E4-3D6BCCDB7976
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmX+DicACgkQcqXauRfM
H+CJgw/+PaOI0yH8X6md/q6dpGtw7cT+GJNkNUqlr1yw/LAXo5PILhX8BoeGtNn0
xVUkNjlKa5esWlZzNALY9MVdlc3Vnrqny11EzovQn9cS046ZGOfPgKJr3rHxND0B
Uik9qVHxqimn5XPydHnHw0ieGMSSEqCnMWTjx+AydPcETDakFYTefQdUSk5tQoGK
1XuLbZI4m+7waWOA0UPCx79n/qHr9cRvBCbGDrIorO6/A59w+k/bawKY06z0gUu0
/eERceymgH28673XZX464zh8es0u8D82gpN84SM6awJbWF/1btgM41WVuQMRQml7
kZk3uHXy1OFz3Va4WDA2pgROcuBVCbjC+50iE2zJ7NH6qAOiITsxpvzk2C8zf62x
Xnu4MPZff989gurDKSjtmvzdZ1tUoQpVxb5uSLqDNar0Z6GI+IGCUdkXNH6hGb1T
hspCIGhg1xzDud3/HTHnjzQswYM2A750U/b2FwBTnig8DVjpcca5qsRqkj4KEo/H
NAK6xP4g3Lhw/b5tBwCRwvH5cgtmiW37WuKk+RFpIILXHxo0FHOPvNQ1CrF8Hwk2
Q7MJ2XdscsCaUfkVYKCRITjGtPqtgBBsaOteo+2eP2zMHgYW4DSA/qOiHtVUj2wJ
L/cX1nOSkk2LQlphDL3eOLa0C+8Az0j7w2kzeYHw5ELW8neQc6Q=
=ABi7
-----END PGP SIGNATURE-----

--Apple-Mail=_9A948BF3-167F-40B7-B1E4-3D6BCCDB7976--

