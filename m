Return-Path: <linux-ext4+bounces-5801-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9BF9F8C74
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 07:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BFD18971E2
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 06:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061581A840E;
	Fri, 20 Dec 2024 06:11:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673319DF61;
	Fri, 20 Dec 2024 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675112; cv=none; b=bPOdWyDW6GjHGuNW6LHWj5UOluhCfZnC2Yv5lKigYvTroEJwXJx95fTDPRMLM62QSDxPEhbFFs8iBa8v3amrV4AZzpC12Ts6TEfOEdmm2QJB4RueGjavxj6mGWFkU6ueZeX7QjO3nmTyPvRDTRv7Z+P+xOj+lA9ygJLNHASpUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675112; c=relaxed/simple;
	bh=ueM1X/xSGjNBPS3ReWmEhuDW3GBKAd4aA2k7fghZO18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAWtIeJjQEJjn3uO06SB0KgO9017sBjbT470AWpnvg5gWW1U1QkYjMM3YmKn4hOiY89Fb3Ob1WP+/94SWBLRJSktFuJg/bSL0YNYO9o2IDqRSL7YuxiGTMHLjuRksydjE2pSZtA/IiXfywcx37zsJzFZI4aIvURtUliCPbfRx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YDxrH3CLvz4f3jsC;
	Fri, 20 Dec 2024 14:11:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 049901A06D7;
	Fri, 20 Dec 2024 14:11:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoKeCmVn6SRyFA--.26943S9;
	Fri, 20 Dec 2024 14:11:46 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 5/5] ext4: pack holes in ext4_inode_info
Date: Fri, 20 Dec 2024 14:07:57 +0800
Message-Id: <20241220060757.1781418-6-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241220060757.1781418-1-libaokun@huaweicloud.com>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3XoKeCmVn6SRyFA--.26943S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uF48Jr1kZrWkKFW5WFy7trb_yoW8WrW8pF
	98K34xGr40q3yq9rW8GF45Zr1Sva1Sgw47Jw4DJw45uryUWr1FqF4ktF1FvFyY9FWxCFyS
	vF1UKryUZ3W2y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7
	CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUbT7KDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWdkCnU2wwAAsO

From: Baokun Li <libaokun1@huawei.com>

When CONFIG_DEBUG_SPINLOCK is not enabled (general case), there are four
4 bytes holes and one 2 bytes hole in struct ext4_inode_info. Move the
members to pack the four 4 bytes holes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 203a900fd789..345dda2310d0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1060,6 +1060,8 @@ struct ext4_inode_info {
 	/* Number of ongoing updates on this inode */
 	atomic_t  i_fc_updates;
 
+	spinlock_t i_raw_lock;	/* protects updates to the raw inode */
+
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
 
@@ -1097,8 +1099,6 @@ struct ext4_inode_info {
 	struct inode vfs_inode;
 	struct jbd2_inode *jinode;
 
-	spinlock_t i_raw_lock;	/* protects updates to the raw inode */
-
 	/*
 	 * File creation time. Its function is same as that of
 	 * struct timespec64 i_{a,c,m}time in the generic inode.
@@ -1141,6 +1141,7 @@ struct ext4_inode_info {
 	/* quota space reservation, managed internally by quota code */
 	qsize_t i_reserved_quota;
 #endif
+	spinlock_t i_block_reservation_lock;
 
 	/* Lock protecting lists below */
 	spinlock_t i_completed_io_lock;
@@ -1151,8 +1152,6 @@ struct ext4_inode_info {
 	struct list_head i_rsv_conversion_list;
 	struct work_struct i_rsv_conversion_work;
 
-	spinlock_t i_block_reservation_lock;
-
 	/*
 	 * Transactions that contain inode's metadata needed to complete
 	 * fsync and fdatasync, respectively.
-- 
2.46.1


