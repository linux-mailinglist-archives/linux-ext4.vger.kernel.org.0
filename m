Return-Path: <linux-ext4+bounces-52-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9A87F2338
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 02:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875DE2822A7
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 01:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED284D522;
	Tue, 21 Nov 2023 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B8CC
	for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 17:40:42 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZ6X50CC9z4f3k6J
	for <linux-ext4@vger.kernel.org>; Tue, 21 Nov 2023 09:40:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AC90F1A0637
	for <linux-ext4@vger.kernel.org>; Tue, 21 Nov 2023 09:40:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA6MClxlGMf4BQ--.64879S8;
	Tue, 21 Nov 2023 09:40:39 +0800 (CST)
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
Subject: [RFC PATCH 4/6] ext4: add a hole extent entry in cache after punch
Date: Tue, 21 Nov 2023 17:34:27 +0800
Message-Id: <20231121093429.1827390-5-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3iA6MClxlGMf4BQ--.64879S8
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fWF47JF1xAr1rGr1UGFg_yoW8tr17pa
	sxAFy8Gr45W34q93yIgF4UZr12ya47G3yUXrWfKw10gry8Xr10yF1UtF13ZFy5tFW8Ja1Y
	vF4UKryUXa13ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
	wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
	IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHa0PU
	UUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In order to cache hole extents in the extent status tree and keep the
hole continuity as much as possible, add a hole entry to the cache after
punching a hole. It can reduce the 'hole' in some continuous hole extent
entries.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    | 3 +++
 fs/ext4/extents.c | 5 ++---
 fs/ext4/inode.c   | 2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9418359b1d9d..c2ca28c6ec38 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3681,6 +3681,9 @@ extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
 					     ext4_io_end_t *io_end);
 extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map, int flags);
+extern void ext4_ext_put_gap_in_cache(struct inode *inode,
+				      ext4_lblk_t hole_start,
+				      ext4_lblk_t hole_len);
 extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
 						   int num,
 						   struct ext4_ext_path *path);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 202c76996b62..52bad225e3c8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2275,9 +2275,8 @@ static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
  * calculate boundaries of the gap that the requested block fits into
  * and cache this gap
  */
-static void
-ext4_ext_put_gap_in_cache(struct inode *inode, ext4_lblk_t hole_start,
-			  ext4_lblk_t hole_len)
+void ext4_ext_put_gap_in_cache(struct inode *inode, ext4_lblk_t hole_start,
+			       ext4_lblk_t hole_len)
 {
 	struct extent_status es;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94e7b8500878..3908ce7f6fb8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4034,6 +4034,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 			ret = ext4_ind_remove_space(handle, inode, first_block,
 						    stop_block);
 
+		ext4_ext_put_gap_in_cache(inode, first_block,
+					  stop_block - first_block);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
 	ext4_fc_track_range(handle, inode, first_block, stop_block);
-- 
2.39.2


