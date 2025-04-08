Return-Path: <linux-ext4+bounces-7138-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A79A811D8
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 18:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386C27B9520
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7E22D4C1;
	Tue,  8 Apr 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT4LFHV3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B322A7F1;
	Tue,  8 Apr 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128960; cv=none; b=gh7z+Jl1gNbJC/UWC9GKft+38ya7Dbb/ZnPTvV9Dg409O43gQzQamfKnwuHc+uWCdRrYpFJHfIS1WRfZdhYKREz7IyL0ebuKqPEh6s8oV1mRwkbIbyBHebC2o8RNGWxuZvtPk18qaDv6xOA3kRMuWTipV2c73D4XbIxbrsFzg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128960; c=relaxed/simple;
	bh=jMbAUfVzSNQk5Ihi8vbFiGB8kuJXsshSh1t5APcKqF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+4pKSs51TjTeJPiJ497FCYs+Alv+lbWPk8HuRT8AGOp3ikdkQr23c796RTWKxd+l5GdkR3BxETeAc8EZEUemB2NlFavb3F+WzYuaqDh/BGE21/XmbXtHUv/+yNlAnka26Vwm1FDLht2VDC1DiWFdJGoXVFtqHkEoYZW5VUWYEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT4LFHV3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736a72220edso5917374b3a.3;
        Tue, 08 Apr 2025 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744128958; x=1744733758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2o2VWJn8/GbhyPU/E3WQ4qOkPcUXW8Wy0LE0pd3784w=;
        b=IT4LFHV3UspBHKuLZ+Jkj5tf+hNQOIgQut0oDcQewZ+C8Bv7HTFvJDjIhGqjFLv9kI
         533REH4DUfgxNeGof0c9rGH6NWrXLs7w4aWFDsEgjn6pMgE0cfvyz+NWIt8PUnFHCsct
         cE5yUZmOPgSUQMLKgKwzIy/LH+WypNrFIgZ6+0TAfhjNdXGp/IqOeQpPOiRgeZSKNAH5
         MSWK1mDCKKdzo5j9hDpe2wAow4hotbq9f+GGhnGDHDZxccsmB0Xn99w+Ky4/vc1WSsQH
         CPd2AQcXNVWcxnMQX3jtYOVAxrrDLTKtF6BvlZjuVXoJGDOiIchvSoTNgxEa2aJ5J4rm
         OZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744128958; x=1744733758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2o2VWJn8/GbhyPU/E3WQ4qOkPcUXW8Wy0LE0pd3784w=;
        b=UquXNqvMnVwUNJXmZJ6oA6J+kw+NS6iHyQmueKB4aJi4fOK5w9jTlp7L7ch2ORkzK+
         eqnZvLxhfy0QJQnYnB12SXNKQoxCXNjkXTsMM8kd4ltE+KGzhjnzWoMCcCeLVRIyEEdR
         kNt1CKrdAv+WtEYdaUQz3sitzdBBOpMcKzBMMyyzMq7dNIbGSIp+ntV3s/KrX9/TZ6/T
         saUtknHh51VqSg1VszOJeLwCOnr01XtjBcfPHUgKlqvmarbZ85md70rYuJxdfTzvsIGu
         X/WR8Q2m2uZixr90m7uQOhOtgzI8v7utwMp1efm789KbGWdmhxAhw47NZGYOxoqYmSSY
         JZmA==
X-Forwarded-Encrypted: i=1; AJvYcCU3dA5Fkd9Le4wpI1/LgnpApo3trMA7VkT+vvyteWJwEw8Kp+POuJS334esE8YaBdpFxAIJ4mWxKlWm@vger.kernel.org, AJvYcCXeffgNksFNWKuKe7K24WrgRL6qDv6+zUv9SVefZ3qWChw+b6bu6djcIGqNcn2sRdnQ91wB/llt@vger.kernel.org
X-Gm-Message-State: AOJu0YwjOLPOp1cCPNbmX1di9DtCAf2ROi6LHOC1kvHjvxSbQhoxaKRQ
	lV2jEclVv+3XcsBTqkBcubzHaogF8QknoFpGTcxF6hhDrAQA+6VA
