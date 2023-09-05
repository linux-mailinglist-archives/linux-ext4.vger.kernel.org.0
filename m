Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B500379247D
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Sep 2023 17:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjIEP7D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Sep 2023 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354365AbjIELBS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Sep 2023 07:01:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A251AD;
        Tue,  5 Sep 2023 04:01:14 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385AgwpT019766;
        Tue, 5 Sep 2023 11:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=C+TUwBTCtIdc1cmlDb9hg/uZ6p9FFeooRc6oMwrbPrk=;
 b=tlo1+aiiqnUphZ2A1usVMxB6zVVn7XRdrL+IflZ/MkuhpmlDjBNwHGsZsd9c5h7kOw5S
 joIOd3vcAR712nm8gI9S6md+/2GBbft0qH1tsTWDL+A4/fwxX99sUW33/8hUFrX2OKVZ
 mnz9e8G7G5ooED/x4UP6Gy4rqidKaxoQKlXxJn/ew5UxddyEtf0mBt7AL0HAvG8SBRu2
 jKmTx93uZtdeHhCZPcvJyH8O30hJj7VK0fqdwNy6cjPk3hXCHG6os/25v4S+Uz0OZCA8
 PyMNonpm5DAHWQVWHY+7IwJX+YwVR3bKXoX2ghio4jEVbwLfdHgr6cPELFXZjAvpS+PP gA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx2hn90dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 11:01:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3859gtGG026826;
        Tue, 5 Sep 2023 11:01:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcn9ydk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 11:01:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385B18pU42402388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 11:01:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21C3920043;
        Tue,  5 Sep 2023 11:01:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4F0C20040;
        Tue,  5 Sep 2023 11:01:06 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 11:01:06 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [RFC 1/1] ext4: Replace linear search with array of lists in CR_GOAL_LEN_SLOW
Date:   Tue,  5 Sep 2023 16:31:04 +0530
Message-Id: <f5c56b0f4c9f0ce3f934ec44a60c6f4dba4410da.1693911548.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1693911548.git.ojaswin@linux.ibm.com>
References: <cover.1693911548.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oxA3HdeKYCjjACEb2du5qnRfrnqFbXxo
X-Proofpoint-GUID: oxA3HdeKYCjjACEb2du5qnRfrnqFbXxo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Originally, in CR_GOAL_LEN_SLOW, we start at goal block group and
keep looking at each BG linearly till we find one with
free blocks > requested blocks and then we allocate from there.

However, due to the linear nature of search we can end up unnecessarily
looping through BGs when none of them have enough free blocks. To avoid
this use an array of lists structure similar to ones used by the faster
CRs. Call this array of lists as freelists as the array has one list for
each possible order of free blocks in a block group.

* Design *

- Calculate freelist order of each BG as fls(grp->bb_free) with empty
  groups having an order of 0.

- Create 1 linked list for each order and place each BG in the respective
  order. Since we have free block data of all BGs on mount, we can classify
  all BGs in one of these lists.

- Upon allocation, if we enter CR_GOAL_LEN_SLOW, we use these freelists
  to quickly find the next group to use based on the request order.

- We update freelist order of a BG after every allocation or free operation
  on it.

* Motivation *

Having such a design in CR_GOAL_LEN_SLOW is beneficial because:

1. Theoretically, if we have a very large disk with large number of filled up
block groups, we'll be able to find the good group faster than linear searching.

2. We'll be able to select a BG whose free block order matches our goal length
and hence we won't be filling up bigger holes for small requests. This can
improve fragmentation in the longer run.

3. We'll have more control in what block groups we want to allocate from,
making CR_GOAL_LEN_SLOW more flexible.

NOTE: With this patch, we'll no longer look for BGs linearly and hence this has a
chance of increasing the spread of allocation however I think that shouldn't be
a problem since we still have the MB_DEFAULT_LINEAR_LIMIT for rotational devices
combined with Jan's (merged) patchset that fixed several issues related to
allocation spread [1].

[1] https://lore.kernel.org/all/20220908091301.147-1-jack@suse.cz/

