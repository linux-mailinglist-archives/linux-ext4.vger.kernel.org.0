Return-Path: <linux-ext4+bounces-6107-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D419BA118C3
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 06:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F3D168201
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 05:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F3D22E40E;
	Wed, 15 Jan 2025 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA4Pxmwd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD887232423;
	Wed, 15 Jan 2025 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917829; cv=none; b=gbQKybu6pvJtJD+AX95NfXHifNzunTm/7rrHZZ1EV6AR1Kgfhm+z+Dywj7tObCSF7+ARgRHOHh76wrgeUX4qi49mVqtyo+kszs3eCrvAqQqYz8Tz9PyQcGbAWjirhqbXLwIALiqZdqjNKqeO+sVaXKJOMfdjv5FMWP5RkE8cZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917829; c=relaxed/simple;
	bh=BSuMZCsoOzKQMEMZkJMQX4MYaNfIMPSWU01+73erjRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFdppRw5T3SuqFuQzH0u6IQyX+4blssp3+w4Ix3+7YDFg3GxRfVTG+ikhhucHNrS2Gr50YJwYYW0X10mzSFUIsxGsHYE3KML9JwJ/fK6TsOnbpC8tv+OlXKRYDpUDbEBtmBGGD+87dhUff0bG2odkBZ0XL+T0ocev56kQXm/Roo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NA4Pxmwd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163b0c09afso115569015ad.0;
        Tue, 14 Jan 2025 21:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736917827; x=1737522627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jm30nj/PYoQLVtdxXBWVFAXbI2tSvP8CATKJm9etVC8=;
        b=NA4PxmwdKvmXtrWulIAVvtm+uF7G2UrQSwxdW1d5n79cwjViV7zKcJ3h1qhfca22Aw
         fEKc6PfLri0GHtf5oW0QQ0VyqAufkn0tsYQsq/LqfWl8UrQ/HD++imWz1Bkdep/2lLPL
         /gvOV0M3odgEKQNRSKwlXfmX6xoH4csgFH+kdgqxTdGR4jf1GJiK9WvwMzVE59D1M4i+
         K1edmhvS9xjYXavKU1bcaaa9vqRHSCqGwnwxciU+eju84Qf4e41RkjCiCs41NTRzWb9Y
         +sYzVzY2Gxt9pjzUZJxeB9tolPdbkFmIoWb8FmDeqte1sv4jjhwy9u6pTZBCtk869KCl
         lwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736917827; x=1737522627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm30nj/PYoQLVtdxXBWVFAXbI2tSvP8CATKJm9etVC8=;
        b=WvYxpC+72SVWqO5CFQPsjWN0UaTN4gxqOl7uylU5AAZBBS63IfXl0RuRTbzJaE9Ayq
         pQm5vhmuSnDQwZ4X2UvwbN2BIK2aBycj5yri25wN9t242+2DxtQ3lWeXplSi0dwLSM5n
         8/AowdlDTE8zYCQEsiTnJQxGE9aDUTaxQAzI5kOwj8+DZ4wC6Q+2rQ402/PpJCrLU0Uj
         e4lijDq8+7petiEo7nWubyiaR2+xvUlVjO2Uh3xg5oIPWpgSWaFazCXr4OcvLdsw/TSX
         mV6khDzZ1qd7rG14dBxp6vcvKi8soo+71RqSN4PiW7iDdJJnmcrPtMco2ItO3fvLWhXU
         S/lw==
X-Forwarded-Encrypted: i=1; AJvYcCUBhpXiJob0BNzU4kIkhQ1TY0bbOOn3N6h5QQQQ1U/Mlz81uvsGp4g5Pl1gxfZB70sBkrse93CyFpT3@vger.kernel.org, AJvYcCUNJ+eORUE15yJ01i+dKVFJ7kGMIVFl3+HfzLKBcnTLAgbEEbK8GVBrxfZOCH6shLL+/s16dS0tXGx9@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCiw8uYuKmWKMSvOeUXWfgW90BGo5gj0a+HWYAdOplkMcJtRk
	zZIU5y39PFU+nO3eL37BrZ1iWc9Ptfw8uoVxyMa67eklyDWFlWiA
X-Gm-Gg: ASbGnctwCecWMhXvWxmDBUKU2ncdWF8kjHUrJSDCdJ+BsNXj3ZxUu0LAHN33Oybytmi
	fEJV0P6rdX+bDgXEReOj5peog3p7qd4PrMfdq+AFF16iQvZqjnM4utQmm+NY4V/08mlUB4a6Rm4
	YdLbwf0J+Z376NDC9afnnZ4s4gqMnWYi6yrlcszv1qhPeBhMBGnj4WTWXZ1EIewmeRMqgaAozon
	04ECgB7b58gX6tl1Dn805+YrvCA/ozro5lVRiX4ktMFX+pNhNlcybiLHB/7T6N7cMo=
X-Google-Smtp-Source: AGHT+IEiJgsCu/Q3rdGyT0BghL8+D1RYTCTSOSRl8nvOHv9f1ec6okKY2kTAvSj1RElobdlvwn+Jmg==
X-Received: by 2002:a17:902:dac6:b0:215:b058:289c with SMTP id d9443c01a7336-21a83f339f2mr391905345ad.8.1736917826961;
        Tue, 14 Jan 2025 21:10:26 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10dddfsm75599195ad.23.2025.01.14.21.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:10:26 -0800 (PST)
