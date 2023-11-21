Return-Path: <linux-ext4+bounces-54-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E07F233A
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 02:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AF2282332
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 01:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5D79EB;
	Tue, 21 Nov 2023 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C05BCF
	for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 17:40:42 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SZ6X63TXXz4f3kFq
	for <linux-ext4@vger.kernel.org>; Tue, 21 Nov 2023 09:40:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 16B461A08B2
	for <linux-ext4@vger.kernel.org>; Tue, 21 Nov 2023 09:40:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA6MClxlGMf4BQ--.64879S9;
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
Subject: [RFC PATCH 5/6] ext4: make ext4_map_blocks() distinguish delayed only mapping
Date: Tue, 21 Nov 2023 17:34:28 +0800
Message-Id: <20231121093429.1827390-6-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3iA6MClxlGMf4BQ--.64879S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47Xw1xXr15WFW7XFW5Jrb_yoW8XF4rpa
	s8GFy8GFs8Ww1Du3yIqa45XF1UK3Z2kw4UCrWYqr45ur9xJr1ftF1q9F4fAFWUKFWxXrWU
	XFy5Jw1rC3ZIkrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
	wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
	IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNZ2-
	UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add a new map flag EXT4_MAP_DELAYED to indicate the mapping range is a
delayed allocated only (not unwritten) one, and making
ext4_map_blocks() can distinguish it, no longer mixing it with holes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  | 4 +++-
 fs/ext4/inode.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c2ca28c6ec38..b5026090ad6f 100644
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
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3908ce7f6fb8..74b41566d31a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -518,6 +518,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
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


