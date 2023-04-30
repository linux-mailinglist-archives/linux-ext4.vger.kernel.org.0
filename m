Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E420F6F2968
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjD3Pn0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 11:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjD3PnY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 11:43:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDACB1BCB
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 08:43:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UFhGhU021718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 11:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682869397; bh=cR+MqpfvsOjglx5tGOLYhvxQXBRGnmA7mkT4INGSN0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oy6ZbiZH0Bc/QOE+/w9piYmoqyw8CWhS/YpLiYPibP424ImrGl2pEdFuTYVSYixPB
         fOLA3YnrDViWQYGk3bMLYvw4KzgOTaJSH8GfFZwyST4Ij0V2Y/cmG2uGG7y5dGaNSl
         67bzDfu5sABGe6keNQEgs/oJp00za/jsGu6/aGmexpcaiknzWqrAomqy+Hj6kLc4uu
         nfrCkI4OTSrHk3L+zEctx7gHwkYbyPcoc/k7tUlJpQkBKBawdsZiaq+QxJ58ds0lxv
         jO8+NDB9hWKu+OAQR0sntedCVZVOXYbhkywMw/nb9MqUk+bRXRamca3Z1lYaGuKGJm
         g3ZyrAvJ/qv8w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6086215C02E3; Sun, 30 Apr 2023 11:43:16 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] ext4: allow ext4_get_group_info() to fail
Date:   Sun, 30 Apr 2023 11:43:10 -0400
Message-Id: <20230430154311.579720-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230430154311.579720-1-tytso@mit.edu>
References: <20230430154311.579720-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Previously, ext4_get_group_info() would treat an invalid group number
as BUG(), since in theory it should never happen.  However, if a
malicious attaker (or fuzzer) modifies the superblock via the block
device while it is the file system is mounted, it is possible for
s_first_data_block to get set to a very large number.  In that case,
when calculating the block group of some block number (such as the
starting block of a preallocation region), could result in an
underflow and very large block group number.  Then the BUG_ON check in
ext4_get_group_info() would fire, resutling in a denial of service
attack that can be triggered by root or someone with write access to
the block device.

For a quality of implementation perspective, it's best that even if
the system administrator does something that they shouldn't, that it
will not trigger a BUG.  So instead of BUG'ing, ext4_get_group_info()
will call ext4_error and return NULL.  We also add fallback code in
all of the callers of ext4_get_group_info() that it might NULL.

Also, since ext4_get_group_info() was already borderline to be an
inline function, un-inline it.  The results in a next reduction of the
compiled text size of ext4 by roughly 2k.

Reported-by: syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=69b28112e098b070f639efb356393af3ffec4220
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/balloc.c  | 19 ++++++++++++-
 fs/ext4/ext4.h    | 15 ++--------
 fs/ext4/ialloc.c  | 12 +++++---
 fs/ext4/mballoc.c | 72 +++++++++++++++++++++++++++++++++++++++--------
 fs/ext4/super.c   |  2 ++
 5 files changed, 91 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 094269488183..106e169e2524 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -305,6 +305,23 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 	return desc;
 }
 
+struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
+					    ext4_group_t group)
+{
+	 struct ext4_group_info **grp_info;
+	 long indexv, indexh;
+
+	 if (unlikely(group >= EXT4_SB(sb)->s_groups_count)) {
+		 ext4_error(sb, "invalid group %u", group);
+		 return NULL;
+	 }
+	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
+	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
+	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
+	 return grp_info[indexh];
+}
+
+
 /*
  * Return the block number which was discovered to be invalid, or 0 if
  * the block bitmap is valid.
@@ -379,7 +396,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 
 	if (buffer_verified(bh))
 		return 0;
-	if (EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
+	if (!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18cb2680dc39..7e8f66ba17f4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2625,6 +2625,8 @@ extern void ext4_check_blocks_bitmap(struct super_block *);
 extern struct ext4_group_desc * ext4_get_group_desc(struct super_block * sb,
 						    ext4_group_t block_group,
 						    struct buffer_head ** bh);
+extern struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
+						   ext4_group_t group);
 extern int ext4_should_retry_alloc(struct super_block *sb, int *retries);
 
 extern struct buffer_head *ext4_read_block_bitmap_nowait(struct super_block *sb,
@@ -3232,19 +3234,6 @@ static inline void ext4_isize_set(struct ext4_inode *raw_inode, loff_t i_size)
 	raw_inode->i_size_high = cpu_to_le32(i_size >> 32);
 }
 
-static inline
-struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
-					    ext4_group_t group)
-{
-	 struct ext4_group_info **grp_info;
-	 long indexv, indexh;
-	 BUG_ON(group >= EXT4_SB(sb)->s_groups_count);
-	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
-	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
-	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
-	 return grp_info[indexh];
-}
-
 /*
  * Reading s_groups_count requires using smp_rmb() afterwards.  See
  * the locking protocol documented in the comments of ext4_group_add()
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 787ab89c2c26..754f961cd9fd 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -91,7 +91,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 
 	if (buffer_verified(bh))
 		return 0;
-	if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+	if (!grp || EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
@@ -293,7 +293,7 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 	}
 	if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
 		grp = ext4_get_group_info(sb, block_group);
-		if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
+		if (!grp || unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
 			fatal = -EFSCORRUPTED;
 			goto error_return;
 		}
@@ -1046,7 +1046,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 			 * Skip groups with already-known suspicious inode
 			 * tables
 			 */
