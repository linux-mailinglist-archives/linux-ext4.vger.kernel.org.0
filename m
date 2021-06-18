Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B2B3AC97F
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhFRLMc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 07:12:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230441AbhFRLMa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IB3sSV106636;
        Fri, 18 Jun 2021 07:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0urVU+0t17nboPM5gabBBN4Hi9aABLAQwpeO0QF3gGc=;
 b=UU8fDkqkKRwsUghfWGqbUmdmymAN8BroD6L0uNcrNw6V45z5OeISTB6X9DisLgzOIUFA
 BoNaJWg7GFwUnTOhCa/RXxadWzGhkQMozWFqmCY9mr/u1j4BkRxo8HIHsEALpbiL8WUy
 YGkZT2XVolEtoMDykWLsyL1YTVrFA+iCU/us2g2ReiAE3TQxF+wWgY0LSpTyOW7bWi7C
 KVMmXIGQa4aZwO06U6jpOU6u+NZbYYYp8/HVtPqPbKICBSOMffggdSC4QoId7s+9jMeS
 VqrPAHCLIse3BVZHw9OALOw0rgbc+D17/lEXZfxzkYY+ylrihn9614mj0DXFRNoowY9x wA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398retuj5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 07:10:19 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IB9jd5012105;
        Fri, 18 Jun 2021 11:10:17 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 394mj8u8xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:10:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IB97NC36503840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 11:09:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5903EAE04D;
        Fri, 18 Jun 2021 11:10:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01299AE056;
        Fri, 18 Jun 2021 11:10:15 +0000 (GMT)
Received: from localhost (unknown [9.85.68.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 11:10:14 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 4/9] ext4/cfg/fast_commit_64K: Add a config file to test fast_commit with 64K bs
Date:   Fri, 18 Jun 2021 16:39:55 +0530
Message-Id: <b5db2fa26f67fa0373f2b4d4792f9038c845b4cd.1624007533.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624007533.git.riteshh@linux.ibm.com>
References: <cover.1624007533.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R1oMYxfmy8ZLPJMQbHJRde_DhOYiNmJV
X-Proofpoint-ORIG-GUID: R1oMYxfmy8ZLPJMQbHJRde_DhOYiNmJV
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

This can be used to test fast_commit with 64K blocksize on
platforms like PPC64.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 .../test-appliance/files/root/fs/ext4/cfg/fast_commit_64k     | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/fast_commit_64k

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/fast_commit_64k b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/fast_commit_64k
new file mode 100644
index 0000000..4b0d3b1
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/fast_commit_64k
@@ -0,0 +1,4 @@
+SIZE=small
+export EXT_MKFS_OPTIONS="-b 65536 -I 256 -O fast_commit,64bit"
+export EXT_MOUNT_OPTIONS=""
+TESTNAME="Ext4 64k block w/fast_commit"
-- 
2.31.1

