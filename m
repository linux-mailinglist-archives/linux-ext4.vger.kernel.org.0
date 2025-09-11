Return-Path: <linux-ext4+bounces-9932-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA2B53A25
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 19:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67E2A036AE
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7D236CC60;
	Thu, 11 Sep 2025 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nvwtnl7X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD8362999;
	Thu, 11 Sep 2025 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610876; cv=none; b=Pb1qCFZpmJ8X3mjBR2MDXq3NAv50n4zJXT9OF3W56CS+yAyXj5/6N+aUOzCM/5pyBSeCzmRMgJDjjWcBqvf2hNosuxNQ0ew+FW2Bo+zmY5N9fRvtSiQIm3Gsw7xQ+slPy+rVlCa0FYhJv5HMCLeER90DC0/LITiJKJ1WuEpnFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610876; c=relaxed/simple;
	bh=DuKA96AdpyKLqZYBHb58RoVvGwseEPk0CTPSH9y8nJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZlfCM3UhmapJoQjWVowsVio62tSxhbPsFfDGy+0qm/l1K2wriSkGQybz1U7dg9cXoKnMqlihoxP7xtmwJcDhN7zmRVLY2gFLvm3Aue5nR5LGMwVpGrbU+G1wq1eKv0dkfZGYJ60uTxqg4eojXDL/u+ChDAmka5DNFLT8eZn66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nvwtnl7X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDFnSx026794;
	Thu, 11 Sep 2025 17:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ot+islW9QqRcQihl1
	cGnoj87N1ScOyDjNrHRSvRNX44=; b=nvwtnl7XbdlQ2ZK3JwqbrCe0yU1jL/Fcv
	muTEkjfZTUEpwndM9C7enMffPURPcDoNC4ZHJM6jPXzdN8/SPQR9wTFj19kCMPS3
	+qmwrTn8KpPwJVpSYZ6KFL7geRxzUSXqZPMWUygfwY6TBUtFdOh1PEcy9OfNFNAt
	DOM2TkrUvUX6dE55798ZOGW0R5KwDCNmN5pA8fcVgrbsiNhhYUCL6ob6mGsbGP3p
	13kw9uTf0mTi0/TTIW53RqTtgG0gnlJeYrx2Zhdksa/VCVKnLiF+k3wkuHbTcIYL
	sltUeVNsUwh0V0QhrBsYopOMabg4gMHZYZ8KxeAZdskQFoBCFVLfQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct5e61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:25 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BHEPlA032470;
	Thu, 11 Sep 2025 17:14:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct5e5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BH6Dnm020469;
	Thu, 11 Sep 2025 17:14:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp171um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BHEJek35455396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:14:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C71E320040;
	Thu, 11 Sep 2025 17:14:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 324EA2004B;
	Thu, 11 Sep 2025 17:14:16 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 17:14:15 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v6 08/12] generic: Stress fsx with atomic writes enabled
Date: Thu, 11 Sep 2025 22:43:39 +0530
Message-ID: <dc8ef1b5f7a53a5b4a010b2de61684f3fee53ac5.1757610403.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1757610403.git.ojaswin@linux.ibm.com>
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX1gb9549iKlLn
 xnTfhzufPZmMLoBEAdhxXKcaJIs/6Ni03bp0zhiBVTH0OxQX8ljaPWfRxdCkS0MeIcIS4pHLZ51
 +JKkfDzSctpmKio9ZeCLnCECorb7oT5FhacCsp+iF0Olii+eoisz2xcIufJYsnIa3AcX9l/xfbm
 dwRv/dIuwDqBDbUpvAzFKwlqibSkzHrauEPx7XhyfKqQ6Rn4lMN7HICUffcZkDR2e5+FYgyHYce
 mpx3v+y6iTP1B/z68oIocwuDeYSKLRJTzd/ZQr9QKcMgyUV/Y1tyfgBEdCs7LbcpikA8l6jHsT0
 COxZDiK6LPPLb35O1tfEcKnkeKQ4Bmu5FnTXP5OWFGWk1exLFk4hHDqO4w9kEPxeQRwBE0e3JBB
 MfW1RJ05
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c30371 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=zPW1cLLGUcrnTIp6xCMA:9
X-Proofpoint-GUID: aP5vXkxGVyMwLPUhnwVbqVX945YZ5cLv
X-Proofpoint-ORIG-GUID: Cjsh6SxfKTPDKLtcR_ThEy2ISGYn5mCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

Stress file with atomic writes to ensure we exercise codepaths
where we are mixing different FS operations with atomic writes

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1229     | 68 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1229.out |  2 ++
 2 files changed, 70 insertions(+)
 create mode 100755 tests/generic/1229
 create mode 100644 tests/generic/1229.out

diff --git a/tests/generic/1229 b/tests/generic/1229
new file mode 100755
index 00000000..6d4dcfed
--- /dev/null
+++ b/tests/generic/1229
@@ -0,0 +1,68 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1229
+#
+# fuzz fsx with atomic writes
+#
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest rw auto quick atomicwrites
+
+_require_odirect
+_require_scratch_write_atomic
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount  >> $seqres.full 2>&1
+
+testfile=$SCRATCH_MNT/testfile
+touch $testfile
+
+awu_max=$(_get_atomic_write_unit_max $testfile)
+blksz=$(_get_block_size $SCRATCH_MNT)
+bsize=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
+
+set_fsx_avoid() {
+	local file=$1
+
+	case "$FSTYP" in
+	"ext4")
+		local dev=$(findmnt -n -o SOURCE --target $testfile)
+
+		# fsx insert/collapse range support for ext4+bigalloc is
+		# currently broken, so disable it. Also disable in case we
+		# can't detect bigalloc to be on safer side.
+		if [ -z "$DUMPE2FS_PROG" ]; then
+			echo "dumpe2fs not found, disabling insert/collapse range" >> $seqres.full
+			FSX_AVOID+=" -I -C"
+			return
+		fi
+
+		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q bigalloc && {
+			echo "fsx insert/collapse range not supported with bigalloc. Disabling.." >> $seqres.full
+			FSX_AVOID+=" -I -C"
+		}
+		;;
+	*)
+		;;
+	esac
+}
+
+# fsx usage:
+#
+# -N numops: total # operations to do
+# -l flen: the upper bound on file size
+# -o oplen: the upper bound on operation size (64k default)
+# -Z: O_DIRECT ()
+
+set_fsx_avoid
+_run_fsx_on_file $testfile -N 10000 -o $awu_max -A -l 500000 -r $bsize -w $bsize -Z $FSX_AVOID  >> $seqres.full
+if [[ "$?" != "0" ]]
+then
+	_fail "fsx returned error: $?"
+fi
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/1229.out b/tests/generic/1229.out
new file mode 100644
index 00000000..737d61c6
--- /dev/null
+++ b/tests/generic/1229.out
@@ -0,0 +1,2 @@
+QA output created by 1229
+Silence is golden
-- 
2.49.0


