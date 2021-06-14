Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560C33A5D27
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 08:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhFNGar (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 02:30:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37226 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232390AbhFNGam (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 02:30:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E64G1g095887;
        Mon, 14 Jun 2021 02:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=upXP3Sd2M4kjGecgsbELRN4CsIWgtHqMxItELIeAUUE=;
 b=nNhpUSsYn/agNd5L+yje3ISu16tINN8mfjITPWftNBUvLAGCRxUeXMHqRgo25loyKiSk
 KHQOIErgQSLLk/3T1/Qc31M+mfMEReBOhHpEFI6mMVCGVY1yMsVgDhydbCp9F33pcTyf
 zuhJ9WakfXAnVmfbbjdfJwrDRWO6f2eLT2NKBkm9t6rFPCv/RovIUMl+q5S4QE9hGKUy
 H/RgELz/wWzwxOD6IjzFDz8fv1gH1hk/KBzePalvnJ0a2OpFsuOUo0vt8LgQekvZG366
 iljfSHcHkK523jKDVTv4qw2iBuacKxpEdGDhFzmN0a7um0VF5c73PpeX9Dvqg2NuQW1q Gw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39611h15fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:28:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E6P129032677;
        Mon, 14 Jun 2021 06:28:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 394mj8rr5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 06:28:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E6SZj432047456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:28:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 236624203F;
        Mon, 14 Jun 2021 06:28:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C078942049;
        Mon, 14 Jun 2021 06:28:34 +0000 (GMT)
Received: from localhost (unknown [9.85.68.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 06:28:34 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/9] ext4/003: Fix this test on 64K platform for dax config
Date:   Mon, 14 Jun 2021 11:58:05 +0530
Message-Id: <fda7d76b27234a46c3e7165fbdfc4154708c227d.1623651783.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623651783.git.riteshh@linux.ibm.com>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DSPI-1gejBpDYKtlUBeBED9zB0gIyeRb
X-Proofpoint-ORIG-GUID: DSPI-1gejBpDYKtlUBeBED9zB0gIyeRb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140045
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
index 00ea9150..1ddb3063 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -31,7 +31,8 @@ _require_scratch_ext4_feature "bigalloc"
 
 rm -f $seqres.full
 
-$MKFS_EXT4_PROG -F -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
+BLOCK_SIZE=$(get_page_size)
+$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
 	>> $seqres.full 2>&1
 _scratch_mount
 
-- 
2.31.1

