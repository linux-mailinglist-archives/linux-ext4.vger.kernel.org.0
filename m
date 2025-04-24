Return-Path: <linux-ext4+bounces-7450-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D5A9A775
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 11:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045FE16F324
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075F215160;
	Thu, 24 Apr 2025 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMB2KE4L"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826B214801;
	Thu, 24 Apr 2025 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485788; cv=none; b=MRrHkizVFsdTPq3HTk0PkXQ3qP1wtRHeCn07+73CehEk4m4pLT51cNm7gRxVaRazKx5ZuiO6UnM+1W7lBAtSFlKSCwBvsUIslSo+EvMeGIjez3xXthpiWmXHnQ7kX0Tfk0Ek4uzzdYTLFRrhNSOYgeIEFeZB1u794BKt8c5v6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485788; c=relaxed/simple;
	bh=X07in+imqZQNSMPNChe4ZXAAk1n7NwX8rwno4+uDGug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVcsfVrhhfqCRS3h3Mb/UsSJnV+TxBGLysn3z0nKKld80j0cD8NOAHTVHBKMZGEshGg2FhxItRBfU96PQfXF654svJeipdxHwEtKoiu8ZY325pD8bBK2eVKd1QUWmRHnXJOaswS0WxHN2pXfox3Vqa3mxT1deeBAoOcNkgDQcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMB2KE4L; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225df540edcso19948305ad.0;
        Thu, 24 Apr 2025 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745485784; x=1746090584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdj+nI//gNydPjfZDccikqd/5LrA6/9ycop2otuF9Og=;
        b=DMB2KE4LBfURzWszb68ZeOwQNkjNET6pEqbvWkYFB28KSRGIxbEo+HopBddXO7aRXG
         sLwpew+ICmGpfdIrTdSYdAcGegoAj2Phjq5ftn5oRW46E7UBKw0xy/wWki0VnW2Cdl9F
         BojOa85CWP+WfFcH/pEDCGdJK8LEjg9YgR6szOgKq9YqO9Wg19Cq6VeNnkZVhdm5V2Z9
         pubeTOBFDEN8JH0PmEMPstUKz+ntO3VhLRUevlYk9BZBmgIHaFTp4zz+LpfggoGl7oDW
         qSRtb2eXM7qDy0NYRV7/FxvYJRbQx9g34Ave41Q4ynURrjeT5HJr5c07e6tqgDIGHmEs
         fZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745485784; x=1746090584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdj+nI//gNydPjfZDccikqd/5LrA6/9ycop2otuF9Og=;
        b=ZQGH1mpjVsh95KOJsMvdsXfh7pbUP+sMNmXlCpykH5DGw5HjUi6RwMhek6RZiRwOMV
         SbarOgvz1iuc6Kuu4MHJg7VHW+MfI8rtuQ2SGQPWjoXG8e8b1r5ZQ+GHfayiYfMJmLuj
         5qgSmzI/oMH0EDBs2Jn9jv7g1YIc9LVWtlR5qKNt61E8FIucbhlqgkxlUHJ7EAo7J92q
         GrWf2qsC8d/CU67y8+Hui36+S9LluB6ogVACYJI/xuaKpCWSyhvXJilY8q+cA2yHijRu
         1v5ANNUO/KDOjfWSQ6iuTjuslBWUtiAp2hN60jzrFFBpb+bHFHgPpFX7wgfge0QUxouQ
         /KRw==
X-Forwarded-Encrypted: i=1; AJvYcCV9dXuZQ9Hghk9tRnOeBrtylqbb+3zCW8KOvqApQCQLxxn0fARN1xBbbEMXY1Lu12N0MICUSEfCn8W2@vger.kernel.org, AJvYcCWuKURH3CIfFl3hpNzQWtRCUduvQ687tZri8sXpeKzsozI2KLoRYCCj6Rl8uMqPibTgu+c1V8JHnBEx@vger.kernel.org
X-Gm-Message-State: AOJu0YxpEwWn//RjMycTfjioimC6W9A0NzukpHCKbudczw0vCUxulPBo
	80i/JLwuc3Oqb0v2yZzFNrzS8CJmQLN0P09o+urQ02S+ci2B2KkwWjsGyg==
