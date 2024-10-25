Return-Path: <linux-ext4+bounces-4757-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E1C9AF9A4
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 08:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE21F23253
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 06:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFB3193089;
	Fri, 25 Oct 2024 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ie+RYopk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEA18F2F2;
	Fri, 25 Oct 2024 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836757; cv=none; b=APvpwrcf4BbUq8d+nqdrRGdK6uWfaIQ4ZvAQzT6Hj/yxbjTAi2C4GQqTGNIjM+xBIISBWMszrO2oToNpabvl0/iGNG9TyJc5YOx5Ztm/jzI2PcQqNaJUtQ2o7RBkz9nYdB9BufDDT0XpjKMtmlcHuOVMtXth+5xg5cTxEB0zxD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836757; c=relaxed/simple;
	bh=2ABQX0qhFkVHAupyHP/8k5mkJbFG1+BAd3WZREZORB0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fYqjLC/cZOaW18AUXFbkQnf3N9JEdfvFS5XMk/yOQZCl+atcJw8ZuGmKUUA4GWs3pG9XPzSgGIfl2AStVLw0+IyaNh0/fB0lQQ4wRHjC628nxsNfIGkDz5cU2FS3nYnwhfSuTisHRLeYzWI8h4Z4Km1pc9GNduAbT697+hB+xcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ie+RYopk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P1uxGm032476;
	Fri, 25 Oct 2024 06:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NGXUL9
	0EGeVDgCUr9QpIcuBZJFFZAfCltSBMpG1F3LU=; b=ie+RYopkKd01TlXeBGRaSF
	GD7uHpto6Fsv42fVdtWU0iA45jU8KZUzYf3jKwhw6VSFy2eUSWkzfWup956X1f5s
	PmO19fVwzNwQ6F8aybUXS3SqtoKsU7V8UWB4ARIsj7bgAUKa1tnSG5IF4F+XThHG
	HfGqhACoeCUT6YU1GLTVSIpkQ+GAioaFB7KREAGdEdKb1qxSXH1DAA8vJzBnoxMm
	wgrC2+P+fib2Wm3eHk7zaEVncT0ZdGaMKDkGQU2ThFiGQBn7pQjw4sI9i8zSeKfO
	Fwje+D25ZJY7T+sllw3xCaEkJsYqU2+NEOMVH9D6J1V4qk8HfV0zlgzWOOt3gc2g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g246rtmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:12:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49P6CUKP018370;
	Fri, 25 Oct 2024 06:12:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g246rtmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:12:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49P28iq9014771;
	Fri, 25 Oct 2024 06:12:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfv8gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:12:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49P6CRWS20513236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 06:12:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79FEF2004B;
	Fri, 25 Oct 2024 06:12:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0FEA20040;
	Fri, 25 Oct 2024 06:12:25 +0000 (GMT)
Received: from [9.39.27.196] (unknown [9.39.27.196])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Oct 2024 06:12:25 +0000 (GMT)
Message-ID: <3376b6e7-9870-46dc-a22d-9879ec4d9c09@linux.ibm.com>
Date: Fri, 25 Oct 2024 11:42:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] generic: Addition of new tests for extsize hints
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, zlang@kernel.org
References: <cover.1729624806.git.nirjhar@linux.ibm.com>
 <5cac327a9ee44c42035d9702b3a146aebc95e28c.1729624806.git.nirjhar@linux.ibm.com>
 <20241024181444.GE2386201@frogsfrogsfrogs>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <20241024181444.GE2386201@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -Jspypgrj0Uy4so0fHlv8oOqwjANT8D0
X-Proofpoint-GUID: nAB0hIjDhJBORrQiMn7pHsyQw1UKDcE3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410250044


