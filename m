Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099903AC97E
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 13:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhFRLM3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 07:12:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230441AbhFRLM2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:28 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IB3omT162961;
        Fri, 18 Jun 2021 07:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SckmTUykzv5X7/KeinHrP4w5g6FLpQcgM/pNp6sHEJM=;
 b=UR4yJaB0AyxltjZzhdfuuVdrvc06k2Fq93Ozz6UY0B4BJqexu9nIt+66N/HfdYtG2Ps7
 7FEqYwX/BX3ORpJPqP7qg6/Tad+wHICvqkLfrDvIv3gnXFrEftP3LWkANfIf6gfQ5XLt
 R384IWYt/to4IuYz0jwILR81Qu9PPdLeP3bY41XUNLDFsCbrk6uHIVdoL6+irdYOHKlw
 IoiSbQUCPKuJn+mXz9x7YU1QgcWPa0gqLc04vRUMPP9fsrh+jSkyCrPtalo1G6J6u/Y0
 uQzl7G0GRk208og5dGbWiSICUWnXgHKebZ+5tII55YNXvJFgLMwvWE7zX/kjY2mdL97m XA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398s8hhuku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 07:10:18 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IB8kWc010187;
        Fri, 18 Jun 2021 11:10:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 394m6hu8qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:10:16 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IB93u035914004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 11:09:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02C57AE051;
        Fri, 18 Jun 2021 11:10:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FBB4AE04D;
        Fri, 18 Jun 2021 11:10:13 +0000 (GMT)
Received: from localhost (unknown [9.85.68.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 11:10:13 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 3/9] ext4/cfg/fast_commit: Add explicit 4k bs option
Date:   Fri, 18 Jun 2021 16:39:54 +0530
Message-Id: <60efcffc39fce13eeb13954a592e2c20d390be02.1624007533.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624007533.git.riteshh@linux.ibm.com>
References: <cover.1624007533.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: onuGaunXsZPha3X2u1Q_LKpidOZm3ThZ
X-Proofpoint-GUID: onuGaunXsZPha3X2u1Q_LKpidOZm3ThZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_04:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=947
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106180064
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test as of now is mainly used to test with 4k blocksize.
Hence add an explicit "-b 4096" option to reflect the same.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/fast_commit | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/fast_commit b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/fast_commit
index 0659c1a..295cda3 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/fast_commit
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/fast_commit
@@ -1,4 +1,4 @@
 SIZE=small
-export EXT_MKFS_OPTIONS="-I 256 -O fast_commit,64bit"
+export EXT_MKFS_OPTIONS="-b 4096 -I 256 -O fast_commit,64bit"
 export EXT_MOUNT_OPTIONS=""
 TESTNAME="Ext4 4k block w/fast_commit"
-- 
2.31.1

