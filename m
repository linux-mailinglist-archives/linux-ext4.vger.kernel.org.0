Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0E5715FF1
	for <lists+linux-ext4@lfdr.de>; Tue, 30 May 2023 14:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjE3Mgm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 May 2023 08:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjE3MgJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 May 2023 08:36:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749A9115;
        Tue, 30 May 2023 05:35:36 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UBIew0015583;
        Tue, 30 May 2023 12:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8AitXp5IA8vKufsR40aabJOyKfpQtoJksWpf2vri7y0=;
 b=cZnK2gAByKeGMICZsuuPHBHaQ5ou8jsD/23eJz+j4FiuBlnClsOxawRW1oDotLfT73Ea
 YphmVD/4DAghPDCLvdXivc9Va+aUPiIUxFfy7os93U44yPUjxEKH+a2nLfedBjRgwAoJ
 7DsKuGCvofJ8az9h9naFu/z3+2M7CaKi3WomjuwMTo5IyHvoooxSWWxagnYR5KavUYVr
 8B479jCZwje3DWrk2Z88hWMaPFxKGOU+f7/I4NON1TQ/5YmAj1rhXEe/vz42qTUnrKZz
 TfMISCMbkw2w7NeqaapYLnQRwa/l9aURkft21PBkCEeelyFhdbh0rmmmxeU1l/aTF9HX Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwg5dt2na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:24 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UCWPGZ026488;
        Tue, 30 May 2023 12:34:24 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwg5dt2ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U2ZIUM002894;
        Tue, 30 May 2023 12:34:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g59fe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCYJBI53412254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:34:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2497C2004E;
        Tue, 30 May 2023 12:34:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 358FA2004B;
        Tue, 30 May 2023 12:34:17 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:34:16 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 11/12] ext4: Add allocation criteria 1.5 (CR1_5)
Date:   Tue, 30 May 2023 18:03:49 +0530
Message-Id: <150fdf65c8e4cc4dba71e020ce0859bcf636a5ff.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vZB_rfFL4mwfGlQr3HI5eWrijh4anRKu
X-Proofpoint-GUID: -AQTrLB_adNoqBA9oXwlfq1mUZpgxVXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305300103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

CR1_5 aims to optimize allocations which can't be satisfied in CR1. The
fact that we couldn't find a group in CR1 suggests that it would be
difficult to find a continuous extent to compleltely satisfy our
allocations. So before falling to the slower CR2, in CR1.5 we
proactively trim the the preallocations so we can find a group with
(free / fragments) big enough.  This speeds up our allocation at the
cost of slightly reduced preallocation.

The patch also adds a new sysfs tunable:

* /sys/fs/ext4/<partition>/mb_cr1_5_max_trim_order

This controls how much CR1.5 can trim a request before falling to CR2.
For example, for a request of order 7 and max trim order 2, CR1.5 can
trim this upto order 5.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

