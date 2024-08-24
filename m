Return-Path: <linux-ext4+bounces-3885-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF3895DFC4
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Aug 2024 21:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0831C20AA3
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Aug 2024 19:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCE12C49B;
	Sat, 24 Aug 2024 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2ZeEYbP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EAC61FFC;
	Sat, 24 Aug 2024 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526775; cv=none; b=N2t4j0n8H7mxtSIv/PazsbqhRcFLwIw6SK93u6bieXCe1bQpxW2Hdudht7QZQwqVP6Zl/fZ9kwRvB1SkSU788oLoV5yaDrHDQINXc7fQCuStY1yKU7UrGsU96w4oLxIVgTAlwR+MBfdSncymU7Y6EvXhTLj1FtCPHCfZM33We3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526775; c=relaxed/simple;
	bh=dRsDBERBKXGQmlNxsmOYsnycmpuJFUc5IIm+FZN1U5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeTmHHawug+j57fGQhfjdRdls5HRxQh2LotXFD2KfnKNY4Cai6AA377wVevE2WyjSMZD37bfg9+mgfBQOQv6L3HN6PMc7IjCQwdtTecMZiROCyeuguCrEN7eKC6UE8iFTU3R1l1STlA6N8gFU2mRhLdXsAHaKlL6zJ6Vjyv4Bgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2ZeEYbP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3718cd91185so1552600f8f.2;
        Sat, 24 Aug 2024 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724526771; x=1725131571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxw92cxeIEiHhs9EMgxgq3pO39LFJ0Vnsb2d9XSPFpU=;
        b=U2ZeEYbP5QsmUn61qTqEkBRfGcvO9rITHaVaoP+oQ3JBWfzc6XCDEnxz4FPgX9QGiQ
         uWbxRUbsX3CdNaOSBKxVaGSo3T+Oc3Z/SLeZJx5sC6MAzaFQO4fbPuEmJFQhrniuGtm+
         aW/WiBg4ws/gX8RJhTxx4q8GOALjX+XHOrO+ILCj7C9wcUBM4T3a6giJbDHvhn7Zo7Me
         P5rr13LhVN2Kwx5KjuV/jzvDV+1AxsMRvbbG84kuAd7owdh87fSP6N+fGHKMVmf3btuZ
         /vffp0NlIf5RTtnW81gHrA2rVzVvZNFuv5ZzgozTaWfQaFEkWv6b3kYcBJlmzuhc8xaO
         wHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724526771; x=1725131571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxw92cxeIEiHhs9EMgxgq3pO39LFJ0Vnsb2d9XSPFpU=;
        b=w0A20t6dj7qx4c+wWm1/5ucA5iD6hI2csuLoLGemseYJgNm4d0n6RRqhdUO0jCgjVG
         EUnK8XjhzCAz5TxJHW50m8qsK1g/d8F8TzYuX6s47Keg62NQWw1p3FOvgLsSTb7D+DV3
         a/FKAPpcR+oMNlMqtjUMte74x5ZZTivY3fSx98ORdUECZeWHNFS16q4S5Bk/4s1BEnyX
         O+xSODTGucnJnfi3itI0bHUt6RlFUeUAR/xaAoVfcoU94ci/w9OROHr7yqpVPEUJVsiU
         4uUN0nlG4oLfYYpH9eXO4LSv6VFI98Sz3rJ3hsv0hz0F+LBrUk3BbRyxV8qbMSNf8qrT
         1uHg==
X-Forwarded-Encrypted: i=1; AJvYcCXF2J4j9cR2FufAKBrGjE1doPrLF7ymG1/zAzkCi7o9nAOuRgOy4OKQPM1LFVjV/FQXJ5HbAIWB7KKW@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQeE75X8plW4rydQilWGCl59omfLmLt0ruKdMzedaogdi/SkA
	vEmfE/sjbsjnwNV8l1ySmLACTpg3E+08nKZqilFN7rK6ndsUypjpqsBKN41fSHQ=
X-Google-Smtp-Source: AGHT+IF9Li3MJwjnTCQZvRS3VVn7nuqBi4T5p7Mo+MHjDsuw5dg8olBZhngWv1qKDBfikGef2aL15A==
X-Received: by 2002:a5d:5273:0:b0:371:a70d:107e with SMTP id ffacd0b85a97d-37311843365mr3676162f8f.6.1724526770689;
        Sat, 24 Aug 2024 12:12:50 -0700 (PDT)
Received: from localhost.localdomain ([156.197.22.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c520sm7109793f8f.39.2024.08.24.12.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 12:12:50 -0700 (PDT)
From: Ahmed Ehab <bottaawesome633@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-ext4@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: [PATCH v6 2/2] locking/lockdep: Test no new string literal is created in lockdep_set_subclass()
Date: Sun, 25 Aug 2024 01:10:31 +0300
Message-ID: <20240824221031.7751-2-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240824221031.7751-1-bottaawesome633@gmail.com>
References: <20240824221031.7751-1-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to ensure that no new name string literal will be
created in lockdep_set_subclass(), otherwise a warning will be triggered
in look_up_lock_class(). Add this to catch the problem in the future. 

Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
---
v5->v6:
- Changed the subject and changelog to be in imperative format

 lib/locking-selftest.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6f6a5fc85b42..2b4650bdf833 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2710,6 +2710,32 @@ static void local_lock_3B(void)
 
 }
 
+static void lock_class_subclass_X1(void)
+{
+	const char *name_before_setting_subclass = rwsem_X1.dep_map.name;
+	const char *name_after_setting_subclass;
+
+	lockdep_set_subclass(&rwsem_X1, 1);
+	name_after_setting_subclass = rwsem_X1.dep_map.name;
+	DEBUG_LOCKS_WARN_ON(name_before_setting_subclass != name_after_setting_subclass);
+}
+
+/*
+ * after setting the subclass the lockdep_map.name changes
+ * if we initialize a new string literal for the subclass
+ * we will have a new name pointer
+ */
+static void class_subclass_X1_name_test(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | class and subclass name test|\n");
+	printk("  ---------------------\n");
+
+	print_testname("lock class and subclass same name");
+	dotest(lock_class_subclass_X1, SUCCESS, LOCKTYPE_RWSEM);
+	pr_cont("\n");
+}
+
 static void local_lock_tests(void)
 {
 	printk("  --------------------------------------------------------------------------\n");
@@ -2920,6 +2946,8 @@ void locking_selftest(void)
 	dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE, LOCKTYPE_SPECIAL);
 	pr_cont("\n");
 
+	class_subclass_X1_name_test();
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
-- 
2.45.2


