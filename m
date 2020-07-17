Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2548C223FF9
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgGQPyG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 11:54:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54477 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726656AbgGQPyF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 11:54:05 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06HFrx2e029541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 11:53:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C8CED42031E; Fri, 17 Jul 2020 11:53:58 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Alex Zhuravlev <bzzz@whamcloud.com>,
        Andreas Dilger <adilger@whamcloud.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/4] ext4: add prefetching for block allocation bitmaps
Date:   Fri, 17 Jul 2020 11:53:49 -0400
Message-Id: <20200717155352.1053040-2-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200717155352.1053040-1-tytso@mit.edu>
References: <20200717155352.1053040-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alex Zhuravlev <bzzz@whamcloud.com>

This should significantly improve bitmap loading, especially for flex
groups as it tries to load all bitmaps within a flex.group instead of
one by one synchronously.

Prefetching is done in 8 * flex_bg groups, so it should be 8 read-ahead
reads for a single allocating thread. At the end of allocation the
thread waits for read-ahead completion and initializes buddy information
so that read-aheads are not lost in case of memory pressure.

At cr=0 the number of prefetching IOs is limited per allocation context
to prevent a situation when mballoc loads thousands of bitmaps looking
for a perfect group and ignoring groups with good chunks.

Together with the patch "ext4: limit scanning of uninitialized groups"
the mount time (which includes few tiny allocations) of a 1PB filesystem
is reduced significantly:

               0% full    50%-full unpatched    patched
  mount time       33s                9279s       563s

[ Restructured by tytso; removed the state flags in the allocation
  context, so it can be used to lazily prefetch the allocation bitmaps
  immediately after the file system is mounted.  Skip prefetching
  block groups which are unitialized.  Finally pass in the REQ_RAHEAD
  flag to the block layer while prefetching. ]

Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/balloc.c  |  14 +++--
 fs/ext4/ext4.h    |   8 ++-
 fs/ext4/mballoc.c | 132 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/sysfs.c   |   4 ++
 4 files changed, 152 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 1ba46d87cdf1..aaa9ec5212c8 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -413,7 +413,8 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
  * Return buffer_head on success or an ERR_PTR in case of failure.
  */
 struct buffer_head *
-ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
+ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
+			      bool ignore_locked)
 {
 	struct ext4_group_desc *desc;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -441,6 +442,12 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (ignore_locked && buffer_locked(bh)) {
+		/* buffer under IO already, return if called for prefetching */
+		put_bh(bh);
+		return NULL;
+	}
+
 	if (bitmap_uptodate(bh))
 		goto verify;
 
@@ -490,7 +497,8 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
 	trace_ext4_read_block_bitmap_load(sb, block_group);
 	bh->b_end_io = ext4_end_bitmap_read;
 	get_bh(bh);
-	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
+	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO |
+		  ignore_locked ? REQ_RAHEAD : 0, bh);
 	return bh;
 verify:
 	err = ext4_validate_block_bitmap(sb, desc, block_group, bh);
@@ -534,7 +542,7 @@ ext4_read_block_bitmap(struct super_block *sb, ext4_group_t block_group)
 	struct buffer_head *bh;
 	int err;
 
