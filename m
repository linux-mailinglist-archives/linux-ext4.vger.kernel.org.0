Return-Path: <linux-ext4+bounces-6057-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E417A0B1C1
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 09:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AFF16109B
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F15234971;
	Mon, 13 Jan 2025 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFWHKbeL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6C234967;
	Mon, 13 Jan 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758350; cv=none; b=Ems/MpNdCozOQ8RKYKg0wVI8ijVo5T0c1z7cDC8e0yPiMvFo3v05o5vfWoeYqvEVD1F9Y5HaOUNodjZlMW8b1oy0cLmZA3v40NIP6S4A+4YzojiUHcYIOVc0IhlfQuUAlSk9LFBonTNBmGWqEmKBlooYpaE7CDsSDRAPwLVqmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758350; c=relaxed/simple;
	bh=fn9TDbicS6Rir9Pkz2uly6IJWxW5Nk996icRTdHpDRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkYqHJuKAmA2ZF9HWwiGsaSyg3X3U5ZHXT0TE8+MJPIR6Bxstuv96tPC75fH3SESlWXRNYajKG1h6hiaqgjIkjadIXmSfZJ4VBxnVwO1loL/cUeQM/PuUkM9gJnKDpQA1LWgVSgm1rXwL6Q8b49BUduo5gxLp8cvEDO1wIZskuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFWHKbeL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b1f05caso67842665ad.3;
        Mon, 13 Jan 2025 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736758346; x=1737363146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/Zo2K/Znek2aTeY+BfbAwDr0U17OaTvvZB1CKGaqJ0=;
        b=mFWHKbeL1YBh3eSAN6z32RqE5/12fAikB+HRUrnP9DBpB/TypIJuvN7C1fvk93EU/M
         De3fs4IZFh/TDGLDPWeQlO3VqyO2vHUwnyQ6i7F7c6B7XTtPCoMVtkre0NM9rZWRkrUd
         AUpsAbVa/GuuE2xIjjnapvvWl7RzXyuGekEy07nBBzy2rnH/lgG/ZhsUlkyo5Kdh/hX0
         yfhcc6N6y8fgRVCB3Cc65gXSwIKbNU8Qq5F11cUIUADr40pMrVAZfwY0eIW7w4Iv0/NF
         Q7p+ynm4F1P8z+rAjkcpwksyIF0Hs9caHhMH8OyT0Z0LwMYp0f1t0oidB3Qoi17DfAJZ
         Iv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736758346; x=1737363146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/Zo2K/Znek2aTeY+BfbAwDr0U17OaTvvZB1CKGaqJ0=;
        b=SRiUKHUX0CN4arJ5SNm7oJsF9PIxy9pqZSzvPshViOeblXvYn/d5sZB1fjElEVGzb8
         OEem1MMrrQffFd3tQNPbmpkQzuRgHLhoTgcbeWfOQhwt4HP5ZrB8VeIRDaUcWcr7G0od
         8ZttbGPtGA3GFTc9/HbhD6/QDazvlY32wYGtt5fZrN4CMlCp1hN1UvlvQ1qpFOAwVmj0
         EcE1jpDfG/Ue01IaEIFoU7RzIxGcD6PgMeeDGPmtU8pnJa04Cva3/UnOYxxnOBHonNVK
         +t0f67P7kCr0kmHCpAIT/l5LpLkx12qealCBqyb85SEPKGnC0wOcUr5UShUVISwrwAyv
         W+ug==
X-Forwarded-Encrypted: i=1; AJvYcCVRuF1l1sdlxSOKPL3uj1KeUWMxTJVHR8k4QtxspAm8zUvzP8Y3ItGL3BpSvlkUNsouSHhdjZOy4Q9S@vger.kernel.org, AJvYcCVuK6nCkvka8lp5R3vUECeK/zNhZyXrLe5OXQHeIGJx5gNe2yRQElfAoV2FFnYQIJVFBqa1C3nFolex@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUFPP6fl5xthQIhEde4l017Qe66BJ28abnUIxev129zRT32Lt
	iCGM+3LuntlFGCzuSbEwivX5zzTLGXzc24AhM3/3If33M7XusmEo
