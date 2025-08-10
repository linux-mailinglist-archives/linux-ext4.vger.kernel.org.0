Return-Path: <linux-ext4+bounces-9317-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E4DB1FA43
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50461189BC8C
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF95327701E;
	Sun, 10 Aug 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R4InZBwS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2D261593;
	Sun, 10 Aug 2025 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833361; cv=none; b=ZhPrgSEtUCee5glqjHUg6GJfW61wgLvFAW/ZHVXt2EEhjfhdE2C8NODJelxsxrGs+CBA+Y5MRMkl7nIOee4WSrJeoE6714xPs1Z5Ittk3wACxAUCNc3RSi90zLE6kTvaLm7kFRIGwe3Ys1TJomml3fQMCzzeyrNPwrCEUeMlAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833361; c=relaxed/simple;
	bh=wspgVSwP2KtmDPNbaP/ai2qU3wRo/iq0pVkkQNIPIXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+NiO0sG9BVSGR/qaKXuFhwvjJAAsXWQmhfFH9RFQ0caPxq+mCc/ovbGhASVlnlZas48G8wJOZdHM2pPrADhcpW+0tXNNe4YVyl+aAqpICD6SFYQb7I86v7qhRgMlrwoiuDAEKsyaH8A7a9qn597c5aondRp2KcEqzVHe9REfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R4InZBwS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ABFHYh020424;
	Sun, 10 Aug 2025 13:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7cAcpyoz5b2WrvbMZ
	5AZRhmyr9/OG0bYIbpRqA/h1BE=; b=R4InZBwSHc5aFHNaD4VtyABGVkDaVqRfw
	GJ8LnLy4hHwTWpxUBF4zjnHyDf/uvB5Vh00g+xcih2B6vHP724LuRPX6TuDMRGCM
	5PI/c/mhgvY25Py4wFBaqt+igf+x8b/Qi8x+NFiY1mB0GesPcESTahYVyOjRG0WG
	41StrH9AzxSfkLzY53Z4bE7iGYjrUvwdgUwAJKDn9Xbg72Pzi0F/pAEGTincCJx6
	GUBdx6Let6ITr+vhhnVfvkpXphVhCeZrmkQenR1x7+FQCzy8SIb4D2pLIAjt7d1G
	eJxk34CnYk30TGr5uFgCg9KoqZjymctgDqgoJOisgDzRYlUilcJVg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnnc4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADgWID027642;
	Sun, 10 Aug 2025 13:42:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnnc4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57A96Uqf017600;
	Sun, 10 Aug 2025 13:42:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc39nf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADgTSo14680514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF3AC2004B;
	Sun, 10 Aug 2025 13:42:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70CE620040;
	Sun, 10 Aug 2025 13:42:27 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:27 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 09/11] ext4: Atomic writes stress test for bigalloc using fio crc verifier
Date: Sun, 10 Aug 2025 19:12:00 +0530
Message-ID: <210979d189d43165fa792101cf2f4eb8ef02bc98.1754833177.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfX/e8XY7776UxW
 qd+khSW+FvzCiGaJ95VJObbbYiQJpaHrXdOw5W1a7mDHquC1pHEqHNEQOPYrf0bjgfYt6LGuxsN
 RYWgaE6z8DCDvT0KM9jZUG3cqi3d1FjmlbirIzWDFYNur952gVDocUEOdovfNCx3xroT9TrBMoi
 aUeoqC207eIdqwS/ltkJQZfUKifFNxfDIt5tz1v5mHLWnf2XKw9g8I6NL1M7SIxYSI5cjy5HCXE
 ISeBZeJyiEqoNHQXb9XOGLHtvDoLU42glj0xmgIrKLw0NdrYC01vs/rF4jcu1SL4N3IcHaC4Dwu
 x33iCrs4y06EyBdHoQG3XM5dexyCBE5u39uHlxgQVaRm7r87pQk6c2ta6CYpN8QDuNVC6ClDcHO
 Z7wi5QulFz/ekoD+Yju+KErH+RbJycIwudvXldJu77yV+aqTHCMDHNNywrL1OUtqjm6F6RBm
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=6898a1c8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=jHICElQ_nnKT0EPUS5YA:9
X-Proofpoint-GUID: Dxu8SrsZfkogDVdt7_UvziYjm6EiDJO1
X-Proofpoint-ORIG-GUID: ih8___XlxYzVK6FGa04wgtgjhQH5NT-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=922
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100097

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

