Return-Path: <linux-ext4+bounces-6276-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDFEA23E44
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jan 2025 14:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA5C188277C
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jan 2025 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C416A1C4A2D;
	Fri, 31 Jan 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Krxc4gJ0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D938DC0;
	Fri, 31 Jan 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329597; cv=none; b=J9SjnNbxqYLvwSrTlftxT3qQ5oNSD0bfcOItVLnbkIX/PjkMh5tfTmHJ0Prn5J27Oicko83Xr8s4MLMPMA0PY9TbTTMPmKju1mYiI8Ar4R5vAt11kOJ22TZq0lzek34uARashkm1d0ihUNTDOT+tZii4RhYOVwSLDRZatpN4/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329597; c=relaxed/simple;
	bh=FE5hfDGVMzXOs8bLsiL1lq38uFbgHIhuJwb8tvboT7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBBlpCZs8vyn6DsiYs5zg29aDaE6fFazrNUc6KucwbCZuqzGejGnkn4IoJmC0078MVNnSU1A+wB7SY0tESndHbjoJgcYMl815aJYhsdqYUZUkogQHAceghYSm8IQJu4O8c3lUSBIvYtU7uzBD2QYcYVwpa1xRJqgbKNlrZ4gEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Krxc4gJ0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2164b1f05caso34225135ad.3;
        Fri, 31 Jan 2025 05:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738329595; x=1738934395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuIktlKTYtd1OCRoNIR8JL3CXmwcu7yxygoE8XEotDk=;
        b=Krxc4gJ0Ewyg1mtZXCpUH2Ce2GtRgJIEr9qKmMGe5yT8PU1BeCMrU2qHKWo0V7FAM+
         cLWe+KYh/u6HG9LXf2Jqm9nlBHRZTIQlsMLL7eCO1nSyXl6uv42rH6vE8+FCJKRa73T/
         GJmJvQl10R+9Z12P9NP7VohcaKPCqeN8SB7a9gZQ3usRhVANuJnXmo2RtupvpbTw9Z/n
         Is/ppqNxOjsF4NhVFiMc0sUt+0bZ7lAaEprc/Q5b1DENV67QJ1anDMsJrlSim1RxnjEV
         7bDQAOiKk/4LB4G+tyqmlbTJa7ZdrTNc3qOEMLkI/ZusR/2z/i1Yc8sTIG/YV0RvbLUf
         Sfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738329595; x=1738934395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuIktlKTYtd1OCRoNIR8JL3CXmwcu7yxygoE8XEotDk=;
        b=p1KXstBzWugEjIMuzrtEM2r+ArTGUKn7NqWZsVQucoqoR5iCBfUoawOWyOgXt/UWi/
         LfUJ/oGUaHaVTm2Rp8lm2ZUlvZ1i+Rwp8t+YVaoU3m/rHgIu8jqeLz/F9PtW9cBhQpI+
         Wxv3e4COstTgBog8C1i+e4w0aLkJimUlbDmGYtgK11pA1zC9/gSTecCnr97stJw5pPGv
         u3igtsFVrxZ+n7o2PXvcV6ZnFnTTWdj0ENGLrrf8uGNbhUhDXBsgK76v+YyxQZ6tC16r
         GNSBMoMGTcxqsNZbvEre43RhIQJRMPYcM25cj1amuuR/T3BezdN+U6yxLar9ACu9TuhZ
         eZdw==
X-Forwarded-Encrypted: i=1; AJvYcCUQU6ALDgt+we/n4DghVDlghrW/INxyrLPy9UxtXGefez4rb5LRlHWViT74oY9YpJwn+wddpNeKrsZg@vger.kernel.org, AJvYcCWBVabCi/n27TkvWq+28RZI8dWW0MBsF71M4PqmzMmumjuGtzURJpx1KrN9N5TZ+EK3i+W9IFctPjr2@vger.kernel.org
X-Gm-Message-State: AOJu0YyAiTxbu6fDBGbjURDBMQJHctaK6SWSFz2zHueJ5eVeDcxhPEGb
	5hbdnJylfMuvKJZ4IWhp9dfqNlEWuZdXm9N7TBQ121e5PV/3HOZR
X-Gm-Gg: ASbGncuCEvt/u/P9tcdm6zWgyyxNt/qxBqgO5rHyfeooUG+oEJ3JgaiLttvGV5xXplD
	ZrYs5Jr4YX4z1vs0XLfDOeyBejU5HJO27mNfk1H3C3Ax2ndIGLvO+yd9/JEtGQiFvI9locHeKu8
	DyUi6Du0AJmr2rlIlBMUhPHGedYY5JgJ8AKGvhMtuCdgN5lOowDe+NQLT6xTVx4RdjB3Ca64cFY
	eagpbDU+5gEF0LE9icbFp3pgzPxQbdojz4/Wt4/MMEEvQLiqhXC39gcOCopE7nifjXtC7ok7c83
	kfhQ71dWqV2Pt+uLRoTc8iScLw==
