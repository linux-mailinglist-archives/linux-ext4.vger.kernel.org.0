Return-Path: <linux-ext4+bounces-1691-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D409987FCD8
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 12:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5B8B22104
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7E07FBA6;
	Tue, 19 Mar 2024 11:32:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696BF7F485;
	Tue, 19 Mar 2024 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847938; cv=none; b=NbQ7ommskNzsE1yyrqg9l2yONygjobMY5Fr5WvLb/yS+jqqtvv7p6Ww/SpSqtYhXq7Sq01Y5GAdwMSy0Xmo88zt5FCGHCEx8N9G2PXhPp80HZEvGdZvhrQGHtCk+67yR9KEHqADo30Oi/xS/oYc9yQ937wDjSOvtyHnvyi586Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847938; c=relaxed/simple;
	bh=0n5+Sdvy+OTRXKi5f3l2hiJnqHHcszu9qyw8Fm2oqrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoFj8rZWwoTlokHpHMOXmSpCb2OA4NarakcSXPDlEFTN5iA71t+vviLHylQyUXhueUZ0qcCRVoirTmE3L4gr44luUtj/7svT9Ufq1e4TK947uRpVdpKWxG4B9lnBmNfr/zSGWDGqthMzvy9svviPKpPNa8H8ieZEzVHp7rv84as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TzTyt0zF6z1h2l9;
	Tue, 19 Mar 2024 19:29:42 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 81118180060;
	Tue, 19 Mar 2024 19:32:14 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 19 Mar
 2024 19:32:13 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v4 9/9] ext4: clean up s_mb_rb_lock to fix build warnings with C=1
Date: Tue, 19 Mar 2024 19:33:25 +0800
Message-ID: <20240319113325.3110393-10-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240319113325.3110393-1-libaokun1@huawei.com>
References: <20240319113325.3110393-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Running sparse (make C=1) on mballoc.c we get the following warning:

 fs/ext4/mballoc.c:3194:13: warning: context imbalance in
  'ext4_mb_seq_structs_summary_start' - wrong count at exit

This is because __acquires(&EXT4_SB(sb)->s_mb_rb_lock) was called in
ext4_mb_seq_structs_summary_start(), but s_mb_rb_lock was removed in commit
83e80a6e3543 ("ext4: use buckets for cr 1 block scan instead of rbtree"),
so remove the __acquires to silence the warning.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index dbf04f91516c..c65fac9b8c72 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3190,7 +3190,6 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 }
 
 static void *ext4_mb_seq_structs_summary_start(struct seq_file *seq, loff_t *pos)
-__acquires(&EXT4_SB(sb)->s_mb_rb_lock)
 {
 	struct super_block *sb = pde_data(file_inode(seq->file));
 	unsigned long position;
-- 
2.31.1


