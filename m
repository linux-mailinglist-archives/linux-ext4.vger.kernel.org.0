Return-Path: <linux-ext4+bounces-4727-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B601A9AD9DB
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2024 04:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711E72836C4
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2024 02:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DCA14D428;
	Thu, 24 Oct 2024 02:22:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C900145B0B
	for <linux-ext4@vger.kernel.org>; Thu, 24 Oct 2024 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736527; cv=none; b=dvhlEuEPDM/HWXmM4k/AfIAmWgV0N3TOCjuu7Ay2pcp9IBV/BkgiGhgbLFA4KtcOe3OeNq4Ff3sCFQ0GHkZK1BkdOnb+89g10VSzErrY4qjE/D2uLWf9cQfizJCXcmmZqRibjGVXTtrrzbGhRMOX/1BwiDl35+jG3QhxgOq5GzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736527; c=relaxed/simple;
	bh=YsPY3nNLrDfmPHM7yGNThzt6Bq+vM5gyJRldLcSJx0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ITL7jBD+iSwzaKSFmtrTXAT9x3dBfKPDZ9QfK0NUZY4Xh3ASXyLQn9VIn9EkBhWNjOE/uEphXiKrzYZ9E+9D9lf7+Sv3UL8kaDQew2iX7Js0kTT+/9C15nWf3PL9TWGTvT7LJGfmAtk+/AVc1+6xBKTRFRM4LgACfgC4/ZaAxco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XYqRV04Bdz4f3jsY
	for <linux-ext4@vger.kernel.org>; Thu, 24 Oct 2024 10:21:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 751E61A0194
	for <linux-ext4@vger.kernel.org>; Thu, 24 Oct 2024 10:21:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8RFrxlnpTzPEw--.49211S4;
	Thu, 24 Oct 2024 10:21:59 +0800 (CST)
From: leo.lilong@huaweicloud.com
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: leo.lilong@huawei.com,
	linux-ext4@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [RESEND PATCH] ext4: Fix race in buffer_head read fault injection
Date: Thu, 24 Oct 2024 10:19:09 +0800
Message-Id: <20241024021909.4032340-1-leo.lilong@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHR8RFrxlnpTzPEw--.49211S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Cr1xJF1Dtw18Zw43ZrW5Wrg_yoWDWr1kp3
	Z0kFWxGrykX3WDuan7trsaqw18Gws2gF4UGFyfC343uFW3XFn3XFW8tFy5AFW8KrZxXry3
	XF1UKry7Cr1rCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUklb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1XdbUUUUU
	U==
X-CM-SenderInfo: hohrhzxlor0w46kxt4xhlfz01xgou0bp/

From: Long Li <leo.lilong@huawei.com>

When I enabled ext4 debug for fault injection testing, I encountered the
following warning:

  EXT4-fs error (device sda): ext4_read_inode_bitmap:201: comm fsstress:
         Cannot read inode bitmap - block_group = 8, inode_bitmap = 1051
  WARNING: CPU: 0 PID: 511 at fs/buffer.c:1181 mark_buffer_dirty+0x1b3/0x1d0

The root cause of the issue lies in the improper implementation of ext4's
buffer_head read fault injection. The actual completion of buffer_head
read and the buffer_head fault injection are not atomic, which can lead
to the uptodate flag being cleared on normally used buffer_heads in race
conditions.

[CPU0]           [CPU1]         [CPU2]
ext4_read_inode_bitmap
  ext4_read_bh()
  <bh read complete>
                 ext4_read_inode_bitmap
                   if (buffer_uptodate(bh))
                     return bh
                               jbd2_journal_commit_transaction
                                 __jbd2_journal_refile_buffer
                                   __jbd2_journal_unfile_buffer
                                     __jbd2_journal_temp_unlink_buffer
  ext4_simulate_fail_bh()
    clear_buffer_uptodate
                                      mark_buffer_dirty
                                        <report warning>
                                        WARN_ON_ONCE(!buffer_uptodate(bh))

The best approach would be to perform fault injection in the IO completion
callback function, rather than after IO completion. However, the IO
completion callback function cannot get the fault injection code in sb.

