Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D267437D4
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jun 2023 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjF3JAO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Jun 2023 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjF3I7v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Jun 2023 04:59:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F195359E;
        Fri, 30 Jun 2023 01:59:47 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U8kI2v006145;
        Fri, 30 Jun 2023 08:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=C+XRnrM6tD10ehACdmcrekJNrOeGwbcFZNLlBDuZfR0=;
 b=A+cucP3sy1xfTkKccmXNy7IwyF4geVplNiVFWG8aNrTKx3MdTXr+GDoTfUlduotQf/mA
 /nLFXDI/KwlXPQVjImmUa+oKOAcesLNwakidIZmxhtCjj0SX9lB22CmFX4071XCDVnzM
 OmLRd2wya40rmE/QM1UCTSKq5r7FRtjudXVqgbgKW7hFIeQAol7LqLv7x7aCDmvM7KiG
 lRixPSuNEl7uvofFdgN5UPAsR+dbPt2TGsm/SzMeVF0nGQOzj7gp71VspnUBGtT6lNcI
 sT70EUS8m8+cVa++0X+G7C7BomIOsbAmN6ht188ELuZP5fydaSzBX9GucBauCVeeKnSl gQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhuu0rdax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 08:59:35 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U3T8Hd017465;
        Fri, 30 Jun 2023 08:59:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rdr45b0c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 08:59:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35U8xUBv21824088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 08:59:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7C4C20040;
        Fri, 30 Jun 2023 08:59:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F17D20043;
        Fri, 30 Jun 2023 08:59:29 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.59.252])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 30 Jun 2023 08:59:29 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>
Subject: [PATCH v2] ext4: Replace CR_FAST macro with inline function for readability
Date:   Fri, 30 Jun 2023 14:29:27 +0530
Message-Id: <20230630085927.140137-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nvo3r_SZz1yog1oe4sjae0__NFzaAn7h
X-Proofpoint-ORIG-GUID: nvo3r_SZz1yog1oe4sjae0__NFzaAn7h
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306300071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Replace CR_FAST with ext4_mb_cr_expensive() inline function for better
readability. This function returns true if the criteria is one of the
expensive/slower ones where lots of disk IO/prefetching is acceptable.

No functional changes are intended in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---

Changes since v1 [1] 

* reworded an if condition in ext_mb_good_group_nolock
  and added a comment to better describe the intent of the 
	condition
* Picked up RVB from Jan.

[1]
https://lore.kernel.org/linux-ext4/ZJ2YIr5EVbz4ezIc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/T/#ma9428de15c4084937274f4d66dcd4d53f505d32a

 fs/ext4/ext4.h    |  7 ++++---
 fs/ext4/mballoc.c | 13 +++++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 45a531446ea2..e404169a2858 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -176,9 +176,6 @@ enum criteria {
 	EXT4_MB_NUM_CRS
 };
 
-/* criteria below which we use fast block scanning and avoid unnecessary IO */
-#define CR_FAST CR_GOAL_LEN_SLOW
-
 /*
  * Flags used in mballoc's allocation_context flags field.
  *
@@ -2924,6 +2921,10 @@ extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
 extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
 extern void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 		       int len, int state);
+static inline bool ext4_mb_cr_expensive(enum criteria cr)
+{
+	return cr >= CR_GOAL_LEN_SLOW;
+}
 
 /* inode.c */
 void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a2475b8c9fb5..542577f621c6 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2446,7 +2446,7 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 			break;
 		}
 
-		if (ac->ac_criteria < CR_FAST) {
+		if (!ext4_mb_cr_expensive(ac->ac_criteria)) {
 			/*
 			 * In CR_GOAL_LEN_FAST and CR_BEST_AVAIL_LEN, we are
 			 * sure that this group will have a large enough
@@ -2630,7 +2630,12 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	free = grp->bb_free;
 	if (free == 0)
 		goto out;
-	if (cr <= CR_FAST && free < ac->ac_g_ex.fe_len)
+	/*
+	 * In all criterias except CR_ANY_FREE we try to avoid groups that
+	 * can't possibly satisfy the full goal request due to insufficient
+	 * free blocks.
+	 */
+	if (cr < CR_ANY_FREE && free < ac->ac_g_ex.fe_len)
 		goto out;
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		goto out;
@@ -2654,7 +2659,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		 * sure we locate metadata blocks in the first block group in
 		 * the flex_bg if possible.
 		 */
-		if (cr < CR_FAST &&
+		if (!ext4_mb_cr_expensive(cr) &&
 		    (!sbi->s_log_groups_per_flex ||
 		     ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &&
 		    !(ext4_has_group_desc_csum(sb) &&
@@ -2848,7 +2853,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			 * spend a lot of time loading imperfect groups
 			 */
 			if ((prefetch_grp == group) &&
-			    (cr >= CR_FAST ||
+			    (ext4_mb_cr_expensive(cr) ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
 				nr = sbi->s_mb_prefetch;
 				if (ext4_has_feature_flex_bg(sb)) {
-- 
2.31.1

