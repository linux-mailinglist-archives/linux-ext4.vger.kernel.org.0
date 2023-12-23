Return-Path: <linux-ext4+bounces-550-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C246081D3AC
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 12:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522F32841CE
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806F9CA53;
	Sat, 23 Dec 2023 11:04:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF76C14B
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sy1X32lGfz4f3kFB
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 19:04:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 456921A01C1
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 19:04:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDX5UW6voZlWeceEg--.27538S8;
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
Subject: [RFC PATCH v2 4/6] ext4: add a hole extent entry in cache after punch
Date: Sat, 23 Dec 2023 19:02:21 +0800
Message-Id: <20231223110223.3650717-5-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDX5UW6voZlWeceEg--.27538S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1kWr18uFyUXFy5GFykZrb_yoW8Gw1xp3
	98Ca4Sgrn5W34kuan7XFWUXr1293WUGr4UXrW29w1xWFyUA3WIgFn09F43Z3W8KrW7Xw4F
	qF48KryY9w1Uu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In order to cache hole extents in the extent status tree and keep the
hole length as long as possible, re-add a hole entry to the cache just
after punching a hole.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 142c67f5c7fc..1b5e6409f958 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4000,12 +4000,12 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	/* If there are blocks to remove, do it */
 	if (stop_block > first_block) {
+		ext4_lblk_t hole_len = stop_block - first_block;
 
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode, 0);
 
-		ext4_es_remove_extent(inode, first_block,
-				      stop_block - first_block);
+		ext4_es_remove_extent(inode, first_block, hole_len);
 
 		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 			ret = ext4_ext_remove_space(inode, first_block,
@@ -4014,6 +4014,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 			ret = ext4_ind_remove_space(handle, inode, first_block,
 						    stop_block);
 
+		ext4_es_insert_extent(inode, first_block, hole_len, ~0,
+				      EXTENT_STATUS_HOLE);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
 	ext4_fc_track_range(handle, inode, first_block, stop_block);
-- 
2.39.2


