Return-Path: <linux-ext4+bounces-926-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451183D63F
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 10:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5591F23CA1
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08721371;
	Fri, 26 Jan 2024 08:54:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F203208BA;
	Fri, 26 Jan 2024 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259293; cv=none; b=TLtGb+iWAGBJYoRAT9pK9xOFiOI00QytpSqWR0r4dai52kFajVAHnE4tHp5vPXCI9iGiWGWDhIeFN5/0Sh6+hZMZqjeakCkzgdTG0Mh6vQa02tNjuNg2FnDZMZFzcSFHfeOItEXx9KcmE+UOuvH4Xu5vTUQvg9i408kxrl+wEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259293; c=relaxed/simple;
	bh=DkiI7BUTL1eBPYg71PHFhBw8t/e1UJbhlPBGiuQ0t7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+InNSjz/8T4jPioTRmT95a2bnXH4w+2btmAwNWFmZi13M23+RFJzZvohSlu3BwgjwShDG1tx1HkgC0aFc4arcXQwXU0tvwKozhgATC1oZ1sXnb6u09W6NBnzR2Tj5jNVgsxRHjlqxzCKDvXYg9dvccQqsHQTDYRBuMf4OSoQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TLs1N2Mf8zsWXw;
	Fri, 26 Jan 2024 16:53:44 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id A7CD718001C;
	Fri, 26 Jan 2024 16:54:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 16:54:49 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 7/7] ext4: set the type of max_zeroout to unsigned int to avoid overflow
Date: Fri, 26 Jan 2024 16:57:16 +0800
Message-ID: <20240126085716.1363019-8-libaokun1@huawei.com>
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

The max_zeroout is of type int and the s_extent_max_zeroout_kb is of
type uint, and the s_extent_max_zeroout_kb can be freely modified via
the sysfs interface. When the block size is 1024, max_zeroout may
overflow, so declare it as unsigned int to avoid overflow.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 01299b55a567..8653b13e8248 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3425,10 +3425,8 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	struct ext4_extent zero_ex1, zero_ex2;
 	struct ext4_extent *ex, *abut_ex;
 	ext4_lblk_t ee_block, eof_block;
-	unsigned int ee_len, depth, map_len = map->m_len;
-	int allocated = 0, max_zeroout = 0;
-	int err = 0;
-	int split_flag = EXT4_EXT_DATA_VALID2;
+	unsigned int ee_len, depth, map_len = map->m_len, max_zeroout = 0;
+	int err = 0, allocated = 0, split_flag = EXT4_EXT_DATA_VALID2;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)map->m_lblk, map_len);
-- 
2.31.1


