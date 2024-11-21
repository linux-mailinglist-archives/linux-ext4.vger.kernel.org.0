Return-Path: <linux-ext4+bounces-5341-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021939D5298
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 19:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACF81F22F90
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86871AAE06;
	Thu, 21 Nov 2024 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QtxBpwgL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA55B67F;
	Thu, 21 Nov 2024 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214096; cv=none; b=IE4DhHvE6lSeUD5YSPtHElK9NIr1W7+WhR+BjJdcjjFjG4WCKlSA6VehZ06vxeNQUYqdmDXUdweAWPJZ3+d3ynTI8M243nVJ2hZk5WIeRGsiatupvDmmSOOks+GJCgJ0tvc+rcOExETBCD38IlMmFyHshniDTFN3MN+c+S80hhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214096; c=relaxed/simple;
	bh=RQm9W8hkoYBkp0xRRLqcp2dDmoQIgaizuVrkh2ajFUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzyhUgVj1NqNlvpdD9WTDPVo17IKj4p42v8qw9vRutPCEJUmpMqK32gQoG1GKi19CFtVaBdBU982zHJ+WVoS7gK5gHScONILQxDHZjc93tmWNspOHzxpk2Xj+6Nfc7medI+/YiUcg+NValkUCVfcRRcYmhnkgjgRyZbWjqonYsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QtxBpwgL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALEE2BR008912;
	Thu, 21 Nov 2024 18:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w4o8wf
	fRIsPF5g2fT/U9UVY1FrLPqjaVs5I1tFmM1PU=; b=QtxBpwgLDHxGdfwiyTq/lN
	VdI9YQoQhPUYAQ7ybnO+X08xBHOFz9KjuAUcn418xKjWeCEgxxuIBDSTNuwxhB9P
	9PPH6nr5XVeZjw7v7RPCa8j05eADcPCapSH8tU09mn+FnU5hMV6y4DtgYMFWtDwA
	8KIgQHuMNSw2aR2z1smhvkEU6cB+KcXsJbMdmOjW5/9frtRamKrWxvsd8PPStjMd
	J/uCKLJ8G5ozget1Ee383qPnfYpMwSetFtpzhM4EQnoQr9dOz0ICuOWVlXiciXwx
	Wh5IIqMsBLGBA0Bs3xlMCFGU7hO7reRQniDjpMLcp+YEN9wOUszighRdGgPo3tnQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu23ek9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:34:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ALIGSYt025356;
	Thu, 21 Nov 2024 18:34:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu23ek6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:34:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALHLU2E030931;
	Thu, 21 Nov 2024 18:34:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y6409xtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:34:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ALIYdqu51249550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 18:34:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C89C2004E;
	Thu, 21 Nov 2024 18:34:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFEE82004B;
	Thu, 21 Nov 2024 18:34:37 +0000 (GMT)
Received: from [9.124.219.125] (unknown [9.124.219.125])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Nov 2024 18:34:37 +0000 (GMT)
Message-ID: <99f4d397-61a7-441d-b64d-3e913a0a643a@linux.ibm.com>
Date: Fri, 22 Nov 2024 00:04:37 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] generic: Addition of new tests for extsize hints
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, zlang@kernel.org
References: <cover.1732126365.git.nirjhar@linux.ibm.com>
 <efd35dc3af1cae406d4ea7644eb9d58b68feb405.1732126365.git.nirjhar@linux.ibm.com>
 <20241121172702.GY9425@frogsfrogsfrogs>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <20241121172702.GY9425@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2hfGemy9vdQnUbhc55e7iJtMESKYY6yy
X-Proofpoint-ORIG-GUID: GXOCvKjqnbHHh2OGPdJnObJLsr9j20IW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210139


