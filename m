Return-Path: <linux-ext4+bounces-4469-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3FF98EFC4
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2024 14:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2811A1F21BD2
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2024 12:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBE1199225;
	Thu,  3 Oct 2024 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxGpOvbU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825F15539D;
	Thu,  3 Oct 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960095; cv=none; b=mhWnlkccL+mcVZ22PDe3KVIN4MGivowdy3SCKIDq9iPSGZGQx1x3JIHqTF7WsodSmIsyWGNB6V9espboliqZE8ZOqYBdmdt8YO7BdjDyfagk2lm5JHV6Edc2XVwnN7uasrpzEPo1Srj7Ogib8mBzqO69agmqzpYErVGz3TUn6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960095; c=relaxed/simple;
	bh=KljAQHtSfrZelRNu/DeQx5LVY5cSuSW2WcANOdnrzUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCtKyi9Qfsy/Ig5seDd8pWEtROtLbCWZydj9Hz2E9tDDNyyQ0k7WChyZ7WSJeluX4cfstjHbBo0U3JCn2g5LXBdmA94awIAMjcaxeolZw7tJ8EqYMPiDf6fnkwsKrtvz5opsidDPUgCFrJSsbjkVhz5aFv5DTTxumbiHrESWzeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxGpOvbU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b0b5cdb57so14280245ad.1;
        Thu, 03 Oct 2024 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727960094; x=1728564894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsC4l5sUrgtE5C3AhIFngE9xrlbDasfd0CJezQP/zPM=;
        b=hxGpOvbUQf/tayGvBmdEgNENJXZMfND0qFUTb9WtKeIULuvfy9EzB/Bn+PCHeT6BIW
         AujUhzskKNHJBVHpRXq5dDDiUOCCL8O/tHyxwBLeh+3moqOoVghUik2jiTaF2YPTSaRw
         23AFP0WkJAlADVM18co0v5sGJVdhoAq2Phbo2OKruE53h3ilCg+oQTE7L1BiKu+7gaqN
         uHWCe/z0Sw73x6OP+I3FTGWgCQgvUkT+6bKxbyryDr0KiWLma7jaLO4h8R30zSDCPyjN
         c8ygi2i1hOadgHey6qVXvgRn77q7dXIPgErQ0ODRYYMjmFRO72e6fRyBaoPnedoXE9Eq
         66VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960094; x=1728564894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsC4l5sUrgtE5C3AhIFngE9xrlbDasfd0CJezQP/zPM=;
        b=NdoSmOUSELL/F5FAIOIQ7rohNdEivx+fqeypkSZsWRNR1N3hQ3w10yonRZIwFa9La3
         gkAp305+sMWe5omZBshBD0LTAvvJ/NkvBUmw5J/Tu/lJTSrmzbUztiV2Vb9tZ6KqjE2E
         wMk3zgOl2E2/Q3ArX8D/lC226aJY4L+3ofcL0TKWar/7BMC1mBBJeqfNdT3fEyNYFXE7
         ODTj21S8BZHO4ejLC11O7FhATDXUlgYPmHn6kajmb6zzh1QTTpy01ci6xgwKh/pEmKgs
         9k8BXpayTpT4sL8fbHetd2CeYV7O9Cm/p0uPylYeUq8c6YUmWzVNJRyM0/Kuq8jn+8ne
         QLtA==
X-Forwarded-Encrypted: i=1; AJvYcCUQCyODv/1x/yx4V2zRTZs+Uv6umultSR5KToecaEYiCo5eySQEQFd34XKeH1Qj5uhaY2DmMceQhLhJZuZ6@vger.kernel.org, AJvYcCVlxyHAewJ6XiuvgFNtOWSu7o+jleaYjbRUltFPpzC+zfczfkbj8ik4gvKrZfmnP4rGwWqio4304uHG@vger.kernel.org, AJvYcCXD0o8uGnHd8iZlLkbEhWLWxmqN5sw1XOlxXVftuE7myxy62e6HUzKCh0debk1jPlVrPDJ3sBbY@vger.kernel.org
X-Gm-Message-State: AOJu0YyWBNhuFXXU4fxTCY3nWJDkPRL4o3tQ/oa0mcLOUJ1KWexwtj2z
	aHIbrfMj8bdX5NedOPyawHGGDytJC+VDqVDNu4EoOt+IV41aJC//
X-Google-Smtp-Source: AGHT+IEVVMmS1YZ2exZ1znFQnn9/34PbEJhr5acgKukRACDsDk/3Nx413ukvQ2Vv4QCXPWtKG24YCA==
X-Received: by 2002:a17:903:41ce:b0:206:9c9b:61bb with SMTP id d9443c01a7336-20be187334amr45591905ad.6.1727960093539;
        Thu, 03 Oct 2024 05:54:53 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefad240sm8324875ad.206.2024.10.03.05.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 05:54:53 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: akpm@osdl.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v3] ext4: prevent data-race that occur when read/write ext4_group_desc structure members
Date: Thu,  3 Oct 2024 21:53:37 +0900
Message-Id: <20241003125337.47283-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, data-race like [1] occur in fs/ext4/ialloc.c

find_group_other() and find_group_orlov() read *_lo, *_hi with 
ext4_free_inodes_count without additional locking. This can cause data-race,
but since the lock is held for most writes and free inodes value is generally
not a problem even if it is incorrect, it is more appropriate to use 
READ_ONCE()/WRITE_ONCE() than to add locking.

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

Cc: <stable@vger.kernel.org>
Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/ext4/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16a4ce704460..8337c4999f90 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -346,9 +346,9 @@ __u32 ext4_free_group_clusters(struct super_block *sb,
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
@@ -402,9 +402,9 @@ void ext4_free_group_clusters_set(struct super_block *sb,
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
--

