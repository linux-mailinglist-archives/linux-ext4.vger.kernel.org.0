Return-Path: <linux-ext4+bounces-4230-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D397CE8F
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 22:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3A8282CA9
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D4814C581;
	Thu, 19 Sep 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="J/NLZK3p"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08463F9D2
	for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2024 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778198; cv=none; b=LAshRj7GdO93LuVNpFwAy7F6n3K8lzkmpTmDgxJBQdfxOt8+TmJeugWTf/KX+0KEjcGpBdEuBU09lAGV4VGI5Whpj/XkPzKlPzq/hbkMkRc4VOdcv155uKkLOvCM+0173AxESq+aJfr4HBX/sjnUfyxY5Sqk2AtZtI/R6BnmU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778198; c=relaxed/simple;
	bh=YsDAxbjr/PZbwdlDhSChefDcKKaDAEGWZeT5iQvQnhM=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=Eg16jRTjE8JCF99oH0IE//hS6FITChOPfp+8POqPJEgT2Et8NyIJm2HLaC0iN0dxd0L/M3arzXql51+cklIbCn5eTOCCyDGq86TLEG4i4wbYZ65KYa2JCpvnnR3J6zLN/6jJkh5g4yc6T0fvhj/+Um7VAqUdcHSl0SpIGIAcNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=J/NLZK3p; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so1761262b3a.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2024 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1726778195; x=1727382995; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=snSMxJ8Ty5N/5c52GVNN3+eZ3O8veg7dbcibfAXneKM=;
        b=J/NLZK3pc8doAI4Tj+I3VuUw5vM0vVLVeDnBfnLcm2Ad8Pnn4qFO1fxfITltnx0epI
         MlCAqP4AQlPu3Lebg/Rc/VvyEkX3kvyC86Z9d7vXyp7ELsa0juMS1wzrKZGpDzSlvvuK
         PGxr4GVqFCICySLgLf7NWh6jvge7U0i15yHah24X9ClylwETuzLuBYQkCWbkmCu6iQ3n
         +QBhDt6/RD2R0AUGIWOV+3GGocjwkQ0e04E16NQ/NTZLoRQfN/F99Ahjso7YtyW0grsd
         fBDdGO1Mi2f84NSwpfwr57WLrInNdwVE7mUjlcOhf36EYuKOjN4/9lckBBIAzgDNsNz5
         ch/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726778195; x=1727382995;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snSMxJ8Ty5N/5c52GVNN3+eZ3O8veg7dbcibfAXneKM=;
        b=WSbQ0q/d40fNxYcZhz7L1aiVBErIwADHrmO3T8h8H82sGImzf1E+3Vx8C4PxGF7Njs
         xqT4AYN00zYcAQBhnlGP2EWsJWehG1N4QNV5/oEauD7TXf47PoQW4GkLnzw19SNmQs9J
         uN1d/mQBxNYvNZnmkZxd2XubzmQ22VkV+PBTuhJxUUMAGCunJEvgjvihwcKNjW/hWgV0
         EowOhv12oT3auanC4FYf5e9KAhlC2aztdxZK5U2l76swobagZUFuYF478YCQbMI721yV
         LN1yCY5V5d0kwoeNRiENeWqSiANg7J5jOZhxpAykEPswk7opqffVvDFtre+9oeKWamQy
         Vczg==
X-Forwarded-Encrypted: i=1; AJvYcCXP3K4zcDWFpzDKBADfCZxDHFu4LCnxgs3zdTziinK2Gloo4PPkYNDzSk5n7H3KTczMx+rY+F2teKTp@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5uzbcxVTNpNHQrSctJpupH0wJMy9OwZJW0cdB1H1ivmMYscq
	5flzCyC/jYhCgP1lLbsN1WG1LtDOT2m8X6ZhcE1b2bTFOmvMJnsQWZRylIImXSQ=
