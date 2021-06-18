Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D923AC981
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 13:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhFRLMe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 07:12:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233264AbhFRLMd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IB3mb6019680;
        Fri, 18 Jun 2021 07:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SR/lXVzgeL9qm56sESRUS/uMx8ja3zNrnlNN0a7ugDA=;
 b=bj0yjKizxoaoW+9MfYaS1DqHtb5ulXr8lqcov46IEgyNciSwYqnbS48MaL219vfc7SoI
 QSLkc8rfBPv1IgHAfXvICL735owP0dMtlHQTxCF/q9HpYypTvD4PXK4WeqeI8Xh/YJkm
 uxeUARYW75S9FWzXHIMQkhio1GfNX24854HhQ+6fYSL3Xh3JK1Gi0uzmHDGNY0cS8EK1
 XiHRYyeZpfhKnZfpejKa97LRIyWHXRG8Xi6XwjYhUgY8fHii32AwVvIbGOYVTlsNh/kc
 9SRA7nscRtNX4iH2J7QrEheAKSHhyw08jixuCjT9S7tkLu3i5j+CHdAiYjsQ8IgPVrcQ DA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398s44jap3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 07:10:22 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IB9Akg026749;
        Fri, 18 Jun 2021 11:10:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 394m6h9te4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:10:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IBAH4731523244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 11:10:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6E5AAE04D;
        Fri, 18 Jun 2021 11:10:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84D20AE045;
        Fri, 18 Jun 2021 11:10:17 +0000 (GMT)
Received: from localhost (unknown [9.85.68.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 11:10:17 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 6/9] xfs/cfg/64K: Add a config file with 64K blocksize
Date:   Fri, 18 Jun 2021 16:39:57 +0530
Message-Id: <52f2ee6dd0517582f8642d51f20dfe8e665d98d3.1624007533.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624007533.git.riteshh@linux.ibm.com>
References: <cover.1624007533.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YcT45KJ-3qEpefyOC8OEquvSVTcRnS_y
X-Proofpoint-GUID: YcT45KJ-3qEpefyOC8OEquvSVTcRnS_y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_04:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=849 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106180064
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This adds a 64K blocksize config file for xfs testing.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/64k | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/64k

diff --git a/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/64k b/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/64k
new file mode 100644
index 0000000..3666d02
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/64k
@@ -0,0 +1,3 @@
+SIZE=small
+export XFS_MKFS_OPTIONS="-bsize=65536"
+TESTNAME="XFS 64k block"
-- 
2.31.1

