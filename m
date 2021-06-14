Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5F53A5D2D
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 08:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhFNGax (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 02:30:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232507AbhFNGau (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 02:30:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E63dSW179896;
        Mon, 14 Jun 2021 02:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5/mmIfCHKIhqHpwRnwC1RxXpjFm1VabJGKfr8jJjc70=;
 b=TRildPWw/kQFQ4SB1Xjx5Q/Oa2H1ibx5V16MKeBMjuyR9Tv0qoZMwOclbBjS2kymcG1F
 5kmY3eragFTOtwDQcdxlbJbDX/CNyhEl86BYfPrZ3nIEcLAPPIjzIVZhA5ZFUHwi3tJW
 IsWxzelvQguKzHR0AFdsU4jDs85LZjDtoITZlXsD5FJCzRQ2pY3ykmzoAUCRsr+XZLRx
 Wuo1sZsDtelU9op3YpPkfUj0ttJehizRdWp0Wbc5F8eFciLZQTcQbxjs3ma/rx+Hw7Ku
 DxkVCN+Izhxw3OtJfjdopftDq4QySzhqaphRFCqO9nvmKE8YHW6C16EeEZdverHR4Pdr fg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3960u49g83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:28:48 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E6NSdk002913;
        Mon, 14 Jun 2021 06:28:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 394m6hrrbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 06:28:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E6Sg4S33358214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:28:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 905754204F;
        Mon, 14 Jun 2021 06:28:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36A7C42045;
        Mon, 14 Jun 2021 06:28:42 +0000 (GMT)
Received: from localhost (unknown [9.85.68.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 06:28:42 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 7/9] generic/620: Remove -b blocksize option for ext4
Date:   Mon, 14 Jun 2021 11:58:11 +0530
Message-Id: <8b3d5afe83ee6d1d35f57914a9b0cfa4b5bb4361.1623651783.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623651783.git.riteshh@linux.ibm.com>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H7EVy-kYL7M_jlXeQcKYEClM_3R1uey_
X-Proofpoint-ORIG-GUID: H7EVy-kYL7M_jlXeQcKYEClM_3R1uey_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140045
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4 with 64k blocksize fails with below error for this given test which
requires dmhugedisk. Also since dax is not supported for this test, so
make sure to remove -b option, if set by config file for ext4 FSTYP for
the test to then use 4K blocksize by default.

mkfs.ext4: Input/output error while writing out and closing file system

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/620 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/generic/620 b/tests/generic/620
index 60559441..3ccda5e4 100755
--- a/tests/generic/620
+++ b/tests/generic/620
@@ -50,6 +50,13 @@ _require_dmhugedisk
 sectors=$((2*1024*1024*1024*17))
 chunk_size=128
 
+# ext4 with 64k blocksize fails to mkfs with below error.
+# So remove -b option, if set by config file.
+# mkfs.ext4: Input/output error while writing out and closing file system
+if [[ $FSTYP = "ext4" ]]; then
+	MKFS_OPTIONS=$(echo $MKFS_OPTIONS | sed -rn 's/(.*)(-b ?+[0-9]+)(.*)/\1 \3/p')
+fi
+
 _dmhugedisk_init $sectors $chunk_size
 _mkfs_dev $DMHUGEDISK_DEV
 _mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
-- 
2.31.1

