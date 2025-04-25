Return-Path: <linux-ext4+bounces-7493-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA00A9C88A
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Apr 2025 14:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C621BC0736
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Apr 2025 12:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18116248891;
	Fri, 25 Apr 2025 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uoty9CIW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F1248176;
	Fri, 25 Apr 2025 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582612; cv=none; b=aD8eEmpUo/ISXVU+ZPlC2KZ1xvdDVujFPxbmdyhBnOJE5OMa4yklhVfEIyVRJ458QKgDIy7ZO8Pjhiu2fM9aWdDtuMuGtRwDoHzK4zavNLjerMsp3QerJYgGZv01j/O8z+HZAXIUBVI/n5atLt7gm48CxKT7CIDFsa4QOPKMGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582612; c=relaxed/simple;
	bh=suWyjNOnQv62iGYEg2h2y4r4lleBKD0a11M5/8UnTC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sI4vtNGlJu1xY8kdIsoBezzgbVbmvCxs6FLBfhEd8U9V2b5F3y2FOMH4f5jHxiD6+vSZqsL2RN3nuZNICnGWcE4sKKh5wdYf9xqXkjFqxeF9DoFvciz6VWQ0idhv4bxFTqkYYt4XHkq4IWoXJH7KjWb9wj44uoBX6+c8freiy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uoty9CIW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224171d6826so33928895ad.3;
        Fri, 25 Apr 2025 05:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745582610; x=1746187410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUOed1AViqWYDq7OJ76sc7eZ98x3xbN19MeMYRNZKmQ=;
        b=Uoty9CIWgG7xA67LYD+tVVZ/U5t8BzYinA9WzeUpf6OnYpoAttH1ZnlOw4RiAltZOW
         xwzgVSlHu/khnQeL1LgwmKObPziYzfp1qdhhRf6GzoGakC6dQIivO6fSo5txcVMBgOZ2
         qutAcvl02TxrfV/U7KnY8YiwU2DpY00xVymH3EadZHThcdpmPGUaBuP96gbGtk6msSzn
         xIr7+vuOfdx3foo+CfLp+lJ9/4N/Jx4jBzpEgWPw2cA8GE+ka0NdBAjcbHrZWm0aYVZZ
         OLIoToEN/Zo5Od7Bdg67prda6V3THBAqd74FacW0uYjMQoyhnVxVcXQVAoT8tRmMyQ4Y
         Ma/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745582610; x=1746187410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUOed1AViqWYDq7OJ76sc7eZ98x3xbN19MeMYRNZKmQ=;
        b=kRxdX7uhImHTF9eCypKOoJ/2CBrRwgifSwERJqaxLpff3MD7+yvj//Jk+RsJpQcRiK
         ddsZWTVr12jIDM5dUkcwrPEmZQam0mh0u3jRMNuGMiXezkEpwtyfWE98YyGAEMk6deMQ
         gJt/zbajPZ4H4IibW/psXDtSzDFQujCffWz+symhr8kIYWppG5WEHmCt8dGtdGtGsYCH
         ADKRne+bZJiNijWqL4Q1P/b0teRC8+n2mCebCKV2KJ5WcmQER9wHEj1x9H/ngb5L27oS
         JoZfPtF0t+an/D4E0Z4NfdUAoHc83CTPoFiYJlhqRofp/AbkpvVeZce+hdqOH2ti2c47
         mPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq+WFp1SEYQ5+5TWv3CqTBKhL4cXiq5C4idjL4q0P+yRFUqQCbdaundQ36/zsECuyVR/buq1Jw6rA2@vger.kernel.org, AJvYcCXdeY5ZwTc5Kjwkwj6HaMwCbxsrQshZJr7eWC7KruMf1nPk71I0gPv1O9bTAUD0SSPwtY6mcGVCK2xE@vger.kernel.org
X-Gm-Message-State: AOJu0YxFAnTuvl2R4h0ZDBhcCEFCVbn7xWwg2WbExbR/m07D/Mb7bW02
	Oe1mfbiiY26XoX4y7RwPLBHA3n0PGPW1agsw6Y2PWP3tLeviQ4CPS0Owcw==
X-Gm-Gg: ASbGncvM/jbfCjDUJmN3xoFzJKgN3P0ILfmLNbiUHrCZ7Vn3nir6sy/5PKrQDPZBpRJ
	aT7uA/RQwEY3EeMmClYIf+p6B5hiyiz0sCMRDGdwDmZmnxCAWmhli+HZLPPy0DyAJRfUCZppG+9
	7C3T8XaAP4NyWnoKzihl9lX5UHX7xkQig066LWqFbWcUn0x0NjaeIKop77FR9b8LTZbsz3p0mSz
	65MRzt8O93PD6NRfO7Mxv2tn4C19wznkVFNqWFc1Q+owiLLWrMGq2fqXroPggPBy4b4wEAN1spy
	0DwBsDgOt8VCoKuHDu3VWEVFQZRcE/XmiI2GP+h1SEcbZZ0JQzs=
