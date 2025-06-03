Return-Path: <linux-ext4+bounces-8294-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3BDACCE3B
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 22:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4161633AA
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 20:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740617C224;
	Tue,  3 Jun 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="IGg7lfh+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABA15E5C2
	for <linux-ext4@vger.kernel.org>; Tue,  3 Jun 2025 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982780; cv=none; b=OfocOpdZEXy5Zi4oiaTLXDLu9ivt/k7oryIo/nCQmyZ1qpFkcHfEedELUvu4+mCIeT3VxEmyVUboB8Ol0rPPM7gKPtBAqmWngb9vRYeWwj2T4RcXsi+trdd6u1N+cywf3Put37j34nmYITZrXsu5QqwMyqFZkdZGiAOofjTArbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982780; c=relaxed/simple;
	bh=gRaERZQkhocULXlCG/X/h/R5XG8eUA2IwhcjqXRw0NQ=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=XZVgFElTtTors15l2+SbXxz40CXUr74YR9zicfUmLR0tqpI8C2T2FP5GG3uf7D6gwRntDHDUNWOK8YFMw02GqAGfYBljZCC9edl0+AOCwIXI3l7kcS844zDlPR3ZblhXJupDVOTwmX4TqztdVJUG3yNW6RfMCMAFoKYJ3pA0c0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=IGg7lfh+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234d2d914bcso43028515ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jun 2025 13:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1748982777; x=1749587577; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HVDNpuIj2vvb/nVmbPh2SBcTSRC1OTz+L9z52PGm4D0=;
        b=IGg7lfh+CC061184+JO2CdyXEnHiKXnWceKsULyGB60zgxJYPRBnT02k2ez3T8eFKA
         1yXYu45n4lTjCwkyl+4rwPdRaEzspv7xhaYArBNBGTRy0Pjbm7kCOQ+p/N95uKEOJncq
         Ppz3SrQJ+hzx3bF0DYOqsWHuLQkAlnhD5Yf0+nvlfYLpCzdP+LY2Ucooae/aPSZm4vfj
         jXXdTDihpIbOy6xCUWWZ0LLQTVXjZ+UnVvpJ+RX2T+D+maWGFnb6UNK5c6+wAnt4Hw8+
         e24zzgUQxITuwRd3hPF7Mey7xiGrOINXgSPVlWuHnatXyyUSqTiz4yRVl3joB6s9dPVH
         jYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748982777; x=1749587577;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVDNpuIj2vvb/nVmbPh2SBcTSRC1OTz+L9z52PGm4D0=;
        b=WyFNIm2NAwvg2jDCLmzAhxNiPAFhdE2DNCdLYRvsgv2whZGIrDNCZ80fHFRpng5/4c
         q5bK9+e4Bcg1hAnRn9EZZ5Efd3xA8zvDzwpLMPbYmlm5t6w3dxc1rfTW8ivThVk+2T5P
         S4YraA7s3VqVugGgi45sRmy3LURzmHchX0eNiFykeNHmOaZWz3f55B9zs/L7T89k/60Q
         BJG/6qW3bNuZ2MOSfz/RbWfqbM3/MLLSW8e2ty+ydAFzwLfz8AETI1KVp2Tliumqwypo
         jzVwMNXkClCX/5G1Ocy1G3ieSCDG8m7CyASXmFsaL3boPSZYTschCG+IBDpXtR88h3Ii
         bRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHwPETkomZkYvr6KfwKJKk5rEklX9F7lljgekgl41KT7i+aW94kn6lK3okf/0c060V1lSXw3an91ha@vger.kernel.org
X-Gm-Message-State: AOJu0YxFN530X8zkMB2UkluCol4IwiJl7GxRb5V6cACpDd9L6BYXzOFh
	LyT/t4weSdZrqU0hgzK5cHTymWC0pglXZ/S1TVyCBdK7m61i4axoozC3O0S1CuH7kHY=
X-Gm-Gg: ASbGncuvgRs8gIcLNK9Htt24cBbuUyGCLeItD5J8f+OLZ96MimqJ1KiEwqOBJcj2Vhl
	VMkAbLDv1DF3TfnDhsoZ9t3nieENh/o3zKQrHtzJueCHY7dnJvA17XPEzFewBOOmMABBmNK07fp
	7A/EoPXn+lG2WbSvC96PkCxnDdCm2GYDLrMRn9Y5t7bBSDKXdUMWQMrSe4uEFJMVcV14P0nOTNq
	AYfawVXda05d/PmKf9QI+QeMFGtdwNgPsopOddXccQDdKB9izLPFXUvWfRnuwz5z02kS0n0VwR6
	JnKY0WxAOeB4cfO8Y8xomRQTmeEid1EAGcjSFEY8wKI7ZaSCefjxRzSU2zI4sP6cfD7Qg04+fyI
	rLBUe7+Hg5/5Xn2SaER9BhRSH
X-Google-Smtp-Source: AGHT+IG+W4jIWFbfDvGkXqXleFhLy0qpdSfVmTtf97WBfpXxjF0Yuqi9x3tpb4b06hWPaaVAPd8W+w==
X-Received: by 2002:a17:902:d4cb:b0:234:88f5:c0cf with SMTP id d9443c01a7336-235e1485aa2mr1043115ad.3.1748982776945;
        Tue, 03 Jun 2025 13:32:56 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3d7a17sm7614153a91.47.2025.06.03.13.32.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jun 2025 13:32:56 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <369896EC-04BB-41D3-8A08-5A37E16F0984@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_76007CD5-E6CD-423E-9336-CF6372B91462";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [EXTERNAL] Re: EXT4/JBD2 Not Fully Released device after unmount
 of NVMe-oF Block Device
