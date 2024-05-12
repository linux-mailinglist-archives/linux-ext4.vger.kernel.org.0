Return-Path: <linux-ext4+bounces-2468-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544BF8C353C
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2024 08:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7852281E87
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2024 06:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC4510953;
	Sun, 12 May 2024 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUZRqQcO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2743101EC
	for <linux-ext4@vger.kernel.org>; Sun, 12 May 2024 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715496136; cv=none; b=QtNlg0U8v9RsTzZO8qt5MjEeS+A/2Bpv1nouPjtGHRCsUV+H3r95LnTSjqvSzC/Su3KBZA1GPl4GIk6Rq0/d5R0M0MPjdB/C9y0//7SGVG/m7LbK9VdTS3TJ8MIAgeY9Bn/DHqVtUPaNXDJFVChS0Mzfae85vyQcS+3EwZpuezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715496136; c=relaxed/simple;
	bh=0hYGfKBm+iJvk1nLuxfaTkXocv8B2A55jsAi8tnWmBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sdLwM9hriCT8Ja8lRbSQ4ULctxuYs6f9biHeVuYgZYK4FnjOSOQFfCrLABiuXfuzp9pqVW1Ryut/nJDpKZQbsZTNg/BXSScO754bJELN7kLgcc3RAoywKwQsidPrOAMjTJzrCYOdHtWvFQbIC1v/L7YOXyPK4IMgRcKRiQ1YCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUZRqQcO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ecddf96313so29471605ad.2
        for <linux-ext4@vger.kernel.org>; Sat, 11 May 2024 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715496134; x=1716100934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsQIFLeVQZTy3Woga2mwbwIoniSXemPRrVILULMGjxI=;
        b=iUZRqQcOTDtK7x0IuU2rbIR8ftlpefXrATrU0wr14SijM8gTUWaLz6giUoHolBm6fJ
         xRSGOAd41f5mZ2cMpFCo2qY1PB/ngsmHrxE16esj5s2peAcc2ji6JAXmM/9jYcTAY4oG
         HG0q8zQDTVyI3huGVRlN5Wl1sBO/O6npFA6HiUcPOu9FkEb8Ei7pFn6CaDE4As+iX/H6
         24np4fvWyRd0N38X+TwgpAPx9mEFwftvFprBTVfM6/RJ9V6UIYH+60y9sc6561Rgb0Rb
         TQlYrLTn1LXmcElB9ZJUck0awOz83qXcX0OrFi1L7s3j75oqBrxs6tfOCco7pB3L9b5J
         t8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715496134; x=1716100934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsQIFLeVQZTy3Woga2mwbwIoniSXemPRrVILULMGjxI=;
        b=ibU79uum5bpuHSKGZMSXTs7x9CnWmaPkutOL2j81x2nrNLBIsoinw/jkUP4Y6+v+Yf
         oddWifJzsyqvISvdaUqn+seJSHSojmIujrVNxp/UOtplB1q5LIWhgGpQ2DnOWCAR2EII
         kS6ZiDtdsAKRn58EQm7Yuc0gUfbmrWK2SqsCeAshBnIXk4OYm7Ok48et2v/jlwEPvnR2
         Kfv6zZuNJJbPflTM7ff8Ap7snJMqKYJLBvUIhoaTPV7Vdr3vlHVT9UMrBAKcUoodm9ry
         s0fEYzTiqxVzp1Y6WDpzBjojnPedjXBTjl/JQgDWTaGMergB79eWvn1GQ7Dp8IRrvQtq
         dc1g==
X-Gm-Message-State: AOJu0YwaH9SPcVuVOlnnE+bg8z5CcdbmOnMTqEpeAM7PUUcPPAEQeXNF
	MXCJUkDOp3g+t6zokLkDZg0PjVlecT73V3Ml1mhMO00bMLnRrqA7
X-Google-Smtp-Source: AGHT+IHPvUb280YylH1TXxp4CZGMTV1h+cOdhticvxtBypR21ig/Hfaxr1bgMjJOZ7mdp9PxfkYTdg==
X-Received: by 2002:a17:903:2281:b0:1eb:2f02:cd0d with SMTP id d9443c01a7336-1ef433cef35mr124177535ad.0.1715496133973;
        Sat, 11 May 2024 23:42:13 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf2f503sm57455215ad.122.2024.05.11.23.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 23:42:13 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH] ext4: fix a data-race around bg_free_blocks_count_lo
Date: Sun, 12 May 2024 14:42:03 +0800
Message-Id: <20240512064203.63067-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240512064203.63067-1-kerneljasonxing@gmail.com>
References: <20240512064203.63067-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

KCSAN reported a data-race issue due to two different cpus accessing
this member.

BUG: KCSAN: data-race in ext4_free_inodes_count / ext4_free_inodes_set

write to 0xffff888104a9e00e of 2 bytes by task 4435 on cpu 0:
 ext4_free_inodes_set+0x1f/0x80 fs/ext4/super.c:397
 __ext4_new_inode+0x15c8/0x2290 fs/ext4/ialloc.c:1216
 ext4_symlink+0x242/0x580 fs/ext4/namei.c:3393
 vfs_symlink+0xc2/0x1a0 fs/namei.c:4475
 do_symlinkat+0xe3/0x320 fs/namei.c:4501
 __do_sys_symlinkat fs/namei.c:4517 [inline]
 __se_sys_symlinkat fs/namei.c:4514 [inline]
 __x64_sys_symlinkat+0x62/0x70 fs/namei.c:4514
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888104a9e00e of 2 bytes by task 4440 on cpu 1:
 ext4_free_inodes_count+0x1c/0x80 fs/ext4/super.c:341
 __ext4_new_inode+0xb71/0x2290 fs/ext4/ialloc.c:1040
 ext4_symlink+0x242/0x580 fs/ext4/namei.c:3393
 vfs_symlink+0xc2/0x1a0 fs/namei.c:4475
 do_symlinkat+0xe3/0x320 fs/namei.c:4501
 __do_sys_symlinkat fs/namei.c:4517 [inline]
 __se_sys_symlinkat fs/namei.c:4514 [inline]
 __x64_sys_symlinkat+0x62/0x70 fs/namei.c:4514
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x185c -> 0x185b

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cf817a6a6e27..6db71cc1e5cd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -338,7 +338,7 @@ ext4_fsblk_t ext4_inode_table(struct super_block *sb,
 __u32 ext4_free_group_clusters(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_blocks_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_blocks_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
 		 (__u32)le16_to_cpu(bg->bg_free_blocks_count_hi) << 16 : 0);
 }
@@ -394,7 +394,7 @@ void ext4_inode_table_set(struct super_block *sb,
 void ext4_free_group_clusters_set(struct super_block *sb,
 				  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_free_blocks_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_free_blocks_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
 		bg->bg_free_blocks_count_hi = cpu_to_le16(count >> 16);
 }
-- 
2.37.3


