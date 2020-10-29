Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D0629F599
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 20:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJ2TxV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 15:53:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726073AbgJ2TxT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Oct 2020 15:53:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TJWH4o100020;
        Thu, 29 Oct 2020 15:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Hs+sSwME8cN/ETcXqb7UZT/lCqhAOJNpiIjNgy5nNHQ=;
 b=RgJlw5j4vSjiTaxfjmG4M7svuRzWRd/vbFLZqsgP7Mw4SK6dtbeeCkHwwikL9SJdzb2g
 4d/TOayDzhnyh9egwCEhDqJDdICd+VJfw05fggB1JAXCzBKu4WiN8hV92PX/pS1+7o8B
 ClJsrB5elje5jaLbSQnJcOxD3DOYx2Pr1KoVydfF6yiB4AUkYI5OsXPE75zbeuQ8SnUB
 rYgTQC4oG/6VjWlJtuj4C4zodf33A0VMy8eF1GldGG8hJjqJxCDJXxSVUdcEK7pKoRHq
 yUUSk8sQYr8PG6YuAQCaRe8KNAelmr2puDdXOAjZIW1yUSwV4CCyjdVEs/iygz7zOLCu Ow== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34fnh068yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 15:53:17 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09TJm4aO025081;
        Thu, 29 Oct 2020 19:53:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 34fvc487cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 19:53:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09TJrCK033620242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 19:53:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BE614C052;
        Thu, 29 Oct 2020 19:53:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF64F4C040;
        Thu, 29 Oct 2020 19:53:10 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.33.247])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Oct 2020 19:53:10 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com, Eryu Guan <guan@eryu.me>,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 2/3] shared/001: Verify swapon on fallocated files for supported FS
Date:   Fri, 30 Oct 2020 01:22:52 +0530
Message-Id: <5750e38bb14440b6357a46470f2cd769cde1a349.1604000570.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604000570.git.riteshh@linux.ibm.com>
References: <cover.1604000570.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_11:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 impostorscore=0
 suspectscore=1 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290131
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently generic/496 tests if swapon works with fallocated files or not
on the given FS and bails out with _not_run if it doesn't. Due to this
2 of the regressions went unnoticed in ext4.
Hence this test is created specifically for FS (ext4, xfs) which does
support swap functionality on unwritten extents to report an error
if it swapon fails with fallocated fils.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/shared/001     | 97 ++++++++++++++++++++++++++++++++++++++++++++
 tests/shared/001.out |  6 +++
 tests/shared/group   |  1 +
 3 files changed, 104 insertions(+)
 create mode 100755 tests/shared/001
 create mode 100644 tests/shared/001.out

diff --git a/tests/shared/001 b/tests/shared/001
new file mode 100755
index 000000000000..ad7285bdb709
--- /dev/null
+++ b/tests/shared/001
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Oracle.  All Rights Reserved.
+#
+# FS QA Test 001
+#
+# This is similar to generic/472 and generic/496.
+# Except that generic/496 is modified to focefully verify if
+# swap works on fallocate files for given supported filesystems
+# or not instead of bailing out with _not_run, if swapon cmd fails.
+# Modified by Ritesh Harjani <riteshh@linux.ibm.com>
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	swapoff $swapfile 2> /dev/null
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs ext4 xfs
+_require_scratch_swapfile
+_require_test_program mkswap
+_require_test_program swapon
+_require_xfs_io_command "falloc"
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount >>$seqres.full 2>&1
+
+swapfile=$SCRATCH_MNT/swap
+len=$((2 * 1048576))
+page_size=$(get_page_size)
+
+swapfile_cycle() {
+	local swapfile="$1"
+
+	if [ $# -eq 2 ]; then
+		local len="$2"
+		_pwrite_byte 0x58 0 $len $swapfile >> $seqres.full
+	fi
+	"$here/src/mkswap" $swapfile >> $seqres.full
+	"$here/src/swapon" $swapfile 2>&1 | _filter_scratch
+	swapoff $swapfile 2>> $seqres.full
+	rm -f $swapfile
+}
+
+# from here similar to generic/472
+touch $swapfile
+
+# Create a regular swap file
+echo "regular swap" | tee -a $seqres.full
+swapfile_cycle $swapfile $len
+
+# Create a swap file with a little too much junk on the end
+echo "too long swap" | tee -a $seqres.full
+swapfile_cycle $swapfile $((len + 3))
+
+# Create a ridiculously small swap file.  Each swap file must have at least
+# two pages after the header page.
+echo "tiny swap" | tee -a $seqres.full
+swapfile_cycle $swapfile $(($(get_page_size) * 3))
+
+# From here similar to generic/496
+echo "fallocate swap" | tee -a $seqres.full
+$XFS_IO_PROG -f -c "falloc 0 $len" $swapfile >> $seqres.full
+"$here/src/mkswap" $swapfile
+"$here/src/swapon" $swapfile 2>&1 | _filter_scratch
+swapoff $swapfile
+
+# Create a fallocated swap file and touch every other $PAGE_SIZE to create
+# a mess of written/unwritten extent records
+echo "mixed swap" | tee -a $seqres.full
+$XFS_IO_PROG -f -c "falloc 0 $len" $swapfile >> $seqres.full
+seq $page_size $((page_size * 2)) $len | while read offset; do
+	_pwrite_byte 0x58 $offset 1 $swapfile >> $seqres.full
+done
+swapfile_cycle $swapfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/shared/001.out b/tests/shared/001.out
new file mode 100644
index 000000000000..2d7655e19422
--- /dev/null
+++ b/tests/shared/001.out
@@ -0,0 +1,6 @@
+QA output created by 001
+regular swap
+too long swap
+tiny swap
+fallocate swap
+mixed swap
diff --git a/tests/shared/group b/tests/shared/group
index a8b926d877d2..5a41b23c7010 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -3,6 +3,7 @@
 # - do not start group names with a digit
 # - comment line before each group is "new" description
 #
+001 auto swap quick
 002 auto metadata quick log
 032 mkfs auto quick
 298 auto trim
--
2.26.2