X-Google-Smtp-Source: AGHT+IEPSPGFkUKYwMbyA86b6vt78E8e8TsqlyW9ozmsSEud9W4nXX1J8pMat28TvGWn9vy7B3AOxA==
X-Received: by 2002:a05:6a00:91c2:b0:718:db3b:435 with SMTP id d2e1a72fcca58-7198e299d6fmr6255469b3a.8.1726778194905;
        Thu, 19 Sep 2024 13:36:34 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b21csm8644889b3a.123.2024.09.19.13.36.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2024 13:36:34 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <5E4A9CEF-3355-4362-A17D-9BFBA81D2094@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_38203389-B12B-4A54-BA3E-8CF4EB30B995";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: prevent data-race that occur when read/write
 ext4_group_desc structure members
Date: Thu, 19 Sep 2024 14:36:28 -0600
In-Reply-To: <20240918092141.213584-1-aha310510@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 aneesh.kumar@linux.vnet.ibm.com,
 shaggy@austin.ibm.com,
 akpm@osdl.org,
 alexandre.ratchov@bull.net,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
References: <20240918092141.213584-1-aha310510@gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_38203389-B12B-4A54-BA3E-8CF4EB30B995
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 18, 2024, at 3:21 AM, Jeongjun Park <aha310510@gmail.com> wrote:
>=20
> Currently, data-race like [1] occur in fs/ext4/super.c
>=20
> Since the ext4_group_desc structure does not have a lock to protect =
its
> member variables and there is a possibility that unexpected behavior =
may
> occur in the future if a data-race occurs, I think it would be =
appropriate
> to modify the ext4_group_desc member variables to be read/written =
atomically.

It is unclear if this is enough, or alternately whether it is needed at =
all?

There is still a race window between accessing/setting the _hi and _lo
fields in the group descriptor that could result in torn writes.
This will _rarely_ be an issue for many filesystems, since block/inode
bitmap numbers are only read, so it is only the block and inode counts
that are changed.

Also, it is only a fairly rare use case where there are more than 2^16
blocks or inodes in a single group, so the _hi field should almost =
always
be zero, unless this is a 64KB blocksize filesystem?

It looks like ext4_lock_group() could be used to protect this access, =
but
that is very expensive for the read side, and unnecessary for 4KB =
blocksize
filesystems (the vast majority of cases).

I suspect that the inode allocation side is *already* holding the group
lock so that the bitmap update and other fields are atomic?  It probably
makes sense to get ext4_lock_group() at a higher level (e.g. =
ext4_symlink()
or __ext4_new_inode() when it is allocating the inode) rather than =
pretend
the two _lo and _hi accesses are atomic at the lower level.

