Return-Path: <linux-ext4+bounces-5234-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060D9D0B94
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 007F5B22F06
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DAA18C939;
	Mon, 18 Nov 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MfCsfuod"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60417C224;
	Mon, 18 Nov 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921897; cv=none; b=OBFpsvYDIbXTgfomewyjkPxOycBt+JmAgSXf+cxAHWorV2jiMpWheavxVx7J5lb5ZSoJt53P2WJ7s3yq2OHyx8Vf9rB7vFrSNrbT8UGMbV8jExekhdb9GimU+e3CXWpRxr3JWgM4oiSi7fu58zceeIL6NCjM3CZdGzBXS0EMqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921897; c=relaxed/simple;
	bh=TN7w7rgpEGIlswoBDm0z+DlDBw4/s0w1y8v7cGXqdoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFJiPH2mDkzJPqJShU31+itDTDcoQ6JzqmWncRL0CSpGA+nsKaB6UA8LGDomcoVctKPlh2pGBKw+fCw9txFtlzOFD7lh2mVz0D8Je1PziLf5zj8UbqwC8p8wdg3LhxUx74Y1a50b64exVWrMqnk2ROKDmzMq0dzRXKw9JdRRNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MfCsfuod; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AHLtBs8023253;
	Mon, 18 Nov 2024 09:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xBuCcl
	6/Q8QB148jctoqV1U37HHskUOiAvJmwtSsHiE=; b=MfCsfuodmZFNXX+IRSqS06
	AIIZdff5ydmVgHzQRP5o+Id9n8CWgt+qQUnCVBj94AwrJGqSMCw+sLeZpkyJ+MWO
	6w4Y5Y+HARNoQvnhVzx6wbnPDZkAGDnfiUFFdM54LaPihYFUZSx4E+ZFZ6PqJ9k0
	DZjY1ji75BlDhJQMna+97Ss8MT4zlqlzreGdDPaM3am4TAo1izeu6UFOxibwUMZx
	zaFgCwOUvQuDYFzhcJmRaRz7z35ovZ0dN90ufcrEZqqAKd4wXU/MhPFsaOVUWfaa
	i0DtCzLfFHRexjhAfyNpSJR5VQ0RuhLwnfPcgfOrxFV031bRJLe3Y+OjbN1UWjtA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu1eqap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 09:24:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AI9MIE3006787;
	Mon, 18 Nov 2024 09:24:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu1eqam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 09:24:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8EOYO000580;
	Mon, 18 Nov 2024 09:24:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77kj5x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 09:24:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AI9OhNp50987340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 09:24:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0C8520043;
	Mon, 18 Nov 2024 09:24:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8957E20040;
	Mon, 18 Nov 2024 09:24:42 +0000 (GMT)
Received: from [9.39.30.224] (unknown [9.39.30.224])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Nov 2024 09:24:42 +0000 (GMT)
Message-ID: <8e43c570-b3ad-42a3-8270-4a41ab171b8b@linux.ibm.com>
Date: Mon, 18 Nov 2024 14:54:41 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] common/rc,xfs/207: Adding a common helper function
 to check xflag bits on a given file
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, zlang@kernel.org
References: <cover.1731597226.git.nirjhar@linux.ibm.com>
 <9a955f34cab443d3ed0fc07c17886d5e8a11ad80.1731597226.git.nirjhar@linux.ibm.com>
 <20241115164548.GE9425@frogsfrogsfrogs>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <20241115164548.GE9425@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SdAu1hCfUylqNfLNKowS6iEsCliVOV2C
X-Proofpoint-ORIG-GUID: N3MP-h76YaeNFWoAlYfdMS6CRMQCWA09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=914 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180074


On 11/15/24 22:15, Darrick J. Wong wrote:
> On Fri, Nov 15, 2024 at 09:45:58AM +0530, Nirjhar Roy wrote:
>> This patch defines a common helper function to test whether any of
>> fsxattr xflags field is set or not. We will use this helper in the next
>> patch for checking extsize (e) flag.
>>
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
>> ---
>>   common/rc     |  7 +++++++
>>   tests/xfs/207 | 13 ++-----------
>>   2 files changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 2af26f23..fc18fc94 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -41,6 +41,13 @@ _md5_checksum()
>>   	md5sum $1 | cut -d ' ' -f1
>>   }
>>   
>> +# Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
>> +# e.g, fsxattr.xflags =  0x80000800 [----------e-----X]
>> +_test_fsx_xflags_field()
> How about we call this "_test_fsxattr_xflag" instead?
>
> fsx is already something else in fstests.
Noted.
>
>> +{
>> +    grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
>> +}
> Not sure why this lost the xfs_io | grep -q structure.  The return value
> of the whole expression will always be the return value of the last
> command in the pipeline.
>
> (Correct?  I hate bash...)
>
> --D
>
>> +
>>   # Write a byte into a range of a file
>>   _pwrite_byte() {
>>   	local pattern="$1"
>> diff --git a/tests/xfs/207 b/tests/xfs/207
>> index bbe21307..4f6826f3 100755
>> --- a/tests/xfs/207
>> +++ b/tests/xfs/207
>> @@ -21,15 +21,6 @@ _require_cp_reflink
>>   _require_xfs_io_command "fiemap"
>>   _require_xfs_io_command "cowextsize"
>>   
>> -# Takes the fsxattr.xflags line,
>> -# i.e. fsxattr.xflags = 0x0 [--------------C-]
>> -# and tests whether a flag character is set
>> -test_xflag()
>> -{
>> -    local flg=$1
>> -    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
>> -}
>> -
>>   echo "Format and mount"
>>   _scratch_mkfs > $seqres.full 2>&1
>>   _scratch_mount >> $seqres.full 2>&1
>> @@ -65,14 +56,14 @@ echo "Set cowextsize and check flag"
>>   $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>>   _scratch_cycle_mount
>>   
>> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>> +_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>>   $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>>   
>>   echo "Unset cowextsize and check flag"
>>   $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>>   _scratch_cycle_mount
>>   
>> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>> +_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>>   $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>>   
>>   status=0
>> -- 
>> 2.43.5
>>
>>
-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


