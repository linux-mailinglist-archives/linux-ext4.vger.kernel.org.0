Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666C37DE41B
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Nov 2023 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjKAPrl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Nov 2023 11:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjKAPrj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Nov 2023 11:47:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8874F11D;
        Wed,  1 Nov 2023 08:47:27 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1FiM5g017490;
        Wed, 1 Nov 2023 15:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rieV4Xr0SXCwizv+l8KgkkxVPiD43mXrdwoEie+1NqU=;
 b=RX853iI0j5szNFg3C7k/UDG9CuzRKPWi25d8sxn2eXeHWBlZU0TO1nGk8L5ltIFrX3Nr
 lie5cJr0JptHI1w5H2fUsS/vEDXin5vbYHjS342TsTtJA/D6zMFfdcxyQJKB2wk47CR1
 EoyEmnqilL/QYvNuq/dtevP84BGCWMsvUmjMS8tPPEPH+WPDOSSlb15/OXHs+Y7pnv5O
 KTP0Xz4QEjUWlXq/LNtgnqHLqGTtwcj0U04hGygXPBkit4z8+sGNlrx5hhMmC2JjivgI
 bC/vAgzP1ZXZjE4g7j1/DWqImPmE0cU+fSJbEmQbrLh9eCe7DniA5/E8pOYg3UZsdPH6 iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3sk4025w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 15:47:25 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A1FkXL0025065;
        Wed, 1 Nov 2023 15:47:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3sk4025s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 15:47:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1Eps7k031391;
        Wed, 1 Nov 2023 15:47:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1fb27y71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 15:47:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A1FlMCS17105624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 15:47:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D3442004B;
        Wed,  1 Nov 2023 15:47:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D028920040;
        Wed,  1 Nov 2023 15:47:20 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.9.163])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Nov 2023 15:47:20 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Enable dioread_nolock as default for bs < ps case
Date:   Wed,  1 Nov 2023 21:17:17 +0530
Message-Id: <20231101154717.531865-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QUcy2Ap6G6he6lEHHaNXlVYW-8l_Z4z4
X-Proofpoint-GUID: 5Qo8IxzH_mYmhlIQh14hqphb-mXYQ-dm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_13,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxlogscore=859
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

dioread_nolock was originally disabled as a default option for bs < ps
scenarios due to a data corruption issue. Since then, we've had some
fixes in this area which address such issues. Enable dioread_nolock by
default and remove the experimental warning message for bs < ps path.

dioread for bs < ps has been tested on a 64k pagesize machine using:

kvm-xfstest -C 3 -g auto

with the following configs:

64k adv bigalloc_4k bigalloc_64k data_journal encrypt
dioread_nolock dioread_nolock_4k ext3 ext3conv nojournal

And no new regressions were seen compared to baseline kernel.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/super.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d062383ea50e..99c8ae97112c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2785,15 +2785,6 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 		return -EINVAL;
 	}
 
-	if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DIOREAD_NOLOCK)) {
-		int blocksize =
-			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
-		if (blocksize < PAGE_SIZE)
-			ext4_msg(NULL, KERN_WARNING, "Warning: mounting with an "
-				 "experimental mount option 'dioread_nolock' "
-				 "for blocksize < PAGE_SIZE");
-	}
-
 	err = ext4_check_test_dummy_encryption(fc, sb);
 	if (err)
 		return err;
@@ -4402,7 +4393,7 @@ static void ext4_set_def_opts(struct super_block *sb,
 	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
 		set_opt(sb, DELALLOC);
 
-	if (sb->s_blocksize == PAGE_SIZE)
+	if (sb->s_blocksize <= PAGE_SIZE)
 		set_opt(sb, DIOREAD_NOLOCK);
 }
 
-- 
2.39.3

