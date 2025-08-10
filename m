Return-Path: <linux-ext4+bounces-9315-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F357B1FA3A
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C043BC2EA
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090552749D6;
	Sun, 10 Aug 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hLAwhhcV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407CB271A7B;
	Sun, 10 Aug 2025 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833355; cv=none; b=ZQ8CAJ206Af5hoZSPxgapQS0go6w5Mg9c34WSjXQgquy+gi70I/cVD4I7hwQ2hQTaXwzNJXPvdVxLMqSSyIGd1/gSki0qh5UDSTo8RnoPAEvO6hbqExXYmQqlK+hqTNzrH31/zkZoByEbFOWr/QKgBAtEVS0srlyS0ZgjA5cyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833355; c=relaxed/simple;
	bh=uPasESbOKX5ySA2wW6RZodhKnEOlPArEeggRaHry10k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvGh5b0WLlb+J2jM/1+/WcLAeuW/YkcCT6HKzqngWtgztKUxnQIQA7/7QnfXa00CVGcT9/SSmEuAwFp7ZW0f6JTdwammXnTw/lPLypXMDfFfuYyMUPhHxwQOm9kAPNpG8xbRphLlhi2bmE9ojpn8jWUMRlJmy9cUCZPlXtAnMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hLAwhhcV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A9pqla008903;
	Sun, 10 Aug 2025 13:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7AbQG57LSa3FbHWfM
	NrAfby5XX2AiWzch8fpH1rzmHo=; b=hLAwhhcVHo5Gdz1V9F9i3IA4P7LDe3ezV
	wY8cb5GRUVcV/GfDESFVi5uEf83Z35TwBz+YEPtMQGl8vPNat5aFqN/Jow69Tvq/
	tp58iZcxyGhlPnVMb4rUDHw6Eu029FhRRT5o70VEyoaMRrRz6PoFd4rbgGvr5hZN
	1Kjg385dYtX7VqhOG3uFEN579PnaM+x6BPaz1jMlA4C/R8gW6xmnNj6tFeZOKJJO
	/wkAZIxnbrJfhTITy03onu/jhdtm9VJEkAKKH6uf/jy73Xh2lmNjPIh/bHK6etJk
	HI1TceqEh/a0Na7CURR98YTsFPScxqDH7LT3SMKckxkYOUeyiOa1w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwucwcyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADgRlw028380;
	Sun, 10 Aug 2025 13:42:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwucwcy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57ACKYC1026282;
	Sun, 10 Aug 2025 13:42:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh20t4nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADgOXv62390778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78F9820043;
	Sun, 10 Aug 2025 13:42:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4794620040;
	Sun, 10 Aug 2025 13:42:22 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:22 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 07/11] generic: Stress fsx with atomic writes enabled
Date: Sun, 10 Aug 2025 19:11:58 +0530
Message-ID: <50487b2e8a510598a93888c2674df7357d371da8.1754833177.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754833177.git.ojaswin@linux.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfXyaXxv26N7l2/
 8/yx1ebUVhlTYhGiNJTyTlOxB/r/WD2TlfVz/9wXBQYxjVhMcCSPvkBQO5oe8PaPq4SVEH2m82k
 2LHSAmIXKpeYfysWSsBtTUTwNa4HRa+7gUVa3FnlRSw9yvm8hMdekOMsdfCljB/XXfdmpjlspWK
 z05vZ/QojJLX8qxIC9FC9Iu522MEHvzw9GFX4oUkC6h+DjfeQg0RsPlUuY4Onrf9WcwM0qccNNU
 71dcAUB4txE2iR+VYNYLn2EIC7SxLmaGRENhwLm007MvyvgIwrpUTtW/7x1chB63adQaIqCZ5qi
 blYto26ZQTydv2uw7Idu5vDABGfVC3ks1Lh/ZcUDZLwotKCqC/+3b7tlo4xW8plFzwH/n8rdUWO
 iK3Cr4/AFZ710MXDk75PwAXXigPYHuI2ReOCPkmKSb/umflha37DXrCBkb+8Q1JmTiZYU+NE
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=6898a1c4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=zPW1cLLGUcrnTIp6xCMA:9
X-Proofpoint-GUID: CYLhPlzA0JAufm-1JbEkjcyz6nyRMYtt
X-Proofpoint-ORIG-GUID: kdReY34iAi8zHa2SHWAM0YMeTLmfD1Kq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=968 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508100097

Stress file with atomic writes to ensure we excercise codepaths
where we are mixing different FS operations with atomic writes

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1229     | 68 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1229.out |  2 ++
 2 files changed, 70 insertions(+)
 create mode 100755 tests/generic/1229
 create mode 100644 tests/generic/1229.out

diff --git a/tests/generic/1229 b/tests/generic/1229
new file mode 100755
index 00000000..7fa57105
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
+		# fsx insert/collpase range support for ext4+bigalloc is
+		# currently broken, so disable it. Also disable incase we can't
+		# detect bigalloc to be on safer side.
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


