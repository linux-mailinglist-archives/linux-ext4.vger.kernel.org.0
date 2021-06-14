Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8B3A5D2B
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 08:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhFNGau (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 02:30:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232394AbhFNGas (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 02:30:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E64mOA188852;
        Mon, 14 Jun 2021 02:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EzAVJMIonmlWocRAMw/JzQoD9hDugKo7Zy8ZnDkQRGw=;
 b=mfwubVRX3dzZFC+wZIjsAUGWynNkD0X4J5DRoIFTVAH1+bNntXnk80H4FLE0ZcnBDUMb
 rw/vFdlXDjF1VuXAYTapS8Q+R7KbmFKFVMMC0NBxqHIXIGbAxmjqXaivoEiPvOnd0tki
 svl4D2U9U6/zgpTfsnrNyzofGOkooKuOHjNZk1XZnIo/7OWFZtjYy7z4u1icT0HRp/c6
 Al51x9IqyifMU8fnfS1Wppz89WLrqjvfn2q53RoROwPOwakiYS/ViogKX3momFIizV0i
 rNKZZDWRJmcEZWcZnPkBHIFQrD90b7eP34q0JgYA/4T65icI+THd4ar7QF0GMXAcoxLU RA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39618sgvkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:28:45 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E6OJTd014174;
        Mon, 14 Jun 2021 06:28:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 394mj90d9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 06:28:43 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E6Seut34210214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:28:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11E0442047;
        Mon, 14 Jun 2021 06:28:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B60A142041;
        Mon, 14 Jun 2021 06:28:39 +0000 (GMT)
Received: from localhost (unknown [9.85.68.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 06:28:39 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 5/9] generic/031: Fix the test case for 64k blocksize config
Date:   Mon, 14 Jun 2021 11:58:09 +0530
Message-Id: <efd1594eeec7b893c47865ce5a94c25dc94dac28.1623651783.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623651783.git.riteshh@linux.ibm.com>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LQzBDMDaq2m6ra4vva-LIixNg0sX9xex
X-Proofpoint-ORIG-GUID: LQzBDMDaq2m6ra4vva-LIixNg0sX9xex
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140045
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test fails with blocksize 64k since the test assumes 4k blocksize
in fcollapse param. This patch fixes that and also tests for 64k
blocksize.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/031                          | 37 ++++++++++++++++++----
 tests/generic/031.out.64k                  | 19 +++++++++++
 tests/generic/{031.out => 031.out.default} |  0
 3 files changed, 49 insertions(+), 7 deletions(-)
 create mode 100644 tests/generic/031.out.64k
 rename tests/generic/{031.out => 031.out.default} (100%)

diff --git a/tests/generic/031 b/tests/generic/031
index db84031b..40cb23af 100755
--- a/tests/generic/031
+++ b/tests/generic/031
@@ -8,6 +8,7 @@
 # correctly written and aren't left behind causing invalidation or data
 # corruption issues.
 #
+seqfull=$0
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -39,12 +40,35 @@ testfile=$SCRATCH_MNT/testfile
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
-$XFS_IO_PROG -f \
-	-c "pwrite 185332 55756" \
-	-c "fcollapse 28672 40960" \
-	-c "pwrite 133228 63394" \
-	-c "fcollapse 0 4096" \
-$testfile | _filter_xfs_io
+# fcollapse need offset and len to be multiple of blocksize for filesystems
+# hence make this test work with 64k blocksize as well.
+blksz=$(_get_block_size $SCRATCH_MNT)
+
+rm -f $seqfull.out
+if [ "$blksz" -eq 65536 ]; then
+	ln -s $seq.out.64k $seqfull.out
+else
+	ln -s $seq.out.default $seqfull.out
+fi
+
+if [[ $blksz -le 4096 ]]; then
+	$XFS_IO_PROG -f \
+		-c "pwrite 185332 55756" \
+		-c "fcollapse 28672 40960" \
+		-c "pwrite 133228 63394" \
+		-c "fcollapse 0 4096" \
+	$testfile | _filter_xfs_io
+elif [[ $blksz -eq 65536 ]]; then
+	fact=$blksz/4096
+	$XFS_IO_PROG -f \
+		-c "pwrite $((185332*fact + 12)) $((55756*fact + 12))" \
+		-c "fcollapse $((28672 * fact)) $((40960 * fact))" \
+		-c "pwrite $((133228 * fact + 12)) $((63394 * fact + 12))" \
+		-c "fcollapse 0 $((4096 * fact))" \
+	$testfile | _filter_xfs_io
+else
+	_notrun "blocksize not supported"
+fi
 
 echo "==== Pre-Remount ==="
 hexdump -C $testfile
@@ -54,4 +78,3 @@ hexdump -C $testfile
 
 status=0
 exit
-
diff --git a/tests/generic/031.out.64k b/tests/generic/031.out.64k
new file mode 100644
index 00000000..7dfcfe41
--- /dev/null
+++ b/tests/generic/031.out.64k
@@ -0,0 +1,19 @@
+QA output created by 031
+wrote 892108/892108 bytes at offset 2965324
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1014316/1014316 bytes at offset 2131660
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== Pre-Remount ===
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+001f86c0  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
+001f86d0  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+*
+002fdc18
+==== Post-Remount ==
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+001f86c0  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
+001f86d0  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+*
+002fdc18
diff --git a/tests/generic/031.out b/tests/generic/031.out.default
similarity index 100%
rename from tests/generic/031.out
rename to tests/generic/031.out.default
-- 
2.31.1

