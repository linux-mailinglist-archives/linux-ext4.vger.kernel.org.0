Return-Path: <linux-ext4+bounces-4201-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575A497BA0D
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 11:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE6F1F22E67
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 09:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CA216EB56;
	Wed, 18 Sep 2024 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQjxfE1c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0992868B;
	Wed, 18 Sep 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651311; cv=none; b=ZZROrwW2PdnT1LOLhc/HPJjeW2q44wkm97YR4FXj9ujuPSxTyseTV54OQgVcxQ4DorCuZpt255yOHdkkX4igNvKC+QREF+YdbLb/XZpbposvUsZV+MaGHxsdiGSP3HAHPnjEa6li+Z/1xhHhPwu7BO5gtFFQuCtZKgB/o4W0Kg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651311; c=relaxed/simple;
	bh=1BELm9mLeFSN/MYxaKyAvm3TaGVnVAWQv/Xu0oXSY20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NPbDdn8j6G0wKmM4tlP4aCFDyWAuMum8r1qwc6VrGYdU4EuIat0EbyyX2eR62i3hcD35ELWW2YeHagRpnIsiQAzDtVRxLvEpnUEemgquPn9wXOIja5S79R53i1xsNz4GcWTMNWhnp4ycje2oe7hoGacgyP1krsbDauvfxC7onhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQjxfE1c; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2055f630934so55925365ad.1;
        Wed, 18 Sep 2024 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726651309; x=1727256109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEP5rLu/74jPCIwcYJptqtU03Mq/Af34CDXsVsOL2Uo=;
        b=dQjxfE1cGP7FjGecyagqOxWIGTyoP1YZcX6HrcgX2b+QE4yhorzoFfXB6boryPgwbk
         sMuUFx/MEqmoj9Q4s4ugkK/459YocSm/ugDjUHflwdjQY4DTSvSMzHy6DvhzC9AIvUiP
         QI2XQKJ0bpvmK33LJCNbT9RIpp5vkNq3aDylOwGZVVPs9Cy9melFbrwbmC03GUxgciGD
         2s81xx0EikB+wc/3tIMikTQqLf11cIt5PEBk+SrMQC5F/Uqg0w5l8ccossWw4zmvFqnK
         PWXh2LiWsddxKomFWi59ppiCrO6O1Y+QGzC2LJnTJ3SJJrB8kasoJ5WC67exapgzZYY/
         NP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726651309; x=1727256109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEP5rLu/74jPCIwcYJptqtU03Mq/Af34CDXsVsOL2Uo=;
        b=NLauPtbH28NmPeL3x/2R3TW7Cbw1dUQ/4s+e1P6aMCJoVklbEy8e5mKKFiJtEF7K+U
         OBrMY1PJamGW37Q+8mBoEcTU9xfJFbApLZb7ZWLgSN+dsrjrBEFDPGqXmGJwpPsTyM09
         AG3A4cAz5aw4e/+n9D/fBApI7HT5wgdeM+ATBq/QSisyBqHHeX4pvLxF/qhFdYxCw0bm
         62KAn9J5sUKJkAqPC1ZrS9EAFsO/+Vwory58TGVDC/4vLHlYa7oRBpkH0hti9MiPCm5f
         2YxJHPanguvBEK1LHZZO3JxERwyL+SNyNSu4gocXdepF716rj+Yy+4nkrcd6vwswZIjs
         y74w==
X-Forwarded-Encrypted: i=1; AJvYcCXGP821iBlAXjsFx5Ej6Kvoxv6Mij7xbpySd8zpr+A/sNueYrBRBvXlQ9WpkbrRjQb+QlUui/MW7a7h@vger.kernel.org, AJvYcCXYOCpNoHk3dn6QZLDSD6+PKxjLYJR+1Er+1qHEvWxn7FLi+qb3txcNE6gF6wxnK08hfR0zXFMlXo+M214S@vger.kernel.org
X-Gm-Message-State: AOJu0YxrVYcKimHsjdZ6UqNynhsYaKYSqtUGP6sJ/ikcrwTTgG4XlsqP
	o93q3oEVSFaERBD7HYqisqMborHs+qA20F1xZzRQREXOT1c0bwx6