-	bh = ext4_read_block_bitmap_nowait(sb, block_group);
+	bh = ext4_read_block_bitmap_nowait(sb, block_group, false);
 	if (IS_ERR(bh))
 		return bh;
 	err = ext4_wait_block_bitmap(sb, block_group, bh);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42f5060f3cdf..7451662e092a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1505,6 +1505,8 @@ struct ext4_sb_info {
 	/* where last allocation was done - for stream allocation */
 	unsigned long s_mb_last_group;
 	unsigned long s_mb_last_start;
+	unsigned int s_mb_prefetch;
+	unsigned int s_mb_prefetch_limit;
 
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
@@ -2446,7 +2448,8 @@ extern struct ext4_group_desc * ext4_get_group_desc(struct super_block * sb,
 extern int ext4_should_retry_alloc(struct super_block *sb, int *retries);
 
 extern struct buffer_head *ext4_read_block_bitmap_nowait(struct super_block *sb,
-						ext4_group_t block_group);
+						ext4_group_t block_group,
+						bool ignore_locked);
 extern int ext4_wait_block_bitmap(struct super_block *sb,
 				  ext4_group_t block_group,
 				  struct buffer_head *bh);
@@ -3145,6 +3148,7 @@ struct ext4_group_info {
 	(1 << EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT)
 #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
 	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
+#define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
 
 #define EXT4_MB_GRP_NEED_INIT(grp)	\
 	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
@@ -3159,6 +3163,8 @@ struct ext4_group_info {
 	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
 #define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
 	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
+#define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
+	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, &((grp)->bb_state)))
 
 #define EXT4_MAX_CONTENTION		8
 #define EXT4_CONTENTION_THRESHOLD	2
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c0a331e2feb0..8a1e6e03c088 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -922,7 +922,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			bh[i] = NULL;
 			continue;
 		}
-		bh[i] = ext4_read_block_bitmap_nowait(sb, group);
+		bh[i] = ext4_read_block_bitmap_nowait(sb, group, false);
 		if (IS_ERR(bh[i])) {
 			err = PTR_ERR(bh[i]);
 			bh[i] = NULL;
@@ -2209,12 +2209,93 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	return ret;
 }
 
+/*
+ * Start prefetching @nr block bitmaps starting at @group.
+ * Return the next group which needs to be prefetched.
+ */
+static ext4_group_t
+ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
+		 unsigned int nr, int *cnt)
+{
+	ext4_group_t ngroups = ext4_get_groups_count(sb);
+	struct buffer_head *bh;
+	struct blk_plug plug;
+
+	blk_start_plug(&plug);
+	while (nr-- > 0) {
+		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
+								  NULL);
+		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
+
+		/*
+		 * Prefetch block groups with free blocks; but don't
+		 * bother if it is marked uninitialized on disk, since
+		 * it won't require I/O to read.  Also only try to
+		 * prefetch once, so we avoid getblk() call, which can
+		 * be expensive.
+		 */
+		if (!EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
+		    EXT4_MB_GRP_NEED_INIT(grp) &&
+		    ext4_free_group_clusters(sb, gdp) > 0 &&
+		    !(ext4_has_group_desc_csum(sb) &&
+		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
+			bh = ext4_read_block_bitmap_nowait(sb, group, true);
+			if (bh && !IS_ERR(bh)) {
+				if (!buffer_uptodate(bh) && cnt)
+					(*cnt)++;
+				brelse(bh);
+			}
+		}
+		if (++group >= ngroups)
+			group = 0;
+	}
+	blk_finish_plug(&plug);
+	return group;
+}
+
+/*
+ * Prefetching reads the block bitmap into the buffer cache; but we
+ * need to make sure that the buddy bitmap in the page cache has been
+ * initialized.  Note that ext4_mb_init_group() will block if the I/O
+ * is not yet completed, or indeed if it was not initiated by
+ * ext4_mb_prefetch did not start the I/O.
+ *
+ * TODO: We should actually kick off the buddy bitmap setup in a work
+ * queue when the buffer I/O is completed, so that we don't block
+ * waiting for the block allocation bitmap read to finish when
+ * ext4_mb_prefetch_fini is called from ext4_mb_regular_allocator().
+ */
+static void
+ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
+		      unsigned int nr)
+{
+	while (nr-- > 0) {
+		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
+								  NULL);
+		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
+
+		if (!group)
+			group = ext4_get_groups_count(sb);
+		group--;
+		grp = ext4_get_group_info(sb, group);
+
+		if (EXT4_MB_GRP_NEED_INIT(grp) &&
+		    ext4_free_group_clusters(sb, gdp) > 0 &&
+		    !(ext4_has_group_desc_csum(sb) &&
+		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
+			if (ext4_mb_init_group(sb, group, GFP_NOFS))
+				break;
+		}
+	}
+}
+
 static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
