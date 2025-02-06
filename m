Return-Path: <linux-ext4+bounces-6359-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60066A2AFA6
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 19:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4370A188C789
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96A3198E65;
	Thu,  6 Feb 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9RgSaxD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7F0189F39;
	Thu,  6 Feb 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738864970; cv=none; b=onvQ5Mja7Fp8kLxM5jWPR2neFCZHenxikOFAqYBrX/eDGly0YCZ/QD/unPOtriMK726ZMSTuzFMOEQTEhrY4Y5dENu01mPTLCWYx0E22GOUTkT49OpcDu0WU1/OvQ+sSC8VSgcgnv70wHk5LWrAmyrw1GkkcBEPbXd5wZYQheOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738864970; c=relaxed/simple;
	bh=/P0AdyGEhky8ka/vSg6ZFBPBfnfmBAYtujlaH6lx7Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMYVUfnOyxXCEAaffMc6/dxUWXuNt0b21dnNHLszSb5mwsK/veFXXfHJsDRg5QoHTBcFO/7E7a2kuH5w3exuviAHzVP57NqArTrlVMQN6f1JEQWQxdE1BnJVtIOcPMyceF9aCnZWBPJH2jtoN9iKmXIpkRpBAJMr/2kyzzEveRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9RgSaxD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f3e2b4eceso15831565ad.2;
        Thu, 06 Feb 2025 10:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738864968; x=1739469768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvK38wiRCrAYcKcwBWX3jYdlpcJqbAIE9iLPlquLiKU=;
        b=K9RgSaxDA/z7tIkz3KVQKeFIgnZAHxHOymwb5CYi7LlgogIdstlz72YuACO77gjX6G
         M9sSdA76P4RUX53xDJSZH6OPtTWGaJ8rCv8n034VouD9V+2CgOg+HtyGaaHUCQnml6Hp
         I6XsENY2CHjNgBdpBkmjirocXTwjQVrAbTNZ1cyhNqiYtzdUcpFSciLR+THSb5FeDUgC
         nHBN2iqEh18gGrDMIFWrgSSEgkuTYhUmVZkRJaUn1mDL5NvWsmKrbaSu91UmJNHMMXWr
         IbpnNFiOQgtvue7G4N26TRYqj4QB8cbfypgz1XdcPf6ZMR+55kaR54KgD0WW1kCJ/Sl4
         JXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738864968; x=1739469768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvK38wiRCrAYcKcwBWX3jYdlpcJqbAIE9iLPlquLiKU=;
        b=xOuZ6G5UhVmYChqPOw26YbLMbpB6DdE3b0ODX/YZeZIT2wbNVEPkhvsFlJx45N//dz
         ssVgtyPT5TEqU+rcONdnuSndl9fWsbY/llk67uIJ46+SeuFSuXGCrLLxfNAGuXhlvnTO
         HQQWrPZua2ODlVnGOzp9HMW4cD8coYWpmEmkr0pkows/IXTJuV2S20JBGd9in6W27+SF
         eTlZCPSlnWHLKYc/BpYQtFARztJ+JvzGag0b7tjHX95GKxnT4QflLGgTpZ5xbMIhulPR
         UxGa48SuB/6Hu2rIgaDK4HlGN3BFlRL4wWmoZcLgabsKQ0koSczXecB95gCZVekEXJjT
         jSUw==
X-Forwarded-Encrypted: i=1; AJvYcCUvonUGYN+5SxU8nA09TqK5chyi8Wcydhh80ACacRo/gmDSaJVvq57YJkiTMZDeV1CeVYSNBUdhTtGD@vger.kernel.org, AJvYcCX6T4cVmve9FV1g8TXZTXxj+38b/8xSATPjp08o/v9j/BITvcHjNbSPkX5DGUJRLfViEdUO339JEhAR@vger.kernel.org
X-Gm-Message-State: AOJu0YwcbkbNS4Pd6FpnTwIBITJBMn/7gWovT47z04JTJhQBD7AXJvzZ
	zo1fH+5iQVPe6AfsW87moJPxmt2C/uzy1yopPURiMFyHjRUkF66l
X-Gm-Gg: ASbGncuF0UIkrzi2WnCKp4+AfPPAjdnrhm7REAri5ierHyVpiym4hKK60EjP7HFziSV
	OgGgTgu1ayXma2kKDh906JWJx4p+3XxvrC1cjdbY/GAT48pTzflK1RXCZhtL4bCMQ/O7ZrTFrX0
	n3P21S8L5V1YRkPlT7phhyVHLdcMRfBEDPGP2vlGtu0knIZqqMi06c1JdDVlzW7N8BikFZw6lpr
	Yafus5hZBxyoLTH/9U6Pdz1LL/MJxLixV+mfUc0L8LcKI5QV+j5puyA5Hh5x7ZGDOZHk65FfUAE
	TEejoQSNFWWGVl8K4dGVezEqBg==