-			if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+			if (!grp || EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
 				goto next_group;
 		}
 
@@ -1183,6 +1183,10 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 
 		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
 			grp = ext4_get_group_info(sb, group);
+			if (!grp) {
+				err = -EFSCORRUPTED;
+				goto out;
+			}
 			down_read(&grp->alloc_sem); /*
 						     * protect vs itable
 						     * lazyinit
@@ -1526,7 +1530,7 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
 	}
 
 	gdp = ext4_get_group_desc(sb, group, &group_desc_bh);
-	if (!gdp)
+	if (!gdp || !grp)
 		goto out;
 
 	/*
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 78259bddbc4d..dc13734f399d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -745,6 +745,8 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 	MB_CHECK_ASSERT(e4b->bd_info->bb_fragments == fragments);
 
 	grp = ext4_get_group_info(sb, e4b->bd_group);
+	if (!grp)
+		return NULL;
 	list_for_each(cur, &grp->bb_prealloc_list) {
 		ext4_group_t groupnr;
 		struct ext4_prealloc_space *pa;
@@ -1060,9 +1062,9 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 
 static noinline_for_stack
 void ext4_mb_generate_buddy(struct super_block *sb,
-				void *buddy, void *bitmap, ext4_group_t group)
+			    void *buddy, void *bitmap, ext4_group_t group,
+			    struct ext4_group_info *grp)
 {
-	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
 	ext4_grpblk_t i = 0;
@@ -1181,6 +1183,8 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			break;
 
 		grinfo = ext4_get_group_info(sb, group);
+		if (!grinfo)
+			continue;
 		/*
 		 * If page is uptodate then we came here after online resize
 		 * which added some new uninitialized group info structs, so
@@ -1246,6 +1250,10 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 				group, page->index, i * blocksize);
 			trace_ext4_mb_buddy_bitmap_load(sb, group);
 			grinfo = ext4_get_group_info(sb, group);
+			if (!grinfo) {
+				err = -EFSCORRUPTED;
+				goto out;
+			}
 			grinfo->bb_fragments = 0;
 			memset(grinfo->bb_counters, 0,
 			       sizeof(*grinfo->bb_counters) *
@@ -1256,7 +1264,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			ext4_lock_group(sb, group);
 			/* init the buddy */
 			memset(data, 0xff, blocksize);
