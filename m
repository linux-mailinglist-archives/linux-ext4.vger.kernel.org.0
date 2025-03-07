Return-Path: <linux-ext4+bounces-6701-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E7A56067
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 06:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD68188F8C1
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 05:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2083E198E91;
	Fri,  7 Mar 2025 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F65regMo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477EC1C27;
	Fri,  7 Mar 2025 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326682; cv=none; b=ojv+olZqjFr2orayzZ4V7T3rsApoy0Pkmlho1T73xEt2OYAC7QfAmTbYBc+VxUSRVTrJQL45hnWNIEjo/SDcE2MUy9dpZGZDTOEcgDPXk5/ll8qB2/iW3AfjpggI/mJAQLenVMa97qFPZi69DyxdJNU0uzGiPSzDVheIJge3GIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326682; c=relaxed/simple;
	bh=N7QfQ818LnaP9EYBqnFiIYWNhDWeK9UxSAuBB5F24mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVf9xhOJRxXPl43uLXiw//UKJiwvY3a/e+BzmDQz8Nen3KjZIEVm6/OBNfV4nWJntX6hQy71uPZWal2X40ddi1/jL0ReOyHMgD5FOyWkfDQDY8xyTeH6h9M9GfwIMXHFeyOezcy7LDsQGiqjdphpRktzSTQZMkyHKVt8Hxaflr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F65regMo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so2306972a91.0;
        Thu, 06 Mar 2025 21:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741326680; x=1741931480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5vkcR+tWXq3UvWo4eKw0Oda2yrE0hWS8QxOpDzT0PQ=;
        b=F65regMoBuuc7VnZtO5aEYCTw9GYCuTLt13oOmDDreXFE+NaxJtfkWvyeHjTaLNQmO
         aHNXJnbNRli1TDH8mMXBodaHW/pThv2RUn9PzeXH1ujQDIUZO5Qj8WqE/7tg5VSiUs3N
         /OYXwXxQxOohptYA1qDz82rDNkF/zb00KmrK9W5mDMPGEAXiZf8CnZ7PtsEcAVJfHl8O
         zyvP7rkWHNz+0Q6Mu/NQXJTsz+C7MfvvNMr707BVk+ZLRsYVDtMk+NWsiziqT+tjVZSp
         Gyy5iK9cecm+RrUC/LvVnpkJxnMYhPv9QTgB4kMxkyXhK+9WaGrepG5zNrMdWd6PCG6Q
         Qi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326680; x=1741931480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5vkcR+tWXq3UvWo4eKw0Oda2yrE0hWS8QxOpDzT0PQ=;
        b=UMqCkqg6h3CUyYsuq5fiePea441FvB6WeEQdQ5/V8AJiijKKx3Pfj8C4+ESvdXphbc
         AlcjQEMGqPaKGGqnapy8XzIocEv23uPUG16l/95NxIXEL0VyjV58Wvef/rlIhYZnC+EB
         kK3/b/8p/mJVeQKWYjR1Z4fSZGfy5zowq2gU22YQM9wPWtnM6y0q1AvGsM0GeFHtW4VO
         66oPKgCNVmXUWRbTNCXV4MgJNY78b//kwQyQAUynG3SZXUej63MqbfxPWFUA/ax+1vxE
         +bua0zRBG/tAnqLX7WY29EXZuzSY33imN3kJG9jUF8ZqLS/vPFk3FGQjVAleOYDkzwly
         Tqcg==
X-Forwarded-Encrypted: i=1; AJvYcCVPyOA2cFLFU+Q2iitNtl9huksvd9zP9TpnEOphv/M2b0uquHttLa428W4xG3GufYcngTdC5B+BOfgS@vger.kernel.org, AJvYcCXqkhSEvO/HnYp71wcNIIZZaJLgVhG0CFlTlCj+FNHewttZZwLTwLXBagl79vJqUJ9/ZxKi6ZAcCiN+@vger.kernel.org
X-Gm-Message-State: AOJu0YzfgXp0syq+nDEsrfDSkM/tBcyZ4TdS1O5B4i6wfPuVu0d1PBN1
	yV0rIMxbvLoGVBfvXgCanvMUZIGxtoJKGURI8LBTs8pH0NeYYEYo
X-Gm-Gg: ASbGncsDXDyjwujN0qqCnHnpaM28ZeXOjCDgO2EHdwGAavxkDg5jbIPNetwT3ZNNzhI
	HA4O8jHFDIgBi7OD7yvOIFL+3/GHEjuU7yH07UmRoqz4vEeUDk8Y+zu8Qd7IcAGUQI5lKtB87Jw
	mvzFeGsyakxyq3JB1hdWfTapwNkaF3aByJ9bgyha1nLLsmopjzkIgUtLlgQuJ/pNzznfHtZTgo8
	yBBqcv4FWtVU3+s8kwejBcoaISTy7JuxPQZF+j6x7HPLyoK4m1RX4gG/vo/kWucXobJmjNbfISI
	iqW4Y5VIbyE4q9Jm+HDIizdX6VJ4TaR4XkW1DgFwtKwMEVYllI5IF6k=
