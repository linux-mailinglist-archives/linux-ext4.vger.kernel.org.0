Return-Path: <linux-ext4+bounces-1403-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02117868BDD
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 10:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AF9281B44
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5817D13A26F;
	Tue, 27 Feb 2024 09:10:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115B1384BA;
	Tue, 27 Feb 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025018; cv=none; b=uKZR0e6LsO2Tw44pigITMK/PAwVPZ+++Wwx5yPRzWOY3svBh7dqGG8YPpQxN6zhi9ANrpIyNdpr8/QineIjZKkP7C2HqUKovCP6iFE+Q7adveFyPp8C7xGQHMKYM79/SJYij80fpvXvH4+i5nycctFiyDHJW1PLmGRbVZHCFmAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025018; c=relaxed/simple;
	bh=E3tx3eh+bCVYiHAIXeS50xiX4fCWXiXTC4hITGl7KwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiliKwNTXRNy+hUKRpWGIhpY/Q4/SdKvGxaL8rHaDZZI+vNq7QKRDdaI/Pn0EaOioiCjF6ssZobnDV3DzeaI5LhAO9LekqZXJBbeWvQH8O9CUY4J6dBgRHigNBPXnE3MdXYkvisu94upGJ/Ln2EuydyGO4borMWzePYAKHhkfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TkWrq0SZzzqhs5;
	Tue, 27 Feb 2024 17:09:31 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id C79DA140384;
	Tue, 27 Feb 2024 17:10:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:10:07 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 2/9] ext4: refactor out ext4_generic_attr_store()
Date: Tue, 27 Feb 2024 17:11:41 +0800
Message-ID: <20240227091148.178435-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240227091148.178435-1-libaokun1@huawei.com>
References: <20240227091148.178435-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Refactor out the function ext4_generic_attr_store() to handle the setting
of values of various common types, with no functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/sysfs.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index ca820620b974..2b1c529b7fdf 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -443,24 +443,20 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
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
+	int ret;
 	unsigned int t;
 	unsigned long lt;
-	int ret;
+	void *ptr = calc_ptr(a, sbi);
+
+	if (!ptr)
+		return 0;
 
 	switch (a->attr_id) {
-	case attr_reserved_clusters:
-		return reserved_clusters_store(sbi, buf, len);
 	case attr_pointer_ui:
-		if (!ptr)
-			return 0;
 		ret = kstrtouint(skip_spaces(buf), 0, &t);
 		if (ret)
 			return ret;
@@ -470,19 +466,33 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 			*((unsigned int *) ptr) = t;
 		return len;
 	case attr_pointer_ul:
-		if (!ptr)
-			return 0;
 		ret = kstrtoul(skip_spaces(buf), 0, &lt);
 		if (ret)
 			return ret;
 		*((unsigned long *) ptr) = lt;
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


