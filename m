Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6307427AA
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjF2Nrr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjF2Nrq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jun 2023 09:47:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CC63588;
        Thu, 29 Jun 2023 06:47:45 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TDiliY003116;
        Thu, 29 Jun 2023 13:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dbRiAIZ0g8cUPtf7bZFwLT9yLNoqZAhs7QkDidxTlAk=;
 b=ajX6+rkx6KLqsqwDCB5WeM4DqMS1DWnoeCPBhtJ4TJXOdNcmWPKHhXJgb5Y7/4PAe8kg
 XLIBD/Qp5I6LuYjBn6koBrcqxLALhpAqSVhgaQd310nBDRDqdM7fFyv+jEoNzd957kIX
 o6/UmCnCet+KGUEprwYrBYcs0EqiO9zp5Nx5xX9X+VvkXsbY1smqjAwh725q5sL5JogC
 EHCj12ktc170T22oAMRAfpGLzM4ezIBE8qDe8/O1AlquX+QXbZ1rD1AEJ1sCIDM0JFOW
 Lv1x9E+PHTFC5JRgoWVxZBL9uScO/4G9nsaVAXvar9BFCcAHonStsMWtRH3aqpldKiQ+ Hw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhb3u04yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 13:47:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35T7voGf003733;
        Thu, 29 Jun 2023 13:47:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr453cd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 13:47:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35TDlNDx43451020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 13:47:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 847A02004D;
        Thu, 29 Jun 2023 13:47:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBF0D20040;
        Thu, 29 Jun 2023 13:47:21 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.95.242])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jun 2023 13:47:21 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>
Subject: [PATCH] ext4: Replace CR_FAST macro with inline function for readability
Date:   Thu, 29 Jun 2023 19:17:19 +0530
Message-Id: <20230629134719.108104-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xr3wRvvdaDjVBLg7-_5mr_6rGqNTZZe4
X-Proofpoint-ORIG-GUID: Xr3wRvvdaDjVBLg7-_5mr_6rGqNTZZe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290122
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
---
 fs/ext4/ext4.h    | 7 ++++---
 fs/ext4/mballoc.c | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

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
index a2475b8c9fb5..94fdcc757aa9 100644
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
@@ -2630,7 +2630,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	free = grp->bb_free;
 	if (free == 0)
 		goto out;
-	if (cr <= CR_FAST && free < ac->ac_g_ex.fe_len)
+	if (cr <= CR_GOAL_LEN_SLOW && free < ac->ac_g_ex.fe_len)
 		goto out;
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		goto out;
@@ -2654,7 +2654,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		 * sure we locate metadata blocks in the first block group in
 		 * the flex_bg if possible.
 		 */
-		if (cr < CR_FAST &&
+		if (!ext4_mb_cr_expensive(cr) &&
 		    (!sbi->s_log_groups_per_flex ||
 		     ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &&
 		    !(ext4_has_group_desc_csum(sb) &&
@@ -2848,7 +2848,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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