Fix it by passing the result of fault injection into the bh read function,
we simulate faults within the bh read function itself. This requires adding
an extra parameter to the bh read functions that need fault injection.

Fixes: 46f870d690fe ("ext4: simulate various I/O and checksum errors when reading metadata")
Signed-off-by: Long Li <leo.lilong@huawei.com>
---
Changelog: Previous mailboxes may be classified as spam and resent using
           another mailbox.

 fs/ext4/balloc.c      |  4 ++--
 fs/ext4/ext4.h        | 12 ++----------
 fs/ext4/extents.c     |  2 +-
 fs/ext4/ialloc.c      |  5 +++--
 fs/ext4/indirect.c    |  2 +-
 fs/ext4/inode.c       |  4 ++--
 fs/ext4/mmp.c         |  2 +-
 fs/ext4/move_extent.c |  2 +-
 fs/ext4/resize.c      |  2 +-
 fs/ext4/super.c       | 23 +++++++++++++++--------
 10 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 591fb3f710be..8042ad873808 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -550,7 +550,8 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 	trace_ext4_read_block_bitmap_load(sb, block_group, ignore_locked);
 	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO |
 			    (ignore_locked ? REQ_RAHEAD : 0),
-			    ext4_end_bitmap_read);
+			    ext4_end_bitmap_read,
+			    ext4_simulate_fail(sb, EXT4_SIM_BBITMAP_EIO));
 	return bh;
 verify:
 	err = ext4_validate_block_bitmap(sb, desc, block_group, bh);
@@ -577,7 +578,6 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
 	if (!desc)
 		return -EFSCORRUPTED;
 	wait_on_buffer(bh);
