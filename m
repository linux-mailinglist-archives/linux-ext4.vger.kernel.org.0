Return-Path: <linux-ext4+bounces-7142-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36C5A812B4
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 18:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8AE4E2257
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8D1231CB1;
	Tue,  8 Apr 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZmna3Vz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B251D5CF8;
	Tue,  8 Apr 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130642; cv=none; b=DGR+Dp4+r/uvT7cdfM4w1ucJGwWGWOurwfE7QIRg/w+ujxus+vTTf7px8kRSBrSR2m9T/OAwIC1oIsCJftAqJpjUSAZr/mXneeF4QBiO2YlKTOtW0tuGCESpThIIXGtT7OOtdgbN0MT4e7kZgtu/gqYgzqp9TS2iMmDwt5SsdF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130642; c=relaxed/simple;
	bh=Ojk5OViEKUCcr3YUWTJco5zlv1sFpKvptFMWlLMi+l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oU+1E0xjrAV8WoVvE04Du4zswBvbuDqtTEX8alm3hUwwrAhAndUFdU47f48xMmcht5W0ek+E7nWszeK327rH1qAp5jgKlOkAnItMkaxnaSkSXaLknYx1fW6HJd0FdeLiiXaXBGG/CUoTup/5mH4qjj8vdEUkB0q9zvC7Vzs+BcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZmna3Vz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af6b02d9e5eso4044271a12.0;
        Tue, 08 Apr 2025 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744130640; x=1744735440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMzApreeBbDaWRj5R3KuZRrnpsLYeSAfDX1fgiqxEX0=;
        b=gZmna3VzyS7Hi+NiX54Jr9p5XJIQyCVU4h3nNwf/CQ2e6GqkKOqIFjEYt68x82fvyJ
         ZV/kvtvkaNZEO2IBgwke0SkSQVqH1NSeICnHA56uhnaIS48It5cdryiODPAOVYqyCLj/
         2KgMZwMi77+nVrdsCcCTXmjSqViAHFOT8WfO9Z335wCNLX1eLcZga0izlq4MKsYxjcP1
         oby6SrvEa7A+nQXsKJQx64zEE30FVSj41qvYkOsxvRAKotavWoJvwcBo00TMD7ZfOn7g
         O/zjb8q5ynDSONoIRrwn/y6PnLKe50ON+Oq7Bm28N1WCuL0EbuxLg+ScAceo+UY7rlLo
         DhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744130640; x=1744735440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMzApreeBbDaWRj5R3KuZRrnpsLYeSAfDX1fgiqxEX0=;
        b=SMJa7CElDSPuzFDogYCXpibGuzDIheQbR2DYGVn66MtrEVo8UEPejnx4DKxaEGA057
         xXy6nWw1tcDODFia4Z+jXCtoifvNPeDaQevv9JjrZQsd1MltDoapwvNq7PVHuMBfj0rM
         i0c6qUO0cSLkUbJ7d14qKSW9eBdke81/aU4QWXa9MfBuWAWRURUbSgkE2KTuasezlxA+
         F8Fh9ynN2irFgI1kCBUcO7SwMeVBZjmdC9uEJjX3cjv0ja3mLXEdSN8kn34qHk9tvO5D
         LhSPKR/rJTa5zsdGnTPlkv2V5s5rJLiyECjybfhdoJ6omfH5XlFh2WzUQLUbynwO2i3X
         aSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwDww2pXTFTgKZ/0MA1Pk0D51uaUpEdRb5vYDfs5Ftr3CnQPfJsVl0/pKev5s+REiePoJnW/yDVFy9@vger.kernel.org, AJvYcCXxqbEH55uDR29ij0DNJT4Kv7rIMFN4FLx8Xu0tyJI84nrHqijaIG2LXnoH1rzRidOORU+o+k4O+wmB@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5FeHZWc2Sa3K62UYCN2NGWly8xGM0lL/iGKwV4jygeL1rDpv
	e6R4sSCw6LsEzuVXpysfthQwATErxCyZAZXPvTCf1AnwpbjoKez+
X-Gm-Gg: ASbGncvc9U1NjxKeR6sIK+jErGrVGyNH8ftl32xK+xNOJPOKu+D8x/8OvW0cCPVcRn4
	x1is1vhszeSafy/3ve/v1IOgT6RGMZ/AEKi1/858j7TN1NIKDHU1zpV1Scb2XW6xMHOjkAiaXv6
	18itHzsb6OKaVUEHWOambpkto2r6AjFoIL4NPFaa63XXS53uhxiREI1jkPj3+uV6XtN0W7IRFn1
	ef1M1rvqcrtztPU8ZEq4fbu9CBkCVeJ6W+L3zeZIU2pZH5hAN0tnk4FuiX2kvUcG/vD+GqguQmg
	Fl6tiYw7aM88vYrcHc/fZKabas59/7Q6X3IXOHbTaX3JCmmj8GhIK8eHUP6QVksxnyyL10gEczl
	6W3xv1tv7KVuXfutcAkbZphqlM08D
X-Google-Smtp-Source: AGHT+IGtgfuJoR0WAzMzmd0kcigb62CvlzLHsFYBHc3ixOP809i80HsiVHGpsVS9z3DCBIOHCCfJcA==
X-Received: by 2002:a17:902:f690:b0:224:912:153 with SMTP id d9443c01a7336-22a8a04ab76mr245870495ad.5.1744130639786;
        Tue, 08 Apr 2025 09:43:59 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f2a:4b1d:fee1:8dac:3556:836f? ([2401:4900:1f2a:4b1d:fee1:8dac:3556:836f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785bfffasm102951585ad.61.2025.04.08.09.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 09:43:59 -0700 (PDT)
Message-ID: <37155b56-34ba-4d5d-a023-242abbe525b5@gmail.com>
Date: Tue, 8 Apr 2025 22:13:54 +0530
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
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
 <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>
 <Z_UJ7XcpmtkPRhTr@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z_UJ7XcpmtkPRhTr@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/8/25 17:05, Dave Chinner wrote:
> On Tue, Apr 08, 2025 at 05:37:21AM +0000, Nirjhar Roy (IBM) wrote:
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
>> +_exit()
>> +{
>> +	status="$1"
>> +	exit "$status"
>> +}
> The only issue with putting this helper in common/config is that
> calling _exit() requires sourcing common/config from the shell
> context that calls it.
>
> This means every test must source common/config and re-execute the
> environment setup, even though we already have all the environment
> set up because it was exported from check when it sourced
> common/config.
>
> We have the same problem with _fatal() - it is defined in
> common/config instead of an independent common file. If we put such
> functions in their own common file, they can be sourced
> without dependencies on any other common file being included first.
>
> e.g. we create common/exit and place all the functions that
> terminate tests in it - _fatal, _notrun, _exit, etc and source that
> file once per shell context before we source common/config,
> common/rc, etc. This means we can source and call those termination
> functions from any context without having to worry about
> dependencies...

Yes, I agree to the above. Do you want this refactoring to be done as a 
part of this patch series in the further revisions, or can this be sent 
as a separate series?

--NR

>
> -Dave.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


