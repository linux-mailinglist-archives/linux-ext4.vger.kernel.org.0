Return-Path: <linux-ext4+bounces-6702-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B08A5608B
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 06:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF701189554A
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 05:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9049E199385;
	Fri,  7 Mar 2025 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7vem+ZN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3E1990C3;
	Fri,  7 Mar 2025 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327023; cv=none; b=JpbyrLAYghsC5Vcu9pCUW5/bBLuD5xfrZWecR6Nqx1GlB/OKnDgZg5dYayAnzjO6vZ7Bq/SVI5oTeTxPD3LK4lsdwF1PGrZOthKA4cQS/3t1sZxEFj5NXAU7rM4yD7fUuCudJewMpRNXs5ACC6YnJI9HUtGzp2whRN1BMFjTaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327023; c=relaxed/simple;
	bh=E+XKrAjprJAEbSNQb5StFu5XuRWHmSHx8RSJaX4FZZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5ipYsRX3r1jKcq7Wgyg7NYOcZIaZER5TFy0cgAwDrv2zahYeHOmgI9P9dhGFLNTl9vsz3JL8ArnGKP5jPrFQ3vzpbJADguYekfm9iJISCoD5i5N0SEEjhjWt/Dsv7+1vdPzLvVznsOVIU+jGYtnI6/4NLvgZCY0ru21UNDLilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7vem+ZN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224191d92e4so21422435ad.3;
        Thu, 06 Mar 2025 21:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741327021; x=1741931821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RJ4GgmaUCeUyiQLhX/4iScj1laeCJdSqSvO0xcP9LI=;
        b=W7vem+ZNcS+zjIN68+JGB3WFVJHfL+MKIsEwIjIti+BK0orBA6umPSZwkB3nTpc2bc
         LePm0r2kF27uUpqnWeef6jY/wDw4W/2KbIEMWlMjSI1p9scDd3w2x/aMMwWE0tE6hZTd
         h7DQ18gLqPRxOUecNKFXl7TDJFRCwlDndF6n4hnJo+o4E1rAPffXmKQWf3yhdJAkMQTK
         a3O019krBeDqhY1Tb1LY/gmx8QRNbwsau5sAokHt4TsINuM/CCDaU19CJWekIshDjoic
         DFJXDi06o53cSjWsLcr2A1O80SLJIh7Kg3Zg4EjElDBuljeE8kkyZBLKnxm8xl35poL/
         2VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741327021; x=1741931821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RJ4GgmaUCeUyiQLhX/4iScj1laeCJdSqSvO0xcP9LI=;
        b=sm1jFKEq7vodw3GA+LGxbCz2D5e26RmurvEijmIwt0Bd5C+QWa4A/XZ1V2Wm5eV6RP
         GjXP/1vi2G3shJtaopcAboOl8YuiyPu3yZlWTjK2UdTSXDKEhJMoZFZiRa9Ih6ZL+JbY
         Z8r+PdYyVeVod2flqVK4v6rTP6yKGLcNTF+Upgxl9lwoh4lYbUdP/aiUz3926C70IS2Z
         /ql8d2PV6sOa1Yj/iZPrMZju0FhMZ3WmdoAzBd+xDwHe8uHoyOKR6vfXSIjMShMYT8SR
         pgfHCGz2icuwsmy1swFAHqOokSJX+7KxIbOV7pDNq4L5YdeZVHKTwqkqLpuYtGLxg2Sj
         /JvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPB6ZxHNR0LZBFZlq+1ChMEteA4/EJNffejQax+44RgKtUeS+AsEBmnS03jv3uy/+HGeN4FnDg5heU@vger.kernel.org, AJvYcCWoCGedRh03ETwRk29/gxtmVQ+TFZJ9+bty93kGSC0eR63iDIchnRmQHwv7sfAbKRAP8eGhhOb3b3ul@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0nc/hKV372QM7N1IJjxxQ/m8HtAkESTRmIabNSgmmRBpqdzO
	LRNMFKcRGbQ/AFJiL8Q6XSWRZdJNbHIkPyvbJQdMkseq90Kz2pnZ
X-Gm-Gg: ASbGncvbU1HYcLtaztY+p6sOkvZEncEN7tX5O13HbPgVf+fV0CUGFuzeMAMViOTqXD/
	h7h+Md5gkcCOjJ7ML3cUY5+0LC5byYtbmshiTu+Re5eJE3Hgs1ISRxspGtIw72aHBskq4/OZk+n
	+yNyRYEU2Vn54I36iZuRtFBBgkUoAh83loXhZpxpk16v60V1Bqk0JKO6aU7tx9ISinMQL5pCHi8
	5iddmB0Ksy5l+8FjG8ksJrkOz0cSjsxAkXk8C5Fn1/wk9xZipwxRNLQN3oHKRJe/ycdHtJ0coPZ
	oW/zBi4uwhR8MpzNLJ2nkjbPRp7JuW5PfDXd0LJl5Zw2Nhyp5R0DQ18=
X-Google-Smtp-Source: AGHT+IFxucM6W+U0CU+hPzKAczQ+Fo4RQQcykP7T5oQxE6tvPEKZVx/IEjDk3GRUV6+N+yktU1Xq9A==
X-Received: by 2002:a05:6a00:23d5:b0:736:9fa2:bcbb with SMTP id d2e1a72fcca58-736aaae5325mr4293622b3a.24.1741327020788;
        Thu, 06 Mar 2025 21:57:00 -0800 (PST)
Received: from [192.168.0.120] ([49.205.39.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369844ce06sm2387236b3a.73.2025.03.06.21.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 21:57:00 -0800 (PST)
Message-ID: <c4fc5048-77fb-410b-b204-308881b9a23c@gmail.com>
Date: Fri, 7 Mar 2025 11:26:56 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
 <20250306211357.fnruffn2nkbiyx5b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250306211357.fnruffn2nkbiyx5b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/7/25 02:43, Zorro Lang wrote:
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
> Why remove these lines?

Darrick has asked the same question [1]. Basically I have already added 
init_rc() call to _begin_fstests() which will do the _test_mount() so we 
don't need the above lines, right?


[1] 
https://lore.kernel.org/all/716e0d26-7728-42bb-981d-aae89ef50d7f@gmail.com/

>
>>   	fi
>>   
>> -	init_rc
> Doesn't the "check" need init_rc at here?
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
>           ^^^^^^^
>           Different indent with below code.
>
> This looks like part of init_rc. If you don't remove above init_rc, can this
> change be saved?
>
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
> I never noticed we have this file... this file was create by:
>
>    commit 27fba05e66981c239c3be7a7e5a3aa0d8dc59247
>    Author: Nathan Scott <nathans@sgi.com>
>    Date:   Mon Jan 15 05:01:19 2001 +0000
>
>        cmd/xfs/stress/001 1.6 Renamed to cmd/xfstests/001
>
> I can't understand the relationship of this commit with this file. Does
> anyone learn about the history of it.
>
> I tried to "grep" the whole fstests, looks like nothing uses this file.
> Maybe we should remove it?

Okay. I can see Dave suggesting something similar and has also given a 
sample patch where he is planning to do the same[2].

[2] https://lore.kernel.org/all/Z8oT_tBYG-a79CjA@dread.disaster.area/

--NR


>
> Thanks,
> Zorro
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


