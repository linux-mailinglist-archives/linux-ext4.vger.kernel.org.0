Return-Path: <linux-ext4+bounces-3243-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F74B930845
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 04:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6831C212F9
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 02:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C9979E5;
	Sun, 14 Jul 2024 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZrsFv5r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71627F;
	Sun, 14 Jul 2024 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720923470; cv=none; b=JJF8mOxDi+B1l8ignXu8zRuUjl2MJ6hIkmA36P0OuPzIS7hTEmPfh3+AQ4jVk1OW+Y96c0Jzwl1YcFSEAMS1Sw4Y4kcH56HYUS5G9x3cDIytLyGslP648Xq5TMF87QlGTmDJ1y8wrYBYuQMKdOaOv6mMf1UkGSMFyy4LTUsO0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720923470; c=relaxed/simple;
	bh=7saIKA8qMpKbEd9wBs8h8mybAWFy2v0tt43dMyJFu6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwMO6IMTkaEshnMVyADP7kAE1M9oKK3aP0iOM+Eh3bbPSiIYTN7cTjzptYFAp5/1+uLfrNwIlLk6Ka1N9Z+/DOshB3omdlf9OYQ0bF3q3F56U3G4MQcwjN8IzTprRxK4FZohPXbYLqqemwDX/8kK97YGD9731TxE+kwmOSVVVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZrsFv5r; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3679f806223so2498869f8f.0;
        Sat, 13 Jul 2024 19:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720923466; x=1721528266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCoKA5BrfWhFEib4kaVyxIYyuyejdXkK7Z8BehM2NAc=;
        b=FZrsFv5r0WkQGig74vHthNc2Qo7q6mpNhbxoS+3898Ek1RgZuUHpdFif4/JvCAwPIn
         SmyKB0bqMJcuNAT60YYQzlWTWGwmgfMJgo+f4P7WGVLV8AqwPvxCy32buBYkJW4qzR38
         GunodH83WyT85mtVAO/1ClqJEQhqKERch3BzYz/E9QrI0rbsNFdm5ZUhiR04oK5bJVYN
         luwQOZ9V9+QcYMax+TnXUTrTTjyZxMijfhNtWHei45rrJi3mDEXeVNDkiJFVJYxti3GS
         utoJmndkxRLfDIUFc9B2g36Re0Tbn8rqGS5yRcyWj6YgZ5DtryGy11kgWB5f7ytb/9XA
         iAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720923466; x=1721528266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCoKA5BrfWhFEib4kaVyxIYyuyejdXkK7Z8BehM2NAc=;
        b=w9Rp6WBCsFDH/1z7wJBRaKDgfK9OJZJZ4CFzw/stwJWONDZB2CW2jHwm0gIThT8koU
         rbNOBZcXSofkNM4k57FzYOWwbfD6x+B4VscFC+RdapVpAj1sq4Knp8peXT9YwYFIkhHp
         JSZPtdl/07+toDJVfwz2s6y7abqYBQH5ncWCOA3eDpvqybM7K2cGXT+dxgFdfGYWVzc0
         Z4fiS1TyXzWcD0ERQZ6NBMqI/gLLRJKRw462PiEn9qbVTExMOW69gTK8UkqC+h4ZLRsS
         +bVeM3FeFKmdiUCS4R8sDqU8oG+OWq95WGgLEcws0LAqlVTu749WToiAH13LZ0j/9tqz
         EBIw==
X-Forwarded-Encrypted: i=1; AJvYcCXE5mjp/uGH9Z0Nqz8/F8ZJgdL+Ox2DdfoaxgpbGHVx96fvxQWMQ1hJAcDY4DbCf5N/RHTa0Zpsro7YnjCNDmj1S3bHHSxJNVQx82A1L6iyehm2if3FF8lL2RqMeqOIL27B2g==
X-Gm-Message-State: AOJu0YzSU7G9f5GjBibCM7Ck8/JoVtiCOeQXT9teiohyzWlQ34kbI3Bm
	u26mj/d/L2cVJ5cQICAGxnCjtToUv5V+GS/h+Zi2e9sk7S9HyHHoNybNW9s4wW4=
X-Google-Smtp-Source: AGHT+IGng0aKTTKKDJUqgv6okJdzbLOCEt9gvgMrG99Ho+nKg8+Q7fOUTL/vjd0GDDqaH/ulLAvH7g==
X-Received: by 2002:a05:6000:e02:b0:367:938f:550 with SMTP id ffacd0b85a97d-367ff70537dmr5290238f8f.25.1720923466105;
        Sat, 13 Jul 2024 19:17:46 -0700 (PDT)
Received: from localhost.localdomain ([156.197.1.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e774besm38142655e9.5.2024.07.13.19.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 19:17:45 -0700 (PDT)
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
Subject: [PATCH v2 1/2] ext4: Forcing subclasses to have same name pointer as their parent class
Date: Sun, 14 Jul 2024 08:14:26 +0300
Message-ID: <20240714051427.114044-1-bottaawesome633@gmail.com>
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
Fixes: fd5e3f5fe27
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