We brute force all possible blocksize & clustersize combinations on
a bigalloc filesystem for stressing atomic write using fio data crc
verifier. We run nproc * $LOAD_FACTOR threads in parallel writing to
a single $SCRATCH_MNT/test-file. With atomic writes this test ensures
that we never see the mix of data contents from different threads on
a given bsrange.

This test might do overlapping atomic writes but that should be okay
since overlapping parallel hardware atomic writes don't cause tearing as
long as io size is the same for all writes.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/061     | 130 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/061.out |   2 +
 2 files changed, 132 insertions(+)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out

diff --git a/tests/ext4/061 b/tests/ext4/061
new file mode 100755
index 00000000..a0e49249
--- /dev/null
+++ b/tests/ext4/061
@@ -0,0 +1,130 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 061
+#
+# Brute force all possible blocksize clustersize combination on a bigalloc
+# filesystem for stressing atomic write using fio data crc verifier. We run
+# nproc * 2 * $LOAD_FACTOR threads in parallel writing to a single
+# $SCRATCH_MNT/test-file. With fio aio-dio atomic write this test ensures that
+# we should never see the mix of data contents from different threads for any
+# given fio blocksize.
+#
+
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto rw stress atomicwrites
+
+_require_scratch_write_atomic
+_require_aiodio
+
+FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
+SIZE=$((100*1024*1024))
+fiobsize=4096
+
+# Calculate fsblocksize as per bdev atomic write units.
+bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
+bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
+fsblocksize=$(_max 4096 "$bdev_awu_min")
+
+function create_fio_configs()
+{
+	create_fio_aw_config
+	create_fio_verify_config
+}
+
+function create_fio_verify_config()
+{
+cat >$fio_verify_config <<EOF
+	[aio-dio-aw-verify]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$fiobsize
+	fallocate=native
+	filename=$SCRATCH_MNT/test-file
+	size=$SIZE
+	iodepth=$FIO_LOAD
+	numjobs=$FIO_LOAD
+	atomic=1
+	group_reporting=1
+
+	verify_only=1
+	verify_state_save=0
+	verify=crc32c
+	verify_fatal=1
+	verify_write_sequence=0
+EOF
+}
+
+function create_fio_aw_config()
+{
+cat >$fio_aw_config <<EOF
+	[aio-dio-aw]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$fiobsize
+	fallocate=native
+	filename=$SCRATCH_MNT/test-file
+	size=$SIZE
+	iodepth=$FIO_LOAD
+	numjobs=$FIO_LOAD
+	group_reporting=1
+	atomic=1
+
+	verify_state_save=0
+	verify=crc32c
+	do_verify=0
+
+EOF
+}
+
+# Let's create a sample fio config to check whether fio supports all options.
+fio_aw_config=$tmp.aw.fio
+fio_verify_config=$tmp.verify.fio
+fio_out=$tmp.fio.out
+
+create_fio_configs
+_require_fio $fio_aw_config
+
+for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
+	# cluster sizes above 16 x blocksize are experimental so avoid them
+	# Also, cap cluster size at 128kb to keep it reasonable for large
+	# blocks size
+	fs_max_clustersize=$(_min $((16 * fsblocksize)) "$bdev_awu_max" $((128 * 1024)))
+
+	for ((fsclustersize=$fsblocksize; fsclustersize <= $fs_max_clustersize; fsclustersize = $fsclustersize << 1)); do
+		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
+			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
+			_scratch_mkfs_ext4  >> $seqres.full 2>&1 || continue
+			if _try_scratch_mount >> $seqres.full 2>&1; then
+				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
+
+				touch $SCRATCH_MNT/f1
+				create_fio_configs
+
+				cat $fio_aw_config >> $seqres.full
+				echo >> $seqres.full
+				cat $fio_verify_config >> $seqres.full
+
+				$FIO_PROG $fio_aw_config >> $seqres.full
+				ret1=$?
+
+				$FIO_PROG $fio_verify_config >> $seqres.full
+				ret2=$?
+
+				_scratch_unmount
+
+				[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
+			fi
+		done
+	done
+done
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/ext4/061.out b/tests/ext4/061.out
new file mode 100644
index 00000000..273be9e0
--- /dev/null
+++ b/tests/ext4/061.out
@@ -0,0 +1,2 @@
+QA output created by 061
+Silence is golden
-- 
2.49.0


