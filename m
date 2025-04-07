Return-Path: <linux-ext4+bounces-7095-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF0A7ED66
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 21:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B65E3BFFEB
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 19:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7418A2571AA;
	Mon,  7 Apr 2025 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao4WX7IG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20F256C93;
	Mon,  7 Apr 2025 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053219; cv=none; b=r+x9Y+VqnffLcniuKOBrB43DnNFktHZd9fnOTvWOuHaSVaiPIWtZIFUXricWbKhU9FW5ddDqZWMgXQIakStQ9WVMB+8zzkqVitX0NTybgUXJhiEwWFiIdsQ2p7clcvYIPyUh24H4uMMopKpT17dDfrpXw/G8MCm3ihElimnjk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053219; c=relaxed/simple;
	bh=/JCkoMYeYTg+xiv5Gbm1fsTKBxBNPa1SYgZ2XJjo0FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjwSWaPzimqKmk92F4LmCxXwmlbTm+ViToANU9g9qH8B5AYXYy3XR4OiiOA2XBzGtbSnLTh+nHNrRQnpMuDvfZzii8j+zUEyjLnZj+JX7fdTEFVc7GWf1klYay9deoZnLsZQzb14ufcgU+qwDQbToO3pCN/szJzmdzpkyMoJ8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao4WX7IG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223fd89d036so55757745ad.1;
        Mon, 07 Apr 2025 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744053217; x=1744658017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDngx8onKZRLk0PfYYDyEVgWcLIqibcCPgS4W8KKrUY=;
        b=ao4WX7IGU0cohgXSpPL8ulTBnSzaHBSci2bKjfWt4SYjfF5GmbYnWBR7wg5bXKtC6d
         ibC8Vx4iiHegEXDgzlknmbw02+HTG3Bj15v63++7241xE/7SovZFWnI7597txcW1Gn/Z
         6s0+86WLHqSBHvtoQyWJFA+rVtHrzNazovZwhqiD2TA7nWOf+FjUDnNJVmPqg24IAh7m
         h8YVyNeGu6UMmxqPIPt9GJ7jmn4UGdFIC8fOCTHMp77YgbXIQjwzKQOnrgc1JREcN5pn
         CLUuZtUTN0+ExQ4jsQQK6MGY7FwmmBOa4jigaxzTMEiWpCXKtQ9mDjHeSr0jlUj3wWwc
         aQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744053217; x=1744658017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDngx8onKZRLk0PfYYDyEVgWcLIqibcCPgS4W8KKrUY=;
        b=HfnVrGrnNcPyOFAYw6vhxJj0grBvuk4CjB/LBCHdwpkVRzcEzTNBU4AgnTYG+5fyt2
         wEpvjJQ1xwb+9eZBCpu5NYHOEEbyP8CIQzyWBnS6rND+Rs5xhNvTNTUU0BKEDuNr4zit
         P3sPIs/erkcDWoyhdVyhSs87+VhHzG7uxtuaQISDdx0gLMscaABWlRy+hPU8amYOvmkz
         U+KCV7cOoys/lXexn1xZ/kewWp4HMLDWZVP9c4GiSyybyzuTjbQOIuZdKWibxtT8tUQO
         LbBZfJW2uj4PTqy2OyFlIFTMBnddM4/HxCFPhIKk7L905by/01O8iwL8uZMNwYszFxMr
         KPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs4waDdrkwDjVte0QbMpOGmaBbRiGD+yDgCOWVriCOGRcmyfAJ7R2Ot/1sIJAcnqeIW/9OkEqj2dDh@vger.kernel.org, AJvYcCWlAKNKsMLgHvqbz9zwCcZBZGHwuoVDqMDe2P2MOqVahXectJnfGsAtQx/Aujp+9SSqAoMi0ppau0k1@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOX+yItawyy3s+5l+woF+hjr0zuERfhGvrOrPT4ZEuwHR7Xkp
	JWZmd4pSqkaQLw2DnOV9lpUt0fw+ksLyUL0nXiFvd1+77bFwhFxbOLGf0Q==
X-Gm-Gg: ASbGnct+8q1GYl0PqDe8ooJp8gB9GwqfbE64EGOAVdPZ8vIrXGDB1feJCFrGFfvG4yD
	/b01Ba2/EBGfHQvSurgwA/w5447tNLmS3P5rN2zHaLzEKCDCLlHCpyYU4I5CH/kjDmewZaRU8To
	8/KJwIQQYJqsmH4s/GIgJXprAh8SqcOBAzuf21jcQNfWixq31RpZX4FN5DJpiM8yDyOa6kFT8uN
	l5iWzaCBMLRR2bvJJRguxjK+SHXRhkLGpYABsh9tuQ3YSRtk5JH7OdxlO30ibCLtTVT3rRTIBm1
	H3t4W+DQnoYHhMKHBEAsCOZitWDY6ACecKVG704rhu/pUdQbZqGqYxhrjrGvBsyKiA==
X-Google-Smtp-Source: AGHT+IFBJOI6Xjxk3xrcSshSP0nnxC3Jh0sfVtuQXYHi8al8EmQEuXspLibXcpNt8bFGW7cW/RMhNw==
X-Received: by 2002:a17:902:f54f:b0:223:88af:2c30 with SMTP id d9443c01a7336-22a8a0583d6mr180737055ad.16.1744053216827;
        Mon, 07 Apr 2025 12:13:36 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e280sm84891455ad.186.2025.04.07.12.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 12:13:36 -0700 (PDT)
Message-ID: <3c1d608d-4ea0-4e24-9abc-95eb226101c2@gmail.com>
Date: Tue, 8 Apr 2025 00:43:32 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] common: exit --> _exit
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org, david@fromorbit.com
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87mscwv7o0.fsf@gmail.com>
 <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <877c3vzu5p.fsf@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <877c3vzu5p.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/8/25 00:16, Ritesh Harjani (IBM) wrote:
> Zorro Lang <zlang@redhat.com> writes:
>
>> On Fri, Apr 04, 2025 at 10:34:47AM +0530, Ritesh Harjani wrote:
>>> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>>>
>>>> Replace exit <return-val> with _exit <return-val> which
>>>> is introduced in the previous patch.
>>>>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> <...>
>>>> ---
>>>> @@ -225,7 +225,7 @@ _filter_bmap()
>>>>   die_now()
>>>>   {
>>>>   	status=1
>>>> -	exit
>>>> +	_exit
>>> Why not remove status=1 too and just do _exit 1 here too?
>>> Like how we have done at other places?
>> Yeah, nice catch! As the defination of _exit:
>>
>>    _exit()
>>    {
>>         status="$1"
>>         exit "$status"
>>    }
>>
>> The
>>    "
>>    status=1
>>    exit
>>    "
>> should be equal to:
>>    "
>>    _exit 1
>>    "
>>
>> And "_exit" looks not make sense, due to it gives null to status.
>>
>> Same problem likes below:
>>
>>
>> @@ -3776,7 +3773,7 @@ _get_os_name()
>>                  echo 'linux'
>>          else
>>                  echo Unknown operating system: `uname`
>> -               exit
>> +               _exit
>>
>>
>> The "_exit" without argument looks not make sense.
>>
> That's right. _exit called with no argument could make status as null.
Yes, that is correct.
> To prevent such misuse in future, should we add a warning/echo message

Yeah, the other thing that we can do is 'status=${1:-0}'. In that case, 
for cases where the return value is a success, we simply use "_exit". 
Which one do you think adds more value and flexibility to the usage?

--NR

> if the no. of arguments passed to _exit() is not 1?
>
> -ritesh

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


