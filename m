Return-Path: <linux-ext4+bounces-3884-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F7395DFC2
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Aug 2024 21:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE533282913
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Aug 2024 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36DF7DA79;
	Sat, 24 Aug 2024 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6TbKhWp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681B7DA61;
	Sat, 24 Aug 2024 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526773; cv=none; b=kWRWrFwalN0kwEYLhrV3e3dQXw7dWK5+Hy52X/CfvhKeprWO89Uv0tsFi0sB8qbJGdxacJPiafgxBDnfszZbA9kLEPMhDOd33zgDFxeXYSCxeryoa3lUY9j66sKP+hKdrJIHkyRCCE12Hvbnebpa+Dst0HV2PBq8bJz9luYCiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526773; c=relaxed/simple;
	bh=pnaGJYOZGck1ER1jWc1dvxcWSL8te3arYl6CgL95lrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGny5MHEbCbkurFsk7D5lb5pgz7rxGsrgCeN6RCGSrs5lb/qoeo/Ccos1hsb4e5Nx/hmkasOEgGHEmqyZqhrFG43WbeMjdumcYhjSJLsg429Abv86f2k+O2XU4ZBjGDdrmh7DT1NdMN0KeKsNKlAxkuBFbHIB4pMMuBbD/DfbEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6TbKhWp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso25202855e9.0;
        Sat, 24 Aug 2024 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724526770; x=1725131570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRqSVSBy7WVzrRyXzMTngEmfTDtpwenXKbG7hH0Uup8=;
        b=G6TbKhWp5tfCeafR9InzSm0Cr+GmDlCfnSK2T6XmYkqzYNTFLWhgwV5dVQOz5Db9sW
         bhQve4v8XDVTr+pyV4qEgDhu31S/LXl9EXGI3vNkdANtFHRKy7s9CNHyHFmJn1nBy048
         GR8xfzrNnzsdtOGtSXmtpk4HNqH9X8B9FW4iJgrrcIJhrHAZ8ODGhQ6H17cOQpDCwxvj
         YTBaByxEFjKsbqhbquTxbJcPsx5+LGQmWeFL8KkyhQEszlU0wWDICnZHdUpl5817/Znc
         3Pi4oAqY1lxtg7C6F60sWAvMp7AkAmWTtnMt+GIXIcdgIkODdD0hjOKJFEu+X7ig98st
         z40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724526770; x=1725131570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRqSVSBy7WVzrRyXzMTngEmfTDtpwenXKbG7hH0Uup8=;
        b=GH0xpDC64I46aDoLwo4PSpVpY40PZEfTvXBQAuO9heVjjfZFm7UtNIJywSJLTPWo6j
         KeB2QsqDNBF+42r86ODo/kht+7qBNmyWI9YBfufF3sW7ft/8JV/qzbtv2Ut+QJCGJgCU
         5CMHeKpP4vsyeZzyOT2kgcVddKfOvmO/vTUfkPe36TPpxNMdtnxg6nmXuYvc876Px/4S
         /10+foX4AoF28ojAf9a//gHPMsO2FK5jiZMlHOmDukRatU4vVjbFcnk3hETuWYepznwm
         JkkJbvM30tw7hbtinWFb3FZJuQksQnGdYb0oia4XA1cHY/MbogU3cEjWHbwr6us9GPYf
         u/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV/9fY0O1GiAiFKyKwsOZhr68HtkGajm3QOj19l3cPZwMDDuNIB3VizJ5bF2bgXHpgck9Km3c/d3mn@vger.kernel.org, AJvYcCVxnTBZu7tellYMtvR3SBgUBF2ZVVoW13/1Vh5oLUnheCqEGPpW3IY8Z5Oz8nTnX+l64gUqemKY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs0PRUDYgnmu1SXHviOFqB5h1paO/yk+vcjHzBGNyKaLYB1kn+
	kmJr2oJEkdagC6YIc9fi+8shSfwN7FIzHQ6rVMtosSwzwrOwu/YB09VGjeUI/i4=
X-Google-Smtp-Source: AGHT+IEOcWJXK+IUeq9aebQdW8nPQy00HtJM4j9sdFCYGF6fyDggXTCyaAy5A/yB1LwAbqhRDy0WVw==
X-Received: by 2002:adf:f5c3:0:b0:371:8c1f:6692 with SMTP id ffacd0b85a97d-373118e979amr3784385f8f.52.1724526769323;
        Sat, 24 Aug 2024 12:12:49 -0700 (PDT)
Received: from localhost.localdomain ([156.197.22.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c520sm7109793f8f.39.2024.08.24.12.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 12:12:48 -0700 (PDT)
From: Ahmed Ehab <bottaawesome633@gmail.com>
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
Subject: [PATCH v5 1/2] locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()
Date: Sun, 25 Aug 2024 01:10:30 +0300
Message-ID: <20240824221031.7751-1-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reports a problem that a warning will be triggered while
searching a lock class in look_up_lock_class().

The cause of the issue is that a new name is created and used by
lockdep_set_subclass() instead of using the existing one. This results
in two lock classes with the same key but different name pointers and a
WARN_ONCE() is triggered because of that in look_up_lock_class().

To fix this, change lockdep_set_subclass() to use the existing name
instead of a new one. Hence, no new name will be created by
lockdep_set_subclass(). Hence, the warning is avoided.

Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
Fixes: de8f5e4f2dc1f ("lockdep: Introduce wait-type checks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
---
v4->v5:
    - Changed the subject
    - Changed the changelog to be more detailed

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

