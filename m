Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426863A5D2A
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 08:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhFNGat (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 02:30:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232496AbhFNGaq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 02:30:46 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E63hUx016077;
        Mon, 14 Jun 2021 02:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=q0Tn7eos6XPNRvYOKCBT93r3PKKxbsJngPoWRexw2bc=;
 b=O588Yhu9mxkghYVffC8o26p1G1qC5aB51KNrG9EDlDwqls6QX5x/4YwveceRmzUYEXxh
 4OVXgLcFtJSVe1Ayst5G4CqaThlJUE4ID6dTVvdxGM6ptpnjxrqmVx5VS0/U3RhRiL6w
 wnVazzrqDfo5iZjiWPKiuAQ0rLW3e9iSrEIdpjyUhoteWZWskPdTPZWfcKGqiLr1KkRV
 ly8+yGw+SIeM76L9Tuu8IsvPKcsW4lyJHsJbucR75VLHK/n8c8VrnQNRYj5Wfz6O9rgS
 JHmxzychlgEC1au2E/wiexuiXUPwTcDFqVyYZZBpjvj3xp+GUXQD3RWlrheKHkNGusVY cw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 395xnqmavr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:28:44 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E6OJTc014174;
        Mon, 14 Jun 2021 06:28:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 394mj90d9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 06:28:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E6Scnl29557098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:28:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4C3542049;
        Mon, 14 Jun 2021 06:28:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 840C74203F;
        Mon, 14 Jun 2021 06:28:38 +0000 (GMT)
Received: from localhost (unknown [9.85.68.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 06:28:38 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 4/9] ext4/022: exclude this test for dax config on 64KB pagesize platform
Date:   Mon, 14 Jun 2021 11:58:08 +0530
Message-Id: <f956243c84dcc77d8c301d0ec956c68d9076bbcb.1623651783.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623651783.git.riteshh@linux.ibm.com>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9UIVwm01fqozGwnH13aZFFdNOI8dzw0H
X-Proofpoint-GUID: 9UIVwm01fqozGwnH13aZFFdNOI8dzw0H
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140045
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test case assumes blocksize to be 4KB and hence it fails
to mount with "-o dax" option on a 64kb pagesize platform (e.g. PPC64).
This leads to test case reported as failed with dax config on PPC64.

This patch exclude this test when pagesize is 64KB and for dax config.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/022 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/022 b/tests/ext4/022
index 3de7619a..ca58f34e 100755
--- a/tests/ext4/022
+++ b/tests/ext4/022
@@ -41,10 +41,13 @@ _require_dumpe2fs
 _require_command "$DEBUGFS_PROG" debugfs
 _require_attrs
 
-# Use large inodes to have enough space for experimentation
-INODE_SIZE=1024
 # Block size
 BLOCK_SIZE=4096
+if [[ $(get_page_size) -ne $BLOCK_SIZE ]]; then
+       _exclude_scratch_mount_option dax
+fi
+# Use large inodes to have enough space for experimentation
+INODE_SIZE=1024
 # We leave this amount of bytes for xattrs
 XATTR_SPACE=256
 # We grow extra_isize by this much
-- 
2.31.1

