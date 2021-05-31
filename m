Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F89395440
	for <lists+linux-ext4@lfdr.de>; Mon, 31 May 2021 05:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEaDu7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 May 2021 23:50:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230006AbhEaDu7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 30 May 2021 23:50:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14V3YhjK170449;
        Sun, 30 May 2021 23:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vh2cIsmSvr1efqQoUaiP035+94Z+NWLtoAPD8ruttHY=;
 b=fPorvUKSxJQjf16nqtgvym8dgKnms2wc6ddVmqG+fSviHFBx7mDht+SjTd2Vm8s2wxVY
 MPjHYqU0Z7vYdo2IuTPXYl54ztHmcNMWNmSZS9IWdD1zokT8f2RsLTBX+2DyryH5eGuM
 h0r9LkIDbLc9zA7kEDXAZxhiq9W5HqXmI2NASAQlekN8dQ4cK5ZZJSYnwOiy095/nXpq
 xpdZMPiGU9mphNzKes5Uejz2pU05EJ0DZ+0tU7Z/bps1V5IRR/NhDmXOpGKigRlGoSZA
 1Hy2yw5XYbHbFzBwfDHcScRCDX+9vQ5DK1CHuye0+2T70wXE4LcWPIS17YxacrKXK+/8 eA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38vqrx8dp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 May 2021 23:49:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14V3hBow021237;
        Mon, 31 May 2021 03:49:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 38ucvh8r52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 03:49:13 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14V3nADK21102884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 03:49:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6FF44C040;
        Mon, 31 May 2021 03:49:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 566C64C046;
        Mon, 31 May 2021 03:49:10 +0000 (GMT)
Received: from localhost (unknown [9.79.215.216])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 May 2021 03:49:10 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH] ext4: fsmap: Fix the block/inode bitmap comment
Date:   Mon, 31 May 2021 09:19:08 +0530
Message-Id: <e79134132db7ea42f15747b5c669ee91cc1aacdf.1622432690.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hff8sh0t1SZ7LSSSaSYwLkG5tV1YD-L_
X-Proofpoint-ORIG-GUID: hff8sh0t1SZ7LSSSaSYwLkG5tV1YD-L_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-31_02:2021-05-27,2021-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=795 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105310026
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

While debugging fstest ext4/027 failure, found below comment to be wrong and
confusing. Hence fix it while we are at it.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/fsmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fsmap.h b/fs/ext4/fsmap.h
index 68c8001fee85..ac642be2302e 100644
--- a/fs/ext4/fsmap.h
+++ b/fs/ext4/fsmap.h
@@ -50,7 +50,7 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 #define EXT4_FMR_OWN_INODES	FMR_OWNER('X', 5) /* inodes */
 #define EXT4_FMR_OWN_GDT	FMR_OWNER('f', 1) /* group descriptors */
 #define EXT4_FMR_OWN_RESV_GDT	FMR_OWNER('f', 2) /* reserved gdt blocks */
-#define EXT4_FMR_OWN_BLKBM	FMR_OWNER('f', 3) /* inode bitmap */
-#define EXT4_FMR_OWN_INOBM	FMR_OWNER('f', 4) /* block bitmap */
+#define EXT4_FMR_OWN_BLKBM	FMR_OWNER('f', 3) /* block bitmap */
+#define EXT4_FMR_OWN_INOBM	FMR_OWNER('f', 4) /* inode bitmap */
 
 #endif /* __EXT4_FSMAP_H__ */
-- 
2.31.1