-			ext4_mb_generate_buddy(sb, data, incore, group);
+			ext4_mb_generate_buddy(sb, data, incore, group, grinfo);
 			ext4_unlock_group(sb, group);
 			incore = NULL;
 		} else {
@@ -1370,6 +1378,9 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	might_sleep();
 	mb_debug(sb, "init group %u\n", group);
 	this_grp = ext4_get_group_info(sb, group);
+	if (!this_grp)
+		return -EFSCORRUPTED;
+
 	/*
 	 * This ensures that we don't reinit the buddy cache
 	 * page which map to the group from which we are already
@@ -1444,6 +1455,8 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
 	grp = ext4_get_group_info(sb, group);
+	if (!grp)
+		return -EFSCORRUPTED;
 
 	e4b->bd_blkbits = sb->s_blocksize_bits;
 	e4b->bd_info = grp;
@@ -2159,6 +2172,8 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct ext4_free_extent ex;
 
+	if (!grp)
+		return -EFSCORRUPTED;
 	if (!(ac->ac_flags & (EXT4_MB_HINT_TRY_GOAL | EXT4_MB_HINT_GOAL_ONLY)))
 		return 0;
 	if (grp->bb_free == 0)
@@ -2385,7 +2400,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 
 	BUG_ON(cr < 0 || cr >= 4);
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
 		return false;
 
 	free = grp->bb_free;
@@ -2454,6 +2469,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	ext4_grpblk_t free;
 	int ret = 0;
 
+	if (!grp)
+		return -EFSCORRUPTED;
 	if (sbi->s_mb_stats)
 		atomic64_inc(&sbi->s_bal_cX_groups_considered[ac->ac_criteria]);
 	if (should_lock) {
@@ -2534,7 +2551,7 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 		 * prefetch once, so we avoid getblk() call, which can
 		 * be expensive.
 		 */
-		if (!EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
+		if (gdp && grp && !EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
 		    EXT4_MB_GRP_NEED_INIT(grp) &&
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
@@ -2578,7 +2595,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 		gdp = ext4_get_group_desc(sb, group, NULL);
 		grp = ext4_get_group_info(sb, group);
 
-		if (EXT4_MB_GRP_NEED_INIT(grp) &&
+		if (grp && grp && EXT4_MB_GRP_NEED_INIT(grp) &&
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
 		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
@@ -2837,6 +2854,8 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 		sizeof(struct ext4_group_info);
 
 	grinfo = ext4_get_group_info(sb, group);
+	if (!grinfo)
+		return 0;
 	/* Load the group info in memory only if not already loaded. */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grinfo))) {
 		err = ext4_mb_load_buddy(sb, group, &e4b);
@@ -2847,7 +2866,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 		buddy_loaded = 1;
 	}
 
-	memcpy(&sg, ext4_get_group_info(sb, group), i);
+	memcpy(&sg, grinfo, i);
 
 	if (buddy_loaded)
 		ext4_mb_unload_buddy(&e4b);
@@ -3208,8 +3227,12 @@ static int ext4_mb_init_backend(struct super_block *sb)
 
 err_freebuddy:
 	cachep = get_groupinfo_cache(sb->s_blocksize_bits);
-	while (i-- > 0)
-		kmem_cache_free(cachep, ext4_get_group_info(sb, i));
+	while (i-- > 0) {
+		struct ext4_group_info *grp = ext4_get_group_info(sb, i);
+
+		if (grp)
+			kmem_cache_free(cachep, grp);
+	}
 	i = sbi->s_group_info_size;
 	rcu_read_lock();
 	group_info = rcu_dereference(sbi->s_group_info);
@@ -3522,6 +3545,8 @@ int ext4_mb_release(struct super_block *sb)
 		for (i = 0; i < ngroups; i++) {
 			cond_resched();
 			grinfo = ext4_get_group_info(sb, i);
+			if (!grinfo)
+				continue;
 			mb_group_bb_bitmap_free(grinfo);
 			ext4_lock_group(sb, i);
 			count = ext4_mb_cleanup_pa(grinfo);
@@ -4606,6 +4631,8 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 	struct ext4_free_data *entry;
 
 	grp = ext4_get_group_info(sb, group);
+	if (!grp)
+		return;
 	n = rb_first(&(grp->bb_free_root));
 
 	while (n) {
@@ -4633,6 +4660,9 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 	int preallocated = 0;
 	int len;
 
+	if (!grp)
+		return;
+
 	/* all form of preallocation discards first load group,
 	 * so the only competing code is preallocation use.
 	 * we don't need any locking here
@@ -4869,6 +4899,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
 	ei = EXT4_I(ac->ac_inode);
 	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
+	if (!grp)
+		return;
 
 	pa->pa_node_lock.inode_lock = &ei->i_prealloc_lock;
 	pa->pa_inode = ac->ac_inode;
@@ -4918,6 +4950,8 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	atomic_add(pa->pa_free, &EXT4_SB(sb)->s_mb_preallocated);
 
 	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
+	if (!grp)
+		return;
 	lg = ac->ac_lg;
 	BUG_ON(lg == NULL);
 
@@ -5043,6 +5077,8 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	int err;
 	int free = 0;
 
+	if (!grp)
+		return 0;
 	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
 		goto out_dbg;
@@ -5222,6 +5258,14 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 		BUG_ON(pa->pa_type != MB_INODE_PA);
 		group = ext4_get_group_number(sb, pa->pa_pstart);
+		if (pa->pa_pstart > ext4_blocks_count(EXT4_SB(sb)->s_es) ||
+		    group >= EXT4_SB(sb)->s_groups_count) {
+			ext4_warning(sb, "pa_pstart %llu invalid max %llu first_data_block %u group %u",
+				     pa->pa_pstart,
+				     ext4_blocks_count(EXT4_SB(sb)->s_es),
+				     le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block),
+				     group);
+		}
 
 		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
 					     GFP_NOFS|__GFP_NOFAIL);
@@ -5297,6 +5341,9 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
 		struct ext4_prealloc_space *pa;
 		ext4_grpblk_t start;
 		struct list_head *cur;
+
+		if (!grp)
+			continue;
 		ext4_lock_group(sb, i);
 		list_for_each(cur, &grp->bb_prealloc_list) {
 			pa = list_entry(cur, struct ext4_prealloc_space,
@@ -6064,6 +6111,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	struct buffer_head *bitmap_bh = NULL;
 	struct super_block *sb = inode->i_sb;
 	struct ext4_group_desc *gdp;
+	struct ext4_group_info *grp;
 	unsigned int overflow;
 	ext4_grpblk_t bit;
 	struct buffer_head *gd_bh;
@@ -6089,8 +6137,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	overflow = 0;
 	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(
-			ext4_get_group_info(sb, block_group))))
+	grp = ext4_get_group_info(sb, block_group);
+	if (unlikely(!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		return;
 
 	/*
@@ -6692,6 +6740,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 
 	for (group = first_group; group <= last_group; group++) {
 		grp = ext4_get_group_info(sb, group);
+		if (!grp)
+			continue;
 		/* We only do this if the grp has never been initialized */
 		if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
 			ret = ext4_mb_init_group(sb, group, GFP_NOFS);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 39f00f05f981..40ab4f78161d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1048,6 +1048,8 @@ void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 	struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group, NULL);
 	int ret;
 
+	if (!grp || !gdp)
+		return;
 	if (flags & EXT4_GROUP_INFO_BBITMAP_CORRUPT) {
 		ret = ext4_test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT,
 					    &grp->bb_state);
-- 
2.31.0

