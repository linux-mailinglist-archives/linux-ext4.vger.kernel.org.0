Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E3C276AD3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgIXHcx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 03:32:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727149AbgIXHcv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 03:32:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ABBD7E8135C0223BE7D2;
        Thu, 24 Sep 2020 15:32:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 15:32:38 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2 3/7] ext4: use common helpers in all places reading metadata buffers
Date:   Thu, 24 Sep 2020 15:33:33 +0800
Message-ID: <20200924073337.861472-4-yi.zhang@huawei.com>
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

Revome all open codes that read metadata buffers, switch to use
ext4_read_bh_*() common helpers.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/balloc.c      |  8 +++-----
 fs/ext4/extents.c     |  3 +--
 fs/ext4/ialloc.c      |  6 +-----
 fs/ext4/indirect.c    |  2 +-
 fs/ext4/inode.c       | 35 ++++++++++++++---------------------
 fs/ext4/mmp.c         | 10 +++-------
 fs/ext4/move_extent.c |  2 +-
 fs/ext4/resize.c      |  2 +-
 fs/ext4/super.c       | 22 +++++++++++-----------
 9 files changed, 36 insertions(+), 54 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8e7e9715cde9..dea738ba2acd 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -494,12 +494,10 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 	 * submit the buffer_head for reading
 	 */
 	set_buffer_new(bh);
-	clear_buffer_verified(bh);
 	trace_ext4_read_block_bitmap_load(sb, block_group, ignore_locked);
-	bh->b_end_io = ext4_end_bitmap_read;
-	get_bh(bh);
-	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO |
-		  (ignore_locked ? REQ_RAHEAD : 0), bh);
+	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO |
+			    (ignore_locked ? REQ_RAHEAD : 0),
+			    ext4_end_bitmap_read);
 	return bh;
 verify:
 	err = ext4_validate_block_bitmap(sb, desc, block_group, bh);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0a5205edc00a..7cc202dcf083 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -501,8 +501,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
 
 	if (!bh_uptodate_or_lock(bh)) {
 		trace_ext4_ext_load_extent(inode, pblk, _RET_IP_);
-		clear_buffer_verified(bh);
-		err = bh_submit_read(bh);
+		err = ext4_read_bh(bh, 0, NULL);
 		if (err < 0)
 			goto errout;
 	}
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 20cda952c621..33c0fc0197ce 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -188,12 +188,8 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 	/*
 	 * submit the buffer_head for reading
 	 */
-	clear_buffer_verified(bh);
 	trace_ext4_load_inode_bitmap(sb, block_group);
-	bh->b_end_io = ext4_end_bitmap_read;
-	get_bh(bh);
-	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
-	wait_on_buffer(bh);
+	ext4_read_bh(bh, REQ_META | REQ_PRIO, ext4_end_bitmap_read);
 	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_IBITMAP_EIO);
 	if (!buffer_uptodate(bh)) {
 		put_bh(bh);
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 80c9f33800be..4d7656f4ebc3 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -163,7 +163,7 @@ static Indirect *ext4_get_branch(struct inode *inode, int depth,
 		}
 
 		if (!bh_uptodate_or_lock(bh)) {
-			if (bh_submit_read(bh) < 0) {
+			if (ext4_read_bh(bh, 0, NULL) < 0) {
 				put_bh(bh);
 				goto failure;
 			}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7eaa55651d29..3661ed126c5f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -878,19 +878,20 @@ struct buffer_head *ext4_bread(handle_t *handle, struct inode *inode,
 			       ext4_lblk_t block, int map_flags)
 {
 	struct buffer_head *bh;
+	int ret;
 
 	bh = ext4_getblk(handle, inode, block, map_flags);
 	if (IS_ERR(bh))
 		return bh;
 	if (!bh || ext4_buffer_uptodate(bh))
 		return bh;
-	clear_buffer_verified(bh);
-	ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1, &bh);
-	wait_on_buffer(bh);
-	if (buffer_uptodate(bh))
-		return bh;
-	put_bh(bh);
-	return ERR_PTR(-EIO);
+
+	ret = ext4_read_bh_lock(bh, REQ_META | REQ_PRIO, true);
+	if (ret) {
+		put_bh(bh);
+		return ERR_PTR(ret);
+	}
+	return bh;
 }
 
 /* Read a contiguous batch of blocks. */
@@ -910,11 +911,8 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
 
 	for (i = 0; i < bh_count; i++)
 		/* Note that NULL bhs[i] is valid because of holes. */
-		if (bhs[i] && !ext4_buffer_uptodate(bhs[i])) {
-			clear_buffer_verified(bhs[i]);
-			ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1,
-				    &bhs[i]);
-		}
+		if (bhs[i] && !ext4_buffer_uptodate(bhs[i]))
+			ext4_read_bh_lock(bhs[i], REQ_META | REQ_PRIO, false);
 
 	if (!wait)
 		return 0;
@@ -1084,7 +1082,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 		if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
 		    !buffer_unwritten(bh) &&
 		    (block_start < from || block_end > to)) {
-			ll_rw_block(REQ_OP_READ, 0, 1, &bh);
+			ext4_read_bh_lock(bh, 0, false);
 			wait[nr_wait++] = bh;
 		}
 	}
