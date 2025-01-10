Return-Path: <linux-ext4+bounces-6034-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80151A08BF0
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 10:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2555168CF1
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277D20ADE6;
	Fri, 10 Jan 2025 09:24:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3320ADD8;
	Fri, 10 Jan 2025 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501077; cv=none; b=TvmyZk0v4Ii29dJYXBFK/mOr9H/eysOcGac1f67b9CpTe0vJGzHkSUg8p3ViydDbuQypljIPM/g021BO1BEqApMxKX9G8iuY7BphtGZ2Tz0xHxhk57WYuwo50ZitrBf70Kwefz4/XhnD/0yfHto1z/iU1W2YItknVg64CQfgW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501077; c=relaxed/simple;
	bh=AKkJCaCPXSvyH5GqVcbVqUM5RcY8rfwt8AfH6+YT3RM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hMMxZ+2hQ8/DnhbLfoiqoV7WWI2UCdJDmsvh/WOP2goBjZsOzNNHtW2PAh21Y831SpBaqLc4MHS5ZqtDp+zXgOG4U0waQCtjrCmdc2PSIn6zYY5JEYTdTz9ubmMxzgxsTBl5mB3JBPj3+PONwSXD/XTxCepsWaCn6SduxKqJ+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id ICJ00024;
        Fri, 10 Jan 2025 17:24:24 +0800
Received: from localhost.localdomain (10.94.7.238) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 10 Jan 2025 17:24:23 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <shikemeng@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] ext4: Fix potential null dereference in ext4 kunit test
Date: Fri, 10 Jan 2025 17:24:21 +0800
Message-ID: <20250110092421.35619-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20251101724249214b117e871fa48ec07ca4690175d48
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

kunit_kzalloc() may return a NULL pointer, dereferencing it
without NULL check may lead to NULL dereference.
Add a NULL check for grp.

Fixes: ac96b56a2fbd ("ext4: Add unit test for mb_mark_used")
Fixes: b7098e1fa7bc ("ext4: Add unit test for mb_free_blocks")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
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
2.45.2


