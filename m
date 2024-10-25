Return-Path: <linux-ext4+bounces-4759-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9EB9AF9BA
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 08:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB524283685
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 06:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9613199935;
	Fri, 25 Oct 2024 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WmOJFIDe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30018C346;
	Fri, 25 Oct 2024 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836976; cv=none; b=fAXQGrpfQyDbrUvPlLeJ6SLV1/rmwzniQv6ePcq/H59wQ4zSNJUGbdQbZBXVu9slcrXUp491sZ+7seMvtoVgAzWl7WSCSAh045lXEDkaLRrIz5mO3C0/5oi6JWrm7j90Hqa7eAZzLhZAPd5Fv/LveJVfnpbBQbFf3/J50Hkez7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836976; c=relaxed/simple;
	bh=ETHoSgyPCcEBFwOHPXJ4L5uyLT5H2sSlXC4SjGGcl6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+VJ+OrBQ+uNBi86v+iBbJkxcaE8jA0LELtn2h6+Ww0hdpPKmOJYTZPaaAGLE9e+tCBpqFl1RvcHZAKaXXUqlCuVE4SLwAYNCnMXb8nWpDKs5QDHDOXLWtiO3JbbLpsFXyWLA7tRGqG50MQpDHxpZJL2LNhLE+RF6JryaUqEURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WmOJFIDe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P1upCP032361;
	Fri, 25 Oct 2024 06:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jzn4g4
	F973F1H+jvb+vUYu9rpGinImfpwiAncVIDc3g=; b=WmOJFIDescH51ACp8R3I4d
	9AiB/lbeKFeadCEEvuYhuWcK4Pia2Dx9FGWdW111Ju9j4akTddcDdph38aLw99H6
	CnwNmNus3UcxpHFJ8M6qWyWkJ0rW2Ss8q9l9tJPx7nmDftj39sozmZ6T2pfloaBz
	Mt/+VWYvxmYRlGIOIuUrWmKj+djLB6TqoVuX4c7D8yirw4V+A1mfbft/Oc3J1Ws5
	v6+2xHSRf9/y0//epzpOP1lEp6GCeel2JfEqlWLUNdDEM23MQkeY9R8a+9O14LZ9
	wS60wwoEkJ4OgOAWds51HiXKJ49I7AdClphX4uMxGUQj7hWQdo/78mmbgluIvZaQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g246rtyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:16:09 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49P6G99M024736;
	Fri, 25 Oct 2024 06:16:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g246rtyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:16:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49P2FN9H012614;
	Fri, 25 Oct 2024 06:16:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhfmaq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:16:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49P6G6cI31654430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 06:16:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A30C520043;
	Fri, 25 Oct 2024 06:16:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA31D20040;
	Fri, 25 Oct 2024 06:16:04 +0000 (GMT)
Received: from [9.39.27.196] (unknown [9.39.27.196])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Oct 2024 06:16:04 +0000 (GMT)
Message-ID: <d8e2db85-4a39-4628-847d-08d37cbbb6b4@linux.ibm.com>
Date: Fri, 25 Oct 2024 11:46:03 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] common/xfs,xfs/207: Adding a common helper function
 to check xflag bits on a given file
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, zlang@kernel.org
References: <cover.1729624806.git.nirjhar@linux.ibm.com>
 <6ba7f682af7e0bc99a8baeccc0d7aa4e5062a433.1729624806.git.nirjhar@linux.ibm.com>
 <20241025025651.okneano7d324nl4e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241025040703.GQ2578692@frogsfrogsfrogs>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <20241025040703.GQ2578692@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6oWEhE72vbezeAEu0SAL8ZOyQ70HKaL6
X-Proofpoint-GUID: e4ssvMgfv5_GS2stMalfHZjtglKExj-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410250044


On 10/25/24 09:37, Darrick J. Wong wrote:
> On Fri, Oct 25, 2024 at 10:56:51AM +0800, Zorro Lang wrote:
>> On Wed, Oct 23, 2024 at 12:56:19AM +0530, Nirjhar Roy wrote:
>>> This patch defines a common helper function to test whether any of
>>> fsxattr xflags field is set or not. We will use this helper in the next
>>> patch for checking extsize (e) flag.
>>>
>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
>>> ---
>>>   common/xfs    |  9 +++++++++
>>>   tests/xfs/207 | 14 +++-----------
>>>   2 files changed, 12 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/common/xfs b/common/xfs
>>> index 62e3100e..7340ccbf 100644
>>> --- a/common/xfs
>>> +++ b/common/xfs
>>> @@ -13,6 +13,15 @@ __generate_xfs_report_vars() {
>>>   	REPORT_ENV_LIST_OPT+=("TEST_XFS_REPAIR_REBUILD" "TEST_XFS_SCRUB_REBUILD")
>>>   }
>>>   
>>> +# Check whether a fsxattr xflags character field is set on a given file.
>> Better to explain the arguments, e.g.
>>
>> # Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
>>
>>> +# e.g. fsxattr.xflags = 0x0 [--------------C-]
>>> +# Returns 0 if passed flag character is set, otherwise returns 1
>>> +_test_xfs_xflags_field()
>>> +{
>>> +    $XFS_IO_PROG -c "stat" "$1" | grep "fsxattr.xflags" | grep -q "\[.*$2.*\]" \
>>> +        && return 0 || return 1
>> That's too complex. Those "return" aren't needed as Darrick metioned. About
>> that two "grep", how about combine them, e.g.
>>
>> _test_xfs_xflags_field()
>> {
>> 	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
>> }
>>
>>
>>
>>> +}
>>> +
>>>   _setup_large_xfs_fs()
>>>   {
>>>   	fs_size=$1
>>> diff --git a/tests/xfs/207 b/tests/xfs/207
>>> index bbe21307..adb925df 100755
>>> --- a/tests/xfs/207
>>> +++ b/tests/xfs/207
>>> @@ -15,21 +15,13 @@ _begin_fstest auto quick clone fiemap
>>>   # Import common functions.
>>>   . ./common/filter
>>>   . ./common/reflink
>>> +. ./common/xfs
>> Is this really necessary? Will this test fail without this line?
>> The common/$FSTYP file is imported automatically, if it's not, that a bug.
> If the generic helper goes in common/rc instead then it's not necessary
> at all.
>
> --D
Yeah, this makes sense.
>
>> Thanks,
>> Zorro
>>
>>>   
>>>   _require_scratch_reflink
>>>   _require_cp_reflink
>>>   _require_xfs_io_command "fiemap"
>>>   _require_xfs_io_command "cowextsize"
>>>   
>>> -# Takes the fsxattr.xflags line,
>>> -# i.e. fsxattr.xflags = 0x0 [--------------C-]
>>> -# and tests whether a flag character is set
>>> -test_xflag()
>>> -{
>>> -    local flg=$1
>>> -    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
>>> -}
>>> -
>>>   echo "Format and mount"
>>>   _scratch_mkfs > $seqres.full 2>&1
>>>   _scratch_mount >> $seqres.full 2>&1
>>> @@ -65,14 +57,14 @@ echo "Set cowextsize and check flag"
>>>   $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>>>   _scratch_cycle_mount
>>>   
>>> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>>> +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>>>   $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>>>   
>>>   echo "Unset cowextsize and check flag"
>>>   $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>>>   _scratch_cycle_mount
>>>   
>>> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>>> +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>>>   $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>>>   
>>>   status=0
>>> -- 
>>> 2.43.5
>>>
>>>
-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


