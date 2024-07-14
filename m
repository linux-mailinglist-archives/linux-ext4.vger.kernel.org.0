Return-Path: <linux-ext4+bounces-3245-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF6930855
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA51F21901
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B8DB64E;
	Sun, 14 Jul 2024 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DibKUocx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B79A92F;
	Sun, 14 Jul 2024 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720924179; cv=none; b=uyZnqb1CLTk6LmwONDW6XwpLXXkh/CJCIhV6SBN+iQCdchQ1PxE2eAvbRvPvlqERPS8bZTWAd2lIIgAqczqDS1Whg5yaGM5E5l4voUrJZs0/Eiji9L84V3KktQWm7sOLVbv54+lJuTpjgmGDre0j4MSfdDfAwNd/ez0lOxR4IAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720924179; c=relaxed/simple;
	bh=gvaCtxw0JmqX0qKNFkwrK622sEzBsNuUqWwdfi1veZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HO0DL7ly8my0VL9mtNcxnw5Gq6iv8wtyWQ4cEY3yzZC6TvvQr0pgPQwgzwceG/lU73dbxRZt3rC+XcLzu8zPUBfIWYBFzKYjqKjJWYJc1OV5p9pIqjT5dygma+cAyjD7/m6ffu8Jx/NtW0EVHRdD+q38ya8yBoQ0k2dq3Fm27K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DibKUocx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so21336705e9.1;
        Sat, 13 Jul 2024 19:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720924176; x=1721528976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7uTtxkGrUED0qsLRRVKEM+k/1Ov/NZS6SczaERixb68=;
        b=DibKUocxo7UdohX02RbknBx06eH0pyD/2/5mUNPnFtd0zNrl9CKFE6YfFBxD7bj5mK
         V1wMH14gZEOU2J4CAN4Mu/A/y6UMxU+cX0whwp5vVnV9o+huppDUTZyOheFDpuFb8Mtj
         R0jn23EGrTDFtXOPyBqAHSW8A1iceceot6oH9HPCNyzVGXVoSW1qR+t/xcrOEcAtAfWC
         zOorDI8yZQyOgm5n2TrpxRZslMEKSyRXOOzs8Vyf14doH74Z+MjdMsbTaFgk51qWqf5c
         5PYv8ndimPHTiUcWZ3Xhm+wHETcNsLotGBWUef0RmcuVZoBWRZzevrNBjHAcsEP3TFOc
         mQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720924176; x=1721528976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uTtxkGrUED0qsLRRVKEM+k/1Ov/NZS6SczaERixb68=;
        b=aktxBxzsx0X3ilArgbvsmeBed8jWfoDk9cF8GLEYuph0iBR1XF9OcLo8KFYsAO+qja
         tus1FlfB85X1SBzp1x/AZv+mpnNpzfjUMfiQYe2+X910DzhYPDAOEpl136Nk9ISSdsgO
         adYINAhCbtFEohcmdj+EN46zK/u9HagrUT8MYkwhZPbcxrTxDUzvQjVAqlELXJ5mvjvT
         9bkWHfj1uAVV1qnjBKc9VZ7psh+K+hey0kPCP1us1Tg8Oz6J0nZUx5GbrLSvQ1dcrmdk
         LwzTmKrb+AJ8pGAA+29s563TtTdmHMQ/20yrbCfR2H6sSouufTReZu6iCnz4PdmUMAFX
         5HZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGIDOggGE5caxXlJjN+IrdQ/JHqYYDsqZLgq+xRMcaNrI3FvIGKE5IIADbK/JRD/Ri1wX+v2qYIMxYujRt9Rog66HNLqYUfFJkkf8MMlA+m1zoLbPgGkrCp7u1b6TpTzi2Cg==
X-Gm-Message-State: AOJu0Yynvt298E0hg3iGvfRI+jtpqvcgDo7/DW3vzw4T0n22Rfx69goV
	lLuLRn/LzPGms+DYTsNFSHrUPTArwSq8fusmkAzvF4/C+xeAFdJnuJROxQVoFK4=
X-Google-Smtp-Source: AGHT+IHl8Y8wLqDxJzkDVIy/A1pwLR4+D5zIzHFndDxbJqI0GiE3G+KkSNQb9LjffrW2mOyVJKvV1A==
X-Received: by 2002:a05:600c:524f:b0:427:9dad:8063 with SMTP id 5b1f17b1804b1-4279dad8478mr44072335e9.12.1720924175722;
        Sat, 13 Jul 2024 19:29:35 -0700 (PDT)
Received: from localhost.localdomain ([156.197.1.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d7955sm72759145e9.47.2024.07.13.19.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 19:29:35 -0700 (PDT)
From: botta633 <bottaawesome633@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-ext4@vger.kernel.org,
	syzkaller@googlegroups.com,
	Ahmed Ehab <bottaawesome633@gmail.com>,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] ext4: Testing lock class and subclass got the same name pointer
Date: Sun, 14 Jul 2024 08:26:40 +0300
Message-ID: <20240714052640.115476-1-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Ehab <bottaawesome633@gmail.com>

Checking if the lockdep_map->name will change when setting the subclass.
It shouldn't change so that the lock class and subclass will have the same name


Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
Fixes: fd5e3f5fe27
Cc: <stable@vger.kernel.org>
Signed-off-by: botta633 <bottaawesome633@gmail.com>
---
 lib/locking-selftest.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6f6a5fc85b42..1d7885205f36 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2710,12 +2710,24 @@ static void local_lock_3B(void)
 
 }
 
+static void class_subclass_X1_name(void)
+{
+	const char *name_before_subclass = rwsem_X1.dep_map.name;
+	const char *name_after_subclass;
+
+	WARN_ON(!rwsem_X1.dep_map.name);
+	lockdep_set_subclass(&rwsem_X1, 1);
+	WARN_ON(name_before_subclass != name_after_subclass);
+}
+
 static void local_lock_tests(void)
 {
 	printk("  --------------------------------------------------------------------------\n");
 	printk("  | local_lock tests |\n");
 	printk("  ---------------------\n");
 
+	init_class_X(&lock_X1, &rwlock_X1, &mutex_X1, &rwsem_X1);
+
 	print_testname("local_lock inversion  2");
 	dotest(local_lock_2, SUCCESS, LOCKTYPE_LL);
 	pr_cont("\n");
@@ -2727,6 +2739,10 @@ static void local_lock_tests(void)
 	print_testname("local_lock inversion 3B");
 	dotest(local_lock_3B, FAILURE, LOCKTYPE_LL);
 	pr_cont("\n");
+
+	print_testname("Class and subclass");
+	dotest(class_subclass_X1_name, SUCCESS, LOCKTYPE_RWSEM);
+	pr_cont("\n");
 }
 
 static void hardirq_deadlock_softirq_not_deadlock(void)
-- 
2.45.2


