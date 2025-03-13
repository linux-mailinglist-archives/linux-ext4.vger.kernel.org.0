Return-Path: <linux-ext4+bounces-6779-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32375A5E8DF
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Mar 2025 01:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DBB3B50DF
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Mar 2025 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285691EF39C;
	Thu, 13 Mar 2025 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVFDvl3d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23070818;
	Thu, 13 Mar 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741824036; cv=none; b=rzUJE1di/5en67Dxzwb3h0UJrLLf60MvGJ5x9AtoD04LVuY9frde2WG4fIN95nyopDwcQyCb+1WJL+fznPN3MNKl3PZ9PPrzAU02uLmGD3IYBpdKWwAlLfi4OveB99XW2w+pG0ts/PXnM6nK6hPZ7NzDQ5xcVxMNtrhHYlhflPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741824036; c=relaxed/simple;
	bh=4BMK/YpzzNp5PxalzBToe0ubZNqxp6ZnKRn7zN/f8i0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MI3SBor0vuED9Pe0ms/7+mTZQzzo1HWJe0mY5jN4W/SKxY6gJ7/lTIcEhBtVkV9DyLFeCz2+5sZbX0juCZpsxQl5brUHJ6RAazDdvl+IoqCNXFA/9hq6r+kqY0YdGPdv4pS0nnRv21GTG2DWxcg6pGBYTx8xzCsemw0iDdOsYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVFDvl3d; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so2750505e9.3;
        Wed, 12 Mar 2025 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741824033; x=1742428833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejuNv8rYCw+E9SmKdhuUEutSZ7Cxi43XWQoJBcNyrcs=;
        b=WVFDvl3dQ4f9Ck3VGepuHLJ6XcxQvw/qiGMdtgpjzVXgQ3DbW4Lx01gADrIdYkUzBy
         HJMl0KUQ82qDbnPXbh3xEzivUmraAki6miEpa2zWxBD4qmjvK4CWIwaw9SpJkZeBNEGl
         PyzGRqCWcDUObh+EXz0rUNyNTajq8Y4WBJtWe9wLFjV0HrExO6lDuqEzipG3X/WPBxP+
         NbPmsFHyKgshYqhGqcBHbi5pvVudlkxTIPfMr1GwszacRNEDYECjvOfeAte52IcVbduK
         slxsaMaqJfa5S6UVj4OLUYHANonPNSxNHrsLfSbDOjPNlNitPgLd7854K3lWCDO7Ak0r
         vF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741824033; x=1742428833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejuNv8rYCw+E9SmKdhuUEutSZ7Cxi43XWQoJBcNyrcs=;
        b=D03VIRL+zg/0h5lgLzgc3WOmExLN+ZS4pB676uMJEk4ViuH7N+ty+1idY8bcRxaofR
         dSJ67Pnp9vI/Rt0XIu/gOHvAO8VC/oMP/npX1FXnpH4pvc1Ga/dHwO8YrJMBD00rVk5p
         0CiSEDXiHpvx61AuPxMttfd4GDhccis0o2yCjEaV/uYEt1Ojuor7rqopvvHVkom8aNic
         wOw+raSaDqlshVNYHd3gJugIT/vWazqVj0zVgLslrQoG7DfGAyTcuc77dKBaY2owSKTz
         nVBpphhdnZIjVQY7e/JgkvXnr9bd3sUpylTmimk5YYpB2CeHH71mNCHnI9wOl9IrteGv
         04vw==
X-Forwarded-Encrypted: i=1; AJvYcCUHzpMwi3hq2WEz5TLoyfUqSlV7XMGyJcHzX0zyVmVVg9ahE/xTRGMIhK63ioQxqyTu6OFSVtRFZljtC14=@vger.kernel.org, AJvYcCUvcJf8HX8BAOF47DngRB4ijd6nDOK5FB/V3SoKw87mxuSaxHMBoCCgi2yKQFyFG2q3rvY5bRqX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LW3aAyt8pUtRnTcjHUeXp/o4Ff7SXCmsuypl+G39Wie531gI
	QnnjrYDhpRc7VhztKYG06kfghECUoYOHsK46FaUxKUgOsteb6XWo5DnFBA==
X-Gm-Gg: ASbGncuq4Y0p9W56SMV7Oi15fLY+ZXMbKwtnvEc5hv+k/nWVaiEepyRRkKhN9mP+G2p
	X6ifmyeGwW2hYnaf9Z5PzfOz8aRbT1VMgJNMp4Hfc+IAXvRSDPyCoGe/PJMkfZm2DnC4mwti2xw
	CSfMdGjCabEKPVFb+N8q74IWsD9fvXlcwQVQTEafos7450kkWUYx9MC1Kh5r+5JOeHnQknXNHxZ
	bYZSa6p6dOkW9EYH1UwfL/xL1qzSc5kPti06chKESf1yjmrd+v19fYIPIJQpolS4cGDn3m0n/V7
	KKnEXgKtSfHcbSjozm+paR7/WYD3CHEVQgODIj83FKI2sSR/odRWa/qTUA==
X-Google-Smtp-Source: AGHT+IFuo61yCvipm5hMZjaeumpbpltoRjoRDM1oIDlSvOgzJUvZEvB+rFPlQ299bPySriHs/yZzGw==
X-Received: by 2002:a05:600c:4fd5:b0:43c:fb5b:84d8 with SMTP id 5b1f17b1804b1-43cfb5b8569mr133512285e9.16.1741824032931;
        Wed, 12 Mar 2025 17:00:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:d012:c3ec:2d3:844b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8d0e01sm35770955e9.39.2025.03.12.17.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 17:00:31 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: adilger.kernel@dilger.ca,
	tytso@mit.edu,
	shikemeng@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] ext4: Fix potential NULL pointer dereferences in test_mb_mark_used() and test_mb_free_blocks()
Date: Thu, 13 Mar 2025 00:00:21 +0000
Message-Id: <20250313000021.18170-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_mb_mark_used() and test_mb_free_blocks() call kunit_kzalloc() to 
allocate memory, however both fail to ensure that the allocations 
succeeded. If kunit_kzalloc() returns NULL, then dereferencing the 
corresponding pointer without checking for NULL will lead to 
a NULL pointer dereference.

To fix this call KUNIT_ASSERT_NOT_ERR_OR_NULL() to ensure 
the allocation succeeded.

Fixes: ac96b56a2fbd ("ext4: Add unit test for mb_mark_used")
Fixes: b7098e1fa7bc ("ext4: Add unit test for mb_free_blocks")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 fs/ext4/mballoc-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index bb2a223b207c..d634c12f1984 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -796,6 +796,7 @@ static void test_mb_mark_used(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buddy);
 	grp = kunit_kzalloc(test, offsetof(struct ext4_group_info,
 				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, grp);
 
 	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -860,6 +861,7 @@ static void test_mb_free_blocks(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buddy);
 	grp = kunit_kzalloc(test, offsetof(struct ext4_group_info,
 				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, grp);
 
 	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
 	KUNIT_ASSERT_EQ(test, ret, 0);
-- 
2.39.5


