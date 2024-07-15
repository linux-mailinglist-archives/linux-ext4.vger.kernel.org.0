Return-Path: <linux-ext4+bounces-3264-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13889931256
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 12:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7C21F210D5
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E5A188CAD;
	Mon, 15 Jul 2024 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOyjFO2j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D6186E3C;
	Mon, 15 Jul 2024 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039697; cv=none; b=UGFt5i4P60lgEHa5WdLy7BuhUZEEJf770sTjoiHdu8+aaPDJBjTJ4BT5A2eWR+DIR+I6ZibeZ1jFIP4TY6AJm+PMtF9lQ9EBvE2kVji009EuOCGkKbi3qL7Erj6apmb+upDSRVknq1RekuHO8W4iJbvWVDdCHsRDiHF4rx3zHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039697; c=relaxed/simple;
	bh=z67cwuXCyLiAJN3piPdcSSVvfm1vvJ6uWmtFWPvPkVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyWuObka890z4/B9kfCl7fRrl9gAVrksOe2L4ov8V3xd1zucJExz3J7yMki6T2KvYMGTePeycuNRnTarXbOf4wpKa+LWgXu2OWqMOugo8niHOzx5+4iR6iWOXmy9g7zrLS3YqmocRvPfLvfoJVZ1dGk/5PREGNLE//t5bRwAZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOyjFO2j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42795086628so27862035e9.3;
        Mon, 15 Jul 2024 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721039693; x=1721644493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dffq/wFS7ipPDTEeMPaMdYsEzjLjNSdN/3BeGkOPcP0=;
        b=dOyjFO2jC7lHogNBLM8StPpGyN1uw8iMQDRDFKIW0UsDksnYrUmhu6v81GkaiKY6pR
         g5UHvLpBO4K7jk9Y0dP4L9x/ep/UowvtccDhyOvcjPxPuHY52L+YhNW+vPHjj3De4QoM
         2EapKJb7tB8W5+pQUnr/ZcvUtTTJ3EISKNx9milXM8hQlZu8iJdaa+a8GQpbUT6ZWVcp
         5Mbo62U3wNrYxIIgIMJOHCZx5a3/wigp+zRimQQcjpsub4aFoNyTYFw883jzZ50i65NV
         Gs98vZ9ZocswhixzQUcmFWIq9xc5isdONC++EweUnXCKU9mEjqo3WV+Nig76Arve7is0
         XR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721039693; x=1721644493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dffq/wFS7ipPDTEeMPaMdYsEzjLjNSdN/3BeGkOPcP0=;
        b=L9QvZ2hjjTVv4Re6+CDxUlCUQmF2ZE5fntTfB9baN08YKu0TLsFppx0NkYonvC3JjE
         SEjgHxnkVZsLQfzmc/uBkgZE8CP2leCF1mnrxHUwA+NNMzVtF23d1dCVc7zzyp7ORxOF
         KTz38ew2Xt1OK1hqMmzJ+8iIzLacJDcCMKPguRK9RT2+aYlDGLwvv7Qnqp9DySylMLr5
         avfcAOF71dEmsBhAX2KRFjqV0Hnet60NJTTU4j0aCoAYpxpwkXUZWEN4xSTD/ynZ3MSD
         77W/NfQDUHcmrJgAZIq7gDr0STDbskxD5uv5A1UnWvgWOxpJmoCNORGjKwknInN7ouU/
         lygA==
X-Forwarded-Encrypted: i=1; AJvYcCVkpuPIhqmn2dBDTU85mOXWy9xFNaoAFr1Llo9rbxTUATNBESQH0kGl51ahJBnhEbOXiYdNRRZwe98sJGHVXQO8E/JEyU/dtvGeu9PrpyCEPhLKVQL/0Ul6AfwLdQjUuzDUpA==
X-Gm-Message-State: AOJu0YyVAZpXj8VPbwxgBW7s1NcrWu3awQtWPLRLjJA4y8gEiy5MDilO
	uxJMMeCacbPPxcddIymTczGWAfmmSq1wmkSm4H3c2Wuw3DOrvv6JXtJT95fAKn4=
X-Google-Smtp-Source: AGHT+IFgbSwxsLnVD4xGnLJHLaWJpwMzFdvR7ziL66wXY2Nvt+hNP/YMHt2EaDX5P4VtWqKCjcfqYg==
X-Received: by 2002:a05:600c:63c4:b0:426:5e8e:410a with SMTP id 5b1f17b1804b1-426707e31aemr119937755e9.24.1721039693133;
        Mon, 15 Jul 2024 03:34:53 -0700 (PDT)
Received: from localhost.localdomain ([156.197.57.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f239883sm116126895e9.10.2024.07.15.03.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:34:52 -0700 (PDT)
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
Subject: [PATCH v4 2/2] locking/lockdep: Testing lock class and subclass got the same name pointer
Date: Mon, 15 Jul 2024 16:26:38 +0300
Message-ID: <20240715132638.3141-2-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715132638.3141-1-bottaawesome633@gmail.com>
References: <20240715132638.3141-1-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Ehab <bottaawesome633@gmail.com>

Checking if the lockdep_map->name will change when setting the subclass.
It shouldn't change so that the lock class and subclass will have the same
name

Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
Fixes: de8f5e4f2dc1f ("lockdep: Introduce wait-type checks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
---
v3->v4:
    - Fixed subject line truncation.

 lib/locking-selftest.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6f6a5fc85b42..aeed613799ca 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2710,6 +2710,25 @@ static void local_lock_3B(void)
 
 }
 
+ /** 
+  * after setting the subclass the lockdep_map.name changes
+  * if we initialize a new string literal for the subclass
+  * we will have a new name pointer
+  */
+static void class_subclass_X1_name_test(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | class and subclass name test|\n");
+	printk("  ---------------------\n");
+	const char *name_before_setting_subclass = rwsem_X1.dep_map.name;
+	const char *name_after_setting_subclass;
+
+	WARN_ON(!rwsem_X1.dep_map.name);
+	lockdep_set_subclass(&rwsem_X1, 1);
+	name_after_setting_subclass = rwsem_X1.dep_map.name;
+	WARN_ON(name_before_setting_subclass != name_after_setting_subclass);
+}
+
 static void local_lock_tests(void)
 {
 	printk("  --------------------------------------------------------------------------\n");
@@ -2916,6 +2935,8 @@ void locking_selftest(void)
 
 	local_lock_tests();
 
+	class_subclass_X1_name_test();
+
 	print_testname("hardirq_unsafe_softirq_safe");
 	dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE, LOCKTYPE_SPECIAL);
 	pr_cont("\n");
-- 
2.45.2


