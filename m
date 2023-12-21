Return-Path: <linux-ext4+bounces-533-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C693C81BA18
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Dec 2023 16:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652461F23917
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Dec 2023 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFA1539E4;
	Thu, 21 Dec 2023 15:02:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9565B3608F;
	Thu, 21 Dec 2023 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SwtvM1xJwz1wn6J;
	Thu, 21 Dec 2023 23:02:23 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F9A61400DB;
	Thu, 21 Dec 2023 23:02:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Dec
 2023 23:02:38 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>
Subject: [PATCH v2 3/8] ext4: regenerate buddy after block freeing failed if under fc replay
Date: Thu, 21 Dec 2023 23:05:53 +0800
Message-ID: <20231221150558.2740823-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231221150558.2740823-1-libaokun1@huawei.com>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

This reverts [Fixes] under fast commit replay. When we are freeing blocks
that have already been freed, the buddy may be corrupted, and we need to
regenerate the buddy when the fast commit is being replayed in order to
avoid using an corrupted buddy, since it will not mark the group block
bitmap as corrupted at that point.

Reported-by: Jan Kara <jack@suse.cz>
Fixes: 6bd97bf273bd ("ext4: remove redundant mb_regenerate_buddy()")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a95fa6e2b0f9..f6131ba514c8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1233,6 +1233,24 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 	atomic64_add(period, &sbi->s_mb_generation_time);
 }
 
+static void mb_regenerate_buddy(struct ext4_buddy *e4b)
+{
+	int count;
+	int order = 1;
+	void *buddy;
+
+	while ((buddy = mb_find_buddy(e4b, order++, &count)))
+		mb_set_bits(buddy, 0, count);
+
+	e4b->bd_info->bb_fragments = 0;
+	memset(e4b->bd_info->bb_counters, 0,
+		sizeof(*e4b->bd_info->bb_counters) *
+		(e4b->bd_sb->s_blocksize_bits + 2));
+
+	ext4_mb_generate_buddy(e4b->bd_sb, e4b->bd_buddy,
+		e4b->bd_bitmap, e4b->bd_group, e4b->bd_info);
+}
+
 /* The buddy information is attached the buddy cache inode
  * for convenience. The information regarding each group
  * is loaded via ext4_mb_load_buddy. The information involve
@@ -1921,6 +1939,8 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 			ext4_mark_group_bitmap_corrupted(
 				sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		} else {
+			mb_regenerate_buddy(e4b);
 		}
 		goto done;
 	}
-- 
2.31.1


