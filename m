Return-Path: <linux-ext4+bounces-6358-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ADDA2AF96
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 18:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E57A169EE1
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F76199238;
	Thu,  6 Feb 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlbhirEy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF2194A60;
	Thu,  6 Feb 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738864710; cv=none; b=CSR/sCAwgr/x6po+szA14yXuTkPheF095Fi+JLUGMiCSBQv1ZV/L47rtey42A+KA2RIIdyjbVpQn5LdhWscvn6oMiALjqalfTDISUIsI4pVzqNTXkSuAuhvJjV40mNVuh4B5s4lopa2kgqqeZBXbz7ZpaWsfuOmxZLVP5KtK+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738864710; c=relaxed/simple;
	bh=dtzRs9CDOrh2EzrUHAA28GBlpoWGrSTvBw3xhCNQWZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEnxiRD0v1dFAZWLmfdLKm5DdZzwJ23FuMBfopKigox6etZB23BfvfF1zVdTdgwBoIaRG7T2uXW3dAi3T/PKMha/xF4YzcnGr0y1qlID25axz78y30u0bddYpl4ncJh3C2i/88dfg1YVRhJsS1rBReDKJw2M0aXxp9tn5QBRXzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlbhirEy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fa21145217so318237a91.3;
        Thu, 06 Feb 2025 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738864708; x=1739469508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcHVrr7l23BDT+T2YquoT72CFB8dSBvVHsqgvrHaOmc=;
        b=QlbhirEyh5JmSoX2xglHmrZs7Rf2Khf7a7GtlYvn6XO2dcQgtvRdtcbGwN7E8KJO2r
         CnNr8083YrotBCQKmpCtIg5xDL0X/7MIt/H5dsZPYz9O+sCG+xDulST7VuxsOtMl2b4U
         80fRYR6U3WZccJ5JovPsjin+LzeFGCd9gST7Gw/xNlKNBdnAKSYrfnWNtDDDXzlGroXe
         veqHh7TKIomDuxqdmRXKWeiLD44AjdvvMo+rV2eqjbrIStXtyytF+JUvcFxkSw3LCThD
         EE2AtOW/fz1hzPc3K8G17yQKQmjVryFCLMu8hUus4IHl932sQMvYDyJ0VjmeKDeAYWPc
         jQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738864708; x=1739469508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcHVrr7l23BDT+T2YquoT72CFB8dSBvVHsqgvrHaOmc=;
        b=GZthXLC5raK2gUYHT3wcCzCNzQb80XkekIH6OKQ7lxBV4xmLJ+rLOB1ZAiGMO04YJi
         EtTkq/NYgIwUX//NQRs0NlPUhxmsNZ5rRVJ6mFBdjKamtsukTTlAyK3qR+uSKfPMph0g
         dLOWZJoDzxhQN17xFf/OWpDJThV0U2kMk/ymosyBr5KBR1jI+qyaz2QPiyOLGl3KilM9
         ama/4sAcv0/YjVH9REx6tRo0ZKdlSovVzifDJyyvUEtA4QdDqoXD5qkcw3onKPSRwNkH
         XiS1xugmMHIqIiDKKhvIF9fzvmp/Z7IKuDb61h1XdLNllTyRyvKH8BR1sWOiyycir/Hk
         eH1w==
X-Forwarded-Encrypted: i=1; AJvYcCWAxGunLqBZMtUeWE+YMAG8FkMxq1awydOqSBkgA2Fevkrc6Jd1kJF+/CyDEssTI/DnrS8N6ypRk2pg@vger.kernel.org, AJvYcCWLUjmyc7euHdEVSzxyEaNbrYln6uLCT1p5Sa4XITqUba4JM8GU3AG5i4pcCmkOaJeAxvOz2CbJm5s0@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMzuXKn9vaYTUv3vyILwsm90IddXZVDA5kEd2f/LDog19tklH
	l8CdgdnmAyrU0VgX8Fm3MN4j0cQuA1AMQicdy9Z9NTY7jCtMRKDn
X-Gm-Gg: ASbGnctFjtCRZuOw+S0KNgAtKr9zGHmmAQsgCiAGOAPzrkgHaZH+2CzHnIGSvKPqjVv
	WUOjwqNrOBOeEtEymjpzEzZ7rXs8Ep4QapfAQhStJjHCs7W83f9oDUaIq7Ysowa14XUMzKAD0LM
	/6Caa91ItrHgPY2r190DqSnWL92w3KVQh4zdI5NpzwPtVZkGuIlUU8ZOnx13x9zmW4EAh1cnpIx
	aSPwfuKW56TTl2uxFfn8e29EuMJrOAIbZvIwBdi1VRjn0EGaPdfKO0Yv58TkA3lIzAdgpjZcStk
	3zeQMJ9abbXHQq0akcEoQnWrmQ==