X-Google-Smtp-Source: AGHT+IFUP4l29W30rYSa5hx0it+Wxex0QXE6gRKgQ7gKfuDDSLUz28qqhUDwMzklTdHixaCYC3DYgA==
X-Received: by 2002:a17:902:f707:b0:201:e7c2:bd03 with SMTP id d9443c01a7336-2076e444167mr269983375ad.60.1726651308711;
        Wed, 18 Sep 2024 02:21:48 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207947365ddsm61611025ad.283.2024.09.18.02.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 02:21:48 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	aneesh.kumar@linux.vnet.ibm.com
Cc: shaggy@austin.ibm.com,
	akpm@osdl.org,
	alexandre.ratchov@bull.net,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ext4: prevent data-race that occur when read/write ext4_group_desc structure members
Date: Wed, 18 Sep 2024 18:21:41 +0900
Message-Id: <20240918092141.213584-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, data-race like [1] occur in fs/ext4/super.c

Since the ext4_group_desc structure does not have a lock to protect its
member variables and there is a possibility that unexpected behavior may
occur in the future if a data-race occurs, I think it would be appropriate
to modify the ext4_group_desc member variables to be read/written atomically.

[1]

==================================================================
BUG: KCSAN: data-race in ext4_free_inodes_count / ext4_free_inodes_set

write to 0xffff88810404300e of 2 bytes by task 6254 on cpu 1:
 ext4_free_inodes_set+0x1f/0x80 fs/ext4/super.c:405
 __ext4_new_inode+0x15ca/0x2200 fs/ext4/ialloc.c:1216
 ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
 vfs_symlink+0xca/0x1d0 fs/namei.c:4615
 do_symlinkat+0xe3/0x340 fs/namei.c:4641
 __do_sys_symlinkat fs/namei.c:4657 [inline]
 __se_sys_symlinkat fs/namei.c:4654 [inline]
 __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4654
 x64_sys_call+0x1dda/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:267
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff88810404300e of 2 bytes by task 6257 on cpu 0:
 ext4_free_inodes_count+0x1c/0x80 fs/ext4/super.c:349
 find_group_other fs/ext4/ialloc.c:594 [inline]
 __ext4_new_inode+0x6ec/0x2200 fs/ext4/ialloc.c:1017
 ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
 vfs_symlink+0xca/0x1d0 fs/namei.c:4615
 do_symlinkat+0xe3/0x340 fs/namei.c:4641
 __do_sys_symlinkat fs/namei.c:4657 [inline]
 __se_sys_symlinkat fs/namei.c:4654 [inline]
 __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4654
 x64_sys_call+0x1dda/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:267
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x185c -> 0x185b

Fixes: 560671a0d3c9 ("ext4: Use high 16 bits of the block group descriptor's free counts fields")
Fixes: 8fadc1432368 ("[PATCH] ext4: move block number hi bits")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/ext4/super.c | 56 ++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..9c918cf2eb7e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -314,113 +314,113 @@ void ext4_superblock_csum_set(struct super_block *sb)
 ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_block_bitmap_lo) |
+	return le32_to_cpu(READ_ONCE(bg->bg_block_bitmap_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_block_bitmap_hi) << 32 : 0);
+		 (ext4_fsblk_t)le32_to_cpu(READ_ONCE(bg->bg_block_bitmap_hi)) << 32 : 0);
 }
 
 ext4_fsblk_t ext4_inode_bitmap(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_inode_bitmap_lo) |