ext4 squash
---
 fs/ext4/ext4.h              |   8 ++-
 fs/ext4/mballoc.c           | 135 +++++++++++++++++++++++++++++++++---
 fs/ext4/mballoc.h           |  13 ++++
 fs/ext4/sysfs.c             |   2 +
 include/trace/events/ext4.h |   2 +
 5 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index eae981ab2539..942e97026a60 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -133,13 +133,14 @@ enum SHIFT_DIRECTION {
  * criteria the slower the allocation. We start at lower criterias and keep
  * falling back to higher ones if we are not able to find any blocks.
  */
-#define EXT4_MB_NUM_CRS 4
+#define EXT4_MB_NUM_CRS 5
 /*
  * All possible allocation criterias for mballoc
  */
 enum criteria {
 	CR0,
 	CR1,
+	CR1_5,
 	CR2,
 	CR3,
 };
@@ -185,6 +186,9 @@ enum criteria {
 #define EXT4_MB_CR0_OPTIMIZED		0x8000
 /* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
 #define EXT4_MB_CR1_OPTIMIZED		0x00010000
+/* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
+#define EXT4_MB_CR1_5_OPTIMIZED		0x00020000
+
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
 	struct inode *inode;
@@ -1547,6 +1551,7 @@ struct ext4_sb_info {
 	unsigned long s_mb_last_start;
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
+	unsigned int s_mb_cr1_5_max_trim_order;
 
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
@@ -1561,6 +1566,7 @@ struct ext4_sb_info {
 	atomic_t s_bal_2orders;	/* 2^order hits */
 	atomic_t s_bal_cr0_bad_suggestions;
 	atomic_t s_bal_cr1_bad_suggestions;
+	atomic_t s_bal_cr1_5_bad_suggestions;
 	atomic64_t s_bal_cX_groups_considered[EXT4_MB_NUM_CRS];
 	atomic64_t s_bal_cX_hits[EXT4_MB_NUM_CRS];
 	atomic64_t s_bal_cX_failed[EXT4_MB_NUM_CRS];		/* cX loop didn't find blocks */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f59e1e0e01b1..0cf037489e97 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -166,6 +166,14 @@
  * equal to request size using our average fragment size group lists (data
  * structure 2) in O(1) time.
  *
+ * At CR1.5 (aka CR1_5), we aim to optimize allocations which can't be satisfied
+ * in CR1. The fact that we couldn't find a group in CR1 suggests that there is
+ * no BG that has average fragment size > goal length. So before falling to the
+ * slower CR2, in CR1.5 we proactively trim goal length and then use the same
+ * fragment lists as CR1 to find a BG with a big enough average fragment size.
+ * This increases the chances of finding a suitable block group in O(1) time and
+ * results * in faster allocation at the cost of reduced size of allocation.
+ *
  * If "mb_optimize_scan" mount option is not set, mballoc traverses groups in
  * linear order which requires O(N) search time for each CR0 and CR1 phase.
  *
@@ -963,6 +971,91 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 		*group = grp->bb_group;
 		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
 	} else {
+		*new_cr = CR1_5;
+	}
+}
+
+/*
+ * We couldn't find a group in CR1 so try to find the highest free fragment
+ * order we have and proactively trim the goal request length to that order to
+ * find a suitable group faster.
+ *
+ * This optimizes allocation speed at the cost of slightly reduced
+ * preallocations. However, we make sure that we don't trim the request too
+ * much and fall to CR2 in that case.
+ */
+static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
+		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_group_info *grp = NULL;
+	int i, order, min_order;
+	unsigned long num_stripe_clusters = 0;
+
+	if (unlikely(ac->ac_flags & EXT4_MB_CR1_5_OPTIMIZED)) {
+		if (sbi->s_mb_stats)
+			atomic_inc(&sbi->s_bal_cr1_5_bad_suggestions);
+	}
+
+	/*
+	 * mb_avg_fragment_size_order() returns order in a way that makes
+	 * retrieving back the length using (1 << order) inaccurate. Hence, use
+	 * fls() instead since we need to know the actual length while modifying
+	 * goal length.
+	 */
+	order = fls(ac->ac_g_ex.fe_len);
+	min_order = order - sbi->s_mb_cr1_5_max_trim_order;
+	if (min_order < 0)
+		min_order = 0;
+
+	if (1 << min_order < ac->ac_o_ex.fe_len)
+		min_order = fls(ac->ac_o_ex.fe_len) + 1;
+
+	if (sbi->s_stripe > 0) {
+		/*
+		 * We are assuming that stripe size is always a multiple of
+		 * cluster ratio otherwise __ext4_fill_super exists early.
+		 */
+		num_stripe_clusters = EXT4_NUM_B2C(sbi, sbi->s_stripe);
+		if (1 << min_order < num_stripe_clusters)
+			min_order = fls(num_stripe_clusters);
+	}
+
+	for (i = order; i >= min_order; i--) {
+		int frag_order;
+		/*
+		 * Scale down goal len to make sure we find something
+		 * in the free fragments list. Basically, reduce
+		 * preallocations.
+		 */
+		ac->ac_g_ex.fe_len = 1 << i;
+
+		if (num_stripe_clusters > 0) {
+			/*
+			 * Try to round up the adjusted goal to stripe size
+			 * (in cluster units) multiple for efficiency.
+			 *
+			 * XXX: Is s->stripe always a power of 2? In that case
+			 * we can use the faster round_up() variant.
+			 */
+			ac->ac_g_ex.fe_len = roundup(ac->ac_g_ex.fe_len,
+						     num_stripe_clusters);
+		}
+
+		frag_order = mb_avg_fragment_size_order(ac->ac_sb,
+							ac->ac_g_ex.fe_len);
+
+		grp = ext4_mb_find_good_group_avg_frag_lists(ac, frag_order);
+		if (grp)
+			break;
+	}
+
+	if (grp) {
+		*group = grp->bb_group;
+		ac->ac_flags |= EXT4_MB_CR1_5_OPTIMIZED;
+	} else {
+		/* Reset goal length to original goal length before falling into CR2 */
+		ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
 		*new_cr = CR2;
 	}
 }
