Return-Path: <linux-ext4+bounces-7520-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D1A9EAF1
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Apr 2025 10:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D051891144
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Apr 2025 08:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE281BD01D;
	Mon, 28 Apr 2025 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAwkeeR/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF6253F02;
	Mon, 28 Apr 2025 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829566; cv=none; b=gOtDaeE/0KzR1TSIrknxXHyDBB82+1Ryad7d69uYf7kaDtTdQh8k9xoQ4N6ojeoOAHIZX7hYrASze1GHE68xy1iHq9Z4EWpYjesgqMapYFwKJbmIzbpF9jm/jsh7bfVcKQMCCZED83IupL94OvoYmynIQ2IbOHi4qIQsM+PHotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829566; c=relaxed/simple;
	bh=dyvVzieNVLHx9TOwKnHXM4+0cPAgpKW1Lw4R0dMYcsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoJomxHjuZdK76PYVKH2NHIQjVQ1cbKTonxRX0oALXHpYPRd0dQcwN3UYFBtTLf1WXrLC9E7gK4ImfuFNjRA2U6x8TQ/Y09tbOHOf4bjgwxV20l4wCwNLW9nJ0BvDpaDi2YbXhgnZ1YdHh9KwLe+pyK3eziKIRNFz1s8u/YcEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAwkeeR/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739be717eddso3606315b3a.2;
        Mon, 28 Apr 2025 01:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745829564; x=1746434364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSMqbYhbu12yh2ez0ipOG5SjAc9kvDU8lhNm8t4ttSE=;
        b=FAwkeeR/NPC9Y1VETbxrsYR4X46nT0pGQljdV1Jhl3sqZRbjekhAmgpkW9HqdGGYOh
         j5l8g2FJIy3E/1rnkmbjLA6ARCZ8h06EvianhrQsaIV2JcYgzQ3QcucH/MJYItynx2LT
         4uiCn8ud/qK0u4QIHKIYPF0TNM2A0qrKUl7GBlZ6m7BroJR4abPLgCzTfkiG7nca/dTJ
         b8ULvnHdlK5v5Sx/rC9nAbd6k0B1PIaFLkpWSaIPz0mBbZhRYjtaabHf8hgbCgXe0IMb
         EXZzoJNW0EItZ5RPgdPRU3VqjENyfvXyKfYP804+tiDiEUqev7mmUF0BO0kh2KZ0XVZT
         QcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745829564; x=1746434364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSMqbYhbu12yh2ez0ipOG5SjAc9kvDU8lhNm8t4ttSE=;
        b=oBXX0dr5Yvupz/nAE1xDWrIE6be63qIbZSZADxW6BqhWWC5LHI1oHovfJHcoqaYdFQ
         D2m1HtoYu0FMtJ2isBF1Na2jl1p/Q/gIBVMNu9l1u9JN6+AXBgLdLlPVZZ7tvZHoxKDS
         tSex7U6e/y6v8XxQTGqPxEB0+SxZwJObZKaEo8Xh2PIq6dj5/srbUZzc6CLz2YnC46NZ
         +7JZntwQ19MHXAgn4LBNBxsHyzU1qxP2dQpGvwyIu9Zc7Mv/NyeyWGA+KK72ccIAvA8P
         FtpuZ/sXiqujN+kXB0OAq8vFubZypk0yWCKitL3MNxjFxd06EafRA+XVSo11gDH1CjhZ
         1euA==
X-Forwarded-Encrypted: i=1; AJvYcCV5n+pZQ/Zw9Kk8Go2dy3ZIQEbTQ69dwKw1Jan3Kfk54qmel2zUNBVpolVHAFWY9ZEKSNEh/8wyfQEs@vger.kernel.org, AJvYcCVysrGkAyqaqopnCM5PP8+fBCOEknDj4bRUHgmlMZzIetWXXLy0E2hu7UOsQxzEd7ppTCXAexKoBJYn@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmudafA5aR1yt+qGCvWDMjlOSFzoFIk6SyPvKSijiILnp6jb+
	3siv6pvS05Rfe5U35+UdRWdTPGoJjRM3THcW3X+Zd4uNjvHbgZh19c0ZZA==
