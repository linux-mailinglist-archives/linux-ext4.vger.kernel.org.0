Return-Path: <linux-ext4+bounces-6162-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A15A1787E
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 08:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EFC3AC6B9
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4C31BEF95;
	Tue, 21 Jan 2025 07:16:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76431B87F0;
	Tue, 21 Jan 2025 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443803; cv=none; b=kpYGea2XG9cNGjtP9p3/UdnjGKs8V/Sb/yhdCm7KROKqdrfObjum4FXFt24OkyjKutATJvGTXyzatzBuTf7Z4GlfincwuNVdk4s+76gwdAwWG2LXR+5wKH0Jpzq3zoS8qxWxpSPQJtbpfhYHco5xQFeG9UTb1avuOzcpCPj4ecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443803; c=relaxed/simple;
	bh=FQVlNxKEM37oYtJglnt6N+2h7JkbjCYdJY21cDdHci8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJoqmYuUbj8RZq8I9TV0X+g4+NbGsz9km09ivPSs5XgKbXb/W/XPGeFET84mOJJ+QijF7cNQXXQ9Usqp5fCnMAB57RR6liSJP447zsHuMR49cyY39nEwZt7ltMLb6zQgTN5UadE+dQIIvSXQGi4EwYRR/WSo83rCmj51nml5zF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YcdmR3bFXz4f3jqy;
	Tue, 21 Jan 2025 15:16:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E23FC1A17D8;
	Tue, 21 Jan 2025 15:16:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2DNSY9n3Gg+Bg--.34135S12;
	Tue, 21 Jan 2025 15:16:38 +0800 (CST)
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
Subject: [PATCH v2 8/8] ext4: pack holes in ext4_inode_info
Date: Tue, 21 Jan 2025 15:10:50 +0800
Message-Id: <20250121071050.3991249-9-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250121071050.3991249-1-libaokun@huaweicloud.com>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2DNSY9n3Gg+Bg--.34135S12
X-Coremail-Antispam: 1UD129KBjvJXoW7uF48Jr1kZF1UJryUCrWruFg_yoW8Ar17pF
	98Ka4xGr40q3yq9rW8GF45Zr1Iva1Igw47X3yDJw45uryqg34FgF4xtF1FvFyYyFW8CFyI
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAPBWeOA-NKzQABsU

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
index 6fd550fc0c5c..c1693ba836ee 100644
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


