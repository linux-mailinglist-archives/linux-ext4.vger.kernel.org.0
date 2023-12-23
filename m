Return-Path: <linux-ext4+bounces-556-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7E81D3B2
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 12:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220A91C214B4
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A908DD2F2;
	Sat, 23 Dec 2023 11:04:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DCD265
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sy1X546Kjz4f3jqt
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 19:04:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 075391A05D4
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 19:04:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDX5UW6voZlWeceEg--.27538S10;
	Sat, 23 Dec 2023 19:04:38 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH v2 6/6] ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC map type
Date: Sat, 23 Dec 2023 19:02:23 +0800
Message-Id: <20231223110223.3650717-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223110223.3650717-1-yi.zhang@huaweicloud.com>
References: <20231223110223.3650717-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDX5UW6voZlWeceEg--.27538S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1kKFWkAr45AF4UCrW7Arb_yoW8tFW8pa
	9xKFy7GF43Xr1jgr48trW7Zr1ak3WUK3y2grWfG3s5Cr10yry8tF48CF1ayF90qrWxZw1S
	qF4jkr18Wa1SyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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