X-Gm-Gg: ASbGncsFW5yaKNSEZ6Pl7ypvgdY7/p7/QZi8zDczHZQ+37gT3xVHZqBcqW83LZEWSzA
	cB3zwVQAFnD1FulXFrpn3MmsRvBPfa1F8MhYQcy0WtBz7X62kuAdZ3PX2WOR+TSEfxLs0jaonWh
	aXO3lPaQIC+lsiPgZMdDgg2Oe4kXMh1yxPP+braRTZVL9eqZakud11LleMMnDyzwEg73b5DbTyd
	tKLu40Jeipl8g01cNix/16kZrpzdZx//hc7CRT93dlNz0036YOrLAJ93qLsKNtwdZAYtl6rZOlR
	qkuSo3Q1GpJTOf0RIFnX4aSyI67GPq2wb+wRWhZHgsC/F/DUCuQ=
X-Google-Smtp-Source: AGHT+IEvu6dlrLD2qfMZTkDeIJ6gXFD8uJUCqvL81/Lbd7KPlt/ciZ/O9gRrBQdhSqEVn/0SzvtpXw==
X-Received: by 2002:a05:6a00:4fcc:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-73fd71cfbc9mr18005311b3a.8.1745829563782;
        Mon, 28 Apr 2025 01:39:23 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a415sm7420370b3a.85.2025.04.28.01.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 01:39:23 -0700 (PDT)
Message-ID: <ccb82360-d9ae-46c5-a579-ae1be8d013ce@gmail.com>
Date: Mon, 28 Apr 2025 14:09:18 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] common: Move exit related functions to a
 common/exit
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <cover.1745390030.git.nirjhar.roy.lists@gmail.com>
 <d0b7939a277e8a16566f04e449e9a1f97da28b9d.1745390030.git.nirjhar.roy.lists@gmail.com>
 <20250423141808.2qdmacsyxu3rtrwh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <054fa772-360e-4f90-bc4d-ea7ef954d5a2@gmail.com>
 <20250425112745.aaamjdvhqtlx7vpd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <175d064b-76a5-4ff8-a34f-358f0e0d6baa@gmail.com>
 <20250425133648.5uygihyqo7vqofi3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250425133648.5uygihyqo7vqofi3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/25/25 19:06, Zorro Lang wrote:
> On Fri, Apr 25, 2025 at 05:33:24PM +0530, Nirjhar Roy (IBM) wrote:
>> On 4/25/25 16:57, Zorro Lang wrote:
>>> On Thu, Apr 24, 2025 at 02:39:39PM +0530, Nirjhar Roy (IBM) wrote:
>>>> On 4/23/25 19:48, Zorro Lang wrote:
>>>>> On Wed, Apr 23, 2025 at 06:41:34AM +0000, Nirjhar Roy (IBM) wrote:
>>>>>> Introduce a new file common/exit that will contain all the exit
>>>>>> related functions. This will remove the dependencies these functions
>>>>>> have on other non-related helper files and they can be indepedently
>>>>>> sourced. This was suggested by Dave Chinner[1].
>>>>>>
>>>>>> [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
>>>>>> Suggested-by: Dave Chinner <david@fromorbit.com>
>>>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>>>> ---
>>>>>>     check           |  1 +
>>>>>>     common/btrfs    |  2 +-
>>>>>>     common/ceph     |  2 ++
>>>>>>     common/config   | 17 +----------------
>>>>>>     common/dump     |  1 +
>>>>>>     common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>     common/ext4     |  2 +-
>>>>>>     common/populate |  2 +-
>>>>>>     common/preamble |  1 +
>>>>>>     common/punch    |  6 +-----
>>>>>>     common/rc       | 29 +---------------------------
>>>>>>     common/repair   |  1 +
>>>>>>     common/xfs      |  1 +
>>>>> I think if you define exit helpers in common/exit, and import common/exit
>>>>> in common/config, then you don't need to source it(common/exit) in other
>>>>> common files (.e.g common/xfs, common/rc, etc). Due to when we call the
>>>>> helpers in these common files, the process should already imported
>>>>> common/rc -> common/config -> common/exit. right?
>>>> Oh, right. I can remove the redundant imports from
>>>> common/{btrfs,ceph,dump,ext4,populate,preamble,punch,rc,repair,xfs} in v2. I
>>>> will keep ". common/exit" only in common/config and check. The reason for me
>>>> to keep it in check is that before common/rc is sourced in check, we might
>>>> need _exit() (which is present is common/exit). Do you agree?
>>> I thought "check" might not need that either. I didn't give it a test, but I found
>>> before importing common/rc, there're only command arguments initialization, and
>>> "check" calls "exit" directly if the initialization fails (except you want to call
>>> _exit, but I didn't see you change that).
>> Yes, I have changed the exit() to _exit() in "check" in the next patch [1]
>> of this series. Can you please take a look at that patch[1] and suggest
>> whether I should have ". common/exit" in "check" or not?
>>
>>
>> [1] https://lore.kernel.org/all/7d8587b8342ee2cbe226fb691b372ac7df5fdb71.1745390030.git.nirjhar.roy.lists@gmail.com/
> Oh, as "check" has:
>
>    if $OPTIONS_HAVE_SECTIONS; then
>            trap "_summary; exit \$status" 0 1 2 3 15
>    else
>            trap "_wrapup; exit \$status" 0 1 2 3 15
>    fi
>
> So I think it makes sense to use _exit() to deal with status variable :)

Oh, right. Yes, I can replace this "exit \$status" with "_exit". I will 
make the changes in v2. Any thoughts on the next patch[2]?

[2] 
https://lore.kernel.org/all/7d8587b8342ee2cbe226fb691b372ac7df5fdb71.1745390030.git.nirjhar.roy.lists@gmail.com/

--NR

>
>> --NR
>>
>>> Thanks,
>>> Zorro
>>>
>>>> --NR
>>>>
>>>>> Thanks,
>>>>> Zorro
>>>>>
>>>>>>     13 files changed, 63 insertions(+), 52 deletions(-)
>>>>>>     create mode 100644 common/exit
>>>>>>
>>>>>> diff --git a/check b/check
>>>>>> index 9451c350..67355c52 100755
>>>>>> --- a/check
>>>>>> +++ b/check
>>>>>> @@ -51,6 +51,7 @@ rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>>>>>>     SRC_GROUPS="generic"
>>>>>>     export SRC_DIR="tests"
>>>>>> +. common/exit
>>>>>>     usage()
>>>>>>     {
>>>>>> diff --git a/common/btrfs b/common/btrfs
>>>>>> index 3725632c..9e91ee71 100644
>>>>>> --- a/common/btrfs
>>>>>> +++ b/common/btrfs
>>>>>> @@ -1,7 +1,7 @@
>>>>>>     #
>>>>>>     # Common btrfs specific functions
>>>>>>     #
>>>>>> -
>>>>>> +. common/exit
>>>>>>     . common/module
>>>>>>     # The recommended way to execute simple "btrfs" command.
>>>>>> diff --git a/common/ceph b/common/ceph
>>>>>> index df7a6814..89e36403 100644
>>>>>> --- a/common/ceph
>>>>>> +++ b/common/ceph
>>>>>> @@ -2,6 +2,8 @@
>>>>>>     # CephFS specific common functions.
>>>>>>     #
>>>>>> +. common/exit
>>>>>> +
>>>>>>     # _ceph_create_file_layout <filename> <stripe unit> <stripe count> <object size>
>>>>>>     # This function creates a new empty file and sets the file layout according to
>>>>>>     # parameters.  It will exit if the file already exists.
>>>>>> diff --git a/common/config b/common/config
>>>>>> index eada3971..6a60d144 100644
>>>>>> --- a/common/config
>>>>>> +++ b/common/config
>>>>>> @@ -38,7 +38,7 @@
>>>>>>     # - this script shouldn't make any assertions about filesystem
>>>>>>     #   validity or mountedness.
>>>>>>     #
>>>>>> -
>>>>>> +. common/exit
>>>>>>     . common/test_names
>>>>>>     # all tests should use a common language setting to prevent golden
>>>>>> @@ -96,15 +96,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>>>>>>     export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>>>>>> -# This functions sets the exit code to status and then exits. Don't use
>>>>>> -# exit directly, as it might not set the value of "$status" correctly, which is
>>>>>> -# used as an exit code in the trap handler routine set up by the check script.
>>>>>> -_exit()
>>>>>> -{
>>>>>> -	test -n "$1" && status="$1"
>>>>>> -	exit "$status"
>>>>>> -}
>>>>>> -
>>>>>>     # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>>>>>>     set_mkfs_prog_path_with_opts()
>>>>>>     {
>>>>>> @@ -121,12 +112,6 @@ set_mkfs_prog_path_with_opts()
>>>>>>     	fi
>>>>>>     }
>>>>>> -_fatal()
>>>>>> -{
>>>>>> -    echo "$*"
>>>>>> -    _exit 1
>>>>>> -}
>>>>>> -
>>>>>>     export MKFS_PROG="$(type -P mkfs)"
>>>>>>     [ "$MKFS_PROG" = "" ] && _fatal "mkfs not found"
>>>>>> diff --git a/common/dump b/common/dump
>>>>>> index 09859006..4701a956 100644
>>>>>> --- a/common/dump
>>>>>> +++ b/common/dump
>>>>>> @@ -3,6 +3,7 @@
>>>>>>     # Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.  All Rights Reserved.
>>>>>>     #
>>>>>>     # Functions useful for xfsdump/xfsrestore tests
>>>>>> +. common/exit
>>>>>>     # --- initializations ---
>>>>>>     rm -f $seqres.full
>>>>>> diff --git a/common/exit b/common/exit
>>>>>> new file mode 100644
>>>>>> index 00000000..ad7e7498
>>>>>> --- /dev/null
>>>>>> +++ b/common/exit
>>>>>> @@ -0,0 +1,50 @@
>>>>>> +##/bin/bash
>>>>>> +
>>>>>> +# This functions sets the exit code to status and then exits. Don't use
>>>>>> +# exit directly, as it might not set the value of "$status" correctly, which is
>>>>>> +# used as an exit code in the trap handler routine set up by the check script.
>>>>>> +_exit()
>>>>>> +{
>>>>>> +	test -n "$1" && status="$1"
>>>>>> +	exit "$status"
>>>>>> +}
>>>>>> +
>>>>>> +_fatal()
>>>>>> +{
>>>>>> +    echo "$*"
>>>>>> +    _exit 1
>>>>>> +}
>>>>>> +
>>>>>> +_die()
>>>>>> +{
>>>>>> +        echo $@
>>>>>> +        _exit 1
>>>>>> +}
>>>>>> +
>>>>>> +die_now()
>>>>>> +{
>>>>>> +	_exit 1
>>>>>> +}
>>>>>> +
>>>>>> +# just plain bail out
>>>>>> +#
>>>>>> +_fail()
>>>>>> +{
>>>>>> +    echo "$*" | tee -a $seqres.full
>>>>>> +    echo "(see $seqres.full for details)"
>>>>>> +    _exit 1
>>>>>> +}
>>>>>> +
>>>>>> +# bail out, setting up .notrun file. Need to kill the filesystem check files
>>>>>> +# here, otherwise they are set incorrectly for the next test.
>>>>>> +#
>>>>>> +_notrun()
>>>>>> +{
>>>>>> +    echo "$*" > $seqres.notrun
>>>>>> +    echo "$seq not run: $*"
>>>>>> +    rm -f ${RESULT_DIR}/require_test*
>>>>>> +    rm -f ${RESULT_DIR}/require_scratch*
>>>>>> +
>>>>>> +    _exit 0
>>>>>> +}
>>>>>> +
>>>>>> diff --git a/common/ext4 b/common/ext4
>>>>>> index f88fa532..ab566c41 100644
>>>>>> --- a/common/ext4
>>>>>> +++ b/common/ext4
>>>>>> @@ -1,7 +1,7 @@
>>>>>>     #
>>>>>>     # ext4 specific common functions
>>>>>>     #
>>>>>> -
>>>>>> +. common/exit
>>>>>>     __generate_ext4_report_vars() {
>>>>>>     	__generate_blockdev_report_vars TEST_LOGDEV
>>>>>>     	__generate_blockdev_report_vars SCRATCH_LOGDEV
>>>>>> diff --git a/common/populate b/common/populate
>>>>>> index 50dc75d3..a17acc9e 100644
>>>>>> --- a/common/populate
>>>>>> +++ b/common/populate
>>>>>> @@ -4,7 +4,7 @@
>>>>>>     #
>>>>>>     # Routines for populating a scratch fs, and helpers to exercise an FS
>>>>>>     # once it's been fuzzed.
>>>>>> -
>>>>>> +. common/exit
>>>>>>     . ./common/quota
>>>>>>     _require_populate_commands() {
>>>>>> diff --git a/common/preamble b/common/preamble
>>>>>> index ba029a34..0f306412 100644
>>>>>> --- a/common/preamble
>>>>>> +++ b/common/preamble
>>>>>> @@ -3,6 +3,7 @@
>>>>>>     # Copyright (c) 2021 Oracle.  All Rights Reserved.
>>>>>>     # Boilerplate fstests functionality
>>>>>> +. common/exit
>>>>>>     # Standard cleanup function.  Individual tests can override this.
>>>>>>     _cleanup()
>>>>>> diff --git a/common/punch b/common/punch
>>>>>> index 64d665d8..637f463f 100644
>>>>>> --- a/common/punch
>>>>>> +++ b/common/punch
>>>>>> @@ -3,6 +3,7 @@
>>>>>>     # Copyright (c) 2007 Silicon Graphics, Inc.  All Rights Reserved.
>>>>>>     #
>>>>>>     # common functions for excersizing hole punches with extent size hints etc.
>>>>>> +. common/exit
>>>>>>     _spawn_test_file() {
>>>>>>     	echo "# spawning test file with $*"
>>>>>> @@ -222,11 +223,6 @@ _filter_bmap()
>>>>>>     	_coalesce_extents
>>>>>>     }
>>>>>> -die_now()
>>>>>> -{
>>>>>> -	_exit 1
>>>>>> -}
>>>>>> -
>>>>>>     # test the different corner cases for zeroing a range:
>>>>>>     #
>>>>>>     #	1. into a hole
>>>>>> diff --git a/common/rc b/common/rc
>>>>>> index 9bed6dad..945f5134 100644
>>>>>> --- a/common/rc
>>>>>> +++ b/common/rc
>>>>>> @@ -2,6 +2,7 @@
>>>>>>     # SPDX-License-Identifier: GPL-2.0+
>>>>>>     # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
>>>>>> +. common/exit
>>>>>>     . common/config
>>>>>>     BC="$(type -P bc)" || BC=
>>>>>> @@ -1798,28 +1799,6 @@ _do()
>>>>>>         return $ret
>>>>>>     }
>>>>>> -# bail out, setting up .notrun file. Need to kill the filesystem check files
>>>>>> -# here, otherwise they are set incorrectly for the next test.
>>>>>> -#
>>>>>> -_notrun()
>>>>>> -{
>>>>>> -    echo "$*" > $seqres.notrun
>>>>>> -    echo "$seq not run: $*"
>>>>>> -    rm -f ${RESULT_DIR}/require_test*
>>>>>> -    rm -f ${RESULT_DIR}/require_scratch*
>>>>>> -
>>>>>> -    _exit 0
>>>>>> -}
>>>>>> -
>>>>>> -# just plain bail out
>>>>>> -#
>>>>>> -_fail()
>>>>>> -{
>>>>>> -    echo "$*" | tee -a $seqres.full
>>>>>> -    echo "(see $seqres.full for details)"
>>>>>> -    _exit 1
>>>>>> -}
>>>>>> -
>>>>>>     #
>>>>>>     # Tests whether $FSTYP should be exclude from this test.
>>>>>>     #
>>>>>> @@ -3835,12 +3814,6 @@ _link_out_file()
>>>>>>     	_link_out_file_named $seqfull.out "$features"
>>>>>>     }
>>>>>> -_die()
>>>>>> -{
>>>>>> -        echo $@
>>>>>> -        _exit 1
>>>>>> -}
>>>>>> -
>>>>>>     # convert urandom incompressible data to compressible text data
>>>>>>     _ddt()
>>>>>>     {
>>>>>> diff --git a/common/repair b/common/repair
>>>>>> index fd206f8e..db6a1b5c 100644
>>>>>> --- a/common/repair
>>>>>> +++ b/common/repair
>>>>>> @@ -3,6 +3,7 @@
>>>>>>     # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
>>>>>>     #
>>>>>>     # Functions useful for xfs_repair tests
>>>>>> +. common/exit
>>>>>>     _zero_position()
>>>>>>     {
>>>>>> diff --git a/common/xfs b/common/xfs
>>>>>> index 96c15f3c..c236146c 100644
>>>>>> --- a/common/xfs
>>>>>> +++ b/common/xfs
>>>>>> @@ -1,6 +1,7 @@
>>>>>>     #
>>>>>>     # XFS specific common functions.
>>>>>>     #
>>>>>> +. common/exit
>>>>>>     __generate_xfs_report_vars() {
>>>>>>     	__generate_blockdev_report_vars TEST_RTDEV
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
>>>> -- 
>>>> Nirjhar Roy
>>>> Linux Kernel Developer
>>>> IBM, Bangalore
>>>>
>> -- 
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


