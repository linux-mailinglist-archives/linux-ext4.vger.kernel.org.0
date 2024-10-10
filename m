Return-Path: <linux-ext4+bounces-4563-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7418399943A
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Oct 2024 23:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2D11F285B2
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Oct 2024 21:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4F1E2830;
	Thu, 10 Oct 2024 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="mDjHOYt2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A31E2317
	for <linux-ext4@vger.kernel.org>; Thu, 10 Oct 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594287; cv=none; b=i7W/ZA8Etjon/Fq6m5GtYV3Atl5VNKGkUAkEphAeVFDh9zCKcX/s9xvs8rtshnXQNaLrBlKDh+DfosmbrKqqZfz0ZfkS/nnAG5dWJzBuiIsDaaxOtX158/eYSoZPzAM4A4exStzxxLifKtqlPlAoZ4vOtFCeXB1btHLnDiTbsC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594287; c=relaxed/simple;
	bh=+lwrhBbfCHbY15soZ8qQFvmU9QO27WFLZclr11V0zkY=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=bsUa/PsDj5sI3yKTB7XJv3lhiKciTKl5lw2v8KxpIEDoOf3/lITZAFB/8VwpvVXXKxVxENcZULKPitIHsGBEsC21yPjUwEZ15EFn8hst4mp6RZDNRfwc5hzK2OR5Y4ImS3E5838vVbxSgz2Sb+U9kcVStcjR3HqePq7HGAzjnRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=mDjHOYt2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b8be13cb1so14953515ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 10 Oct 2024 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1728594284; x=1729199084; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HOXAAWOUO42Iy9Fe066sbNSBqIXI7uWiqzyRC9lRxXQ=;
        b=mDjHOYt2JZM9knW4TV72To8dGPF0BJRBKWJrTfG0z5EELcqPSAYvXEULd3l0dNBSBW
         dqMPmPQtFfE+S4hZ8vYqomtht64WYGQcd5qwYI6QgFYE5t7ALlGMz1Sc+nsXWo3NJ/9E
         Z6uwXipAZkJDlFVhDDdi9J00dRqo7z6zZStIIT00MTTGSe9DA0ub4s+lWzgdQcz5wAhM
         qzp1TUy+wLmBg2bBNBGe3tsvmlYbZ0nU6hBNbifrm4/kwkuH7P7ksJPvpvh+MiL9/Msu
         iWStkH/fX6BPaloxxJfY7281ZmEJ58Auv7mXiDig2M9+lcZhtPfDVlpDSPWzsON4BNnz
         ncKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594284; x=1729199084;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOXAAWOUO42Iy9Fe066sbNSBqIXI7uWiqzyRC9lRxXQ=;
        b=B6GJv+ALlVC5QaSIkDNu0LTuuS8zgXnaFyCK7v6FCRd8vwuwi+41N3IfjvDEl/q0ZR
         cagKHYnHX+74eUDdXZpoULFsOtSNigJCVHgHHRJ2iGciHI0idy1dPxLIc9t62kQiR7vv
         ituaZo8cv/0qCFhKPgmhLk+d/CdsQ3pp4warFSzDMyCJ0B4t2CDMloaj2f8kaK2JT7CG
         9ddzemOhVaC8L53/dMhZZWfeMVaim4a5FSio5tFxGybdclBjRC9nu5hM5Naqe62+wQ7i
         7de9iSPnlYOOG/RY0OCLyfNLU5KvbhFFdaU2MTzeihE/qMnaDxWT1gW5xZizd5utIZqc
         24fg==
X-Forwarded-Encrypted: i=1; AJvYcCX4zne9nRFUJiuLxnD45N46WJ2roRb8zpYOifvHprBTcirSHbfZCz/vDSahT3pxNFuj5wEEueqLNzAW@vger.kernel.org
X-Gm-Message-State: AOJu0YwRx3FqChvlufzTJ0OFT48JxOxblBtDLJiRxujDnVXhWeuLQZLV
	CFe+Q4fvS4PhbnLJZS2a5MDCjMQT94EbIJ27sL2zBWcVSbHR1dJG1PVyOpulmO4=
X-Google-Smtp-Source: AGHT+IGfQSroh/1VmCw3y+pZWR9nNIoy24k2NTL449Btzyp91i/0YvQF2oSnGggy7CFITjsQGBa1ZA==
X-Received: by 2002:a17:902:e549:b0:20b:6457:31db with SMTP id d9443c01a7336-20ca1466d0amr2991515ad.30.1728594284429;
        Thu, 10 Oct 2024 14:04:44 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad99ecsm13406815ad.3.2024.10.10.14.04.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2024 14:04:43 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <198BCE25-4D30-409B-B7AA-5802E0D26621@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D7F73B52-8651-4588-82F6-F30885017D58";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] ext4: prevent data-race that occur when read/write
 ext4_group_desc structure members
Date: Thu, 10 Oct 2024 15:04:47 -0600
In-Reply-To: <20241003125337.47283-1-aha310510@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 akpm@osdl.org,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
To: Jeongjun Park <aha310510@gmail.com>
References: <20241003125337.47283-1-aha310510@gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_D7F73B52-8651-4588-82F6-F30885017D58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 3, 2024, at 6:53 AM, Jeongjun Park <aha310510@gmail.com> wrote:
>=20
> Currently, data-race like [1] occur in fs/ext4/ialloc.c
>=20
> find_group_other() and find_group_orlov() read *_lo, *_hi with
> ext4_free_inodes_count without additional locking. This can cause =
data-race,
> but since the lock is held for most writes and free inodes value is =
generally
> not a problem even if it is incorrect, it is more appropriate to use
> READ_ONCE()/WRITE_ONCE() than to add locking.