X-Google-Smtp-Source: AGHT+IFfC7n5xfiQH9KbrNPW9ZxolQE8fQJRjy/Nn2RGDxAAZUvdGEpSQfwz+k/kz82N9Z7cXfLyvA==
X-Received: by 2002:a17:902:ef43:b0:216:45eb:5e4d with SMTP id d9443c01a7336-21dd7c3d30dmr137809035ad.6.1738329595028;
        Fri, 31 Jan 2025 05:19:55 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331f2dcsm29924295ad.226.2025.01.31.05.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 05:19:54 -0800 (PST)
Message-ID: <dfbd2895-e29a-4e25-bbc6-a83826d14878@gmail.com>
Date: Fri, 31 Jan 2025 18:49:50 +0530
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
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250129160259.GT3557553@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/29/25 21:32, Darrick J. Wong wrote:
> On Wed, Jan 29, 2025 at 04:48:10PM +0530, Nirjhar Roy (IBM) wrote:
>> On 1/28/25 23:39, Darrick J. Wong wrote:
>>> On Tue, Jan 28, 2025 at 05:00:22AM +0000, Nirjhar Roy (IBM) wrote:
>>>> Bug Description:
>>>>
>>>> _test_mount function is failing with the following error:
>>>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
>>>> check: failed to mount /dev/loop0 on /mnt1/test
>>>>
>>>> when the second section in local.config file is xfs and the first section
>>>> is non-xfs.
>>>>
>>>> It can be easily reproduced with the following local.config file
>>>>
>>>> [s2]
>>>> export FSTYP=ext4
>>>> export TEST_DEV=/dev/loop0
>>>> export TEST_DIR=/mnt1/test
>>>> export SCRATCH_DEV=/dev/loop1
>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>
>>>> [s1]
>>>> export FSTYP=xfs
>>>> export TEST_DEV=/dev/loop0
>>>> export TEST_DIR=/mnt1/test
>>>> export SCRATCH_DEV=/dev/loop1
>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>
>>>> ./check selftest/001
>>>>
>>>> Root cause:
>>>> When _test_mount() is executed for the second section, the FSTYPE has
>>>> already changed but the new fs specific common/$FSTYP has not yet
>>>> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>>>> the test run fails.
>>>>
>>>> Fix:
>>>> Remove the additional _test_mount in check file just before ". commom/rc"
>>>> since ". commom/rc" is already sourcing fs specific imports and doing a
>>>> _test_mount.
>>>>
>>>> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> ---
>>>>    check | 12 +++---------
>>>>    1 file changed, 3 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/check b/check
>>>> index 607d2456..5cb4e7eb 100755
>>>> --- a/check
>>>> +++ b/check
>>>> @@ -784,15 +784,9 @@ function run_section()
>>>>    			status=1
>>>>    			exit
>>>>    		fi
>>>> -		if ! _test_mount
>>> Don't we want to _test_mount the newly created filesystem still?  But
>>> perhaps after sourcing common/rc ?
>>>
>>> --D
>> common/rc calls init_rc() in the end and init_rc() already does a
>> _test_mount. _test_mount after sourcing common/rc will fail, won't it? Does
>> that make sense?
>>
>> init_rc()
>> {
>>      # make some further configuration checks here
>>      if [ "$TEST_DEV" = ""  ]
>>      then
>>          echo "common/rc: Error: \$TEST_DEV is not set"
>>          exit 1
>>      fi
>>
>>      # if $TEST_DEV is not mounted, mount it now as XFS
>>      if [ -z "`_fs_type $TEST_DEV`" ]
>>      then
>>          # $TEST_DEV is not mounted
>>          if ! _test_mount
>>          then
>>              echo "common/rc: retrying test device mount with external set"
>>              [ "$USE_EXTERNAL" != "yes" ] && export USE_EXTERNAL=yes
>>              if ! _test_mount
>>              then
>>                  echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
>>                  exit 1
>>              fi
>>          fi
>>      fi
>> ...
> ahahahaha yes it does.
>
> /commit message reading comprehension fail, sorry about that.
>
> Though now that you point it out, should check elide the init_rc call
> about 12 lines down if it re-sourced common/rc ?

Yes, it should. init_rc() is getting called twice when common/rc is 
getting re-sourced. Maybe I can do like


if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then

     <...>

     . common/rc # changes in this patch

     <...>

elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then

     ...

     init_rc() # explicitly adding an init_rc() for this condition

else

     init_rc() # # explicitly adding an init_rc() for all other 
conditions. This will prevent init_rc() from getting called twice during 
re-sourcing common/rc

fi

What do you think?


>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D
>
>> ...
>>
>> --NR
>>
>>
>>
>>>> -		then
>>>> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>>> -			status=1
>>>> -			exit
>>>> -		fi
>>>> -		# TEST_DEV has been recreated, previous FSTYP derived from
>>>> -		# TEST_DEV could be changed, source common/rc again with
>>>> -		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>>>> +		# Previous FSTYP derived from TEST_DEV could be changed, source
>>>> +		# common/rc again with correct FSTYP to get FSTYP specific configs,
>>>> +		# e.g. common/xfs
>>>>    		. common/rc
>>>>    		_prepare_test_list
>>>>    	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>> -- 
>>>> 2.34.1
>>>>
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