X-Google-Smtp-Source: AGHT+IFYdGXiEo8gWMPZsX9l9DjFOV4J8MhWKi+DtLsbsOT6f7hKkwjDECOj35bZKLej2yNsvuMPqg==
X-Received: by 2002:a05:6a00:3ccb:b0:72d:8d98:c250 with SMTP id d2e1a72fcca58-7305d43aa90mr327807b3a.4.1738864967864;
        Thu, 06 Feb 2025 10:02:47 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c16676sm1612559b3a.133.2025.02.06.10.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 10:02:47 -0800 (PST)
Message-ID: <ff6b4e2f-dbd3-479b-a522-a1ae4837b3df@gmail.com>
Date: Thu, 6 Feb 2025 23:32:43 +0530
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
To: Zorro Lang <zlang@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 zlang@kernel.org
References: <3b980d028a8ae1496c13ebe3a6685fbc472c5bc0.1738040386.git.nirjhar.roy.lists@gmail.com>
 <20250128180917.GA3561257@frogsfrogsfrogs>
 <f89b6b40-8dce-4378-ba56-cf7f29695bdb@gmail.com>
 <20250129160259.GT3557553@frogsfrogsfrogs>
 <dfbd2895-e29a-4e25-bbc6-a83826d14878@gmail.com>
 <20250131162457.GV1611770@frogsfrogsfrogs>
 <20250201063516.gndb7lngpd5afatv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250201063516.gndb7lngpd5afatv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/1/25 12:05, Zorro Lang wrote:
