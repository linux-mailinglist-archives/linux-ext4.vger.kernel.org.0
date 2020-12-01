Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6272CA36B
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Dec 2020 14:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgLANFP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Dec 2020 08:05:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727658AbgLANFP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Dec 2020 08:05:15 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1D2uN0190946;
        Tue, 1 Dec 2020 08:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pJz9CQlhOyxs9SWnIFTFVbeaUA/55eQfVhU3WhvcVpg=;
 b=Vr2u95ZaqQ0TL8IZM6g26c54fQC98K+DxCNvlM0u3xEFk3F5UQlzB7K7rzXKxuv1jqFJ
 EFn4Oc92zVSark2P7DjOr8C9/oygWl8cwthKwTHB5NzyUH/UL1xFCuiSOw1lpXp3yAOz
 aywnpbDH0ghbsmFRIEPrmWZbk0yhcnv5C0xNm3uxcj7nIF9Cz0IOhaFiecHWwWTwxaaN
 DmjK0X3U9pCGHDHDaJNQJ0EIXINe5eiH+8M0c89f4XwHBbyxFMz0ZXpDsed36BUumjHt
 uwToLNJO0q1YBhjx8dyTFHFGw2o7A9RbJG0sbkW5wYTIXwWp3qQmipdMgWktZG11VXdN eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jjgpk5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 08:04:32 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B1D2vZQ190993;
        Tue, 1 Dec 2020 08:04:01 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jjgpjm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 08:04:01 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1D1fEa022673;
        Tue, 1 Dec 2020 13:03:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 353e68355q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 13:03:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1D3UsX47186236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 13:03:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E3D711C05C;
        Tue,  1 Dec 2020 13:03:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2A6E11C04C;
        Tue,  1 Dec 2020 13:03:28 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.123.125])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Dec 2020 13:03:28 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        riteshh@linux.ibm.com, sourabhjain@linux.ibm.com,
        psampat@linux.ibm.com, pratik.r.sampat@gmail.com
Subject: [PATCH v2] generic: ENOSPC regression test in a multi-threaded scenario
Date:   Tue,  1 Dec 2020 18:33:28 +0530
Message-Id: <20201201130328.46460-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_05:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010083
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Test allocation strategies of the file system and validate space
anomalies as reported by the system versus the allocated by the
program.

The test is motivated by a bug in ext4 systems where-in ENOSPC is
reported by the file system even though enough space for allocations is
available[1].

[1]: https://patchwork.ozlabs.org/patch/1294003

