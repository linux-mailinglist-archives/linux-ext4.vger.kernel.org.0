Return-Path: <linux-ext4+bounces-6272-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC02CA21C06
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2025 12:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF497A0802
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2025 11:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175821B85DF;
	Wed, 29 Jan 2025 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2bJC//X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3F19DF60;
	Wed, 29 Jan 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149497; cv=none; b=K8OkXfWL9xAkxr2MUK34bhJ2K8QhlczvQYqwZW7ccf3ZOtGAwsjY5PRYezycalnilktfc9Ec6TzHlbrkyOrt7fek0jluwrRc6SY9ZT8SfNiBg+iyCkXeSWrycobCBlyUUEQR3mFk1DBIgkQzAyAUX00eEPshlDkinVtfk0lvK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149497; c=relaxed/simple;
	bh=3p3h1pv8J2c1FvL/X/lc339oqDdxtJN9pJ0h+9Y1QoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fi4w3j7nV6880X1ZPqyVgnsUoWdkyy/ywUbJPYOuasoQdsfNxNa8X44q8mpEHRjU4oW0oCTriZaUABRdeUU5bKEKIESBIisx3mkjGv7KAj5qiOKcEBRjNsksWI1nTTARvhM+B4DhhErOcrPvs5WlK/2oksoMFnSb4Gyj8MSyJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2bJC//X; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2165cb60719so118851415ad.0;
        Wed, 29 Jan 2025 03:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738149495; x=1738754295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Un8YIu7U0rtJz4Eo1iyAOAUXT9TJl6lo48bWaNY04aM=;
        b=H2bJC//XtcJVsLS+KFcY+uyjtkjzNjEzJCS1ql7gNjQ51XTIR1qN80fiI/PWZNR5nE
         8tsX3z2OCVpViX3Z0pIpVgolTQF+Xve1B0q4Lm9MVHy84bc9MYBAPhxDxdlpNM4EnvMW
         HY4W3Mz0+XCWvlL/3tSeOSP1ux7toOSHC6p6e6MPXMS4qWLIwwOpdY+dQWh5G2CO70Tb
         X+q+1m3X7mw6SPgP78tgHPYrNHqsHul48DYuv5sLmXz5gPhd7TUyUPTkTTaNYanNIFhw
         e8K2tTvloPShynBTMoeXDNuIZrg1Ukae2vGOwy11YprpxHsxebBL2pGO2dO1OEHFuvw5
         3HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738149495; x=1738754295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Un8YIu7U0rtJz4Eo1iyAOAUXT9TJl6lo48bWaNY04aM=;
        b=wVk50iBPG7RNgaPD1YFtq5YwlVuAA2svwuweMpmho5/7sNyqVNWTwrN/+9hfnoBmqI
         d/MYS5hMLBfVdkTsKRX/aOaX20cKBjTFqi49jhev4saT5GG8HK5NQbDFKBEjPg/Y4kx5
         2+Cg0MTM43sQQt7EKb0Gnin0B9mm/muFAhvEjM7iJLgWWwwdRJz/AGz9PQ2yrJLnOog1
         Dbwfj18Wa8EvegHexavB6JEIgqDP4ru/Y+Wy9+XNiwrDijOFOkd2HO1F5l4O2kGz4wyD
         p7IyxeHog58y9NJDFRWqi+jZ7ble0MBnohn7OrZbkc+OU5QR0dgDfsmMDA9eodpn4kAa
         U68Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQwa/zgCfHy+Fv3hZiRO+2wVUN9zvNo/s2XmZAM+xz8ozUbwuexKRB4+MbdPvHNK7f2dDr84CLoOkv@vger.kernel.org, AJvYcCWURY5QHx1GGDl/FGv1IzTeYlT9MbjWgpc+ZfCJVedLdGpEPY/xFnEQ2njl9o6cdc4KhBvJ6IY6eTqg@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmXy5QAlvwZsBA6WA4MkZXuP6bl5OZ3yeRe91RSB1TeLINjyH
	H9DMVCjhBZPEuvDyiO7i+iMBMCyh0DdEj3A+uwBBOPevX7HAi6c1
