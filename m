Return-Path: <linux-ext4+bounces-716-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14159824D75
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 04:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A99C1C21C8D
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 03:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383D4405;
	Fri,  5 Jan 2024 03:33:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF252440E
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T5pvD5DYpz4f3pJJ
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 11:33:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 741B31A0A77
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 11:33:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6hByeJdlyaRBFg--.23173S5;
	Fri, 05 Jan 2024 11:33:18 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 1/6] ext4: refactor ext4_da_map_blocks()
Date: Fri,  5 Jan 2024 11:30:13 +0800
Message-Id: <20240105033018.1665752-2-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDn6hByeJdlyaRBFg--.23173S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJr17JF15uw4DuryfZr4rAFb_yoW8uFy7pr
	9IkF93Wr1UXwnYgF4Iqr1UXF1fKa4YqrWDGrZ3Ww18Ary8AwnagFn8tF1fKa4rtrZ7ZF1Y
	qF4rKry5uw15GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUkPEfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Refactor and cleanup ext4_da_map_blocks(), reduce some unnecessary
parameters and branches, no logic changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 61277f7f8722..5b0d3075be12 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1704,7 +1704,6 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
 		if (ext4_es_is_hole(&es)) {
-			retval = 0;
 			down_read(&EXT4_I(inode)->i_data_sem);
 			goto add_delayed;
 		}
@@ -1749,26 +1748,9 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
 	else
 		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
-
-add_delayed:
-	if (retval == 0) {
-		int ret;
-
-		/*
-		 * XXX: __block_prepare_write() unmaps passed block,
-		 * is it OK?
-		 */
-
-		ret = ext4_insert_delayed_block(inode, map->m_lblk);
-		if (ret != 0) {
-			retval = ret;
-			goto out_unlock;
-		}
-
-		map_bh(bh, inode->i_sb, invalid_block);
-		set_buffer_new(bh);
-		set_buffer_delay(bh);
-	} else if (retval > 0) {
+	if (retval < 0)
+		goto out_unlock;
+	if (retval > 0) {
 		unsigned int status;
 
 		if (unlikely(retval != map->m_len)) {
@@ -1783,11 +1765,24 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status);
+		goto out_unlock;
 	}
 
+add_delayed:
+	/*
+	 * XXX: __block_prepare_write() unmaps passed block,
+	 * is it OK?
+	 */
+	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	if (retval)
+		goto out_unlock;
+
+	map_bh(bh, inode->i_sb, invalid_block);
+	set_buffer_new(bh);
+	set_buffer_delay(bh);
+
 out_unlock:
 	up_read((&EXT4_I(inode)->i_data_sem));
-
 	return retval;
 }
 
-- 
2.39.2


