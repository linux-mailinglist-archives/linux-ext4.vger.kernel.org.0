Return-Path: <linux-ext4+bounces-4237-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0B97D734
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2024 17:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56981C20B30
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2024 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE6317B41F;
	Fri, 20 Sep 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS10Vzci"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CA1EA84;
	Fri, 20 Sep 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844447; cv=none; b=ULKoxFGJEVzy91YHIw5WgmuCuGtUL+fH5kW4hz/VKgeb1w8xV/U2VDaUMs1cnqJ8EuMzmaELPPH9FdMP1BkUFUG9Y/znujkz+iWwnQChJLJlNKTjL7c0RHIGOh3C+6gsdrd3sVY+o0mEz1WNVS1E7KbWEkZMqWLC3R0C5FkADW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844447; c=relaxed/simple;
	bh=0ASLXfSVwbMq6iMZVMyo10HW1dHGWEbdZFqwz6cyu9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aPXG0Gs+86BZR81xGZ7ti5YRM+jKLeq9UZTDHYKEDdlcrTb6TICSYc+mLcVKGE7VgsfqTRL8zgq5DH/W8CDPvcDnVtwiL7f0b4WQZOj1+qT1tZuceZFfX/c+wxqQS6w4aqKRjsxAAMQduzn+FfesJlkY8mmW1qMcvjL4a7WcLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS10Vzci; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-205909afad3so26652465ad.2;
        Fri, 20 Sep 2024 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726844445; x=1727449245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TvEkmf5URJ1aeSmER0MrZLqGQs3JKg0CwGkoOctEdws=;
        b=mS10Vzci6mhSep3lai7Ku14nv15J4jRYU6cqDBbRJXX/Y4eV/tjPUbOO2kmIOIXp1l
         CWvotrgDghzy8ucqlt61/X+GbAt2NKDecuRq/8JExXthyMupLC4qEDj9wtrsPjKMN0Du
         GjH0lSQOxqzlv+Ofp/5+aYMtiLlbLm1lyUYaaNII61gDdzxOVKyAGeUQPCECC9h8ScaX
         6vQBK9LYEKtWP3BDkiQjvhBhTd/rO8hHpiu/cjL44EW6w21vGKuqNGmtxcMB9vBWmUR8
         RKQpcxzYWT0ZfDfAjonz6X6MvtM0OO3++xW6a+NFAGyLFtAOYI5PvsiY4uLvbNQNGZJO
         AB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726844445; x=1727449245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvEkmf5URJ1aeSmER0MrZLqGQs3JKg0CwGkoOctEdws=;
        b=gJGTEfUmToNpv7GQRrKyMy5m9cg73k6p+OzcyK0th/+EdWm1F6+3rJw6S8xRbIGFXw
         Ql++ZjwORHIqARzbyiKtRG9CwTkxtA0f6oLnVQ4ZXxK+/lz/+rum2f4+Bh9X+/JuUxEk
         LjolKFnI7s0v+afg+UD55o1+HUSszB4JkZOdD3BGQW9y3ETtIX6KwRD6dsJibltcB1PH
         JXZNhhF4kMTAss8W+clGz3rBuEOQKzdI2Ffx00iH2cZ2CCBDSdsz2IkTdCN3hQqKLILa
         LabqIIncEva73JLsX6U5Xz7uJnDgQxEg7Nl0F1hNfy8NKzNO1y+3ItCoUjY5c/lh7y7J
         Zo0g==
X-Forwarded-Encrypted: i=1; AJvYcCUguK2+Va6VWX6LnJsz5TGdTfX1X40nDKAu15DnldzQ8dL9YBhDJzhlxLg7eWGrTcCgUtQkap/K+/5+@vger.kernel.org, AJvYcCXSwB09AuUT/p8X8q2TyKZXeEMpSzXpyabaefoBWQVxHmR7BXOGAmdx+c98ADIZsP1NJ15Yw7YlCQRMZKYG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf2luJqFv6QWEvwWJY4byRlCeadKSPbsobaBItqGbPH77QbN99
	NVyIyD8BtJGsw+HiC7nQPZF0hpBNBZJjzN9YCY7aPfec/MaPh+5hsATX+tAR
