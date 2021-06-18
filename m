Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1643AC980
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 13:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhFRLMd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 07:12:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233132AbhFRLMc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IB3svw106617;
        Fri, 18 Jun 2021 07:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Y0HoqDfeHPpataXodm2Dv2hiy5ZVDGvEtciap5BzZ8o=;
 b=AiGtWxzotLq7FVJJDXkqVDyX5v6VHB+vnphSn4yQdexDNox8q7ybmi2o4ES1ojrvvt94
 aD2z3fI5hP2C81etuFWUjyiFIA5J37kr1JHAlEDvJu8Ch+Z61UsnNr41Csf1KQY2LzhS
 in2GPLwaiqu7UZCfjxa3pGyDsQedkttAA4YmE5inonmFj4UpCOof3gVZ6h2nLC7e/8zk
 5yEf+MXXaKfk5FAKccWy6xJiXjx1IS7Auv3POwbAtujZ1YBPUEBBtZ2oJQ08FA0ABO+9
 mHv22Dx+Gtsfbvj6BmSOR0XKys9JUpj7DJ5MeqMVx6iGVecXcvGHS6/wNhRiwA0/Njc+ ww== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398retuj6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 07:10:21 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IB8ruR028765;
        Fri, 18 Jun 2021 11:10:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 394mj8u8s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:10:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IBAGZ516384332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 11:10:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E39BAE053;
        Fri, 18 Jun 2021 11:10:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BA93AE051;
        Fri, 18 Jun 2021 11:10:16 +0000 (GMT)
Received: from localhost (unknown [9.85.68.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 11:10:16 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 5/9] xfs/cfg/dax: Fix this config to work on 64K pagesize platform too
Date:   Fri, 18 Jun 2021 16:39:56 +0530
Message-Id: <44fca888a4a6c5d628773efbe98ec53cc1bbf7e3.1624007533.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624007533.git.riteshh@linux.ibm.com>
References: <cover.1624007533.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xu909pJwa-DJtobuQ6vSI3Y1_JKDEVRj
X-Proofpoint-ORIG-GUID: Xu909pJwa-DJtobuQ6vSI3Y1_JKDEVRj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_04:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106180064
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

w/o this patch XFS DAX tests fails on 64K pagesize platform like PPC64.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/dax | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/dax b/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/dax
index 6c85796..3a12ad2 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/dax
+++ b/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/dax
@@ -2,6 +2,6 @@ export TEST_DEV=/dev/pmem0
 export TEST_DIR=$SM_TST_MNT
 export SCRATCH_DEV=/dev/pmem1
 export SCRATCH_MNT=$SM_SCR_MNT
-export XFS_MKFS_OPTIONS="-bsize=4096 -mreflink=0"
+export XFS_MKFS_OPTIONS="-bsize=$(getconf PAGE_SIZE) -mreflink=0"
 export XFS_MOUNT_OPTIONS="-o dax"
 TESTNAME="XFS using DAX"
-- 
2.31.1

