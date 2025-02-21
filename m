Return-Path: <linux-ext4+bounces-6522-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A516DA3EBBB
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2025 05:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4837A420ABD
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2025 04:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA43B1FAC29;
	Fri, 21 Feb 2025 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XArqJzEG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A09288D2;
	Fri, 21 Feb 2025 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740111267; cv=none; b=qELP33FEXL6M8yDq0+XdoQkGFegdEMI30i/vg6N4Ucykx+3POTJNLIKtsaX8hH2+7iwyNrO4w9WcN14VW4JUlZHH0R0xtoW8bQPDtGv0t6D19cighHQpmnjrGn4FO8H1t4bXb8NvmZw2RydNNT99IGWEqyEk9fPTL/dtayubAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740111267; c=relaxed/simple;
	bh=mr129RpKe4qZhUm4zKwY+fdQ+Qj7H1r+aYrC25nFBNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NU824jIp1BgrTOuqwPU9G2zl4v3l5laxPs4d8dh6n5NIio/ptdB9M/ImcPfooFtTu5dvtYNbVPJwjXISkT9XXklo2zAxlgXg/+DZTotEyjbofdcNpeXNFJ3PDfYA9EeloIUV2i8IItrhtXbns+y0nnp/fWyPldKEKSQ17lI7T3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XArqJzEG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d398bea9so24463885ad.3;
        Thu, 20 Feb 2025 20:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740111265; x=1740716065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHr6xR4ESQRe/w/mY2FxSwMZDKAFIO1DxA/UrWdYVIY=;
        b=XArqJzEGmouFqP1HMbgfkVlS6FVCPuz2m1LLjDpVEuDoRkSFWNbmCBhoKUumaEL86Z
         yMOJQ9NrindRB1K26c1Ix8DUy/4DSSck3jJ5oka99rfLSwGV7ehFDCg0tSv0wPiZ//9q
         JFUA7Py8TLTCts8TXfDo6LCHdri3tD+7rFq0NKBW3idS3ha13JFOJJKFMyDGx8vTW08z
         Miq8b6OOXRUX5LYM3F0j+Oqen3oaIdHO+IKAgl78tK6JxZn/A8pzELQTxpG3295YeI6n
         1Wv+YBBNv/ciX82E8tvGpryS5xXPS/zQIGS5NIfxo074lXN7PHgW4OjBGqUWYANQ2yMC
         qjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740111265; x=1740716065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHr6xR4ESQRe/w/mY2FxSwMZDKAFIO1DxA/UrWdYVIY=;
        b=ur/ED2Rg3+v+gXl3NuG8H90JJ0j5MG+MAdlLg9GkDZ/DFHa/mpGeCMCCzGD4YkRMLV
         MhEUT73qzQVxBa3qqMn1vs2VzAeRe5kvPL0jePSKuZm2dC7ncjECspwoF2frtSTo3gS7
         AxKpV10Y750JjzBciEHtmLbYg4DuC1a8ZjOXj83P8fkvA2SIoksmRulUq39SU2d6BnQH
         pPzTcFMRd0wkDFCS7xXxaAt+b7lmi+yRfwsTLn9UW8asQ8Y+xWj7Y7vr2TF10t/CPdpJ
         kiU+SYnyTUgfZbDk6ryWK1gcylgRj06lzE8mliUJZ/m8Fre1Dw+/5e91X6lXP9Gwj+GE
         8CAw==
X-Forwarded-Encrypted: i=1; AJvYcCWBLDac/U+DBfTzT1nnQ9i4aZfOJ/PTrAMuLU7hgqPfHVHP87rJrxozbBApRf8Vj/YjZ2xjvru5pwIbAw==@vger.kernel.org, AJvYcCWZeIq9dBGBvlzOHSPDeJzlOf6uIQ2FjHpkTsGB6qVwsWuo/Cg6elsfn69RwZViAfATbceA8BKssJ9a@vger.kernel.org, AJvYcCX+3w58KFgyHjL7R3N9LsZJXu98UPryGFEKdpOeCrenPlyLqX7sHaDLzPqBVMpPlufBPuiyO8Pr@vger.kernel.org
X-Gm-Message-State: AOJu0YxgN5OX74KnskISaG43+69rkoFb8X7mFokwRMXRoAit08ShvllM
	H0aTyOZO5f+wplvp1iqawaK6sQGah2RlpP2AnR/iSM3Xp/+yHgT/