Message-ID: <9c6f6f09-d80a-450d-9a41-47de4d88469a@gmail.com>
Date: Wed, 15 Jan 2025 10:40:22 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org
References: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com>
 <20250113055901.u5e5ghzi3t45hdha@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <4afe80a4-ac6b-4796-b466-c42a95f7225a@gmail.com>
 <20250113131103.tb25jtgkepw4xreo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <87h662vici.fsf@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <87h662vici.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/13/25 21:03, Ritesh Harjani (IBM) wrote:
> Zorro Lang <zlang@redhat.com> writes:
>
>> On Mon, Jan 13, 2025 at 02:22:20PM +0530, Nirjhar Roy (IBM) wrote:
>>> On 1/13/25 11:29, Zorro Lang wrote:
>>>> On Sun, Jan 12, 2025 at 03:21:51PM +0000, Nirjhar Roy (IBM) wrote:
>>>>> Bug Description:
>>>>>
>>>>> _test_mount function is failing with the following error:
>>>>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
>>>>> check: failed to mount /dev/loop0 on /mnt1/test
>>>>>
>>>>> when the second section in local.config file is xfs and the first section
>>>>> is non-xfs.
>>>>>
>>>>> It can be easily reproduced with the following local.config file
>>>>>
>>>>> [s2]
>>>>> export FSTYP=ext4
>>>>> export TEST_DEV=/dev/loop0
>>>>> export TEST_DIR=/mnt1/test
>>>>> export SCRATCH_DEV=/dev/loop1
>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>
>>>>> [s1]
>>>>> export FSTYP=xfs
>>>>> export TEST_DEV=/dev/loop0
>>>>> export TEST_DIR=/mnt1/test
>>>>> export SCRATCH_DEV=/dev/loop1
>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>
>>>>> ./check selftest/001
>>>>>
>>>>> Root cause:
>>>>> When _test_mount() is executed for the second section, the FSTYPE has
>>>>> already changed but the new fs specific common/$FSTYP has not yet
>>>>> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>>>>> the test run fails.
>>>>>
>>>>> Fix:
>>>>> call _source_specific_fs $FSTYP at the correct call site of  _test_mount()
>>>>>
>>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>>> ---
>>>>>    check | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/check b/check
>>>>> index 607d2456..8cdbb68f 100755
>>>>> --- a/check
>>>>> +++ b/check
>>>>> @@ -776,6 +776,7 @@ function run_section()
>>>>>    	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>>>>    		echo "RECREATING    -- $FSTYP on $TEST_DEV"
>>>>>    		_test_unmount 2> /dev/null
>>>>> +		[[ "$OLD_FSTYP" != "$FSTYP" ]] && _source_specific_fs $FSTYP
>>>> The _source_specific_fs is called when importing common/rc file:
>>>>
>>>>     # check for correct setup and source the $FSTYP specific functions now
>>>>     _source_specific_fs $FSTYP
>>>>
>>>>   From the code logic of check script:
>>>>
>>>>           if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>>>                   echo "RECREATING    -- $FSTYP on $TEST_DEV"
>>>>                   _test_unmount 2> /dev/null
>>>>                   if ! _test_mkfs >$tmp.err 2>&1
>>>>                   then
>>>>                           echo "our local _test_mkfs routine ..."
>>>>                           cat $tmp.err
>>>>                           echo "check: failed to mkfs \$TEST_DEV using specified options"
>>>>                           status=1
>>>>                           exit
>>>>                   fi
>>>>                   if ! _test_mount
>>>>                   then
>>>>                           echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>>>                           status=1
>>>>                           exit
>>>>                   fi
>>>>                   # TEST_DEV has been recreated, previous FSTYP derived from
>>>>                   # TEST_DEV could be changed, source common/rc again with
>>>>                   # correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>>>>                   . common/rc
>>>>                   ^^^^^^^^^^^
>>>> we import common/rc at here.
>>>>
>>>> So I'm wondering if we can move this line upward, to fix the problem you
>>>> hit (and don't bring in regression :) Does that help?
>>>>
>>>> Thanks,
>>>> Zorro
>>> Okay so we can move ". common/rc" upward and then remove the following from
>>> "check" file:
>>>
>>>          if ! _test_mount
>>>          then
>>>              echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>>              status=1
>>>              exit
>>>          fi
>>>
>>> since . common/rc will call init_rc() in the end, which does a
>>> _test_mount(). Do you agree with this (Zorro and Ritesh)?
>>>
>>> I can make the changes and send a v2?
>> Hmm... the _init_rc doesn't do _test_mkfs,
> Yes, I had noticed that problem. So I felt sourcing fs specific file
> before _test_mkfs should be ok.
>
>> so you might need to do ". common/rc" after "_test_mkfs", rather than "_test_unmount".
>>
>> By checking the _init_rc, I think it can replace the _test_mount you metioned
>> above. Some details might need more testing, to make sure we didn't miss
>> anything wrong:)
> If moving . common/rc above _test_mount works, than that is a better
> approach than sourcing fs specific config file twice.

Yes, moving the ". common/rc" just after _test_mkfs and removing the 
_test_mount after fixes it the issue. I will do additional testing 
before sending a v2.

--NR

>
>
> -ritesh
>
>> Any review points from others?
>>
>> Thanks,
>> Zorro
>>
>>> --NR
>>>
>>>>
>>>>>    		if ! _test_mkfs >$tmp.err 2>&1
>>>>>    		then
>>>>>    			echo "our local _test_mkfs routine ..."
>>>>> -- 
>>>>> 2.34.1
>>>>>
>>>>>
>>> -- 
>>> Nirjhar Roy
>>> Linux Kernel Developer
>>> IBM, Bangalore
>>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


