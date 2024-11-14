Return-Path: <linux-ext4+bounces-5151-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEBF9C8667
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 10:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB062834EE
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9F1F6669;
	Thu, 14 Nov 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dFCxLHic"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DB1D86CB;
	Thu, 14 Nov 2024 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577570; cv=none; b=r99CrTsJv8vTqqh4oL978tC87EY2vOOPFTLv7HMcA4oMjJaozx1cR5AqsxeJZ93al3kJW0hKcxjM2kTktu9mS08PGAfpwcmmXMadCHifj/SRmhnwKrTLU6tgSKtEYnFcOP2tm+4YTsU321r0BrhbWPizqiNGGG3kNdIgTtPEld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577570; c=relaxed/simple;
	bh=O1M1VzK7tHnd1/T53YKedTKNqiT4A0YLr4Shm/WLSn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TGxNGrmQpqdV3nfLB57Vkz9vz/HXS4hyrpb1AM0ZIPSA4ddmcei8McxadqlpSf4MTsuxe8dHvHuUg80qSy7WMiKPXmT7IVHQQKHbVCQhvex4kXLqFaBbNE90khEw4OTSEEUAZ3ZSarG6peMSPh9QUeY5ey6AD2QLPRrXGOkQ/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dFCxLHic; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE8A5qa021603;
	Thu, 14 Nov 2024 09:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1S9Fb+
	/uvEo1brGT+3jEZ98xvLIRtgGEDvpVxU6YSdA=; b=dFCxLHicJERiTzIewVwKIY
	69XSww/WyYUPW8LtD8l6y/xV9NbaQIO4deZqedRzHbwcqhJydeH9poGcMnnYcRS0
	feZrjbXYtgmP/RjKb1MqKTsGPXjkM8mgc5A5qnRNfFgq60LlxhrKYVGPoKFmd3DD
	qowl5ohdLv3RcxjSDzcJkoAeie6EnsdpzD8ljKDflIVU5AazPxpCLthSyGZBaw2q
	4YF/9JZXOfhhmFR9/bQs3wFZQj+0iNkAoNMkuQnEwk/soZm3exIS8oscpWxh8PDh
	cMx3CdwLQr9AnpFCd6QxpWGeFaSPyKGNqpMOtW3fnnriG08pt3SOFH+Y5vMfakFg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wdf00khu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 09:46:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AE9k3tW027423;
	Thu, 14 Nov 2024 09:46:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wdf00khq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 09:46:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE8OEiJ008404;
	Thu, 14 Nov 2024 09:46:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjf06dju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 09:46:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AE9k06V47841710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 09:46:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CEB52004E;
	Thu, 14 Nov 2024 09:46:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BDFA20040;
	Thu, 14 Nov 2024 09:45:58 +0000 (GMT)
Received: from [9.124.214.206] (unknown [9.124.214.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Nov 2024 09:45:58 +0000 (GMT)
Message-ID: <1ec7b087-de12-4b43-b689-87b2e02ffd77@linux.ibm.com>
Date: Thu, 14 Nov 2024 15:15:58 +0530
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
X-Proofpoint-GUID: epyYv4Q2zINndeCkaJxUQRqV-bwLRzVY
X-Proofpoint-ORIG-GUID: 1-VTWkH_ANoLGePFh4wjERD1SODpr8Gn
Content-Transfer-Encoding: 8bit
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411140073


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
>
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

We have made some changes in the tests in v2 so that the test behaves as 
expected with preset extsize/extszinherit mkfs options on the root. Also 
tested with  mkfs.xfs from [1]. I will send PATCH v2 shortly.

[1]. 
https://lore.kernel.org/all/20230929095342.2976587-7-john.g.garry@oracle.com/

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