-	ext4_group_t ngroups, group, i;
+	ext4_group_t prefetch_grp = 0, ngroups, group, i;
 	int cr = -1;
 	int err = 0, first_err = 0;
+	unsigned int nr = 0, prefetch_ios = 0;
 	struct ext4_sb_info *sbi;
 	struct super_block *sb;
 	struct ext4_buddy e4b;
@@ -2282,6 +2363,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 * from the goal value specified
 		 */
 		group = ac->ac_g_ex.fe_group;
+		prefetch_grp = group;
 
 		for (i = 0; i < ngroups; group++, i++) {
 			int ret = 0;
@@ -2293,6 +2375,29 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if (group >= ngroups)
 				group = 0;
 
+			/*
+			 * Batch reads of the block allocation bitmaps
+			 * to get multiple READs in flight; limit
+			 * prefetching at cr=0/1, otherwise mballoc can
+			 * spend a lot of time loading imperfect groups
+			 */
+			if ((prefetch_grp == group) &&
+			    (cr > 1 ||
+			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
+				unsigned int curr_ios = prefetch_ios;
+
+				nr = sbi->s_mb_prefetch;
+				if (ext4_has_feature_flex_bg(sb)) {
+					nr = (group / sbi->s_mb_prefetch) *
+						sbi->s_mb_prefetch;
+					nr = nr + sbi->s_mb_prefetch - group;
+				}
+				prefetch_grp = ext4_mb_prefetch(sb, group,
+							nr, &prefetch_ios);
+				if (prefetch_ios == curr_ios)
+					nr = 0;
+			}
+
 			/* This now checks without needing the buddy page */
 			ret = ext4_mb_good_group_nolock(ac, group, cr);
 			if (ret <= 0) {
@@ -2367,6 +2472,10 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, cr, err);
+
+	if (nr)
+		ext4_mb_prefetch_fini(sb, prefetch_grp, nr);
+
 	return err;
 }
 
@@ -2613,6 +2722,25 @@ static int ext4_mb_init_backend(struct super_block *sb)
 			goto err_freebuddy;
 	}
 
+	if (ext4_has_feature_flex_bg(sb)) {
+		/* a single flex group is supposed to be read by a single IO */
+		sbi->s_mb_prefetch = 1 << sbi->s_es->s_log_groups_per_flex;
+		sbi->s_mb_prefetch *= 8; /* 8 prefetch IOs in flight at most */
+	} else {
+		sbi->s_mb_prefetch = 32;
+	}
+	if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
+		sbi->s_mb_prefetch = ext4_get_groups_count(sb);
+	/* now many real IOs to prefetch within a single allocation at cr=0
+	 * given cr=0 is an CPU-related optimization we shouldn't try to
+	 * load too many groups, at some point we should start to use what
+	 * we've got in memory.
+	 * with an average random access time 5ms, it'd take a second to get
+	 * 200 groups (* N with flex_bg), so let's make this limit 4 */
+	sbi->s_mb_prefetch_limit = sbi->s_mb_prefetch * 4;
+	if (sbi->s_mb_prefetch_limit > ext4_get_groups_count(sb))
+		sbi->s_mb_prefetch_limit = ext4_get_groups_count(sb);
+
 	return 0;
 
 err_freebuddy:
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6c9fc9e21c13..31e0db726d21 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -240,6 +240,8 @@ EXT4_RO_ATTR_ES_STRING(last_error_func, s_last_error_func, 32);
 EXT4_ATTR(first_error_time, 0444, first_error_time);
 EXT4_ATTR(last_error_time, 0444, last_error_time);
 EXT4_ATTR(journal_task, 0444, journal_task);
+EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
+EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
 
 static unsigned int old_bump_val = 128;
 EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
@@ -283,6 +285,8 @@ static struct attribute *ext4_attrs[] = {
 #ifdef CONFIG_EXT4_DEBUG
 	ATTR_LIST(simulate_fail),
 #endif
+	ATTR_LIST(mb_prefetch),
+	ATTR_LIST(mb_prefetch_limit),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
-- 
2.24.1