Date: Tue, 3 Jun 2025 14:32:52 -0600
In-Reply-To: <20250603002904.GE179983@mit.edu>
Cc: Mitta Sai Chaithanya <mittas@microsoft.com>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 Nilesh Awate <Nilesh.Awate@microsoft.com>,
 Ganesan Kalyanasundaram <ganesanka@microsoft.com>,
 Pawan Sharma <sharmapawan@microsoft.com>
To: Theodore Ts'o <tytso@mit.edu>
References: <TYZP153MB06279836B028CF36EB7ED260D761A@TYZP153MB0627.APCP153.PROD.OUTLOOK.COM>
 <20250601220418.GC179983@mit.edu>
 <TYZP153MB0627DED95B9B9B2E86D66EFED762A@TYZP153MB0627.APCP153.PROD.OUTLOOK.COM>
 <20250603002904.GE179983@mit.edu>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_76007CD5-E6CD-423E-9336-CF6372B91462
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jun 2, 2025, at 6:29 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Mon, Jun 02, 2025 at 09:32:18PM +0000, Mitta Sai Chaithanya wrote:
>=20
>> However, after the connection is re-established and the device is
>> unmounted from all namespaces, I still observe errors from both ext4
>> and jb2 when the device is especially disconnected.
>=20
> How do you *know* that you've unmounted the device in all namespaces.
> I seem to recall that some process (I think one of the systemd
> daemons, but I could be wrong) was creating a namespace that users
> were not expecting, resulting in the device staying mounted when the
> users were not so expecting it.
>=20
> The fact that /proc/fs/ext4/<device_name> still exists means that the
> kernel (specifically, the VFS layer) doesn't think that the file
> system can be shut down.  As a result, the VFS layer has not called
> ext4's put_super() and kill_sb() methods.  And so yes, I/O activity
> can still happen, because the file system has not been shutdown.
>=20
> If you still see /proc/fs/ext4/<device_name>, my suggestion would be
> grep /proc/*/mounts looking to see which processes has a namespace
> which still has the device mounted.  I suspect that you will see that
> there is some namespace that you weren't aware of that is keeping the
> ext4 struct super object pinned and alive.
>=20
>> Another point I would like to mention, I am observing JBD2 errors =
especially after NVMe-oF device has been disconnected and below are the =
logs.
>=20
> Sure, but that's the effect, not the cause, of the NVME-of device
> getting ripped down while the file system is still active.  Which I am
> 99.997% sure is because it is still mounted in some namespace.  The
> other 0.003% chance is that there is some refcount problem in the VFS
> subsytem, and I would suggest that you ask Microsoft's VFS experts,
> (such as Christain Brauner, who is one of the VFS maintainers) to take
> a look.  I very much doubt it is a kernel bug, though.

We've definitely seen similar situations with filesystem mounts inside
of a namespace keeping the mountpoint busy.

Adding debugging in ext4_put_super() if current->comm !=3D "umount" to =
print
the process name showed monitoring tools running in the container that
held open references on the mountpoint until they exited and closed =
files.

Cheers, Andreas






--Apple-Mail=_76007CD5-E6CD-423E-9336-CF6372B91462
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmg/W/QACgkQcqXauRfM
H+Drvw//QRJe/6jmjTiLACgdPKFx//dPxcnYS83bqCcwvAwi/K7egFjdsGkkPFuf
S1oRVgwjyaQOtKqU/ebs+F3I31pYKVItOrBB+IBJVrhLB3clNCEg5QlrFEdah90p
t2NEZpOzJJcrJZI1GsPbd150j4pZ2VYbio4qY49/E8zSPU54VK7XPl37odYXot6y
QeRBhPztuzPTMGYjyMvDoyn7lheHgb+8wsOt2bIEINRRqXksgVEDnru98HmZFxKd
G/8c+iOyQIualx6lXFl8zDpkKi2rGNcXGvyGZ2BtKlTTbPXxJjbAbVNxZ5II+ZDm
j1YmKF5L1+xI7WPl7uN/40eTSr2H1Yq1HCvOwHdTSCPFMIWHJzCliaOLOlsWM7OB
A381qDfNHi7QRrcCiYjiVTKNLuwei5Yxd0tkA8+0ypRXTxTvUUpBe+Zj6iOifsSv
cnhDGlLsX4i2zimtT+6XBnWagxxI/jY9d9Oxd2s/3vSXXTETfSqqZLS+vD4jlDV6
m0bN6/dv8XNwejmOSYQ5+iQ9eHFw0x6Ece5huLYdwsGhlGbgGHl6BsO98hewmj+R
Wi8u4lB1PSbaLbUcXeAEb/cdpoeHlEz9XzisWwXAIGMWfCgdqaGHH6JjZf4zuqPv
zKghJk29IRB4MZY7+V1yi+WMIZNVyMSywbDLRm/DqGJWH4rQuqI=
=ery9
-----END PGP SIGNATURE-----

--Apple-Mail=_76007CD5-E6CD-423E-9336-CF6372B91462--