-	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_BBITMAP_EIO);
 	if (!buffer_uptodate(bh)) {
 		ext4_error_err(sb, EIO, "Cannot read block bitmap - "
 			       "block_group = %u, block_bitmap = %llu",
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..bbffb76d9a90 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1865,14 +1865,6 @@ static inline bool ext4_simulate_fail(struct super_block *sb,
 	return false;
 }
 
-static inline void ext4_simulate_fail_bh(struct super_block *sb,
-					 struct buffer_head *bh,
-					 unsigned long code)
-{
-	if (!IS_ERR(bh) && ext4_simulate_fail(sb, code))
-		clear_buffer_uptodate(bh);
-}
-
 /*
  * Error number codes for s_{first,last}_error_errno
  *
@@ -3100,9 +3092,9 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 						   sector_t block);
 extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
-				bh_end_io_t *end_io);
+				bh_end_io_t *end_io, bool simu_fail);
 extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
-			bh_end_io_t *end_io);
+			bh_end_io_t *end_io, bool simu_fail);
 extern int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
 extern void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 34e25eee6521..88f98dc44027 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -568,7 +568,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
 
 	if (!bh_uptodate_or_lock(bh)) {
 		trace_ext4_ext_load_extent(inode, pblk, _RET_IP_);
-		err = ext4_read_bh(bh, 0, NULL);
+		err = ext4_read_bh(bh, 0, NULL, false);
 		if (err < 0)
 			goto errout;
 	}
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 7f1a5f90dbbd..21d228073d79 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -193,8 +193,9 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 	 * submit the buffer_head for reading
 	 */
 	trace_ext4_load_inode_bitmap(sb, block_group);
-	ext4_read_bh(bh, REQ_META | REQ_PRIO, ext4_end_bitmap_read);
-	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_IBITMAP_EIO);
+	ext4_read_bh(bh, REQ_META | REQ_PRIO,
+		     ext4_end_bitmap_read,
+		     ext4_simulate_fail(sb, EXT4_SIM_IBITMAP_EIO));
 	if (!buffer_uptodate(bh)) {
 		put_bh(bh);
 		ext4_error_err(sb, EIO, "Cannot read inode bitmap - "
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 7404f0935c90..7de327fa7b1c 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -170,7 +170,7 @@ static Indirect *ext4_get_branch(struct inode *inode, int depth,
 		}
 
 		if (!bh_uptodate_or_lock(bh)) {
-			if (ext4_read_bh(bh, 0, NULL) < 0) {
+			if (ext4_read_bh(bh, 0, NULL, false) < 0) {
 				put_bh(bh);
 				goto failure;
 			}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..99d09cd9c6a3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4497,10 +4497,10 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 	 * Read the block from disk.
 	 */
 	trace_ext4_load_inode(sb, ino);
-	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
+	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL,
+			    ext4_simulate_fail(sb, EXT4_SIM_INODE_EIO));
 	blk_finish_plug(&plug);
 	wait_on_buffer(bh);
-	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
 	if (!buffer_uptodate(bh)) {
 		if (ret_block)
 			*ret_block = block;
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index bd946d0c71b7..d64c04ed061a 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -94,7 +94,7 @@ static int read_mmp_block(struct super_block *sb, struct buffer_head **bh,
 	}
 
 	lock_buffer(*bh);
-	ret = ext4_read_bh(*bh, REQ_META | REQ_PRIO, NULL);
+	ret = ext4_read_bh(*bh, REQ_META | REQ_PRIO, NULL, false);
 	if (ret)
 		goto warn_exit;
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index b64661ea6e0e..898443e98efc 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -213,7 +213,7 @@ static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
 			unlock_buffer(bh);
 			continue;
 		}
-		ext4_read_bh_nowait(bh, 0, NULL);
+		ext4_read_bh_nowait(bh, 0, NULL, false);
 		nr++;
 	} while (block++, (bh = bh->b_this_page) != head);
 
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index a2704f064361..72f77f78ae8d 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1300,7 +1300,7 @@ static struct buffer_head *ext4_get_bitmap(struct super_block *sb, __u64 block)
 	if (unlikely(!bh))
 		return NULL;
 	if (!bh_uptodate_or_lock(bh)) {
-		if (ext4_read_bh(bh, 0, NULL) < 0) {
+		if (ext4_read_bh(bh, 0, NULL, false) < 0) {
 			brelse(bh);
 			return NULL;
 		}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b77acba4a719..acce6644c1fc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -161,8 +161,14 @@ MODULE_ALIAS("ext3");
 
 
 static inline void __ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
-				  bh_end_io_t *end_io)
+				  bh_end_io_t *end_io, bool simu_fail)
 {
+	if (simu_fail) {
+		clear_buffer_uptodate(bh);
+		unlock_buffer(bh);
+		return;
+	}
+
 	/*
 	 * buffer's verified bit is no longer valid after reading from
 	 * disk again due to write out error, clear it to make sure we
@@ -176,7 +182,7 @@ static inline void __ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
 }
 
 void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
-			 bh_end_io_t *end_io)
+			 bh_end_io_t *end_io, bool simu_fail)
 {
 	BUG_ON(!buffer_locked(bh));
 
@@ -184,10 +190,11 @@ void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
 		unlock_buffer(bh);
 		return;
 	}
-	__ext4_read_bh(bh, op_flags, end_io);
+	__ext4_read_bh(bh, op_flags, end_io, simu_fail);
 }
 
-int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io)
+int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
+		 bh_end_io_t *end_io, bool simu_fail)
 {
 	BUG_ON(!buffer_locked(bh));
 
@@ -196,7 +203,7 @@ int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io
 		return 0;
 	}
 
-	__ext4_read_bh(bh, op_flags, end_io);
+	__ext4_read_bh(bh, op_flags, end_io, simu_fail);
 
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
@@ -208,10 +215,10 @@ int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
 {
 	lock_buffer(bh);
 	if (!wait) {
-		ext4_read_bh_nowait(bh, op_flags, NULL);
+		ext4_read_bh_nowait(bh, op_flags, NULL, false);
 		return 0;
 	}
-	return ext4_read_bh(bh, op_flags, NULL);
+	return ext4_read_bh(bh, op_flags, NULL, false);
 }
 
 /*
@@ -266,7 +273,7 @@ void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 
 	if (likely(bh)) {
 		if (trylock_buffer(bh))
-			ext4_read_bh_nowait(bh, REQ_RAHEAD, NULL);
+			ext4_read_bh_nowait(bh, REQ_RAHEAD, NULL, false);
 		brelse(bh);
 	}
 }
-- 
2.39.2


