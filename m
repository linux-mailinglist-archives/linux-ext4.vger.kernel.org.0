Return-Path: <linux-ext4+bounces-3262-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48F8931248
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 12:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AB91C2267B
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9576187868;
	Mon, 15 Jul 2024 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Moj+jtQE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88F185E75;
	Mon, 15 Jul 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039373; cv=none; b=PAmt83+CgPwQqdEHPiuZRaoZHeyosLPd69H+7nSZb2vncSySh4mg5nfivth6uxzhUmyhvZbIMLfH7j7SBbbqKw9IfmRHGNSWoMT5yTDF/8Zyz1AtcusenAqD+8yyHoAcC8kl2hrFnR2UUDX7Oco7XbWJdy9epD/TchvGr3Styrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039373; c=relaxed/simple;
	bh=Tpo3i9nWRkFmdG+yqEX5SbUrsISpvqNzF38iONE2sdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFAah9R2/ePkgopSxzHykP8sjuUwpRI4H9nsRbSv+CwpwlWwc7GvD6b+8IvktjF3+aRyKMZTMhHly+sS2j7UnxekFXCa6jW7SSOKCCL+aQNieMZuQU8IHU6wTbI1MYPTqc3b6yvZJqvFUIFaP6gmVd7ILn9t3ZdRfed3R8h4gHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Moj+jtQE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eeef45d865so4816461fa.0;
        Mon, 15 Jul 2024 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721039369; x=1721644169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WfhfSZb9tdtzR3gnLjz0/3kFMfQiwyXaN/FkolkC9Zc=;
        b=Moj+jtQETZQ+kTYhisZ91TnhULbZT81huQOcAFtZevu0m6EIgfVbjIOf1VIltGrF+P
         2a8qYqtv4TM0WU7Uqpbe293wJtD+2k717FehuRqMDRer/UoHllWS8IKyAQyYWoksTmc3
         kbHNadFS/WaMY6E+IHUt+gefbaMIQwUBAbZxm9/ZI9AgHumrUZ2yLtQkG+wIFiayIPKp
         C4XDqDaSlN/xzUNoCYcnbjeXgFg/1XizDPgm8tdtJKSFolpQyPbTIPUyekSiZbkiGYsb
         zNgp0Neg6nfkWh01MtrQb3LRwSi6/t7+pZ9LqPXFFsBhvyDIJxOtPsqAJP7/pjD1OxHR
         yzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721039369; x=1721644169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfhfSZb9tdtzR3gnLjz0/3kFMfQiwyXaN/FkolkC9Zc=;
        b=FeujDfqs/+jA7QgBCPOR889G+2XF+chH1IVBlKLqhodHlsahMLpDkjhj+Vu2IQzAtA
         eigrC33S9mpEAO3FxXPCdveNPbGzo8qtnKrQ8CSz++XaxnLxPYeYCiCdBMpMPTxNA40C
         Tq//2veSQ4jryxX6fKK8LC8XanKDv8a/k2GMMlUe8rQOF29I0etLXgD/ToQ7BZjgemrr
         cDd1Xe+vA4VqaZNYuPwkI2ONveQi/vn/72CCqQbOSEY5Hs0vCh2HvUyLVGXDK+W+h2sH
         8PcdY9w0a+LDAx3uff2t3XzYkYCKy4JRckJy7wLVFgEXPwyeXow4FAvUxZOiYvuaW+1k
         VvFw==
X-Forwarded-Encrypted: i=1; AJvYcCXaWPvG1uARGXdm/14VU+9uO0YtgCaaHox4ZgiKcHdc1Q2urovW+BDTqHYevSfn7E37blxmS7B34oDUT9z3+o/quseqEFrmf4BbB+cWz8h2Hre/i4c5oIqwl6mH+/XEyB71WQ==
X-Gm-Message-State: AOJu0YwFq/WcFs2401DSvm7yBVbEAbe1LQ9y1jCIdmCFmqbiP9jnag2q
	mbs2in3OrrBpCli+DAY+RbPzILBizTVCTYmEqowlrfKekP2lTZoY4nAx7t6FDA8=
X-Google-Smtp-Source: AGHT+IGZT6pmo1C5EBVThTxwee153HHgHACC3+aB15ujmjHqmWt0s6JB1knURw4GD0o6fM6jOh/mrA==
X-Received: by 2002:a2e:8ed3:0:b0:2ee:4d37:91df with SMTP id 38308e7fff4ca-2eeb30fef50mr145012981fa.27.1721039367938;
        Mon, 15 Jul 2024 03:29:27 -0700 (PDT)
Received: from localhost.localdomain ([156.197.57.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f239883sm116126895e9.10.2024.07.15.03.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:29:27 -0700 (PDT)
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
Subject: [PATCH v4 1/2] locking/lockdep: Forcing subclasses to have same name pointer as their parent class
Date: Mon, 15 Jul 2024 16:26:37 +0300
Message-ID: <20240715132638.3141-1-bottaawesome633@gmail.com>
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
v3->v4:
    - Fixed subject line truncation.

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

