Return-Path: <linux-ext4+bounces-3255-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FC8930D03
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 05:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611541F212FA
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995918308C;
	Mon, 15 Jul 2024 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEimJytb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0641D68F;
	Mon, 15 Jul 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721014648; cv=none; b=r+WY4sXGvjXwE6EjAd1NTbuZXeTnqv4iivA2v3MgHvebWmcVSAjrtu6fAy3g/d1RyvvLGPserHRx4pa1Fl2Ea6rknnp5SbOLU97F+1mrGniOigNQzJGYm7mtvJSjyGm0GyO8oO5DSSt8PSFINAtjWE7Y6+2VZP6u9c+x5XKfXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721014648; c=relaxed/simple;
	bh=cJRpNo/iI7BuI5w3pjrX7vr/qCEOdaeQjJjGilw2xA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8Je1WZQ9nVJVBDH2KUGs1dMArpVs8RyFPh5dYxqLzEf0mdgrO2eaqb4WlSwMxDh4gl80Le5hE0QsLVrWydFI9uPUzu+krm+T2uUhtgCWwmkvgEwfGRHaFBPnbgij0unpl5BW+nhdE9x+X1fWMJzCLup8K3XiS3UdZPGhdZTdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEimJytb; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eede876fcbso17709761fa.2;
        Sun, 14 Jul 2024 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721014645; x=1721619445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd89MrgNcMORm5VAgplz/lj1KoWR6pPa+D0jHSmlnRY=;
        b=IEimJytbOzBW06OY0K44noGp+rj4lMG0dPeoz9TgdAezSv7Nw58DscirPGwE4ylaUS
         VQOcMZwqswnIWpVZCcXYrfZi+zv+Lh6an9umqb8gpLG0vIrFrrwFj+tRZTFd9vHahACy
         RyNH+Vz8Pw7xJxk7KIfO9MIM7zDvm8+6BXj0WpJ1NhFWjLG/I9OOwnpDSoJwFIATZDOX
         jMZhAC/1AxIR6vdHO+22M3LVBntm/ZBueLl83ZGti19/D4VtaqOB+E0ibIfWKT+bTQHp
         sHY0HCBsL4fz1TUMzR2DJKhpP+8mKJL8MtQ/eldzWpQQaczfLA120FVhOCC32FmcyJ/e
         rxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721014645; x=1721619445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd89MrgNcMORm5VAgplz/lj1KoWR6pPa+D0jHSmlnRY=;
        b=BWp/mWM/nu2WOz8tw9WYyCfSbyMw6BLlLbrSbi58lGzlZubuAnqD3oRnUUGuzM0nTP
         kch6K7uqZHztW5ztBYapPlsVkng/MuQz4+44VYNFAb15lfZYX2dtu66/Ak4TVJz/qlZ8
         ex8d6oQnIbT83wElQGbPjTWz76JUu3vLRjWpjKuRzq/G3y5sOXzUh6a7iLRVS8qpMkYJ
         7iGXQhOYxkczfny/61LaqWBRByo9vdjWPD1ohZeBNqa1FNedi8dJQoCupbIAPMIFif2k
         OvfbrlEzAIjEMLIjtBUuIFBRnD88bTQM7PlDL1/UEjd3W5KdzWboJUF/FYZWjf3/z061
         al+g==
X-Forwarded-Encrypted: i=1; AJvYcCXeMk8WZz3LQ6FDMjK0fMosLrz+JCPvrMzlCAQbS4nybCPnzVPZyRgHDxYzX1ivew3DRiCaZ97OD2jmSzKqNCgy8KSV415VEytaTD1oXeLqPkO1TEWIXljjpyVamEZ/t1Be5w==
X-Gm-Message-State: AOJu0YzE/kCjc4W2F2VgIT2NcLRvdC+4ITQjfIcakyW/GKztbGkrnbRy
	NsxZfyrC+NjOjhZKXAhsyz5ggmk4eMEpje5jL2kUPwrO1vQs6yObj8hQHLraGzE=
X-Google-Smtp-Source: AGHT+IFuOnuC1jqv7U79ZPTMb9O4A22IBmgkmC7SU7BC+4QXWbf9zYjWJBXMK0EdZgnGAXZ6U92n+w==
X-Received: by 2002:a2e:a78b:0:b0:2ee:6b86:b0aa with SMTP id 38308e7fff4ca-2eeb30e3693mr150239671fa.17.1721014644461;
        Sun, 14 Jul 2024 20:37:24 -0700 (PDT)
Received: from localhost.localdomain ([197.35.224.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25b946sm102604485e9.19.2024.07.14.20.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 20:37:24 -0700 (PDT)
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
Date: Mon, 15 Jul 2024 09:34:46 +0300
Message-ID: <20240715063447.391668-1-bottaawesome633@gmail.com>
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

