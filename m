Return-Path: <linux-ext4+bounces-6200-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679B8A1905D
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F71D16B940
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4740212D81;
	Wed, 22 Jan 2025 11:11:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB6B211A18;
	Wed, 22 Jan 2025 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544294; cv=none; b=hL3R1i2CivCARSYII2y2msA4PzToNdU20YahuPgRItbWbeKld7kYc413daeE6O5Br15n8d6ED/O8GNAqZyekv0/hhsuMDtuw2b7hAqk3oyNvLi9PRL3alRIb1t7/GMGvSpDYNBG18JTr0wo+rPdZy93rvcjAoPyR17TRUfsW9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544294; c=relaxed/simple;
	bh=ImDwuIe9Xaysu9MKqTImGbsu1P8k133hSn/9pog8TEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCXtagZTs6A7a7F3UKTUx4FTHU5nWQ1VyJxr8O38NBJRZMmjpQ3fcpbVElI+KvKCKmFqtZnaPaeibvXURXCfGZulSZes7NOr1dcbf9fYoek7MCRwvfIrWkkrn/oq4iq5jm+2SW1STBIvpWZBu7LH9euvGEPX7ijr5FGLbXhoDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdLwr0h7vz4f3kvl;
	Wed, 22 Jan 2025 19:11:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F2A961A0BED;
	Wed, 22 Jan 2025 19:11:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAni19Z0pBnW0KsBg--.50502S13;
	Wed, 22 Jan 2025 19:11:29 +0800 (CST)
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
Subject: [PATCH v3 9/9] ext4: pack holes in ext4_inode_info
Date: Wed, 22 Jan 2025 19:05:33 +0800
Message-Id: <20250122110533.4116662-10-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250122110533.4116662-1-libaokun@huaweicloud.com>
References: <20250122110533.4116662-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni19Z0pBnW0KsBg--.50502S13
X-Coremail-Antispam: 1UD129KBjvJXoW7uF48Jr1kZrWkKryDAw1DKFg_yoW8Ar17pF
	9xKa4xGr40q34q9rW8GF45Zr1Iva1Igw47X3yDJw15uryDWryFgF48tF1FvFyYyFW8CFyS
	qF1jkr1UZw12y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAQBWeQpvkM-gAAsN

From: Baokun Li <libaokun1@huawei.com>

When CONFIG_DEBUG_SPINLOCK is not enabled (general case), there are four
4 bytes holes and one 2 bytes hole in struct ext4_inode_info. Move the
members to pack the four 4 bytes holes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index cde6a93a9a1d..550d21ddba8c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1062,6 +1062,8 @@ struct ext4_inode_info {
 	/* Number of ongoing updates on this inode */
 	atomic_t  i_fc_updates;
 
+	spinlock_t i_raw_lock;	/* protects updates to the raw inode */
+
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
 
@@ -1099,8 +1101,6 @@ struct ext4_inode_info {
 	struct inode vfs_inode;
 	struct jbd2_inode *jinode;
 
-	spinlock_t i_raw_lock;	/* protects updates to the raw inode */
-
 	/*
 	 * File creation time. Its function is same as that of
 	 * struct timespec64 i_{a,c,m}time in the generic inode.
@@ -1143,6 +1143,7 @@ struct ext4_inode_info {
 	/* quota space reservation, managed internally by quota code */
 	qsize_t i_reserved_quota;
 #endif
+	spinlock_t i_block_reservation_lock;
 
 	/* Lock protecting lists below */
 	spinlock_t i_completed_io_lock;
@@ -1153,8 +1154,6 @@ struct ext4_inode_info {
 	struct list_head i_rsv_conversion_list;
 	struct work_struct i_rsv_conversion_work;
 
-	spinlock_t i_block_reservation_lock;
-
 	/*
 	 * Transactions that contain inode's metadata needed to complete
 	 * fsync and fdatasync, respectively.
-- 
2.39.2


