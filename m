Return-Path: <linux-ext4+bounces-7074-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75221A7B6FD
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 06:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329A316E34C
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 04:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8A14831E;
	Fri,  4 Apr 2025 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXLMnhk7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F5A95E;
	Fri,  4 Apr 2025 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743742342; cv=none; b=pJC3hK5zMqeBxXKdGhoGMqoGyc0z3/CkS0S5gfbNUbi/Sq4JK1+DrpNBM4O86HsoPjFCv+tufUKC8mJHGB/9uhO0fZTzMFmA7I9sUvi+srS2kZyoXYVW1JJBpswJCa+ApD7irC5FEsnZzwasPik86fDTRDGMQ+s6Rh6yygViQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743742342; c=relaxed/simple;
	bh=oROJ0S0KuLRcoNOw3Gbsbzd49wgJU4YAd8L57FP0WMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwstVkBPjbsmtYm9057CJ76Gl2dKUsKVHrJ12E8DBSumpjamvn4A2x0RZQjFFOVuS/Pzw13+tbT9BTvUlBGezrdbd8u1tlTv58O709c3dVxe/6TVtMD0HnNvclGrD2/IVF+DM04Mq34XH5eT5ypbYVCvpyOQZTUyC+EcyaRcVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXLMnhk7; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso1708305a12.2;
        Thu, 03 Apr 2025 21:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743742339; x=1744347139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSZ1dpvznv37gbkz+Kv0zeLTDnd7KwJJdSzSu8UVzOY=;
        b=hXLMnhk7e1FRqf9TCVRS97t9ZynyxozW/kFPQUXCL1oR0GQno5m+aoS47JnTkBO9g/
         p4UUEyLDLeo9gYMP7Z4alhVADxTuP1O1pqC7xwV5YuVN6P2Nfu5TxDWepeCz/v4MkJRe
         Q0ERctniPUaQ8uzphDqzLCnJ8I48gK41gDuZpblZyKnR+clGevDrSSvtLXyTHqLKm/dg
         OJ72Lr0xsDOcF/RWmbBV+WbMbboy+IXHUnBlce6SjQ7Og2ovhYkzCtRypigxNahsnJuc
         GbfnyAsXbdz1XAHq5gbvLSmrN3gqX5QOvzqfej49IxVgiW+gQlRIdGxsYwQe9nBkh3+U
         06Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743742339; x=1744347139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSZ1dpvznv37gbkz+Kv0zeLTDnd7KwJJdSzSu8UVzOY=;
        b=n+nMmdF8tLSWgjM8CZYgMYOaaaMuolPvPUz9NCinLj7z2Yb136DsLW2M+yfB793BWQ
         hw3iS3ZGRC67gwzhDZnuP/MFciSJFBg4Bk1avG2KBishZS7NR4TPB1Uwoh/2UGAPc9Yo
         727VSeQczJ0FdgZIWU/8A4UqbnJhwPvePJ10JQNnPkcS1xTecV/UZRWgkQpiBTAcvuxK
         3Rahu81yOoKJBqCEjBanrid2exRNd5wFLhc19MWIM5lKXhE93QtEy1gLYPgf4CY93xUU
         nrJZCEiXukQb4Imfk2HThaXuJQtzuFvjJxQ450gVfZMeLDjsXtRm+le0W32dFMjM+nss
         SpNA==
X-Forwarded-Encrypted: i=1; AJvYcCVRu6X3NJ5bpK+XR75J5qUDY/G9Rf34xpumSwy2Yu2l4XxaH6bFPeQ7f5hTF9bgL/o4TRLUNNhQ@vger.kernel.org, AJvYcCVV8pP6tj8kZ4+qNDK3+M0Vy/8NsuxLGXQF4ZTrG3FEWYVnoVbcPFAWi5xuxjl4JLSMW7bTxpwz3H0d@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUoKHzpxJIZa//jKAlKrA04SNA6vylozV0HCIS05eW0yGQKd4
	ufze4xVr3dZa8oj+Z7ocyuxTEBtTMCgwae/oLhV8noMVun0AGg1E6imSgg==
X-Gm-Gg: ASbGnct9hLtmFhjNBZwjOkMsdCDH0T7FEmOj0H+wtyJYD5dhonn9nYQoHiKU/y71JmV
	JRb7YzJnrLqZF+dBeU+5Fh2B9i5B0vgqhHmSaNJHt7B87VT9rpdOnw7QCR6QwFJs0jJZSxs0hoT
	wqryqM27f9YTG9GprffkozSsEsodcgQw9t00EgRaPttodRzboh41JqL5SkTLWfQcm4pAQAZAUid
	2ykRcCuSKIYkwsxK8ES7w6S2m0GMdN/D1MtT6H1/q5I7HoSbfCl8vV+aQzh4CKKfN6QpBaSJofO
	z0d2CQ2X+/+uhG8FaR4vj7ArCFP0bgzpgVJoFzSxxg6y0pBFP/TtgrpHjm4jcDWGSg==
X-Google-Smtp-Source: AGHT+IHrLpi+tu/RYuos1j6wvwCrwiFSKmTtX4ZVMFn2yudh1HFTs3FjWKk+EOUEWiN4P6+H7dNFvQ==
X-Received: by 2002:a17:90b:280e:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-306a48b391emr3100518a91.33.1743742339429;
        Thu, 03 Apr 2025 21:52:19 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866d094sm23443715ad.166.2025.04.03.21.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 21:52:19 -0700 (PDT)
Message-ID: <549c229b-5d6a-4963-a8a4-18036ceb5cbf@gmail.com>
Date: Fri, 4 Apr 2025 10:22:14 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] check,common{rc,preamble}: Decouple init_rc() call
 from sourcing common/rc
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 david@fromorbit.com
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <ad86fdf39bfac1862960fb159bb2757e100db898.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87r028vamn.fsf@gmail.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <87r028vamn.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/4/25 09:30, Ritesh Harjani (IBM) wrote:
> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>
>> Silently executing scripts during sourcing common/rc isn't good practice
>> and also causes unnecessary script execution. Decouple init_rc() call
>> and call init_rc() explicitly where required.
> This patch looks good to me. Please feel free to add:
>       Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>
> While reviewing this patch, I also noticed couple of related cleanups
> which you might be interested in:
>
> 1. common/rc sources common/config which executes a function
> _canonicalize_devices()
>
> 2. tests/generic/367 sources common/config which is not really
> required since _begin_fstests() will anyways source common/rc and
> common/config will get sourced automatically.

Thank you for the pointer. I can have follow-up patches for such cleanups.

--NR

>
> -ritesh
>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   check           | 2 ++
>>   common/preamble | 1 +
>>   common/rc       | 2 --
>>   3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/check b/check
>> index 16bf1586..2d2c82ac 100755
>> --- a/check
>> +++ b/check
>> @@ -364,6 +364,8 @@ if ! . ./common/rc; then
>>   	exit 1
>>   fi
>>   
>> +init_rc
>> +
>>   # If the test config specified a soak test duration, see if there are any
>>   # unit suffixes that need converting to an integer seconds count.
>>   if [ -n "$SOAK_DURATION" ]; then
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
>> index 16d627e1..038c22f6 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -5817,8 +5817,6 @@ _require_program() {
>>   	_have_program "$1" || _notrun "$tag required"
>>   }
>>   
>> -init_rc
>> -
>>   ################################################################################
>>   # make sure this script returns success
>>   /bin/true
>> -- 
>> 2.34.1

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


