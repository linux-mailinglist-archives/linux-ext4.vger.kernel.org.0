Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD583A5D28
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 08:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhFNGas (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 02:30:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15256 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232478AbhFNGan (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 02:30:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E65PY4029963;
        Mon, 14 Jun 2021 02:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=x19Y8x2t6YhLfL4jsMjExB3htEDo9KC+vhhmcTkU6Q8=;
 b=E+N3Kgn8Ka7WuNznIbDd4UYmTnMsosFQgx9/5d6XPN8GgTPTvK96zZe60bFcnLMpWySh
 4DzXsLwnRcNy5BUzjZ9AP13AY7Y94ErlBRoVNS+aStsu15X4zFUdgkAi6NU6sW4DrPsF
 S9AMTSSlVHBCjCT5PfsWoql5OEglQS5ML548a26Fq13OLqyyamru8WnRDpYq/0XiUbAB
 3VdxB8t2bsgStEIRcGGPcgdSostFgiEeYea1KdaH+XkG+jUL/WjcgkMffHoroDOP8cXi
 V4ojw4VDNx6bNj/5bBiAFVBN7Xsfk93ApjW3FarNUABvDE9Wx8WG9mg3YMcTceILPJ5Y 4Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 395xmjvavw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:28:41 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E6MB14001993;
        Mon, 14 Jun 2021 06:28:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 394m6hrrbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 06:28:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E6RYZ837159294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:27:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A86C4204B;
        Mon, 14 Jun 2021 06:28:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0781042041;
        Mon, 14 Jun 2021 06:28:36 +0000 (GMT)
Received: from localhost (unknown [9.85.68.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 06:28:35 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 2/9] ext4/027: Correct the right code of block and inode bitmap
Date:   Mon, 14 Jun 2021 11:58:06 +0530
Message-Id: <cf9babe1f24507d31886d806053dd1b93f2d144b.1623651783.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623651783.git.riteshh@linux.ibm.com>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AA0cIJPSNhuA0USg3ntziwAdaXykRi8u
X-Proofpoint-ORIG-GUID: AA0cIJPSNhuA0USg3ntziwAdaXykRi8u
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140045
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Observed occasional failure of this test sometimes say with 64k config
and small device size. Reason is we were grepping for wrong values for
inode and block bitmap.

Correct those values according to [1] to fix this test.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/fsmap.h#n53

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/027 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/027 b/tests/ext4/027
index 97c14cf5..83d5a413 100755
--- a/tests/ext4/027
+++ b/tests/ext4/027
@@ -45,11 +45,11 @@ x=$(grep -c 'static fs metadata' $TEST_DIR/fsmap)
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

