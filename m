Return-Path: <linux-ext4+bounces-695-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4E824383
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9101C223F6
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA9241FE;
	Thu,  4 Jan 2024 14:17:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6E225D1;
	Thu,  4 Jan 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T5TDk57zmzMqcg;
	Thu,  4 Jan 2024 22:17:10 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 29E9218005E;
	Thu,  4 Jan 2024 22:17:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jan
 2024 22:17:41 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>
Subject: [PATCH v3 3/8] ext4: regenerate buddy after block freeing failed if under fc replay
Date: Thu, 4 Jan 2024 22:20:35 +0800
Message-ID: <20240104142040.2835097-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240104142040.2835097-1-libaokun1@huawei.com>
References: <20240104142040.2835097-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

This mostly reverts commit 6bd97bf273bd ("ext4: remove redundant
mb_regenerate_buddy()") and reintroduces mb_regenerate_buddy(). Based on
code in mb_free_blocks(), fast commit replay can end up marking as free
blocks that are already marked as such. This causes corruption of the
buddy bitmap so we need to regenerate it in that case.

Reported-by: Jan Kara <jack@suse.cz>
Fixes: 6bd97bf273bd ("ext4: remove redundant mb_regenerate_buddy()")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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


