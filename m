Return-Path: <linux-ext4+bounces-4052-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3001096CA0C
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 00:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C0D0B2506B
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 22:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C71714A9;
	Wed,  4 Sep 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjQENuLy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91C535D4;
	Wed,  4 Sep 2024 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725487386; cv=none; b=GcFsBRkcKvXG2lg8V6iXEZuAUwYaY2HauzCQprKdpWjVBn0qKI2B3oNahtEMBQxn1NGu2qfNKwUBGRvzDsnxgDmGyQscXjxM9FUgOO/2uwjQrksUuia1aBrHht9MsewxpsydKmr0ydNuklzXw1ONZzqTIle+ZXdBAQe5WD/nv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725487386; c=relaxed/simple;
	bh=K8MJs+EJIwG7sJB2ifj+Y0bf3kKsIwOqEP422d4TVWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYdEdUN5BkB3L5haAf8RJHsSf7r+MXyqb8JuU4JypCCqzHc6yxBjIjqTy5W+49MUuIJg+zjYiRo8CbC/4EGDWwJDht/tjFoanwnh6Uc7Zw7E7IDLINAKUm026l+S3S+5zASFd0EaEVldjj2/p5IvvNbyXKZjmaSQisQ3G6EL+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjQENuLy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bbe809b06so116775e9.1;
        Wed, 04 Sep 2024 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725487382; x=1726092182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh8A8xEp/g3VK70eE6Ph8a8PDw8n7olrF1x7DsPqcC4=;
        b=fjQENuLyApEZ1dLBJmW37SstY/JOc95cZNSgg3fviU9XL0nCOhWV4TBsNjFDdL3YId
         ZfAD/Y57i5otM1DtrBmhQicf7hQByzlMG8gN4hs022XcKDUPAXetLMOBP5apAJ5nAQdP
         fM4HRKUdAwWdF1bgywt6Qukf5lBc8xHYlykTAlaM/A+lKWUsoelY+jYTShEBK869u3Qs
         nE8AWS/L1AIcPjtKzGkLiS1S0HDYbUVkmfPVCXhfmyDlj8PnDpVP+todz4Mr+h2I2qp4
         5z1vQTwqS0fcCAWUwyMnzr1UQBibP5E8y7mLBSBRqPvOHBbhiRm8D8SjYHfFwtI1ES8a
         nWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725487382; x=1726092182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gh8A8xEp/g3VK70eE6Ph8a8PDw8n7olrF1x7DsPqcC4=;
        b=NMVtIa2uPYBcDACFIapPEp/jrBTosJf5VFPKYDB7e1jcBgJs412NDQK+086ZBmKNnu
         MwbApoq5x8miX3Mvy9AOrz37DwKQmcd0yXp0Uofn03vQsml0T0WxkIBMF0ZecnGKI73I
         /oQBrwUdoacHEDAWidwrrrMGthnCfgLrCXNEFw3H68qXKLt3+rRFieCjLz91e0m27R9M
         Q9BoSjbQEMJ8iuhd0tfm0DdgQMkbf2Opqaa6J9qho+FLcPh9Yr8GFYnTLKSTJ5XBKIJt
         NhQ/a5vzGOAkkWnz3/dcorNi33SCk7+K6iAWWjS71keWDEwYUVVWw+oO+FxYKKqWCcqK
         vDJA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Pxm3QyR2VAZA2GNwQ+0I10kI7AHFNDYeHVpoQTTSGZatZ5h/SwnQmiyOBusCDMFraZwJzMqvbA04@vger.kernel.org
X-Gm-Message-State: AOJu0YyaLg5BPzgd7ia0z4A4v3qqlGm9zPBKCa9nLnniGTwyTCDZv6tC
	hTg6gn+BA3mZ+fBMxVJI9nlpatXUmuyG566HKNTd5paQDqsrbEOLHucYKLtY0hM=
X-Google-Smtp-Source: AGHT+IFnrQndGf4+Gbd+MDlVfwPdj5W4CwU3o8FFEgXSTpDH013+ykqIiRPCkitX9bUrsa8u3X5K3Q==
X-Received: by 2002:a05:600c:3ba7:b0:425:7c5f:1bac with SMTP id 5b1f17b1804b1-42bb0306f94mr177937675e9.21.1725487381964;
        Wed, 04 Sep 2024 15:03:01 -0700 (PDT)
Received: from localhost.localdomain ([156.197.26.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb27fsm214861925e9.10.2024.09.04.15.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 15:03:01 -0700 (PDT)
From: Ahmed Ehab <bottaawesome633@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-ext4@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: [PATCH v7 2/2] locking/lockdep: Test no new string literal is created in lockdep_set_subclass()
Date: Thu,  5 Sep 2024 04:00:42 +0300
Message-ID: <20240905010042.355977-1-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.46.0
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
 lib/locking-selftest.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6f6a5fc85b42..0783ee97c971 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2710,6 +2710,44 @@ static void local_lock_3B(void)
 
 }
 
+#if CONFIG_DEBUG_LOCK_ALLOC
+static inline const char* rw_semaphore_lockdep_name(struct rw_semaphore *rwsem)
+{
+	return rwsem->dep_map.name;
+}
+#else
+static inline const char* rw_semaphore_lockdep_name(struct rw_semaphore *rwsem)
+{
+	return NULL;
+}
+#endif
+
+static void lock_class_subclass_X1(void)
+{
+	const char *name_before_setting_subclass = rw_semaphore_lockdep_name(&rwsem_X1);
+	const char *name_after_setting_subclass;
+
+	lockdep_set_subclass(&rwsem_X1, 1);
+	name_after_setting_subclass = rw_semaphore_lockdep_name(&rwsem_X1);
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
@@ -2920,6 +2958,8 @@ void locking_selftest(void)
 	dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE, LOCKTYPE_SPECIAL);
 	pr_cont("\n");
 
+	class_subclass_X1_name_test();
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
-- 
2.46.0


