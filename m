Return-Path: <linux-ext4+bounces-5382-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34C09D63FB
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2024 19:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635D4B29CA9
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2024 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E119F1DFD9E;
	Fri, 22 Nov 2024 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IB0rOGks"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445C1DFD97;
	Fri, 22 Nov 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298850; cv=none; b=Fc4r4eTGg5yDChh786F1oHXDIw7GxeqpJV07BtWZLJit76br7k7RPXK1EcYEbh+ar8CyTpI5m6TI0n4jnPsIbXf+Xl3t4Zx0Ya0T5LSVpVhHRyLgGRfbosyHrx8pB5ZFQ2G5vN1560QhHVp0TrA3nGfqR3RumPT2N3X/9Izkzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298850; c=relaxed/simple;
	bh=VEPzV/cQtApsGaERHepz/W1OSfgzg9ZHPbVr569mBa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpHiu/6SI+zpLlG3xEI6OnSCqoRdvI1hCfZvEBJWrASLVw0q4ccUEA2VYfnx87Rtl0slFfcMbWDLEj2kokqrhmOECmmkidrkIDOcC4GKr4N0ObNmLBawGjxOlAK1GNtpWRqrjqxWLSUP2cQnvydZ9tohgeyOaCs5/3+Mq7eutoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IB0rOGks; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMC5lUB019046;
	Fri, 22 Nov 2024 18:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XXnVGD
	Uy16e9DBM9uQ2NUu0acgwcDqoLl9RObSCKwGY=; b=IB0rOGkszgpoYT23VxHTUj
	RmmeslF7Rse6S0C9eGXL9rYsx/zo3e/QBNdxLxYGhGoo8u5KJ6OcyoB+63j+SWWj
	UKBSKpsRnheK+km9FIfrHomQobstBAnkRyhEjDesNBIQpqzEaSXF2RlML+KmgGCn
	00LfZ0wiB2jqj6n7I63SPykwSaHH65/PGo1F6y+IZtisEmUhAocWuylyTMXYGZBK
	5mlVERtrwad1ldyA/6E0Qljnqq8FdREtuPkTnCb5pUBkJq+xIC59Cm0i/hjuJlcu
	ShZEboYLZJc2a4uEioR6qPMDkYtztYqydpjA0qt55yRkamREb1LCceP0/fSxrf3w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk21jcuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 18:07:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AMI7MZq004992;
	Fri, 22 Nov 2024 18:07:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk21jcu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 18:07:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMI29ik000626;
	Fri, 22 Nov 2024 18:07:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77n5kcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 18:07:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AMI7JuR33489606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 18:07:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD1620122;
	Fri, 22 Nov 2024 18:07:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4757120123;
	Fri, 22 Nov 2024 18:07:18 +0000 (GMT)
Received: from [9.124.208.242] (unknown [9.124.208.242])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 18:07:18 +0000 (GMT)
Message-ID: <7bf1c177-1213-4c35-80bc-620d02a441c2@linux.ibm.com>
Date: Fri, 22 Nov 2024 23:37:17 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] common/rc: Add a new _require_scratch_extsize
 helper function
To: "Darrick J. Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, zlang@kernel.org
References: <cover.1732126365.git.nirjhar@linux.ibm.com>
 <4412cece5c3f2175fa076a3b29fe6d0bb4c43a6e.1732126365.git.nirjhar@linux.ibm.com>
 <87plmp81km.fsf@gmail.com>
 <52dce21e-9b34-4a3d-9f2c-86634cd10750@linux.ibm.com>
 <871pz4xvuu.fsf@gmail.com> <20241122160430.GZ9425@frogsfrogsfrogs>
Content-Language: en-US
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <20241122160430.GZ9425@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4TRqew3xe_XpeXexfVHNbDwVbCGLmxDH
X-Proofpoint-GUID: aj5PcCxHl4dOb2ASwUEBqJzGLM7NIWWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220151