X-Gm-Gg: ASbGnctPoPDI9Gmn0MCwRCp3ppXOzTJ57FRma9OtHN1GxsZvp2RZXr0aZEOaulzbZDH
	cE57RnGl9dSTzkXl4qW7AgPL2sIcVhbvrXpcGH5gSDjAHfnAReFWqPe+1evwJz33vly7pLBsxwq
	WvcVQ8+TIG7hSQ0vwLarujdAU18qR1MmuMArpbw10lu4OA39dPtQdkmmqN/j4axyVRwRYGdK5Ze
	eVwTFK+MyqrkPMlDNh6jp0ugI647KxzAlZdeei6tMq5hUDNtALLauMudBDue7oRSkGQMlTN1QbG
	z47Keveefv0GE4S9z2o6Z0abVM6BCVdiXP9C
X-Google-Smtp-Source: AGHT+IGp5DLZjMSc5QicVCq7ZLMPhFC2+soM9LdXSJrfVSXvofOLC04sFme3uQNZgnSdacORfM4A8w==
X-Received: by 2002:a17:902:f68c:b0:220:e156:63e0 with SMTP id d9443c01a7336-221a0ec9b16mr18160405ad.8.1740111264544;
        Thu, 20 Feb 2025 20:14:24 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb04bbccsm258986a91.17.2025.02.20.20.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 20:14:24 -0800 (PST)
Message-ID: <b066257d-e32b-4c2e-a213-826ce8923a93@gmail.com>
Date: Fri, 21 Feb 2025 09:44:19 +0530
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
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, zlang@kernel.org
References: <3b980d028a8ae1496c13ebe3a6685fbc472c5bc0.1738040386.git.nirjhar.roy.lists@gmail.com>
 <20250128180917.GA3561257@frogsfrogsfrogs>
 <f89b6b40-8dce-4378-ba56-cf7f29695bdb@gmail.com>
 <20250129160259.GT3557553@frogsfrogsfrogs>
 <dfbd2895-e29a-4e25-bbc6-a83826d14878@gmail.com>
 <20250131162457.GV1611770@frogsfrogsfrogs>
 <20250201063516.gndb7lngpd5afatv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ff6b4e2f-dbd3-479b-a522-a1ae4837b3df@gmail.com>
 <20250210142322.tptpphdntglsz4eq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250210142322.tptpphdntglsz4eq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/10/25 19:53, Zorro Lang wrote:
> On Thu, Feb 06, 2025 at 11:32:43PM +0530, Nirjhar Roy (IBM) wrote:
>> On 2/1/25 12:05, Zorro Lang wrote:
>>> On Fri, Jan 31, 2025 at 08:24:57AM -0800, Darrick J. Wong wrote:
>>>> On Fri, Jan 31, 2025 at 06:49:50PM +0530, Nirjhar Roy (IBM) wrote:
>>>>> On 1/29/25 21:32, Darrick J. Wong wrote:
>>>>>> On Wed, Jan 29, 2025 at 04:48:10PM +0530, Nirjhar Roy (IBM) wrote:
>>>>>>> On 1/28/25 23:39, Darrick J. Wong wrote:
>>>>>>>> On Tue, Jan 28, 2025 at 05:00:22AM +0000, Nirjhar Roy (IBM) wrote:
>>>>>>>>> Bug Description:
>>>>>>>>>
>>>>>>>>> _test_mount function is failing with the following error:
>>>>>>>>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
>>>>>>>>> check: failed to mount /dev/loop0 on /mnt1/test
>>>>>>>>>
>>>>>>>>> when the second section in local.config file is xfs and the first section
>>>>>>>>> is non-xfs.
>>>>>>>>>
>>>>>>>>> It can be easily reproduced with the following local.config file
>>>>>>>>>
>>>>>>>>> [s2]
>>>>>>>>> export FSTYP=ext4
>>>>>>>>> export TEST_DEV=/dev/loop0
>>>>>>>>> export TEST_DIR=/mnt1/test
>>>>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>>>>>
>>>>>>>>> [s1]
>>>>>>>>> export FSTYP=xfs
>>>>>>>>> export TEST_DEV=/dev/loop0
>>>>>>>>> export TEST_DIR=/mnt1/test
>>>>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>>>>>
>>>>>>>>> ./check selftest/001
>>>>>>>>>
>>>>>>>>> Root cause:
>>>>>>>>> When _test_mount() is executed for the second section, the FSTYPE has
>>>>>>>>> already changed but the new fs specific common/$FSTYP has not yet
>>>>>>>>> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>>>>>>>>> the test run fails.
>>>>>>>>>
>>>>>>>>> Fix:
>>>>>>>>> Remove the additional _test_mount in check file just before ". commom/rc"
>>>>>>>>> since ". commom/rc" is already sourcing fs specific imports and doing a
>>>>>>>>> _test_mount.
>>>>>>>>>
>>>>>>>>> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
>>>>>>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>>>>>>> ---
>>>>>>>>>      check | 12 +++---------
>>>>>>>>>      1 file changed, 3 insertions(+), 9 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/check b/check
>>>>>>>>> index 607d2456..5cb4e7eb 100755
>>>>>>>>> --- a/check
>>>>>>>>> +++ b/check
>>>>>>>>> @@ -784,15 +784,9 @@ function run_section()
>>>>>>>>>      			status=1
>>>>>>>>>      			exit
>>>>>>>>>      		fi
>>>>>>>>> -		if ! _test_mount
>>>>>>>> Don't we want to _test_mount the newly created filesystem still?  But
>>>>>>>> perhaps after sourcing common/rc ?
>>>>>>>>
>>>>>>>> --D
>>>>>>> common/rc calls init_rc() in the end and init_rc() already does a
>>>>>>> _test_mount. _test_mount after sourcing common/rc will fail, won't it? Does
>>>>>>> that make sense?
>>>>>>>
>>>>>>> init_rc()
>>>>>>> {
>>>>>>>        # make some further configuration checks here
>>>>>>>        if [ "$TEST_DEV" = ""  ]
>>>>>>>        then
>>>>>>>            echo "common/rc: Error: \$TEST_DEV is not set"
>>>>>>>            exit 1
>>>>>>>        fi
>>>>>>>
>>>>>>>        # if $TEST_DEV is not mounted, mount it now as XFS
>>>>>>>        if [ -z "`_fs_type $TEST_DEV`" ]
>>>>>>>        then
>>>>>>>            # $TEST_DEV is not mounted
>>>>>>>            if ! _test_mount
>>>>>>>            then
>>>>>>>                echo "common/rc: retrying test device mount with external set"
>>>>>>>                [ "$USE_EXTERNAL" != "yes" ] && export USE_EXTERNAL=yes
>>>>>>>                if ! _test_mount
>>>>>>>                then
>>>>>>>                    echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
>>>>>>>                    exit 1
>>>>>>>                fi
>>>>>>>            fi
>>>>>>>        fi
>>>>>>> ...
>>>>>> ahahahaha yes it does.
>>>>>>
>>>>>> /commit message reading comprehension fail, sorry about that.
>>>>>>
>>>>>> Though now that you point it out, should check elide the init_rc call
>>>>>> about 12 lines down if it re-sourced common/rc ?
>>>>> Yes, it should. init_rc() is getting called twice when common/rc is getting
>>>>> re-sourced. Maybe I can do like
>>>>>
>>>>>
>>>>> if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>>>>
>>>>>       <...>
>>>>>
>>>>>       . common/rc # changes in this patch
>>>>>
>>>>>       <...>
>>>>>
>>>>> elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>>>
>>>>>       ...
>>>>>
>>>>>       init_rc() # explicitly adding an init_rc() for this condition
>>>>>
>>>>> else
>>>>>
>>>>>       init_rc() # # explicitly adding an init_rc() for all other conditions.
>>>>> This will prevent init_rc() from getting called twice during re-sourcing
>>>>> common/rc
>>>>>
>>>>> fi
>>>>>
>>>>> What do you think?
>>>> Sounds fine as a mechanical change, but I wonder, should calling init_rc
>>>> be explicit?  There are not so many places that source common/rc:
>>>>
>>>> $ git grep 'common/rc'
>>>> check:362:if ! . ./common/rc; then
>>>> check:836:              . common/rc
>>>> common/preamble:52:     . ./common/rc
>>>> soak:7:. ./common/rc
>>>> tests/generic/749:18:. ./common/rc
>>>>
>>>> (I filtered out the non-executable matches)
>>>>
>>>> I think the call in generic/749 is unnecessary and I don't know what
>>>> soak does.  But that means that one could insert an explicit call to
>>>> init_rc at line 366 and 837 in check and at line 53 in common/preamble,
>>>> and we can clean up one more of those places where sourcing a common/
>>>> file actually /does/ something quietly under the covers.
>>>>
>>>> (Unless the maintainer is ok with the status quo...?)
>>> I think people just hope to import the helpers in common/rc mostly, don't
>>> want to run init_rc again. Maybe we can make sure the init_rc is only run
>>> once each time?
>>>
>>> E.g.
>>>
>>>     if [ _INIT_RC != "done" ];then
>>> 	init_rc
>>> 	_INIT_RC="done"
>>>     fi
>>>
>>> Or any better idea.
>> Yes, this idea looks good too. However, after thinking a bit more, I like
>> Darrick's idea to remove the call to init_rc from common/rc and explicitly
>> calling them explicitly whenever necessary makes more sense. This also makes
>> the interface/reason to source common/rc more meaningful, and also not
>> making common/rc do something via init_rc silently. What do you think?
> Sorry I'm on a travel, reply you late. I don't like to run codes in include
> files either :) If we remove the init_rc calling from common/rc we might
> need to do 2 things:
> 1) xfstests/check needs to run init_rc, calls it in check properly.
> 2) Now each sub-cases run init_rc when they import common/rc, I think
> we can call init_rc in common/preamble:_begin_fstest().