> On Fri, Jan 31, 2025 at 08:24:57AM -0800, Darrick J. Wong wrote:
>> On Fri, Jan 31, 2025 at 06:49:50PM +0530, Nirjhar Roy (IBM) wrote:
>>> On 1/29/25 21:32, Darrick J. Wong wrote:
>>>> On Wed, Jan 29, 2025 at 04:48:10PM +0530, Nirjhar Roy (IBM) wrote:
>>>>> On 1/28/25 23:39, Darrick J. Wong wrote:
>>>>>> On Tue, Jan 28, 2025 at 05:00:22AM +0000, Nirjhar Roy (IBM) wrote:
>>>>>>> Bug Description:
>>>>>>>
>>>>>>> _test_mount function is failing with the following error:
>>>>>>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
>>>>>>> check: failed to mount /dev/loop0 on /mnt1/test
>>>>>>>
>>>>>>> when the second section in local.config file is xfs and the first section
>>>>>>> is non-xfs.
>>>>>>>
>>>>>>> It can be easily reproduced with the following local.config file
>>>>>>>
>>>>>>> [s2]
>>>>>>> export FSTYP=ext4
>>>>>>> export TEST_DEV=/dev/loop0
>>>>>>> export TEST_DIR=/mnt1/test
>>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>>>
>>>>>>> [s1]
>>>>>>> export FSTYP=xfs
>>>>>>> export TEST_DEV=/dev/loop0
>>>>>>> export TEST_DIR=/mnt1/test
>>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>>>
>>>>>>> ./check selftest/001
>>>>>>>
>>>>>>> Root cause:
>>>>>>> When _test_mount() is executed for the second section, the FSTYPE has
>>>>>>> already changed but the new fs specific common/$FSTYP has not yet
>>>>>>> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>>>>>>> the test run fails.
>>>>>>>
>>>>>>> Fix:
>>>>>>> Remove the additional _test_mount in check file just before ". commom/rc"
>>>>>>> since ". commom/rc" is already sourcing fs specific imports and doing a
>>>>>>> _test_mount.
>>>>>>>
>>>>>>> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
>>>>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>>>>> ---
>>>>>>>     check | 12 +++---------
>>>>>>>     1 file changed, 3 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> diff --git a/check b/check
>>>>>>> index 607d2456..5cb4e7eb 100755
>>>>>>> --- a/check
>>>>>>> +++ b/check
>>>>>>> @@ -784,15 +784,9 @@ function run_section()
>>>>>>>     			status=1
>>>>>>>     			exit
>>>>>>>     		fi
>>>>>>> -		if ! _test_mount
>>>>>> Don't we want to _test_mount the newly created filesystem still?  But
>>>>>> perhaps after sourcing common/rc ?
>>>>>>
>>>>>> --D
>>>>> common/rc calls init_rc() in the end and init_rc() already does a
>>>>> _test_mount. _test_mount after sourcing common/rc will fail, won't it? Does
>>>>> that make sense?
>>>>>
>>>>> init_rc()
>>>>> {
>>>>>       # make some further configuration checks here
>>>>>       if [ "$TEST_DEV" = ""  ]
>>>>>       then
>>>>>           echo "common/rc: Error: \$TEST_DEV is not set"
>>>>>           exit 1
>>>>>       fi
>>>>>
>>>>>       # if $TEST_DEV is not mounted, mount it now as XFS
>>>>>       if [ -z "`_fs_type $TEST_DEV`" ]
>>>>>       then
>>>>>           # $TEST_DEV is not mounted
>>>>>           if ! _test_mount
>>>>>           then
>>>>>               echo "common/rc: retrying test device mount with external set"
>>>>>               [ "$USE_EXTERNAL" != "yes" ] && export USE_EXTERNAL=yes
>>>>>               if ! _test_mount
>>>>>               then
>>>>>                   echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
>>>>>                   exit 1
>>>>>               fi
>>>>>           fi
>>>>>       fi
>>>>> ...
>>>> ahahahaha yes it does.
>>>>
>>>> /commit message reading comprehension fail, sorry about that.
>>>>
>>>> Though now that you point it out, should check elide the init_rc call
>>>> about 12 lines down if it re-sourced common/rc ?
>>> Yes, it should. init_rc() is getting called twice when common/rc is getting
>>> re-sourced. Maybe I can do like
>>>
>>>
>>> if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>>
>>>      <...>
>>>
>>>      . common/rc # changes in this patch
>>>
>>>      <...>
>>>
>>> elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>
>>>      ...
>>>
>>>      init_rc() # explicitly adding an init_rc() for this condition
>>>
>>> else
>>>
>>>      init_rc() # # explicitly adding an init_rc() for all other conditions.
>>> This will prevent init_rc() from getting called twice during re-sourcing
>>> common/rc
>>>
>>> fi
>>>
>>> What do you think?
>> Sounds fine as a mechanical change, but I wonder, should calling init_rc
>> be explicit?  There are not so many places that source common/rc:
>>
>> $ git grep 'common/rc'
>> check:362:if ! . ./common/rc; then
>> check:836:              . common/rc
>> common/preamble:52:     . ./common/rc
>> soak:7:. ./common/rc
>> tests/generic/749:18:. ./common/rc
>>
>> (I filtered out the non-executable matches)
>>
>> I think the call in generic/749 is unnecessary and I don't know what
>> soak does.  But that means that one could insert an explicit call to
>> init_rc at line 366 and 837 in check and at line 53 in common/preamble,
>> and we can clean up one more of those places where sourcing a common/
>> file actually /does/ something quietly under the covers.
>>
>> (Unless the maintainer is ok with the status quo...?)
> I think people just hope to import the helpers in common/rc mostly, don't
> want to run init_rc again. Maybe we can make sure the init_rc is only run
> once each time?
>
> E.g.
>
>    if [ _INIT_RC != "done" ];then
> 	init_rc
> 	_INIT_RC="done"
>    fi
>
> Or any better idea.

Yes, this idea looks good too. However, after thinking a bit more, I 
like Darrick's idea to remove the call to init_rc from common/rc and 
explicitly calling them explicitly whenever necessary makes more sense. 
This also makes the interface/reason to source common/rc more 
meaningful, and also not making common/rc do something via init_rc 
silently. What do you think?

--NR

>
> Thanks,
> Zorro
>
>> --D
>>
>>>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>>>>
>>>> --D
>>>>
>>>>> ...
>>>>>
>>>>> --NR
>>>>>
>>>>>
>>>>>
>>>>>>> -		then
>>>>>>> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>>>>>> -			status=1
>>>>>>> -			exit
>>>>>>> -		fi
>>>>>>> -		# TEST_DEV has been recreated, previous FSTYP derived from
>>>>>>> -		# TEST_DEV could be changed, source common/rc again with
>>>>>>> -		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>>>>>>> +		# Previous FSTYP derived from TEST_DEV could be changed, source
>>>>>>> +		# common/rc again with correct FSTYP to get FSTYP specific configs,
>>>>>>> +		# e.g. common/xfs
>>>>>>>     		. common/rc
>>>>>>>     		_prepare_test_list
>>>>>>>     	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>>>>> -- 
>>>>>>> 2.34.1
>>>>>>>
>>>>>>>
>>>>> -- 
>>>>> Nirjhar Roy
>>>>> Linux Kernel Developer
>>>>> IBM, Bangalore
>>>>>
>>> -- 
>>> Nirjhar Roy
>>> Linux Kernel Developer
>>> IBM, Bangalore
>>>
>>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


