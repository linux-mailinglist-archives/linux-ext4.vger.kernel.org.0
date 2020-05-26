Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAED31E1BFF
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgEZHTT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 May 2020 03:19:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4897 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbgEZHTS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 May 2020 03:19:18 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0D39761D8F65E44BF83F;
        Tue, 26 May 2020 15:19:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 15:19:08 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 03/10] ext4: add ext4_sb_getblk*() wrapper functions
Date:   Tue, 26 May 2020 15:17:47 +0800
Message-ID: <20200526071754.33819-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526071754.33819-1-yi.zhang@huawei.com>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For most cases of reading metadata block, we invoke sb_getblk() to get
bh and check the uptodate flag, and then lock buffer and submit bio to
read block data from disk if it isn't uptodate, finally return bh if
read successfully. But if the buffer return from sb_getblk() is
!uptodate and has write io error flag, it means that it has been failed
to write out but the metadata in this buffer is still uptodate, we
should avoid subsequent read to prevent potential inconsistency since
we may read old metadata successfully.

Now, we have already deal with it in some places, such as
__ext4_get_inode_loc() and commit 7963e5ac90125 ("ext4: treat buffers
with write errors as containing valid data"), but it's not enough.

This patch add ext4_sb_getblk*() wrapper function to check the buffer
is actually uptodate re-add the uptodate flag if it has write io error
flag, preparing to replace all sb_getblk*() to handle all the read
metadata cases.

 - ext4_sb_getblk(): works the same as sb_getblk(), preparing to replace
   all sb_getblk(). It is will be used for newly allocated blocks and
   the cases of getting buffers for write.
 - ext4_sb_getblk_locked(): works the same as sb_getblk() except check &
   fix buffer uotpdate flag, preparing to replace all sb_getblk(). It
   will be used for the cases of getting buffers for read.
 - ext4_sb_getblk_gfp(): gfp version of ext4_sb_getblk().
 - ext4_sb_getblk_locked_gfp(): gfp version of ext4_sb_getblk_locked().

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  | 29 +++++++++++++++++++++++++++
 fs/ext4/super.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..2ee76efd029b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2758,6 +2758,11 @@ extern int ext4_group_extend(struct super_block *sb,
 extern int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count);
 
 /* super.c */
+extern struct buffer_head *__ext4_sb_getblk_gfp(struct super_block *sb,
+						sector_t block, bool lock,
+						gfp_t gfp);
+extern struct buffer_head *__ext4_sb_getblk(struct super_block *sb,
+					     sector_t block, bool lock);
 extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 					 sector_t block, int op_flags);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
@@ -2940,6 +2945,30 @@ extern void ext4_group_desc_csum_set(struct super_block *sb, __u32 group,
 extern int ext4_register_li_request(struct super_block *sb,
 				    ext4_group_t first_not_zeroed);
 
+static inline struct buffer_head *
+ext4_sb_getblk_gfp(struct super_block *sb, sector_t block, gfp_t gfp)
+{
+	return __ext4_sb_getblk_gfp(sb, block, false, gfp);
+}
+
+static inline struct buffer_head *
+ext4_sb_getblk_locked_gfp(struct super_block *sb, sector_t block, gfp_t gfp)
+{
+	return __ext4_sb_getblk_gfp(sb, block, true, gfp);
+}
+
+static inline struct buffer_head *
+ext4_sb_getblk(struct super_block *sb, sector_t block)
+{
+	return __ext4_sb_getblk(sb, block, false);
+}
+
+static inline struct buffer_head *
+ext4_sb_getblk_locked(struct super_block *sb, sector_t block)
+{
+	return __ext4_sb_getblk(sb, block, true);
+}
+
 static inline int ext4_has_metadata_csum(struct super_block *sb)
 {
 	WARN_ON_ONCE(ext4_has_feature_metadata_csum(sb) &&
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bf5fcb477f66..ddc46dbcd5ce 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -141,6 +141,58 @@ MODULE_ALIAS_FS("ext3");
 MODULE_ALIAS("ext3");
 #define IS_EXT3_SB(sb) ((sb)->s_bdev->bd_holder == &ext3_fs_type)
 
+/**
+ * __ext4_sb_getblk_gfp
+ * @sb: super block
+ * @block: number of meta block
+ * @lock: check the buffer uptodate flag and lock it if it's actually not
+ *        uptodate, use for the case of caller will read metadata from
+ *        disk immediately if the buffer is not uptodate.
+ * @gfp: allocation flag
+ *
+ * __ext4_sb_getblk_gfp() works like __getblk_gfp() except it add @lock
+ * to check the buffer write io error flag, it keep the buffer locked if
+ * it is not uptodate. If the buffer is not uptodate && has write_io_error
+ * flag, it means that the buffer has been failed to write out but the
+ * metadata in this buffer is still uptodate. So for the most read block
+ * cases, we should avoid the subsequent reading operation to prevent
+ * potential inconsistency since it may read old metadata from disk
+ * successfully.
+ */
+struct buffer_head *
+__ext4_sb_getblk_gfp(struct super_block *sb, sector_t block,
+		     bool lock, gfp_t gfp)
+{
+	struct buffer_head *bh = sb_getblk_gfp(sb, block, gfp);
+
+	if (unlikely(!bh))
+		return NULL;
+	/*
+	 * Keep the buffer locked if buffer isn't uptodate and the 'lock'
+	 * specified, use for the case of caller will read from disk
+	 * immediately if the buffer is not uptodate.
+	 */
+	if (lock && !bh_uptodate_or_lock(bh)) {
+		/*
+		 * If the buffer has the write error flag, we have failed
+		 * to write out this metadata block. In this case, we
+		 * don't have to read the block because we may read the
+		 * old metadata successfully.
+		 */
+		if (buffer_write_io_error(bh)) {
+			set_buffer_uptodate(bh);
+			unlock_buffer(bh);
+		}
+	}
+	return bh;
+}
+
+struct buffer_head *
+__ext4_sb_getblk(struct super_block *sb, sector_t block, bool lock)
+{
+	return __ext4_sb_getblk_gfp(sb, block, lock, __GFP_MOVABLE);
+}
+
 /*
  * This works like sb_bread() except it uses ERR_PTR for error
  * returns.  Currently with sb_bread it's impossible to distinguish
-- 
2.21.3

