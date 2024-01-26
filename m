Return-Path: <linux-ext4+bounces-928-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9B83D644
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1890428B337
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC970224D3;
	Fri, 26 Jan 2024 08:54:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F121A0B;
	Fri, 26 Jan 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259296; cv=none; b=W4wyDt15y6SYHnuU5PEN8sZCA/YE8P/XZGIetiIVlSoImetUJZ28UVwpANhIJMJU8IpcVtdlRbJ3B0M+c931wbMTN8Dc2sQhtMPNpZOJkR0JU1lglMLJHORg+gmBMAqgb/ZeUDrHTpKQY6l26KilRlIMs+UWnMex/bQ4DrPIYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259296; c=relaxed/simple;
	bh=XVZTnWgrN4eoD381RhpPzZI9lSQkvdNH38Scr5pZWLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgfQigMczrap8KcEb+o2FDbJD2nl4zb9or2GCxlprI/qxM68CppsZ0zATKeC8U8tng3oLJwtcRcVCPGaX7aG7cv3V+brsAzyU3kuu+JuEL/AeR8bEFx78wBXGyVI9MxVqFJLffNhU1JVHDZIMwDwjJIIN0IaxChZYdYol3vZT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TLs0X2Dd8z1Q85N;
	Fri, 26 Jan 2024 16:53:00 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 99BD114040D;
	Fri, 26 Jan 2024 16:54:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 16:54:45 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 1/7] ext4: avoid overflow when setting values via sysfs
Date: Fri, 26 Jan 2024 16:57:10 +0800
Message-ID: <20240126085716.1363019-2-libaokun1@huawei.com>
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

When setting values of type unsigned int through sysfs, we use kstrtoul()
to parse it and then truncate part of it as the final set value, when the
set value is greater than UINT_MAX, the set value will not match what we
see because of the truncation. As follows:

  $ echo 4294967296 > /sys/fs/ext4/sda/mb_max_linear_groups
  $ cat /sys/fs/ext4/sda/mb_max_linear_groups
    0

So when the value set is outside the variable type range, -EINVAL is
returned to avoid the inconsistency described above. In addition, a
judgment is added to avoid setting s_resv_clusters less than 0.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6d332dff79dd..3671a8aaf4af 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -104,7 +104,7 @@ static ssize_t reserved_clusters_store(struct ext4_sb_info *sbi,
 	int ret;
 
 	ret = kstrtoull(skip_spaces(buf), 0, &val);
-	if (ret || val >= clusters)
+	if (ret || val >= clusters || (s64)val < 0)
 		return -EINVAL;
 
 	atomic64_set(&sbi->s_resv_clusters, val);
@@ -463,6 +463,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 		ret = kstrtoul(skip_spaces(buf), 0, &t);
 		if (ret)
 			return ret;
+		if (t != (unsigned int)t)
+			return -EINVAL;
 		if (a->attr_ptr == ptr_ext4_super_block_offset)
 			*((__le32 *) ptr) = cpu_to_le32(t);
 		else
-- 
2.31.1


