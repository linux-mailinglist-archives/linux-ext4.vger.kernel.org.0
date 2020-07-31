Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCC234B76
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jul 2020 21:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgGaTIf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Jul 2020 15:08:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59741 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726964AbgGaTIe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Jul 2020 15:08:34 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06VJ8SlU009105
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 15:08:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 653CE420C56; Fri, 31 Jul 2020 15:08:28 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/4] ext4: add prefetch_block_bitmaps mount options
Date:   Fri, 31 Jul 2020 15:08:05 -0400
Message-Id: <20200731190805.181253-5-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200731190805.181253-1-tytso@mit.edu>
References: <20200731190805.181253-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For file systems where we can afford to keep the buddy bitmaps cached,
we can speed up initial writes to large file systems by starting to
load the block allocation bitmaps as soon as the file system is
mounted.  This won't work well for _super_ large file systems, or
memory constrained systems, so we only enable this when it is
requested via a mount option.

Addresses-Google-Bug: 159488342
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h              | 15 +++++++++-
 fs/ext4/mballoc.c           | 10 +++----
 fs/ext4/super.c             | 59 +++++++++++++++++++++++++++----------
 include/trace/events/ext4.h | 44 +++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7451662e092a..4df6f429de1a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1172,6 +1172,7 @@ struct ext4_inode_info {
 #define EXT4_MOUNT_JOURNAL_CHECKSUM	0x800000 /* Journal checksums */
 #define EXT4_MOUNT_JOURNAL_ASYNC_COMMIT	0x1000000 /* Journal Async Commit */
 #define EXT4_MOUNT_WARN_ON_ERROR	0x2000000 /* Trigger WARN_ON on error */
+#define EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS 0x4000000
 #define EXT4_MOUNT_DELALLOC		0x8000000 /* Delalloc support */
 #define EXT4_MOUNT_DATA_ERR_ABORT	0x10000000 /* Abort on file data write */
 #define EXT4_MOUNT_BLOCK_VALIDITY	0x20000000 /* Block validity checking */
@@ -2315,9 +2316,15 @@ struct ext4_lazy_init {
 	struct mutex		li_list_mtx;
 };
 
+enum ext4_li_mode {
+	EXT4_LI_MODE_PREFETCH_BBITMAP,
+	EXT4_LI_MODE_ITABLE,
+};
+
 struct ext4_li_request {
 	struct super_block	*lr_super;
-	struct ext4_sb_info	*lr_sbi;
+	enum ext4_li_mode	lr_mode;
+	ext4_group_t		lr_first_not_zeroed;
 	ext4_group_t		lr_next_group;
 	struct list_head	lr_request;
 	unsigned long		lr_next_sched;
@@ -2657,6 +2664,12 @@ extern int ext4_mb_reserve_blocks(struct super_block *, int);
 extern void ext4_discard_preallocations(struct inode *);
 extern int __init ext4_init_mballoc(void);
 extern void ext4_exit_mballoc(void);
+extern ext4_group_t ext4_mb_prefetch(struct super_block *sb,
+				     ext4_group_t group,
+				     unsigned int nr, int *cnt);
+extern void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
+				  unsigned int nr);
+
 extern void ext4_free_blocks(handle_t *handle, struct inode *inode,
 			     struct buffer_head *bh, ext4_fsblk_t block,
 			     unsigned long count, int flags);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b1ef35a9e9f1..47de61e44db2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2233,9 +2233,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
  * Start prefetching @nr block bitmaps starting at @group.
  * Return the next group which needs to be prefetched.
  */
-static ext4_group_t
-ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
-		 unsigned int nr, int *cnt)
+ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
+			      unsigned int nr, int *cnt)
 {
 	ext4_group_t ngroups = ext4_get_groups_count(sb);
 	struct buffer_head *bh;
@@ -2285,9 +2284,8 @@ ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
  * waiting for the block allocation bitmap read to finish when
  * ext4_mb_prefetch_fini is called from ext4_mb_regular_allocator().
  */
-static void
-ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
-		      unsigned int nr)
+void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
+			   unsigned int nr)
 {
 	while (nr-- > 0) {
 		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957ed1f05..51e91a220ea9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1521,6 +1521,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
+	Opt_prefetch_block_bitmaps,
 };
 
 static const match_table_t tokens = {
@@ -1612,6 +1613,7 @@ static const match_table_t tokens = {
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_nombcache, "nombcache"},
 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
+	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
 	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
 	{Opt_removed, "nocheck"},	/* mount option from ext2/3 */
 	{Opt_removed, "reservation"},	/* mount option from ext2/3 */
@@ -1829,6 +1831,8 @@ static const struct mount_opts {
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_STRING},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
+	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
+	 MOPT_SET},
 	{Opt_err, 0, 0}
 };
 