+	return le32_to_cpu(READ_ONCE(bg->bg_inode_bitmap_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_inode_bitmap_hi) << 32 : 0);
+		 (ext4_fsblk_t)le32_to_cpu(READ_ONCE(bg->bg_inode_bitmap_hi)) << 32 : 0);
 }
 
 ext4_fsblk_t ext4_inode_table(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le32_to_cpu(bg->bg_inode_table_lo) |
+	return le32_to_cpu(READ_ONCE(bg->bg_inode_table_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (ext4_fsblk_t)le32_to_cpu(bg->bg_inode_table_hi) << 32 : 0);
+		 (ext4_fsblk_t)le32_to_cpu(READ_ONCE(bg->bg_inode_table_hi)) << 32 : 0);
 }
 
 __u32 ext4_free_group_clusters(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_blocks_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_blocks_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_free_blocks_count_hi) << 16 : 0);
+		 (__u32)le16_to_cpu(READ_ONCE(bg->bg_free_blocks_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_free_inodes_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_inodes_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_free_inodes_count_hi) << 16 : 0);
+		 (__u32)le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_used_dirs_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_used_dirs_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_used_dirs_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_used_dirs_count_hi) << 16 : 0);
+		 (__u32)le16_to_cpu(READ_ONCE(bg->bg_used_dirs_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_itable_unused_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_itable_unused_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_itable_unused_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_itable_unused_hi) << 16 : 0);
+		 (__u32)le16_to_cpu(READ_ONCE(bg->bg_itable_unused_hi)) << 16 : 0);
 }
 
 void ext4_block_bitmap_set(struct super_block *sb,
 			   struct ext4_group_desc *bg, ext4_fsblk_t blk)
 {
-	bg->bg_block_bitmap_lo = cpu_to_le32((u32)blk);
+	WRITE_ONCE(bg->bg_block_bitmap_lo, cpu_to_le32((u32)blk));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_block_bitmap_hi = cpu_to_le32(blk >> 32);
+		WRITE_ONCE(bg->bg_block_bitmap_hi, cpu_to_le32(blk >> 32));
 }
 
 void ext4_inode_bitmap_set(struct super_block *sb,
 			   struct ext4_group_desc *bg, ext4_fsblk_t blk)
 {
-	bg->bg_inode_bitmap_lo  = cpu_to_le32((u32)blk);
+	WRITE_ONCE(bg->bg_inode_bitmap_lo, cpu_to_le32((u32)blk));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_inode_bitmap_hi = cpu_to_le32(blk >> 32);
+		WRITE_ONCE(bg->bg_inode_bitmap_hi, cpu_to_le32(blk >> 32));
 }
 
 void ext4_inode_table_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, ext4_fsblk_t blk)
 {
-	bg->bg_inode_table_lo = cpu_to_le32((u32)blk);
+	WRITE_ONCE(bg->bg_inode_table_lo, cpu_to_le32((u32)blk));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_inode_table_hi = cpu_to_le32(blk >> 32);
+		WRITE_ONCE(bg->bg_inode_table_hi, cpu_to_le32(blk >> 32));
 }
 
 void ext4_free_group_clusters_set(struct super_block *sb,
 				  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_free_blocks_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_free_blocks_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_free_blocks_count_hi = cpu_to_le16(count >> 16);
+		WRITE_ONCE(bg->bg_free_blocks_count_hi, cpu_to_le16(count >> 16));
 }
 
 void ext4_free_inodes_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_free_inodes_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_free_inodes_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_free_inodes_count_hi = cpu_to_le16(count >> 16);
+		WRITE_ONCE(bg->bg_free_inodes_count_hi, cpu_to_le16(count >> 16));
 }
 
 void ext4_used_dirs_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_used_dirs_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_used_dirs_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_used_dirs_count_hi = cpu_to_le16(count >> 16);
+		WRITE_ONCE(bg->bg_used_dirs_count_hi, cpu_to_le16(count >> 16));
 }
 
 void ext4_itable_unused_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_itable_unused_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_itable_unused_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_itable_unused_hi = cpu_to_le16(count >> 16);
+		WRITE_ONCE(bg->bg_itable_unused_hi, cpu_to_le16(count >> 16));
 }
 
 static void __ext4_update_tstamp(__le32 *lo, __u8 *hi, time64_t now)
--

