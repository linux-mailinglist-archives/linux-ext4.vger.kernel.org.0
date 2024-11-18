Return-Path: <linux-ext4+bounces-5233-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEF59D0B92
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 10:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15BF7B22C2F
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9642218FDD8;
	Mon, 18 Nov 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n1Ap6WcG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964218B46E;
	Mon, 18 Nov 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921859; cv=none; b=GsjyRkbLhIfkskU2Bxyvq++YBI0inNziCiwNxvA/N35txUOOXELlU10OWp0EjTBQJFzLwzi28o+t0wiEqEH4aKhLmTb2jB3gi7FeN0/j15fYdrYlk8viykvH707aeOUlW8MpHYvEsgIfBuhb26hPy78Ct7kvH+uJle22ie+1Pkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921859; c=relaxed/simple;
	bh=MlCjVl/TxyUCxXcUJMXLoMIyW0e/PGPS6pBVfJ/K5h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpOX70lnFFEvT24lkWh2T+KJo4kw3o/bCCQ46NbG3WevdQlTTkW43GLxYlzq3XEmpeiAg7w7tHh6n1urgZ7DCUi9VqvI0XySGihq/LMt08U5VuvUafqbymemVq6orm6pxkPrIlh2bxfMUh/BH2xb4tnhltDRoRMBSfH32tVjrxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n1Ap6WcG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI3wJdF015288;
	Mon, 18 Nov 2024 09:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0OeCch
	iJjocfkoQo+wbRUatCIuAbJ5zfg+6hljZjoC0=; b=n1Ap6WcGrOKc9zWfI0O8o/
	3AhirjyOew0qvShqcVQy3rzaVTaWbLO8yaE0RC5vI0bQ62xng9k3BqyzN7tyBkzF
	WpOQ+HzioAQsqB1hOtoJ91BjNaw1x2avB2emzLqXjuTqJwm6aoh0rrLvD9csPuxd
	5VI499r+O22bL3imChHuXhBh7IMttc0NWqEZxYzZQHHJr23gS9A38aJA8k9Vc7zG
	STGQOKfjZen/qwEXuLxdsuYuw5x8jlRgYe1PFZCIat9w5iAtEy3qNAYuN2TDfRaG
	GCiiYWIhf/MRnz+lWyItacpkN8X/RM77CaAc9R2aodYMHm5OHI5eNmqDZzaRutVA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk20r9mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 09:24:12 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AI9N7N2017623;
	Mon, 18 Nov 2024 09:24:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk20r9mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 09:24:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI2TlEf021833;
	Mon, 18 Nov 2024 09:24:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y6qmtb9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 09:24:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AI9O9ue53084464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 09:24:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 196E320040;
	Mon, 18 Nov 2024 09:24:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D092420043;
	Mon, 18 Nov 2024 09:24:07 +0000 (GMT)
Received: from [9.39.30.224] (unknown [9.39.30.224])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Nov 2024 09:24:07 +0000 (GMT)
Message-ID: <c6ca5784-de55-43ec-ba6a-3afbf6b2aa53@linux.ibm.com>
Date: Mon, 18 Nov 2024 14:54:06 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] generic: Addition of new tests for extsize hints
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, zlang@kernel.org
References: <cover.1731597226.git.nirjhar@linux.ibm.com>
 <373a7e378ba4a76067dc7da5835ac722248144f9.1731597226.git.nirjhar@linux.ibm.com>
 <20241115165054.GF9425@frogsfrogsfrogs>
Content-Language: en-US
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <20241115165054.GF9425@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GYMJirTzDiqI_FCWqGZ8GYqG3mFXhawM
X-Proofpoint-GUID: 5hI4ly7H6u_L1YBnxwhWVb-xj0H0VoCf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180074