X-Gm-Gg: ASbGncu/0J2w2rDGmGnlaOBeURppwTrtDQWKxosnkOzcNEbQpr+g7uMSG3B+cL5ZlCd
	XXJ65Bwa6Ca0ZCE5g99s1k7XOiABkqF1UWYKTKYU+waB83cvE3dhsebpQpWymLWFDWWOgQfyoES
	5H/3Zfomi29M1+hbJFkVCAdvAdv5PFIqBhfrziQgGg3FEpNueCmOPUGqSdc5spJqJLXi49Kq/8N
	qXuKMmXkcXMGFMubYmYPFD2K98RAJRlpx/JHk+9VZXiFTXBrCgd8LVx+AByvaYHcnP8mO0NxrtL
	h++HIjYGbrSvoKecu79orP7+xVXrpVtMB4gtFNbzAN7jjp6bD430qm0hzTaJvjZHr1tcvNcAamN
	PmwgsfPqWX6INXk5j4R2M5zfmy59H
X-Google-Smtp-Source: AGHT+IHTY9jipPKHFJfXmSpBFz5laTCTHFJUNflsN2udZWTKkJT9r/HCR/cPmM5KIBGov338noS8nA==
X-Received: by 2002:a05:6a00:ccc:b0:736:6202:3530 with SMTP id d2e1a72fcca58-73b6b8f7617mr15959480b3a.22.1744128958164;
        Tue, 08 Apr 2025 09:15:58 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f2a:4b1d:fee1:8dac:3556:836f? ([2401:4900:1f2a:4b1d:fee1:8dac:3556:836f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d17absm11095522b3a.17.2025.04.08.09.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 09:15:57 -0700 (PDT)
Message-ID: <0e4817b5-bd20-4ea6-93f4-ec0bee9bf833@gmail.com>
Date: Tue, 8 Apr 2025 21:45:53 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] common/config: Introduce _exit wrapper around exit
 command
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 david@fromorbit.com
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
 <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>
 <87y0wbj9ru.fsf@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <87y0wbj9ru.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/8/25 14:43, Ritesh Harjani (IBM) wrote:
> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>
>> We should always set the value of status correctly when we are exiting.
>> Else, "$?" might not give us the correct value.
>> If we see the following trap
>> handler registration in the check script:
>>
>> if $OPTIONS_HAVE_SECTIONS; then
>>       trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
>> else
>>       trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
>> fi
>>
>> So, "exit 1" will exit the check script without setting the correct
>> return value. I ran with the following local.config file:
>>
>> [xfs_4k_valid]
>> FSTYP=xfs
>> TEST_DEV=/dev/loop0
>> TEST_DIR=/mnt1/test
>> SCRATCH_DEV=/dev/loop1
>> SCRATCH_MNT=/mnt1/scratch
>>
>> [xfs_4k_invalid]
>> FSTYP=xfs
>> TEST_DEV=/dev/loop0
>> TEST_DIR=/mnt1/invalid_dir
>> SCRATCH_DEV=/dev/loop1
>> SCRATCH_MNT=/mnt1/scratch
>>
>> This caused the init_rc() to catch the case of invalid _test_mount
>> options. Although the check script correctly failed during the execution
>> of the "xfs_4k_invalid" section, the return value was 0, i.e "echo $?"
>> returned 0. This is because init_rc exits with "exit 1" without
>> correctly setting the value of "status". IMO, the correct behavior
>> should have been that "$?" should have been non-zero.
>>
>> The next patch will replace exit with _exit.
>>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Reviewed-by: Dave Chinner <dchinner@redhat.com>
>> ---
>>   common/config | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/common/config b/common/config
>> index 79bec87f..eb6af35a 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -96,6 +96,14 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>>   
>>   export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>>   
>> +# This functions sets the exit code to status and then exits. Don't use
>> +# exit directly, as it might not set the value of "status" correctly.
> ...as it might not set the value of "$status" correctly, which is used
> as an exit code in the trap handler routine set up by the check script.
>
>> +_exit()
>> +{
>> +	status="$1"
>> +	exit "$status"
>> +}
>> +
> I agree with Darrick’s suggestion here. It’s safer to update status only
> when an argument is passed - otherwise, it’s easy to trip over this.
>
> Let’s also avoid defaulting status to 0 inside _exit(). That way, if the
> caller forgets to pass an argument but has explicitly set status
> earlier, we preserve the intended value.
>
> We should update _exit() with...
>
> test -n "$1" && status="$1"

Okay, so in that case if someone does "status=<value>;_exit", we should 
end up with the "<value>" instead of something else, right?

--NR

>
> -ritesh
>
>
>>   # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>>   set_mkfs_prog_path_with_opts()
>>   {
>> -- 
>> 2.34.1

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