X-Google-Smtp-Source: AGHT+IF/iz6QKaBigAHbbFuRIWDoJr/3bOq3rNTvobPeENpmYtCeopnab2S0vL0c1j4Md5OnTfBVEA==
X-Received: by 2002:a17:902:d4ce:b0:206:b399:2f21 with SMTP id d9443c01a7336-208d840808dmr42159785ad.43.1726844423660;
        Fri, 20 Sep 2024 08:00:23 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d15fesm96196865ad.162.2024.09.20.08.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:00:23 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: akpm@osdl.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] ext4: prevent data-race that occur when read/write ext4_group_desc structure members
Date: Sat, 21 Sep 2024 00:00:13 +0900
Message-Id: <20240920150013.2447-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, data-race like [1] occur in fs/ext4/ialloc.c

find_group_other() and find_group_orlov() read multiple ext4_groups but
do not protect them with locks, which causes data-race. I think it would
be appropriate to add ext4_lock_group() at an appropriate location to solve
this.

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

Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/ext4/ialloc.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 9dfd768ed9f8..5cae247ff21f 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -500,11 +500,14 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 		for (i = 0; i < flex_size; i++) {
 			if (grp+i >= real_ngroups)
 				break;
+			ext4_lock_group(sb, grp+i);
 			desc = ext4_get_group_desc(sb, grp+i, NULL);
 			if (desc && ext4_free_inodes_count(sb, desc)) {
 				*group = grp+i;
+				ext4_unlock_group(sb, grp+i);
 				return 0;
 			}
+			ext4_unlock_group(sb, grp+i);
 		}
 		goto fallback;
 	}
@@ -544,14 +547,17 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 	parent_group = EXT4_I(parent)->i_block_group;
 	for (i = 0; i < ngroups; i++) {
 		grp = (parent_group + i) % ngroups;
+		ext4_lock_group(sb, grp);
 		desc = ext4_get_group_desc(sb, grp, NULL);
 		if (desc) {
 			grp_free = ext4_free_inodes_count(sb, desc);
 			if (grp_free && grp_free >= avefreei) {
 				*group = grp;
+				ext4_unlock_group(sb, grp);
 				return 0;
 			}
 		}
+		ext4_unlock_group(sb, grp);
 	}
 
 	if (avefreei) {
@@ -590,11 +596,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 		if (last > ngroups)
 			last = ngroups;
 		for  (i = parent_group; i < last; i++) {
+			ext4_lock_group(sb, i);
 			desc = ext4_get_group_desc(sb, i, NULL);
 			if (desc && ext4_free_inodes_count(sb, desc)) {
 				*group = i;
+				ext4_unlock_group(sb, i);
 				return 0;
 			}
+			ext4_unlock_group(sb, i);
 		}
 		if (!retry && EXT4_I(parent)->i_last_alloc_group != ~0) {
 			retry = 1;
@@ -616,10 +625,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 	 * Try to place the inode in its parent directory
 	 */
 	*group = parent_group;
+	ext4_lock_group(sb, *group);
 	desc = ext4_get_group_desc(sb, *group, NULL);
 	if (desc && ext4_free_inodes_count(sb, desc) &&
-	    ext4_free_group_clusters(sb, desc))
+	    ext4_free_group_clusters(sb, desc)) {
+		ext4_unlock_group(sb, *group);
 		return 0;
+	}
+	ext4_unlock_group(sb, *group);
 
 	/*
 	 * We're going to place this inode in a different blockgroup from its
@@ -640,10 +653,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 		*group += i;
 		if (*group >= ngroups)
 			*group -= ngroups;
+		ext4_lock_group(sb, *group);
 		desc = ext4_get_group_desc(sb, *group, NULL);
 		if (desc && ext4_free_inodes_count(sb, desc) &&
-		    ext4_free_group_clusters(sb, desc))
+		    ext4_free_group_clusters(sb, desc)) {
+			ext4_unlock_group(sb, *group);
 			return 0;
+		}
+		ext4_unlock_group(sb, *group);
 	}
 
 	/*
@@ -654,9 +671,13 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 	for (i = 0; i < ngroups; i++) {
 		if (++*group >= ngroups)
 			*group = 0;
+		ext4_lock_group(sb, *group);
 		desc = ext4_get_group_desc(sb, *group, NULL);
-		if (desc && ext4_free_inodes_count(sb, desc))
+		if (desc && ext4_free_inodes_count(sb, desc)) {
+			ext4_unlock_group(sb, *group);
 			return 0;
+		}
+		ext4_unlock_group(sb, *group);
 	}
 
 	return -1;
--

