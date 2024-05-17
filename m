Return-Path: <linux-ext4+bounces-2559-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3018C869E
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2024 14:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94379283FF0
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2024 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658AA6A8BE;
	Fri, 17 May 2024 12:51:09 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B35DF3B;
	Fri, 17 May 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950269; cv=none; b=n9YvyV4zbY9i2KC6cD45egpA6bOJjq0nMqEUlFlE/gq4aw+jtq1jk8gddo4UH5cXE2p3TL8YaJ3VaNMIYZyfpmTIqOoHiUdZfHmCwCYodkKt0H/2hmgoP6t6qZxTZrGik6XEcEC1OSuefFiw/9qAkKwjI5c37KM3lQSflXuzhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950269; c=relaxed/simple;
	bh=hzG3rlIBvdTJiMamFuzYj+xoY3L/r3/1QqUeMtzgGp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bd644/abd3sgBEsziawY7ToquQRGipdeSuBKkqpym+gdMn9vVM08P99xLLMjeIiWXQI1ok8s+SDIWlWlTFTdcqkzjoVqAWTcs2yI737JCy3YznFKH8xRyFelTtqy+jsx1rnCkVOlfUwEtkWda85gFxye4S342zoxD49zIseQz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VgmzF55YQz4f3jdq;
	Fri, 17 May 2024 20:50:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 732861A016E;
	Fri, 17 May 2024 20:50:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGdUkdmdAmqMw--.14380S12;
	Fri, 17 May 2024 20:50:58 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v5 08/10] ext4: factor out a helper to check the cluster allocation state
Date: Fri, 17 May 2024 20:40:03 +0800
Message-Id: <20240517124005.347221-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBGdUkdmdAmqMw--.14380S12
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW5Cr43KFyruF4xtw1DZFb_yoW8tw1xpr
	ZxGFWSgFsxWr97WF4SqrnrXr1Fgay0qrWDJrW293WxZrnxCF1YkF1qkF1rXFyrKrW8JFs0
	qFWUAryUua1jka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU17G
	YJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Factor out a common helper ext4_clu_alloc_state(), check whether the
cluster containing a delalloc block to be added has been allocated or
has delalloc reservation, no logic changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 55 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0c52969654ac..eefedb7264c7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1649,6 +1649,35 @@ static void ext4_print_free_blocks(struct inode *inode)
 	return;
 }
 
+/*
+ * Check whether the cluster containing lblk has been allocated or has
+ * delalloc reservation.
+ *
+ * Returns 0 if the cluster doesn't have either, 1 if it has delalloc
+ * reservation, 2 if it's already been allocated, negative error code on
+ * failure.
+ */
+static int ext4_clu_alloc_state(struct inode *inode, ext4_lblk_t lblk)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	int ret;
+
+	/* Has delalloc reservation? */
+	if (ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk))
+		return 1;
+
+	/* Already been allocated? */
+	if (ext4_es_scan_clu(inode, &ext4_es_is_mapped, lblk))
+		return 2;
+	ret = ext4_clu_mapped(inode, EXT4_B2C(sbi, lblk));
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return 2;
+
+	return 0;
+}
+
 /*
  * ext4_insert_delayed_block - adds a delayed block to the extents status
  *                             tree, incrementing the reserved cluster/block
@@ -1682,23 +1711,15 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		if (ret != 0)   /* ENOSPC */
 			return ret;
 	} else {   /* bigalloc */
-		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
-			if (!ext4_es_scan_clu(inode,
-					      &ext4_es_is_mapped, lblk)) {
-				ret = ext4_clu_mapped(inode,
-						      EXT4_B2C(sbi, lblk));
-				if (ret < 0)
-					return ret;
-				if (ret == 0) {
-					ret = ext4_da_reserve_space(inode, 1);
-					if (ret != 0)   /* ENOSPC */
-						return ret;
-				} else {
-					allocated = true;
-				}
-			} else {
-				allocated = true;
-			}
+		ret = ext4_clu_alloc_state(inode, lblk);
+		if (ret < 0)
+			return ret;
+		if (ret == 2)
+			allocated = true;
+		if (ret == 0) {
+			ret = ext4_da_reserve_space(inode, 1);
+			if (ret != 0)   /* ENOSPC */
+				return ret;
 		}
 	}
 
-- 
2.39.2


