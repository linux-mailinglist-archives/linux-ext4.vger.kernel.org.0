Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE720716278
	for <lists+linux-ext4@lfdr.de>; Tue, 30 May 2023 15:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjE3NqW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 May 2023 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjE3NqV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 May 2023 09:46:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1354E52;
        Tue, 30 May 2023 06:45:46 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UBkADs020995;
        Tue, 30 May 2023 12:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vKqk5VAlWO7T7apoxgtfCz1rQzInq/ixcvszJqIQEaI=;
 b=pxn88Zqh83rsEZNa/XC4dsTq2rxNi4kutSspmJOGFJltL26ZrCXleFcjBTGSkHt4RY6R
 lzfUnhqHzY0T8ltiQJNkzPX0M4eOKqNyumYyDuc6UZ96Ef7/pvl5LhxRas+FP1hIm6mp
 6pfnMElFFhZa8Qzt2MOSt10dv9IVh9iamw/MzonyOvCg7G0EaGa4r3IfJ5uMsVqAkK2v
 +rE+/Zm437KwpyJEd8kvuKrLCuz0WEidh/4GadCtsl/bMZCztijQMn5cTUhv30S+ZHzQ
 ekWZq5w7NY+a9/xDBOtRr0geNCm1yE2bFgBihpTsx+bawmRPOChMGa1EOjT2LK1QuYJV lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwbst1e1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:12 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UCGPwO030742;
        Tue, 30 May 2023 12:34:12 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwbst1dyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:12 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U30Gkv021816;
        Tue, 30 May 2023 12:34:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qu9g5183x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCY76136111094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:34:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4700420043;
        Tue, 30 May 2023 12:34:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4438920040;
        Tue, 30 May 2023 12:34:05 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:34:05 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 06/12] ext4: Add counter to track successful allocation of goal length
Date:   Tue, 30 May 2023 18:03:44 +0530
Message-Id: <343620e2be8a237239ea2613a7a866ee8607e973.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QNhsF3hkGIQzvuc7Ao8pzSztLvLlzWxR
X-Proofpoint-GUID: SmM8nCuuuJbtAKCmR1X7DXcHA2AdVcrD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Track number of allocations where the length of blocks allocated is equal to the
length of goal blocks (post normalization). This metric could be useful if
making changes to the allocator logic in the future as it could give us
visibility into how often do we trim our requests.

PS: ac_b_ex.fe_len might get modified due to preallocation efforts and
hence we use ac_f_ex.fe_len instead since we want to compare how much the
allocator was able to actually find.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    | 1 +
 fs/ext4/mballoc.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2df4189ef778..eae981ab2539 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1556,6 +1556,7 @@ struct ext4_sb_info {
 	atomic_t s_bal_cX_ex_scanned[EXT4_MB_NUM_CRS];	/* total extents scanned */
 	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
 	atomic_t s_bal_goals;	/* goal hits */
+	atomic_t s_bal_len_goals;	/* len goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
 	atomic_t s_bal_2orders;	/* 2^order hits */
 	atomic_t s_bal_cr0_bad_suggestions;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a3106607486f..73e98a4d01f5 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2966,6 +2966,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 		   atomic64_read(&sbi->s_bal_cX_failed[CR3]));
 	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
 	seq_printf(seq, "\t\tgoal_hits: %u\n", atomic_read(&sbi->s_bal_goals));
+	seq_printf(seq, "\t\tlen_goal_hits: %u\n", atomic_read(&sbi->s_bal_len_goals));
 	seq_printf(seq, "\t\t2^n_hits: %u\n", atomic_read(&sbi->s_bal_2orders));
 	seq_printf(seq, "\t\tbreaks: %u\n", atomic_read(&sbi->s_bal_breaks));
 	seq_printf(seq, "\t\tlost: %u\n", atomic_read(&sbi->s_mb_lost_chunks));
@@ -4420,6 +4421,8 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
 		if (ac->ac_g_ex.fe_start == ac->ac_b_ex.fe_start &&
 				ac->ac_g_ex.fe_group == ac->ac_b_ex.fe_group)
 			atomic_inc(&sbi->s_bal_goals);
+		if (ac->ac_f_ex.fe_len == ac->ac_g_ex.fe_len)
+			atomic_inc(&sbi->s_bal_len_goals);
 		if (ac->ac_found > sbi->s_mb_max_to_scan)
 			atomic_inc(&sbi->s_bal_breaks);
 	}
-- 
2.31.1

