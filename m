Return-Path: <linux-ext4+bounces-9316-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298EB1FA3D
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3E57A7CB1
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECB2276022;
	Sun, 10 Aug 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F/fwmhpW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF6275B08;
	Sun, 10 Aug 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833360; cv=none; b=PZ1Ml8WD+bHh7cwNuFR8n5nJGetMU7MfCzi3Xd262eRBLjJrPOg64cwuAJ6CQ54z085k7QIK6HAhOuF79tLBNP/aWkYk28faC5g8iwI5128YctSACF2OwoYGZZiJvk7Vx0k9uWAcnwxjsFYBjcNYAVF3uI3WrkcYvYkAvNziido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833360; c=relaxed/simple;
	bh=5Whlb3M258/hYH1QZfI08fWCJYDAzM4q+pN3fIkE6zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVC3rcG4mZbLY2CiE9WmGaMBsSCwm2Z9NmrGW2kqvCB29OmGnhOdqyI9Wlovw+soxHaJ/TIZ/t2ou3tqPkArB2i5dJgZSW1u4DsQVjC8gOAA/OwEcWn6xEZMAxtuE6Au2Kz7Kx4pCEjfKeDv3cmuiLCjVAlak9HqBvVCF7VnJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F/fwmhpW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ABmBYR002295;
	Sun, 10 Aug 2025 13:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=K/X0pllH+N+VUDutZ
	XHOgTw9gsmcrn73ZXWsZBojlR0=; b=F/fwmhpWdkoFjw6EH5roCDNrcj0HZr8m4
	FkdziKAjIlz18NeSs7L+rlXSfQwiGtbRsVlm0r8hDi881l3IpurKJNRleCB+TBlm
	htrlyR1B6SZTogu9w/8njIbiemjD2uhU+X4a2m6gM1vd3Sl6L4zQnn8aKKXWrVhB
	auMla/Yn1kSzvmhnlhqqWXXSTnUyMthdqkRkPj//fgrLBPaUc50+dDwnrHUr7nes
	75RRNDSZQcdg3cWyp+zeCNQoXSOHeITZupuezzrykNSNkfkzdyfV6H746DGL54Wn
	26elLZCbjvNjQAF62K+vEK6OOVNqATC4M5GVgkOn325jB7o80C01A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durtwjb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:30 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADemqb003312;
	Sun, 10 Aug 2025 13:42:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durtwjb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57A8ZwlT025654;
	Sun, 10 Aug 2025 13:42:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvm1rpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADgRBj15860120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 263D520043;
	Sun, 10 Aug 2025 13:42:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCAA820040;
	Sun, 10 Aug 2025 13:42:24 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:24 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 08/11] generic: Add sudden shutdown tests for multi block atomic writes
Date: Sun, 10 Aug 2025 19:11:59 +0530
Message-ID: <36f8204dfa6880956dd94a52e9d89b4f1dfeba53.1754833177.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: 9HcCdvpu4xlMdj4iiJ-HPeVM4v5heHRA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfX8Lg4GGo6M0Kp
 +BAOgRPWQXe86PyttdWzV5osqtcqOLjc6brsnvPRwMbM+5eT4CuW0oxaWqL0dwSZPuEQ39Qi2KO
 akXpzi6qjIMejgKYKAXDXNkbkb7RJnlT2KFntIPioZwtfQnyq/Qdde5oTaFAnLWtEwm69u4XBow
 m1wNT26gtB8EXmSORGP/zBV6se7OuerjMmxk2RupkHTWd7LoYQ1/Ozh1vbyi4j4uPm3CBN5eUq+
 g/R3OfJ3PRFSfvXO7b9p7ef4ckEO9+dR2QKtcPayykZPm+Zopl4BMS5JzLPBOyZmqC1d5cQ0pC4
 EIyHJEDfeT5eFaxWsM8j27g7UnLV2NWCKUbXJtcFBErYuYLylZeKQvjqFll0ZUQXa5Eiq8+H/s8
 atgoigwxSanKu+C/R4EmiJpPoJVFrylCrwLRLYOxgl56fqoOYq3x9+Dq1vyl++J5NgEppuua
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=6898a1c6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=jzLDx6uKbS-OZFe_CzQA:9
X-Proofpoint-ORIG-GUID: Ku93tApph_-hkBr3u6rjQoMhbkxPjknr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100097

