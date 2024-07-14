Return-Path: <linux-ext4+bounces-3244-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A2930847
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 04:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085391C211A8
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 02:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09394B64E;
	Sun, 14 Jul 2024 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDDkX4/y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D492F5E;
	Sun, 14 Jul 2024 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720923495; cv=none; b=aSkg4bAmZFkaYvr4ItSjFDlUrvl5wGnh/RDflBBvNHg0JAS/bbF1EyHbNvqTuF+mdHNKCknxGj+i5LhmFpZp6uHMEEanspXCPb8jcC5Ua+g/SdMACEZ3lJKv0TS7RviYkTJxrWWGfu5AelzRlNF76nZz8PcFx8Hng2FFChGMYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720923495; c=relaxed/simple;
	bh=Q2VWN9oYpodyWvS7RzRqUazVqYKNN8A1wmP5RDMVu2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gva//KhmgC/NTGfUeblZ54qQflSUCoFlSE9s/11h8Ip92Iyf8IzgiHyXvr4d9LrETCvPmWOgGzQsOYquEHo8Lk4n6q5grHpo7+D/FrGunQk6yjpyT89mAm4wn3zaUBBkK9Ss3OxoIb0dQWF9XdFn3Ryf/6lZWCVSC0+onn6oQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDDkX4/y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4279c10a40eso18829195e9.3;
        Sat, 13 Jul 2024 19:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720923492; x=1721528292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAs1Gk4an+iNb/J96GVaGrZrn8TrGn7XZfkpZtZ/+3s=;
        b=MDDkX4/yN1k1bSPJ6xaW2gdTAqAnfUTgBX72Jq4ZDEJ72zHdmt2FdBOZ95aP5VTxHX
         +rmQGm7tCWEhAd67HX1w6Wp0BZgzbyP2+CCeg+KnMfoHJz+U5YVWXXe+zGDOzxAFqOQG
         h0LqeJoOZHx9M90302Rw9bd8m4MddyUD8+/ited3hhhlsRAx3MuJ7WDpWQDF1usinMmW
         aQuIq6mLuCQhow7mwni7cRDfRlUUB3fDfcJFTJpM853yfEwHTv1ngtPMGGSoc67dCVHa
         3okqIi5tPEl74zYvhMDCqDn+V5/45wm5Tw1DBiNGPWMSAKpPV/VKZfVhY2vxGUFFKFS3
         MJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720923492; x=1721528292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAs1Gk4an+iNb/J96GVaGrZrn8TrGn7XZfkpZtZ/+3s=;
        b=roEko6W2ExFegxFCpAVmAvsk5LEs6CAO9ToR3GTHeUToVkb7KtxoBh7MXotADFuMCO
         rA6MDhn4zAKL9YVwkSwCJJlAoxL8O2q+gsLxIKOFpJEcvUbt0ysksXzmkTGYM/y9mmAy
         zcsbNTqikGGp3MB69vEU9ed9gdB1+2zE27Bemwuh4E48Ws8jaEThChcWBWoKDV3dvNwn
         Qw1oQI1dSneUatJhAN1WZvR9jprMKgPiDzYPUCLn3KNfKQttX2s4gKTCd5QF9vrY0xCv
         mAUShtRAhJq5ERrk6ZbjJfUxgdpGD357SKufPUS/li5RPikM5TqRem9BXAH1AoQ5aBFd
         d8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVFaXkENUCsbFdJnHwP6zPeh+STdEHRCfkHmhPamAdtJJrZzkYI0+Eibb+FQMgpq8fXfdADtk/KzuMJLQ7NS4SNEXqHCpTuC/Ax3CEKLpcEJG9PjLrPPiOHt2lJYQmplbDOvw==
X-Gm-Message-State: AOJu0YzrmHyz6fHNY+OD7FpJ/+WXLuJnEObLGT5VktZVzVbtx8AMSTwg
	Jups52p/jcEM5aFfgO0AMw8N0WBbJJ7P+g99gdVyeqpD9/0MxwTBRuOQvlEHqQQ=
X-Google-Smtp-Source: AGHT+IEgJqm+4IgLtChQAMhCHVaPrvOHaykEEA+S++jectej03gs2zLNTF0WplY5JTGrItqluKdpyw==
X-Received: by 2002:a05:600c:4930:b0:425:5ec3:570b with SMTP id 5b1f17b1804b1-426708f1f07mr96194945e9.35.1720923491924;
        Sat, 13 Jul 2024 19:18:11 -0700 (PDT)
Received: from localhost.localdomain ([156.197.1.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e774besm38142655e9.5.2024.07.13.19.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 19:18:11 -0700 (PDT)
From: botta633 <bottaawesome633@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-ext4@vger.kernel.org,
	syzkaller@googlegroups.com,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ext4: Testing lock class and subclass got the same name pointer
Date: Sun, 14 Jul 2024 08:14:27 +0300
Message-ID: <20240714051427.114044-2-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714051427.114044-1-bottaawesome633@gmail.com>
References: <20240714051427.114044-1-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


