Return-Path: <linux-ext4+bounces-6342-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD1BA2A031
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 06:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D171651D9
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 05:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478B22370A;
	Thu,  6 Feb 2025 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ztt+B5xW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D21FE45E;
	Thu,  6 Feb 2025 05:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820149; cv=none; b=O94Nm+G0HJgiGq0kD+r+n/+FbxVLRCzk1N7C89Gb39xeRcP2ZofjhQ68csKqP6D3WEKxmjKoTIevvbYTI9dCdY27V33UtavCk+Wod3BLrmJRm9YSYPevqGJti+vBmAhWYXjbgGqvC/fwH5p4S8BJcJpPNirBHl3ESVXWVhr8kLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820149; c=relaxed/simple;
	bh=BilhGVoyRvt1yPecuGqIkUJ6aQF2+GP4pzLYJe/XlBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANafEQb4f/+CUb12DkWJNeFoZtAHeY3SaAnFEkNhoPNyd8tHEKYWd8gKHvLXGq0mfhiHregB+dFhCn6+cfh9HhXP0N75QNBZfriSExW8N0/VqQLIQ2SvjM8IennCRoOySEsFJDTgWQXftHCIGnltOyQiJQlsK7FyXdiFc1F5Mdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ztt+B5xW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9c97af32eso645806a91.2;
        Wed, 05 Feb 2025 21:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738820147; x=1739424947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7w703HwqBgOWr79K15MCTaF81eL4ynHuX79DmzphP8=;
        b=Ztt+B5xWKp6aVIOv6IatV4XFxdAhdNIeK5Z7lTb3uDsUqRm7pwYRSGl4kJmfHMR7Y8
         AddITyaGsF99eOYR+x85K1uYgMoJhEjkB0aryHiHwFmt8Yrgk/QoQd/O6st/jQe43vZN
         xDbAlf2hEvf+wnhxZEGNyEgb2bEkt95f8WTPruZuItysaGMN54gTpFw3CzMaUq1gpU3k
         yOr7mM6HAGHAR+tevSv1dzqv5LBXJZCe2Ekv2Q6OH0oibOOJBdIV5A9ayrX4Uod8Yh38
         DbiC9Dto8D1UeEfuP8lA0RE98BR0AjW4tmxVCfHIii/FvGiQqtsQ96zkQcaafjP4E8L5
         53jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738820147; x=1739424947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7w703HwqBgOWr79K15MCTaF81eL4ynHuX79DmzphP8=;
        b=ETnBkggj94QPHR+BFpU2HVZUwB4gFdBHeJwLYjWcTT30Irdglf7zQXtaBLCOtpBwNl
         4ysRTab1FlGR3MRkXsyBMziixp2K4tkeOskDVBPuzCDJYYDatpiGgLnAFrJSYhyR0w+o
         jAgAFm1F3MnTyAEev/7EtNXACLXZfoYWvveuojQ6dEjofa/ORPqHmqmwX+cFRtttlKrc
         cuhxLvVq6/NIoC1XRDBzgIPw+8VDddJMiSCOqP2kdP3xjflwxOx7u5HizNweYeA3H7Ds
         +/fXY4zpBoNLccil0nD+hitQ1Bk+yHgKkjfUrz28TIF/0c2HFOnNVBeVHYam7YwoBCMO
         /rgA==
X-Forwarded-Encrypted: i=1; AJvYcCW3pw+aIVl7xyIORHrXiFyENd3ycOzLGLAvR6pleZygQ75tnjIT4L9GUgje0mL0kx7IVmdo04gw1crB@vger.kernel.org, AJvYcCWIO2nm1VplHCYMQhW8WtIcwt3AwuTfWLhToKUrTTQYy5JTPPLa6XJgOZuYDkdrr/FayJFDsfuf3AQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcMkbY2MykFWhb+37lBdadXWX4WKZd60wPjXOTGsJWXR7JyjH
	LefVERt/EjsI412Gi2a8WX+Q6QUX/B91eEAPtyAmAkOOguTQ0WUD7Cot9w==
