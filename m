Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635602EAD61
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbhAEOdD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 09:33:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbhAEOdC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 09:33:02 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 105EW9f6071208;
        Tue, 5 Jan 2021 09:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VjOyvlwRQ8IN757uWSoatarB17Xy/ESK3JmlD7zhSzw=;
 b=Q82bEc6D5A4V3Q3Z/1RlTKKNdAii4rHl19rG4de5xMgHS2C0zbfN59KlYw5HwsFAAaZZ
 24Ek3lOt++lVKTf4B2+ZUdB8QkFN92BIT4jLr2WKaR2Xo91auicM+klrxc2YTRe3icAb
 ayO1yRlt1U33XhOH1unI0nEWUBNk1UgjVZTe7ePDtTd/rHmysEeTjXZkGN9PWXFzzMOJ
 JPcHCSblMIPMxvtrI6z3CcbBUjC0tXTrcuWc3JbmoigaovoMgiPs6SuCvB2NUedx3cFO
 iutVBOOuSS45TQKXvE7g+mAdeT1/t8onM4cbXbfRcPbeo/J6GR51iSTCQH1+iopRr5w/ Nw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35vs671rpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 09:32:12 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 105ESAKd030134;
        Tue, 5 Jan 2021 14:31:50 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 35tg3hhhg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 14:31:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 105EVmZS41877910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jan 2021 14:31:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7155B4C050;
        Tue,  5 Jan 2021 14:31:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AB5D4C040;
        Tue,  5 Jan 2021 14:31:47 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.32.130])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jan 2021 14:31:46 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        anju@linux.vnet.ibm.com, guan@eryu.me, darrick.wong@oracle.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 2/2] generic/496: ext4 and xfs supports swapon on fallocated file
Date:   Tue,  5 Jan 2021 20:01:43 +0530
Message-Id: <12d1420a4a3fe6be0918a8a13a1960db47032330.1609848797.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <aad3aeb9c717c76fc4e5fd124037da2510f51054.1609848797.git.riteshh@linux.ibm.com>
References: <aad3aeb9c717c76fc4e5fd124037da2510f51054.1609848797.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_02:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=728 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050089
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4, xfs should not fail swapon on fallocated file. Currently if this
fails the fstst was not returning a failure. Fix those for given
filesystems (for now added ext4/xfs).
There were some regressions which went unnoticed due to this in ext4
tree, which later got fixed as part of this patch [1]

[1]: https://patchwork.ozlabs.org/patch/1357275

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
v2 -> v3:
1. Removed whitelisted naming convention.

 tests/generic/496   | 16 +++++++++++++---
 tests/generic/group |  2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/generic/496 b/tests/generic/496
index 805c6ac1c0ea..1bfd16411b8a 100755
--- a/tests/generic/496
+++ b/tests/generic/496
@@ -5,7 +5,7 @@
 # FS QA Test No. 496
 #
 # Test various swapfile activation oddities on filesystems that support
-# fallocated swapfiles.
+# fallocated swapfiles (for given fs ext4/xfs)
 #
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
@@ -61,8 +61,18 @@ touch $swapfile
 $CHATTR_PROG +C $swapfile >> $seqres.full 2>&1
 $XFS_IO_PROG -f -c "falloc 0 $len" $swapfile >> $seqres.full
 "$here/src/mkswap" $swapfile
-"$here/src/swapon" $swapfile >> $seqres.full 2>&1 || \
-	_notrun "fallocated swap not supported here"
+
+# ext4/xfs should not fail for swapon on fallocated files
+case $FSTYP in
+ext4|xfs)
+	"$here/src/swapon" $swapfile >> $seqres.full 2>&1 || \
+		_fail "swapon failed on fallocated file"
+	;;
+*)
+	"$here/src/swapon" $swapfile >> $seqres.full 2>&1 || \
+		_notrun "fallocated swap not supported here"
+	;;
+esac
 swapoff $swapfile

 # Create a fallocated swap file and touch every other $PAGE_SIZE to create
diff --git a/tests/generic/group b/tests/generic/group
index fec35d8e7b12..30a73605610d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -498,7 +498,7 @@
 493 auto quick swap dedupe
 494 auto quick swap punch
 495 auto quick swap
-496 auto quick swap
+496 auto quick swap prealloc
 497 auto quick swap collapse
 498 auto quick log
 499 auto quick rw collapse zero
--
2.26.2

