Return-Path: <linux-ext4+bounces-3256-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2C9930D06
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 05:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDE6281121
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 03:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114CD183092;
	Mon, 15 Jul 2024 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmQ8KJR3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF491D68F;
	Mon, 15 Jul 2024 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721014663; cv=none; b=f5gZG7lYbbs+l5Sr450/STQLp9Py2gqGDUHsmaf8CdS7+kubCpRmtw/HM4Oq51MJIK02aImNMCdnf1OBrUxTjHQAGeuGJekDXxmDM8jQ1mOIrk9zhoZh0BwWl34Y0WHFAqxHqsSiR9G1jfMwsANOIrX2iXSsOqNh1MCGRJ2f/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721014663; c=relaxed/simple;
	bh=Y0PadggLRkA95euQ2qJyyCo+WToLY6xDRBOzjxa9woc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/42dUr9lHyNZLtmrwhHszT3+ggLrUPnyx5bA+eA5P4fvybbxyM5/tZEY9qdCuggEhAHfrrzQVattPERgPNr2IlhQuk7jpINHCJJ2MDL2U3HTD1cksP/CVhGcAMtlYM3shy2p2+NP8QYjmn3mQXHnsqWIVeQehidasWADPeNpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmQ8KJR3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so23988065e9.0;
        Sun, 14 Jul 2024 20:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721014660; x=1721619460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cncGZVsdVkoJ+Ta2O3z5A5pVfum/7e9lqGRcPz/LKR8=;
        b=WmQ8KJR3JICKFzAXDX5pcL60bJq7xx6B/S6ojH9mWQA1UvZZnpZV2ZLC9uSKZwzeyO
         KGNuhC+snDniAdGfPhXCMK/FsIkJ+lI2DE2CBhPrdxJbk10BYuXah5wYH9pXX4tK9RtL
         BUmqIeHj3WKZyuqhspoYHX9EmAcLJT73iYavZWYPhjeHw4WkkncTfl7GScNSVZ1Xc7A8
         lLJCckuZAWzy3CtjgG3IRARVJGsYasX4h90nXHLbfcLUwAPMbY3c2jAQwN0xIpc8F7lC
         gdYZUi3ED7WQLLEzV459fVLyCWwtAO0/qPgBG3cC9tbSGiZCU02H7dYdVFI+0iAj0Y/f
         K9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721014660; x=1721619460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cncGZVsdVkoJ+Ta2O3z5A5pVfum/7e9lqGRcPz/LKR8=;
        b=XMLci0okIfXJqqxRuxgjQZAJUgC4sRW0gFvqlvkloiyuUnMcNDeBoNusPmclj6vPvy
         9xknth7iJjuzc5wkxGZ3tAbed0DiYFixq60uq4epo41o7sjbYM9iBh1TVnmbKk/KRpsM
         o6/pLW62Izcyt+yYU8Fh/EEkeLJ8Y68/n+sriCvN1vAz73lGOEXl7AIfiW8090Xv9tOD
         55RwrBwcOj0pfMHmJMtw/7JcjRr5ShcuoxPEEiEFq2eIPK1VTirEtZDTNoKJZhBmd4Ik
         ok1qHo/3th2lIzScOH3c8eCa6daDfYPU1TzECvD6BCUBSfHaoZkhFSDxQFctLFqEMWBb
         0lzg==
X-Forwarded-Encrypted: i=1; AJvYcCVcykjEKOFt2348i55EKijL+ZnqlHFFcGRNUvIZo+vAjvmQEeCUcz5xxtPOQE2ykmxcbIozwOlEe85MsUs8durzq1510+h97w31AROUU9dHsr17JEnzX3i0ZhdZz2lGnoYqGw==
X-Gm-Message-State: AOJu0YwD667Q05cRYzkx6Oq1Y5uNHbOEMHN9oLdK9f7IsM7FadpN06bt
	FpBqruAUCpxoCedfPSUJdOLgX6/19vb+UScAd2xfS9Oj/NKX7pnU6jUGmFkiuDQ=
X-Google-Smtp-Source: AGHT+IGCp9pnBR3+YaVvySCjBtKchpkQcveoCrHmToVOhcPnS6s9hzhxCX3gnzThxrRvYtHTAuP2UA==
X-Received: by 2002:a05:600c:54c3:b0:426:5440:854a with SMTP id 5b1f17b1804b1-426707cca09mr119389945e9.1.1721014659861;
        Sun, 14 Jul 2024 20:37:39 -0700 (PDT)
Received: from localhost.localdomain ([197.35.224.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25b946sm102604485e9.19.2024.07.14.20.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 20:37:39 -0700 (PDT)
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
Date: Mon, 15 Jul 2024 09:34:47 +0300
Message-ID: <20240715063447.391668-2-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715063447.391668-1-bottaawesome633@gmail.com>
References: <20240715063447.391668-1-bottaawesome633@gmail.com>
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


