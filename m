Return-Path: <linux-ext4+bounces-6201-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B826A1905E
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A01886E36
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FA3212D8A;
	Wed, 22 Jan 2025 11:11:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70014211A08;
	Wed, 22 Jan 2025 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544294; cv=none; b=bp61ER0fOILAyGUtaL9p1DnmM7nLJKFygflo6nqceHwDEPjriu0XkAD1X38uQt1ZqmiXiCRIFS4GgA0Eu3SaZ0TSgM7uB1qemSxj9aBCHZ/V58LEbHT9GHxiQHOgwAP87DcNy9u3i7olkyuLWB8XzoXy6ewzQ0Nb3Qi8JhWFn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544294; c=relaxed/simple;
	bh=VaXVxGiosKKlIDR8yDpRO5hPwVLdl9nJXWXnj3yrWak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSjQGiDjT4i0ZZaIITFK2mzwp8DvvCMBHdRKsaYjajbbOeMfXEG4ipAgB0M4bFriJAHuDkXfM3PqfzY4TPPCeLqUcuF8sznf9l8Ps81LGPzXNVbnxN6G04fhw4SQBOBc/Ovjw+Q80m4cPks7sJduRZbqgSAH9WsQDbvbPjvNGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdLwq4pQKz4f3kvM;
	Wed, 22 Jan 2025 19:11:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8E3F61A16EA;
	Wed, 22 Jan 2025 19:11:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAni19Z0pBnW0KsBg--.50502S12;
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
Subject: [PATCH v3 8/9] ext4: remove unused member 'i_unwritten' from 'ext4_inode_info'
Date: Wed, 22 Jan 2025 19:05:32 +0800
Message-Id: <20250122110533.4116662-9-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni19Z0pBnW0KsBg--.50502S12
X-Coremail-Antispam: 1UD129KBjvJXoWxur1DArWxGF4UWrW5WF1kAFb_yoWrWw1kpF
	WakFy8GF4UXayq9397GFs7ZF1xtw1xKFWDXrW7GayUXasxuryFgF18tF1rAFyjvFWxAayx
	XF48CryUZr13GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAQBWeQpvkM-QAAsO

From: Baokun Li <libaokun1@huawei.com>

After commit 378f32bab371 ("ext4: introduce direct I/O write using iomap
infrastructure"), no one cares about the value of i_unwritten, so there
is no need to maintain this variable, remove it, and clean up the
associated logic.

Suggested-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  | 22 +++-------------------
 fs/ext4/inode.c |  2 +-
 fs/ext4/super.c |  9 +--------
 3 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0fed71beb906..cde6a93a9a1d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1061,7 +1061,6 @@ struct ext4_inode_info {
 
 	/* Number of ongoing updates on this inode */
 	atomic_t  i_fc_updates;
-	atomic_t i_unwritten; /* Nr. of inflight conversions pending */
 
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
@@ -3788,34 +3787,19 @@ static inline void set_bitmap_uptodate(struct buffer_head *bh)
 	set_bit(BH_BITMAP_UPTODATE, &(bh)->b_state);
 }
 
-/* For ioend & aio unwritten conversion wait queues */
-#define EXT4_WQ_HASH_SZ		37
-#define ext4_ioend_wq(v)   (&ext4__ioend_wq[((unsigned long)(v)) %\
-					    EXT4_WQ_HASH_SZ])
-extern wait_queue_head_t ext4__ioend_wq[EXT4_WQ_HASH_SZ];
-
 extern int ext4_resize_begin(struct super_block *sb);
 extern int ext4_resize_end(struct super_block *sb, bool update_backups);
 
-static inline void ext4_set_io_unwritten_flag(struct inode *inode,
-					      struct ext4_io_end *io_end)
+static inline void ext4_set_io_unwritten_flag(struct ext4_io_end *io_end)
 {
-	if (!(io_end->flag & EXT4_IO_END_UNWRITTEN)) {
+	if (!(io_end->flag & EXT4_IO_END_UNWRITTEN))
 		io_end->flag |= EXT4_IO_END_UNWRITTEN;
-		atomic_inc(&EXT4_I(inode)->i_unwritten);
-	}
 }
 
 static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 {
-	struct inode *inode = io_end->inode;
-
-	if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
+	if (io_end->flag & EXT4_IO_END_UNWRITTEN)
 		io_end->flag &= ~EXT4_IO_END_UNWRITTEN;
-		/* Wake up anyone waiting on unwritten extent conversion */
-		if (atomic_dec_and_test(&EXT4_I(inode)->i_unwritten))
-			wake_up_all(ext4_ioend_wq(inode));
-	}
 }
 
 extern const struct iomap_ops ext4_iomap_ops;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5fcbd4..36b1f9fb690a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2225,7 +2225,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
 			handle->h_rsv_handle = NULL;
 		}
-		ext4_set_io_unwritten_flag(inode, mpd->io_submit.io_end);
+		ext4_set_io_unwritten_flag(mpd->io_submit.io_end);
 	}
 
 	BUG_ON(map->m_len == 0);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87f5ab48b7f4..ca1ecafd48c5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1426,7 +1426,6 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	spin_lock_init(&ei->i_completed_io_lock);
 	ei->i_sync_tid = 0;
 	ei->i_datasync_tid = 0;
-	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	mutex_init(&ei->i_fc_lock);
@@ -7389,12 +7388,9 @@ static struct file_system_type ext4_fs_type = {
 };
 MODULE_ALIAS_FS("ext4");
 
-/* Shared across all ext4 file systems */
-wait_queue_head_t ext4__ioend_wq[EXT4_WQ_HASH_SZ];
-
 static int __init ext4_init_fs(void)
 {
-	int i, err;
+	int err;
 
 	ratelimit_state_init(&ext4_mount_msg_ratelimit, 30 * HZ, 64);
 	ext4_li_info = NULL;
@@ -7402,9 +7398,6 @@ static int __init ext4_init_fs(void)
 	/* Build-time check for flags consistency */
 	ext4_check_flag_values();
 
-	for (i = 0; i < EXT4_WQ_HASH_SZ; i++)
-		init_waitqueue_head(&ext4__ioend_wq[i]);
-
 	err = ext4_init_es();
 	if (err)
 		return err;
-- 
2.39.2


