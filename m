Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8AC3D0845
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jul 2021 07:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhGUEsQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jul 2021 00:48:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232390AbhGUErq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Jul 2021 00:47:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L53aSr142258;
        Wed, 21 Jul 2021 01:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=x3GRL6dsgm9fWp6B0aJqjR3QHgva7/Dk+PzVsS5AmYA=;
 b=HzIRgAwafym51fGLBHYlvVkq532jqhf6b0zVhBzaANP/mlGkJHk+Sz3+g+TPGL8Fnkbc
 TEPYtA7t09q0cwSRFtV85/V8ER1FObehChyRQAHtT9L3dcVxPbqlzmfGNVj1bu38Ce7q
 RHlIyPuzWd4ckSgPRYABWmaSsWhvR9CBaWDog30cSBlrUks+kRjfrS6Z6eXKw4ZYEPr4
 +8FjMdpJ8Yjb5fQs0/0y5pSL3TDiGVWN/7ciZwRoAxC41WzvTt4xCDk6cz/b0Isk/V28
 mSk/i01J22oNpcyw8ujwEibfshUdLtOtt5+vC4Ck2YJE7pF49tXoeeJaIlqNouRPXVVb 2w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39xan7bgjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:28:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L5Cxfb015125;
        Wed, 21 Jul 2021 05:28:18 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 39upu89p3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 05:28:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L5SG7W35783102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 05:28:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2117CAE051;
        Wed, 21 Jul 2021 05:28:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF951AE045;
        Wed, 21 Jul 2021 05:28:15 +0000 (GMT)
Received: from localhost (unknown [9.85.82.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 05:28:15 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 7/9] generic/620: Use _mkfs_dev_blocksized to use 4k bs
Date:   Wed, 21 Jul 2021 10:58:00 +0530
Message-Id: <a7d863771ec7187a1d89e0e33aa36bb6aaa5a2a7.1626844259.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626844259.git.riteshh@linux.ibm.com>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sTf-rnZsURHasWDAu00e0oh7HHm7fX-V
X-Proofpoint-GUID: sTf-rnZsURHasWDAu00e0oh7HHm7fX-V
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_02:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4 with 64k blocksize (passed by user config) fails with below error for
this given test which requires dmhugedisk. Since this test anyways only
requires 4k bs, so use _mkfs_dev_blocksized() to fix this.

<error log with 64k bs>
mkfs.ext4: Input/output error while writing out and closing file system

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/620 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/generic/620 b/tests/generic/620
index b052376f..444e682d 100755
--- a/tests/generic/620
+++ b/tests/generic/620
@@ -42,7 +42,9 @@ sectors=$((2*1024*1024*1024*17))
 chunk_size=128
 
 _dmhugedisk_init $sectors $chunk_size
-_mkfs_dev $DMHUGEDISK_DEV
+
+# Use 4k blocksize.
+_mkfs_dev_blocksized 4096 $DMHUGEDISK_DEV
 _mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
 testfile=$SCRATCH_MNT/testfile-$seq
 
-- 
2.31.1