Sorry for my delayed reply, I got caught up with some other work items. 
Thank you for your above suggestions. Let me go through them, look for 
some edge cases and I can come up with a patch after some proper testing.

Regards,

--NR

>
> If I miss other things, please feel free to remind me:)
>
> Thanks,
> Zorro
>
>> --NR
>>
>>> Thanks,
>>> Zorro
>>>
>>>> --D
>>>>
>>>>>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>>>>>>
>>>>>> --D
>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>> --NR
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>> -		then
>>>>>>>>> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>>>>>>>> -			status=1
>>>>>>>>> -			exit
>>>>>>>>> -		fi
>>>>>>>>> -		# TEST_DEV has been recreated, previous FSTYP derived from
>>>>>>>>> -		# TEST_DEV could be changed, source common/rc again with
>>>>>>>>> -		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>>>>>>>>> +		# Previous FSTYP derived from TEST_DEV could be changed, source
>>>>>>>>> +		# common/rc again with correct FSTYP to get FSTYP specific configs,
>>>>>>>>> +		# e.g. common/xfs
>>>>>>>>>      		. common/rc
>>>>>>>>>      		_prepare_test_list
>>>>>>>>>      	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>>>>>>> -- 
>>>>>>>>> 2.34.1
>>>>>>>>>
>>>>>>>>>
>>>>>>> -- 
>>>>>>> Nirjhar Roy
>>>>>>> Linux Kernel Developer
>>>>>>> IBM, Bangalore
>>>>>>>
>>>>> -- 
>>>>> Nirjhar Roy
>>>>> Linux Kernel Developer
>>>>> IBM, Bangalore
>>>>>
>>>>>
>> -- 
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


