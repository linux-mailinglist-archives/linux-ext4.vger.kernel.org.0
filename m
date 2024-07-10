Return-Path: <linux-ext4+bounces-3149-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7BB92C986
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6261F23E45
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 04:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF98482C8;
	Wed, 10 Jul 2024 04:09:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FB15D1;
	Wed, 10 Jul 2024 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584556; cv=none; b=BC45zDeYIpF94txhsssNdbwMXB2bBvTJI6XqfueODG28fzG9iaLKlfO4Rqr7vKu+MyHorBoK4sTPCZJbYsdZCZbpvblAy7sHeqP9VEL8VQ1QN0GscNXO5bZxSfLwrUNP/x8ZmqqiWn8V7eFkFPYFAjmWSUnpMoQvsFbw+u9YSW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584556; c=relaxed/simple;
	bh=gwRcVK2dLKOaYtOn17+khUsO6T+UH8dmKwhGcmf0u1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JAzWkdR38HWZzQS5y7cBf8UZEU2WrURdi6BfEBo6eA/zNmNpCjL6SLXsT8I/iQR6VbvobpP5sosgBslDEgZ+j21pecM3VUpcH8CfrcBDNHCRfvCwTQzLVq0U3pJFGQpL++kS3c6TLwBb7Ql+X+KG6NVTV/mOo3Yx3QMa66xtNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WJkr564hLz4f3mJX;
	Wed, 10 Jul 2024 12:08:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 761C11A0189;
	Wed, 10 Jul 2024 12:09:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIZdCY5mkoy3Bg--.14986S6;
	Wed, 10 Jul 2024 12:09:05 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>,
	zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH 02/20] ext4: prevent partial update of the extents path
Date: Wed, 10 Jul 2024 12:06:36 +0800
Message-Id: <20240710040654.1714672-3-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710040654.1714672-1-libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAIZdCY5mkoy3Bg--.14986S6
X-Coremail-Antispam: 1UD129KBjvJXoW7KF15tFWUJF15Jr4ftF4DCFg_yoW5JF1xpr
	nIkrn5Gr48Way3uFW3tFWUZFy3K3Wkuw4xGrWxC343WFy5ZryFqryxKF13CFyrJrWxWa4f
	XrW8tw1UKw1DGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
	yTuYvjfU1GQDUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAPBV1jkIIt0wAEsd

From: Baokun Li <libaokun1@huawei.com>

In ext4_ext_rm_idx() and ext4_ext_correct_indexes(), there is no proper
rollback of already executed updates when updating a level of the extents
path fails, so we may get an inconsistent extents tree, which may trigger
some bad things in errors=continue mode.

Hence clear the verified bit of modified extents buffers if the tree fails
to be updated in ext4_ext_rm_idx() or ext4_ext_correct_indexes(), which
forces the extents buffers to be checked in ext4_valid_extent_entries(),
ensuring that the extents tree is consistent.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Link: https://lore.kernel.org/r/20230213080514.535568-3-zhanchengbin1@huawei.com/
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index bff3666c891a..4d589d34b30e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1749,12 +1749,23 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 			break;
 		err = ext4_ext_get_access(handle, inode, path + k);
 		if (err)
-			break;
+			goto clean;
 		path[k].p_idx->ei_block = border;
 		err = ext4_ext_dirty(handle, inode, path + k);
 		if (err)
-			break;
+			goto clean;
 	}
+	return 0;
+
+clean:
+	/*
+	 * The path[k].p_bh is either unmodified or with no verified bit
+	 * set (see ext4_ext_get_access()). So just clear the verified bit
+	 * of the successfully modified extents buffers, which will force
+	 * these extents to be checked to avoid using inconsistent data.
+	 */
+	while (++k < depth)
+		clear_buffer_verified(path[k].p_bh);
 
 	return err;
 }
@@ -2312,12 +2323,24 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
 			break;
 		err = ext4_ext_get_access(handle, inode, path + k);
 		if (err)
-			break;
+			goto clean;
 		path[k].p_idx->ei_block = path[k + 1].p_idx->ei_block;
 		err = ext4_ext_dirty(handle, inode, path + k);
 		if (err)
-			break;
+			goto clean;
 	}
+	return 0;
+
+clean:
+	/*
+	 * The path[k].p_bh is either unmodified or with no verified bit
+	 * set (see ext4_ext_get_access()). So just clear the verified bit
+	 * of the successfully modified extents buffers, which will force
+	 * these extents to be checked to avoid using inconsistent data.
+	 */
+	while (++k < depth)
+		clear_buffer_verified(path[k].p_bh);
+
 	return err;
 }
 
-- 
2.39.2


