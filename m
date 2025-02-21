Return-Path: <linux-ext4+bounces-6524-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE3EA3EC57
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2025 06:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E207A2F24
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2025 05:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404761FC0F0;
	Fri, 21 Feb 2025 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt+8ACfI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9B1FBC87;
	Fri, 21 Feb 2025 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116988; cv=none; b=GPEMMu3n6iUQJylsiBSNq5zWR1270uhspvS8NQo83349Ims/Ov6rVQcqYo6eI0RufNIkfWR8+Buj9Z0KuCkqJXXnJqYsCt9Jg5CM3Ply+ogeXWUV2IBZ0dWpcpKHQHqqpCUmOl6TBl+TQPkVcrm3+WjUD+IKJ0bSu5xfY2myvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116988; c=relaxed/simple;
	bh=cvmiWKew6bIhrYPHLGmG7TpPGmgPt9q+TqAyBCJNGBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yme7b3+HDWH5Ynj4bD725qNkkDWokMu0ICZf0P4w9OSPZDA8fu86oth9h1a+iFPEPaYKJTUEXCY94dCeNqHmbBXXQVOvTa4tX7df1p63LuKUn2TefKSh7kJRjVD71WS3NSyKTVEy2srs8GcIiuZ8GGonEbZfql4fc3ceq4SGo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt+8ACfI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220bfdfb3f4so37778475ad.2;
        Thu, 20 Feb 2025 21:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740116986; x=1740721786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxH9KuWJX9rm9WyAdNNgaHpu9/9ip+kAMwhprP7JICU=;
        b=Lt+8ACfIb2YLXKc1dhR3h9wjwbJIinbqNvR5N5FM5ua4Vu2Cse0x9F3MsaWzxJmU4I
         ZTjeOoxDDjQq7adiBl44VqfbW/UkSR4v+4prTtem7zOE3ART/fy8v7aoEsYhM4R9hGue
         Tz4DKXndA2RzdA2XA25naruzld2s3B9uHtwkagGpf5NshyoUHp8BInBL8FTJdZIZnOhD
         Biz+GIeLNXe7CUu+6ozC9qbUvevlWrUnBo/k/PDc9ONShJqDQDGfWP4RywLV0WPtOwbU
         sHV6g/9PQoeq68gmlEaTVvpCj0pbtQisOtaNPPWLITbsZpFnq+UtR8NoJ4Nb9dSpJLI9
         C7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740116986; x=1740721786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxH9KuWJX9rm9WyAdNNgaHpu9/9ip+kAMwhprP7JICU=;
        b=ZKto6mqI5qrMx4Q5BuDzyrf8ov7vlldUvPwY54GEZz5YKZew/A5hDqLAgnDaw6AxRt
         Eieb/nw774kHfrCW7vodC0NXjVPMrL7pBEBsIsQk+x2iOFOag6kAPPiozmYu3cqrZ3UH
         bkKdWweNUZxWEHA9TuMCCxZIbiV9MGgruVILhPUCPHzNSYn5EeYPFCt45pWCyVVRVcca
         HkAkjy+YxS/EjfhbF4OQG1erxBM6ivSnU+MLGbLXuBOZ+VtONQ3hsrC6QxbGWMEQD9fO
         t6JEIpkKtJl6ClxRkaO0rYxKa1Z2uS5dfIXkdADob/DO5L4ggV6nv03PKwzm1zA7HUQ6
         MH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWg7ICWsirX++daTZiHCRecvPPQh4fGfdkfBq0IDsM6cbWKBg9CWo4io0w1E0bK13gTkgA5gXED@vger.kernel.org, AJvYcCWj9eaYT9KOzOooKQxNUHrCMq2sDEqVzvx3qWtdZCyVet7IHd8nyrFRVX6wcKATne+1VAwT/6WANdkp@vger.kernel.org, AJvYcCXqfmIRkzmF6RIxquByl0lH+6XHqCKy9vr2VFG0hpKTL8VJ34JwPd8DqN6CCpgyNFB06rMGXTiQjA8sBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCgyXrPVKfAB6iTbEBDcwqCzC80MdjVo7YU4EBCV4xDfIPHOMl
	Clxd7IpJOlg3GaFD180Cjz0nJQOEaF+iyOUuwSAuIOl2Mz8GBesC