(Also cleanup some comments to reflect the new symbolic names of criterias)

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h    |  25 +++++++--
 fs/ext4/mballoc.c | 134 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h |   5 ++
 3 files changed, 156 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 84618c46f239..fd0f9054a5cc 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -213,12 +213,23 @@ enum criteria {
 #define EXT4_MB_USE_RESERVED		0x2000
 /* Do strict check for free blocks while retrying block allocation */
 #define EXT4_MB_STRICT_CHECK		0x4000
-/* Large fragment size list lookup succeeded at least once for cr = 0 */
+/*
+ * Large fragment size list lookup succeeded at least once for
+ * CR_POWER2_ALIGNED
+ */
 #define EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED		0x8000
-/* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
+/*
+ * Avg fragment size rb tree lookup succeeded at least once for
+ * CR_GOAL_LEN_FAST
+ */
 #define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x00010000
-/* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
+/*
+ * Avg fragment size rb tree lookup succeeded at least once for
+ * CR_BEST_AVAIL_LEN
+ */
 #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
+/* Freelist lookup succeeded at least once for CR_GOAL_LEN_SLOW */
+#define EXT4_MB_CR_GOAL_LEN_SLOW_OPTIMIZED 	0x00040000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
@@ -1567,6 +1578,8 @@ struct ext4_sb_info {
 	rwlock_t *s_mb_avg_fragment_size_locks;
 	struct list_head *s_mb_largest_free_orders;
 	rwlock_t *s_mb_largest_free_orders_locks;
+	struct list_head *s_mb_freelist;
+	rwlock_t *s_mb_freelist_locks;
 
 	/* tunables */
 	unsigned long s_stripe;
@@ -1599,6 +1612,7 @@ struct ext4_sb_info {
 	atomic_t s_bal_p2_aligned_bad_suggestions;
 	atomic_t s_bal_goal_fast_bad_suggestions;
 	atomic_t s_bal_best_avail_bad_suggestions;
+	atomic_t s_bal_goal_slow_bad_suggestions;
 	atomic64_t s_bal_cX_groups_considered[EXT4_MB_NUM_CRS];
 	atomic64_t s_bal_cX_hits[EXT4_MB_NUM_CRS];
 	atomic64_t s_bal_cX_failed[EXT4_MB_NUM_CRS];		/* cX loop didn't find blocks */
@@ -3397,6 +3411,10 @@ struct ext4_group_info {
 	int		bb_avg_fragment_size_order;	/* order of average
 							   fragment in BG */
 	ext4_grpblk_t	bb_largest_free_order;/* order of largest frag in BG */
+	/*
+	 * Determines which freelist will this group be added to
+	 */
+	ext4_grpblk_t 	bb_freelist_order;
 	ext4_group_t	bb_group;	/* Group number */
 	struct          list_head bb_prealloc_list;
 #ifdef DOUBLE_CHECK
@@ -3405,6 +3423,7 @@ struct ext4_group_info {
 	struct rw_semaphore alloc_sem;
 	struct list_head bb_avg_fragment_size_node;
 	struct list_head bb_largest_free_order_node;
+	struct list_head bb_freelist_node;
 	ext4_grpblk_t	bb_counters[];	/* Nr of free power-of-two-block
 					 * regions, index is order.
 					 * bb_counters[3] = 5 means
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c91db9f57524..885571f9be7a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -866,6 +866,31 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 					grp->bb_avg_fragment_size_order]);
 }
 
+static void mb_update_freelist(struct super_block *sb,
+			       struct ext4_group_info *grp)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	int new_order, prev_order;
+
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN))
+		return;
+
+	new_order = fls(grp->bb_free);
+	prev_order = grp->bb_freelist_order;
+	if (new_order == prev_order)
+		return;
+
+	if (prev_order != -1) {
+		write_lock(&sbi->s_mb_freelist_locks[prev_order]);
+		list_del(&grp->bb_freelist_node);
+		write_unlock(&sbi->s_mb_freelist_locks[prev_order]);
+	}
+	write_lock(&sbi->s_mb_freelist_locks[new_order]);
+	grp->bb_freelist_order = new_order;
+	list_add_tail(&grp->bb_freelist_node, &sbi->s_mb_freelist[new_order]);
+	write_unlock(&sbi->s_mb_freelist_locks[new_order]);
+}
+
 /*
  * Choose next group by traversing largest_free_order lists. Updates *new_cr if
  * cr level needs an update.
@@ -1065,11 +1090,63 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 	*new_cr = CR_GOAL_LEN_SLOW;
 }
 
+static void ext4_mb_choose_next_group_goal_slow(struct ext4_allocation_context *ac,
+					  enum criteria *new_cr,
+					  ext4_group_t *group,
+					  ext4_group_t ngroups)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_group_info *iter, *grp = NULL;
+	int i, order;
+	unsigned freelist_max_order = MB_FREELIST_NUM_ORDERS(ac->ac_sb);
+
+	if (unlikely(ac->ac_flags & EXT4_MB_CR_GOAL_LEN_SLOW_OPTIMIZED)) {
+		if (sbi->s_mb_stats)
+			atomic_inc(&sbi->s_bal_goal_slow_bad_suggestions);
+	}
+
+	order = fls(ac->ac_g_ex.fe_len);
+	for (i = order; i < freelist_max_order; i++) {
+		if (list_empty(&sbi->s_mb_freelist[i]))
+			continue;
+
+		read_lock(&sbi->s_mb_freelist_locks[i]);
+		if (list_empty(&sbi->s_mb_freelist[i])) {
+			read_unlock(&sbi->s_mb_freelist_locks[i]);
+			continue;
+		}
+		grp = NULL;
+		list_for_each_entry(iter, &sbi->s_mb_freelist[i],
+				    bb_freelist_node) {
+			if (sbi->s_mb_stats)
+				atomic64_inc(&sbi->s_bal_cX_groups_considered
+						      [CR_GOAL_LEN_SLOW]);
+
+			if (likely(ext4_mb_good_group(ac, iter->bb_group,
+						      CR_GOAL_LEN_SLOW))) {
+				grp = iter;
+				break;
+			}
+		}
+		read_unlock(&sbi->s_mb_freelist_locks[i]);
+
+		if (grp)
+			break;
+	}
+
+	if (grp) {
+		*group = grp->bb_group;
+		ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_SLOW_OPTIMIZED;
+	} else {
+		*new_cr = CR_ANY_FREE;
+	}
+}
+
 static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 {
 	if (unlikely(!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN)))
 		return 0;
-	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
+	if (ac->ac_criteria >= CR_ANY_FREE)
 		return 0;
 	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
 		return 0;
@@ -1130,10 +1207,13 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 		ext4_mb_choose_next_group_goal_fast(ac, new_cr, group, ngroups);
 	} else if (*new_cr == CR_BEST_AVAIL_LEN) {
 		ext4_mb_choose_next_group_best_avail(ac, new_cr, group, ngroups);
+	} else if (*new_cr == CR_GOAL_LEN_SLOW) {
+		ext4_mb_choose_next_group_goal_slow(ac, new_cr, group, ngroups);
 	} else {
 		/*
-		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
-		 * bb_free. But until that happens, we should never come here.
+		 * We should never reach this point since should_opitimize_scan()
+		 * will make sure we don't use mb_optimize_scan for the remaining
+		 * CR_ANY_FREE criteria.
 		 */
 		WARN_ON(1);
 	}
@@ -1952,6 +2032,7 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 done:
 	mb_set_largest_free_order(sb, e4b->bd_info);
 	mb_update_avg_fragment_size(sb, e4b->bd_info);
+	mb_update_freelist(e4b->bd_sb, e4b->bd_info);
 	mb_check_buddy(e4b);
 }
 
@@ -2096,6 +2177,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
 
 	mb_update_avg_fragment_size(e4b->bd_sb, e4b->bd_info);
+	mb_update_freelist(e4b->bd_sb, e4b->bd_info);
 	mb_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
 	mb_check_buddy(e4b);
 
@@ -3125,6 +3207,8 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 		   atomic_read(&sbi->s_bal_cX_ex_scanned[CR_GOAL_LEN_SLOW]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR_GOAL_LEN_SLOW]));
+	seq_printf(seq, "\t\tbad_suggestions: %u\n",
+		   atomic_read(&sbi->s_bal_goal_slow_bad_suggestions));
 
 	/* CR_ANY_FREE stats */
 	seq_puts(seq, "\tcr_any_free_stats:\n");
@@ -3164,7 +3248,8 @@ __acquires(&EXT4_SB(sb)->s_mb_rb_lock)
 	struct super_block *sb = pde_data(file_inode(seq->file));
 	unsigned long position;
 
-	if (*pos < 0 || *pos >= 2*MB_NUM_ORDERS(sb))
+	if (*pos < 0 ||
+	    *pos >= 2 * MB_NUM_ORDERS(sb) + fls(EXT4_CLUSTERS_PER_GROUP(sb)))
 		return NULL;
 	position = *pos + 1;
 	return (void *) ((unsigned long) position);
@@ -3176,7 +3261,8 @@ static void *ext4_mb_seq_structs_summary_next(struct seq_file *seq, void *v, lof
 	unsigned long position;
 
 	++*pos;
-	if (*pos < 0 || *pos >= 2*MB_NUM_ORDERS(sb))
+	if (*pos < 0 ||
+	    *pos >= 2 * MB_NUM_ORDERS(sb) + fls(EXT4_CLUSTERS_PER_GROUP(sb)))
 		return NULL;
 	position = *pos + 1;
 	return (void *) ((unsigned long) position);
@@ -3191,6 +3277,23 @@ static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
 	unsigned int count;
 
 	position--;
+
+	if (position >= 2*MB_NUM_ORDERS(sb)) {
+		position -= 2*MB_NUM_ORDERS(sb);
+		if (position == 0)
+			seq_puts(seq, "freelists:\n");
+
+		count = 0;
+		read_lock(&sbi->s_mb_freelist_locks[position]);
+		list_for_each_entry(grp, &sbi->s_mb_freelist[position],
+				    bb_freelist_node)
+			count++;
+		read_unlock(&sbi->s_mb_freelist_locks[position]);
+		seq_printf(seq, "\tfreelist_order_%u_groups: %u\n",
+			   (unsigned int)position, count);
+		return 0;
+	}
+
 	if (position >= MB_NUM_ORDERS(sb)) {
 		position -= MB_NUM_ORDERS(sb);
 		if (position == 0)
@@ -3334,6 +3437,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 			ext4_free_group_clusters(sb, desc);
 	}
 
+	INIT_LIST_HEAD(&meta_group_info[i]->bb_freelist_node);
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
 	init_rwsem(&meta_group_info[i]->alloc_sem);
 	meta_group_info[i]->bb_free_root = RB_ROOT;
@@ -3341,8 +3445,10 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_avg_fragment_size_node);
 	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
 	meta_group_info[i]->bb_avg_fragment_size_order = -1;  /* uninit */
+	meta_group_info[i]->bb_freelist_order = -1; /* uninit */
 	meta_group_info[i]->bb_group = group;
 
+	mb_update_freelist(sb, meta_group_info[i]);
 	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
 	return 0;
 
@@ -3553,6 +3659,7 @@ int ext4_mb_init(struct super_block *sb)
 	unsigned i, j;
 	unsigned offset, offset_incr;
 	unsigned max;
+	unsigned freelist_max_order = MB_FREELIST_NUM_ORDERS(sb);
 	int ret;
 
 	i = MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_offsets);