X-Gm-Gg: ASbGncv1/lVesGw1fzGZV9NkBrfFggl59n1uwBxl1T8I74LKx720Yd+PUjPf+88VRRY
	z/pKAI39LOnn53PcgFzmTic6O7DDh2OvRHPvge/Dls6oplN4+q/OV1k6qXuEnYQD8HAwcnHOJHP
	Dt0FM0e37QuuMB4wXuL3DG5tA9kxBDVbp6UFF0gSYd/0zdkT9/hu6TyRVSQOq81lvp2kXtylRjz
	8xtJuZGstODPoBE3x8XygKCdJhPVdHLWRXwbQsyp0c7qJ14J81Jgef+FSh5ioVQpSma1mL0+zS7
	39I0hWwd1Ejo7JQjLa/Aj9I/QQ==
X-Google-Smtp-Source: AGHT+IE6klJTaPcpMVmemdGT4vOgBrAoJYfuYSn5suFG18ptZMLljZUmln7aZrcWmztBr0zyNCkJng==
X-Received: by 2002:a05:6a21:8dca:b0:1e1:96d9:a7db with SMTP id adf61e73a8af0-1ed7a49a283mr5323402637.4.1738149495306;
        Wed, 29 Jan 2025 03:18:15 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b324bsm11243492b3a.62.2025.01.29.03.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 03:18:14 -0800 (PST)
Message-ID: <f89b6b40-8dce-4378-ba56-cf7f29695bdb@gmail.com>
Date: Wed, 29 Jan 2025 16:48:10 +0530
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
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250128180917.GA3561257@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/28/25 23:39, Darrick J. Wong wrote:
> On Tue, Jan 28, 2025 at 05:00:22AM +0000, Nirjhar Roy (IBM) wrote:
>> Bug Description:
>>
>> _test_mount function is failing with the following error:
>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
>> check: failed to mount /dev/loop0 on /mnt1/test
>>
>> when the second section in local.config file is xfs and the first section
>> is non-xfs.
>>
>> It can be easily reproduced with the following local.config file
>>
>> [s2]
>> export FSTYP=ext4
>> export TEST_DEV=/dev/loop0
>> export TEST_DIR=/mnt1/test
>> export SCRATCH_DEV=/dev/loop1
>> export SCRATCH_MNT=/mnt1/scratch
>>
>> [s1]
>> export FSTYP=xfs
>> export TEST_DEV=/dev/loop0
>> export TEST_DIR=/mnt1/test
>> export SCRATCH_DEV=/dev/loop1
>> export SCRATCH_MNT=/mnt1/scratch
>>
>> ./check selftest/001
>>
>> Root cause:
>> When _test_mount() is executed for the second section, the FSTYPE has
>> already changed but the new fs specific common/$FSTYP has not yet
>> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>> the test run fails.
>>
>> Fix:
>> Remove the additional _test_mount in check file just before ". commom/rc"
>> since ". commom/rc" is already sourcing fs specific imports and doing a
>> _test_mount.
>>
>> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   check | 12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/check b/check
>> index 607d2456..5cb4e7eb 100755
>> --- a/check
>> +++ b/check
>> @@ -784,15 +784,9 @@ function run_section()
>>   			status=1
>>   			exit
>>   		fi
>> -		if ! _test_mount
> Don't we want to _test_mount the newly created filesystem still?  But
> perhaps after sourcing common/rc ?
>
> --D

common/rc calls init_rc() in the end and init_rc() already does a 
_test_mount. _test_mount after sourcing common/rc will fail, won't it? 
Does that make sense?

init_rc()
{
     # make some further configuration checks here
     if [ "$TEST_DEV" = ""  ]
     then
         echo "common/rc: Error: \$TEST_DEV is not set"
         exit 1
     fi

     # if $TEST_DEV is not mounted, mount it now as XFS
     if [ -z "`_fs_type $TEST_DEV`" ]
     then
         # $TEST_DEV is not mounted
         if ! _test_mount
         then
             echo "common/rc: retrying test device mount with external set"
             [ "$USE_EXTERNAL" != "yes" ] && export USE_EXTERNAL=yes
             if ! _test_mount
             then
                 echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
                 exit 1
             fi
         fi
     fi
...

...

--NR



>
>> -		then
>> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>> -			status=1
>> -			exit
>> -		fi
>> -		# TEST_DEV has been recreated, previous FSTYP derived from
>> -		# TEST_DEV could be changed, source common/rc again with
>> -		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>> +		# Previous FSTYP derived from TEST_DEV could be changed, source
>> +		# common/rc again with correct FSTYP to get FSTYP specific configs,
>> +		# e.g. common/xfs
>>   		. common/rc
>>   		_prepare_test_list
>>   	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>> -- 
>> 2.34.1
>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


