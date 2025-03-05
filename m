Return-Path: <linux-ext4+bounces-6670-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9EA4FEDD
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Mar 2025 13:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F0C3A7ED6
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Mar 2025 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D75D2459FD;
	Wed,  5 Mar 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccuTXNw8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533EB246326;
	Wed,  5 Mar 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178432; cv=none; b=Gq7qjKGFjomy2kUHuyuIzv6mRD3dQwMmIWBjGJMAcOJ/xa+2PuV/y5E3VutD3i8ALg7ibWly85d0aJxd1UJhXtSaLRJQKlOO6W3RDxhPawVjSgDWITitV7UMQ+dh96a4cPwsNek/MIFFx+yxIMwRlmF+8/UK+gXrWj5mmp+IFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178432; c=relaxed/simple;
	bh=oeAyzhOZkb7LEMowcz56bvOxX8oCCi6/DhM8XJDiiKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Abp6BIt7Rv+AL1shUJfwuAbMkAbz1Z5MarlXc+hF//8jZo9PIEgUrossQX6CdS3fR+Fe7/QBSG3LTuECFhpeSIuMbGDY1X5HoPKK1wmJmBdcMyc55qolLsRvDb4plZOPj6ojx2WzwrbhsfIXzwoYxPYdSi35o7SK4LEFYSyJHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccuTXNw8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390f5556579so2953684f8f.1;
        Wed, 05 Mar 2025 04:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741178428; x=1741783228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qv7vNwjiLrzxqQ13AbY2Y9wvDjj6iJYqXWPt/syp30=;
        b=ccuTXNw8o2IB78qiLHB+ffTLn/eKFtj79EV2MBb/QfDKL009NKz4LA3TvsiTqx70fR
         7H2SuAn1C6RsP7iDin6zf0XoxrYriAqpEw8p+3ruf8LRLbRwxgcwnb63i3DmNQSDi4Ht
         h29jrJGiqybPAQlKrcoo5JGbOerkklTFSs7tQkgDheBjSzIQT2bZ9fWqbvmO8Lt+zqNz
         MO5Qydr9YmG1Yn7GoM0zl0ioxvKFKpox44fnxonDreEYPNUGk2VFu0vhR97WOb7WQikH
         pnQVi/f+Qa73YFb/7Hp+FWizlncLzbut392ABdwu8YkfgXOP/bERKOoxWuxv8L+F9hV3
         +JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178428; x=1741783228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qv7vNwjiLrzxqQ13AbY2Y9wvDjj6iJYqXWPt/syp30=;
        b=u7pqcvftH/xZUC26MJENOO2pDCKQudqA7IMehZUdfO/bAqagCmb2bk+FC24xS/gOqQ
         utquSlLaXq5WpZ20CgT9ux5PJ0I5sRQAcoEXZHltUMOHk+dq4IO4ob5eIikB+7CYeh9V
         1FxLM9vjABwK/r+5cJI4BCjM2YtXrzzEvDCTU+s8sGyTXsdtGXvTTeecF16SpBWCAP3A
         K+xHfGDMU6oPBbZNotM2CSb7osnVVT2ZOKFPzstvUUx7eZ0NdnaeFiBWyPb8hBumeRGB
         KDwlWUXHG8/2aYembZJInGFGkD2Tf9KtSNGCqdAHDE4dOhnj16bDQhktck9otxB7EZrz
         ez3w==
X-Forwarded-Encrypted: i=1; AJvYcCV9WZ/mUKGRY243roWWG3wreJk23TW9ORB6ZyO81ZQCFxEgcgTedrk9QKOGcvRTpvbQzvBHJf0N@vger.kernel.org, AJvYcCVYQwaGZDv/sn7NnUWPm3tH4nVZ7Ebv4+Bpu4drd62CF+37q3f3Ts6bU8+XwTy1u0OgRXixrJrE0w3gyD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LG5V01FoEjdkExSpacShv9pL5qHDbYeCw78K/fWxS0uri1Q9
	XSlq02vzjQLhWQzhx04+PTL/Y96BbLDty9GNtpuS2XfnXcPctI7EimnbFA==
X-Gm-Gg: ASbGncuQAbXCPq8dSSOTnZSrRLJccXJ0WoZszUGtnMauVEoBxeksrdY+uFw+Jt0ntdU
	4zmfL7yyW2sB8mwtiRHECy96f9p0oqnkKKY/1LoDz9UbpwV/mD+O+YBmo/jXrBaBulo5tQAM1kI
	kIbSdyTvGWzp0yioJGbqgAsJl7IF1wfaw7L8TBZMQJwWim60RJNiedsk06ju6JDdIttVPM6N8AY
	N+hWcgZXRYFp59m1VvS4hhO19FIgo6hfDbfKjFPT2H7319SLwbAYDD/UEs7g7QM8M7dy0bJpVFw
	djpFVk5nSRcNNHtKer0Sn3vZb4GgfPgewUbHzxHd0p6oJQ==
X-Google-Smtp-Source: AGHT+IHUUVHZp3vO4Q9MO882vZfI2u8tktJ9u/LsJlvZzzHu94nWDHiy8WED3wb5qVHrYlJa8wuNlw==
X-Received: by 2002:a05:6000:2b0b:b0:390:df7f:c20a with SMTP id ffacd0b85a97d-3911f772ae4mr1498716f8f.33.1741178428208;
        Wed, 05 Mar 2025 04:40:28 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:dd18:aac7:25a4:9d82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcbcc53d3sm35391675e9.0.2025.03.05.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:40:27 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: adilger.kernel@dilger.ca,
	tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ext4: Fix potential NULL pointer dereferences in test_mb_mark_used() and test_mb_free_blocks()
Date: Wed,  5 Mar 2025 12:40:12 +0000
Message-Id: <20250305124012.28500-1-qasdev00@gmail.com>
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

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Fixes: ac96b56a2fbd ("ext4: Add unit test for mb_mark_used")
Fixes: b7098e1fa7bc ("ext4: Add unit test for mb_free_blocks")
Cc: stable@vger.kernel.org
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


