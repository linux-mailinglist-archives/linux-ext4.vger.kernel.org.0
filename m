Return-Path: <linux-ext4+bounces-1397-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3C2868BC9
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104AD1F2214E
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 09:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F07F1369BF;
	Tue, 27 Feb 2024 09:10:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0013666E;
	Tue, 27 Feb 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025013; cv=none; b=eu9cDPWsom2RAaxFxxaONgacSu24I8wn3RTZNS21G96zZI/wBbCMHgWgLFxZcSOMGplpktlDM9jHisiIrEIf5WoFaOOvOE7Np4fx64Cb+sjmnOetf/eWsyraH93kt7PMwEMq4PNif7uY1RrQHJxfxJ5eFVjNucn7kH5yalfX424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025013; c=relaxed/simple;
	bh=GQePeHmLBXBOXIAO3Kr28EekfNyWO9K0IjzdXcsDa/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHFqT01zUwTEaJfPnW3NhEURsbznocL+WoxPpyRocqTHNcF4/ijsbxhXlIGWYgA02NAY4TzhZc3ZC0hy0OXjNOOWN9/ae5EC6yw8oOHy28JlzNyfvim/sPKam9mp4CnmPZEHCFQOsk0Kuwo46fd3FZ7As6C+S95yOtdwgFXsqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TkWqq2TCbz1xpPH;
	Tue, 27 Feb 2024 17:08:39 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A2821400F4;
	Tue, 27 Feb 2024 17:10:08 +0800 (CST)
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
Subject: [PATCH v2 3/9] ext4: refactor out ext4_generic_attr_show()
Date: Tue, 27 Feb 2024 17:11:42 +0800
Message-ID: <20240227091148.178435-4-libaokun1@huawei.com>
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

Refactor out the function ext4_generic_attr_show() to handle the reading
of values of various common types, with no functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/sysfs.c | 74 +++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 42 deletions(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 2b1c529b7fdf..7f455b5f22c0 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -366,13 +366,42 @@ static ssize_t __print_tstamp(char *buf, __le32 lo, __u8 hi)
 #define print_tstamp(buf, es, tstamp) \
 	__print_tstamp(buf, (es)->tstamp, (es)->tstamp ## _hi)
 
+static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
+				      struct ext4_sb_info *sbi, char *buf)
+{
+	void *ptr = calc_ptr(a, sbi);
+
+	if (!ptr)
+		return 0;
+
+	switch (a->attr_id) {
+	case attr_inode_readahead:
+	case attr_pointer_ui:
+		if (a->attr_ptr == ptr_ext4_super_block_offset)
+			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
+		return sysfs_emit(buf, "%u\n", *((unsigned int *) ptr));
+	case attr_pointer_ul:
+		return sysfs_emit(buf, "%lu\n", *((unsigned long *) ptr));
+	case attr_pointer_u8:
+		return sysfs_emit(buf, "%u\n", *((unsigned char *) ptr));
+	case attr_pointer_u64:
+		if (a->attr_ptr == ptr_ext4_super_block_offset)
+			return sysfs_emit(buf, "%llu\n", le64_to_cpup(ptr));
+		return sysfs_emit(buf, "%llu\n", *((unsigned long long *) ptr));
+	case attr_pointer_string:
+		return sysfs_emit(buf, "%.*s\n", a->attr_size, (char *) ptr);
+	case attr_pointer_atomic:
+		return sysfs_emit(buf, "%d\n", atomic_read((atomic_t *) ptr));
+	}
+	return 0;
+}
+
 static ssize_t ext4_attr_show(struct kobject *kobj,
 			      struct attribute *attr, char *buf)
 {
 	struct ext4_sb_info *sbi = container_of(kobj, struct ext4_sb_info,
 						s_kobj);
 	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
-	void *ptr = calc_ptr(a, sbi);
 
 	switch (a->attr_id) {
 	case attr_delayed_allocation_blocks:
@@ -391,45 +420,6 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 		return sysfs_emit(buf, "%llu\n",
 				(unsigned long long)
 			percpu_counter_sum(&sbi->s_sra_exceeded_retry_limit));
-	case attr_inode_readahead:
-	case attr_pointer_ui:
-		if (!ptr)
-			return 0;
-		if (a->attr_ptr == ptr_ext4_super_block_offset)
-			return sysfs_emit(buf, "%u\n",
-					le32_to_cpup(ptr));
-		else
-			return sysfs_emit(buf, "%u\n",
-					*((unsigned int *) ptr));
-	case attr_pointer_ul:
-		if (!ptr)
-			return 0;
-		return sysfs_emit(buf, "%lu\n",
-				*((unsigned long *) ptr));
-	case attr_pointer_u8:
-		if (!ptr)
-			return 0;
-		return sysfs_emit(buf, "%u\n",
-				*((unsigned char *) ptr));
-	case attr_pointer_u64:
-		if (!ptr)
-			return 0;
-		if (a->attr_ptr == ptr_ext4_super_block_offset)
-			return sysfs_emit(buf, "%llu\n",
-					le64_to_cpup(ptr));
-		else
-			return sysfs_emit(buf, "%llu\n",
-					*((unsigned long long *) ptr));
-	case attr_pointer_string:
-		if (!ptr)
-			return 0;
-		return sysfs_emit(buf, "%.*s\n", a->attr_size,
-				(char *) ptr);
-	case attr_pointer_atomic:
-		if (!ptr)
-			return 0;
-		return sysfs_emit(buf, "%d\n",
-				atomic_read((atomic_t *) ptr));
 	case attr_feature:
 		return sysfs_emit(buf, "supported\n");
 	case attr_first_error_time:
@@ -438,9 +428,9 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 		return print_tstamp(buf, sbi->s_es, s_last_error_time);
 	case attr_journal_task:
 		return journal_task_show(sbi, buf);
+	default:
+		return ext4_generic_attr_show(a, sbi, buf);
 	}
-
-	return 0;
 }
 
 static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
-- 
2.31.1