X-Gm-Gg: ASbGncsBJ9s6uaa4e4dAx7Tn7v497lo2fZ2y6d2kcqfkawgLju7/QrwaFNBiQT3372h
	FuuPfPMLjyFp/dZu4OID9eBwLE97yojEDU4qKL+hij+4aCM5XBeMwFHwcpfRFbkM6MfkyADqffO
	AUkJeNzAhSw4EQytciLMccS29oerMuFjbtC//+w6XpFEvu9ExLojMXvhIvsea4Xab3jlcBFjFrx
	D98/GHBOW7M0eH2JmbrE3QLDsHGJXyBmFAUZf9XmIDV6/WKyAgZxEHAMmKr4HwKW9E1wWPqXN9b
	6E31/uoATWNXwTbtGLxGNO+RAzI1Q9kXHMcz
X-Google-Smtp-Source: AGHT+IEiidR4fTSv8C0AJDrbT+K+y1GcOQ2r1xj4NzKnkKaamPGXo0BUpCJHMFOCn1ftjslEXhVOIg==
X-Received: by 2002:a17:902:f68e:b0:21f:6bda:e492 with SMTP id d9443c01a7336-2219ffc3d85mr33712205ad.35.1740116986228;
        Thu, 20 Feb 2025 21:49:46 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55858d6sm129371975ad.223.2025.02.20.21.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 21:49:45 -0800 (PST)
Message-ID: <b8dcd75a-ba05-40c7-adb4-862e594f9b70@gmail.com>
Date: Fri, 21 Feb 2025 11:19:41 +0530
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
 <b066257d-e32b-4c2e-a213-826ce8923a93@gmail.com>
 <20250221054737.owarnxetb34gdicf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250221054737.owarnxetb34gdicf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/21/25 11:17, Zorro Lang wrote:
