Return-Path: <linux-ext4+bounces-722-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29078824D7C
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 04:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D001C21E1D
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 03:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C053AC;
	Fri,  5 Jan 2024 03:33:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89B4C81
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T5pvL12kZz4f3mWM
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 11:33:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E95DF1A0A2B
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 11:33:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6hByeJdlyaRBFg--.23173S9;
	Fri, 05 Jan 2024 11:33:19 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 5/6] ext4: make ext4_map_blocks() distinguish delalloc only extent
Date: Fri,  5 Jan 2024 11:30:17 +0800
Message-Id: <20240105033018.1665752-6-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDn6hByeJdlyaRBFg--.23173S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47Xw1xGw1DAFy8tr4Dtwb_yoW8tw4Dpa
	95GFyUGFs09w1q93yxGa1UJr1UKa48C3y7Cr4Yqr4F9F9xJr1ftF1q9F1fZFyYgrWxXFy5
	XF4Utw1UCa9IkrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add a new map flag EXT4_MAP_DELAYED to indicate the mapping range is a
delayed allocated only (not unwritten) one, and making
ext4_map_blocks() can distinguish it, no longer mixing it with holes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    | 4 +++-
 fs/ext4/extents.c | 7 +++++--
 fs/ext4/inode.c   | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a5d784872303..55195909d32f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -252,8 +252,10 @@ struct ext4_allocation_request {
 #define EXT4_MAP_MAPPED		BIT(BH_Mapped)
 #define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
 #define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
+#define EXT4_MAP_DELAYED	BIT(BH_Delay)
 #define EXT4_MAP_FLAGS		(EXT4_MAP_NEW | EXT4_MAP_MAPPED |\
-				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY)
+				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY |\
+				 EXT4_MAP_DELAYED)
 
 struct ext4_map_blocks {
 	ext4_fsblk_t m_pblk;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e0b7e48c4c67..6b64319a7df8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4076,8 +4076,11 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
 		/*
 		 * The delalloc extent containing lblk, it must have been
 		 * added after ext4_map_blocks() checked the extent status
-		 * tree, adjust the length to the delalloc extent's after
-		 * lblk.
+		 * tree so we are not holding i_rwsem and delalloc info is
+		 * only stabilized by i_data_sem we are going to release
+		 * soon. Don't modify the extent status tree and report
+		 * extent as a hole, just adjust the length to the delalloc
+		 * extent's after lblk.
 		 */
 		len = es.es_lblk + es.es_len - lblk;
 		return len;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1b5e6409f958..c141bf6d8db2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -515,6 +515,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			map->m_len = retval;
 		} else if (ext4_es_is_delayed(&es) || ext4_es_is_hole(&es)) {
 			map->m_pblk = 0;
+			map->m_flags |= ext4_es_is_delayed(&es) ?
+					EXT4_MAP_DELAYED : 0;
 			retval = es.es_len - (map->m_lblk - es.es_lblk);
 			if (retval > map->m_len)
 				retval = map->m_len;
-- 
2.39.2