Thanks for the updated patch.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

>=20
> [1]
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in ext4_free_inodes_count / ext4_free_inodes_set
>=20
> write to 0xffff88810404300e of 2 bytes by task 6254 on cpu 1:
> ext4_free_inodes_set+0x1f/0x80 fs/ext4/super.c:405
> __ext4_new_inode+0x15ca/0x2200 fs/ext4/ialloc.c:1216
> ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
> vfs_symlink+0xca/0x1d0 fs/namei.c:4615
> do_symlinkat+0xe3/0x340 fs/namei.c:4641
> __do_sys_symlinkat fs/namei.c:4657 [inline]
> __se_sys_symlinkat fs/namei.c:4654 [inline]
> __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4654
> x64_sys_call+0x1dda/0x2d60 =
arch/x86/include/generated/asm/syscalls_64.h:267
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> read to 0xffff88810404300e of 2 bytes by task 6257 on cpu 0:
> ext4_free_inodes_count+0x1c/0x80 fs/ext4/super.c:349
> find_group_other fs/ext4/ialloc.c:594 [inline]
> __ext4_new_inode+0x6ec/0x2200 fs/ext4/ialloc.c:1017
> ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
> vfs_symlink+0xca/0x1d0 fs/namei.c:4615
> do_symlinkat+0xe3/0x340 fs/namei.c:4641
> __do_sys_symlinkat fs/namei.c:4657 [inline]
> __se_sys_symlinkat fs/namei.c:4654 [inline]
> __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4654
> x64_sys_call+0x1dda/0x2d60 =
arch/x86/include/generated/asm/syscalls_64.h:267
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> value changed: 0x185c -> 0x185b
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
> fs/ext4/super.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..8337c4999f90 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -346,9 +346,9 @@ __u32 ext4_free_group_clusters(struct super_block =
*sb,
> __u32 ext4_free_inodes_count(struct super_block *sb,
> 			      struct ext4_group_desc *bg)
> {
> -	return le16_to_cpu(bg->bg_free_inodes_count_lo) |
> +	return le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_lo)) |
> 		(EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT ?
> -		 (__u32)le16_to_cpu(bg->bg_free_inodes_count_hi) << 16 : =
0);
> +		 =
(__u32)le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_hi)) << 16 : 0);
> }
>=20
> __u32 ext4_used_dirs_count(struct super_block *sb,
> @@ -402,9 +402,9 @@ void ext4_free_group_clusters_set(struct =
super_block *sb,
> void ext4_free_inodes_set(struct super_block *sb,
> 			  struct ext4_group_desc *bg, __u32 count)
> {
> -	bg->bg_free_inodes_count_lo =3D cpu_to_le16((__u16)count);
> +	WRITE_ONCE(bg->bg_free_inodes_count_lo, =
cpu_to_le16((__u16)count));
> 	if (EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT)
> -		bg->bg_free_inodes_count_hi =3D cpu_to_le16(count >> =
16);
> +		WRITE_ONCE(bg->bg_free_inodes_count_hi, =
cpu_to_le16(count >> 16));
> }
>=20
> void ext4_used_dirs_set(struct super_block *sb,
> --


Cheers, Andreas






--Apple-Mail=_D7F73B52-8651-4588-82F6-F30885017D58
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmcIQW8ACgkQcqXauRfM
H+DDghAAoLVAiMC+T+w1FSCTI0cff6trG1fotAT5i3ow9mlKY5NpP5o6yZ5XsOsc
xjzAYgqD3XTP+KdFzboSzeWB3R6UUjk/uvNzRz41xemzNWJhfPpW/M/lX+N0Jl0y
STC72SHg0GreZd2eW4iuVljmGCRgPPVl8YFnb3r/dkSZ9aZClEZ0OoiimpyJOCpM
rTFfXt/98MWMCgr8442iQ+Y2Tc9m2PzVDeo0cnFP94iCXZcX5oAHnf6VYK0E16ht
LLN5sdJTDpb94/Gq1EtdUWlFU40VQZJOjMufd38rEnZXhHGR2qVq6BT7YHRSezHX
NsUO4NepDyESsP6NdIrCoUeGKaAJRIymwzAbSHwQVR9VrFpzQJ4UCkQV/8d5/m8u
oXuAvaTG8+35XYROR6jjBNMJKanPQXgo91Dl2uhZaPg5jA9ZX7fp0MlSI+SY4CyH
YkfFBSNKOIqSEMzeak4JaOGCY/+nH3fSLN8kBOeAmDMMX/EJwmBRDAawo84qZ2hJ
mCV6YJcnF+PBdhFLiYoo/6fYVjd/0Nz3TOegDKCeglLuUlDMp+g88+kwC0Q7WhA4
atVSnkAu4jirjV11IDEr0Qe1Wf0gwevGH4z8PESrQrHP8SaLz5H4FERytfwqjF4C
Z7cnbbSb9f3rQ5pBqpwPn+OIWy64nXVoO6L42MM+JE+pJRB4kNs=
=wf4O
-----END PGP SIGNATURE-----

--Apple-Mail=_D7F73B52-8651-4588-82F6-F30885017D58--