On 11/22/24 21:34, Darrick J. Wong wrote:
> On Fri, Nov 22, 2024 at 12:22:41AM +0530, Ritesh Harjani wrote:
>> Nirjhar Roy <nirjhar@linux.ibm.com> writes:
>>
>>> On 11/21/24 13:23, Ritesh Harjani (IBM) wrote:
>>>> Nirjhar Roy <nirjhar@linux.ibm.com> writes:
>>>>
>>>>> _require_scratch_extsize helper function will be used in the
>>>>> the next patch to make the test run only on filesystems with
>>>>> extsize support.
>>>>>
>>>>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>>>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
>>>>> ---
>>>>>    common/rc | 17 +++++++++++++++++
>>>>>    1 file changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/common/rc b/common/rc
>>>>> index cccc98f5..995979e9 100644
>>>>> --- a/common/rc
>>>>> +++ b/common/rc
>>>>> @@ -48,6 +48,23 @@ _test_fsxattr_xflag()
>>>>>    	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
>>>>>    }
>>>>>    
>>>>> +# This test requires extsize support on the  filesystem
>>>>> +_require_scratch_extsize()
>>>>> +{
>>>>> +	_require_scratch
>>>> _require_xfs_io_command "extsize"
>>>>
>>>> ^^^ Don't we need this too?
>>> Yes, good point. I will add this in the next revision.
>>>>> +	_scratch_mkfs > /dev/null
>>>>> +	_scratch_mount
>>>>> +	local filename=$SCRATCH_MNT/$RANDOM
>>>>> +	local blksz=$(_get_block_size $SCRATCH_MNT)
>>>>> +	local extsz=$(( blksz*2 ))
>>>>> +	local res=$($XFS_IO_PROG -c "open -f $filename" -c "extsize $extsz" \
>>>>> +		-c "extsize")
>>>>> +	_scratch_unmount
>>>>> +	grep -q "\[$extsz\] $filename" <(echo $res) || \
>>>>> +		_notrun "this test requires extsize support on the filesystem"
>>>> Why grep when we can simply just check the return value of previous xfs_io command?
>>> No, I don't think we can rely on the return value of xfs_io. For ex,
>>> let's look at the following set of commands which are ran on an ext4 system:
>>>
>>> root@AMARPC: /mnt1/test$ xfs_io -V
>>> xfs_io version 5.13.0
>>> root@AMARPC: /mnt1/test$ touch new
>>> root@AMARPC: /mnt1/test$ xfs_io -c "extsize 8k"  new
>>> foreign file active, extsize command is for XFS filesystems only
>>> root@AMARPC: /mnt1/test$ echo "$?"
>>> 0
>>> This incorrect return value might have been fixed in some later versions
>>> of xfs_io but there are still versions where we can't solely rely on the
>>> return value.
>> Ok. That's bad, we then have to rely on grep.
>> Sure, thanks for checking and confirming that.
> You all should add CMD_FOREIGN_OK to the extsize command in xfs_io,
> assuming that you've not already done that in your dev workspace.
>
> --D

Yes, I have tested with that as well. I have applied the following patch 
to xfsprogs and tested with the modified xfs_io.

diff --git a/io/open.c b/io/open.c
index 15850b55..6407b7e8 100644
--- a/io/open.c
+++ b/io/open.c
@@ -980,7 +980,7 @@ open_init(void)
         extsize_cmd.args = _("[-D | -R] [extsize]");
         extsize_cmd.argmin = 0;
         extsize_cmd.argmax = -1;
-       extsize_cmd.flags = CMD_NOMAP_OK;
+       extsize_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
         extsize_cmd.oneline =
                 _("get/set preferred extent size (in bytes) for the 
open file");
         extsize_cmd.help = extsize_help;

The return values are similar.

root@AMARPC: /mnt1/scratch$ touch new
root@AMARPC: /mnt1/scratch$ /home/ubuntu/xfsprogs-dev/io/xfs_io -c 
"extsize 8k" new
root@AMARPC: /mnt1/scratch$ echo "$?"
0
root@AMARPC: /mnt1/scratch$ /home/ubuntu/xfsprogs-dev/io/xfs_io -c 
"extsize" new
[0] new

This is the reason I am not relying on the return value, instead I am 
checking if only the extsize gets changed, we will assume that the 
extsize support is there, else the test will _notrun.

Also,

root@AMARPC: /mnt1/scratch$ strace -f /mnt1/scratch$ 
/home/ubuntu/xfsprogs-dev/io/xfs_io -c "extsize 16k" new

...

...

ioctl(3, FS_IOC_FSGETXATTR, {fsx_xflags=0, fsx_extsize=0, 
fsx_nextents=0, fsx_projid=0, fsx_cowextsize=0}) = 0
ioctl(3, FS_IOC_FSSETXATTR, {fsx_xflags=FS_XFLAG_EXTSIZE, 
fsx_extsize=16384, fsx_projid=0, fsx_cowextsize=0}) = 0
exit_group(0)

Looking at the existing code for ext4_fileattr_set(), We validate the 
flags but I think we silently don't validate(and ignore) the xflags. 
Like, we have

int err = -EOPNOTSUPP;
if (flags & ~EXT4_FL_USER_VISIBLE)
         goto out;

BUT we do NOT have something like

int err = -EOPNOTSUPP;
if (fa->fsx_flags & ~EXT4_VALID_XFLAGS) // where EXT4_VALID_XFLAGS 
should be an || of all the supported xflags in ext4.
         goto out;

I am not sure what other filesystems do, but if we check whether the 
extsize got changed, then we can correctly determine extsize support.

Does that make sense?

--NR



>
>> -ritesh
>>
-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