> On Fri, Feb 21, 2025 at 09:44:19AM +0530, Nirjhar Roy (IBM) wrote:
>> On 2/10/25 19:53, Zorro Lang wrote:
>>> On Thu, Feb 06, 2025 at 11:32:43PM +0530, Nirjhar Roy (IBM) wrote:
>>>> On 2/1/25 12:05, Zorro Lang wrote:
>>>>> On Fri, Jan 31, 2025 at 08:24:57AM -0800, Darrick J. Wong wrote:
>>>>>> On Fri, Jan 31, 2025 at 06:49:50PM +0530, Nirjhar Roy (IBM) wrote:
>>>>>>> On 1/29/25 21:32, Darrick J. Wong wrote:
>>>>>>>> On Wed, Jan 29, 2025 at 04:48:10PM +0530, Nirjhar Roy (IBM) wrote:
>>>>>>>>> On 1/28/25 23:39, Darrick J. Wong wrote:
>>>>>>>>>> On Tue, Jan 28, 2025 at 05:00:22AM +0000, Nirjhar Roy (IBM) wrote:
>>>>>>>>>>> Bug Description:
>>>>>>>>>>>
>>>>>>>>>>> _test_mount function is failing with the following error:
>>>>>>>>>>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
>>>>>>>>>>> check: failed to mount /dev/loop0 on /mnt1/test
>>>>>>>>>>>
>>>>>>>>>>> when the second section in local.config file is xfs and the first section
>>>>>>>>>>> is non-xfs.
>>>>>>>>>>>
>>>>>>>>>>> It can be easily reproduced with the following local.config file
>>>>>>>>>>>
>>>>>>>>>>> [s2]
>>>>>>>>>>> export FSTYP=ext4
>>>>>>>>>>> export TEST_DEV=/dev/loop0
>>>>>>>>>>> export TEST_DIR=/mnt1/test
>>>>>>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>>>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>>>>>>>
>>>>>>>>>>> [s1]
>>>>>>>>>>> export FSTYP=xfs
>>>>>>>>>>> export TEST_DEV=/dev/loop0
>>>>>>>>>>> export TEST_DIR=/mnt1/test
>>>>>>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>>>>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>>>>>>>>
>>>>>>>>>>> ./check selftest/001
>>>>>>>>>>>
>>>>>>>>>>> Root cause:
>>>>>>>>>>> When _test_mount() is executed for the second section, the FSTYPE has
>>>>>>>>>>> already changed but the new fs specific common/$FSTYP has not yet
>>>>>>>>>>> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>>>>>>>>>>> the test run fails.
>>>>>>>>>>>
>>>>>>>>>>> Fix:
>>>>>>>>>>> Remove the additional _test_mount in check file just before ". commom/rc"
>>>>>>>>>>> since ". commom/rc" is already sourcing fs specific imports and doing a
>>>>>>>>>>> _test_mount.
>>>>>>>>>>>
>>>>>>>>>>> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
>>>>>>>>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       check | 12 +++---------
>>>>>>>>>>>       1 file changed, 3 insertions(+), 9 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/check b/check
>>>>>>>>>>> index 607d2456..5cb4e7eb 100755
>>>>>>>>>>> --- a/check
>>>>>>>>>>> +++ b/check
>>>>>>>>>>> @@ -784,15 +784,9 @@ function run_section()
>>>>>>>>>>>       			status=1
>>>>>>>>>>>       			exit
>>>>>>>>>>>       		fi
>>>>>>>>>>> -		if ! _test_mount
>>>>>>>>>> Don't we want to _test_mount the newly created filesystem still?  But
>>>>>>>>>> perhaps after sourcing common/rc ?
>>>>>>>>>>
>>>>>>>>>> --D
>>>>>>>>> common/rc calls init_rc() in the end and init_rc() already does a
>>>>>>>>> _test_mount. _test_mount after sourcing common/rc will fail, won't it? Does
>>>>>>>>> that make sense?
>>>>>>>>>
>>>>>>>>> init_rc()
>>>>>>>>> {
>>>>>>>>>         # make some further configuration checks here
>>>>>>>>>         if [ "$TEST_DEV" = ""  ]
>>>>>>>>>         then
>>>>>>>>>             echo "common/rc: Error: \$TEST_DEV is not set"
>>>>>>>>>             exit 1
>>>>>>>>>         fi
>>>>>>>>>
>>>>>>>>>         # if $TEST_DEV is not mounted, mount it now as XFS
>>>>>>>>>         if [ -z "`_fs_type $TEST_DEV`" ]
>>>>>>>>>         then
>>>>>>>>>             # $TEST_DEV is not mounted
>>>>>>>>>             if ! _test_mount
>>>>>>>>>             then
>>>>>>>>>                 echo "common/rc: retrying test device mount with external set"
>>>>>>>>>                 [ "$USE_EXTERNAL" != "yes" ] && export USE_EXTERNAL=yes
>>>>>>>>>                 if ! _test_mount
>>>>>>>>>                 then
>>>>>>>>>                     echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
>>>>>>>>>                     exit 1
>>>>>>>>>                 fi
>>>>>>>>>             fi
>>>>>>>>>         fi
>>>>>>>>> ...
>>>>>>>> ahahahaha yes it does.
>>>>>>>>
>>>>>>>> /commit message reading comprehension fail, sorry about that.
>>>>>>>>
>>>>>>>> Though now that you point it out, should check elide the init_rc call
>>>>>>>> about 12 lines down if it re-sourced common/rc ?
>>>>>>> Yes, it should. init_rc() is getting called twice when common/rc is getting
>>>>>>> re-sourced. Maybe I can do like
>>>>>>>
>>>>>>>
>>>>>>> if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>>>>>>
>>>>>>>        <...>
>>>>>>>
>>>>>>>        . common/rc # changes in this patch
>>>>>>>
>>>>>>>        <...>
>>>>>>>
>>>>>>> elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>>>>>
>>>>>>>        ...
>>>>>>>
>>>>>>>        init_rc() # explicitly adding an init_rc() for this condition
>>>>>>>
>>>>>>> else
>>>>>>>
>>>>>>>        init_rc() # # explicitly adding an init_rc() for all other conditions.
>>>>>>> This will prevent init_rc() from getting called twice during re-sourcing
>>>>>>> common/rc
>>>>>>>
>>>>>>> fi
>>>>>>>
>>>>>>> What do you think?
>>>>>> Sounds fine as a mechanical change, but I wonder, should calling init_rc
>>>>>> be explicit?  There are not so many places that source common/rc:
>>>>>>
>>>>>> $ git grep 'common/rc'
>>>>>> check:362:if ! . ./common/rc; then
>>>>>> check:836:              . common/rc
>>>>>> common/preamble:52:     . ./common/rc
>>>>>> soak:7:. ./common/rc
>>>>>> tests/generic/749:18:. ./common/rc
>>>>>>
>>>>>> (I filtered out the non-executable matches)
>>>>>>
>>>>>> I think the call in generic/749 is unnecessary and I don't know what
>>>>>> soak does.  But that means that one could insert an explicit call to
>>>>>> init_rc at line 366 and 837 in check and at line 53 in common/preamble,
>>>>>> and we can clean up one more of those places where sourcing a common/
>>>>>> file actually /does/ something quietly under the covers.
>>>>>>
>>>>>> (Unless the maintainer is ok with the status quo...?)
>>>>> I think people just hope to import the helpers in common/rc mostly, don't
>>>>> want to run init_rc again. Maybe we can make sure the init_rc is only run
>>>>> once each time?
>>>>>
>>>>> E.g.
>>>>>
>>>>>      if [ _INIT_RC != "done" ];then
>>>>> 	init_rc
>>>>> 	_INIT_RC="done"
>>>>>      fi
>>>>>
>>>>> Or any better idea.
>>>> Yes, this idea looks good too. However, after thinking a bit more, I like
>>>> Darrick's idea to remove the call to init_rc from common/rc and explicitly
>>>> calling them explicitly whenever necessary makes more sense. This also makes
>>>> the interface/reason to source common/rc more meaningful, and also not
>>>> making common/rc do something via init_rc silently. What do you think?
>>> Sorry I'm on a travel, reply you late. I don't like to run codes in include
>>> files either :) If we remove the init_rc calling from common/rc we might
>>> need to do 2 things:
>>> 1) xfstests/check needs to run init_rc, calls it in check properly.
>>> 2) Now each sub-cases run init_rc when they import common/rc, I think
>>> we can call init_rc in common/preamble:_begin_fstest().
>> Sorry for my delayed reply, I got caught up with some other work items.
>> Thank you for your above suggestions. Let me go through them, look for some
>> edge cases and I can come up with a patch after some proper testing.
> No problem :) I just suggested, but the thing is we must figure out which
> ". common/rc" hopes to run init_rc, and which not :) Thanks for looking
> into it and test it.