X-Google-Smtp-Source: AGHT+IGkAmtLRKiQAsQss/GrOT7D0l6Tya2D5CKBC7hEBirnYinKDomMY5wwUc34bpjgurPBVC1I1w==
X-Received: by 2002:a17:90b:1d4e:b0:2ee:a4f2:b307 with SMTP id 98e67ed59e1d1-2f9e074b4c6mr12391093a91.4.1738864707824;
        Thu, 06 Feb 2025 09:58:27 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09b5ad4esm1690087a91.41.2025.02.06.09.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 09:58:27 -0800 (PST)
Message-ID: <cee9a325-5402-4aaa-b517-d8c7bd73bfa8@gmail.com>
Date: Thu, 6 Feb 2025 23:28:23 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] check: Fix fs specfic imports when
 $FSTYPE!=$OLD_FSTYPE
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
 <3599e504-8c2f-4196-9ce8-a4c458505888@gmail.com>
 <20250206155251.GA21787@frogsfrogsfrogs>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250206155251.GA21787@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/6/25 21:22, Darrick J. Wong wrote:
> On Thu, Feb 06, 2025 at 11:05:42AM +0530, Nirjhar Roy (IBM) wrote:
>> On 1/31/25 21:54, Darrick J. Wong wrote:
>>> On Fri, Jan 31, 2025 at 06:49:50PM +0530, Nirjhar Roy (IBM) wrote:
>>>> On 1/29/25 21:32, Darrick J. Wong wrote:
>>>>> On Wed, Jan 29, 2025 at 04:48:10PM +0530, Nirjhar Roy (IBM) wrote:
>>>>>> On 1/28/25 23:39, Darrick J. Wong wrote:
>>>>>>> On Tue, Jan 28, 2025 at 05:00:22AM +0000, Nirjhar Roy (IBM) wrote:
>>>>>>>> Bug Description:
>>>>>>>>
>>>>>>>> _test_mount function is failing with the following error:
>>>>>>>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
>>>>>>>> check: failed to mount /dev/loop0 on /mnt1/test
>>>>>>>>
>>>>>>>> when the second section in local.config file is xfs and the first section
>>>>>>>> is non-xfs.
>>>>>>>>
>>>>>>>> It can be easily reproduced with the following local.config file
>>>>>>>>
>>>>>>>> [s2]
>>>>>>>> export FSTYP=ext4
>>>>>>>> export TEST_DEV=/dev/loop0
>>>>>>>> export TEST_DIR=/mnt1/test
>>>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>>>>
>>>>>>>> [s1]
>>>>>>>> export FSTYP=xfs
>>>>>>>> export TEST_DEV=/dev/loop0
>>>>>>>> export TEST_DIR=/mnt1/test
>>>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>>>>
>>>>>>>> ./check selftest/001
>>>>>>>>
>>>>>>>> Root cause:
>>>>>>>> When _test_mount() is executed for the second section, the FSTYPE has
>>>>>>>> already changed but the new fs specific common/$FSTYP has not yet
>>>>>>>> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>>>>>>>> the test run fails.
>>>>>>>>
>>>>>>>> Fix:
>>>>>>>> Remove the additional _test_mount in check file just before ". commom/rc"
>>>>>>>> since ". commom/rc" is already sourcing fs specific imports and doing a
>>>>>>>> _test_mount.
>>>>>>>>
>>>>>>>> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
>>>>>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>>>>>> ---
>>>>>>>>      check | 12 +++---------
>>>>>>>>      1 file changed, 3 insertions(+), 9 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/check b/check
>>>>>>>> index 607d2456..5cb4e7eb 100755
>>>>>>>> --- a/check
>>>>>>>> +++ b/check
>>>>>>>> @@ -784,15 +784,9 @@ function run_section()
>>>>>>>>      			status=1
>>>>>>>>      			exit
>>>>>>>>      		fi
>>>>>>>> -		if ! _test_mount
>>>>>>> Don't we want to _test_mount the newly created filesystem still?  But
>>>>>>> perhaps after sourcing common/rc ?
>>>>>>>
>>>>>>> --D
>>>>>> common/rc calls init_rc() in the end and init_rc() already does a
>>>>>> _test_mount. _test_mount after sourcing common/rc will fail, won't it? Does
>>>>>> that make sense?
>>>>>>
>>>>>> init_rc()
>>>>>> {
>>>>>>        # make some further configuration checks here
>>>>>>        if [ "$TEST_DEV" = ""  ]
>>>>>>        then
>>>>>>            echo "common/rc: Error: \$TEST_DEV is not set"
>>>>>>            exit 1
>>>>>>        fi
>>>>>>
>>>>>>        # if $TEST_DEV is not mounted, mount it now as XFS
>>>>>>        if [ -z "`_fs_type $TEST_DEV`" ]
>>>>>>        then
>>>>>>            # $TEST_DEV is not mounted
>>>>>>            if ! _test_mount
>>>>>>            then
>>>>>>                echo "common/rc: retrying test device mount with external set"
>>>>>>                [ "$USE_EXTERNAL" != "yes" ] && export USE_EXTERNAL=yes
>>>>>>                if ! _test_mount
>>>>>>                then
>>>>>>                    echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
>>>>>>                    exit 1
>>>>>>                fi
>>>>>>            fi
>>>>>>        fi
>>>>>> ...
>>>>> ahahahaha yes it does.
>>>>>
>>>>> /commit message reading comprehension fail, sorry about that.
>>>>>
>>>>> Though now that you point it out, should check elide the init_rc call
>>>>> about 12 lines down if it re-sourced common/rc ?
>>>> Yes, it should. init_rc() is getting called twice when common/rc is getting
>>>> re-sourced. Maybe I can do like
>>>>
>>>>
>>>> if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>>>
>>>>       <...>
>>>>
>>>>       . common/rc # changes in this patch
>>>>
>>>>       <...>
>>>>
>>>> elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>>
>>>>       ...
>>>>
>>>>       init_rc() # explicitly adding an init_rc() for this condition
>>>>
>>>> else
>>>>
>>>>       init_rc() # # explicitly adding an init_rc() for all other conditions.
>>>> This will prevent init_rc() from getting called twice during re-sourcing
>>>> common/rc
>>>>
>>>> fi
>>>>
>>>> What do you think?
>>> Sounds fine as a mechanical change, but I wonder, should calling init_rc
>>> be explicit?  There are not so many places that source common/rc:
>>>
>>> $ git grep 'common/rc'
>>> check:362:if ! . ./common/rc; then
>>> check:836:              . common/rc
>>> common/preamble:52:     . ./common/rc
>>> soak:7:. ./common/rc
>>> tests/generic/749:18:. ./common/rc
>>>
>>> (I filtered out the non-executable matches)
>>>
>>> I think the call in generic/749 is unnecessary and I don't know what
>>> soak does.  But that means that one could insert an explicit call to
>>> init_rc at line 366 and 837 in check and at line 53 in common/preamble,
>>> and we can clean up one more of those places where sourcing a common/
>>> file actually /does/ something quietly under the covers.
>> Okay just to clear my understanding, do you mean that the call to init_rc()
>> be removed from common/rc file and the places which actually need the call
>> to init_rc, explicitly calls init_rc() instead of sourcing ". common/rc" and
>> making common/rc do something under the cover?
> Yes.  Callsites like this:
>
> . ./common
> <horrid bash code>
>
> become this:
>
> . ./common/rc
> init_rc
> <horrid bash code>

Okay. Thank you for the confirmation.

--NR

>
> --D
>
>> --NR
>>
>>> (Unless the maintainer is ok with the status quo...?)
>>>
>>> --D
>>>
>>>>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>>>>>
>>>>> --D
>>>>>
>>>>>> ...
>>>>>>
>>>>>> --NR
>>>>>>
>>>>>>
>>>>>>
>>>>>>>> -		then
>>>>>>>> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>>>>>>> -			status=1
>>>>>>>> -			exit
>>>>>>>> -		fi
>>>>>>>> -		# TEST_DEV has been recreated, previous FSTYP derived from
>>>>>>>> -		# TEST_DEV could be changed, source common/rc again with
>>>>>>>> -		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>>>>>>>> +		# Previous FSTYP derived from TEST_DEV could be changed, source
>>>>>>>> +		# common/rc again with correct FSTYP to get FSTYP specific configs,
>>>>>>>> +		# e.g. common/xfs
>>>>>>>>      		. common/rc
>>>>>>>>      		_prepare_test_list
>>>>>>>>      	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>>>>>> -- 
>>>>>>>> 2.34.1
>>>>>>>>
>>>>>>>>
>>>>>> -- 
>>>>>> Nirjhar Roy
>>>>>> Linux Kernel Developer
>>>>>> IBM, Bangalore
>>>>>>
>>>> -- 
>>>> Nirjhar Roy
>>>> Linux Kernel Developer
>>>> IBM, Bangalore
>>>>
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