X-Gm-Gg: ASbGnctQ0KYlpYSR8pXU1QbTrmEgizago/x36OsrHc+f+Jvxfot4Ir/ZqgFCEPEULIZ
	XDhKIEM/QOhAszm/pBfnE9NyUgJ1NLrtn9RL+pirIorovE92wgr18voqlYLlLJFI6LjPNCxVnBG
	xjoHxTzqY4F5/mpUABA8VmSHR1Nrxvby2hHpbemz3IY4DTogYLRmCvtBddzaNb9gf0FIfUJEwqd
	mrKD3k9bz3CBqk1TKyYKHuzRiMUhA2c/Wku2dv2dFnVc1QeM3rRpZQ0pXgxq37ZOWHNn4no/k4n
	sGCWHuxl52zUXOCCHpl/6w==
X-Google-Smtp-Source: AGHT+IF9srkCPHR0JEUraYhWLtRfQjVoi/whodT6kkzfR1dlXfzqzCS+r8Kc5wRzrJ3TGj9HSqnb3g==
X-Received: by 2002:a17:90b:38c3:b0:2ee:b2fe:eeee with SMTP id 98e67ed59e1d1-2f9e0792b60mr9419630a91.15.1738820147369;
        Wed, 05 Feb 2025 21:35:47 -0800 (PST)
