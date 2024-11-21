Return-Path: <linux-ext4+bounces-5340-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB39D5295
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 19:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902701F2162F
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A781AA1DB;
	Thu, 21 Nov 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H1uTrkCR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC8B67F;
	Thu, 21 Nov 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214027; cv=none; b=Pd9ys4cOvUXkvDrpaaNVXjAo5Six46L2IiTXTKSKxbVXboXu9uKT1CiYek8calYnkZIDHLLAM0sEGX2dl0NBnhjATsYLeWZWQ98b9XpECySr2anOISgoEx6fYNyZm2n7kW65cOBsz616sBz0xFz46Ro9fFWfRyCa4YSGr4OA5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214027; c=relaxed/simple;
	bh=AilhvwYoNac3zfe6kuXqE5PfFvcWyYngC9rXwaG+nfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCuFLJ3umI7TerIJWdK21JWFfa8XFFMv4hedV/lv1KiKiI9CYKNKh2/JMVBXfUMWDW2RSHZEd7FdR2x541RU03kAhIS6Yh1HabaNGDFwdYIi/HyjmvxdeQjw3i89Q+MrdP9r5oPeS9GsKVtK+VFgZHIEf1gem+k7k/C5Vnuc3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H1uTrkCR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL9Iu7Z012436;
	Thu, 21 Nov 2024 18:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j6JY/o
	NRQCuIhr+taNlVHFAQVdK0uFg7NljK8349KYM=; b=H1uTrkCR20R3yKBwZG3Y1Z
	Ml1ZTqf79hlUF7XmOS6xkF04OIW7r7ocE+CBtMJy7ViUXGBumVSYVRGIOTswR8b5
	lXxBqAF89Xn783sS2UjSIxLCDxgiI6WCciSrUu8UEZ/SzONe14GgCy5Lo1C2T6y5
	SH8662T+eMGlVV7zsbrbk83ImbzRl2e7koo+rXMsLQsNX9yZ/27JyE+/Tf0lVO0e
	OqmnLq+gSAoOunm6QyH9cD2ml71AZTfqb6quYVj84uhU+wi/sujd1kpZ2sv+9zwb
	vShbh25bzAQRgN9ZGTrXwILbf6GyAUb27iF/VylLL+/s8wctlMn+uAYvn8pb9CzQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4313gstwkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:33:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ALIGpkx013783;
	Thu, 21 Nov 2024 18:33:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4313gstwkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:33:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALH4qwB000591;
	Thu, 21 Nov 2024 18:33:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77msc67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:33:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ALIXXLu53608746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 18:33:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 041BF20043;
	Thu, 21 Nov 2024 18:33:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A117920040;
	Thu, 21 Nov 2024 18:33:31 +0000 (GMT)
Received: from [9.124.219.125] (unknown [9.124.219.125])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Nov 2024 18:33:30 +0000 (GMT)
Message-ID: <52dce21e-9b34-4a3d-9f2c-86634cd10750@linux.ibm.com>
Date: Fri, 22 Nov 2024 00:03:30 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] common/rc: Add a new _require_scratch_extsize
 helper function
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
References: <cover.1732126365.git.nirjhar@linux.ibm.com>
 <4412cece5c3f2175fa076a3b29fe6d0bb4c43a6e.1732126365.git.nirjhar@linux.ibm.com>
 <87plmp81km.fsf@gmail.com>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <87plmp81km.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iaUInM7EjzT1AWGztfLarK27nxTr97-w
X-Proofpoint-ORIG-GUID: zRWqT0NSR1cTUorB80TKVOOmJran-FEr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210139


On 11/21/24 13:23, Ritesh Harjani (IBM) wrote:
> Nirjhar Roy <nirjhar@linux.ibm.com> writes:
>
>> _require_scratch_extsize helper function will be used in the
>> the next patch to make the test run only on filesystems with
>> extsize support.
>>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
>> ---
>>   common/rc | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index cccc98f5..995979e9 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -48,6 +48,23 @@ _test_fsxattr_xflag()
>>   	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
>>   }
>>   
>> +# This test requires extsize support on the  filesystem
>> +_require_scratch_extsize()
>> +{
>> +	_require_scratch
> _require_xfs_io_command "extsize"
>
> ^^^ Don't we need this too?
Yes, good point. I will add this in the next revision.
>
>> +	_scratch_mkfs > /dev/null
>> +	_scratch_mount
>> +	local filename=$SCRATCH_MNT/$RANDOM
>> +	local blksz=$(_get_block_size $SCRATCH_MNT)
>> +	local extsz=$(( blksz*2 ))
>> +	local res=$($XFS_IO_PROG -c "open -f $filename" -c "extsize $extsz" \
>> +		-c "extsize")
>> +	_scratch_unmount
>> +	grep -q "\[$extsz\] $filename" <(echo $res) || \
>> +		_notrun "this test requires extsize support on the filesystem"
> Why grep when we can simply just check the return value of previous xfs_io command?
No, I don't think we can rely on the return value of xfs_io. For ex, 
let's look at the following set of commands which are ran on an ext4 system:

root@AMARPC: /mnt1/test$ xfs_io -V
xfs_io version 5.13.0
root@AMARPC: /mnt1/test$ touch new
root@AMARPC: /mnt1/test$ xfs_io -c "extsize 8k"  new
foreign file active, extsize command is for XFS filesystems only
root@AMARPC: /mnt1/test$ echo "$?"
0
This incorrect return value might have been fixed in some later versions 
of xfs_io but there are still versions where we can't solely rely on the 
return value.
>
>> +}
>> +
>> +
> ^^ Extra newline.

Noted. I will fix this.

--NR

>
>>   # Write a byte into a range of a file
>>   _pwrite_byte() {
>>   	local pattern="$1"
>> -- 
>> 2.43.5

-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