X-Gm-Gg: ASbGncsO/QsGN3ANdBi7EZCXXRLJahsoCWO6TJ+nOxdnfrBTdtno0aD8+sHnf053dtD
	7KkMrUDL14lm7/yMDLfC9tSBB083Ppqb28QsVQWFssnGh+MKzuiCcQoPrn5aZWEJXbESfbyiv6j
	1P4Ayumxydp0crrXo5xuxxeF928AJTj75/g5mn0sbAQlw9Oj7X+cMZNwt1Q7PxkvOEfKo9qqs0E
	O5nUwv+ys1y3tcOZJ+AITKDewkteLMxm/GaSo6B23a0pgEn616sJbJ8tdyKwzLISd+e5RmwXmF7
	Zw/ZUUl9RlXAr6HNgTRttDBee0RpL1HPqXXN22YxtlRXRdyoV7k=
X-Google-Smtp-Source: AGHT+IHq7beMFtT/z2p9hFRZ7GkfWWrRSoZB5Z5wltqy5x+3GUJpzrUmZEYJy5Ktfw6EvkHFzqutPw==
X-Received: by 2002:a17:903:3c64:b0:215:6c5f:d142 with SMTP id d9443c01a7336-22db4957f83mr22587575ad.20.1745485783997;
        Thu, 24 Apr 2025 02:09:43 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76fa2sm8447755ad.19.2025.04.24.02.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 02:09:43 -0700 (PDT)
Message-ID: <054fa772-360e-4f90-bc4d-ea7ef954d5a2@gmail.com>
Date: Thu, 24 Apr 2025 14:39:39 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] common: Move exit related functions to a
 common/exit
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <cover.1745390030.git.nirjhar.roy.lists@gmail.com>
 <d0b7939a277e8a16566f04e449e9a1f97da28b9d.1745390030.git.nirjhar.roy.lists@gmail.com>
 <20250423141808.2qdmacsyxu3rtrwh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250423141808.2qdmacsyxu3rtrwh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/23/25 19:48, Zorro Lang wrote:
> On Wed, Apr 23, 2025 at 06:41:34AM +0000, Nirjhar Roy (IBM) wrote:
>> Introduce a new file common/exit that will contain all the exit
>> related functions. This will remove the dependencies these functions
>> have on other non-related helper files and they can be indepedently
>> sourced. This was suggested by Dave Chinner[1].
>>
>> [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
>> Suggested-by: Dave Chinner <david@fromorbit.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   check           |  1 +
>>   common/btrfs    |  2 +-
>>   common/ceph     |  2 ++
>>   common/config   | 17 +----------------
>>   common/dump     |  1 +
>>   common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   common/ext4     |  2 +-
>>   common/populate |  2 +-
>>   common/preamble |  1 +
>>   common/punch    |  6 +-----
>>   common/rc       | 29 +---------------------------
>>   common/repair   |  1 +
>>   common/xfs      |  1 +
> I think if you define exit helpers in common/exit, and import common/exit
> in common/config, then you don't need to source it(common/exit) in other
> common files (.e.g common/xfs, common/rc, etc). Due to when we call the
> helpers in these common files, the process should already imported
> common/rc -> common/config -> common/exit. right?

Oh, right. I can remove the redundant imports from 
common/{btrfs,ceph,dump,ext4,populate,preamble,punch,rc,repair,xfs} in 
v2. I will keep ". common/exit" only in common/config and check. The 
reason for me to keep it in check is that before common/rc is sourced in 
check, we might need _exit() (which is present is common/exit). Do you 
agree?

--NR

>
> Thanks,
> Zorro
>
>>   13 files changed, 63 insertions(+), 52 deletions(-)
>>   create mode 100644 common/exit
>>
>> diff --git a/check b/check
>> index 9451c350..67355c52 100755
>> --- a/check
>> +++ b/check
>> @@ -51,6 +51,7 @@ rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>>   
>>   SRC_GROUPS="generic"
>>   export SRC_DIR="tests"
>> +. common/exit
>>   
>>   usage()
>>   {
>> diff --git a/common/btrfs b/common/btrfs
>> index 3725632c..9e91ee71 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -1,7 +1,7 @@
>>   #
>>   # Common btrfs specific functions
>>   #
>> -
>> +. common/exit
>>   . common/module
>>   
>>   # The recommended way to execute simple "btrfs" command.
>> diff --git a/common/ceph b/common/ceph
>> index df7a6814..89e36403 100644
>> --- a/common/ceph
>> +++ b/common/ceph
>> @@ -2,6 +2,8 @@
>>   # CephFS specific common functions.
>>   #
>>   
>> +. common/exit
>> +
>>   # _ceph_create_file_layout <filename> <stripe unit> <stripe count> <object size>
>>   # This function creates a new empty file and sets the file layout according to
>>   # parameters.  It will exit if the file already exists.
>> diff --git a/common/config b/common/config
>> index eada3971..6a60d144 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -38,7 +38,7 @@
>>   # - this script shouldn't make any assertions about filesystem
>>   #   validity or mountedness.
>>   #
>> -
>> +. common/exit
>>   . common/test_names
>>   
>>   # all tests should use a common language setting to prevent golden
>> @@ -96,15 +96,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>>   
>>   export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>>   
>> -# This functions sets the exit code to status and then exits. Don't use
>> -# exit directly, as it might not set the value of "$status" correctly, which is
>> -# used as an exit code in the trap handler routine set up by the check script.
>> -_exit()
>> -{
>> -	test -n "$1" && status="$1"
>> -	exit "$status"
>> -}
>> -
>>   # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>>   set_mkfs_prog_path_with_opts()
>>   {
>> @@ -121,12 +112,6 @@ set_mkfs_prog_path_with_opts()
>>   	fi
>>   }
>>   
>> -_fatal()
>> -{
>> -    echo "$*"
>> -    _exit 1
>> -}
>> -
>>   export MKFS_PROG="$(type -P mkfs)"
>>   [ "$MKFS_PROG" = "" ] && _fatal "mkfs not found"
>>   
>> diff --git a/common/dump b/common/dump
>> index 09859006..4701a956 100644
>> --- a/common/dump
>> +++ b/common/dump
>> @@ -3,6 +3,7 @@
>>   # Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.  All Rights Reserved.
>>   #
>>   # Functions useful for xfsdump/xfsrestore tests
>> +. common/exit
>>   
>>   # --- initializations ---
>>   rm -f $seqres.full
>> diff --git a/common/exit b/common/exit
>> new file mode 100644
>> index 00000000..ad7e7498
>> --- /dev/null
>> +++ b/common/exit
>> @@ -0,0 +1,50 @@
>> +##/bin/bash
>> +
>> +# This functions sets the exit code to status and then exits. Don't use
>> +# exit directly, as it might not set the value of "$status" correctly, which is
>> +# used as an exit code in the trap handler routine set up by the check script.
>> +_exit()
>> +{
>> +	test -n "$1" && status="$1"
>> +	exit "$status"
>> +}
>> +
>> +_fatal()
>> +{
>> +    echo "$*"
>> +    _exit 1
>> +}
>> +
>> +_die()
>> +{
>> +        echo $@
>> +        _exit 1
>> +}
>> +
>> +die_now()
>> +{
>> +	_exit 1
>> +}
>> +
>> +# just plain bail out
>> +#
>> +_fail()
>> +{
>> +    echo "$*" | tee -a $seqres.full
>> +    echo "(see $seqres.full for details)"
>> +    _exit 1
>> +}
>> +
>> +# bail out, setting up .notrun file. Need to kill the filesystem check files
>> +# here, otherwise they are set incorrectly for the next test.
>> +#
>> +_notrun()
>> +{
>> +    echo "$*" > $seqres.notrun
>> +    echo "$seq not run: $*"
>> +    rm -f ${RESULT_DIR}/require_test*
>> +    rm -f ${RESULT_DIR}/require_scratch*
>> +
>> +    _exit 0
>> +}
>> +
>> diff --git a/common/ext4 b/common/ext4
>> index f88fa532..ab566c41 100644
>> --- a/common/ext4
>> +++ b/common/ext4
>> @@ -1,7 +1,7 @@
>>   #
>>   # ext4 specific common functions
>>   #
>> -
>> +. common/exit
>>   __generate_ext4_report_vars() {
>>   	__generate_blockdev_report_vars TEST_LOGDEV
>>   	__generate_blockdev_report_vars SCRATCH_LOGDEV
>> diff --git a/common/populate b/common/populate
>> index 50dc75d3..a17acc9e 100644
>> --- a/common/populate
>> +++ b/common/populate
>> @@ -4,7 +4,7 @@
>>   #
>>   # Routines for populating a scratch fs, and helpers to exercise an FS
>>   # once it's been fuzzed.
>> -
>> +. common/exit
>>   . ./common/quota
>>   
>>   _require_populate_commands() {
>> diff --git a/common/preamble b/common/preamble
>> index ba029a34..0f306412 100644
>> --- a/common/preamble
>> +++ b/common/preamble
>> @@ -3,6 +3,7 @@
>>   # Copyright (c) 2021 Oracle.  All Rights Reserved.
>>   
>>   # Boilerplate fstests functionality
>> +. common/exit
>>   
>>   # Standard cleanup function.  Individual tests can override this.
>>   _cleanup()
>> diff --git a/common/punch b/common/punch
>> index 64d665d8..637f463f 100644
>> --- a/common/punch
>> +++ b/common/punch
>> @@ -3,6 +3,7 @@
>>   # Copyright (c) 2007 Silicon Graphics, Inc.  All Rights Reserved.
>>   #
>>   # common functions for excersizing hole punches with extent size hints etc.
>> +. common/exit
>>   
>>   _spawn_test_file() {
>>   	echo "# spawning test file with $*"
>> @@ -222,11 +223,6 @@ _filter_bmap()
>>   	_coalesce_extents
>>   }
>>   
>> -die_now()
>> -{
>> -	_exit 1
>> -}
>> -
>>   # test the different corner cases for zeroing a range:
>>   #
>>   #	1. into a hole
>> diff --git a/common/rc b/common/rc
>> index 9bed6dad..945f5134 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2,6 +2,7 @@
>>   # SPDX-License-Identifier: GPL-2.0+
>>   # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
>>   
>> +. common/exit
>>   . common/config
>>   
>>   BC="$(type -P bc)" || BC=
>> @@ -1798,28 +1799,6 @@ _do()
>>       return $ret
>>   }
>>   
>> -# bail out, setting up .notrun file. Need to kill the filesystem check files
>> -# here, otherwise they are set incorrectly for the next test.
>> -#
>> -_notrun()
>> -{
>> -    echo "$*" > $seqres.notrun
>> -    echo "$seq not run: $*"
>> -    rm -f ${RESULT_DIR}/require_test*
>> -    rm -f ${RESULT_DIR}/require_scratch*
>> -
>> -    _exit 0
>> -}
>> -
>> -# just plain bail out
>> -#
>> -_fail()
>> -{
>> -    echo "$*" | tee -a $seqres.full
>> -    echo "(see $seqres.full for details)"
>> -    _exit 1
>> -}
>> -
>>   #
>>   # Tests whether $FSTYP should be exclude from this test.
>>   #
>> @@ -3835,12 +3814,6 @@ _link_out_file()
>>   	_link_out_file_named $seqfull.out "$features"
>>   }
>>   
>> -_die()
>> -{
>> -        echo $@
>> -        _exit 1
>> -}
>> -
>>   # convert urandom incompressible data to compressible text data
>>   _ddt()
>>   {
>> diff --git a/common/repair b/common/repair
>> index fd206f8e..db6a1b5c 100644
>> --- a/common/repair
>> +++ b/common/repair
>> @@ -3,6 +3,7 @@
>>   # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
>>   #
>>   # Functions useful for xfs_repair tests
>> +. common/exit
>>   
>>   _zero_position()
>>   {
>> diff --git a/common/xfs b/common/xfs
>> index 96c15f3c..c236146c 100644
>> --- a/common/xfs
>> +++ b/common/xfs
>> @@ -1,6 +1,7 @@
>>   #
>>   # XFS specific common functions.
>>   #
>> +. common/exit
>>   
>>   __generate_xfs_report_vars() {
>>   	__generate_blockdev_report_vars TEST_RTDEV
>> -- 
>> 2.34.1
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