Cheers, Andreas

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
> Fixes: 560671a0d3c9 ("ext4: Use high 16 bits of the block group =
descriptor's free counts fields")
> Fixes: 8fadc1432368 ("[PATCH] ext4: move block number hi bits")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
> fs/ext4/super.c | 56 ++++++++++++++++++++++++-------------------------
> 1 file changed, 28 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index e72145c4ae5a..9c918cf2eb7e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -314,113 +314,113 @@ void ext4_superblock_csum_set(struct =
super_block *sb)
> ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
> 			       struct ext4_group_desc *bg)
> {
> -	return le32_to_cpu(bg->bg_block_bitmap_lo) |
> +	return le32_to_cpu(READ_ONCE(bg->bg_block_bitmap_lo)) |
> 		(EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT ?
> -		 (ext4_fsblk_t)le32_to_cpu(bg->bg_block_bitmap_hi) << 32 =
: 0);
> +		 =
(ext4_fsblk_t)le32_to_cpu(READ_ONCE(bg->bg_block_bitmap_hi)) << 32 : 0);
> }
>=20
> ext4_fsblk_t ext4_inode_bitmap(struct super_block *sb,
> 			       struct ext4_group_desc *bg)
> {
> -	return le32_to_cpu(bg->bg_inode_bitmap_lo) |
> +	return le32_to_cpu(READ_ONCE(bg->bg_inode_bitmap_lo)) |
> 		(EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT ?
> -		 (ext4_fsblk_t)le32_to_cpu(bg->bg_inode_bitmap_hi) << 32 =
: 0);
> +		 =
(ext4_fsblk_t)le32_to_cpu(READ_ONCE(bg->bg_inode_bitmap_hi)) << 32 : 0);
> }
>=20
> ext4_fsblk_t ext4_inode_table(struct super_block *sb,
> 			      struct ext4_group_desc *bg)
> {
> -	return le32_to_cpu(bg->bg_inode_table_lo) |
> +	return le32_to_cpu(READ_ONCE(bg->bg_inode_table_lo)) |
> 		(EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT ?
> -		 (ext4_fsblk_t)le32_to_cpu(bg->bg_inode_table_hi) << 32 =
: 0);
> +		 =
(ext4_fsblk_t)le32_to_cpu(READ_ONCE(bg->bg_inode_table_hi)) << 32 : 0);
> }
>=20
> __u32 ext4_free_group_clusters(struct super_block *sb,
> 			       struct ext4_group_desc *bg)
> {
> -	return le16_to_cpu(bg->bg_free_blocks_count_lo) |
> +	return le16_to_cpu(READ_ONCE(bg->bg_free_blocks_count_lo)) |
> 		(EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT ?
> -		 (__u32)le16_to_cpu(bg->bg_free_blocks_count_hi) << 16 : =
0);
> +		 =
(__u32)le16_to_cpu(READ_ONCE(bg->bg_free_blocks_count_hi)) << 16 : 0);
> }
>=20
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
> 			      struct ext4_group_desc *bg)
> {
> -	return le16_to_cpu(bg->bg_used_dirs_count_lo) |
> +	return le16_to_cpu(READ_ONCE(bg->bg_used_dirs_count_lo)) |
> 		(EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT ?
> -		 (__u32)le16_to_cpu(bg->bg_used_dirs_count_hi) << 16 : =
0);
> +		 =
(__u32)le16_to_cpu(READ_ONCE(bg->bg_used_dirs_count_hi)) << 16 : 0);
> }
>=20
> __u32 ext4_itable_unused_count(struct super_block *sb,
> 			      struct ext4_group_desc *bg)
> {
> -	return le16_to_cpu(bg->bg_itable_unused_lo) |
> +	return le16_to_cpu(READ_ONCE(bg->bg_itable_unused_lo)) |
> 		(EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT ?
> -		 (__u32)le16_to_cpu(bg->bg_itable_unused_hi) << 16 : 0);
> +		 (__u32)le16_to_cpu(READ_ONCE(bg->bg_itable_unused_hi)) =
<< 16 : 0);
> }
>=20
> void ext4_block_bitmap_set(struct super_block *sb,
> 			   struct ext4_group_desc *bg, ext4_fsblk_t blk)
> {
> -	bg->bg_block_bitmap_lo =3D cpu_to_le32((u32)blk);
> +	WRITE_ONCE(bg->bg_block_bitmap_lo, cpu_to_le32((u32)blk));
> 	if (EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT)
> -		bg->bg_block_bitmap_hi =3D cpu_to_le32(blk >> 32);
> +		WRITE_ONCE(bg->bg_block_bitmap_hi, cpu_to_le32(blk >> =
32));
> }
>=20
> void ext4_inode_bitmap_set(struct super_block *sb,
> 			   struct ext4_group_desc *bg, ext4_fsblk_t blk)
> {
> -	bg->bg_inode_bitmap_lo  =3D cpu_to_le32((u32)blk);
> +	WRITE_ONCE(bg->bg_inode_bitmap_lo, cpu_to_le32((u32)blk));
> 	if (EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT)
> -		bg->bg_inode_bitmap_hi =3D cpu_to_le32(blk >> 32);
> +		WRITE_ONCE(bg->bg_inode_bitmap_hi, cpu_to_le32(blk >> =
32));
> }
>=20
> void ext4_inode_table_set(struct super_block *sb,
> 			  struct ext4_group_desc *bg, ext4_fsblk_t blk)
> {
> -	bg->bg_inode_table_lo =3D cpu_to_le32((u32)blk);
> +	WRITE_ONCE(bg->bg_inode_table_lo, cpu_to_le32((u32)blk));
> 	if (EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT)
> -		bg->bg_inode_table_hi =3D cpu_to_le32(blk >> 32);
> +		WRITE_ONCE(bg->bg_inode_table_hi, cpu_to_le32(blk >> =
32));
> }
>=20
> void ext4_free_group_clusters_set(struct super_block *sb,
> 				  struct ext4_group_desc *bg, __u32 =
count)
> {
> -	bg->bg_free_blocks_count_lo =3D cpu_to_le16((__u16)count);
> +	WRITE_ONCE(bg->bg_free_blocks_count_lo, =
cpu_to_le16((__u16)count));
> 	if (EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT)
> -		bg->bg_free_blocks_count_hi =3D cpu_to_le16(count >> =
16);
> +		WRITE_ONCE(bg->bg_free_blocks_count_hi, =
cpu_to_le16(count >> 16));
> }
>=20
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
> 			  struct ext4_group_desc *bg, __u32 count)
> {
> -	bg->bg_used_dirs_count_lo =3D cpu_to_le16((__u16)count);
> +	WRITE_ONCE(bg->bg_used_dirs_count_lo, =
cpu_to_le16((__u16)count));
> 	if (EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT)
> -		bg->bg_used_dirs_count_hi =3D cpu_to_le16(count >> 16);
> +		WRITE_ONCE(bg->bg_used_dirs_count_hi, cpu_to_le16(count =
>> 16));
> }
>=20
> void ext4_itable_unused_set(struct super_block *sb,
> 			  struct ext4_group_desc *bg, __u32 count)
> {
> -	bg->bg_itable_unused_lo =3D cpu_to_le16((__u16)count);
> +	WRITE_ONCE(bg->bg_itable_unused_lo, cpu_to_le16((__u16)count));
> 	if (EXT4_DESC_SIZE(sb) >=3D EXT4_MIN_DESC_SIZE_64BIT)
> -		bg->bg_itable_unused_hi =3D cpu_to_le16(count >> 16);
> +		WRITE_ONCE(bg->bg_itable_unused_hi, cpu_to_le16(count >> =
16));
> }
>=20
> static void __ext4_update_tstamp(__le32 *lo, __u8 *hi, time64_t now)
> --


