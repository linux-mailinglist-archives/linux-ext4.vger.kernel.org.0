Return-Path: <linux-ext4+bounces-10262-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76840B880D6
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 08:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE057567BD8
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 06:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EEA2D6621;
	Fri, 19 Sep 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ONyo7m9r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CBE265CBB;
	Fri, 19 Sep 2025 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264540; cv=none; b=LoJOWIGMz7bdhwUY8yPv63upsn03i+CvH5iv6jus2JTxBQEM2eIRz1/SN7yDhzSroyWMCieT7bHja9H6uRnfDWGZ+CKV4EzB67e2AYWCcckfifndtez1P3W367lSJUR1GDF2OtMW6xJ+9pVFiY5VG3wI4YGE+x9FJCJeoYeCk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264540; c=relaxed/simple;
	bh=7zFcMttLKMqJVZ4fcVUY/R4zC9cUxqDiDZoxmG9SqmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diUkTmtoOieG6Pa4sxM1K8pVneUyqSMdGxF1leAip2eQ+z3pKKrB2P877E7Vm7jll3tCewkOk7ogwVzhIiOFCXZ2iu0joU2O2YnD0UWj8MnQNZOIDALhp1yfvhU3UaxNgm1OooPoElBkFOGOb6PQbxYL6oYnfH+NbfoeMzOj5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ONyo7m9r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58INDaaJ012207;
	Fri, 19 Sep 2025 06:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UrioZmgTfKAivy8rh
	voElgdTxnsSA0lgnyocQ6OyEnM=; b=ONyo7m9rglO4DkdS0mYvvAK/GTaOsccYk
	oaMd9A7xGn91c1iH6HfbtUQ5Sl3ZxkYrOiORG0LkfSJRteouqlMhHOUEudqX3Dcl
	wKB7KOLkxX1LDUc6lqjdax16QuE7gYWILBNrJfkropUAzvwCE6gqJaFI+4KTzWVZ
	1tZ4F5voZcojGi+H1gmH6LZW0rhQWxVRXtF1hGhmdJ3TcyqEzY4MFoNO9sWTaE+K
	7x2pU0nyQ3sjbQaRHJ9d2fWatNejt6aYzYi4An27F19ALJI4oARgk6ndi0BPPxg1
	iGHMn09uiNEgBwByLk0X0DWPJt8WktX2mP87JSom1tepyIqFgQJsA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jeybe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6gAff008680;
	Fri, 19 Sep 2025 06:48:48 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jeybb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J30khU008987;
	Fri, 19 Sep 2025 06:48:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3t9wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6mjXg29884726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:48:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A10AF2004B;
	Fri, 19 Sep 2025 06:48:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6556720040;
	Fri, 19 Sep 2025 06:48:42 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:48:42 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v7 09/12] generic: Add sudden shutdown tests for multi block atomic writes
Date: Fri, 19 Sep 2025 12:18:02 +0530
Message-ID: <a64db1f0a595c75acbcf0b94e185a37077a5a72c.1758264169.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758264169.git.ojaswin@linux.ibm.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68ccfcd1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=dyK_zsDHFtz5CmQ9vqoA:9
X-Proofpoint-ORIG-GUID: imFECujH9nHfNE438EfAJNB86qoQptSu
X-Proofpoint-GUID: dmANn37mm5xYZPmZpYdJyRxI4MJKuCPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX3SpZt6mZXOK8
 gAZPxy7ETqQRqjBLi268V3Tlu0jx9Wm7EobMyYoRAtkRlkt10aF0tPJSzqujZyEO7OdMacoM4j4
 wt0/GpTljUEZtJI7SZlnaXXVpYHsa42Tg9cSlhmeZV+M1lP8uECCGY3LcJT1ZPDnpqpwY2QnOXa
 EGvAJtOiZrrYCznGV4rB4tZCOvpUnNp9CoyQxjn2Gdod2wkO09Uaq9+ZqDHvo/UwnhDV4AuiV2x
 mkwnyTfE/fP/nmm7aPmZY1jzbq/r9b0MzBivhTC7BMLpGRWBAjJcgBV4s6U513WNtWVPAvGz88f
 6ndO8Qljk/SGV9uBurXu+adOXjK59uMaFQ8hKLR2/lAM/8wB07yb+aTyyBbAC2oi5AqN35DBzgc
 7AXWtkvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

