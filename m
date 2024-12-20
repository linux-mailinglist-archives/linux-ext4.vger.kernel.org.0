Return-Path: <linux-ext4+bounces-5798-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A906C9F8C6F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 07:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0045016ABA2
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 06:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8A1A42C4;
	Fri, 20 Dec 2024 06:11:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E2198823;
	Fri, 20 Dec 2024 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675111; cv=none; b=Ndi8XRw593tTIN4egbgR0bBKH3M24xpe5L4rSJJhNL7KGjArQg5nTpxoxWAChTG4qqJHcZ0vHvsKx5E+rDdc0cDkFLNVw7Ezw1WXdsb/3wTBSn2zkbxi8rax6UCQrCru2Owt0xpc8n6ME8/ZGFc5E5kqFetsrU/FoXvhhOz7UOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675111; c=relaxed/simple;
	bh=CDsugzs9fMErtron0AUYuJv0qUoJmjRYH6VU5AQkHJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZukUQ0txqNBONNRS0/g0tOxZRTGN2qComz3YlstLfJPhHYwyYKygz4r3nD6/hCAx0i+admk089IVUz6wzYCJRsmbWS6flWtDDlWr6T4t6fKOeFB8zz9Ju43DrajRcvHsEeX/TVwrMTW/hygJ3FujgEyuSNr9+FN+AMeB5mPADes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YDxrG0810z4f3l2C;
	Fri, 20 Dec 2024 14:11:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9A9271A0359;
	Fri, 20 Dec 2024 14:11:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoKeCmVn6SRyFA--.26943S8;
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
Subject: [PATCH 4/5] ext4: remove unused member 'i_unwritten' from 'ext4_inode_info'
Date: Fri, 20 Dec 2024 14:07:56 +0800
Message-Id: <20241220060757.1781418-5-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgA3XoKeCmVn6SRyFA--.26943S8
X-Coremail-Antispam: 1UD129KBjvJXoWxur1DArWxGw1fXw4UtF13urg_yoWrWr43pF
	WakFy8GF47Xa4qg397GFs7ZF1xtw1xKFWDXry7GayUXasxuryFgF1rtFy5AFyjvFWxAayx
	XF48CryUZr13CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7
	CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
	yTuYvjfUYl19UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWdkCqk2IQAAsz

From: Baokun Li <libaokun1@huawei.com>

After commit 378f32bab371 ("ext4: introduce direct I/O write using iomap
infrastructure"), no one cares about the value of i_unwritten, so there
is no need to maintain this variable, remove it, and clean up the
associated logic.

Suggested-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h  | 22 +++-------------------
 fs/ext4/inode.c |  2 +-
 fs/ext4/super.c |  9 +--------
 3 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9da0e32af02a..203a900fd789 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1059,7 +1059,6 @@ struct ext4_inode_info {
 
 	/* Number of ongoing updates on this inode */
 	atomic_t  i_fc_updates;
-	atomic_t i_unwritten; /* Nr. of inflight conversions pending */
 
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
@@ -3786,34 +3785,19 @@ static inline void set_bitmap_uptodate(struct buffer_head *bh)
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
index a50e5c31b937..853997655e40 100644
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
@@ -7381,12 +7380,9 @@ static struct file_system_type ext4_fs_type = {
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
@@ -7394,9 +7390,6 @@ static int __init ext4_init_fs(void)
 	/* Build-time check for flags consistency */
 	ext4_check_flag_values();
 
-	for (i = 0; i < EXT4_WQ_HASH_SZ; i++)
-		init_waitqueue_head(&ext4__ioend_wq[i]);
-
 	err = ext4_init_es();
 	if (err)
 		return err;
-- 
2.46.1


