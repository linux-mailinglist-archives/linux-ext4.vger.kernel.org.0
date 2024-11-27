Return-Path: <linux-ext4+bounces-5423-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74129DA160
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 05:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54838168C60
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 04:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24360367;
	Wed, 27 Nov 2024 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KyVuL6lu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043C28EB;
	Wed, 27 Nov 2024 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680643; cv=none; b=Ut8v6aSjR/Oa9rgGcGlUgh9lY4qE2ZnXvpLAIfg8KO/V3ECAR5kxf9ZUlpG/nxTOTSnRKgksYoJlvlcjaAong4RxBQ9vBWL1OZR2ZhcsTWStGsT2ZUD8nNTJqMupwu8AOfKLBZJ+14vqeONrRRB24axE1iC4VxYmu63xXhRaVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680643; c=relaxed/simple;
	bh=6t2ItbKLz/3mY+hQqF2YXsn2yU/0EOQZNbBGS41AYfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FiL5VdSC1FE5Ue71wT0+7iGdahoVL2NtK/TL53vvSjgqk20q0ZuKeHBJupOQxkXl5HdpXWfXlQ3gW1vnSHrX7AERcrw+2B9EfIDWLtdOvF6/lf5zXR7uiCZMK5XxzPjGIdkvRgPKeFaReQdEVxpOVCZ3pQuZEoiyRNAPZwr+kDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KyVuL6lu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1ixv6024520;
	Wed, 27 Nov 2024 04:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4IvgS/
	RSMTXJM0/AhwuL8iklHlIyh70nfD70aF0E9fs=; b=KyVuL6lu4CFa5hRjVq3MW5
	Ux+oJ2z5ZuF1XjrENHXU7IqNXPPBZY/qfy3dQXzMD7aCeZANjWNVCEBBXKGtqQ1q
	VT+y9mindSGaoAn6TSw0kF7AuT2gTo+KUTjeyDsbZkVhGKtaMzUO3KErOJenD2iu
	BJieKSIjAd6m4b+iH2KQ+3KAJA1L7A9dGJgZGAN2KhyhaT4Drwz66t/s6cJXwh7f
	g/HiQCNohXB4c+DiP8ALkzOknnfw1Y0fkgPDQhu85Kidc+2e0vtrZw/5ZKe0tisR
	aztxIScQ64HirTbEqVtBH+QnVycVsVld35FXpTTOvV34aOa2nMLDeS7pOUC1P8aA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43389chrkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:10:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AR49vb9013586;
	Wed, 27 Nov 2024 04:10:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43389chrkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:10:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR380na024910;
	Wed, 27 Nov 2024 04:10:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433tvkhy14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:10:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AR4AYRF55116232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 04:10:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5F3F20040;
	Wed, 27 Nov 2024 04:10:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68DAD20043;
	Wed, 27 Nov 2024 04:10:33 +0000 (GMT)
Received: from [9.39.20.219] (unknown [9.39.20.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 04:10:33 +0000 (GMT)
Message-ID: <9b6c5616-580a-491d-a5b9-aa0344e7db12@linux.ibm.com>
Date: Wed, 27 Nov 2024 09:40:32 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] common/rc: Add a new _require_scratch_extsize
 helper function
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, zlang@kernel.org
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
 <3e0f7be0799a990e2f6856f884e527a92585bf56.1732599868.git.nirjhar@linux.ibm.com>
 <20241127005403.GS9438@frogsfrogsfrogs>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <20241127005403.GS9438@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iqp3O-alBmnGhSXknkbyuLXHJQYncYjZ
X-Proofpoint-ORIG-GUID: ZqKfJ8BmAKcZR8K3rQZ093T_uW700Jeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=935
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270030


On 11/27/24 06:24, Darrick J. Wong wrote:
> On Tue, Nov 26, 2024 at 11:24:07AM +0530, Nirjhar Roy wrote:
>> _require_scratch_extsize helper function will be used in the
>> the next patch to make the test run only on filesystems with
>> extsize support.
>>
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
>>   common/rc | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index f94bee5e..e6c6047d 100644
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
>> +	_require_xfs_io_command "extsize"
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
>> +}
>> +
>>   # Write a byte into a range of a file
>>   _pwrite_byte() {
>>   	local pattern="$1"
>> -- 
>> 2.43.5
>>
>>
-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


