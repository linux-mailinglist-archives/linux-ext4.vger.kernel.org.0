Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A8A3EC368
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Aug 2021 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhHNO7f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Aug 2021 10:59:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58113 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238522AbhHNO7e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Aug 2021 10:59:34 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17EEx3x6029547
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Aug 2021 10:59:04 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6A7A815C37CF; Sat, 14 Aug 2021 10:59:03 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] ext4: fix sparse warnings
Date:   Sat, 14 Aug 2021 10:58:59 -0400
Message-Id: <20210814145900.500399-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add sparse annotations to suppress false positive context imbalance
warnings, and use NULL instead of 0 in EXT_MAX_{EXTENT,INDEX}.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4_extents.h |  5 +++--
 fs/ext4/mballoc.c      | 26 ++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4_extents.h b/fs/ext4/ext4_extents.h
index 44e59881a1f0..26435f3a3094 100644
--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -173,10 +173,11 @@ struct partial_cluster {
 #define EXT_MAX_EXTENT(__hdr__)	\
 	((le16_to_cpu((__hdr__)->eh_max)) ? \
 	((EXT_FIRST_EXTENT((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)) \
-					: 0)
+					: NULL)
 #define EXT_MAX_INDEX(__hdr__) \
 	((le16_to_cpu((__hdr__)->eh_max)) ? \
-	((EXT_FIRST_INDEX((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)) : 0)
+	((EXT_FIRST_INDEX((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)) \
+					: NULL)
 
 static inline struct ext4_extent_header *ext_inode_hdr(struct inode *inode)
 {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a496509e61b7..e89db3396203 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2479,6 +2479,12 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
  * This could return negative error code if something goes wrong
  * during ext4_mb_init_group(). This should not be called with
  * ext4_lock_group() held.
+ *
+ * Note: because we are conditionally operating with the group lock in
+ * the EXT4_MB_STRICT_CHECK case, we need to fake out sparse in this
+ * function using __acquire and __release.  This means we need to be
+ * super careful before messing with the error path handling via "goto
+ * out"!
  */
 static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 				     ext4_group_t group, int cr)
@@ -2492,8 +2498,10 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 
 	if (sbi->s_mb_stats)
 		atomic64_inc(&sbi->s_bal_cX_groups_considered[ac->ac_criteria]);
-	if (should_lock)
+	if (should_lock) {
 		ext4_lock_group(sb, group);
+		__release(ext4_group_lock_ptr(sb, group));
+	}
 	free = grp->bb_free;
 	if (free == 0)
 		goto out;
@@ -2501,8 +2509,10 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		goto out;
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		goto out;
-	if (should_lock)
+	if (should_lock) {
+		__acquire(ext4_group_lock_ptr(sb, group));
 		ext4_unlock_group(sb, group);
+	}
 
 	/* We only do this if the grp has never been initialized */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
@@ -2529,12 +2539,16 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 			return ret;
 	}
 
-	if (should_lock)
+	if (should_lock) {
 		ext4_lock_group(sb, group);
+		__release(ext4_group_lock_ptr(sb, group));
+	}
 	ret = ext4_mb_good_group(ac, group, cr);
 out:
-	if (should_lock)
+	if (should_lock) {
+		__acquire(ext4_group_lock_ptr(sb, group));
 		ext4_unlock_group(sb, group);
+	}
 	return ret;
 }
 
@@ -2970,6 +2984,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 }
 
 static void *ext4_mb_seq_structs_summary_start(struct seq_file *seq, loff_t *pos)
+__acquires(&EXT4_SB(sb)->s_mb_rb_lock)
 {
 	struct super_block *sb = PDE_DATA(file_inode(seq->file));
 	unsigned long position;
@@ -3042,6 +3057,7 @@ static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
 }
 
 static void ext4_mb_seq_structs_summary_stop(struct seq_file *seq, void *v)
+__releases(&EXT4_SB(sb)->s_mb_rb_lock)
 {
 	struct super_block *sb = PDE_DATA(file_inode(seq->file));
 
@@ -6280,6 +6296,8 @@ __acquires(bitlock)
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks)
+__acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
+__releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
 	ext4_grpblk_t next, count, free_count;
 	void *bitmap;
-- 
2.31.0

