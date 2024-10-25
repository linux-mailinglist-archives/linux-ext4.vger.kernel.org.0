Return-Path: <linux-ext4+bounces-4760-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4217E9AF9C3
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 08:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02094283A8E
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 06:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0467197521;
	Fri, 25 Oct 2024 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nv+PpQBS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F818BC1C;
	Fri, 25 Oct 2024 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837063; cv=none; b=KMIqiJf2leZLyvp7Kpt1//dv972GxZksJpl9Gve1APiKoTqRD4n2dfpXR9FDjwpK5Wxl5rLz75d6t4Y+IgeMyjO24+oK4GoQgc6qE7c8qKueOjyCUVbaZrCoTTUQ+udjJiFQeAkVePv27XH2uJCmHMdqJYkz2Vn15KsjsUL1VLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837063; c=relaxed/simple;
	bh=gEoc57HRjyWOW3Q+Uc8leZ57H/DxK+5BArCyluq5y4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcM6wn97bHECkU1WzBM41YWQTw3ea8Rmm1LnslVDixg1j3+aRIg1x7CndAKnfsVKeYFZjaepyIeax97xVtXTM98827aBrZsglxgqDaQgJ97haybHJ8Gm3Xtp6yaQayA0AHuoVV1FriPQPaUFVAidat/Em1rNSdgSIFp0CMvjV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nv+PpQBS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P0bDC1012520;
	Fri, 25 Oct 2024 06:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KGu//x
	20XDmynYHA65O0vsYFhSc8EY5fw2wg33YnAFE=; b=Nv+PpQBS1qIZK5suaULlPg
	USGffpU7bRgD9ZdJvAEP+MowzyEuPKTXkGBNcykig4rv5ZSclvePSMh4ergZ25aH
	LkxAJ5QHfVfcAtziB4pdrY+7nQlTDSE7OC38ICjNYPnFVWBaXjuTOXpDif9yigae
	1E4BYDkXNLjcsl3qD08qrA35NsRbExsRmcANcFgGiFqOuRYeLzhw2C5HE4WWIaEX
	jp22fdZ7FHraAB6ZQVXE7KOQZzFCSFR7yBp8PClhtyk4CG7hx1/OOtQ4XvF1YtWb
	bFXj/j4JCc5LXEOnGiCkiAp2zV8BQTfAn9XhOw8lt1BoS+T+D5sQigsjk+ooRPkw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw46nff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:17:36 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49P6HZro003205;
	Fri, 25 Oct 2024 06:17:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw46nfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:17:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49P2U01A007286;
	Fri, 25 Oct 2024 06:17:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emjd48dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:17:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49P6HWRL55771430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 06:17:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0A7120043;
	Fri, 25 Oct 2024 06:17:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E05FF20040;
	Fri, 25 Oct 2024 06:17:30 +0000 (GMT)
Received: from [9.39.27.196] (unknown [9.39.27.196])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Oct 2024 06:17:30 +0000 (GMT)
Message-ID: <335a0031-d1f3-4af3-abb8-f411a9dfdcb5@linux.ibm.com>
Date: Fri, 25 Oct 2024 11:47:30 +0530
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
To: Zorro Lang <zlang@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, zlang@kernel.org
References: <cover.1729624806.git.nirjhar@linux.ibm.com>
 <6ba7f682af7e0bc99a8baeccc0d7aa4e5062a433.1729624806.git.nirjhar@linux.ibm.com>
 <20241025025651.okneano7d324nl4e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241025040703.GQ2578692@frogsfrogsfrogs>
 <20241025041501.jzj7b2ensn6lvpep@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <20241025041501.jzj7b2ensn6lvpep@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l2dSGesWdo9wRKAI_xzyHgC4OaGKKJmQ
X-Proofpoint-GUID: jLYk955Pb1FyQskku4RecVq4QlNrzAA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=990 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250044


