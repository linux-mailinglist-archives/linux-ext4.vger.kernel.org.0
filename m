Return-Path: <linux-ext4+bounces-5338-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575749D528D
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 19:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183F728109F
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BA21BBBC1;
	Thu, 21 Nov 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XhdOpiD5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA419EEC4;
	Thu, 21 Nov 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213869; cv=none; b=Co2XA60pNGVRMDq4E7Rus0Bdq34WS5K0A3so78hZIkxS6DIBMFXtkem2G96EIIuthyjQgojf2FBPtl4s8PhNzQxs80dZppPdhYxuA63Uo4FRye8mKj8Loi+L92LD5rAQuuGJhZ11zvkFWLaQJPC8P9pMBH8haehKpwGbc3YTU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213869; c=relaxed/simple;
	bh=qioggrxnVgno/FO6LLhy5ZyuWSzXrSq8/0OlfYztgpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epmvbr0Hlt4If5/AZIOpo4n9iAKS+SYOufYTi4kIbLHEbcvt2le9GFQOAQkMzM2lii9SXhlqzNy7OG5M0A+hkHmSiVpbOuQw0F8HkKqfAMdKbmczIixyp/KabUbRxeone+JIppjOFOQ4ty4fokzBM+wzl5fBsBohDu/uA2YueoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XhdOpiD5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8xXFJ027820;
	Thu, 21 Nov 2024 18:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W0lvMT
	1s3YNC9kYeGKhAn6MY9ArUfENZ3jBkSGnLUKk=; b=XhdOpiD53wiC+ycfqI07wO
	LMdNdSqEIT1MgIH7xdu8ntwZB3+G3mLufyL5fOO7Gc5yjqOnHjsU+dCMTgwliR+q
	IXJ6B9ufNSWp+bpuQGacCOSTfS/lEZi8bhEfPNFUliwPpjwrXx8yxVsKQjwElpEX
	0M4WJg5yK5BxJX+Zm1+W8DFemKw9Vd6Yy0dmAVBcTho7wEWH+YCGllRRPBrXok+4
	K5NTUCxi+ajKUl7XFrmGqR4GyxwrnVZJRmQvFXfnY9zSHuBRCGlq3sLb4q40Qozk
	QHvMJFJ62TJFGG/1ORjQzdsY0y6tudqza55UY6JbTg7yP+0pCfISHlBniyfG28jQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk21c7y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:31:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ALIR3Aa027631;
	Thu, 21 Nov 2024 18:31:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk21c7xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:31:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALFLf4a021833;
	Thu, 21 Nov 2024 18:31:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y6qn1ad3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:31:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ALIV1QA52429296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 18:31:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0150220040;
	Thu, 21 Nov 2024 18:31:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28FA12004B;
	Thu, 21 Nov 2024 18:30:59 +0000 (GMT)
Received: from [9.124.219.125] (unknown [9.124.219.125])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Nov 2024 18:30:58 +0000 (GMT)
Message-ID: <8ad602fa-119c-4863-a3be-e778fefa0b1c@linux.ibm.com>
Date: Fri, 22 Nov 2024 00:00:52 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] common/rc,xfs/207: Add a common helper function to
 check xflag bits
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, zlang@kernel.org
References: <cover.1732126365.git.nirjhar@linux.ibm.com>
 <e3fe55386a702d34147612b2ce46698b6257e821.1732126365.git.nirjhar@linux.ibm.com>
 <20241121172029.GX9425@frogsfrogsfrogs>
Content-Language: en-US
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <20241121172029.GX9425@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a23bRwkJPLmUScM1mYV9uQBnXp3XZ881
X-Proofpoint-GUID: WbTKPbxPJxMTGVtGs6y-oPLx9d1R4E2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=914 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210139


On 11/21/24 22:50, Darrick J. Wong wrote:
> On Thu, Nov 21, 2024 at 10:39:10AM +0530, Nirjhar Roy wrote:
>> This patch defines a common helper function to test whether any of
>> fsxattr xflags field is set or not. We will use this helper in
>> an upcoming patch for checking extsize (e) flag.
>>
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> Looks good to me now,
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D

Thank you.

--NR

>
>> ---
>>   common/rc     |  7 +++++++
>>   tests/xfs/207 | 15 ++++-----------
>>   2 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 2af26f23..cccc98f5 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -41,6 +41,13 @@ _md5_checksum()
>>   	md5sum $1 | cut -d ' ' -f1
>>   }
>>   
>> +# Check whether a fsxattr xflags name ($2) field is set on a given file ($1).
>> +# e.g, fsxattr.xflags =  0x80000800 [extsize, has-xattr]
>> +_test_fsxattr_xflag()
>> +{
>> +	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
>> +}
>> +
>>   # Write a byte into a range of a file
>>   _pwrite_byte() {
>>   	local pattern="$1"
>> diff --git a/tests/xfs/207 b/tests/xfs/207
>> index bbe21307..394e7e55 100755
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
>> @@ -65,14 +56,16 @@ echo "Set cowextsize and check flag"
>>   $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>>   _scratch_cycle_mount
>>   
>> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>> +_test_fsxattr_xflag "$testdir/file3" "cowextsize" && echo "C flag set" || \
>> +	echo "C flag unset"
>>   $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>>   
>>   echo "Unset cowextsize and check flag"
>>   $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>>   _scratch_cycle_mount
>>   
>> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>> +_test_fsxattr_xflag "$testdir/file3" "cowextsize" && echo "C flag set" || \
>> +	echo "C flag unset"
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