Linux kernel patch series that fixes the above regression:
53f86b170dfa ("ext4: mballoc: add blocks to PA list under same spinlock
              after allocating blocks")
cf5e2ca6c990 ("ext4: mballoc: refactor ext4_mb_discard_preallocations()")
07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to
              improve ENOSPC handling")
8ef123fe02ca ("ext4: mballoc: refactor ext4_mb_good_group()")
993778306e79 ("ext4: mballoc: use lock for checking free blocks while
              retrying")

Suggested-by: Ritesh Harjani <riteshh@linux.ibm.com>
Co-authored-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
Changelog:
v1: https://patchwork.kernel.org/patch/11935521
Incorporated the following review comments by Eryu Guan
1. Added references to upstream ext4 bug fix
2. Added entry in .gitignore
3. Explained file ratio argument, along with acceptable ratio format
4. Enabled debug prints by default to go to $seqres.full
5. Added _require_xfs_io_command "falloc" check
6. Removed TEST_DIR require check
7. Described the arguments in calc_thread_cnt and run_testcase
8. Replaced df and bc usage with $DF_PROG and $BC_PROG respectively
9. Fixed -f option to identify fallocate instead of ftruncate
10. Refactored "for" loop format
11. Added comments describing error codes
12. Added and tested the $FTRUNCATE option 
13. Dropped stress group and added enospc group

---
 .gitignore            |   1 +
 src/Makefile          |   2 +-
 src/t_enospc.c        | 193 +++++++++++++++++++++++++++++++++++++++
 tests/generic/618     | 207 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/618.out |   2 +
 tests/generic/group   |   1 +
 6 files changed, 405 insertions(+), 1 deletion(-)
 create mode 100644 src/t_enospc.c
 create mode 100755 tests/generic/618
 create mode 100644 tests/generic/618.out

diff --git a/.gitignore b/.gitignore
index 5f5c4a0f..041cc2d9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -125,6 +125,7 @@
 /src/t_dir_offset2
 /src/t_dir_type
 /src/t_encrypted_d_revalidate
+/src/t_enospc
 /src/t_ext4_dax_inline_corruption
 /src/t_ext4_dax_journal_corruption
 /src/t_futimens
diff --git a/src/Makefile b/src/Makefile
index 919d77c4..32940142 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -17,7 +17,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
-	t_get_file_time t_create_short_dirs t_create_long_dirs
+	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/t_enospc.c b/src/t_enospc.c
new file mode 100644
index 00000000..d06c6764
--- /dev/null
+++ b/src/t_enospc.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 IBM.
+ * All Rights Reserved.
+ *
+ * simple mmap write multithreaded test for testing enospc
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <assert.h>
+#include <sys/mman.h>
+#include <pthread.h>
+#include <signal.h>
+
+#define pr_debug(fmt, ...) do { \
+    if (verbose) { \
+        printf (fmt, ##__VA_ARGS__); \
+    } \
+} while (0)
+
+struct thread_s {
+	int id;
+};
+
+static float file_ratio[2] = {0.5, 0.5};
+static unsigned long fsize = 0;
+static char *base_dir = ".";
+static char *ratio = "1";
+
+static bool use_fallocate = false;
+static bool verbose = false;
+
+pthread_barrier_t bar;
+
+void handle_sigbus(int sig)
+{
+	pr_debug("Enospc test failed with SIGBUS\n");
+	exit(7);
+}
+
+void enospc_test(int id)
+{
+	int fd;
+	char fpath[255] = {0};
+	char *addr;
+	unsigned long size = 0;
+
+	/*
+	 * Comma separated values against -r option indicates that the file
+	 * should be divided into two small files.
+	 * The file_ratio specifies the proportion in which the file sizes must
+	 * be divided into.
+	 *
+	 * Half of the files will be divided into size of the first ratio and the
+	 * rest of the following ratio
+	 */
+
+	if (id % 2 == 0)
+		size = fsize * file_ratio[0];
+	else
+		size = fsize * file_ratio[1];
+
+	pthread_barrier_wait(&bar);
+
+	sprintf(fpath, "%s/mmap-file-%d", base_dir, id);
+	pr_debug("Test write phase starting file %s fsize %lu, id %d\n", fpath, size, id);
+
+	signal(SIGBUS, handle_sigbus);
+
+	fd = open(fpath, O_RDWR | O_CREAT, 0644);
+	if (fd < 0) {
+		pr_debug("Open failed\n");
+		exit(1);
+	}
+
+	if (use_fallocate)
+		assert(fallocate(fd, 0, 0, size) == 0);
+	else
+		assert(ftruncate(fd, size) == 0);
+
+	addr = mmap(NULL, size, PROT_WRITE, MAP_SHARED, fd, 0);
+	assert(addr != MAP_FAILED);
+
+	for (int i = 0; i < size; i++) {
+		addr[i] = 0xAB;
+	}
+
+	assert(munmap(addr, size) != -1);
+	close(fd);
+	pr_debug("Test write phase completed...file %s, fsize %lu, id %d\n", fpath, size, id);
+}
+
+void *spawn_test_thread(void *arg)
+{
+	struct thread_s *thread_info = (struct thread_s *)arg;
+
+	enospc_test(thread_info->id);
+	return NULL;
+}
+
+void _run_test(int threads)
+{
+	pthread_t tid[threads];
+
+	pthread_barrier_init(&bar, NULL, threads+1);
+	for (int i = 0; i < threads; i++) {
+		struct thread_s *thread_info = (struct thread_s *) malloc(sizeof(struct thread_s));
+		thread_info->id = i;
+		assert(pthread_create(&tid[i], NULL, spawn_test_thread, thread_info) == 0);
+	}
+
+	pthread_barrier_wait(&bar);
+
+	for (int i = 0; i <threads; i++) {
+		assert(pthread_join(tid[i], NULL) == 0);
+	}
+
+	pthread_barrier_destroy(&bar);
+	return;
+}
+
+static void usage(void)
+{
+	printf("\nUsage: t_enospc [options]\n\n"
+	       " -t                    thread count\n"
+	       " -s size               file size\n"
+	       " -p path               set base path\n"
+	       " -f fallocate          use fallocate instead of ftruncate\n"
+	       " -v verbose            print debug information\n"
+	       " -r ratio              ratio of file sizes, ',' separated values (def: 0.5,0.5)\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int opt;
+	int threads = 0;
+	char *ratio_ptr;
+
+	while ((opt = getopt(argc, argv, ":r:p:t:s:vf")) != -1) {
+		switch(opt) {
+		case 't':
+			threads = atoi(optarg);
+			pr_debug("Testing with (%d) threads\n", threads);
+			break;
+		case 's':
+			fsize = atoi(optarg);
+			pr_debug("size: %lu Bytes\n", fsize);
+			break;
+		case 'p':
+			base_dir = optarg;
+			break;
+		case 'r':
+			ratio = optarg;
+			ratio_ptr = strtok(ratio, ",");
+			if (ratio_ptr[0] == '1') {
+				file_ratio[0] = 1;
+				file_ratio[1] = 1;
+				break;
+			}
+			if (ratio_ptr != NULL)
+				file_ratio[0] = strtod(ratio_ptr, NULL);
+			ratio_ptr = strtok(NULL, ",");
+			if (ratio_ptr != NULL)
+				file_ratio[1] = strtod(ratio_ptr, NULL);
+			break;
+		case 'f':
+			use_fallocate = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		case '?':
+			usage();
+			exit(1);
+		}
+	}
+
+	/* Sanity test of parameters */
+	assert(threads);
+	assert(fsize);
+	assert(file_ratio[0]);
+	assert(file_ratio[1]);
+
+	pr_debug("Testing with (%d) threads\n", threads);
+	pr_debug("size: %lu Bytes\n", fsize);
+
+	_run_test(threads);
+	return 0;
+}
diff --git a/tests/generic/618 b/tests/generic/618
new file mode 100755
index 00000000..69776363
--- /dev/null
+++ b/tests/generic/618
@@ -0,0 +1,207 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 618
+#
+# ENOSPC regression test in a multi-threaded scenario. Test allocation
+# strategies of the file system and validate space anomalies as reported by
+# the system versus the allocated by the program.
+#
+# The test is motivated by a bug in ext4 systems where-in ENOSPC is
+# reported by the file system even though enough space for allocations is
+# available[1].
+# [1]: https://patchwork.ozlabs.org/patch/1294003
+#
+# Linux kernel patch series that fixes the above regression:
+# 53f86b170dfa ("ext4: mballoc: add blocks to PA list under same spinlock
+#               after allocating blocks")
+# cf5e2ca6c990 ("ext4: mballoc: refactor ext4_mb_discard_preallocations()")
+# 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to
+#               improve ENOSPC handling")
+# 8ef123fe02ca ("ext4: mballoc: refactor ext4_mb_good_group()")
+# 993778306e79 ("ext4: mballoc: use lock for checking free blocks while
+#               retrying")
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
+FS_SIZE=$((240*1024*1024)) # 240MB
+DEBUG=1 # set to 0 to disable debug statements in shell and c-prog
+FACT=0.7
+
+# Disk allocation methods
+FALLOCATE=1
+FTRUNCATE=2
+
+# Helps to build TEST_VECTORS
+SMALL_FILE_SIZE=$((512 * 1024)) # in Bytes
+BIG_FILE_SIZE=$((1536 * 1024))  # in Bytes
+MIX_FILE_SIZE=$((2048 * 1024))  # (BIG + SMALL small file size)
+
+_cleanup()
+{
+	cd /
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
+_supported_fs generic
+_require_scratch
+_require_test_program "t_enospc"
+_require_xfs_io_command "falloc"
+
+debug()
+{
+	if [ $DEBUG -eq 1 ]; then
+		echo "$1" >> $seqres.full
+	fi
+}
+
+# Calculate the number of threads needed to fill the disk space
+# Arguments
+# $1: the size of a file
+# $2: ratio in which $1 file should be split into multiple files.
+# $3: percentage of the disk space should be used during the test
+# Calculate the number of threads needed to fill the disk space
+calc_thread_cnt()
+{
+	local file_ratio_unit=$1
+	local file_ratio=$2
+	local disk_saturation=$3
+	local tot_avail_size
+	local avail_size
+	local thread_cnt
+
+	IFS=',' read -ra fratio <<< $file_ratio
+	file_ratio_cnt=${#fratio[@]}
+
+	tot_avail_size=$($DF_PROG --block-size=1 $SCRATCH_DEV | awk 'FNR == 2 { print $5 }')
+	avail_size=$(echo $tot_avail_size*$disk_saturation | $BC_PROG)
+	thread_cnt=$(echo "$file_ratio_cnt*($avail_size/$file_ratio_unit)" | $BC_PROG)
+
+	debug "Total available size: $tot_avail_size"
+	debug "Available size: $avail_size"
+	debug "Thread count: $thread_cnt"
+
+	echo ${thread_cnt}
+}
+
+# Arguments
+# $1: a string containing test configuration separated by a colon.
+#     $1 is treated as an array of arguments to the function.
+#     Description of each array element is given below.
+#
+# @1: name of the test
+# @2: thread in t_enospec exerciser will allocate file of @2 size
+# @3: defines the proportion in which the file size defined in @2
+#     should be divided into two files.
+#     (valid @3: more than two values are not allowed)
+#                values should be comma separated)
+#                sum of all values must be 1)
+# @4: define the percentage of available memory should be used to
+#     during the test.
+# @5: defines the disk allocation method (fallocate/ftruncate)
+# @6: number of the test should run
+run_testcase()
+{
+	IFS=':' read -ra args <<< $1
+	local test_name=${args[0]}
+	local file_ratio_unit=${args[1]}
+	local file_ratio=${args[2]}
+	local disk_saturation=${args[3]}
+	local disk_alloc_method=${args[4]}
+	local test_iteration_cnt=${args[5]}
+	local extra_args=""
+	local thread_cnt
+
+	if [ "$disk_alloc_method" == "$FALLOCATE" ]; then
+		extra_args="$extra_args -f"
+	fi
+
+	# enable the debug statements in c program
+	if [ "$DEBUG" -eq 1 ]; then
+		extra_args="$extra_args -v"
+	fi
+
+	debug "============ Test details start ============"
+	debug "Test name: $test_name"
+	debug "File ratio unit: $file_ratio_unit"
+	debug "File ratio: $file_ratio"
+	debug "Disk saturation $disk_saturation"
+	debug "Disk alloc method $disk_alloc_method"
+	debug "Test iteration count: $test_iteration_cnt"
+	debug "Extra arg: $extra_args"
+
+	for i in $(eval echo "{1..$test_iteration_cnt}"); do
+		# Setup the device
+		_scratch_mkfs_sized $FS_SIZE >> $seqres.full 2>&1
+		_scratch_mount
+
+		debug "===== Test: $test_name iteration: $i starts ====="
+		thread_cnt=$(calc_thread_cnt $file_ratio_unit $file_ratio $disk_saturation)
+
+		# Start the test
+		$here/src/t_enospc -t $thread_cnt -s $file_ratio_unit -r $file_ratio -p $SCRATCH_MNT $extra_args >> $seqres.full
+
+		status=$(echo $?)
+		if [ $status -ne 0 ]; then
+			use_per=$($DF_PROG -h | grep $SCRATCH_MNT | awk '{print substr($6, 1, length($6)-1)}' | $BC_PROG)
+			alloc_per=$(echo "$FACT * 100" | $BC_PROG)
+			# We are here since t_enospc failed with an error code.
+			# If the used filesystem space is still < available space - that means
+			# the test failed due to FS wrongly reported ENOSPC.
+			if [ $(echo "$use_per < $alloc_per" | $BC_PROG) -ne 0 ]; then
+				if [ $status -eq 134 ]; then
+					# SIGABRT asserted exit code = 134
+					echo "FAIL: Aborted assertion faliure"
+				elif [ $status -eq 7 ]; then
+					# SIGBUS asserted exit code = 7
+					echo "FAIL: ENOSPC BUS faliure"
+				fi
+				echo "$test_name failed at iteration count: $i"
+				echo "$($DF_PROG -h $SCRATCH_MNT)"
+				echo "Allocated: $alloc_per% Used: $use_per%"
+				exit
+			fi
+		fi
+
+		# Make space for other tests
+		_scratch_unmount
+
+		debug "===== Test: $test_name iteration: $i ends ====="
+	done
+	debug "============ Test details end ============="
+}
+
+declare -a TEST_VECTORS=(
+# test-name:file-ratio-unit:file-ratio:disk-saturation:disk-alloc-method:test-iteration-cnt
+"Small-file-fallocate-test:$SMALL_FILE_SIZE:1:$FACT:$FALLOCATE:3"
+"Big-file-fallocate-test:$BIG_FILE_SIZE:1:$FACT:$FALLOCATE:3"
+"Mix-file-fallocate-test:$MIX_FILE_SIZE:0.75,0.25:$FACT:$FALLOCATE:3"
+"Small-file-ftruncate-test:$SMALL_FILE_SIZE:1:$FACT:$FTRUNCATE:3"
+"Big-file-ftruncate-test:$BIG_FILE_SIZE:1:$FACT:$FTRUNCATE:3"
+"Mix-file-ftruncate-test:$MIX_FILE_SIZE:0.75,0.25:$FACT:$FTRUNCATE:3"
+)
+
+# real QA test starts here
+for i in "${TEST_VECTORS[@]}"; do
+	run_testcase $i
+done
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/618.out b/tests/generic/618.out
new file mode 100644
index 00000000..8940b72f
--- /dev/null
+++ b/tests/generic/618.out
@@ -0,0 +1,2 @@
+QA output created by 618
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 94e860b8..e67e620b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -620,3 +620,4 @@
 615 auto rw
 616 auto rw io_uring stress
 617 auto rw io_uring stress
+618 auto rw enospc
-- 
2.28.0