Yes, I will look into this. Thank you.

--NR

>
>> Regards,
>>
>> --NR
>>
>>> If I miss other things, please feel free to remind me:)
>>>
>>> Thanks,
>>> Zorro
>>>
>>>> --NR
>>>>
>>>>> Thanks,
>>>>> Zorro
>>>>>
>>>>>> --D
>>>>>>
>>>>>>>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>>>>>>>>
>>>>>>>> --D
>>>>>>>>
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>> --NR
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>> -		then
>>>>>>>>>>> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>>>>>>>>>> -			status=1
>>>>>>>>>>> -			exit
>>>>>>>>>>> -		fi
>>>>>>>>>>> -		# TEST_DEV has been recreated, previous FSTYP derived from
>>>>>>>>>>> -		# TEST_DEV could be changed, source common/rc again with
>>>>>>>>>>> -		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>>>>>>>>>>> +		# Previous FSTYP derived from TEST_DEV could be changed, source
>>>>>>>>>>> +		# common/rc again with correct FSTYP to get FSTYP specific configs,
>>>>>>>>>>> +		# e.g. common/xfs
>>>>>>>>>>>       		. common/rc
>>>>>>>>>>>       		_prepare_test_list
>>>>>>>>>>>       	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>>>>>>>>> -- 
>>>>>>>>>>> 2.34.1
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>> -- 
>>>>>>>>> Nirjhar Roy
>>>>>>>>> Linux Kernel Developer
>>>>>>>>> IBM, Bangalore
>>>>>>>>>
>>>>>>> -- 
>>>>>>> Nirjhar Roy
>>>>>>> Linux Kernel Developer
>>>>>>> IBM, Bangalore
>>>>>>>
>>>>>>>
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


