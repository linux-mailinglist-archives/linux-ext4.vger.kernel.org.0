Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3081475DDBB
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Jul 2023 19:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGVRQS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Jul 2023 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGVRQR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Jul 2023 13:16:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1AD2733;
        Sat, 22 Jul 2023 10:16:08 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36MGXovP032586;
        Sat, 22 Jul 2023 17:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=uOMY5bX8mLajdVgXJRmK6Dkbguk4Dw6Efd+JMxCiyHc=;
 b=lxwOnOUuAT5qEMK9vwDmw9+DD9LswGCl3cbeBsQE5mAN7ItdhdiqBNGJMS59pzsb60g9
 3apMnB1G2TeX7WN/XxAuAUQXxYroCKJ54N5wnNEZgfQnPzjhXXfNrSQSRto5Ul3XAMsF
 0tiz5XPworzyZRxKV6tKbyjs++hkhbL/vUtz7q6hieNoylvvLQ1+rzOwI5bGJZSVEFg8
 Q1AUbKK3tPAy8M4G1NVUd1M8oP0pp1G8vZINWTSScksrGO9vjLUbj8lra/u8aIT4iap3
 izxmzb/n9Yug6GFV7bj3y4jYRqDRAEQo53G9kpRZxy5xwFa9shRNvn9hgFHXKuIu1o+h +w== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s0jhw8kcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 17:16:02 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36MF1HnK016875;
        Sat, 22 Jul 2023 17:16:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5sshb63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 17:16:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36MHG0K214877226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 17:16:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFE052004B;
        Sat, 22 Jul 2023 17:15:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDE8120040;
        Sat, 22 Jul 2023 17:15:48 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.0.4])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 22 Jul 2023 17:15:47 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 1/1] ext4: Fix rbtree traversal bug in ext4_mb_use_preallocated
Date:   Sat, 22 Jul 2023 22:45:24 +0530
Message-Id: <edd2efda6a83e6343c5ace9deea44813e71dbe20.1690045963.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1690045963.git.ojaswin@linux.ibm.com>
References: <cover.1690045963.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jWsBnPM0AxkJ5q9E1-aaIjyB3l2llOqL
X-Proofpoint-ORIG-GUID: jWsBnPM0AxkJ5q9E1-aaIjyB3l2llOqL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=962 impostorscore=0 mlxscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307220156
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

During allocations, while looking for preallocations(PA) in the per
inode rbtree, we can't do a direct traversal of the tree because
ext4_mb_discard_group_preallocation() can paralelly mark the pa deleted
and that can cause direct traversal to skip some entries. This was
leading to a BUG_ON() being hit [1] when we missed a PA that could satisfy
our request and ultimately tried to create a new PA that would overlap
with the missed one.

To makes sure we handle that case while still keeping the performance of
the rbtree, we make use of the fact that the only pa that could possibly
overlap the original goal start is the one that satisfies the below
conditions:

  1. It must have it's logical start immediately to the left of
  (ie less than) original logical start.

  2. It must not be deleted

To find this pa we use the following traversal method:

1. Descend into the rbtree normally to find the immediate neighboring
PA. Here we keep descending irrespective of if the PA is deleted or if
it overlaps with our request etc. The goal is to find an immediately
adjacent PA.

2. If the found PA is on right of original goal, use rb_prev() to find
the left adjacent PA.

3. Check if this PA is deleted and keep moving left with rb_prev() until
a non deleted PA is found.

4. This is the PA we are looking for. Now we can check if it can satisfy
the original request and proceed accordingly.

This approach also takes care of having deleted PAs in the tree.

(While we are at it, also fix a possible overflow bug in calculating the
end of a PA)

[1] https://lore.kernel.org/linux-ext4/CA+G9fYv2FRpLqBZf34ZinR8bU2_ZRAUOjKAD3+tKRFaEQHtt8Q@mail.gmail.com/

Fixes: 3872778664e3 ("ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list")
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reviewed-by: Ritesh Harjani (IBM) ritesh.list@gmail.com
Tested-by: Ritesh Harjani (IBM) ritesh.list@gmail.com
---
 fs/ext4/mballoc.c | 158 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 131 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 456150ef6111..21b903fe546e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4765,8 +4765,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	int order, i;
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_locality_group *lg;
-	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+	struct ext4_prealloc_space *tmp_pa = NULL, *cpa = NULL;
+	loff_t tmp_pa_end;
 	struct rb_node *iter;
 	ext4_fsblk_t goal_block;
 
@@ -4774,47 +4774,151 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return false;
 
-	/* first, try per-file preallocation */
+	/*
+	 * first, try per-file preallocation by searching the inode pa rbtree.
+	 *
+	 * Here, we can't do a direct traversal of the tree because
+	 * ext4_mb_discard_group_preallocation() can paralelly mark the pa
+	 * deleted and that can cause direct traversal to skip some entries.
+	 */
 	read_lock(&ei->i_prealloc_lock);
+
+	if (RB_EMPTY_ROOT(&ei->i_prealloc_node)) {
+		goto try_group_pa;
+	}
+
+	/*
+	 * Step 1: Find a pa with logical start immediately adjacent to the
+	 * original logical start. This could be on the left or right.
+	 *
+	 * (tmp_pa->pa_lstart never changes so we can skip locking for it).
+	 */
 	for (iter = ei->i_prealloc_node.rb_node; iter;
 	     iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical,
-					    tmp_pa_start, iter)) {
+					    tmp_pa->pa_lstart, iter)) {
 		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
 				  pa_node.inode_node);
+	}
 