X-Google-Smtp-Source: AGHT+IHgW2yFtUhnN2+llXSdfzN6cZOoFzJ0PNxIZXQVJMcmAnQibISj6yF3etnQBx6wDKeQpCR9cQ==
X-Received: by 2002:a05:6a20:9150:b0:1f3:3e91:fac0 with SMTP id adf61e73a8af0-1f544af00e2mr4214662637.11.1741326680278;
        Thu, 06 Mar 2025 21:51:20 -0800 (PST)
Received: from [192.168.0.120] ([49.205.39.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736985387d3sm2439715b3a.172.2025.03.06.21.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 21:51:19 -0800 (PST)
Message-ID: <716e0d26-7728-42bb-981d-aae89ef50d7f@gmail.com>
Date: Fri, 7 Mar 2025 11:21:15 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 zlang@kernel.org, david@fromorbit.com
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
 <20250306174653.GP2803749@frogsfrogsfrogs>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250306174653.GP2803749@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/6/25 23:16, Darrick J. Wong wrote:
> On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
>> Silently executing scripts during sourcing common/rc doesn't look good
>> and also causes unnecessary script execution. Decouple init_rc() call
>> and call init_rc() explicitly where required.
>>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   check           | 10 ++--------
>>   common/preamble |  1 +
>>   common/rc       |  2 --
>>   soak            |  1 +
>>   4 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/check b/check
>> index ea92b0d6..d30af1ba 100755
>> --- a/check
>> +++ b/check
>> @@ -840,16 +840,8 @@ function run_section()
>>   		_prepare_test_list
>>   	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>   		_test_unmount 2> /dev/null
>> -		if ! _test_mount
>> -		then
>> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>> -			status=1
>> -			exit
>> -		fi
> Unrelated change?  I was expecting a mechanical ". ./common/rc" =>
> ". ./common/rc ; init_rc" change in this patch.
This patch adds an init_rc() call to _begin_fstests() in common/preamble 
and hence the above _test_mount() will be executed during that call. So 
this _test_mount isn't necessary here, right? _test_mount() will be 
executed (as a part of init_rc() call) before every test run. Please let 
me know if my understanding isn't correct.
>>   	fi
>>   
>> -	init_rc
> Why remove init_rc here?
Same reason as above.
>
>> -
>>   	seq="check.$$"
>>   	check="$RESULT_BASE/check"
>>   
>> @@ -870,6 +862,8 @@ function run_section()
>>   	needwrap=true
>>   
>>   	if [ ! -z "$SCRATCH_DEV" ]; then
>> +		_check_mounted_on SCRATCH_DEV $SCRATCH_DEV SCRATCH_MNT $SCRATCH_MNT
>> +		[ $? -le 1 ] || exit 1
>>   	  _scratch_unmount 2> /dev/null
>>   	  # call the overridden mkfs - make sure the FS is built
>>   	  # the same as we'll create it later.
>> diff --git a/common/preamble b/common/preamble
>> index 0c9ee2e0..c92e55bb 100644
>> --- a/common/preamble
>> +++ b/common/preamble
>> @@ -50,6 +50,7 @@ _begin_fstest()
>>   	_register_cleanup _cleanup
>>   
>>   	. ./common/rc
>> +	init_rc
>>   
>>   	# remove previous $seqres.full before test
>>   	rm -f $seqres.full $seqres.hints
>> diff --git a/common/rc b/common/rc
>> index d2de8588..f153ad81 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -5754,8 +5754,6 @@ _require_program() {
>>   	_have_program "$1" || _notrun "$tag required"
>>   }
>>   
>> -init_rc
>> -
>>   ################################################################################
>>   # make sure this script returns success
>>   /bin/true
>> diff --git a/soak b/soak
>> index d5c4229a..5734d854 100755
>> --- a/soak
>> +++ b/soak
>> @@ -5,6 +5,7 @@
>>   
>>   # get standard environment, filters and checks
>>   . ./common/rc
>> +# ToDo: Do we need an init_rc() here? How is soak used?
> I have no idea what soak does and have never used it, but I think for
> continuity's sake you should call init_rc here.

Okay. I think Dave has suggested removing this file[1]. This doesn't 
seem to used anymore.

[1] https://lore.kernel.org/all/Z8oT_tBYG-a79CjA@dread.disaster.area/

--NR

>
> --D
>
>>   . ./common/filter
>>   
>>   tmp=/tmp/$$
>> -- 
>> 2.34.1
>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


