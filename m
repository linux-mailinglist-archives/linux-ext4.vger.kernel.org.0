Return-Path: <linux-ext4+bounces-720-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8212824D7A
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 04:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EF01F22D10
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 03:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC9C46A1;
	Fri,  5 Jan 2024 03:33:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA44C9F
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T5pvG46thz4f3pJZ
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 11:33:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4D9AC1A08D8
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 11:33:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6hByeJdlyaRBFg--.23173S10;
	Fri, 05 Jan 2024 11:33:20 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 6/6] ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC map type
Date: Fri,  5 Jan 2024 11:30:18 +0800
Message-Id: <20240105033018.1665752-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105033018.1665752-1-yi.zhang@huaweicloud.com>
References: <20240105033018.1665752-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6hByeJdlyaRBFg--.23173S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1kKFWkAr4DGw43GrW7Arb_yoW8Kr17pa
	9xKFy7GF43Xr1qgr48trW7Zr1Yk3WUK3y7WrWfG3s5Cr10yry8tF48CF1SyF90qrWxZw1I
	qF4jkr18ua1SyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since ext4_map_blocks() can recognize a delayed allocated only extent,
make ext4_set_iomap() can also recognize it, and remove the useless
separate check in ext4_iomap_begin_report().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c141bf6d8db2..0458d7f0c059 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3261,6 +3261,9 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 		iomap->addr = (u64) map->m_pblk << blkbits;
 		if (flags & IOMAP_DAX)
 			iomap->addr += EXT4_SB(inode->i_sb)->s_dax_part_off;
+	} else if (map->m_flags & EXT4_MAP_DELAYED) {
+		iomap->type = IOMAP_DELALLOC;
+		iomap->addr = IOMAP_NULL_ADDR;
 	} else {
 		iomap->type = IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
@@ -3423,35 +3426,11 @@ const struct iomap_ops ext4_iomap_overwrite_ops = {
 	.iomap_end		= ext4_iomap_end,
 };
 
-static bool ext4_iomap_is_delalloc(struct inode *inode,
-				   struct ext4_map_blocks *map)
-{
-	struct extent_status es;
-	ext4_lblk_t offset = 0, end = map->m_lblk + map->m_len - 1;
-
-	ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
-				  map->m_lblk, end, &es);
-
-	if (!es.es_len || es.es_lblk > end)
-		return false;
-
-	if (es.es_lblk > map->m_lblk) {
-		map->m_len = es.es_lblk - map->m_lblk;
-		return false;
-	}
-
-	offset = map->m_lblk - es.es_lblk;
-	map->m_len = es.es_len - offset;
-
-	return true;
-}
-
 static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 				   loff_t length, unsigned int flags,
 				   struct iomap *iomap, struct iomap *srcmap)
 {
 	int ret;
-	bool delalloc = false;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
 
@@ -3492,13 +3471,8 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	ret = ext4_map_blocks(NULL, inode, &map, 0);
 	if (ret < 0)
 		return ret;
-	if (ret == 0)
-		delalloc = ext4_iomap_is_delalloc(inode, &map);
-
 set_iomap:
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
-	if (delalloc && iomap->type == IOMAP_HOLE)
-		iomap->type = IOMAP_DELALLOC;
 
 	return 0;
 }
-- 
2.39.2


