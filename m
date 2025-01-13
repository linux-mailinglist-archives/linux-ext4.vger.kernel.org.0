Return-Path: <linux-ext4+bounces-6056-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A638A0AF0D
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 07:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58784163D07
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 06:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EEE231A44;
	Mon, 13 Jan 2025 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2Gexd7F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250B230D17;
	Mon, 13 Jan 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748003; cv=none; b=J4HtBzEtmEspUq7Qw6/ii+QnsJPfLtTLrnBL2jIdicAUH49eJ5/6IkjM07fxADwQVEz8DIxV6em48VeY8Q+pPAUFt0LDYQldAeKrn+A24iYyPu7/igoo9oRTxY46t4t7Q14wYpd5OReZR/vV9tYfn89rclScXOimLGve+s1oftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748003; c=relaxed/simple;
	bh=E0+fkKArJDq7eSOEssf+MTwNUuhfAIpE7/mP7IAq7+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQ99L3eS6JO5OfnwWMr8gac34nZelyqdpY7dlEXahiX/XOQf8SP84j75M2QFXM9zGJdbFJwwgWlQkhEpK0lnVKNUOxGOuTItePkM1ZYc/Qu9k7f+aGnulFaxUPODLW+feAU51Z/Kvzy6RinwsZaMeimCu1U737QOlmFzCSBE2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2Gexd7F; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so4860564a91.3;
        Sun, 12 Jan 2025 22:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736748001; x=1737352801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPia3MKeGS5s0IMA9MWQxTciC7tZ1guiQ90y2x1iM0c=;
        b=G2Gexd7FjDhCxDvL3vtQxGB4EFvBbiKAOrUSe0SPudXzX4Hf6WSDKaPBbGHM56sibq
         tktI86aIRecPvbS7UAvLxevAKgqWjlAPn2AerS7jFzfUSkAy6t/xWEL8NDS/p/QUHoZd
         F1gdzYaa6nGh3zDn7VyVUHVN1uwGt6XcMpYHlxVeFl4FdBkVHwpTubd1VRsFk6uYoqJr
         5L2+8YmtSYSRcqCoqNQCUJ2drraR8UWzTg4QIfqmV7p3oyy2UYJ/gtRtXLPpERpLmJSV
         8aRIkW3T3aZeafnZ33ThzSBFSnIZoYNvP4o2GruDlDLhNeQLSTTUgitGFbWZ43CGbUku
         yWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736748001; x=1737352801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPia3MKeGS5s0IMA9MWQxTciC7tZ1guiQ90y2x1iM0c=;
        b=XaPftpfwgGw4byYK2y3a7JwWg5/DUNlI/xUs+Va6TvqHLAgIRnD6nEOWQXZtrgcpK3
         +FWR+m2hhkcRU3Oqwt5scEtEpidMG/KoAkAGbtBR5gMO76QhQTHvqS3KnEECT4avU1ST
         7pErdEKfGQTPY0iJd3DtaKzp6i50gpPwQ4PjxOokX/c98jVIzZTHU/XT686UAR2Zosi/
         r4VqoiPV6erQ35WT98h+RqZeJ261rsuIVPdM5zQ5j24ccus03pfaS/PE8n259E+D0AbA
         wQ9/8nIHB8/XIExX3B+H+esxqBbetxWbu6alCoTUlHnVlPl0vWOq12ICKc8ssZx9TGtr
         3HMg==
X-Forwarded-Encrypted: i=1; AJvYcCUiy5CzZlwf/QMNYV9HLcNGA9pryA/0DVONfggp+H4W61Cg9fgv023bDjFEX0ROMy+DLp4qL0Jsiz0G@vger.kernel.org, AJvYcCUvbSl20Uk6hFkHC55vnldcfGoTTtMC/F7pbZFRHqeibTDjrR77j9GB7y4OzzLtyi1IYnCoGrh6@vger.kernel.org
X-Gm-Message-State: AOJu0YwfmjXKgBZXubYFYlOS4sKsr9WCB7G/bTwBrzbvKkfgsbNl1a/g
	pVtf5tu+BmwZ8XYy91hmTN6kqWTFvLcy+emVtjHH8SZQnHEZ+UCc
X-Gm-Gg: ASbGnctGUBqfO0+gnQHl9ZlHmCz4L8N+Qc3+AGUdQ3GUWjR/jzpUc7xETqCRi4PcWo/
	wTKsefcKXdLGDOP58CV/5/B1a6khhkEVR5m30Ag6mkjf/0XCz+5wIONK6Dzq5Vs+vB9IcUy3h5R
	b5wLsbAxzJGP2QVDaqh/jw5ZXjjuRe7xp7pKTisdDwoD7OAaUBHGew34AtpeXPdLd0VKoTHBLSL
	mn5+cR0XiUG0wvihHj/vzUaw/Kqr7UhUvIY72Ys5P9oLkbK7ppSAwjW4eVCxuU=
X-Google-Smtp-Source: AGHT+IEocPo6jGCdtMtvR8MNx17eAyI6wpaUVtCw4v35D5vCJNO+gNisSCYWd1ED/o6pKhWcxF7Qiw==
X-Received: by 2002:a17:90b:54cb:b0:2ee:863e:9fe8 with SMTP id 98e67ed59e1d1-2f548ec793fmr31215330a91.18.1736748001041;
        Sun, 12 Jan 2025 22:00:01 -0800 (PST)
Received: from [9.109.247.80] ([129.41.58.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm46466365ad.168.2025.01.12.21.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 22:00:00 -0800 (PST)
Message-ID: <1efecce4-f051-40fc-8851-e9f9c057e844@gmail.com>
Date: Mon, 13 Jan 2025 11:29:56 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
References: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com>
 <87jzazvmzh.fsf@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <87jzazvmzh.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/13/25 01:11, Ritesh Harjani (IBM) wrote:
> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>
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
> You should add the Fixes: tag too. Based on your description I guess
> this should be the tag?
>
> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")

Shouldn't this be the following?

commit f8e4f532f18d7517430d9849bfc042305d7f7f4d (HEAD)
Author: Lukas Czerner <lczerner@redhat.com>
Date:   Fri Apr 4 17:18:15 2014 +1100

     check: Allow to recreate TEST_DEV

     Add config option RECREATE_TEST_DEV to allow to recreate file system on
     the TEST_DEV device. Permitted values are true and false.

     If RECREATE_TEST_DEV is set to true the TEST_DEV device will be
     unmounted and FSTYP file system will be created on it. Afterwards it
     will be mounted to TEST_DIR again with the default, or specified mount
     options.

     Also recreate the file system if FSTYP differs from the previous
     section.

>
> I agree with today the problem was in _test_mount(), tomorrow it could
> be _test_mkfs, hence we could source the new FSTYP config file before
> calling _test_mkfs().
>
> With the fixes tag added, please feel free to add:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
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
>>   		if ! _test_mkfs >$tmp.err 2>&1
>>   		then
>>   			echo "our local _test_mkfs routine ..."
>> -- 
>> 2.34.1

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