@@ -3627,6 +3734,23 @@ int ext4_mb_init(struct super_block *sb)
 		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
 		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
 	}
+	/* Empty block groups get an order of 0 */
+	freelist_max_order = MB_FREELIST_NUM_ORDERS(sb);
+	sbi->s_mb_freelist = kmalloc_array(freelist_max_order, sizeof(struct list_head), GFP_KERNEL);
+	if (!sbi->s_mb_freelist) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	sbi->s_mb_freelist_locks =
+		kmalloc_array(freelist_max_order, sizeof(rwlock_t), GFP_KERNEL);
+	if (!sbi->s_mb_freelist_locks) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < freelist_max_order; i++) {
+		INIT_LIST_HEAD(&sbi->s_mb_freelist[i]);
+		rwlock_init(&sbi->s_mb_freelist_locks[i]);
+	}
 
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index d7aeb5da7d86..a3b53802899c 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -97,6 +97,11 @@
  */
 #define MB_NUM_ORDERS(sb)		((sb)->s_blocksize_bits + 2)
 
+/*
+ * Number of valid freelist orders. One extra order for 0 blocks.
+ */
+#define MB_FREELIST_NUM_ORDERS(sb) (fls(EXT4_CLUSTERS_PER_GROUP(sb)) + 1)
+
 struct ext4_free_data {
 	/* this links the free block information from sb_info */
 	struct list_head		efd_list;
-- 
2.31.1

