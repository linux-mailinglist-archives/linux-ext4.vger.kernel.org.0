Return-Path: <linux-ext4+bounces-6105-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D437AA118B1
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 06:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57901684EE
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 05:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445422E3F7;
	Wed, 15 Jan 2025 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSW/iI92"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAE4C6C;
	Wed, 15 Jan 2025 05:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917591; cv=none; b=kKrQlBBNAA0SRPL4houyNW5VWlvqvT5oKWy0flMrB5NLmQKAFwCf8Y9m9lq8ll6yR/4YHoYK2tZCpVYUVYVQARqq+AsHb/fTR++pcjhu6ID5Yoxyp5NfzeilNLkL+bJbJ+RRYjNvrfvzr3WFhjOFAT0WepPr6DvySB2uKxlTeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917591; c=relaxed/simple;
	bh=KjgoSbXszLXoXHoi9/i8h5dy1czUZuku0z3G/aDzZk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Odith99tXnZPCMtoMnh00i3B9NZGIiTHx5/+aF/8ZqgpRUBF7RPXWd6YHkBh4g+0l7M58XOzeSjrZNId2I55ZsuyfTPVznTx1owcuLSOJZzFlu1XoaE8stwl3ufWTwuPmsCGgD5XdavLlC4Uo/HNahVAGo9jfWpSBSh41utSslY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSW/iI92; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so7938793a91.3;
        Tue, 14 Jan 2025 21:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736917589; x=1737522389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAOTT5u9dBdg3GPbM9mMYLriXpbeNHlQ021icnWLTLk=;
        b=jSW/iI92jbyWzxyvtH7rpIwffyxGm3pPIgZ6TnH8JifVduXNqYbl4nnZZO+37uKx3H
         4SV4ttZun4Ni7FYM7eC503iDXLuMJ5aQMKlI3NeQEEy32MLQCxXBI29xE1hN+JZz41f5
         oTCEK8IyUyj5Zx4Ygo8OzT6cMibmTjvV8iclr59BVv2Zi04xya9ZK2M8boM72OSrRcDc
         0mYecgJw3Rp5x4uPFo0upkpc0C+b0vQLqIIEl5OU4OQGnBNyRMl+RZBkZA+Hw+R85l+I
         piG8wx08ZoOKcANyjpndCfu6wwlCtjSzPhlNdlW/brl6bQuaX64PxzNTuUC6cEcEvKXx
         MyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736917589; x=1737522389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAOTT5u9dBdg3GPbM9mMYLriXpbeNHlQ021icnWLTLk=;
        b=wPm6qx+1f3tx8TOfqgZbMtR/48AKGRrcLav4vhivppCuQGRvQ90dj086Pwrb32r+QF
         CKse3KIXjul+1gaaNmqnc/+c9nL5fdrvilt7b6x3/anCb/+sVsQM3iMhFUzPvs6StA7C
         ekxcA74Oh4+sqLQqE0qE+SzV6pTDRuYKTuogGY+5Baf00JbmXLYY7UjkpFj88aUK10HO
         sDHQz57KESmdZqAB6dO0UtRIRix0pLlCtrN1TXMYDooubtNCL2hkul8QQEJIwDLsesdO
         uVV0LiVFSmEM4KV1gWLj7q3mJfk3kw510yxWm/6m16ice8KpXxVXn5g1VuyFoiCCcLAw
         8W1A==
X-Forwarded-Encrypted: i=1; AJvYcCUT+5OhayKTcc9+Dv1o+mwms1/Eou5+/P/OjfFO2uQOGWwOexgSkXq5Hjfz1eA34w+Ki/Bur2pH0T8P@vger.kernel.org, AJvYcCXQNPSM4KAKRxM2ElNUZ0Lma+Ihob5ku5GvgEmTrG1B2HTaTBJEW/eMy9r1OZmgDK1jk0Jj4ovZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzsUvn/J0tjd1oqT31YOu39tPEGPVRxYRDJFQ/Idi8ilqx01rIJ
	hu3krM3CBanC8ae/YjfOePTn0VMKmNJvXxyIzdZ4hbD39AMAwn67
