Return-Path: <linux-ext4+bounces-4053-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE62B96CA1B
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 00:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AD3287CBF
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 22:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2D717623F;
	Wed,  4 Sep 2024 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzQakMYj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF115E88;
	Wed,  4 Sep 2024 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488084; cv=none; b=DcPvdQtk3gZLggp6S+3/yRndtmHrtgPY2m47D8q+y+1I5Mj/shutQL1YIUr/V3S8SUAC+SM3SzIuFj6kos1IL5peyjEOrRDX1nyjy6GYz96zUacoiMLzsBifyiJtk58RE2O1FzDJeY0nFUCFKn/lpS2o0Mwyq7Eu+/qOSORXwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488084; c=relaxed/simple;
	bh=CgsG2+XiNjYPEy+DVNFbWNKxDVp5dFyls1EnUueMkRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLbXVzw3SrKppx2vHJyoRBwdN/jGIkH+van0FuxsadwVfcbfb4ss1K6L0gCoOjOSXBIGPwuhSwD5s7m3/SdnxlFhYY6p7aLq3297t+P5I+Yhksj1X+LEnYfsXv3RK7SzvxEoCaNlJyx8qUPXUAKPBA9EZfIsZHOFgi8Ykz1w7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzQakMYj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374d29ad8a7so30486f8f.2;
        Wed, 04 Sep 2024 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725488080; x=1726092880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsygHmC13nPym3x+NfMXuV7WZdkx9F+s+uWop9lRtS0=;
        b=kzQakMYjNuhUg2KrnTgB/7zQkQnrD1cmQToO0r8gvmI+8iwZrHMbo/xmEtncJJKFdT
         o5ZkUz6+aasbNXfYHX8rQbnFMz4vhUB+jjOHU8kdV6wn0P9khj2IJLwSv/h3PIXLFqSc
         75oUfQFnf5A3vTee8HnomBmqRb+T39mrKBXapmft0qm03EmS6kWnOpH5L2yn/NVd7oqq
         XUXGO7zZ0lVcGsAbjoxy8PWSTY6O+eaFRguWwsvCXiICWqvKKkjnsupITvTuNLWTa2cU
         vBnKxjO3SWpgJgS8+NoEwC7GzN/3vTx1aFpFescTeV4g0nr21G0UfVmLnbGCqkddl+9i
         Ed0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725488080; x=1726092880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsygHmC13nPym3x+NfMXuV7WZdkx9F+s+uWop9lRtS0=;
        b=ATkk5MZXL457DFjJSjUKVbQ52Cuv/SdmZaihml+aGUK8cY8nvufEGWCQwamU7k4ZgS
         KloPdGg/s8X0U7nql+NcWQO7Vf8Wd5NWlNbjOKROKLee56evAm2wXDCY5Z8wLj5F7A/W
         a1nWpi9LVnPZ2sEnHre6OTgmXubPBv8u04798+pIebg8JyT+ts0zz6IK0HPWPiGiI50+
         ey3QRP52C7M/Dt/VNU6t95oNgnk1n+QUbdaQt8LKXTXxYp+WH4BzevsGXepwpNh7fEJw
         M9RSin6Cry8GDuKtmOCimjf6yt+GswTZjfzpY7EN4qXvys+KD7Om3Ieu6XikOqc3GD58
         udmw==
X-Forwarded-Encrypted: i=1; AJvYcCWqgFQT716Y6UGyv8Dys64v/Il5QSDJffDGpT+33esdEGgw73cZtoAazwPDVWjczGIoJgkY9uwUYgAu@vger.kernel.org
X-Gm-Message-State: AOJu0YymV0erb/g66rfrLki+3z1B6ml8wXASxIPAyr0cU5OakxK/b3DO
	UfKly8mvnXSWyXniquxno4SmKKKm7rk7p3AVqd6W3ik1WdhWmVIs+3GbmOOtmPw=
X-Google-Smtp-Source: AGHT+IGf2Ws/BTsd0Y5w3sB6GiGG0rYmPyithXsJAOUnCbAG5wGVck88NwUxRvsLWRx+hgtWcFQCdA==
X-Received: by 2002:a05:6000:136c:b0:374:c5e9:623e with SMTP id ffacd0b85a97d-37770c70337mr2815523f8f.43.1725488080248;
        Wed, 04 Sep 2024 15:14:40 -0700 (PDT)
Received: from localhost.localdomain ([156.197.26.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cd205ab0sm8345086f8f.87.2024.09.04.15.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 15:14:39 -0700 (PDT)
From: Ahmed Ehab <bottaawesome633@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-ext4@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: [PATCH v8 2/2] locking/lockdep: Test no new string literal is created in lockdep_set_subclass()
Date: Thu,  5 Sep 2024 04:12:20 +0300
Message-ID: <20240905011220.356973-1-bottaawesome633@gmail.com>
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
+static inline const char *rw_semaphore_lockdep_name(struct rw_semaphore *rwsem)
+{
+	return rwsem->dep_map.name;
+}
+#else
+static inline const char *rw_semaphore_lockdep_name(struct rw_semaphore *rwsem)
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