This test is intended to ensure that multi blocks atomic writes
maintain atomic guarantees across sudden FS shutdowns.

The way we work is that we lay out a file with random mix of written,
unwritten and hole extents. Then we start performing atomic writes
sequentially on the file while we parallelly shutdown the FS. Then we
note the last offset where the atomic write happened just before shut
down and then make sure blocks around it either have completely old
data or completely new data, ie the write was not torn during shutdown.

We repeat the same with completely written, completely unwritten and completely
empty file to ensure these cases are not torn either.  Finally, we have a
similar test for append atomic writes

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1230     | 368 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1230.out |   2 +
 2 files changed, 370 insertions(+)
 create mode 100755 tests/generic/1230
 create mode 100644 tests/generic/1230.out

diff --git a/tests/generic/1230 b/tests/generic/1230
new file mode 100755
index 00000000..cba75441
--- /dev/null
+++ b/tests/generic/1230
@@ -0,0 +1,368 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test No. 1230
+#
+# Test multi block atomic writes with sudden FS shutdowns to ensure
+# the FS is not tearing the write operation
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest auto atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_atomic_write_test_commands
+_require_scratch_shutdown
+_require_xfs_io_command "truncate"
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full
+
+testfile=$SCRATCH_MNT/testfile
+touch $testfile
+
+awu_max=$(_get_atomic_write_unit_max $testfile)
+blksz=$(_get_block_size $SCRATCH_MNT)
+echo "Awu max: $awu_max" >> $seqres.full
+
+num_blocks=$((awu_max / blksz))
+# keep initial value high for dry run. This will be
+# tweaked in dry_run() based on device write speed.
+filesize=$(( 10 * 1024 * 1024 * 1024 ))
+
+_cleanup() {
+	[ -n "$awloop_pid" ] && kill $awloop_pid &> /dev/null
+	wait
+}
+
+atomic_write_loop() {
+	local off=0
+	local size=$awu_max
+	for ((i=0; i<$((filesize / $size )); i++)); do
+		# Due to sudden shutdown this can produce errors so just
+		# redirect them to seqres.full
+		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
+		echo "Written to offset: $off" >> $tmp.aw
+		off=$((off + $size))
+	done
+}
+
+start_atomic_write_and_shutdown() {
+	atomic_write_loop &
+	awloop_pid=$!
+
+	local i=0
+	# Wait for at least first write to be recorded or 10s
+	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
+
+	if [[ $i -gt 50 ]]
+	then
+		_fail "atomic write process took too long to start"
+	fi
+
+	echo >> $seqres.full
+	echo "# Shutting down filesystem while write is running" >> $seqres.full
+	_scratch_shutdown
+
+	kill $awloop_pid 2>/dev/null  # the process might have finished already
+	wait $awloop_pid
+	unset $awloop_pid
+}
+
+# This test has the following flow:
+# 1. Start doing sequential atomic writes in background, upto $filesize
+# 2. Sleep for 0.2s and shutdown the FS
+# 3. kill the atomic write process
+# 4. verify the writes were not torn
+#
+# We ideally want the shutdown to happen while an atomic write is ongoing
+# but this gets tricky since faster devices can actually finish the whole
+# atomic write loop before sleep 0.2s completes, resulting in the shutdown
+# happening after the write loop which is not what we want. A simple solution
+# to this is to increase $filesize so step 1 takes long enough but a big
+# $filesize leads to create_mixed_mappings() taking very long, which is not
+# ideal.
+#
+# Hence, use the dry_run function to figure out the rough device speed and set
+# $filesize accordingly.
+dry_run() {
+	echo >> $seqres.full
+	echo "# Estimating ideal filesize..." >> $seqres.full
+
+	start_atomic_write_and_shutdown
+
+	bytes_written=$(tail -n 1 $tmp.aw | cut -d" " -f4)
+	echo "# Bytes written in 0.2s: $bytes_written" >> $seqres.full
+
+	filesize=$((bytes_written * 3))
+	echo "# Setting \$filesize=$filesize" >> $seqres.full
+
+	rm $tmp.aw
+	sleep 0.5
+
+	_scratch_cycle_mount
+
+}
+
+create_mixed_mappings() {
+	local file=$1
+	local size_bytes=$2
+
+	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
+	#Fill the file with alternate written and unwritten blocks
+	local off=0
+	local operations=("W" "U")
+
+	for ((i=0; i<$((size_bytes / blksz )); i++)); do
+		index=$(($i % ${#operations[@]}))
+		map="${operations[$index]}"
+
+		case "$map" in
+		    "W")
+			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
+			;;
+		    "U")
+			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
+			;;
+		esac
+		off=$((off + blksz))
+	done
+
+	sync $file
+}
+
+populate_expected_data() {
+	# create a dummy file with expected old data for different cases
+	create_mixed_mappings $testfile.exp_old_mixed $awu_max
+	expected_data_old_mixed=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mixed)
+
+	$XFS_IO_PROG -fc "falloc 0 $awu_max" $testfile.exp_old_zeroes >> $seqres.full
+	expected_data_old_zeroes=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_zeroes)
+
+	$XFS_IO_PROG -fc "pwrite -b $awu_max 0 $awu_max" $testfile.exp_old_mapped >> $seqres.full
+	expected_data_old_mapped=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mapped)
+
+	# create a dummy file with expected new data
+	$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp_new >> $seqres.full
+	expected_data_new=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_new)
+}
+
+verify_data_blocks() {
+	local verify_start=$1
+	local verify_end=$2
+	local expected_data_old="$3"
+	local expected_data_new="$4"
+
+	echo >> $seqres.full
+	echo "# Checking for torn write from $verify_start to $verify_end" >> $seqres.full
+
+	# After an atomic write, for every chunk we ensure that the underlying
+	# data is either the old data or new data as writes shouldn't get torn.
+	local off=$verify_start
+	while [[ "$off" -lt "$verify_end" ]]
+	do
+		#actual_data=$(xxd -s $off -l $awu_max -p $testfile)
+		actual_data=$(od -An -t x1 -j $off -N $awu_max $testfile)
+		if [[ "$actual_data" != "$expected_data_new" ]] && [[ "$actual_data" != "$expected_data_old" ]]
+		then
+			echo "Checksum match failed at off: $off size: $awu_max"
+			echo "Expected contents: (Either of the 2 below):"
+			echo
+			echo "Old: "
+			echo "$expected_data_old"
+			echo
+			echo "New: "
+			echo "$expected_data_new"
+			echo
+			echo "Actual contents: "
+			echo "$actual_data"
+
+			_fail
+		fi
+		echo -n "Check at offset $off succeeded! " >> $seqres.full
+		if [[ "$actual_data" == "$expected_data_new" ]]
+		then
+			echo "matched new" >> $seqres.full
+		elif [[ "$actual_data" == "$expected_data_old" ]]
+		then
+			echo "matched old" >> $seqres.full
+		fi
+		off=$(( off + awu_max ))
+	done
+}
+
+# test torn write for file by shutting down in between atomic writes
+test_torn_write() {
+	echo >> $seqres.full
+	echo "# Writing atomically to file in background" >> $seqres.full
+
+	start_atomic_write_and_shutdown
+
+	last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
+	if [[ -z $last_offset ]]
+	then
+		last_offset=0
+	fi
+
+	echo >> $seqres.full
+	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
+
+	rm $tmp.aw
+	sleep 0.5
+
+	_scratch_cycle_mount
+
+	# we want to verify all blocks around which the shutdown happened
+	verify_start=$(( last_offset - (awu_max * 5)))
+	if [[ $verify_start < 0 ]]
+	then
+		verify_start=0
+	fi
+
+	verify_end=$(( last_offset + (awu_max * 5)))
+	if [[ "$verify_end" -gt "$filesize" ]]
+	then
+		verify_end=$filesize
+	fi
+}
+
+# test torn write for file with written and unwritten mappings
+test_torn_write_mixed() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with mixed mappings" >> $seqres.full
+	create_mixed_mappings $testfile $filesize
+
+	test_torn_write
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_mixed" "$expected_data_new"
+}
+
+# test torn write for file with completely written mappings
+test_torn_write_written() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with fully written mapping" >> $seqres.full
+	$XFS_IO_PROG -c "pwrite -b $filesize 0 $filesize" $testfile >> $seqres.full
+	sync $testfile
+
+	test_torn_write
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_mapped" "$expected_data_new"
+}
+
+# test torn write for file with completely unwritten mappings
+test_torn_write_unwritten() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with fully unwritten mappings" >> $seqres.full
+	$XFS_IO_PROG -c "falloc 0 $filesize" $testfile >> $seqres.full
+	sync $testfile
+
+	test_torn_write
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
+}
+
+# test torn write for file with no mappings
+test_torn_write_hole() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with no mappings" >> $seqres.full
+	$XFS_IO_PROG -c "truncate $filesize" $testfile >> $seqres.full
+	sync $testfile
+
+	test_torn_write
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
+}
+
+test_append_torn_write() {
+	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Performing append atomic writes over file in background" >> $seqres.full
+
+	start_atomic_write_and_shutdown
+
+	local last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
+	if [[ -z $last_offset ]]
+	then
+		last_offset=0
+	fi
+
+	echo >> $seqres.full
+	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
+	rm $tmp.aw
+	sleep 0.5
+
+	_scratch_cycle_mount
+	local filesize=$(_get_filesize $testfile)
+	echo >> $seqres.full
+	echo "# Filesize after shutdown: $filesize" >> $seqres.full
+
+	# To confirm that the write went atomically, we check:
+	# 1. The last block should be a multiple of awu_max
+	# 2. The last block should be the completely new data
+
+	if (( $filesize % $awu_max ))
+	then
+		echo "Filesize after shutdown ($filesize) not a multiple of atomic write unit ($awu_max)"
+	fi
+
+	verify_start=$(( filesize - (awu_max * 5)))
+	if [[ $verify_start < 0 ]]
+	then
+		verify_start=0
+	fi
+
+	local verify_end=$filesize
+
+	# Here the blocks should always match new data hence, for simplicity of
+	# code, just corrupt the $expected_data_old buffer so it never matches
+	local expected_data_old="POISON"
+	verify_data_blocks $verify_start $verify_end "$expected_data_old" "$expected_data_new"
+}
+
+$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+dry_run
+
+echo >> $seqres.full
+echo "# Populating expected data buffers" >> $seqres.full
+populate_expected_data
+
+# Loop 20 times to shake out any races due to shutdown
+for ((iter=0; iter<20; iter++))
+do
+	echo >> $seqres.full
+	echo "------ Iteration $iter ------" >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Starting torn write test for atomic writes over mixed mapping" >> $seqres.full
+	test_torn_write_mixed
+
+	echo >> $seqres.full
+	echo "# Starting torn write test for atomic writes over fully written mapping" >> $seqres.full
+	test_torn_write_written
+
+	echo >> $seqres.full
+	echo "# Starting torn write test for atomic writes over fully unwritten mapping" >> $seqres.full
+	test_torn_write_unwritten
+
+	echo >> $seqres.full
+	echo "# Starting torn write test for atomic writes over holes" >> $seqres.full
+	test_torn_write_hole
+
+	echo >> $seqres.full
+	echo "# Starting shutdown torn write test for append atomic writes" >> $seqres.full
+	test_append_torn_write
+done
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/1230.out b/tests/generic/1230.out
new file mode 100644
index 00000000..d01f54ea
--- /dev/null
+++ b/tests/generic/1230.out
@@ -0,0 +1,2 @@
+QA output created by 1230
+Silence is golden
-- 
2.49.0