-		/* all fields in this condition don't change,
-		 * so we can skip locking for them */
-		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
-
-		/* original request start doesn't lie in this PA */
-		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
-		    ac->ac_o_ex.fe_logical >= tmp_pa_end)
-			continue;
+	/*
+	 * Step 2: The adjacent pa might be to the right of logical start, find
+	 * the left adjacent pa. After this step we'd have a valid tmp_pa whose
+	 * logical start is towards the left of original request's logical start
+	 */
+	if (tmp_pa->pa_lstart > ac->ac_o_ex.fe_logical) {
+		struct rb_node *tmp;
+		tmp = rb_prev(&tmp_pa->pa_node.inode_node);
 
-		/* non-extent files can't have physical blocks past 2^32 */
-		if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
-		    (tmp_pa->pa_pstart + EXT4_C2B(sbi, tmp_pa->pa_len) >
-		     EXT4_MAX_BLOCK_FILE_PHYS)) {
+		if (tmp) {
+			tmp_pa = rb_entry(tmp, struct ext4_prealloc_space,
+					    pa_node.inode_node);
+		} else {
 			/*
-			 * Since PAs don't overlap, we won't find any
-			 * other PA to satisfy this.
+			 * If there is no adjacent pa to the left then finding
+			 * an overlapping pa is not possible hence stop searching
+			 * inode pa tree
 			 */
-			break;
+			goto try_group_pa;
 		}
+	}
 
-		/* found preallocated blocks, use them */
+	BUG_ON(!(tmp_pa && tmp_pa->pa_lstart <= ac->ac_o_ex.fe_logical));
+
+	/*
+	 * Step 3: If the left adjacent pa is deleted, keep moving left to find
+	 * the first non deleted adjacent pa. After this step we should have a
+	 * valid tmp_pa which is guaranteed to be non deleted.
+	 */
+	for (iter = &tmp_pa->pa_node.inode_node;; iter = rb_prev(iter)) {
+		if (!iter) {
+			/*
+			 * no non deleted left adjacent pa, so stop searching
+			 * inode pa tree
+			 */
+			goto try_group_pa;
+		}
+		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
+				  pa_node.inode_node);
 		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_deleted == 0 && tmp_pa->pa_free &&
-		    likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
-			atomic_inc(&tmp_pa->pa_count);
-			ext4_mb_use_inode_pa(ac, tmp_pa);
+		if (tmp_pa->pa_deleted == 0) {
+			/*
+			 * We will keep holding the pa_lock from
+			 * this point on because we don't want group discard
+			 * to delete this pa underneath us. Since group
+			 * discard is anyways an ENOSPC operation it
+			 * should be okay for it to wait a few more cycles.
+			 */
+			break;
+		} else {
 			spin_unlock(&tmp_pa->pa_lock);
-			read_unlock(&ei->i_prealloc_lock);
-			return true;
 		}
+	}
+
+	BUG_ON(!(tmp_pa && tmp_pa->pa_lstart <= ac->ac_o_ex.fe_logical));
+	BUG_ON(tmp_pa->pa_deleted == 1);
+
+	/*
+	 * Step 4: We now have the non deleted left adjacent pa. Only this
+	 * pa can possibly satisfy the request hence check if it overlaps
+	 * original logical start and stop searching if it doesn't.
+	 */
+	tmp_pa_end = (loff_t)tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+
+	if (ac->ac_o_ex.fe_logical >= tmp_pa_end) {
+		spin_unlock(&tmp_pa->pa_lock);
+		goto try_group_pa;
+	}
+
+	/* non-extent files can't have physical blocks past 2^32 */
+	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
+	    (tmp_pa->pa_pstart + EXT4_C2B(sbi, tmp_pa->pa_len) >
+	     EXT4_MAX_BLOCK_FILE_PHYS)) {
+		/*
+		 * Since PAs don't overlap, we won't find any other PA to
+		 * satisfy this.
+		 */
 		spin_unlock(&tmp_pa->pa_lock);
+		goto try_group_pa;
+	}
+
+	if (tmp_pa->pa_free && likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
+		atomic_inc(&tmp_pa->pa_count);
+		ext4_mb_use_inode_pa(ac, tmp_pa);
+		spin_unlock(&tmp_pa->pa_lock);
+		read_unlock(&ei->i_prealloc_lock);
+		return true;
+	} else {
+		/*
+		 * We found a valid overlapping pa but couldn't use it because
+		 * it had no free blocks. This should ideally never happen
+		 * because:
+		 *
+		 * 1. When a new inode pa is added to rbtree it must have
+		 *    pa_free > 0 since otherwise we won't actually need
+		 *    preallocation.
+		 *
+		 * 2. An inode pa that is in the rbtree can only have it's
+		 *    pa_free become zero when another thread calls:
+		 *      ext4_mb_new_blocks
+		 *       ext4_mb_use_preallocated
+		 *        ext4_mb_use_inode_pa
+		 *
+		 * 3. Further, after the above calls make pa_free == 0, we will
+		 *    immediately remove it from the rbtree in:
+		 *      ext4_mb_new_blocks
+		 *       ext4_mb_release_context
+		 *        ext4_mb_put_pa
+		 *
+		 * 4. Since the pa_free becoming 0 and pa_free getting removed
+		 * from tree both happen in ext4_mb_new_blocks, which is always
+		 * called with i_data_sem held for data allocations, we can be
+		 * sure that another process will never see a pa in rbtree with
+		 * pa_free == 0.
+		 */
+		WARN_ON_ONCE(tmp_pa->pa_free == 0);
 	}
+	spin_unlock(&tmp_pa->pa_lock);
+try_group_pa:
 	read_unlock(&ei->i_prealloc_lock);
 
 	/* can we use group allocation? */
-- 
2.31.1