X-Google-Smtp-Source: AGHT+IGu4W6Di8yvfAgJCcTnCpIpJE+FQP8MqTvWcylSwb6tGR+nkn+dF3WBNWqFSbiI1r3K4nl7pQ==
X-Received: by 2002:a17:903:1b25:b0:22c:33b2:e420 with SMTP id d9443c01a7336-22dbf4dd940mr27895245ad.7.1745582610051;
        Fri, 25 Apr 2025 05:03:30 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d77368sm30286255ad.46.2025.04.25.05.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 05:03:29 -0700 (PDT)
Message-ID: <175d064b-76a5-4ff8-a34f-358f0e0d6baa@gmail.com>
Date: Fri, 25 Apr 2025 17:33:24 +0530
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
 <054fa772-360e-4f90-bc4d-ea7ef954d5a2@gmail.com>
 <20250425112745.aaamjdvhqtlx7vpd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250425112745.aaamjdvhqtlx7vpd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/25/25 16:57, Zorro Lang wrote:
> On Thu, Apr 24, 2025 at 02:39:39PM +0530, Nirjhar Roy (IBM) wrote:
>> On 4/23/25 19:48, Zorro Lang wrote:
>>> On Wed, Apr 23, 2025 at 06:41:34AM +0000, Nirjhar Roy (IBM) wrote:
>>>> Introduce a new file common/exit that will contain all the exit
>>>> related functions. This will remove the dependencies these functions
>>>> have on other non-related helper files and they can be indepedently
>>>> sourced. This was suggested by Dave Chinner[1].
>>>>
>>>> [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
>>>> Suggested-by: Dave Chinner <david@fromorbit.com>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> ---
>>>>    check           |  1 +
>>>>    common/btrfs    |  2 +-
>>>>    common/ceph     |  2 ++
>>>>    common/config   | 17 +----------------
>>>>    common/dump     |  1 +
>>>>    common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    common/ext4     |  2 +-
>>>>    common/populate |  2 +-
>>>>    common/preamble |  1 +
>>>>    common/punch    |  6 +-----
>>>>    common/rc       | 29 +---------------------------
>>>>    common/repair   |  1 +
>>>>    common/xfs      |  1 +
>>> I think if you define exit helpers in common/exit, and import common/exit
>>> in common/config, then you don't need to source it(common/exit) in other
>>> common files (.e.g common/xfs, common/rc, etc). Due to when we call the
>>> helpers in these common files, the process should already imported
>>> common/rc -> common/config -> common/exit. right?
>> Oh, right. I can remove the redundant imports from
>> common/{btrfs,ceph,dump,ext4,populate,preamble,punch,rc,repair,xfs} in v2. I
>> will keep ". common/exit" only in common/config and check. The reason for me
>> to keep it in check is that before common/rc is sourced in check, we might
>> need _exit() (which is present is common/exit). Do you agree?
> I thought "check" might not need that either. I didn't give it a test, but I found
> before importing common/rc, there're only command arguments initialization, and
> "check" calls "exit" directly if the initialization fails (except you want to call
> _exit, but I didn't see you change that).

Yes, I have changed the exit() to _exit() in "check" in the next patch 
[1] of this series. Can you please take a look at that patch[1] and 
suggest whether I should have ". common/exit" in "check" or not?


[1] 
https://lore.kernel.org/all/7d8587b8342ee2cbe226fb691b372ac7df5fdb71.1745390030.git.nirjhar.roy.lists@gmail.com/

--NR

>
> Thanks,
> Zorro
>
>> --NR
>>
>>> Thanks,
>>> Zorro
>>>
>>>>    13 files changed, 63 insertions(+), 52 deletions(-)
>>>>    create mode 100644 common/exit
>>>>
>>>> diff --git a/check b/check
>>>> index 9451c350..67355c52 100755
>>>> --- a/check
>>>> +++ b/check
>>>> @@ -51,6 +51,7 @@ rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>>>>    SRC_GROUPS="generic"
>>>>    export SRC_DIR="tests"
>>>> +. common/exit
>>>>    usage()
>>>>    {
>>>> diff --git a/common/btrfs b/common/btrfs
>>>> index 3725632c..9e91ee71 100644
>>>> --- a/common/btrfs
>>>> +++ b/common/btrfs
>>>> @@ -1,7 +1,7 @@
>>>>    #
>>>>    # Common btrfs specific functions
>>>>    #
>>>> -
>>>> +. common/exit
>>>>    . common/module
>>>>    # The recommended way to execute simple "btrfs" command.
>>>> diff --git a/common/ceph b/common/ceph
>>>> index df7a6814..89e36403 100644
>>>> --- a/common/ceph
>>>> +++ b/common/ceph
>>>> @@ -2,6 +2,8 @@
>>>>    # CephFS specific common functions.
>>>>    #
>>>> +. common/exit
>>>> +
>>>>    # _ceph_create_file_layout <filename> <stripe unit> <stripe count> <object size>
>>>>    # This function creates a new empty file and sets the file layout according to
>>>>    # parameters.  It will exit if the file already exists.
>>>> diff --git a/common/config b/common/config
>>>> index eada3971..6a60d144 100644
>>>> --- a/common/config
>>>> +++ b/common/config
>>>> @@ -38,7 +38,7 @@
>>>>    # - this script shouldn't make any assertions about filesystem
>>>>    #   validity or mountedness.
>>>>    #
>>>> -
>>>> +. common/exit
>>>>    . common/test_names
>>>>    # all tests should use a common language setting to prevent golden
>>>> @@ -96,15 +96,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>>>>    export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>>>> -# This functions sets the exit code to status and then exits. Don't use
>>>> -# exit directly, as it might not set the value of "$status" correctly, which is
>>>> -# used as an exit code in the trap handler routine set up by the check script.
>>>> -_exit()
>>>> -{
>>>> -	test -n "$1" && status="$1"
>>>> -	exit "$status"
>>>> -}
>>>> -
>>>>    # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>>>>    set_mkfs_prog_path_with_opts()
>>>>    {
>>>> @@ -121,12 +112,6 @@ set_mkfs_prog_path_with_opts()
>>>>    	fi
>>>>    }
>>>> -_fatal()
>>>> -{
>>>> -    echo "$*"
>>>> -    _exit 1
>>>> -}
>>>> -
>>>>    export MKFS_PROG="$(type -P mkfs)"
>>>>    [ "$MKFS_PROG" = "" ] && _fatal "mkfs not found"
>>>> diff --git a/common/dump b/common/dump
>>>> index 09859006..4701a956 100644
>>>> --- a/common/dump
>>>> +++ b/common/dump
>>>> @@ -3,6 +3,7 @@
>>>>    # Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.  All Rights Reserved.
>>>>    #
>>>>    # Functions useful for xfsdump/xfsrestore tests
>>>> +. common/exit
>>>>    # --- initializations ---
>>>>    rm -f $seqres.full
>>>> diff --git a/common/exit b/common/exit
>>>> new file mode 100644
>>>> index 00000000..ad7e7498
>>>> --- /dev/null
>>>> +++ b/common/exit
>>>> @@ -0,0 +1,50 @@
>>>> +##/bin/bash
>>>> +
>>>> +# This functions sets the exit code to status and then exits. Don't use
>>>> +# exit directly, as it might not set the value of "$status" correctly, which is
>>>> +# used as an exit code in the trap handler routine set up by the check script.
>>>> +_exit()
>>>> +{
>>>> +	test -n "$1" && status="$1"
>>>> +	exit "$status"
>>>> +}
>>>> +
>>>> +_fatal()
>>>> +{
>>>> +    echo "$*"
>>>> +    _exit 1
>>>> +}
>>>> +
>>>> +_die()
>>>> +{
>>>> +        echo $@
>>>> +        _exit 1
>>>> +}
>>>> +
>>>> +die_now()
>>>> +{
>>>> +	_exit 1
>>>> +}
>>>> +
>>>> +# just plain bail out
>>>> +#
>>>> +_fail()
>>>> +{
>>>> +    echo "$*" | tee -a $seqres.full
>>>> +    echo "(see $seqres.full for details)"
>>>> +    _exit 1
>>>> +}
>>>> +
>>>> +# bail out, setting up .notrun file. Need to kill the filesystem check files
>>>> +# here, otherwise they are set incorrectly for the next test.
>>>> +#
>>>> +_notrun()
>>>> +{
>>>> +    echo "$*" > $seqres.notrun
>>>> +    echo "$seq not run: $*"
>>>> +    rm -f ${RESULT_DIR}/require_test*
>>>> +    rm -f ${RESULT_DIR}/require_scratch*
>>>> +
>>>> +    _exit 0
>>>> +}
>>>> +
>>>> diff --git a/common/ext4 b/common/ext4
>>>> index f88fa532..ab566c41 100644
>>>> --- a/common/ext4
>>>> +++ b/common/ext4
>>>> @@ -1,7 +1,7 @@
>>>>    #
>>>>    # ext4 specific common functions
>>>>    #
>>>> -
>>>> +. common/exit
>>>>    __generate_ext4_report_vars() {
>>>>    	__generate_blockdev_report_vars TEST_LOGDEV
>>>>    	__generate_blockdev_report_vars SCRATCH_LOGDEV
>>>> diff --git a/common/populate b/common/populate
>>>> index 50dc75d3..a17acc9e 100644
>>>> --- a/common/populate
>>>> +++ b/common/populate
>>>> @@ -4,7 +4,7 @@
>>>>    #
>>>>    # Routines for populating a scratch fs, and helpers to exercise an FS
>>>>    # once it's been fuzzed.
>>>> -
>>>> +. common/exit
>>>>    . ./common/quota
>>>>    _require_populate_commands() {
>>>> diff --git a/common/preamble b/common/preamble
>>>> index ba029a34..0f306412 100644
>>>> --- a/common/preamble
>>>> +++ b/common/preamble
>>>> @@ -3,6 +3,7 @@
>>>>    # Copyright (c) 2021 Oracle.  All Rights Reserved.
>>>>    # Boilerplate fstests functionality
>>>> +. common/exit
>>>>    # Standard cleanup function.  Individual tests can override this.
>>>>    _cleanup()
>>>> diff --git a/common/punch b/common/punch
>>>> index 64d665d8..637f463f 100644
>>>> --- a/common/punch
>>>> +++ b/common/punch
>>>> @@ -3,6 +3,7 @@
>>>>    # Copyright (c) 2007 Silicon Graphics, Inc.  All Rights Reserved.
>>>>    #
>>>>    # common functions for excersizing hole punches with extent size hints etc.
>>>> +. common/exit
>>>>    _spawn_test_file() {
>>>>    	echo "# spawning test file with $*"
>>>> @@ -222,11 +223,6 @@ _filter_bmap()
>>>>    	_coalesce_extents
>>>>    }
>>>> -die_now()
>>>> -{
>>>> -	_exit 1
>>>> -}
>>>> -
>>>>    # test the different corner cases for zeroing a range:
>>>>    #
>>>>    #	1. into a hole
>>>> diff --git a/common/rc b/common/rc
>>>> index 9bed6dad..945f5134 100644
>>>> --- a/common/rc
>>>> +++ b/common/rc
>>>> @@ -2,6 +2,7 @@
>>>>    # SPDX-License-Identifier: GPL-2.0+
>>>>    # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
>>>> +. common/exit
>>>>    . common/config
>>>>    BC="$(type -P bc)" || BC=
>>>> @@ -1798,28 +1799,6 @@ _do()
>>>>        return $ret
>>>>    }
>>>> -# bail out, setting up .notrun file. Need to kill the filesystem check files
>>>> -# here, otherwise they are set incorrectly for the next test.
>>>> -#
>>>> -_notrun()
>>>> -{
>>>> -    echo "$*" > $seqres.notrun
>>>> -    echo "$seq not run: $*"
>>>> -    rm -f ${RESULT_DIR}/require_test*
>>>> -    rm -f ${RESULT_DIR}/require_scratch*
>>>> -
>>>> -    _exit 0
>>>> -}
>>>> -
>>>> -# just plain bail out
>>>> -#
>>>> -_fail()
>>>> -{
>>>> -    echo "$*" | tee -a $seqres.full
>>>> -    echo "(see $seqres.full for details)"
>>>> -    _exit 1
>>>> -}
>>>> -
>>>>    #
>>>>    # Tests whether $FSTYP should be exclude from this test.
>>>>    #
>>>> @@ -3835,12 +3814,6 @@ _link_out_file()
>>>>    	_link_out_file_named $seqfull.out "$features"
>>>>    }
>>>> -_die()
>>>> -{
>>>> -        echo $@
>>>> -        _exit 1
>>>> -}
>>>> -
>>>>    # convert urandom incompressible data to compressible text data
>>>>    _ddt()
>>>>    {
>>>> diff --git a/common/repair b/common/repair
>>>> index fd206f8e..db6a1b5c 100644
>>>> --- a/common/repair
>>>> +++ b/common/repair
>>>> @@ -3,6 +3,7 @@
>>>>    # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
>>>>    #
>>>>    # Functions useful for xfs_repair tests
>>>> +. common/exit
>>>>    _zero_position()
>>>>    {
>>>> diff --git a/common/xfs b/common/xfs
>>>> index 96c15f3c..c236146c 100644
>>>> --- a/common/xfs
>>>> +++ b/common/xfs
>>>> @@ -1,6 +1,7 @@
>>>>    #
>>>>    # XFS specific common functions.
>>>>    #
>>>> +. common/exit
>>>>    __generate_xfs_report_vars() {
>>>>    	__generate_blockdev_report_vars TEST_RTDEV
>>>> -- 
>>>> 2.34.1
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


