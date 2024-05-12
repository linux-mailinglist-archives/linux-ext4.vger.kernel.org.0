Return-Path: <linux-ext4+bounces-2467-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5199E8C353B
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2024 08:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF36EB20E34
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2024 06:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FFFC0C;
	Sun, 12 May 2024 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KopbyPZV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8FEF4E2
	for <linux-ext4@vger.kernel.org>; Sun, 12 May 2024 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715496133; cv=none; b=txTRn02ixuaiK2n0t1m/Xa0Y09Ero960JJ2LgmguRybNXRdduoRc2n6NhH/5bET4bQg5QsPjYG5ZnrPgONK4uDWGBdMj3e2epnt76vAZ4BTt77OHmxksxNQSoFqfdNlXIwNiwd0YZboEiqsoMgBWKlJ2rPfFETIqrflwYK1Eyqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715496133; c=relaxed/simple;
	bh=hplt68wxLVPFe/FBNJNv4BcOR82+0WZFYIvXcEjlD9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZDN/SZzr+yjCXWzdhnSqV9/5oq9NEgoJo3II7EeRoZOKJAGLJGaa5HOqEG4PExQg7P5+qRwhumb24nYx+YUzT58S54Yz6qAX3Jr3sEIkVHmZuRRZ0eLg4zUiJ1UrR5eJYTX9vSK7gVAC1msLfndZeBmgKwBfT+qZRFod3NX8jkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KopbyPZV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec41d82b8bso32062805ad.2
        for <linux-ext4@vger.kernel.org>; Sat, 11 May 2024 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715496131; x=1716100931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6kyLjXqotM5y5xq23p634i7QEzpbaRbZQhJ63CdyQA=;
        b=KopbyPZV4gK/TNtVTG4/xkTmGMmmQ2PQ6rUKsZjJ+ASc0OFr8yDUub1VjdKPp6BlLv
         VCERz0Ifpp3J7e3UP8hoDxVMRX/Us0RvIwK/O1kvTFl1wOmLTChfBw015fO7PnFrW4yb
         REWoRI3XytFQrdGAzKerJ9R40BQDjqHxkrQpx8t7GXXOWPOmSXHtNcDT/4zBE35DdilH
         pE3zQf4+IjbCVfCP3BAYIJjjUtjI+7unK0XRCbt891fpDoUuJKnCO7qg5zytcZbVTLD2
         h8MX6659LQCbut4H2okG6FcyzqWBhO/cghu4pEVWoFJmI5T77Gb68VUjf3Y8ecvGEpEH
         5F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715496131; x=1716100931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6kyLjXqotM5y5xq23p634i7QEzpbaRbZQhJ63CdyQA=;
        b=pUx9DEskGtI1ApxhgZRjnStZ7i7HdkrwDCAQ7NvXGlllKEwIkXCTwWULU5BT2DWxxk
         CgHNxBaPutpFfRl21ENzgjSbB9/kO40DNL0fyU25fg4CC6ETy0dcHH9TXpn4AkRPyxaD
         iSGfflaBEMFH2HZMzulBOYmVFXm6HdsK1yMBh19gV1HdXEzCUTuzhIhKXY2IxJJS/JzY
         oXzV0wK+1IunoBaMelCZQHX8dzmQ+cTeECZCWvYvIrdkTEm11ntvDET/8mm6+U4ZwZoR
         TBKBCnCk4oKumtDjrZuYjVj85RURiUbmeKotFGyQZsOVFkPUmSuVvfKJkwPbXS2EMEGC
         Ce5A==
X-Gm-Message-State: AOJu0YzjrBqCOKv1GJoM8YRwkZ0m30n925SjqKqK8DRw3gE/KWFoxkXJ
	pFJzpP9cqBFv65IyzoFcRal3EYIrgr/mtGgqKExJ4W0p80YMcFNe
X-Google-Smtp-Source: AGHT+IEIqgBYkYkFouD3yUErzm5Qg7GSn2XiLVYpb/AD/cnTl7BsFJFAF8vetVXpqgqAFG6LK1Wauw==
X-Received: by 2002:a17:902:cccb:b0:1f0:6960:1911 with SMTP id d9443c01a7336-1f0696019f0mr23329715ad.44.1715496130680;
        Sat, 11 May 2024 23:42:10 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf2f503sm57455215ad.122.2024.05.11.23.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 23:42:10 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH] ext4: fix a data-race around bg_free_inodes_count_lo
Date: Sun, 12 May 2024 14:42:02 +0800
Message-Id: <20240512064203.63067-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As KCSAN reported below, this member could be accessed concurrently
by two different cpus without lock protection.

BUG: KCSAN: data-race in ext4_free_inodes_count / ext4_free_inodes_set

write to 0xffff8881029ee00e of 2 bytes by task 3446 on cpu 0:
 ext4_free_inodes_set+0x1f/0x80 fs/ext4/super.c:405
 ext4_free_inode+0x436/0x810 fs/ext4/ialloc.c:323
 ext4_evict_inode+0xb20/0xdc0 fs/ext4/inode.c:303
 evict+0x1aa/0x410 fs/inode.c:665
 iput_final fs/inode.c:1739 [inline]
 iput+0x42c/0x5c0 fs/inode.c:1765
 do_unlinkat+0x282/0x4c0 fs/namei.c:4409
 __do_sys_unlink fs/namei.c:4450 [inline]
 __se_sys_unlink fs/namei.c:4448 [inline]
 __x64_sys_unlink+0x30/0x40 fs/namei.c:4448
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

read to 0xffff8881029ee00e of 2 bytes by task 4984 on cpu 1:
 ext4_free_inodes_count+0x1c/0x80 fs/ext4/super.c:349
 find_group_other fs/ext4/ialloc.c:594 [inline]
 __ext4_new_inode+0x6eb/0x2270 fs/ext4/ialloc.c:1017
 ext4_symlink+0x242/0x590 fs/ext4/namei.c:3396
 vfs_symlink+0xc2/0x1a0 fs/namei.c:4484
 do_symlinkat+0xe3/0x340 fs/namei.c:4510
 __do_sys_symlinkat fs/namei.c:4526 [inline]
 __se_sys_symlinkat fs/namei.c:4523 [inline]
 __x64_sys_symlinkat+0x62/0x70 fs/namei.c:4523
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

value changed: 0x1855 -> 0x1856

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 4984 Comm: syz-executor.1 Not tainted 6.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 044135796f2b..cf817a6a6e27 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -346,7 +346,7 @@ __u32 ext4_free_group_clusters(struct super_block *sb,
 __u32 ext4_free_inodes_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_inodes_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
 		 (__u32)le16_to_cpu(bg->bg_free_inodes_count_hi) << 16 : 0);
 }
@@ -402,7 +402,7 @@ void ext4_free_group_clusters_set(struct super_block *sb,
 void ext4_free_inodes_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_free_inodes_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_free_inodes_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
 		bg->bg_free_inodes_count_hi = cpu_to_le16(count >> 16);
 }
-- 
2.37.3


