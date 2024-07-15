Return-Path: <linux-ext4+bounces-3254-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED513930CFB
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 05:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E13281410
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 03:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD4A17B4FA;
	Mon, 15 Jul 2024 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCAYf8+U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC517B435;
	Mon, 15 Jul 2024 03:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721014254; cv=none; b=Ksoh75ZrZD+uKdfGPxNQWfU4h5Yg7yXZlDPSgJ0m60Ntob/nc437jPegPTdU27LkefP3eRGn+4fNHDNaBIS9Q2icIqDu6jxm4C7b0J9Cr9pm8jqiQoERH8vCZcwyTQ/OmGCZfYOn7IFKvu18Kh3D6fvDsqLKn8+AAPNjC+CXKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721014254; c=relaxed/simple;
	bh=Y0PadggLRkA95euQ2qJyyCo+WToLY6xDRBOzjxa9woc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQI0nHIZjT8mcXPGPit/BJF+7Co+y4BVdrS5y6fhjsjflRzF3Uu/EpWeJLKRJPIl5/K9tX+71k85N6CEjY2ljuBJzJ7P3EoxiJPkLKbg9bBHjckPa5cpLfNLi9ToJync/2xKpLkffkBQHCc9MaJTjulS4zV7dCoPdukoXSFxyn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCAYf8+U; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4267300145eso29406525e9.3;
        Sun, 14 Jul 2024 20:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721014250; x=1721619050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cncGZVsdVkoJ+Ta2O3z5A5pVfum/7e9lqGRcPz/LKR8=;
        b=eCAYf8+UpIPwD/G82Q5Qt7BBeoVby7FS1wLJISCHdBYWSPAkw5SAKBrjNKOyZrQ2Kv
         240BBvehqpxIP/IFlu9kSosCGD9J/7KPI1HU94jb1r9GSLuFj5MUPlNBd0/PVhJ2vJrr
         qLc38QmCNN7XhIyGWZ67fxkv+vVeZeB3BTLbGlq1eer/sBuIdyMbzS39KhuZZr2IQaRm
         iEsIGpBqQxefpbCXrnIJil85ThfxzAyBsN6uWnY8HYy5hGMM5QPy9VbSL7o+wHD9o453
         LOAvJIhJU9YCH8iLFh0sXeFGhb0pV6sDx/sCLgJkCx5xge/7VdVjufnyNYyCe6j2aaJD
         +Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721014250; x=1721619050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cncGZVsdVkoJ+Ta2O3z5A5pVfum/7e9lqGRcPz/LKR8=;
        b=odkKx9oC3uiBNkfWA6XvQeu444EyQHa3buNsAqWanzNFYCUHBfL5QfO2iEjwqAj8mi
         NW/rNGdxeBWXsAy3+hqri7w1U6c+8sy/fNqTx6vAnYJdysJx6zwxexnqwywJEqal0TO3
         iVt3mP/22QTnjeaGGk0pYiLflrNV4Sh/6zCqzexarEZlMABCz4h1DrITetc75nxWnIVt
         PXYK+It03I0NePxRbjxn0e0uTco42IBHxIXfjE69gq7FWo6/U5CdtxOzRLgFSyqpcGpf
         /HkllXkMUlA2+jfhgfXI2jvxN8SH6J089dn0maPDffDa745FdvozxuTJv8ttVR6Jutr/
         TUjw==
X-Forwarded-Encrypted: i=1; AJvYcCXsep3jHS/pqLKXGp2NS/Re2U9NEMYJdoVzx6IC76pKTM9rOliHij+dHezO1Cce1AnPV8iHmrad206k249eSrf3hNRtpSu0jAYN45Y+p8FwSW6ZR3Xm27/5YOtdIaqZuZjKSg==
X-Gm-Message-State: AOJu0Yy0WXjNE+SebszVXOd7DkwD9EdGgF6h29bQFea/Buj1p3EpRAZJ
	XiqtPnUiTGEa+lSbwu8R4bcwSKGsoitkLhmpYfDMBDrFeoRdkLr9VTCGgDH/BUU=
X-Google-Smtp-Source: AGHT+IHbou6rRE+8GM70FOzWEFQapdUXE6HTCENk8EIGmdbq3ZUwHjfs/lnqgxEvOIKTWF43vsE4cw==
X-Received: by 2002:a05:600c:4baa:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-426706c656bmr166533575e9.8.1721014250540;
        Sun, 14 Jul 2024 20:30:50 -0700 (PDT)
Received: from localhost.localdomain ([197.35.224.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25a962sm102645215e9.12.2024.07.14.20.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 20:30:50 -0700 (PDT)
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
Subject: [PATCH v3 2/2] locking/lockdep: Testing lock class and subclass
Date: Mon, 15 Jul 2024 09:27:39 +0300
Message-ID: <20240715062739.388591-2-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715062739.388591-1-bottaawesome633@gmail.com>
References: <20240715062739.388591-1-bottaawesome633@gmail.com>
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