@@ -3201,15 +3205,34 @@ static void print_daily_error_info(struct timer_list *t)
 static int ext4_run_li_request(struct ext4_li_request *elr)
 {
 	struct ext4_group_desc *gdp = NULL;
-	ext4_group_t group, ngroups;
-	struct super_block *sb;
+	struct super_block *sb = elr->lr_super;
+	ext4_group_t ngroups = EXT4_SB(sb)->s_groups_count;
+	ext4_group_t group = elr->lr_next_group;
 	unsigned long timeout = 0;
+	unsigned int prefetch_ios = 0;
 	int ret = 0;
 
-	sb = elr->lr_super;
-	ngroups = EXT4_SB(sb)->s_groups_count;
+	if (elr->lr_mode == EXT4_LI_MODE_PREFETCH_BBITMAP) {
+		elr->lr_next_group = ext4_mb_prefetch(sb, group,
+				EXT4_SB(sb)->s_mb_prefetch, &prefetch_ios);
+		if (prefetch_ios)
+			ext4_mb_prefetch_fini(sb, elr->lr_next_group,
+					      prefetch_ios);
+		trace_ext4_prefetch_bitmaps(sb, group, elr->lr_next_group,
+					    prefetch_ios);
+		if (group >= elr->lr_next_group) {
+			ret = 1;
+			if (elr->lr_first_not_zeroed != ngroups &&
+			    !sb_rdonly(sb) && test_opt(sb, INIT_INODE_TABLE)) {
+				elr->lr_next_group = elr->lr_first_not_zeroed;
+				elr->lr_mode = EXT4_LI_MODE_ITABLE;
+				ret = 0;
+			}
+		}
+		return ret;
+	}
 
-	for (group = elr->lr_next_group; group < ngroups; group++) {
+	for (; group < ngroups; group++) {
 		gdp = ext4_get_group_desc(sb, group, NULL);
 		if (!gdp) {
 			ret = 1;
@@ -3227,9 +3250,10 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
 		timeout = jiffies;
 		ret = ext4_init_inode_table(sb, group,
 					    elr->lr_timeout ? 0 : 1);
+		trace_ext4_lazy_itable_init(sb, group);
 		if (elr->lr_timeout == 0) {
 			timeout = (jiffies - timeout) *
-				  elr->lr_sbi->s_li_wait_mult;
+				EXT4_SB(elr->lr_super)->s_li_wait_mult;
 			elr->lr_timeout = timeout;
 		}
 		elr->lr_next_sched = jiffies + elr->lr_timeout;
@@ -3244,15 +3268,11 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
  */
 static void ext4_remove_li_request(struct ext4_li_request *elr)
 {
-	struct ext4_sb_info *sbi;
-
 	if (!elr)
 		return;
 
-	sbi = elr->lr_sbi;
-
 	list_del(&elr->lr_request);
-	sbi->s_li_request = NULL;
+	EXT4_SB(elr->lr_super)->s_li_request = NULL;
 	kfree(elr);
 }
 
@@ -3461,7 +3481,6 @@ static int ext4_li_info_new(void)
 static struct ext4_li_request *ext4_li_request_new(struct super_block *sb,
 					    ext4_group_t start)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_li_request *elr;
 
 	elr = kzalloc(sizeof(*elr), GFP_KERNEL);
@@ -3469,8 +3488,13 @@ static struct ext4_li_request *ext4_li_request_new(struct super_block *sb,
 		return NULL;
 
 	elr->lr_super = sb;
-	elr->lr_sbi = sbi;
-	elr->lr_next_group = start;
+	elr->lr_first_not_zeroed = start;
+	if (test_opt(sb, PREFETCH_BLOCK_BITMAPS))
+		elr->lr_mode = EXT4_LI_MODE_PREFETCH_BBITMAP;
+	else {
+		elr->lr_mode = EXT4_LI_MODE_ITABLE;
+		elr->lr_next_group = start;
+	}
 
 	/*
 	 * Randomize first schedule time of the request to
@@ -3488,6 +3512,7 @@ int ext4_register_li_request(struct super_block *sb,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_li_request *elr = NULL;
 	ext4_group_t ngroups = sbi->s_groups_count;
+	enum ext4_li_mode lr_mode = EXT4_LI_MODE_ITABLE;
 	int ret = 0;
 
 	mutex_lock(&ext4_li_mtx);
@@ -3500,8 +3525,10 @@ int ext4_register_li_request(struct super_block *sb,
 		goto out;
 	}
 
-	if (first_not_zeroed == ngroups || sb_rdonly(sb) ||
-	    !test_opt(sb, INIT_INODE_TABLE))
+	if (test_opt(sb, PREFETCH_BLOCK_BITMAPS)) {
+		lr_mode = EXT4_LI_MODE_PREFETCH_BBITMAP;
+	} else if (first_not_zeroed == ngroups || sb_rdonly(sb) ||
+		   !test_opt(sb, INIT_INODE_TABLE))
 		goto out;
 
 	elr = ext4_li_request_new(sb, first_not_zeroed);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index cbcd2e1a608d..8008d2e116b9 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2742,6 +2742,50 @@ TRACE_EVENT(ext4_error,
 		  __entry->function, __entry->line)
 );
 
+TRACE_EVENT(ext4_prefetch_bitmaps,
+	    TP_PROTO(struct super_block *sb, ext4_group_t group,
+		     ext4_group_t next, unsigned int prefetch_ios),
+
+	TP_ARGS(sb, group, next, prefetch_ios),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	__u32,	group			)
+		__field(	__u32,	next			)
+		__field(	__u32,	ios			)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->group	= group;
+		__entry->next	= next;
+		__entry->ios	= prefetch_ios;
+	),
+
+	TP_printk("dev %d,%d group %u next %u ios %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->group, __entry->next, __entry->ios)
+);
+
+TRACE_EVENT(ext4_lazy_itable_init,
+	    TP_PROTO(struct super_block *sb, ext4_group_t group),
+
+	TP_ARGS(sb, group),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	__u32,	group			)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->group	= group;
+	),
+
+	TP_printk("dev %d,%d group %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->group)
+);
+
 #endif /* _TRACE_EXT4_H */
 
 /* This part must be outside protection */
-- 
2.24.1

