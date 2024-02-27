Return-Path: <linux-ext4+bounces-1394-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE7868BC3
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 10:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2280F28591F
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7913667A;
	Tue, 27 Feb 2024 09:10:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF6136669;
	Tue, 27 Feb 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025012; cv=none; b=I2RUvkbA5uiCSrhuiiEPrOI4Tvau53n8QpPgmy8IZXY6NYebc5BRYlF/M6R9mLXrg66wX6iJnjv1wrmT73AwJNTFAxgnacWWDHRbs4Rzte8UfZ3sTCN47OSEXO+SQUzRIpbZDWEhM37B/lB4qcrt1OFEyBGLJa0uFNdN/2htz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025012; c=relaxed/simple;
	bh=B79jOCDg+Kqp2CFNODMFiUg5lRFhiblMGPgkPFvWVKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUSS7YMKKeEPfAnIxUkTZe4Zed2AaeDv7FxNvzWXAFUTBtGz2RQvxN8D3KeRKp5zE/9loVVNxsBY3Wl5GPbHKfEUnT6e7VfArTIWWAhvTW241MZTVbtQr79XKaKF7IO/xuXkhAybSfwU7VZ/BRtwYY27S5N5a7Q5HLYC1KgwT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TkWq23NT9zvW3F;
	Tue, 27 Feb 2024 17:07:58 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 41578180072;
	Tue, 27 Feb 2024 17:10:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:10:06 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 1/9] ext4: avoid overflow when setting values via sysfs
Date: Tue, 27 Feb 2024 17:11:40 +0800
Message-ID: <20240227091148.178435-2-libaokun1@huawei.com>
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