On 10/25/24 09:45, Zorro Lang wrote:
> On Thu, Oct 24, 2024 at 09:07:03PM -0700, Darrick J. Wong wrote:
>> On Fri, Oct 25, 2024 at 10:56:51AM +0800, Zorro Lang wrote:
>>> On Wed, Oct 23, 2024 at 12:56:19AM +0530, Nirjhar Roy wrote:
>>>> This patch defines a common helper function to test whether any of
>>>> fsxattr xflags field is set or not. We will use this helper in the next
>>>> patch for checking extsize (e) flag.
>>>>
>>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
>>>> ---
>>>>   common/xfs    |  9 +++++++++
>>>>   tests/xfs/207 | 14 +++-----------
>>>>   2 files changed, 12 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/common/xfs b/common/xfs
>>>> index 62e3100e..7340ccbf 100644
>>>> --- a/common/xfs
>>>> +++ b/common/xfs
>>>> @@ -13,6 +13,15 @@ __generate_xfs_report_vars() {
>>>>   	REPORT_ENV_LIST_OPT+=("TEST_XFS_REPAIR_REBUILD" "TEST_XFS_SCRUB_REBUILD")
>>>>   }
>>>>   
>>>> +# Check whether a fsxattr xflags character field is set on a given file.
>>> Better to explain the arguments, e.g.
>>>
>>> # Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
>>>
>>>> +# e.g. fsxattr.xflags = 0x0 [--------------C-]
>>>> +# Returns 0 if passed flag character is set, otherwise returns 1
>>>> +_test_xfs_xflags_field()
>>>> +{
>>>> +    $XFS_IO_PROG -c "stat" "$1" | grep "fsxattr.xflags" | grep -q "\[.*$2.*\]" \
>>>> +        && return 0 || return 1
>>> That's too complex. Those "return" aren't needed as Darrick metioned. About
>>> that two "grep", how about combine them, e.g.
>>>
>>> _test_xfs_xflags_field()
>>> {
>>> 	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
>>> }
>>>
>>>
>>>
>>>> +}
>>>> +
>>>>   _setup_large_xfs_fs()
>>>>   {
>>>>   	fs_size=$1
>>>> diff --git a/tests/xfs/207 b/tests/xfs/207
>>>> index bbe21307..adb925df 100755
>>>> --- a/tests/xfs/207
>>>> +++ b/tests/xfs/207
>>>> @@ -15,21 +15,13 @@ _begin_fstest auto quick clone fiemap
>>>>   # Import common functions.
>>>>   . ./common/filter
>>>>   . ./common/reflink
>>>> +. ./common/xfs
>>> Is this really necessary? Will this test fail without this line?
>>> The common/$FSTYP file is imported automatically, if it's not, that a bug.
>> If the generic helper goes in common/rc instead then it's not necessary
>> at all.
> Won't the "_source_specific_fs $FSTYP" in common/rc helps to import common/xfs?
Yeah, it gets imported automatically(I have verified). Anyway, I am 
moving the helper function to common/rc, so this won't be required.
>
>> --D
>>
>>> Thanks,
>>> Zorro
>>>
>>>>   
>>>>   _require_scratch_reflink
>>>>   _require_cp_reflink
>>>>   _require_xfs_io_command "fiemap"
>>>>   _require_xfs_io_command "cowextsize"
>>>>   
>>>> -# Takes the fsxattr.xflags line,
>>>> -# i.e. fsxattr.xflags = 0x0 [--------------C-]
>>>> -# and tests whether a flag character is set
>>>> -test_xflag()
>>>> -{
>>>> -    local flg=$1
>>>> -    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
>>>> -}
>>>> -
>>>>   echo "Format and mount"
>>>>   _scratch_mkfs > $seqres.full 2>&1
>>>>   _scratch_mount >> $seqres.full 2>&1
>>>> @@ -65,14 +57,14 @@ echo "Set cowextsize and check flag"
>>>>   $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>>>>   _scratch_cycle_mount
>>>>   
>>>> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>>>> +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>>>>   $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>>>>   
>>>>   echo "Unset cowextsize and check flag"
>>>>   $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>>>>   _scratch_cycle_mount
>>>>   
>>>> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>>>> +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>>>>   $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>>>>   
>>>>   status=0
>>>> -- 
>>>> 2.43.5
>>>>
>>>>
-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