@@ -3733,11 +3731,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		set_buffer_uptodate(bh);
 
 	if (!buffer_uptodate(bh)) {
-		err = -EIO;
-		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
-		wait_on_buffer(bh);
-		/* Uhhuh. Read error. Complain and punt. */
-		if (!buffer_uptodate(bh))
+		err = ext4_read_bh_lock(bh, 0, true);
+		if (err)
 			goto unlock;
 		if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 			/* We expect the key to be set. */
@@ -4381,9 +4376,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		 * Read the block from disk.
 		 */
 		trace_ext4_load_inode(inode);
-		get_bh(bh);
-		bh->b_end_io = end_buffer_read_sync;
-		submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
+		ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
 		blk_finish_plug(&plug);
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index d34cb8c46655..795c3ff2907c 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -85,15 +85,11 @@ static int read_mmp_block(struct super_block *sb, struct buffer_head **bh,
 		}
 	}
 
-	get_bh(*bh);
 	lock_buffer(*bh);
-	(*bh)->b_end_io = end_buffer_read_sync;
-	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, *bh);
-	wait_on_buffer(*bh);
-	if (!buffer_uptodate(*bh)) {
-		ret = -EIO;
+	ret = ext4_read_bh(*bh, REQ_META | REQ_PRIO, NULL);
+	if (ret)
 		goto warn_exit;
-	}
+
 	mmp = (struct mmp_struct *)((*bh)->b_data);
 	if (le32_to_cpu(mmp->mmp_magic) != EXT4_MMP_MAGIC) {
 		ret = -EFSCORRUPTED;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 0d601b822875..64a579734f93 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -215,7 +215,7 @@ mext_page_mkuptodate(struct page *page, unsigned from, unsigned to)
 	for (i = 0; i < nr; i++) {
 		bh = arr[i];
 		if (!bh_uptodate_or_lock(bh)) {
-			err = bh_submit_read(bh);
+			err = ext4_read_bh(bh, 0, NULL);
 			if (err)
 				return err;
 		}
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index a50b51270ea9..8596bdda304c 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1243,7 +1243,7 @@ static struct buffer_head *ext4_get_bitmap(struct super_block *sb, __u64 block)
 	if (unlikely(!bh))
 		return NULL;
 	if (!bh_uptodate_or_lock(bh)) {
-		if (bh_submit_read(bh) < 0) {
+		if (ext4_read_bh(bh, 0, NULL) < 0) {
 			brelse(bh);
 			return NULL;
 		}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 1b1a4ca00957..0adba4871f57 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -212,19 +212,21 @@ int ext4_read_bh_lock(struct buffer_head *bh, int op_flags, bool wait)
 struct buffer_head *
 ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
 {
-	struct buffer_head *bh = sb_getblk(sb, block);
+	struct buffer_head *bh;
+	int ret;
 
+	bh = sb_getblk(sb, block);
 	if (bh == NULL)
 		return ERR_PTR(-ENOMEM);
 	if (ext4_buffer_uptodate(bh))
 		return bh;
-	clear_buffer_verified(bh);
-	ll_rw_block(REQ_OP_READ, REQ_META | op_flags, 1, &bh);
-	wait_on_buffer(bh);
-	if (buffer_uptodate(bh))
-		return bh;
-	put_bh(bh);
-	return ERR_PTR(-EIO);
+
+	ret = ext4_read_bh_lock(bh, REQ_META | op_flags, true);
+	if (ret) {
+		put_bh(bh);
+		return ERR_PTR(ret);
+	}
+	return bh;
 }
 
 static int ext4_verify_csum_type(struct super_block *sb,
@@ -5165,9 +5167,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 		goto out_bdev;
 	}
 	journal->j_private = sb;
-	ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1, &journal->j_sb_buffer);
-	wait_on_buffer(journal->j_sb_buffer);
-	if (!buffer_uptodate(journal->j_sb_buffer)) {
+	if (ext4_read_bh_lock(journal->j_sb_buffer, REQ_META | REQ_PRIO, true)) {
 		ext4_msg(sb, KERN_ERR, "I/O error on journal device");
 		goto out_journal;
 	}
-- 
2.25.4

