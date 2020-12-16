Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18F52DBA5C
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 06:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgLPFST (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 00:18:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46206 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgLPFSS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 00:18:18 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BG54o9B092728;
        Wed, 16 Dec 2020 00:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=V4oFR0GL/o/wQ6TttKaSHRbnl12f6ft3uXhYSEBveq4=;
 b=jIA2V8KmTi3r46PMmELv6Myg6kluZepc5DrbHYF44ie3pI68smhj3uCf/lL2JJKaE+rw
 V+eghVrLFQ/nJqoMfBUwb38z9KrVtyrWWTYMGsLknjl9ty2UWWRk3abJH2vWeG3BXrJc
 gi6XvSjQJVYxONlgFAYw4GulmH1ZMLCnfEs3dogGJFPb0HEvSNB4EVlDXvc6OjmGMxWC
 PSKgRyvOmXso/+h/eWoZERpS0McbxoPymhgSv3tY0X4InRN/QOMIyo8ZASkx94glxm7p
 Td7768ONjj8x542wBq0r4lNIr9QunJM+wi8NW/64NgRs78xfuFPauSeJ+o1/LHSxuSM7 LA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35fbg1rmq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 00:17:34 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BG5HXM5013616;
        Wed, 16 Dec 2020 05:17:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 35cng8a1yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 05:17:33 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BG5HUea22741494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 05:17:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD0D64C04A;
        Wed, 16 Dec 2020 05:17:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EC944C052;
        Wed, 16 Dec 2020 05:17:29 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.42.232])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Dec 2020 05:17:29 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     Eryu Guan <guan@eryu.me>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, anju@linux.vnet.ibm.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 2/2] generic/496: Add whitelisted FS support for swapon test
Date:   Wed, 16 Dec 2020 10:47:25 +0530
Message-Id: <17bc90bd450b1d3e8293397d15435a8c448d2b9a.1608094988.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <f161a49e6e3476d83c35b8e6a111644110ec4c8c.1608094988.git.riteshh@linux.ibm.com>
References: <f161a49e6e3476d83c35b8e6a111644110ec4c8c.1608094988.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_01:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=677 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160031
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4, xfs should not fail swapon on fallocated file. Currently if this
fails the fstst was not returning a failure. Fix those for whitelisted
FS (for now added ext4/xfs).
There were some regressions which went unnoticed due to this in ext4
tree, which later got fixed as part of this patch [1]

[1]: https://patchwork.ozlabs.org/patch/1357275

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/496   | 16 +++++++++++++---
 tests/generic/group |  2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/generic/496 b/tests/generic/496
index 805c6ac1c0ea..0546d8455491 100755
--- a/tests/generic/496
+++ b/tests/generic/496
@@ -5,7 +5,7 @@
 # FS QA Test No. 496
 #
 # Test various swapfile activation oddities on filesystems that support
-# fallocated swapfiles.
+# fallocated swapfiles (for whitelisted fs)
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
index d8758d7f6a5f..7a7388d92ec6 100644
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