On 11/21/24 22:57, Darrick J. Wong wrote:
> On Thu, Nov 21, 2024 at 10:39:12AM +0530, Nirjhar Roy wrote:
>> This commit adds new tests that checks the behaviour of xfs/ext4
>> filesystems when extsize hint is set on file with inode size as 0,
>> non-empty files with allocated and delalloc extents and so on.
>> Although currently this test is placed under tests/generic, it
>> only runs on xfs and there is an ongoing patch series[1] to
>> enable extsize hints for ext4 as well.
>>
>> [1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/
>>
>> Reviewed-by Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> Looks ok, though you might want to change generic/366 to a higher number
> because that's now taken.
>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D

Okay. I will update the test sequence number in the next revision.

--NR

>> ---
>>   tests/generic/366     | 175 ++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/366.out |  26 +++++++
>>   2 files changed, 201 insertions(+)
>>   create mode 100755 tests/generic/366
>>   create mode 100644 tests/generic/366.out
>>
>> diff --git a/tests/generic/366 b/tests/generic/366
>> new file mode 100755
>> index 00000000..25d23f42
>> --- /dev/null
>> +++ b/tests/generic/366
>> @@ -0,0 +1,175 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
>> +#
>> +# FS QA Test 366
>> +#
>> +# This test verifies that extent allocation hint setting works correctly on
>> +# files with no extents allocated and non-empty files which are truncated.
>> +# It also checks that the  extent hints setting fails with non-empty file
>> +# i.e, with any file with allocated extents or delayed allocation. We also
>> +# check if the extsize value and the xflag bit actually got reflected after
>> +# setting/re-setting the extsize value.
>> +
>> +. ./common/config
>> +. ./common/filter
>> +. ./common/preamble
>> +
>> +_begin_fstest ioctl quick
>> +
>> +_fixed_by_kernel_commit "2a492ff66673 \
>> +                        xfs: Check for delayed allocations before setting \
>> +			extsize"
>> +
>> +_require_scratch_extsize
>> +
>> +FILE_DATA_SIZE=1M
>> +
>> +get_default_extsize()
>> +{
>> +    if [ -z $1 ] || [ ! -d $1 ]; then
>> +        echo "Missing mount point argument for get_default_extsize"
>> +        exit 1
>> +    fi
>> +    $XFS_IO_PROG -c "extsize" "$1" | sed 's/^\[\([0-9]\+\)\].*/\1/'
>> +}
>> +
>> +filter_extsz()
>> +{
>> +    sed "s/\[$1\]/\[EXTSIZE\]/g"
>> +}
>> +
>> +setup()
>> +{
>> +    _scratch_mkfs >> "$seqres.full"  2>&1
>> +    _scratch_mount >> "$seqres.full" 2>&1
>> +    BLKSZ=`_get_block_size $SCRATCH_MNT`
>> +    DEFAULT_EXTSIZE=`get_default_extsize $SCRATCH_MNT`
>> +    EXTSIZE=$(( BLKSZ*2 ))
>> +    # Make sure the new extsize is not the same as the default
>> +    # extsize so that we can observe it changing
>> +    [[ "$DEFAULT_EXTSIZE" -eq "$EXTSIZE" ]] && EXTSIZE=$(( BLKSZ*4 ))
>> +}
>> +
>> +read_file_extsize()
>> +{
>> +    $XFS_IO_PROG -c "extsize" $1 | _filter_scratch | filter_extsz $2
>> +}
>> +
>> +check_extsz_and_xflag()
>> +{
>> +    local filename=$1
>> +    local extsize=$2
>> +    read_file_extsize $filename $extsize
>> +    _test_fsxattr_xflag $filename "extsize" && echo "e flag set" || \
>> +	    echo "e flag unset"
>> +}
>> +
>> +check_extsz_xflag_across_remount()
>> +{
>> +    local filename=$1
>> +    local extsize=$2
>> +    _scratch_cycle_mount
>> +    check_extsz_and_xflag $filename $extsize
>> +}
>> +
>> +# Extsize flag should be cleared when extsize is reset, so this function
>> +# checks that this behavior is followed.
>> +reset_extsz_and_recheck_extsz_xflag()
>> +{
>> +    local filename=$1
>> +    echo "Re-setting extsize hint to 0"
>> +    $XFS_IO_PROG -c "extsize 0" $filename
>> +    check_extsz_xflag_across_remount $filename "0"
>> +}
>> +
>> +check_extsz_xflag_before_and_after_reset()
>> +{
>> +    local filename=$1
>> +    local extsize=$2
>> +    check_extsz_xflag_across_remount $filename $extsize
>> +    reset_extsz_and_recheck_extsz_xflag $filename
>> +}
>> +
>> +test_empty_file()
>> +{
>> +    echo "TEST: Set extsize on empty file"
>> +    local filename=$1
>> +    $XFS_IO_PROG \
>> +        -c "open -f $filename" \
>> +        -c "extsize $EXTSIZE" \
>> +
>> +    check_extsz_xflag_before_and_after_reset $filename $EXTSIZE
>> +    echo
>> +}
>> +
>> +test_data_delayed()
>> +{
>> +    echo "TEST: Set extsize on non-empty file with delayed allocation"
>> +    local filename=$1
>> +    $XFS_IO_PROG \
>> +        -c "open -f $filename" \
>> +        -c "pwrite -q  0 $FILE_DATA_SIZE" \
>> +        -c "extsize $EXTSIZE" | _filter_scratch
>> +
>> +    echo "test for default extsize setting if any"
>> +    read_file_extsize $filename $DEFAULT_EXTSIZE
>> +    echo
>> +}
>> +
>> +test_data_allocated()
>> +{
>> +    echo "TEST: Set extsize on non-empty file with allocated extents"
>> +    local filename=$1
>> +    $XFS_IO_PROG \
>> +        -c "open -f $filename" \
>> +        -c "pwrite -qW  0 $FILE_DATA_SIZE" \
>> +        -c "extsize $EXTSIZE" | _filter_scratch
>> +
>> +    echo "test for default extsize setting if any"
>> +    read_file_extsize $filename $DEFAULT_EXTSIZE
>> +    echo
>> +}
>> +
>> +test_truncate_allocated()
>> +{
>> +    echo "TEST: Set extsize after truncating a file with allocated extents"
>> +    local filename=$1
>> +    $XFS_IO_PROG \
>> +        -c "open -f $filename" \
>> +        -c "pwrite -qW  0 $FILE_DATA_SIZE" \
>> +        -c "truncate 0" \
>> +        -c "extsize $EXTSIZE" \
>> +
>> +    check_extsz_xflag_across_remount $filename $EXTSIZE
>> +    echo
>> +}
>> +
>> +test_truncate_delayed()
>> +{
>> +    echo "TEST: Set extsize after truncating a file with delayed allocation"
>> +    local filename=$1
>> +    $XFS_IO_PROG \
>> +        -c "open -f $filename" \
>> +        -c "pwrite -q  0 $FILE_DATA_SIZE" \
>> +        -c "truncate 0" \
>> +        -c "extsize $EXTSIZE" \
>> +
>> +    check_extsz_xflag_across_remount $filename $EXTSIZE
>> +    echo
>> +}
>> +
>> +setup
>> +echo -e "EXTSIZE = $EXTSIZE DEFAULT_EXTSIZE = $DEFAULT_EXTSIZE \
>> +	BLOCKSIZE = $BLKSZ\n" >> "$seqres.full"
>> +
>> +NEW_FILE_NAME_PREFIX=$SCRATCH_MNT/new-file-
>> +
>> +test_empty_file "$NEW_FILE_NAME_PREFIX"00
>> +test_data_delayed "$NEW_FILE_NAME_PREFIX"01
>> +test_data_allocated "$NEW_FILE_NAME_PREFIX"02
>> +test_truncate_allocated "$NEW_FILE_NAME_PREFIX"03
>> +test_truncate_delayed "$NEW_FILE_NAME_PREFIX"04
>> +
>> +status=0
>> +exit
>> diff --git a/tests/generic/366.out b/tests/generic/366.out
>> new file mode 100644
>> index 00000000..cdd2f5fa
>> --- /dev/null
>> +++ b/tests/generic/366.out
>> @@ -0,0 +1,26 @@
>> +QA output created by 366
>> +TEST: Set extsize on empty file
>> +[EXTSIZE] SCRATCH_MNT/new-file-00
>> +e flag set
>> +Re-setting extsize hint to 0
>> +[EXTSIZE] SCRATCH_MNT/new-file-00
>> +e flag unset
>> +
>> +TEST: Set extsize on non-empty file with delayed allocation
>> +xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-01: Invalid argument
>> +test for default extsize setting if any
>> +[EXTSIZE] SCRATCH_MNT/new-file-01
>> +
>> +TEST: Set extsize on non-empty file with allocated extents
>> +xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-02: Invalid argument
>> +test for default extsize setting if any
>> +[EXTSIZE] SCRATCH_MNT/new-file-02
>> +
>> +TEST: Set extsize after truncating a file with allocated extents
>> +[EXTSIZE] SCRATCH_MNT/new-file-03
>> +e flag set
>> +
>> +TEST: Set extsize after truncating a file with delayed allocation
>> +[EXTSIZE] SCRATCH_MNT/new-file-04
>> +e flag set
>> +
>> -- 
>> 2.43.5
>>
>>
-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


