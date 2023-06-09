Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC9172970B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jun 2023 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbjFIKgs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Jun 2023 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbjFIKgW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Jun 2023 06:36:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86021A4;
        Fri,  9 Jun 2023 03:34:27 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359AMOje006735;
        Fri, 9 Jun 2023 10:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7uZG4P8ISVDtnNhJ+xnd3/B7iAy5dGQuZAAOlgdFs/0=;
 b=XXpaaGKzWnu16VuKcCu57iVXByYnEogGiGUpzFbQ3apaT+5ePxY6WSNhBM5Y60vrRpez
 Mk0TAq2TbuD6+vC9aH8s88t+ZKQlbYiFLksBERVnU/teDctXBHgReHOFEJPVq+2uedAm
 r/dS+ZiCA/pI5t9SX1Ls6j6Vq3YWt26W2eoLOui/2ZQjgQ8rhejkTZIjX5BKe0PDKNAL
 2cs1/3XcV19w0zEUbJEz2Ofvww4MitGoc8/VQS3s2kCSQR5yua5JFh2t6FmbqxpKE9KG
 E0n9yqn0/IFLVA8CGBSx3ykRO+hAGdfz7ugR/rfDx5tsAJHdAiQlO+LeGbW42MaFBBQZ FA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r4293r71p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:34:17 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3593IovL030871;
        Fri, 9 Jun 2023 10:34:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3r2a791bad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:34:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 359AYDSe21037806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 10:34:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CC3C20043;
        Fri,  9 Jun 2023 10:34:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E42120040;
        Fri,  9 Jun 2023 10:34:11 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.171.3.58])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  9 Jun 2023 10:34:11 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>
Subject: [PATCH] ext4: fix off by one issue in ext4_mb_choose_next_group_best_avail()
Date:   Fri,  9 Jun 2023 16:04:03 +0530
Message-Id: <20230609103403.112807-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EadNiE6X3iy49gkthzpPTeP8y2Xpksu5
X-Proofpoint-ORIG-GUID: EadNiE6X3iy49gkthzpPTeP8y2Xpksu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ext4_mb_choose_next_group_best_avail(), we want the start order to be
1 less than goal length and the min_order to be, at max, 1 more than the
original length. This commit fixes an off by one issue that arose due to
the fact that 1 << fls(n) > (n).

After all the processing:

order = 1 order below goal len
min_order = maximum of the three:-
             - order - trim_order
             - 1 order below B2C(s_stripe)
             - 1 order above original len

Fixes: 33122aa930 ("ext4: Add allocation criteria 1.5 (CR1_5)")
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4f2a1df98141..d890495127d8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1007,14 +1007,11 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 	 * fls() instead since we need to know the actual length while modifying
 	 * goal length.
 	 */
-	order = fls(ac->ac_g_ex.fe_len);
+	order = fls(ac->ac_g_ex.fe_len) - 1;
 	min_order = order - sbi->s_mb_best_avail_max_trim_order;
 	if (min_order < 0)
 		min_order = 0;
 
-	if (1 << min_order < ac->ac_o_ex.fe_len)
-		min_order = fls(ac->ac_o_ex.fe_len) + 1;
-
 	if (sbi->s_stripe > 0) {
 		/*
 		 * We are assuming that stripe size is always a multiple of
@@ -1022,9 +1019,16 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 		 */
 		num_stripe_clusters = EXT4_NUM_B2C(sbi, sbi->s_stripe);
 		if (1 << min_order < num_stripe_clusters)
-			min_order = fls(num_stripe_clusters);
+			/*
+			 * We consider 1 order less because later we round
+			 * up the goal len to num_stripe_clusters
+			 */
+			min_order = fls(num_stripe_clusters) - 1;
 	}
 
+	if (1 << min_order < ac->ac_o_ex.fe_len)
+		min_order = fls(ac->ac_o_ex.fe_len);
+
 	for (i = order; i >= min_order; i--) {
 		int frag_order;
 		/*
@@ -1038,9 +1042,6 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 			/*
 			 * Try to round up the adjusted goal to stripe size
 			 * (in cluster units) multiple for efficiency.
-			 *
-			 * XXX: Is s->stripe always a power of 2? In that case
-			 * we can use the faster round_up() variant.
 			 */
 			ac->ac_g_ex.fe_len = roundup(ac->ac_g_ex.fe_len,
 						     num_stripe_clusters);
-- 
2.31.1

