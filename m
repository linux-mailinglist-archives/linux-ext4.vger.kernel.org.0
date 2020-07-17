Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C737B223FF8
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGQPyF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 11:54:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54475 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726344AbgGQPyE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 11:54:04 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06HFrx1s029544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 11:53:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D4E46420C56; Fri, 17 Jul 2020 11:53:58 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Alex Zhuravlev <bzzz@whamcloud.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/4] ext4: add prefetch_block_bitmaps mount options
Date:   Fri, 17 Jul 2020 11:53:52 -0400
Message-Id: <20200717155352.1053040-5-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200717155352.1053040-1-tytso@mit.edu>
References: <20200717155352.1053040-1-tytso@mit.edu>
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

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h    | 13 ++++++++++++
 fs/ext4/mballoc.c | 10 ++++------
 fs/ext4/super.c   | 51 +++++++++++++++++++++++++++++++++++++----------
 3 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7451662e092a..c04d4ef0b77a 100644
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
 
+typedef enum {
+	EXT4_LI_MODE_ITABLE,
+	EXT4_LI_MODE_PREFETCH_BBITMAP
+} ext4_li_mode;
+
 struct ext4_li_request {
 	struct super_block	*lr_super;
 	struct ext4_sb_info	*lr_sbi;
+	ext4_li_mode		lr_mode;
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
index 172994349bf6..c072d06d678d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2224,9 +2224,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
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
@@ -2276,9 +2275,8 @@ ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
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
index 330957ed1f05..9e19d5830745 100644
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
 
@@ -3197,19 +3201,33 @@ static void print_daily_error_info(struct timer_list *t)
 	mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);  /* Once a day */
 }
 
+static int ext4_run_li_prefetch(struct ext4_li_request *elr,
+				struct super_block *sb, ext4_group_t group)
+{
+	unsigned int prefetch_ios = 0;
+
+	elr->lr_next_group = ext4_mb_prefetch(sb, group,
+					      EXT4_SB(sb)->s_mb_prefetch,
+					      &prefetch_ios);
+	if (prefetch_ios)
+		ext4_mb_prefetch_fini(sb, elr->lr_next_group, prefetch_ios);
+	return (group >= elr->lr_next_group);
+}
+
 /* Find next suitable group and run ext4_init_inode_table */
 static int ext4_run_li_request(struct ext4_li_request *elr)
 {
 	struct ext4_group_desc *gdp = NULL;
-	ext4_group_t group, ngroups;
-	struct super_block *sb;
+	ext4_group_t group = elr->lr_next_group;
+	struct super_block *sb = elr->lr_super;
+	ext4_group_t ngroups = EXT4_SB(sb)->s_groups_count;
 	unsigned long timeout = 0;
 	int ret = 0;
 
-	sb = elr->lr_super;
-	ngroups = EXT4_SB(sb)->s_groups_count;
+	if (elr->lr_mode == EXT4_LI_MODE_PREFETCH_BBITMAP)
+		return ext4_run_li_prefetch(elr, sb, group);
 
-	for (group = elr->lr_next_group; group < ngroups; group++) {
+	for (; group < ngroups; group++) {
 		gdp = ext4_get_group_desc(sb, group, NULL);
 		if (!gdp) {
 			ret = 1;
@@ -3219,13 +3237,12 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
 		if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_ZEROED)))
 			break;
 	}
-
 	if (group >= ngroups)
 		ret = 1;
 
 	if (!ret) {
 		timeout = jiffies;
-		ret = ext4_init_inode_table(sb, group,
+		ret = ext4_init_inode_table(elr->lr_super, group,
 					    elr->lr_timeout ? 0 : 1);
 		if (elr->lr_timeout == 0) {
 			timeout = (jiffies - timeout) *
@@ -3234,6 +3251,10 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
 		}
 		elr->lr_next_sched = jiffies + elr->lr_timeout;
 		elr->lr_next_group = group + 1;
+	} else if (test_opt(sb, PREFETCH_BLOCK_BITMAPS)) {
+		elr->lr_mode = EXT4_LI_MODE_PREFETCH_BBITMAP;
+		elr->lr_next_group = 0;
+		ret = 0;
 	}
 	return ret;
 }
@@ -3459,7 +3480,8 @@ static int ext4_li_info_new(void)
 }
 
 static struct ext4_li_request *ext4_li_request_new(struct super_block *sb,
-					    ext4_group_t start)
+						   ext4_group_t start,
+						   ext4_li_mode mode)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_li_request *elr;
@@ -3468,6 +3490,7 @@ static struct ext4_li_request *ext4_li_request_new(struct super_block *sb,
 	if (!elr)
 		return NULL;
 
+	elr->lr_mode = mode;
 	elr->lr_super = sb;
 	elr->lr_sbi = sbi;
 	elr->lr_next_group = start;
@@ -3488,6 +3511,7 @@ int ext4_register_li_request(struct super_block *sb,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_li_request *elr = NULL;
 	ext4_group_t ngroups = sbi->s_groups_count;
+	ext4_li_mode lr_mode = EXT4_LI_MODE_ITABLE;
 	int ret = 0;
 
 	mutex_lock(&ext4_li_mtx);
@@ -3501,10 +3525,15 @@ int ext4_register_li_request(struct super_block *sb,
 	}
 
 	if (first_not_zeroed == ngroups || sb_rdonly(sb) ||
-	    !test_opt(sb, INIT_INODE_TABLE))
-		goto out;
+	    !test_opt(sb, INIT_INODE_TABLE)) {
+		if (test_opt(sb, PREFETCH_BLOCK_BITMAPS)) {
+			first_not_zeroed = 0;
+			lr_mode = EXT4_LI_MODE_PREFETCH_BBITMAP;
+		} else
+			goto out;
+	}
 
-	elr = ext4_li_request_new(sb, first_not_zeroed);
+	elr = ext4_li_request_new(sb, first_not_zeroed, lr_mode);
 	if (!elr) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.24.1