On 11/15/24 22:20, Darrick J. Wong wrote:
> On Fri, Nov 15, 2024 at 09:45:59AM +0530, Nirjhar Roy wrote:
>> This commit adds new tests that checks the behaviour of xfs/ext4
>> filesystems when extsize hint is set on file with inode size as 0, non-empty
>> files with allocated and delalloc extents and so on.
>> Although currently this test is placed under tests/generic, it
>> only runs on xfs and there is an ongoing patch series[1] to enable
>> extsize hints for ext4 as well.
>>
>> [1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/
>>
>> Reviewed-by Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
>> ---
>>   tests/generic/366     | 172 ++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/366.out |  26 +++++++
>>   2 files changed, 198 insertions(+)
>>   create mode 100755 tests/generic/366
>>   create mode 100644 tests/generic/366.out
>>
>> diff --git a/tests/generic/366 b/tests/generic/366
>> new file mode 100755
>> index 00000000..7ff4e8e2
>> --- /dev/null
>> +++ b/tests/generic/366
>> @@ -0,0 +1,172 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
>> +#
>> +# FS QA Test 366
>> +#
>> +# This test verifies that extent allocation hint setting works correctly on files with
>> +# no extents allocated and non-empty files which are truncated. It also checks that the
>> +# extent hints setting fails with non-empty file i.e, with any file with allocated
>> +# extents or delayed allocation. We also check if the extsize value and the
>> +# xflag bit actually got reflected after setting/re-setting the extsize value.
>> +
>> +. ./common/config
>> +. ./common/filter
>> +. ./common/preamble
>> +
>> +_begin_fstest ioctl quick
>> +
>> +_supported_fs xfs
> Aren't you all adding extsize support for ext4?  I would've expected
> some kind of _require_extsize helper to _notrun on filesystems that
> don't support it.
Yes, this is a good idea. I will try to have something like this. Thank 
you.
>
>> +
>> +_fixed_by_kernel_commit "2a492ff66673 \
>> +                        xfs: Check for delayed allocations before setting extsize"
>> +
>> +_require_scratch
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
> Doesn't this need to check for extszinherit on $SCRATCH_MNT?

The above function tries to get the default extsize set on a directory 
($SCRATCH_MNT for this test). Even if there is an extszinherit set or 
extsize (with -d extsize=<size> [1]), the function will get the extsize 
(in bytes) which is what the function intends to do. In case there is 
no extszinherit or extsize set on the directory, it will return 0.  Does 
this answer your question, or are you asking something else?

[1] 
https://lore.kernel.org/all/20230929095342.2976587-7-john.g.garry@oracle.com/

>
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
>> +    # Making sure the new extsize is not the same as the default extsize
> Er... why?
The test behaves a bit differently when the new and old extsizes are 
equal and the intention of this test is to check if the kernel behaves 
as expected
when we are trying to *change* the extsize. Two of the sub-tests 
(test_data_delayed(), test_data_allocated()) test whether extsize 
settting fails if there are allocated extents or delayed allocation. The 
failure doesn't take place when the new and the default extsizes are 
equal, i.e, when the extsize is not changing. If the default and the new 
extsize are equal, the xfs_io command succeeds, which is not what we 
want the test to do. So we are always ensuring that the new extsize is 
not equal to the default extsize. Does this answer your question?
>
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
>> +    _test_fsx_xflags_field $filename "e" && echo "e flag set" || echo "e flag unset"
> I almost asked in the last patch if the _test_fsxattr_flag function
> should be running xfs_io -c 'stat -v' so that you could grep for whole
> words instead of individual letters.
>
> "extsize flag unset"
>
> "cowextsize flag set"
>
> is a bit easier to figure out what's going wrong.
>
> The rest of the logic looks reasonable to me.
>
> --D

Yes, that makes sense. So do you mean something like the following?

# Check whether a fsxattr xflags name ($2) field is set on a given file 
($1).
# e.g, fsxattr.xflags = 0x80000800 [extsize, has-xattr]
_test_fsxattr_flag_field()
{
     grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
}

and the call sites can be like

_test_fsx_xflags_field $filename "extsize" && echo "e flag set" || echo 
"e flag unset"


THE OTHER OPTION IS:

We can embed the "<flag name> flag set/unset" message, inside the 
_test_fsx_xflags_field() function. Something like

_test_fsxattr_flag_field()
{
     grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" 
"$1") && echo "$2 flag set" || echo "$2 flag unset"
}

Which one do you prefer?

>
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
>> +echo -e "EXTSIZE = $EXTSIZE DEFAULT_EXTSIZE = $DEFAULT_EXTSIZE BLOCKSIZE = $BLKSZ\n" >> "$seqres.full"
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