This test is intended to ensure that multi blocks atomic writes
maintain atomic guarantees across sudden FS shutdowns.

The way we work is that we lay out a file with random mix of written,
unwritten and hole extents. Then we start performing atomic writes
sequentially on the file while we parallely shutdown the FS. Then we
note the last offset where the atomic write happened just before shut
down and then make sure blocks around it either have completely old
data or completely new data, ie the write was not torn during shutdown.

We repeat the same with completely written, completely unwritten and completely
empty file to ensure these cases are not torn either.  Finally, we have a
similar test for append atomic writes

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1230     | 397 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1230.out |   2 +
 2 files changed, 399 insertions(+)
 create mode 100755 tests/generic/1230
 create mode 100644 tests/generic/1230.out

diff --git a/tests/generic/1230 b/tests/generic/1230
new file mode 100755
index 00000000..cff5adc0
--- /dev/null
+++ b/tests/generic/1230
@@ -0,0 +1,397 @@
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
+# This test has the following flow:
+# 1. Start doing sequential atomic writes in bg, upto $filesize
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
+	atomic_write_loop &
+	awloop_pid=$!
+
+	local i=0
+	# Wait for atleast first write to be recorded or 10s
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
+	echo "# Checking data integrity from $verify_start to $verify_end" >> $seqres.full
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
+			echo "Expected old: "
+			echo "$expected_data_old"
+			echo
+			echo "Expected new: "
+			echo "$expected_data_new"
+			echo
+			echo "Actual contents: "
+			echo "$actual_data"
+
+			_fail
+		fi
+		echo -n "Check at offset $off suceeded! " >> $seqres.full
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
+# test data integrity for file by shutting down in between atomic writes
+test_data_integrity() {
+	echo >> $seqres.full
+	echo "# Writing atomically to file in background" >> $seqres.full
+	atomic_write_loop &
+	awloop_pid=$!
+
+	local i=0
+	# Wait for atleast first write to be recorded or 10s
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
+	# we want to verify all blocks around which the shutdown happended
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
+# test data integrity for file wiht written and unwritten mappings
+test_data_integrity_mixed() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with mixed mappings" >> $seqres.full
+	create_mixed_mappings $testfile $filesize
+
+	test_data_integrity
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_mixed" "$expected_data_new"
+}
+
+# test data integrity for file with completely written mappings
+test_data_integrity_writ() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with fully written mapping" >> $seqres.full
+	$XFS_IO_PROG -c "pwrite -b $filesize 0 $filesize" $testfile >> $seqres.full
+	sync $testfile
+
+	test_data_integrity
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_mapped" "$expected_data_new"
+}
+
+# test data integrity for file with completely unwritten mappings
+test_data_integrity_unwrit() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with fully unwritten mappings" >> $seqres.full
+	$XFS_IO_PROG -c "falloc 0 $filesize" $testfile >> $seqres.full
+	sync $testfile
+
+	test_data_integrity
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
+}
+
+# test data integrity for file with no mappings
+test_data_integrity_hole() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with no mappings" >> $seqres.full
+	$XFS_IO_PROG -c "truncate $filesize" $testfile >> $seqres.full
+	sync $testfile
+
+	test_data_integrity
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
+}
+
+test_filesize_integrity() {
+	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Performing extending atomic writes over file in background" >> $seqres.full
+	atomic_write_loop &
+	awloop_pid=$!
+
+	local i=0
+	# Wait for atleast first write to be recorded or 10s
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
+	echo "# Starting data integrity test for atomic writes over mixed mapping" >> $seqres.full
+	test_data_integrity_mixed
+
+	echo >> $seqres.full
+	echo "# Starting data integrity test for atomic writes over fully written mapping" >> $seqres.full
+	test_data_integrity_writ
+
+	echo >> $seqres.full
+	echo "# Starting data integrity test for atomic writes over fully unwritten mapping" >> $seqres.full
+	test_data_integrity_unwrit
+
+	echo >> $seqres.full
+	echo "# Starting data integrity test for atomic writes over holes" >> $seqres.full
+	test_data_integrity_hole
+
+	echo >> $seqres.full
+	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
+	test_filesize_integrity
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


