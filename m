Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900C22CA153
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Dec 2020 12:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgLAL2a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Dec 2020 06:28:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55354 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727858AbgLAL2a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Dec 2020 06:28:30 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1B3amb008799;
        Tue, 1 Dec 2020 06:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kf1lZ+X1XLDmmw3WTSSoHq5DE/cbQTB8TSiM6gQCMKY=;
 b=nwYpqHyEoAddCcIcnDtdu0oAcS8VDpiBPOHx70TtamhGFxQb1Yf7S5fGZafoEX8K+maZ
 7WnKJKneLkBZbocE2RivBh6qgnYVRryxNrobp3dbob5QP3fz9Pu5zc0i++jO3K25FQQm
 +8eSBdUf8VbzN1VgS3Urbq+ywB2f5yKyZrhxCnoEM5Uymcbv9gs/cyx7rUkxxLzzX45o
 PrQ2kydjRTQRz3+eIibXCqSeGOf8JffmfPk9rw3WHswEFRqofZ9fNQr4Ao4yQLhDfp3e
 afrxk4YSxdlw54EqwUsBc6jj/ZM0vGDiKX5CN3XH9kRfgy3DjCDiiM5gSW2vlu1sNxVn gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355ghqr9hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 06:27:45 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B1B5xJK021027;
        Tue, 1 Dec 2020 06:27:44 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355ghqr9hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 06:27:44 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1BNKHc031518;
        Tue, 1 Dec 2020 11:27:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 353e684hvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 11:27:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1BRdrK1311310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 11:27:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7408C52057;
        Tue,  1 Dec 2020 11:27:39 +0000 (GMT)
Received: from [9.85.123.125] (unknown [9.85.123.125])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4802E52050;
        Tue,  1 Dec 2020 11:27:38 +0000 (GMT)
Subject: Re: [PATCH] generic: ENOSPC regression test in a multi-threaded
 scenario
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        riteshh@linux.ibm.com, sourabhjain@linux.ibm.com,
        pratik.r.sampat@gmail.com
References: <20201127105415.41831-1-psampat@linux.ibm.com>
 <20201129114336.GS3853@desktop>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <366f8a25-fe41-9e25-e7fe-b27b47d63a42@linux.ibm.com>
Date:   Tue, 1 Dec 2020 16:57:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201129114336.GS3853@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_04:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010072
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the review.

I'll post out a version 2 addressing the comments below.

Thanks,
Pratik


