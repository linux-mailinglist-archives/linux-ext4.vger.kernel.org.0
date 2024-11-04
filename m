Return-Path: <linux-ext4+bounces-4934-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B418D9BACD9
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 07:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB451C21FDB
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 06:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFC418E04C;
	Mon,  4 Nov 2024 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJjI7FT8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E8C18DF7E;
	Mon,  4 Nov 2024 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730703041; cv=none; b=bDxn600p1gclgBmyIBU0kRvdvopGQYe4s/JyBjD/ucve9wukYUnu6h1lIh6hkmUDAegZfzMP4USgaaGWg4VxyntxaaZNGViS9MSf1VvraZ2LLj/KTpMTN3pqp3cxDuSksZrRkYYqf6OIFAaIOd8OXwsyIPfVSazFZaLzFUTZbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730703041; c=relaxed/simple;
	bh=GvEFOykCUUnBWwQaqLSzTcN/d8nL19cSF46RKYsgBbE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g+jC0LtJ1pu4CdfNQQGd4LrOc812XkSDey5ivt+m/Lt80VizBTHMbbni8QGt0tQlJkgxdRN9w4ij0LxTvSzkAXkwLZpfX37hGZG4sZ3rW42qYtFnXDQ9PQnb+KPhd3xLLSsfGWXMXJGJIGLNbbaNV5oBD+weBN/ZTVJdPWN5PNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJjI7FT8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7187e0041d5so2046630a34.2;
        Sun, 03 Nov 2024 22:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730703037; x=1731307837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eO3/RubZ0jvIJ9YF1B3nhCqzkrpj+4q2V+B4q96o+PI=;
        b=JJjI7FT8oai315/sGnBxYIDpRCNzLoFtsJWX6VLHJyccsTEpEugqXZ8uNX8QegGdnQ
         ajoYj3SEfWBXAXTljQ/Csk4Z86NKx6r4KwOoOMT09wed6lZyYBVI4WShN1MBAb9fdy0c
         wVdnorAC5wIfomRCIwcAoLw7akWh4PxM0EgCTaVMa21n7ES4TUv8cXaZqIxJam5UKXUm
         BHFBKvG40d2dz8/zy0iIjO/807pHPWSgeTZSmfdBwlTMsAyk+IHiwngba9K89IKuPUPS
         OL6w4Mg61QkPEllBacB5ScES4GNRZebBO0MCuQ10oJTOsepv+/2SwKYAvQD5YG9PCo5r
         XtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730703037; x=1731307837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eO3/RubZ0jvIJ9YF1B3nhCqzkrpj+4q2V+B4q96o+PI=;
        b=M4Gxh+HAT0T+epVMasQT2RUBh7GX8PJKXhBPBsIr0VyWmlg7zXYWSYHtX3CBdiwWc2
         GfD6WKTxf3zQ225gODwlcNQFOgzbG9dq489Lw7SMKsUWrWq8DQpM4ohAr0S6VDHFgWPz
         BbAoO6YtP6WXs5JcGyVsncBTl4hXmrySbj3eIv4ysD3bBrsDewt4wx3W1I7e7OG1JK3W
         bCgNPvcimsEli9KmiysqOgcHmoKqR5nUQGU+QNKCtB/DwJlb0qYB9pAu/6URzdMbKQ2D
         KpsPWSIjuZChY96XE3kxvmRHIesT/GKBDBHi7x4o4sFc1bxx984vik5ei+nRPtsnEq+H
         pE3A==
X-Forwarded-Encrypted: i=1; AJvYcCU81aankFhR2/M8lvsF27lgL8hEaXg22xJhg48SlD/Pn7WLySPTUfzrjQmvEYGbJUDD1YEesOakbE2LzQIl@vger.kernel.org, AJvYcCXok8oNTTyBvfWnmYRM0KefuIVuiXwguteaTmFI/bDSBpP68bvq9ksB9L5vJt1ViMBu4kE5kkD6lj45@vger.kernel.org
X-Gm-Message-State: AOJu0YweHVy433Rk9BOroUuMEYEoo23n2ai3YKKxyYHjtVJWNiomYca+
	S5KfvnTbWkQhEqGX5Dq/Qk2O6GPQ8yoF306BwPA398o1oJFrv+QL
X-Google-Smtp-Source: AGHT+IGj3EDzkOoCrJz0dmX4kqse+9CNiQyin/NFZIWwMPzUauctYOZ6Hp5Aq1NIk+M25ydKOBNfqA==
X-Received: by 2002:a05:6830:410d:b0:718:b18:2319 with SMTP id 46e09a7af769-7189b542f06mr10266085a34.26.1730703037290;
        Sun, 03 Nov 2024 22:50:37 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ee459f92e6sm6373233a12.71.2024.11.03.22.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 22:50:36 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>,
	syzbot+a388a53633c9a4e9b22e@syzkaller.appspotmail.com
Subject: [PATCH] fix: KCSAN data-race in ext4_buffered_write_iter() 
Date: Sun,  3 Nov 2024 22:48:57 -0800
Message-Id: <20241104064857.295818-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ext4_buffered_write_iter(), generic_write_sync() is being called at
the same time by two different CPUs. This causes a data-race for
inode->i_state. To prevent this, make generic_write_sync() a critical
section in ext4_buffered_write_iter(). Use mutex to allow preemption so
other CPU is not blocked while waiting.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+a388a53633c9a4e9b22e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a388a53633c9a4e9b22e
---
 fs/ext4/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b..ce1251d3b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -19,6 +19,7 @@
  *	(jj@sunsite.ms.mff.cuni.cz)
  */
 
+#include "linux/mutex.h"
 #include <linux/time.h>
 #include <linux/fs.h>
 #include <linux/iomap.h>
@@ -282,6 +283,9 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return count;
 }
 
+/* lock for critical section of generic_write_sync */
+static DEFINE_MUTEX(write_sync_lock);
+
 static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 					struct iov_iter *from)
 {
@@ -302,7 +306,13 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	inode_unlock(inode);
 	if (unlikely(ret <= 0))
 		return ret;
-	return generic_write_sync(iocb, ret);
+
+	/* prevent read-write data race */
+	mutex_lock(&write_sync_lock);
+	ret = generic_write_sync(iocb, ret);
+	mutex_unlock(&write_sync_lock);
+
+	return ret;
 }
 
 static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
-- 
2.39.2


