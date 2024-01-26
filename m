Return-Path: <linux-ext4+bounces-929-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CFD83D646
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 10:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41901C26C39
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC429224ED;
	Fri, 26 Jan 2024 08:54:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A621A0A;
	Fri, 26 Jan 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259297; cv=none; b=o4nbHxQ8+0ISyxKD2NC5irYk2wIQhSvsw1w35K+PrPFZPk1gmtAFtI2RbNol0yO4fdWa8Cp2MEHPK01KDQkDD4pP6HwfbL9hpIfK8t0GrZih58arRNVVQ6nEUdvrf0wPBtjb+KPRrn2vBGCQzol7I5HxZb4jWAHxqk+wiMA/RAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259297; c=relaxed/simple;
	bh=CDQHfevYVnPvtVEHGW20nRJ7jdxHIiUnVBd6OT/G0Oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g074Oox3NXYixp8k/EO7Jc2uQ+yI0QVzgoSGJ+mkOwbKU3chTkoFk9iJ6enpPDZWWwDb8ZG/fj9sxbTdJsdANb1wIhYmzIOwyVxE2tXHhSogT8ec+r5C+763FPaqd88pYEHnwmFFWkApwXXzXJhO5sZCvHRLDndROQlLNn1jWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TLs0X3mfVz1Q88v;
	Fri, 26 Jan 2024 16:53:00 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id CFE5114040D;
	Fri, 26 Jan 2024 16:54:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 16:54:46 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 2/7] ext4: refactor out ext4_generic_attr_store()
Date: Fri, 26 Jan 2024 16:57:11 +0800
Message-ID: <20240126085716.1363019-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240126085716.1363019-1-libaokun1@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Refactor out the function ext4_generic_attr_store() to handle the setting
of values of various common types, with no functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/sysfs.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 3671a8aaf4af..834f9a0eb641 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -443,26 +443,22 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 	return 0;
 }
 
-static ssize_t ext4_attr_store(struct kobject *kobj,
-			       struct attribute *attr,
-			       const char *buf, size_t len)
+static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
+				       struct ext4_sb_info *sbi,
+				       const char *buf, size_t len)
 {
-	struct ext4_sb_info *sbi = container_of(kobj, struct ext4_sb_info,
-						s_kobj);
-	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
-	void *ptr = calc_ptr(a, sbi);
-	unsigned long t;
 	int ret;
+	unsigned long t;
+	void *ptr = calc_ptr(a, sbi);
+
+	if (!ptr)
+		return 0;
+	ret = kstrtoul(skip_spaces(buf), 0, &t);
+	if (ret)
+		return ret;
 
 	switch (a->attr_id) {
-	case attr_reserved_clusters:
-		return reserved_clusters_store(sbi, buf, len);
 	case attr_pointer_ui:
-		if (!ptr)
-			return 0;
-		ret = kstrtoul(skip_spaces(buf), 0, &t);
-		if (ret)
-			return ret;
 		if (t != (unsigned int)t)
 			return -EINVAL;
 		if (a->attr_ptr == ptr_ext4_super_block_offset)
@@ -471,19 +467,30 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 			*((unsigned int *) ptr) = t;
 		return len;
 	case attr_pointer_ul:
-		if (!ptr)
-			return 0;
-		ret = kstrtoul(skip_spaces(buf), 0, &t);
-		if (ret)
-			return ret;
 		*((unsigned long *) ptr) = t;
 		return len;
+	}
+	return 0;
+}
+
+static ssize_t ext4_attr_store(struct kobject *kobj,
+			       struct attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct ext4_sb_info *sbi = container_of(kobj, struct ext4_sb_info,
+						s_kobj);
+	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
+
+	switch (a->attr_id) {
+	case attr_reserved_clusters:
+		return reserved_clusters_store(sbi, buf, len);
 	case attr_inode_readahead:
 		return inode_readahead_blks_store(sbi, buf, len);
 	case attr_trigger_test_error:
 		return trigger_test_error(sbi, buf, len);
+	default:
+		return ext4_generic_attr_store(a, sbi, buf, len);
 	}
-	return 0;
 }
 
 static void ext4_sb_release(struct kobject *kobj)
-- 
2.31.1


