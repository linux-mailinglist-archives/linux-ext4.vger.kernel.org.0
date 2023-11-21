Return-Path: <linux-ext4+bounces-49-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFAB7F2337
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 02:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174E2B2195E
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 01:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E6579EC;
	Tue, 21 Nov 2023 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6ADF5
	for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 17:40:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZ6X41kyDz4f3k5x
	for <linux-ext4@vger.kernel.org>; Tue, 21 Nov 2023 09:40:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E1F631A070D
	for <linux-ext4@vger.kernel.org>; Tue, 21 Nov 2023 09:40:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA6MClxlGMf4BQ--.64879S6;
	Tue, 21 Nov 2023 09:40:38 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH 2/6] ext4: make ext4_es_lookup_extent() return the next extent if not found
Date: Tue, 21 Nov 2023 17:34:25 +0800
Message-Id: <20231121093429.1827390-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231121093429.1827390-1-yi.zhang@huaweicloud.com>
References: <20231121093429.1827390-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3iA6MClxlGMf4BQ--.64879S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Wryxuw1rtw15CFW7XrW8JFb_yoW8GFWfp3
	sxZ34UKrW8uw10ka1xKr1UXr1Yg3W8KFWxGry3Kr1fG3Z3J34SkF1YyFy2va4kWrW8Gw4Y
	qay8KrZrGayjvrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
	CS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
	RMTmhUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Make ext4_es_lookup_extent() return the next extent entry if we can't
find the extent that lblk belongs to, it's useful to estimate and limit
the length of a potential hole in ext4_map_blocks().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 1b1b1a8848a8..19a0cc904cd8 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1012,19 +1012,9 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 		goto out;
 	}
 
-	node = tree->root.rb_node;
-	while (node) {
-		es1 = rb_entry(node, struct extent_status, rb_node);
-		if (lblk < es1->es_lblk)
-			node = node->rb_left;
-		else if (lblk > ext4_es_end(es1))
-			node = node->rb_right;
-		else {
-			found = 1;
-			break;
-		}
-	}
-
+	es1 = __es_tree_search(&tree->root, lblk);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len))
+		found = 1;
 out:
 	stats = &EXT4_SB(inode->i_sb)->s_es_stats;
 	if (found) {
@@ -1045,6 +1035,11 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 				*next_lblk = 0;
 		}
 	} else {
+		if (es1) {
+			es->es_lblk = es1->es_lblk;
+			es->es_len = es1->es_len;
+			es->es_pblk = es1->es_pblk;
+		}
 		percpu_counter_inc(&stats->es_stats_cache_misses);
 	}
 
-- 
2.39.2


