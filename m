Return-Path: <linux-ext4+bounces-6708-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 190F6A56729
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 12:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0627E3B4C30
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2927C218596;
	Fri,  7 Mar 2025 11:54:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5F20C00C;
	Fri,  7 Mar 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348492; cv=none; b=rHKRXvG4IIjXmgkAaqIe9DEC4yRTSDWZCbFJSJy5GnxH7VAs1AZqcCydDOEFT9zWqgGgJxmVT8CNcxKD7hL4xhdwSCl2jEP+TKI5p0tIMlMudDGMfd5MfDvC/z7FwZ3jGFpGCSA0y3jQjpGL+kPatKP8RQdtlARhs8SlSRhHT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348492; c=relaxed/simple;
	bh=mPKsLyoG+ckF5NFg1lfJ02qsEtyp6ZZ2A3Sbeeh98bc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m+eNgpo5wIgb7GJ/j+8je9ndPMKnXCW9/F45ECQ2k4Kxwd08XEsUHmDhlrM3psH3YV43wrhxTnqXHYCJ0GE4ZNt2E9A4yFThUBigPTs77TAj6sx5GaZxeZCPo7o0mSOqyOD8TdnaQ+cio4p7aY95adm5QeBxqxWf3Cn+EmtGskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201611.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202503071954331739;
        Fri, 07 Mar 2025 19:54:33 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Mar 2025 19:54:34 +0800
Received: from locahost.localdomain.com (10.94.3.180) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Mar 2025 19:54:34 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <shikemeng@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] ext4: Fix potential null dereference in ext4 test
Date: Fri, 7 Mar 2025 19:54:31 +0800
Message-ID: <20250307115432.2112-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025307195433270ead79a7667a2e3ea6f5ac35d98a80
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

kunit_kzalloc() may return a NULL pointer, dereferencing it without
NULL check may lead to NULL dereference.
Add a NULL check for test_state

Fixes: b7098e1fa7bc ("ext4: Add unit test for mb_free_blocks")
Fixes: ac96b56a2fbd ("ext4: Add unit test for mb_mark_used")
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
2.43.0