Received: from [9.109.247.80] ([129.41.58.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a2743asm410124a91.18.2025.02.05.21.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 21:35:46 -0800 (PST)
Message-ID: <3599e504-8c2f-4196-9ce8-a4c458505888@gmail.com>
Date: Thu, 6 Feb 2025 11:05:42 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] check: Fix fs specfic imports when
 $FSTYPE!=$OLD_FSTYPE
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 zlang@kernel.org
References: <3b980d028a8ae1496c13ebe3a6685fbc472c5bc0.1738040386.git.nirjhar.roy.lists@gmail.com>
 <20250128180917.GA3561257@frogsfrogsfrogs>
 <f89b6b40-8dce-4378-ba56-cf7f29695bdb@gmail.com>
 <20250129160259.GT3557553@frogsfrogsfrogs>
 <dfbd2895-e29a-4e25-bbc6-a83826d14878@gmail.com>
 <20250131162457.GV1611770@frogsfrogsfrogs>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250131162457.GV1611770@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/31/25 21:54, Darrick J. Wong wrote:
> On Fri, Jan 31, 2025 at 06:49:50PM +0530, Nirjhar Roy (IBM) wrote:
>> On 1/29/25 21:32, Darrick J. Wong wrote:
>>> On Wed, Jan 29, 2025 at 04:48:10PM +0530, Nirjhar Roy (IBM) wrote:
>>>> On 1/28/25 23:39, Darrick J. Wong wrote:
>>>>> On Tue, Jan 28, 2025 at 05:00:22AM +0000, Nirjhar Roy (IBM) wrote:
>>>>>> Bug Description:
>>>>>>
>>>>>> _test_mount function is failing with the following error:
>>>>>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
>>>>>> check: failed to mount /dev/loop0 on /mnt1/test
>>>>>>
>>>>>> when the second section in local.config file is xfs and the first section
>>>>>> is non-xfs.
>>>>>>
>>>>>> It can be easily reproduced with the following local.config file
>>>>>>
>>>>>> [s2]
>>>>>> export FSTYP=ext4
>>>>>> export TEST_DEV=/dev/loop0
>>>>>> export TEST_DIR=/mnt1/test
>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>>
>>>>>> [s1]
>>>>>> export FSTYP=xfs
>>>>>> export TEST_DEV=/dev/loop0
>>>>>> export TEST_DIR=/mnt1/test
>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>>
>>>>>> ./check selftest/001
>>>>>>
>>>>>> Root cause:
>>>>>> When _test_mount() is executed for the second section, the FSTYPE has
>>>>>> already changed but the new fs specific common/$FSTYP has not yet
>>>>>> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>>>>>> the test run fails.
>>>>>>
>>>>>> Fix:
>>>>>> Remove the additional _test_mount in check file just before ". commom/rc"
>>>>>> since ". commom/rc" is already sourcing fs specific imports and doing a
>>>>>> _test_mount.
>>>>>>
>>>>>> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
>>>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>>>> ---
>>>>>>     check | 12 +++---------
>>>>>>     1 file changed, 3 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/check b/check
>>>>>> index 607d2456..5cb4e7eb 100755
>>>>>> --- a/check
>>>>>> +++ b/check
>>>>>> @@ -784,15 +784,9 @@ function run_section()
>>>>>>     			status=1
>>>>>>     			exit
>>>>>>     		fi
>>>>>> -		if ! _test_mount
>>>>> Don't we want to _test_mount the newly created filesystem still?  But
>>>>> perhaps after sourcing common/rc ?
>>>>>
>>>>> --D
>>>> common/rc calls init_rc() in the end and init_rc() already does a
>>>> _test_mount. _test_mount after sourcing common/rc will fail, won't it? Does
>>>> that make sense?
>>>>
>>>> init_rc()
>>>> {
>>>>       # make some further configuration checks here
>>>>       if [ "$TEST_DEV" = ""  ]
>>>>       then
>>>>           echo "common/rc: Error: \$TEST_DEV is not set"
>>>>           exit 1
>>>>       fi
>>>>
>>>>       # if $TEST_DEV is not mounted, mount it now as XFS
>>>>       if [ -z "`_fs_type $TEST_DEV`" ]
>>>>       then
>>>>           # $TEST_DEV is not mounted
>>>>           if ! _test_mount
>>>>           then
>>>>               echo "common/rc: retrying test device mount with external set"
>>>>               [ "$USE_EXTERNAL" != "yes" ] && export USE_EXTERNAL=yes
>>>>               if ! _test_mount
>>>>               then
>>>>                   echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
>>>>                   exit 1
>>>>               fi
>>>>           fi
>>>>       fi
>>>> ...
>>> ahahahaha yes it does.
>>>
>>> /commit message reading comprehension fail, sorry about that.
>>>
>>> Though now that you point it out, should check elide the init_rc call
>>> about 12 lines down if it re-sourced common/rc ?
>> Yes, it should. init_rc() is getting called twice when common/rc is getting
>> re-sourced. Maybe I can do like
>>
>>
>> if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>
>>      <...>
>>
>>      . common/rc # changes in this patch
>>
>>      <...>
>>
>> elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>
>>      ...
>>
>>      init_rc() # explicitly adding an init_rc() for this condition
>>
>> else
>>
>>      init_rc() # # explicitly adding an init_rc() for all other conditions.
>> This will prevent init_rc() from getting called twice during re-sourcing
>> common/rc
>>
>> fi
>>
>> What do you think?
> Sounds fine as a mechanical change, but I wonder, should calling init_rc
> be explicit?  There are not so many places that source common/rc:
>
> $ git grep 'common/rc'
> check:362:if ! . ./common/rc; then
> check:836:              . common/rc
> common/preamble:52:     . ./common/rc
> soak:7:. ./common/rc
> tests/generic/749:18:. ./common/rc
>
> (I filtered out the non-executable matches)
>
> I think the call in generic/749 is unnecessary and I don't know what
> soak does.  But that means that one could insert an explicit call to
> init_rc at line 366 and 837 in check and at line 53 in common/preamble,
> and we can clean up one more of those places where sourcing a common/
> file actually /does/ something quietly under the covers.

Okay just to clear my understanding, do you mean that the call to 
init_rc() be removed from common/rc file and the places which actually 
need the call to init_rc, explicitly calls init_rc() instead of sourcing 
". common/rc" and making common/rc do something under the cover?

--NR

>
> (Unless the maintainer is ok with the status quo...?)
>
> --D
>
>>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>>>
>>> --D
>>>
>>>> ...
>>>>
>>>> --NR
>>>>
>>>>
>>>>
>>>>>> -		then
>>>>>> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>>>>> -			status=1
>>>>>> -			exit
>>>>>> -		fi
>>>>>> -		# TEST_DEV has been recreated, previous FSTYP derived from
>>>>>> -		# TEST_DEV could be changed, source common/rc again with
>>>>>> -		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>>>>>> +		# Previous FSTYP derived from TEST_DEV could be changed, source
>>>>>> +		# common/rc again with correct FSTYP to get FSTYP specific configs,
>>>>>> +		# e.g. common/xfs
>>>>>>     		. common/rc
>>>>>>     		_prepare_test_list
>>>>>>     	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
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
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