@@ -1029,6 +1122,8 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 		ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
 	} else if (*new_cr == CR1) {
 		ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
+	} else if (*new_cr == CR1_5) {
+		ext4_mb_choose_next_group_cr1_5(ac, new_cr, group, ngroups);
 	} else {
 		/*
 		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
@@ -2352,7 +2447,7 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 
 		if (ac->ac_criteria < CR2) {
 			/*
-			 * In CR1, we are sure that this group will
+			 * In CR1 and CR1_5, we are sure that this group will
 			 * have a large enough continuous free extent, so skip
 			 * over the smaller free extents
 			 */
@@ -2484,6 +2579,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 
 		return true;
 	case CR1:
+	case CR1_5:
 		if ((free / fragments) >= ac->ac_g_ex.fe_len)
 			return true;
 		break;
@@ -2748,7 +2844,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			 * spend a lot of time loading imperfect groups
 			 */
 			if ((prefetch_grp == group) &&
-			    (cr > CR1 ||
+			    (cr > CR1_5 ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
 				nr = sbi->s_mb_prefetch;
 				if (ext4_has_feature_flex_bg(sb)) {
@@ -2788,7 +2884,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_groups_scanned++;
 			if (cr == CR0)
 				ext4_mb_simple_scan_group(ac, &e4b);
-			else if (cr == CR1 && sbi->s_stripe &&
+			else if ((cr == CR1 || cr == CR1_5) && sbi->s_stripe &&
 				 !(ac->ac_g_ex.fe_len %
 				 EXT4_B2C(sbi, sbi->s_stripe)))
 				ext4_mb_scan_aligned(ac, &e4b);
@@ -2804,6 +2900,11 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		/* Processed all groups and haven't found blocks */
 		if (sbi->s_mb_stats && i == ngroups)
 			atomic64_inc(&sbi->s_bal_cX_failed[cr]);
+
+		if (i == ngroups && ac->ac_criteria == CR1_5)
+			/* Reset goal length to original goal length before
+			 * falling into CR2 */
+			ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
 	}
 
 	if (ac->ac_b_ex.fe_len > 0 && ac->ac_status != AC_STATUS_FOUND &&
@@ -2973,6 +3074,16 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
 		   atomic_read(&sbi->s_bal_cr1_bad_suggestions));
 
+	seq_puts(seq, "\tcr1.5_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR1_5]));
+	seq_printf(seq, "\t\tgroups_considered: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR1_5]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR1_5]));
+	seq_printf(seq, "\t\tuseless_loops: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_failed[CR1_5]));
+	seq_printf(seq, "\t\tbad_suggestions: %u\n",
+		   atomic_read(&sbi->s_bal_cr1_5_bad_suggestions));
+
 	seq_puts(seq, "\tcr2_stats:\n");
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR2]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
@@ -3490,6 +3601,8 @@ int ext4_mb_init(struct super_block *sb)
 	sbi->s_mb_stats = MB_DEFAULT_STATS;
 	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
 	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
+	sbi->s_mb_cr1_5_max_trim_order = MB_DEFAULT_CR1_5_TRIM_ORDER;
+
 	/*
 	 * The default group preallocation is 512, which for 4k block
 	 * sizes translates to 2 megabytes.  However for bigalloc file
@@ -4402,6 +4515,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	 * placement or satisfy big request as is */
 	ac->ac_g_ex.fe_logical = start;
 	ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);
+	ac->ac_orig_goal_len = ac->ac_g_ex.fe_len;
 
 	/* define goal start in order to merge */
 	if (ar->pright && (ar->lright == (start + size)) &&
@@ -4445,8 +4559,10 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
 		if (ac->ac_g_ex.fe_start == ac->ac_b_ex.fe_start &&
 				ac->ac_g_ex.fe_group == ac->ac_b_ex.fe_group)
 			atomic_inc(&sbi->s_bal_goals);
-		if (ac->ac_f_ex.fe_len == ac->ac_g_ex.fe_len)
+		/* did we allocate as much as normalizer originally wanted? */
+		if (ac->ac_f_ex.fe_len == ac->ac_orig_goal_len)
 			atomic_inc(&sbi->s_bal_len_goals);
+
 		if (ac->ac_found > sbi->s_mb_max_to_scan)
 			atomic_inc(&sbi->s_bal_breaks);
 	}
@@ -4931,7 +5047,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
 	pa = ac->ac_pa;
 
-	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len) {
+	if (ac->ac_b_ex.fe_len < ac->ac_orig_goal_len) {
 		int new_bex_start;
 		int new_bex_end;
 
@@ -4946,14 +5062,14 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		 * fragmentation in check while ensuring logical range of best
 		 * extent doesn't overflow out of goal extent:
 		 *
-		 * 1. Check if best ex can be kept at end of goal and still
-		 *    cover original start
+		 * 1. Check if best ex can be kept at end of goal (before
+		 *    cr_best_avail trimmed it) and still cover original start
 		 * 2. Else, check if best ex can be kept at start of goal and
 		 *    still cover original start
 		 * 3. Else, keep the best ex at start of original request.
 		 */
 		new_bex_end = ac->ac_g_ex.fe_logical +
-			EXT4_C2B(sbi, ac->ac_g_ex.fe_len);
+			EXT4_C2B(sbi, ac->ac_orig_goal_len);
 		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
 		if (ac->ac_o_ex.fe_logical >= new_bex_start)
 			goto adjust_bex;
@@ -4974,7 +5090,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
 		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
 		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
-				      EXT4_C2B(sbi, ac->ac_g_ex.fe_len)));
+				      EXT4_C2B(sbi, ac->ac_orig_goal_len)));
 	}
 
 	pa->pa_lstart = ac->ac_b_ex.fe_logical;
@@ -5594,6 +5710,7 @@ ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 	ac->ac_o_ex.fe_start = block;
 	ac->ac_o_ex.fe_len = len;
 	ac->ac_g_ex = ac->ac_o_ex;
+	ac->ac_orig_goal_len = ac->ac_g_ex.fe_len;
 	ac->ac_flags = ar->flags;
 
 	/* we have to define context: we'll work with a file or
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index acfdc204e15d..bddc0335c261 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -85,6 +85,13 @@
  */
 #define MB_DEFAULT_LINEAR_SCAN_THRESHOLD	16
 
+/*
+ * The maximum order upto which CR1.5 can trim a particular allocation request.
+ * Example, if we have an order 7 request and max trim order of 3, CR1.5 can
+ * trim this upto order 4.
+ */
+#define MB_DEFAULT_CR1_5_TRIM_ORDER	3
+
 /*
  * Number of valid buddy orders
  */
@@ -179,6 +186,12 @@ struct ext4_allocation_context {
 	/* copy of the best found extent taken before preallocation efforts */
 	struct ext4_free_extent ac_f_ex;
 
+	/*
+	 * goal len can change in CR1.5, so save the original len. This is
+	 * used while adjusting the PA window and for accounting.
+	 */
+	ext4_grpblk_t	ac_orig_goal_len;
+
 	__u32 ac_groups_considered;
 	__u32 ac_flags;		/* allocation hints */
 	__u16 ac_groups_scanned;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 3042bc605bbf..4a5c08c8dddb 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -223,6 +223,7 @@ EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.int
 EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
+EXT4_RW_ATTR_SBI_UI(mb_cr1_5_max_trim_order, s_mb_cr1_5_max_trim_order);
 #ifdef CONFIG_EXT4_DEBUG
 EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
 #endif
@@ -273,6 +274,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(warning_ratelimit_burst),
 	ATTR_LIST(msg_ratelimit_interval_ms),
 	ATTR_LIST(msg_ratelimit_burst),
+	ATTR_LIST(mb_cr1_5_max_trim_order),
 	ATTR_LIST(errors_count),
 	ATTR_LIST(warning_count),
 	ATTR_LIST(msg_count),
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index f062147ca32b..7ea9b4fcb21f 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -122,6 +122,7 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 
 TRACE_DEFINE_ENUM(CR0);
 TRACE_DEFINE_ENUM(CR1);
+TRACE_DEFINE_ENUM(CR1_5);
 TRACE_DEFINE_ENUM(CR2);
 TRACE_DEFINE_ENUM(CR3);
 
@@ -129,6 +130,7 @@ TRACE_DEFINE_ENUM(CR3);
 	__print_symbolic(cr,                    \
 			 { CR0, "CR0" },	\
 			 { CR1, "CR1" },        \
+			 { CR1_5, "CR1.5" }     \
 			 { CR2, "CR2" },        \
 			 { CR3, "CR3" })
 
-- 
2.31.1