Cheers, Andreas






--Apple-Mail=_38203389-B12B-4A54-BA3E-8CF4EB30B995
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmbsi0wACgkQcqXauRfM
H+AYJw/8DUqqkjsXgV4V8q49pQzTRWFfBYiHqMj+vRqowUnQtzyPIOraN1wji4Zu
vXNdRZtXxaJ1ld4unbOMi9WNT5izQRv9hlVj8LtD8f9zDmRiYF6oogxAxgOmkElq
ygYIrarPRxub5aygVZA7z7SQ811lpWFTIGVFTbh1ZuI2yBZ0AW1mA2rZW+hOz7H2
FJHZS72gx6efOBJ+L14KWZjzrffHCeui++2VTDeUN+haBml1OlnWtLpAbvbKlBtZ
FgXiRx74bnZNQ3bSMPEy3cmSao/QJpQmExR/v+2o+WzrdkYvaCHpDsX5sPaPYEqf
88NqnGYv3GWnMBkx9uSClHD1CnRlZaX4q7YMCqR83vLpsE3IlFYAXIP8t0ljpwDt
hFOWTQ/Li79LgUNJAC0RmptujMHVLf8s+9i6DBoZqM8/AexK3EH60GBfsUQP/o/Y
ja8esfx8yLkrUJcGfZ/Gcod5mfrsI9ayF0yiHzpJW7xgenBREwlvMozjmj+D4cgn
N3eGW5okiLpqOvNSaVI31TIYdvHOmYPEas/fsFPKcUPMDQt5H3aPi/87O/hhVyy8
Azp09zzHuvuQ8HWRq0PxUujDwQzRHRjuktXxipisCh4UWAlpPk5vDP3tzpN5zNnD
vAnep1K66nK7wVVxirC/PE0cc3rTx/6A0NCz3VjDAIYQn8SDP7M=
=uHZ8
-----END PGP SIGNATURE-----

--Apple-Mail=_38203389-B12B-4A54-BA3E-8CF4EB30B995--

