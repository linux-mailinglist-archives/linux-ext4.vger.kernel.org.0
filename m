Return-Path: <linux-ext4+bounces-3253-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340E3930CF8
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 05:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE311F21148
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 03:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0794B176FB2;
	Mon, 15 Jul 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5tjvXXF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08254176AB1;
	Mon, 15 Jul 2024 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721014226; cv=none; b=DAZez2yMztdSRBrX8vg4bJvvuirRQBVhigZgoBImTZ+nItYIIJkfQZdq6Ggs29NWT/NVc/QZ70XUUjg0xTioCcny6ttV4MeKWllQ9ZSgeCMdszysTx7otnzroa8ry4q6nlEiMWH8e9HowJDCWkT0sSzafbeomHARU8VmZgBjuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721014226; c=relaxed/simple;
	bh=cJRpNo/iI7BuI5w3pjrX7vr/qCEOdaeQjJjGilw2xA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkBlIAOf5pIjpSWi/1ijl49oM8WbaVvEV6KrhdTggB+NsqRnTC6qxPSkXlgdChNIVafImDu9UYnh7w+Jow5ozIKGvFs1ekXlvohR20AgkF6m57iGMukk6/GC61crJ2sl53o+v9FzeNy/1uqqtZ0R8wtQOdNlhMPjoNlHiC8QI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5tjvXXF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so25929465e9.2;
        Sun, 14 Jul 2024 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721014222; x=1721619022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd89MrgNcMORm5VAgplz/lj1KoWR6pPa+D0jHSmlnRY=;
        b=W5tjvXXF0OiJmJZbhaNFQboKOh4M/xZkC7mibSXhkziOvKhKR4RXJCEOu01mfwHrap
         67q14hoGEJIUV7g6I8e0c0UAWcw81W/SQz+G85FamOVvZ6FbbhiqewqTm6e9OVXsdq3z
         AFCiud/Siuf/Gab7sFaBG1XiClFnRa58bi0XdHTu6UCQAfiH0HuuHIW/6277Pu6C3HnH
         imuxP41TENjV1xD18am61OgW857ZIYGh1NKEtyLoN6FyxW5jmRCVh2mx+t8BL17qWKG9
         gBl2G9ZqP7sapjfZ5UYMmHc50NKnVPeiX439Ho2y+iuxtGlmLgX39HYiXOK2OQV9K8Ky
         lPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721014222; x=1721619022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd89MrgNcMORm5VAgplz/lj1KoWR6pPa+D0jHSmlnRY=;
        b=AjfGAwy/vUNGi4cXlsnXfU7d9gG8V5QPOb+4OuZtG3W4yRGhdsQ82moqgtVQhC3sJ9
         GGizjsJAA+iQ+3DP1mp7F6nm5OpENwM8yp8vCjCE/FsRG3UHleX/T3B6MJogOWvrAkPe
         GYEe0ZYJWRXl21pdpPxAGuVqPh9QUJhrjEBYwVGnrwdJKuI79xRFOrDq6IhKJSfr7EB5
         IOVBM6SddCbMLKg6ZXlHG1HwBDgF0JRLcqn1j7/pgkyTP4umMwfPIShNXOLphexVw7Zg
         3d9zm7O03G6x1e7k5iH+WBXq0EzuEfGmaYgRbMb6VwZtTk5OBgiOQUQ/Xa3IHe6Js1HS
         itnA==
X-Forwarded-Encrypted: i=1; AJvYcCV55PdxrdoW+7QKYMV+RFGvUmSQdNXkMWy+B7oVH+UT5GtiCl3sHYjtIITONClhG0wlW2uHyofy/VYJqJmMqAdLDtUOjrYEweb2w7dV+FgCWxtMrALk1fH6v7D2hoVrwOtpjQ==
X-Gm-Message-State: AOJu0YzRNXSGaua3bQ6ve0h8Uu9nRt7FKXEbDajuYde5SXF9fmWeeyjI
	QKX96Lbjd0fk4OUFUo7KNtApu24LfTg5dB00EFthev5hp4BD8e9DOgJRtxOPrOM=
X-Google-Smtp-Source: AGHT+IEJHTUDhkpWC4FUHsV9d5ygPc+ar72qJsf69EryJll+78vWGb6OWByA8KSGbXIPbu7rk4Fx8g==
X-Received: by 2002:a05:600c:2248:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-426708f14d7mr128152005e9.25.1721014221730;
        Sun, 14 Jul 2024 20:30:21 -0700 (PDT)
Received: from localhost.localdomain ([197.35.224.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25a962sm102645215e9.12.2024.07.14.20.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 20:30:21 -0700 (PDT)
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
Subject: [PATCH v3 1/2] locking/lockdep: Forcing subclasses to have same
Date: Mon, 15 Jul 2024 09:27:38 +0300
Message-ID: <20240715062739.388591-1-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Ehab <bottaawesome633@gmail.com>

Preventing lockdep_set_subclass from creating a new instance of the
string literal. Hence, we will always have the same class->name among
parent and subclasses. This prevents kernel panics when looking up a
lock class while comparing class locks and class names.

Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
Fixes: de8f5e4f2dc1f ("lockdep: Introduce wait-type checks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
---
 include/linux/lockdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 08b0d1d9d78b..df8fa5929de7 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -173,7 +173,7 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
 			      (lock)->dep_map.lock_type)
 
 #define lockdep_set_subclass(lock, sub)					\
-	lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
+	lockdep_init_map_type(&(lock)->dep_map, (lock)->dep_map.name, (lock)->dep_map.key, sub,\
 			      (lock)->dep_map.wait_type_inner,		\
 			      (lock)->dep_map.wait_type_outer,		\
 			      (lock)->dep_map.lock_type)
-- 
2.45.2