X-Gm-Gg: ASbGncs2sKokR36gg7U/UXhtYb8Eyu6EC0A3z5ekEGFssgNHYqMD6osrFvP6Nc70wv/
	k0Sby5Wc8cS3xTN74wvUL3J8qMcWDtJk32L6QBfEyI/5vErI2AQr9jRwJ5/EkQ/7tUGRQXkGLKP
	ze+hA7huYdr60T4EnSkMtn4NVv+AfuKnt8oWCLV2kG4emN8TFx3liEXwUbjsVIAl4Mol9iiHjm5
	67SzxPgBkJ/LzgonMTZuailNDB2S1+TOiX3w1PvUszWEynAkVd2Y2u6vR0iYsaYRn4=
X-Google-Smtp-Source: AGHT+IEg9/F+LGqtKrf7nIklL7vRVleQUqeD4wSDpHAPQtoRyHKedHnZJOvBDJu7I+UNdKVGZdTEZQ==
X-Received: by 2002:a05:6a21:6f87:b0:1e1:ac71:2b6a with SMTP id adf61e73a8af0-1e88d0afd73mr33018334637.28.1736758345996;
        Mon, 13 Jan 2025 00:52:25 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07cff7sm6520341a12.3.2025.01.13.00.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 00:52:25 -0800 (PST)
Message-ID: <4afe80a4-ac6b-4796-b466-c42a95f7225a@gmail.com>
Date: Mon, 13 Jan 2025 14:22:20 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com>
 <20250113055901.u5e5ghzi3t45hdha@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250113055901.u5e5ghzi3t45hdha@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/13/25 11:29, Zorro Lang wrote:
> On Sun, Jan 12, 2025 at 03:21:51PM +0000, Nirjhar Roy (IBM) wrote:
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
>> call _source_specific_fs $FSTYP at the correct call site of  _test_mount()
>>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   check | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/check b/check
>> index 607d2456..8cdbb68f 100755
>> --- a/check
>> +++ b/check
>> @@ -776,6 +776,7 @@ function run_section()
>>   	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>   		echo "RECREATING    -- $FSTYP on $TEST_DEV"
>>   		_test_unmount 2> /dev/null
>> +		[[ "$OLD_FSTYP" != "$FSTYP" ]] && _source_specific_fs $FSTYP
> The _source_specific_fs is called when importing common/rc file:
>
>    # check for correct setup and source the $FSTYP specific functions now
>    _source_specific_fs $FSTYP
>
>  From the code logic of check script:
>
>          if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>                  echo "RECREATING    -- $FSTYP on $TEST_DEV"
>                  _test_unmount 2> /dev/null
>                  if ! _test_mkfs >$tmp.err 2>&1
>                  then
>                          echo "our local _test_mkfs routine ..."
>                          cat $tmp.err
>                          echo "check: failed to mkfs \$TEST_DEV using specified options"
>                          status=1
>                          exit
>                  fi
>                  if ! _test_mount
>                  then
>                          echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>                          status=1
>                          exit
>                  fi
>                  # TEST_DEV has been recreated, previous FSTYP derived from
>                  # TEST_DEV could be changed, source common/rc again with
>                  # correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>                  . common/rc
>                  ^^^^^^^^^^^
> we import common/rc at here.
>
> So I'm wondering if we can move this line upward, to fix the problem you
> hit (and don't bring in regression :) Does that help?
>
> Thanks,
> Zorro

Okay so we can move ". common/rc" upward and then remove the following 
from "check" file:

         if ! _test_mount
         then
             echo "check: failed to mount $TEST_DEV on $TEST_DIR"
             status=1
             exit
         fi

since . common/rc will call init_rc() in the end, which does a 
_test_mount(). Do you agree with this (Zorro and Ritesh)?

I can make the changes and send a v2?

--NR

>
>
>>   		if ! _test_mkfs >$tmp.err 2>&1
>>   		then
>>   			echo "our local _test_mkfs routine ..."
>> -- 
>> 2.34.1
>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


