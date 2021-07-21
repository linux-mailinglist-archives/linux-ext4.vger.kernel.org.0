Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7A73D0841
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jul 2021 07:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhGUEry (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jul 2021 00:47:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232249AbhGUErn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Jul 2021 00:47:43 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L53anw142312;
        Wed, 21 Jul 2021 01:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z2IEvzsnBTucRJ0bEs1jXLn59v41h2gNebpr0/oPxgo=;
 b=f2b1gwfsDG5phYf00DGVYkP61vDPk07tc0zxM6vvYqBl/R9RsLiM0cX56i/98/JlKmsQ
 O7ZnU0qZyNdrTL7CUN3dRcarBSijQ3Q2/wtkicS83+GZGTzUWuTo/8S47v3dc3rZIx+j
 jMZnSziTl+Z+79XluGvFps0GmXBke5oxEmj9jPJDZevM2RvL7u0sizfQdH7ICygi1SIL
 DN1eS0ngjaFZFuJ86H2ZD8BoMcsE+VJaqbGweeYaoYIwEzqw8fZAWRD7qtt0gMJ7xQII
 Y04eWA6Q7uJvswMfeD6tSHRu/41LpS2AzhyHDHE2T3V5W1BKYz3LvV4VvzclmLt95kRo og== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39xan7bgj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:28:17 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L5GEFu030534;
        Wed, 21 Jul 2021 05:28:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 39upu8901u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 05:28:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L5SD6O30802294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 05:28:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E63C1AE051;
        Wed, 21 Jul 2021 05:28:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FFBBAE04D;
        Wed, 21 Jul 2021 05:28:12 +0000 (GMT)
Received: from localhost (unknown [9.85.82.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 05:28:12 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 5/9] generic/031: Fix the test case for 64k blocksize config
Date:   Wed, 21 Jul 2021 10:57:58 +0530
Message-Id: <c37a4cfb8a50d2df68369d66ef6e1ebf6533e3ea.1626844259.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626844259.git.riteshh@linux.ibm.com>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z4nERXEnl1oTBpAdJj9ktYtYo_7fsAKK
X-Proofpoint-GUID: z4nERXEnl1oTBpAdJj9ktYtYo_7fsAKK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_02:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test fails with blocksize 64k since the test assumes 4k blocksize
in fcollapse param. This patch fixes that and also tests for 64k
blocksize.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/031     | 14 +++++++++-----
 tests/generic/031.out | 16 ++++++++--------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/tests/generic/031 b/tests/generic/031
index 313ce9ff..11961c54 100755
--- a/tests/generic/031
+++ b/tests/generic/031
@@ -26,11 +26,16 @@ testfile=$SCRATCH_MNT/testfile
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
+# fcollapse need offset and len to be multiple of blocksize for filesystems
+# So let's make the offsets and len required for fcollapse multiples of 64K
+# so that it works for all configurations (including on dax on 64K page size
+# systems)
+fact=$((65536/4096))
 $XFS_IO_PROG -f \
-	-c "pwrite 185332 55756" \
-	-c "fcollapse 28672 40960" \
-	-c "pwrite 133228 63394" \
-	-c "fcollapse 0 4096" \
+	-c "pwrite $((185332*fact + 12)) $((55756*fact + 12))" \
+	-c "fcollapse $((28672 * fact)) $((40960 * fact))" \
+	-c "pwrite $((133228 * fact + 12)) $((63394 * fact + 12))" \
+	-c "fcollapse 0 $((4096 * fact))" \
 $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
@@ -41,4 +46,3 @@ hexdump -C $testfile
 
 status=0
 exit
-
diff --git a/tests/generic/031.out b/tests/generic/031.out
index 194bfa45..7dfcfe41 100644
--- a/tests/generic/031.out
+++ b/tests/generic/031.out
@@ -1,19 +1,19 @@
 QA output created by 031
-wrote 55756/55756 bytes at offset 185332
+wrote 892108/892108 bytes at offset 2965324
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 63394/63394 bytes at offset 133228
+wrote 1014316/1014316 bytes at offset 2131660
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Pre-Remount ===
 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
-0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
-0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+001f86c0  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
+001f86d0  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
 *
-0002fdc0
+002fdc18
 ==== Post-Remount ==
 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
-0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
-0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+001f86c0  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
+001f86d0  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
 *
-0002fdc0
+002fdc18
-- 
2.31.1

