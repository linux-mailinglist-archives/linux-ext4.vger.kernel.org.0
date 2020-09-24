Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D78276AD6
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 09:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgIXHcx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 03:32:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727120AbgIXHcv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 03:32:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 77E937663FDE5E3C7B15;
        Thu, 24 Sep 2020 15:32:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 15:32:38 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2 2/7] ext4: introduce new metadata buffer read helpers
Date:   Thu, 24 Sep 2020 15:33:32 +0800
Message-ID: <20200924073337.861472-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200924073337.861472-1-yi.zhang@huawei.com>
References: <20200924073337.861472-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The previous patch add clear_buffer_verified() before we read metadata
block from disk again, but it's rather easy to miss clearing of this bit
because currently we read metadata buffer through different open codes
(e.g. ll_rw_block(), bh_submit_read() and invoke submit_bh() directly).
So, it's time to add common helpers to unify in all the places reading
metadata buffers instead. This patch add 3 helpers:

 - ext4_read_bh_nowait(): async read metadata buffer if it's actually
   not uptodate, clear buffer_verified bit before read from disk.
 - ext4_read_bh(): sync version of read metadata buffer, it will wait
   until the read operation return and check the return status.
 - ext4_read_bh_lock(): try to lock the buffer before read buffer, it
   will skip reading if the buffer is already locked.

After this patch, we need to use these helpers in all the places reading
metadata buffer instead of different open codes.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  5 ++++
 fs/ext4/super.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 523e00d7b392..75b46300a65c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2824,6 +2824,11 @@ extern int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count);
 /* super.c */
 extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 					 sector_t block, int op_flags);
+extern void ext4_read_bh_nowait(struct buffer_head *bh, int op_flags,
+				bh_end_io_t *end_io);
+extern int ext4_read_bh(struct buffer_head *bh, int op_flags,
+			bh_end_io_t *end_io);
+extern int ext4_read_bh_lock(struct buffer_head *bh, int op_flags, bool wait);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
 extern int ext4_calculate_overhead(struct super_block *sb);
 extern void ext4_superblock_csum_set(struct super_block *sb);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9e760bf9e8b1..1b1a4ca00957 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -141,6 +141,68 @@ MODULE_ALIAS_FS("ext3");
 MODULE_ALIAS("ext3");
 #define IS_EXT3_SB(sb) ((sb)->s_bdev->bd_holder == &ext3_fs_type)
 
+
+static inline void __ext4_read_bh(struct buffer_head *bh, int op_flags,
+				  bh_end_io_t *end_io)
+{
+	/*
+	 * buffer's verified bit is no longer valid after reading from
+	 * disk again due to write out error, clear it to make sure we
+	 * recheck the buffer contents.
+	 */
+	clear_buffer_verified(bh);
+
+	bh->b_end_io = end_io ? end_io : end_buffer_read_sync;
+	get_bh(bh);
+	submit_bh(REQ_OP_READ, op_flags, bh);
+}
+
+void ext4_read_bh_nowait(struct buffer_head *bh, int op_flags,
+			 bh_end_io_t *end_io)
+{
+	BUG_ON(!buffer_locked(bh));
+
+	if (ext4_buffer_uptodate(bh)) {
+		unlock_buffer(bh);
+		return;
+	}
+	__ext4_read_bh(bh, op_flags, end_io);
+}
+
+int ext4_read_bh(struct buffer_head *bh, int op_flags, bh_end_io_t *end_io)
+{
+	BUG_ON(!buffer_locked(bh));
+
+	if (ext4_buffer_uptodate(bh)) {
+		unlock_buffer(bh);
+		return 0;
+	}
+
+	__ext4_read_bh(bh, op_flags, end_io);
+
+	wait_on_buffer(bh);
+	if (buffer_uptodate(bh))
+		return 0;
+	return -EIO;
+}
+
+int ext4_read_bh_lock(struct buffer_head *bh, int op_flags, bool wait)
+{
+	if (trylock_buffer(bh)) {
+		if (wait)
+			return ext4_read_bh(bh, op_flags, NULL);
+		ext4_read_bh_nowait(bh, op_flags, NULL);
+		return 0;
+	}
+	if (wait) {
+		wait_on_buffer(bh);
+		if (buffer_uptodate(bh))
+			return 0;
+		return -EIO;
+	}
+	return 0;
+}
+
 /*
  * This works like sb_bread() except it uses ERR_PTR for error
  * returns.  Currently with sb_bread it's impossible to distinguish
-- 
2.25.4