On 10/24/24 23:44, Darrick J. Wong wrote:
> On Wed, Oct 23, 2024 at 12:56:20AM +0530, Nirjhar Roy wrote:
>> This commit adds new tests that checks the behaviour of xfs/ext4
>> filesystems when extsize hint is set on file with inode size as 0, non-empty
>> files with allocated and delalloc extents and so on.
>> Although currently this test is placed under tests/generic, it
>> only runs on xfs and there is an ongoing patch series[1] to enable
>> extsize hints for ext4 as well.
>>
>> [1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/
>>
>> Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
>> ---
>>   tests/generic/365     | 156 ++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/365.out |  26 +++++++
>>   2 files changed, 182 insertions(+)
>>   create mode 100755 tests/generic/365
>>   create mode 100644 tests/generic/365.out
>>
>> diff --git a/tests/generic/365 b/tests/generic/365
>> new file mode 100755
>> index 00000000..85a7ce9a
>> --- /dev/null
>> +++ b/tests/generic/365
>> @@ -0,0 +1,156 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
>> +#
>> +# FS QA Test 365
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
>> +. ./common/xfs
>> +
>> +_begin_fstest ioctl quick
>> +
>> +_supported_fs xfs
>> +
>> +_fixed_by_kernel_commit XXXXXXXXXXXX \
>> +    "xfs: Check for delayed allocations before setting extsize",
>> +
>> +_require_scratch
>> +
>> +FILE_DATA_SIZE=1M
> Do these tests work correctly with fsblock size of 64k?  Just curious
> since Pankaj just sent a series doing 1M -> 4M bumps to fix quota
> issues.
Yes I have tested this with 2k, 4k, 16k, 64k on ppc64le and x86_64
>> +filter_extsz()
>> +{
>> +    sed "s/$EXTSIZE/EXTSIZE/g"
>> +}
>> +
>> +setup()
>> +{
>> +    _scratch_mkfs >> "$seqres.full"  2>&1
>> +    _scratch_mount >> "$seqres.full" 2>&1
>> +    BLKSZ=`_get_block_size $SCRATCH_MNT`
>> +    EXTSIZE=$(( BLKSZ*2 ))
> Might want to check that there isn't an extsize/cowextsize set on the
> root directory due to mkfs options.
Noted.
>
>> +}
>> +
>> +read_file_extsize()
>> +{
>> +    $XFS_IO_PROG -c "extsize" $1 | _filter_scratch | filter_extsz
>> +}
>> +
>> +check_extsz_and_xflag()
>> +{
>> +    local filename=$1
>> +    read_file_extsize $filename
>> +    _test_xfs_xflags_field $filename "e" && echo "e flag set" || echo "e flag unset"
>> +}
>> +
>> +check_extsz_xflag_across_remount()
>> +{
>> +    local filename=$1
>> +    _scratch_cycle_mount
>> +    check_extsz_and_xflag $filename
>> +}
>> +
>> +# Extsize flag should be cleared when extsize is reset, so this function
>> +# checks that this behavior is followed.
>> +reset_extsz_and_recheck_extsz_xflag()
>> +{
>> +    local filename=$1
>> +    echo "Re-setting extsize hint to 0"
>> +    $XFS_IO_PROG -c "extsize 0" $filename
>> +    check_extsz_xflag_across_remount $filename
>> +}
>> +
>> +check_extsz_xflag_before_and_after_reset()
>> +{
>> +    local filename=$1
>> +    check_extsz_xflag_across_remount $filename
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
>> +    check_extsz_xflag_before_and_after_reset $filename
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
>> +    check_extsz_xflag_across_remount $filename
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
>> +    check_extsz_xflag_across_remount $filename
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
>> +    check_extsz_xflag_across_remount $filename
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
>> +    check_extsz_xflag_across_remount $filename
>> +    echo
>> +}
> Does this work for filesystems that don't have delalloc?  Like fsdax
> filesystems?
>
> --D
I haven't tested this on fsdax filesystem. Only tested on xfs with 
various bs.
>
>> +setup
>> +echo -e "EXTSIZE = $EXTSIZE BLOCKSIZE = $BLKSZ\n" >> "$seqres.full"
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
>> diff --git a/tests/generic/365.out b/tests/generic/365.out
>> new file mode 100644
>> index 00000000..38cd0885
>> --- /dev/null
>> +++ b/tests/generic/365.out
>> @@ -0,0 +1,26 @@
>> +QA output created by 365
>> +TEST: Set extsize on empty file
>> +[EXTSIZE] SCRATCH_MNT/new-file-00
>> +e flag set
>> +Re-setting extsize hint to 0
>> +[0] SCRATCH_MNT/new-file-00
>> +e flag unset
>> +
>> +TEST: Set extsize on non-empty file with delayed allocation
>> +xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-01: Invalid argument
>> +[0] SCRATCH_MNT/new-file-01
>> +e flag unset
>> +
>> +TEST: Set extsize on non-empty file with allocated extents
>> +xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-02: Invalid argument
>> +[0] SCRATCH_MNT/new-file-02
>> +e flag unset
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