On 29/11/20 5:13 pm, Eryu Guan wrote:
> On Fri, Nov 27, 2020 at 04:24:15PM +0530, Pratik Rajesh Sampat wrote:
>> Test allocation strategies of the file system and validate space
>> anomalies as reported by the system versus the allocated by the
>> program.
>>
>> The test is motivated by a bug in ext4 systems where-in ENOSPC is
>> reported by the file system even though enough space for allocations is
>> available[1].
>> [1]: https://patchwork.ozlabs.org/patch/1294003
> I see that the referenced patch has been upstreamed, Would you please
> reference the commit with commit id and title as well? So it's easier to
> know which commit fixed the bug.
>
>> Suggested-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> Co-authored-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
>> ---
>>   src/Makefile          |   2 +-
>>   src/t_enospc.c        | 186 ++++++++++++++++++++++++++++++++++++++++++
> Need an entry in .gitignore as well.
>
>>   tests/generic/618     | 168 ++++++++++++++++++++++++++++++++++++++
>>   tests/generic/618.out |   2 +
>>   tests/generic/group   |   1 +
>>   5 files changed, 358 insertions(+), 1 deletion(-)
>>   create mode 100644 src/t_enospc.c
>>   create mode 100755 tests/generic/618
>>   create mode 100644 tests/generic/618.out
>>
>> diff --git a/src/Makefile b/src/Makefile
>> index 919d77c4..32940142 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -17,7 +17,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>>   	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
>>   	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
>>   	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>> -	t_get_file_time t_create_short_dirs t_create_long_dirs
>> +	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc
>>   
>>   LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>   	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
>> diff --git a/src/t_enospc.c b/src/t_enospc.c
>> new file mode 100644
>> index 00000000..a0a8c783
>> --- /dev/null
>> +++ b/src/t_enospc.c
>> @@ -0,0 +1,186 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2020 IBM.
>> + * All Rights Reserved.
>> + *
>> + * simple mmap write multithreaded test
>> + */
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <stdbool.h>
>> +#include <unistd.h>
>> +#include <fcntl.h>
>> +#include <string.h>
>> +#include <assert.h>
>> +#include <sys/mman.h>
>> +#include <pthread.h>
>> +#include <signal.h>
>> +
>> +#define pr_debug(fmt, ...) do { \
>> +    if (verbose) { \
>> +        printf (fmt, ##__VA_ARGS__); \
>> +    } \
>> +} while (0)
>> +
>> +struct thread_s {
>> +	int id;
>> +};
>> +
>> +static float file_ratio[2] = {0.5, 0.5};
>> +static unsigned long fsize = 0;
>> +static char *base_dir = ".";
>> +static char *ratio = "1";
>> +
>> +static bool use_fallocate = false;
>> +static bool verbose = false;
>> +
>> +pthread_barrier_t bar;
>> +
>> +void handle_sigbus(int sig)
>> +{
>> +	pr_debug("Enospc test failed with SIGBUS\n");
>> +	exit(7);
>> +}
>> +
>> +void enospc_test(int id)
>> +{
>> +	int fd;
>> +	char fpath[255] = {0};
>> +	char *addr;
>> +	unsigned long size = 0;
>> +
>> +	if (id % 2 == 0)
>> +		size = fsize * file_ratio[0];
>> +	else
>> +		size = fsize * file_ratio[1];
> What's the purpose of this ratio? Some comments would be good.
>
>> +
>> +	pthread_barrier_wait(&bar);
>> +
>> +	sprintf(fpath, "%s/mmap-file-%d", base_dir, id);
>> +	pr_debug("Test write phase starting file %s fsize %lu, id %d\n", fpath, size, id);
>> +
>> +	signal(SIGBUS, handle_sigbus);
>> +
>> +	fd = open(fpath, O_RDWR | O_CREAT, 0644);
>> +	if (fd < 0) {
>> +		pr_debug("Open failed\n");
>> +		exit(1);
>> +	}
>> +
>> +	if (use_fallocate)
>> +		assert(fallocate(fd, 0, 0, fsize) == 0);
>                                             ^^^^^^ should be size?
>> +	else
>> +		assert(ftruncate(fd, size) == 0);
>> +
>> +	addr = mmap(NULL, size, PROT_WRITE, MAP_SHARED, fd, 0);
>> +	assert(addr != MAP_FAILED);
>> +
>> +	for (int i = 0; i < size; i++) {
>> +		addr[i] = 0xAB;
>> +	}
>> +
>> +	assert(munmap(addr, size) != -1);
>> +	close(fd);
>> +	pr_debug("Test write phase completed...file %s, fsize %lu, id %d\n", fpath, size, id);
>> +}
>> +
>> +void *spawn_test_thread(void *arg)
>> +{
>> +	struct thread_s *thread_info = (struct thread_s *)arg;
>> +	pthread_t tid;
>> +
>> +	tid = pthread_self();
>> +	pr_debug("Inside thread %lu %d\n", tid, thread_info->id);
>> +	enospc_test(thread_info->id);
>> +	return NULL;
>> +}
>> +
>> +void _run_test(int threads)
>> +{
>> +	pthread_t tid[threads];
>> +
>> +	pthread_barrier_init(&bar, NULL, threads+1);
>> +	for (int i = 0; i < threads; i++) {
>> +		struct thread_s *thread_info = (struct thread_s *) malloc(sizeof(struct thread_s));
>> +		thread_info->id = i;
>> +		assert(pthread_create(&tid[i], NULL, spawn_test_thread, thread_info) == 0);
>> +	}
>> +
>> +	pthread_barrier_wait(&bar);
>> +
>> +	for (int i = 0; i <threads; i++) {
>> +		assert(pthread_join(tid[i], NULL) == 0);
>> +	}
>> +
>> +	pthread_barrier_destroy(&bar);
>> +	return;
>> +}
>> +
>> +static void usage(void)
>> +{
>> +	printf("\nUsage: t_enospc [options]\n\n"
>> +	       " -t                    thread count\n"
>> +	       " -s size               file size\n"
>> +	       " -p path               set base path\n"
>> +	       " -f fallocate          use fallocate instead of ftruncate\n"
>> +	       " -v verbose            print debug information\n"
>> +	       " -r ratio              ratio of file sizes\n");
> It'd good to describe the acceptable ratio format as well.
>
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	int opt;
>> +	int threads = 0;
>> +	char *ratio_ptr;
>> +
>> +	while ((opt = getopt(argc, argv, ":r:p:t:s:vf")) != -1) {
>> +		switch(opt) {
>> +		case 't':
>> +			threads = atoi(optarg);
>> +			pr_debug("Testing with (%d) threads\n", threads);
>> +			break;
>> +		case 's':
>> +			fsize = atoi(optarg);
>> +			pr_debug("size: %lu Bytes\n", fsize);
>> +			break;
>> +		case 'p':
>> +			base_dir = optarg;
>> +			break;
>> +		case 'r':
>> +			ratio = optarg;
>> +			ratio_ptr = strtok(ratio, ",");
>> +			if (ratio_ptr[0] == '1') {
>> +				file_ratio[0] = 1;
>> +				file_ratio[1] = 1;
>> +				break;
>> +			}
>> +			if (ratio_ptr != NULL)
>> +				file_ratio[0] = strtod(ratio_ptr, NULL);
>> +			ratio_ptr = strtok(NULL, ",");
>> +			if (ratio_ptr != NULL)
>> +				file_ratio[1] = strtod(ratio_ptr, NULL);
>> +			break;
>> +		case 'f':
>> +			use_fallocate = true;
>> +			break;
>> +		case 'v':
>> +			verbose = true;
>> +			break;
>> +		case '?':
>> +			usage();
>> +			exit(1);
>> +		}
>> +	}
>> +
>> +	/* Sanity test of parameters */
>> +	assert(threads);
>> +	assert(fsize);
>> +	assert(file_ratio[0]);
>> +	assert(file_ratio[1]);
>> +
>> +	pr_debug("Testing with (%d) threads\n", threads);
>> +	pr_debug("size: %lu Bytes\n", fsize);
>> +
>> +	_run_test(threads);
>> +	return 0;
>> +}
>> diff --git a/tests/generic/618 b/tests/generic/618
>> new file mode 100755
>> index 00000000..57216b3d
>> --- /dev/null
>> +++ b/tests/generic/618
>> @@ -0,0 +1,168 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2020 IBM Corporation. All Rights Reserved.
>> +#
>> +# FS QA Test 618
> Add an empty line here.
>
>> +# ENOSPC regression test in a multi-threaded scenario. Test allocation
>> +# strategies of the file system and validate space anomalies as reported by
>> +# the system versus the allocated by the program.
>> +#
>> +# With this we should be able to catch similar regressions as reported on
>> +# ext4 on 5.7 kernel which was fixed by patch [1]
>> +# [1]: https://patchwork.ozlabs.org/patch/1294003
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +FS_SIZE=$((240*1024*1024)) # 240MB
>> +DEBUG=0 # set to 1 to enable debug statements in shell and c-prog
> I think DEBUG could be on by default, and append all debug output to
> $seqres.full
>
>> +FACT=0.7
>> +
>> +# Disk allocation methods
>> +FALLOCATE=1
> This needs _require_xfs_io_command "falloc", so filesystem that doesn't
> support fallocate(2) will _notrun.
>
>> +FTRUNCATE=2
>> +
>> +# Helps to build TEST_VECTORS
>> +SMALL_FILE_SIZE=$((512 * 1024)) # in Bytes
>> +BIG_FILE_SIZE=$((1536 * 1024))  # in Bytes
>> +MIX_FILE_SIZE=$((2048 * 1024))  # (BIG + SMALL small file size)
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_require_test
> $TEST_DIR is not used, this could be skipped.
>
>> +_require_scratch
>> +_require_test_program "t_enospc"
>> +
>> +debug()
>> +{
>> +	if [ $DEBUG -eq 1 ]; then
>> +		echo >&2 "func->${FUNCNAME[1]}: $1"
>> +	fi
>> +}
>> +
>> +# Calculate the number of threads needed to fill the disk space
> Would you please describe the arguments in comments?
>
>> +calc_thread_cnt()
>> +{
>> +	local file_ratio_unit=$1
>> +	local file_ratio=$2
>> +	local disk_saturation=$3
>> +	local tot_avail_size
>> +	local avail_size
>> +	local thread_cnt
>> +
>> +	IFS=',' read -ra fratio <<< $file_ratio
>> +	file_ratio_cnt=${#fratio[@]}
>> +
>> +	tot_avail_size=$(df --block-size=1 $SCRATCH_DEV | awk 'FNR == 2 { print $4 }')
> Use $DF_PROG or _df_device instead of pure 'df', as they deal with long
> device name correctly, which causes the output to be wrapped.
>
> Other 'df' usages should be fixed as well.
>
>> +	avail_size=$(echo $tot_avail_size*$disk_saturation | bc)
> Use $BC_PROG instead of bc.
>
>> +	thread_cnt=$(echo "$file_ratio_cnt*($avail_size/$file_ratio_unit)" | bc)
>> +
>> +	debug "Total available size: $tot_avail_size"
>> +	debug "Available size: $avail_size"
>> +	debug "Thread count: $thread_cnt"
>> +
>> +	echo ${thread_cnt}
>> +}
>> +
>> +run_testcase()
>> +{
>> +	IFS=':' read -ra args <<< $1
>> +	local test_name=${args[0]}
>> +	local file_ratio_unit=${args[1]}
>> +	local file_ratio=${args[2]}
>> +	local disk_saturation=${args[3]}
>> +	local disk_alloc_method=${args[4]}
>> +	local test_iteration_cnt=${args[5]}
> Describing the arguments would be good.
>
>> +	local extra_args=""
>> +	local thread_cnt
>> +
>> +	if [ "$disk_alloc_method" == "$FTRUNCATE" ]; then
>                                         ^^^^^^^^^ should be FALLOCATE ?
> '-f' means use fallocate in t_enospc.
>
>> +		extra_args="$extra_args -f"
>> +	fi
>> +
>> +	# enable the debug statements in c program
>> +	if [ "$DEBUG" -eq 1 ]; then
>> +		extra_args="$extra_args -v"
>> +	fi
>> +
>> +	for i in $(eval echo "{1..$test_iteration_cnt}")
>> +	do
> fstests perfer for loop format as
>
> 	for ...; do
> 		<commands>
> 	done
>
>> +		# Setup the device
>> +		_scratch_mkfs_sized $FS_SIZE >> $seqres.full 2>&1
>> +		_scratch_mount
>> +
>> +		thread_cnt=$(calc_thread_cnt $file_ratio_unit $file_ratio $disk_saturation)
>> +
>> +		debug "====== Test details starts ======"
>> +		debug "Test name: $test_name"
>> +		debug "File ratio unit: $file_ratio_unit"
>> +		debug "File ratio: $file_ratio"
>> +		debug "Disk saturation $disk_saturation"
>> +		debug "Disk alloc method $disk_alloc_method"
>> +		debug "Test iteration count: $test_iteration_cnt"
>> +		debug "Extra arg: $extra_args"
>> +		debug "Thread count: $thread_cnt"
>> +		debug "============ end ==============="
>> +
>> +		# Start the test
>> +		$here/src/t_enospc -t $thread_cnt -s $file_ratio_unit -r $file_ratio -p $SCRATCH_MNT $extra_args
>> +
>> +		status=$(echo $?)
>> +		if [ $status -ne 0 ]; then
>> +			use_per=$(df -h | grep $SCRATCH_MNT | awk '{print substr($5, 1, length($5)-1)}' | bc)
>> +			alloc_per=$(echo "$FACT * 100" | bc)
>                                            ^^^^^ should be $disk_saturation ?
>> +			# We are here since t_nospc failed with an error code.
>                                              ^^^^^^^ t_enospc
>> +			# If the used filesystem space is still < available space - that means
>> +			# the test failed due to FS wrongly reported ENOSPC.
>> +			if [ $(echo "$use_per < $alloc_per" | bc) -ne 0 ]; then
>> +				if [ $status -eq 134 ]; then
>> +					echo "FAIL: Aborted assertion faliure"
>> +				elif [ $status -eq 7 ]; then
>> +					echo "FAIL: ENOSPC BUS faliure"
>> +				fi
> Please comment where 134 and 7 come from, I have to look at t_enospc.c
> to know it returns 7 on SIGBUS.
>
>> +				echo "$test_name failed at iteration count: $i"
>> +				echo "$(df -h $SCRATCH_MNT)"
>> +				echo "Allocated: $alloc_per% Used: $use_per%"
>> +				exit
>> +			fi
>> +		fi
>> +
>> +		# Make space for other tests
>> +		_scratch_unmount
>> +	done
>> +}
>> +
>> +declare -a TEST_VECTORS=(
>> +# test-name:file-ratio-unit:file-ratio:disk-saturation:disk-alloc-method:test-iteration-cnt
>> +"Small-file-test:$SMALL_FILE_SIZE:1:$FACT:$FALLOCATE:3"
>> +"Big-file-test:$BIG_FILE_SIZE:1:$FACT:$FALLOCATE:3"
>> +"Mix-file-test:$MIX_FILE_SIZE:0.75,0.25:$FACT:$FALLOCATE:3"
> $FTRUNCATE is not tested?
>
>> +)
>> +
>> +# real QA test starts here
>> +for i in "${TEST_VECTORS[@]}"; do
>> +	run_testcase $i
>> +done
>> +
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/generic/618.out b/tests/generic/618.out
>> new file mode 100644
>> index 00000000..8940b72f
>> --- /dev/null
>> +++ b/tests/generic/618.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 618
>> +Silence is golden
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 94e860b8..dc668c06 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -620,3 +620,4 @@
>>   615 auto rw
>>   616 auto rw io_uring stress
>>   617 auto rw io_uring stress
>> +618 auto rw stress
> Add ennospc group, and drop stress group.
>
> Thanks,
> Eryu
>
>> -- 
>> 2.28.0

