Return-Path: <linux-ext4+bounces-1638-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD3E87BE6C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 15:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE64281C94
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23576FE09;
	Thu, 14 Mar 2024 14:07:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF15B683;
	Thu, 14 Mar 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425268; cv=none; b=V6nwte8vtkS5xzOlrl7TtJs7Wm/xB8vQHcxi/Z7dfD7l7h6Tmpqqaw5gi6JEwTeejL4NHoHw4d5NAW+OWz/oTUQKmaZXXhxPk86aDlEssocvROAzv6GFxNsUpUmR+xVIXLI6J1GMSMx65TKjbCNae+SM1jrnlzXCEk6OPl6wcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425268; c=relaxed/simple;
	bh=8AM8pym/lLuefOMlDqaQegYdsko79Al05Npk0vTE81Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQxDW9fEpdyWDV+zkfH6Az3SQUDvUuepLUfIfqQwTBHjNSh/xxUIw7Kz/YS6tKpjwUq0ghLJA4ZVFxKGwbbzePQIAxkILzU/7zUMNVM4zwhtI0xTFxr+5MKvVzJKNwPbNewp7knMsxo6eLBZGmOJ4As2tidQvVETmgsmY70ajT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TwTjC0W8Nz1FM9Z;
	Thu, 14 Mar 2024 22:07:27 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 0329B1A0172;
	Thu, 14 Mar 2024 22:07:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Mar
 2024 22:07:43 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 1/9] ext4: avoid overflow when setting values via sysfs
Date: Thu, 14 Mar 2024 22:08:58 +0800
Message-ID: <20240314140906.3064072-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240314140906.3064072-1-libaokun1@huawei.com>
References: <20240314140906.3064072-1-libaokun1@huawei.com>
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

When setting values of type unsigned int through sysfs, we use kstrtoul()
to parse it and then truncate part of it as the final set value, when the
set value is greater than UINT_MAX, the set value will not match what we
see because of the truncation. As follows:

  $ echo 4294967296 > /sys/fs/ext4/sda/mb_max_linear_groups
  $ cat /sys/fs/ext4/sda/mb_max_linear_groups
    0

So we use kstrtouint() to parse the attr_pointer_ui type to avoid the
inconsistency described above. In addition, a judgment is added to avoid
setting s_resv_clusters less than 0.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/sysfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6d332dff79dd..ca820620b974 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -104,7 +104,7 @@ static ssize_t reserved_clusters_store(struct ext4_sb_info *sbi,
 	int ret;
 
 	ret = kstrtoull(skip_spaces(buf), 0, &val);
-	if (ret || val >= clusters)
+	if (ret || val >= clusters || (s64)val < 0)
 		return -EINVAL;
 
 	atomic64_set(&sbi->s_resv_clusters, val);
@@ -451,7 +451,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 						s_kobj);
 	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
 	void *ptr = calc_ptr(a, sbi);
-	unsigned long t;
+	unsigned int t;
+	unsigned long lt;
 	int ret;
 
 	switch (a->attr_id) {
@@ -460,7 +461,7 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 	case attr_pointer_ui:
 		if (!ptr)
 			return 0;
-		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		ret = kstrtouint(skip_spaces(buf), 0, &t);
 		if (ret)
 			return ret;
 		if (a->attr_ptr == ptr_ext4_super_block_offset)
@@ -471,10 +472,10 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 	case attr_pointer_ul:
 		if (!ptr)
 			return 0;
-		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		ret = kstrtoul(skip_spaces(buf), 0, &lt);
 		if (ret)
 			return ret;
-		*((unsigned long *) ptr) = t;
+		*((unsigned long *) ptr) = lt;
 		return len;
 	case attr_inode_readahead:
 		return inode_readahead_blks_store(sbi, buf, len);
-- 
2.31.1


