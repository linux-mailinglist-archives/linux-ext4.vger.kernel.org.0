Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DCF3AC97C
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 13:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhFRLM0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 07:12:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhFRLM0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:26 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IB3geh035518;
        Fri, 18 Jun 2021 07:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yOZoIrIghmoW8iM29hRfZ45wNEKTKBf98wagoF026Wk=;
 b=BEoOvgb0iHvqgluWiAX5+d6NH2f9cSx5KTPJRxVJn8UPtFJ+j0VJ+Dd8hcflkvEK1qud
 fmUHZpQbPH7kTuBDcGfqhUFmpGA5n57X6DmfneLyNqgTSjpDKlzG4BH/9FcyQMWC5NPY
 8IczYDnR0m0K8pZWOX+AvU96t0D9JUta+R5mYSVei81iY5Elv95nW6ugCzhf20zBE/VH
 y1glyy2lVcXD7nh/N4ZHqRwpU2bt2XQgAjzDo3LQC0surpfvx+qFbQGdBiv6oPZTT+8S
 UAhhKM3MHX/DwX3TzclGKQtBF/IjnDThWkzYjP1r+HdDPoP0OMLrVRmt/mYIxDIEi5kw EQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398hn76etg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 07:10:15 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IBA0cx029267;
        Fri, 18 Jun 2021 11:10:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 394mj8u8s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:10:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IBABX920578586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 11:10:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47EAFAE045;
        Fri, 18 Jun 2021 11:10:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E503CAE057;
        Fri, 18 Jun 2021 11:10:10 +0000 (GMT)
Received: from localhost (unknown [9.85.68.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 11:10:10 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/9] ext4/cfg/dax: Fix for 64K pagesize platform
Date:   Fri, 18 Jun 2021 16:39:52 +0530
Message-Id: <44ec9ffa86474eec5263a0f420cee33380dbe89b.1624007533.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624007533.git.riteshh@linux.ibm.com>
References: <cover.1624007533.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QYsoB7RsCeEbUfgMURqSdBnaFHGiWtx2
X-Proofpoint-GUID: QYsoB7RsCeEbUfgMURqSdBnaFHGiWtx2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_04:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=912
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180064
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For dax we need blocksize same as pagesize. Hence make changes in this
to get the blocksize via $(getconf PAGE_SIZE) to fix it on 64K pagesize
platforms e.g. POWER.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/dax | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/dax b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/dax
index b46e661..de25d91 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/dax
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/dax
@@ -2,6 +2,6 @@ export TEST_DEV=/dev/pmem0
 export TEST_DIR=$SM_TST_MNT
 export SCRATCH_DEV=/dev/pmem1
 export SCRATCH_MNT=$SM_SCR_MNT
-export EXT_MKFS_OPTIONS="-b 4096"
+export EXT_MKFS_OPTIONS="-b $(getconf PAGE_SIZE)"
 export EXT_MOUNT_OPTIONS="dax"
-TESTNAME="Ext4 4k block using DAX"
+TESTNAME="Ext4 using DAX"
-- 
2.31.1