X-Gm-Gg: ASbGnctVKlElAr91BxEE47Z5Uh5AfIUn8SHWEy7dEpAUi1McwCes9d9FKtAN1RumGBg
	XX29sGor5exqIIFo8BAxqW21yrOjQatT1T/OuAHkNCXlXFi6ncUIviDd5XlBkboo1NkD5IFKLDm
	p7avHdIF0uTXhWgK9SI9pKYZ9bvHjwv5pdnqdiVxtkcoYPpN2ZAMNfsBsQ9OUpyfitOyoQyI8C1
	8U4Q66RoBLU4Ypq3B0dvfRy3ojROJSSrCV/XPEBGTCNdmadLr8uQW6gDdrZf/nBzpw=
X-Google-Smtp-Source: AGHT+IFBO7bEIoVnz0xv09HqB5Oh2UyxG6XEz0Z4PImafkbM3lSX1dudvpHQgcxkT4x1BN+HQ5ej2g==
X-Received: by 2002:a17:90a:c2ce:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2f548ebba5bmr41082025a91.11.1736917588826;
        Tue, 14 Jan 2025 21:06:28 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cd597sm424841a91.24.2025.01.14.21.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:06:28 -0800 (PST)
Message-ID: <4f489dbf-b47f-4b1a-9299-e6d0b6ef2369@gmail.com>
Date: Wed, 15 Jan 2025 10:36:22 +0530
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
 <87jzazvmzh.fsf@gmail.com> <1efecce4-f051-40fc-8851-e9f9c057e844@gmail.com>
 <87frlmvi2u.fsf@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <87frlmvi2u.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/13/25 21:09, Ritesh Harjani (IBM) wrote:
> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>
>> On 1/13/25 01:11, Ritesh Harjani (IBM) wrote:
>>> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>>>
>>>> Bug Description:
>>>>
>>>> _test_mount function is failing with the following error:
>>>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
> Please notice the error that you are seeing here ^^^
>
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
>>>> call _source_specific_fs $FSTYP at the correct call site of  _test_mount()
>>> You should add the Fixes: tag too. Based on your description I guess
>>> this should be the tag?
>>>
>>> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
> Please look into the above commit. The above patch introduced function
> "_prepare_for_eio_shutdown()" in _test_mount(), which is what we are
> getting the error for (for XFS i.e. _xfs_prepare_for_eio_shutdown()
> command not found). Right?
Okay, now I got the logic. I was thinking of the commit that added the 
entire "if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ];" block 
(where the sourcing should have been there)
>
> Ok, why don't revert the above commit and see if the revert fixes the
> issue for you.
Yes, I can check that.
>
> https://www.kernel.org/doc/html/v4.10/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Thanks, I will read this.

--NR

>
> -ritesh
>
>> Shouldn't this be the following?
>>
>> commit f8e4f532f18d7517430d9849bfc042305d7f7f4d (HEAD)
>> Author: Lukas Czerner <lczerner@redhat.com>
>> Date:   Fri Apr 4 17:18:15 2014 +1100
>>
>>       check: Allow to recreate TEST_DEV
>>
>>       Add config option RECREATE_TEST_DEV to allow to recreate file system on
>>       the TEST_DEV device. Permitted values are true and false.
>>
>>       If RECREATE_TEST_DEV is set to true the TEST_DEV device will be
>>       unmounted and FSTYP file system will be created on it. Afterwards it
>>       will be mounted to TEST_DIR again with the default, or specified mount
>>       options.
>>
>>       Also recreate the file system if FSTYP differs from the previous
>>       section.
>>
>>> I agree with today the problem was in _test_mount(), tomorrow it could
>>> be _test_mkfs, hence we could source the new FSTYP config file before
>>> calling _test_mkfs().
>>>
>>> With the fixes tag added, please feel free to add:
>>>
>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> ---
>>>>    check | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/check b/check
>>>> index 607d2456..8cdbb68f 100755
>>>> --- a/check
>>>> +++ b/check
>>>> @@ -776,6 +776,7 @@ function run_section()
>>>>    	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>>>    		echo "RECREATING    -- $FSTYP on $TEST_DEV"
>>>>    		_test_unmount 2> /dev/null
>>>> +		[[ "$OLD_FSTYP" != "$FSTYP" ]] && _source_specific_fs $FSTYP
>>>>    		if ! _test_mkfs >$tmp.err 2>&1
>>>>    		then
>>>>    			echo "our local _test_mkfs routine ..."
>>>> -- 
>>>> 2.34.1
>> -- 
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


