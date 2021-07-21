Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7353D083F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jul 2021 07:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhGUErn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jul 2021 00:47:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhGUErh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Jul 2021 00:47:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L5EVG4030634;
        Wed, 21 Jul 2021 01:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=gfIYQGl9pwnUKP9FGc7nxHIPbu8S7N/shZ66IxgK9a4=;
 b=lS/k+ICqcpOyGwZLvcKcd/fyB71SvuDxWdTzSBVwDJ35u3ospoL/zHo/AsAOIAjTlP11
 d2ypa+Yh6j5nCVdNBCrE7+6bn2kli2iZGwQ5aIn5FdtEX+88h1OwviHIF9TAsUe1EU0C
 TcYs56O94i1XZNUnBtj2evcAL6gmtNoFz8RwTMsdkPziRU8LS/DFnoOaLBQRsMeMylE7
 cXuiP1ABq3ZpUgFtnMXv0A6WjULzRyDSitSKHbEu7EWGQIZkIxaAaeuWh1b3ir5O0fIL
 PaEaQtmaN+dhs4ithWxz4UHLVa6F1oIjanVjiXbpT9oNLo5vxRaHnLouKWeRQem5KNtH 7A== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39xd8k880m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:28:12 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L5DFuh027487;
        Wed, 21 Jul 2021 05:28:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 39upfh90d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 05:28:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L5Pj2w24903992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 05:25:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EC5AAE051;
        Wed, 21 Jul 2021 05:28:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5F1CAE04D;
        Wed, 21 Jul 2021 05:28:07 +0000 (GMT)
Received: from localhost (unknown [9.85.82.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 05:28:07 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 2/9] ext4/027: Correct the right code of block and inode bitmap
Date:   Wed, 21 Jul 2021 10:57:55 +0530
Message-Id: <144ceb12f492e81f781aeddd164e8c3860cfd358.1626844259.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626844259.git.riteshh@linux.ibm.com>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VjEPomlByIgJ-6NN6iv2Q1X_DQo9ovG-
X-Proofpoint-ORIG-GUID: VjEPomlByIgJ-6NN6iv2Q1X_DQo9ovG-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_02:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Observed occasional failure of this test sometimes say with 64k config
and small device size. Reason is we were grepping for wrong values for
inode and block bitmap.

Correct those values according to [1] to fix this test.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/fsmap.h#n53

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/027 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/027 b/tests/ext4/027
index 84e11a29..5bcb2d55 100755
--- a/tests/ext4/027
+++ b/tests/ext4/027
@@ -39,11 +39,11 @@ x=$(grep -c 'static fs metadata' $TEST_DIR/fsmap)
 test $x -gt 0 || echo "No fs metadata?"
 
 echo "Check block bitmap" | tee -a $seqres.full
-x=$(grep -c 'special 102:1' $TEST_DIR/fsmap)
+x=$(grep -c 'special 102:3' $TEST_DIR/fsmap)
 test $x -gt 0 || echo "No block bitmaps?"
 
 echo "Check inode bitmap" | tee -a $seqres.full
-x=$(grep -c 'special 102:2' $TEST_DIR/fsmap)
+x=$(grep -c 'special 102:4' $TEST_DIR/fsmap)
 test $x -gt 0 || echo "No inode bitmaps?"
 
 echo "Check inodes" | tee -a $seqres.full
-- 
2.31.1

