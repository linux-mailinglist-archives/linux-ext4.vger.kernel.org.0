Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB173D083E
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jul 2021 07:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhGUEri (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jul 2021 00:47:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231219AbhGUErg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Jul 2021 00:47:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L53cX7141889;
        Wed, 21 Jul 2021 01:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9Np2L/LAETvvlbt0YW+1IL4LWzJK4iBwFoueHenf0bs=;
 b=k7NbFn4sszEg85AKgRyLtg4yrnu04iGJ+mRgdSQFIxCwQJPsptIhzCmSno7sJgGFfkco
 Kpvw5cpEGTnbtKATrg7DdGLz0fxJ5poXzwLzdnUAda5DoPQskRF/PPsJ91I3XJLgMcFq
 lYsD+c8IGo2RzbX4g6B+gSpn1W7Gx+XVM8729GMGfn+5w4+dKMENv8ApIuURFP2jnwfw
 1kjCN0Q89CmBVj5V8TFfFP2xYlSe+gHtoNVMAD5ElhuIPek4HTiixbv4yavTdxiQsUdE
 nf6qaJMDzSOvDtm9g4yzJMv4rkM2N/r9Z+EfvaMuo8GVDxnc55v4tmHeWwgIxQvc+dGu 8w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39xchqh68y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:28:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L5DfLS018827;
        Wed, 21 Jul 2021 05:28:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 39upu89nv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 05:28:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L5S6g324510974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 05:28:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A17AAE045;
        Wed, 21 Jul 2021 05:28:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16247AE053;
        Wed, 21 Jul 2021 05:28:06 +0000 (GMT)
Received: from localhost (unknown [9.85.82.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 05:28:05 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 1/9] ext4/003: Fix this test on 64K platform for dax config
Date:   Wed, 21 Jul 2021 10:57:54 +0530
Message-Id: <406b10052920a617cb22b8cf5009e3db671d26da.1626844259.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626844259.git.riteshh@linux.ibm.com>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RRU1A558O9VX4kOp_iwOFvIPetXjvcKZ
X-Proofpoint-GUID: RRU1A558O9VX4kOp_iwOFvIPetXjvcKZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_02:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

mkfs.ext4 by default uses 4K blocksize which doesn't mount when testing
with dax config and the test fails. This patch fixes it.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/003 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/003 b/tests/ext4/003
index 3c9a8486..773bcb03 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -26,7 +26,8 @@ _supported_fs ext4
 _require_scratch
 _require_scratch_ext4_feature "bigalloc"
 
-$MKFS_EXT4_PROG -F -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
+BLOCK_SIZE=$(get_page_size)
+$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O bigalloc -C $(($BLOCK_SIZE * 16)) -g 256 $SCRATCH_DEV 512m \
 	>> $seqres.full 2>&1
 _scratch_mount
 
-- 
2.31.1

