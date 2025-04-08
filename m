Return-Path: <linux-ext4+bounces-7139-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5C1A8124B
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 18:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD04638D8
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F9D22D7A4;
	Tue,  8 Apr 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B39sshtd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AEC20FAB1;
	Tue,  8 Apr 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129525; cv=none; b=KgI2uNZK6ANnZykNFA9cWl79nOsPnC+SY6MliKrem8W9VUgQL/fNbg7RvX5Ee97BOTtRYR+AarPWCh/XuS1seroWLJObdy4TLJ0i+ETlfQNuIsoJ3Gzo5jv13xEu5zNVNHWWzRDupihsSn81MKNdmpbF3uu0WzXweBigTxTsOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129525; c=relaxed/simple;
	bh=lLWiIeAoDmM1nnma6JgbVP5o6Ib/aDIhpltfurF+F2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glueSQ1ka3cp5bec52f375NyQad9KgdTMFMxlqFXxzbFcAfoG7okMShAE2vfgJD8eB/QRskWsRQrgUhVFWi4xb5V9iC6A6MMct+dykRSKzk57gmSs+qsaDba7dmqhkbJ7H0t+rJeKK6rjmzAunm6ASRGBP7Jj4z6dg/dC0N47wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B39sshtd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb3so3126774a91.1;
        Tue, 08 Apr 2025 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744129523; x=1744734323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nnVvo5lTMLD76mD2SFudScucVI7geR/m+D0g1jF3b8=;
        b=B39sshtdFGEbMD92pG0qiLKr9lP7EFlmn7gttRcQ+Dswx+A5zcMC8py8TUYie7Fft1
         6frWAvnOPJuaCz92tf6fTDPHTK60w7FQOvZjbRc4yB/XA9htv2EiV76Y0fgpw2AvVxTo
         ApCHjOXh4iAKvvIfEPvnebSjXU/4bV6d6gs+zC+ie+kxNBL7y2VdNS4oJJQe/xsTXSJy
         UjiP9y7o3tecVMHAKC8TQHWRmRZrRYYL/vk2IxLiZ7K0AXcnOxCic55/+tBTFiTVY0n/
         2q+7+AwKMjs8lNtwiHEV0B8jlIU9VRAErtfx/T4Zi4O8FM7JgdlI1gJapF7oAE5y6ag5
         cezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744129523; x=1744734323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nnVvo5lTMLD76mD2SFudScucVI7geR/m+D0g1jF3b8=;
        b=Ldd7owyTxmXUo0UiCv0CmRwdJvZEU6o2CVaAe0nxPxud6zEVeRfBEUAAXK0TwDPGgf
         qNulqSgFmhS0//4evL9f0n9wjCC1nK4/ExYxyNRDmF0fUysP9DdBsZ36AKCwc/pSlr3L
         JP140X19FqWM13UG8xIJtwZp/eaC/u371xsfEZnyk8jWZeJyNIgBZ0l2wF2A5zyXCV29
         hfaS2t48Ss9638+e81Pxfd9Im4iNddcwsq6HsoDfE+/RYW16LTsIqkdsfHX6MmhGPXRB
         yFxBoqB35d/aSzy8v9jz1JbxtMY9z3p1oJ9l5lBod9X4aw8FqcylD3amrzO9dnBKOFNM
         q9xw==
X-Forwarded-Encrypted: i=1; AJvYcCWjOA1mKqEJWR2esi3fq1AsGnYhzjG8cyak6b/XLdkaiEi1lKCojBOT0pc7XXxEI0Sext+LSpvw@vger.kernel.org, AJvYcCWy66jhcNHcCltcosnebxuQHw4xCdjHRW363BXWI0nA++0d2+Nc5F2VjYWQIjRVnUm0En68/7ZK+1a7MQ==@vger.kernel.org, AJvYcCXW3mCOAhfWa9nh648GhRyQKPB+tOvqbNrmV9KLMxc9vmAdYkpzob1gNoEY46nzduMD8w5VDJ5egwn/@vger.kernel.org
X-Gm-Message-State: AOJu0YykIBlK1qWCW3npOUlzKtNR0udNuwNMtkqi2MWhdn/3f5UC+maE
	0x/mo2W2sft5SXdtyMgBmHCYzOeoMBbNR2fRq5zoAFw/iFUiz8oc
X-Gm-Gg: ASbGncuooSC9EAtvDYiurDvGQLZkTZVgJShFnMjR3RZVOyr3X8AC+cl1ujDizMC6wST
	ZYHw6PC6Q+mrvWNer2coSzm6zNoieh+EG/lbF/0pH9y3nT/D4/cK8l6cbnaj8icF5MTo3xYv9Ik
	vQ/zKdUIIAVX0xjXCJIwzQuhA7hVpjXW/FZ+ZUkYb0VEpYKeztkILb/1JOhXObI5WHAD9Qiu1Bv
	3+prGfMOKdnnwk/pkYbK7sOI49MfsGzbQn7PLkomYt7E0qrNW9LlnLppGhXNn82NPgKKXOhz8Qq
	AtFfCrPlLdCCEWG2BuwMi1UIvjb8YZR2leMGIUzmeC4jBd/xgTbTYccuEI4GpKJTokpbR65hTdK
	8G0+gpRH7yEmOYc5l8ByybP4QQ21s
X-Google-Smtp-Source: AGHT+IGdXtxGMkhk9a6+LOcO/a/MRzEBAHqJ7DqhPOV81TQOWyCKjsi7PgVfT416xT9dRcPFFiUXsg==
X-Received: by 2002:a17:90b:4d0c:b0:2ff:6f88:b04a with SMTP id 98e67ed59e1d1-306a47ee42cmr26145717a91.15.1744129522738;
        Tue, 08 Apr 2025 09:25:22 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f2a:4b1d:fee1:8dac:3556:836f? ([2401:4900:1f2a:4b1d:fee1:8dac:3556:836f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad8d6sm102709125ad.1.2025.04.08.09.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 09:25:22 -0700 (PDT)
Message-ID: <f8e5a64a-3909-4c93-8b01-67181ed0f222@gmail.com>
Date: Tue, 8 Apr 2025 21:55:17 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] common: exit --> _exit
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87mscwv7o0.fsf@gmail.com>
 <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <877c3vzu5p.fsf@gmail.com> <3c1d608d-4ea0-4e24-9abc-95eb226101c2@gmail.com>
 <20250408142747.tojq7dhv3ad2mzaq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250408143346.GD6274@frogsfrogsfrogs>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250408143346.GD6274@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/8/25 20:03, Darrick J. Wong wrote:
> On Tue, Apr 08, 2025 at 10:27:48PM +0800, Zorro Lang wrote:
>> On Tue, Apr 08, 2025 at 12:43:32AM +0530, Nirjhar Roy (IBM) wrote:
>>> On 4/8/25 00:16, Ritesh Harjani (IBM) wrote:
>>>> Zorro Lang <zlang@redhat.com> writes:
>>>>
>>>>> On Fri, Apr 04, 2025 at 10:34:47AM +0530, Ritesh Harjani wrote:
>>>>>> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>>>>>>
>>>>>>> Replace exit <return-val> with _exit <return-val> which
>>>>>>> is introduced in the previous patch.
>>>>>>>
>>>>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> <...>
>>>>>>> ---
>>>>>>> @@ -225,7 +225,7 @@ _filter_bmap()
>>>>>>>    die_now()
>>>>>>>    {
>>>>>>>    	status=1
>>>>>>> -	exit
>>>>>>> +	_exit
>>>>>> Why not remove status=1 too and just do _exit 1 here too?
>>>>>> Like how we have done at other places?
>>>>> Yeah, nice catch! As the defination of _exit:
>>>>>
>>>>>     _exit()
>>>>>     {
>>>>>          status="$1"
>>>>>          exit "$status"
>>>>>     }
>>>>>
>>>>> The
>>>>>     "
>>>>>     status=1
>>>>>     exit
>>>>>     "
>>>>> should be equal to:
>>>>>     "
>>>>>     _exit 1
>>>>>     "
>>>>>
>>>>> And "_exit" looks not make sense, due to it gives null to status.
>>>>>
>>>>> Same problem likes below:
>>>>>
>>>>>
>>>>> @@ -3776,7 +3773,7 @@ _get_os_name()
>>>>>                   echo 'linux'
>>>>>           else
>>>>>                   echo Unknown operating system: `uname`
>>>>> -               exit
>>>>> +               _exit
>>>>>
>>>>>
>>>>> The "_exit" without argument looks not make sense.
>>>>>
>>>> That's right. _exit called with no argument could make status as null.
>>> Yes, that is correct.
>>>> To prevent such misuse in future, should we add a warning/echo message
>>> Yeah, the other thing that we can do is 'status=${1:-0}'. In that case, for
>>                                             ^^^^^^^^^^^^^^
>> That's good to me, I'm just wondering if the default value should be "1", to
>> tell us "hey, there's an unknown exit status" :)
> I think status=1 usually means failure...
>
> /usr/include/stdlib.h:92:#define        EXIT_FAILURE    1       /* Failing exit status.  */
> /usr/include/stdlib.h:93:#define        EXIT_SUCCESS    0       /* Successful exit status.  */

Yeah, right. I like Darrick's suggestion to explicitly set the value of 
status in _exit() only if it is passed (test -n "$1" && status="$1"). 
This will preserve any intentional pre-set value of status. I have sent 
a [v3] for this series but haven't modified the definition of _exit. I 
will wait for further comments on [v3] and make this change (along with 
the other changes that will be suggested).

[v3] 
https://lore.kernel.org/all/cover.1744090313.git.nirjhar.roy.lists@gmail.com/

--NR

>
> --D
>
>> Thanks,
>> Zorro
>>
>>> cases where the return value is a success, we simply use "_exit". Which one
>>> do you think adds more value and flexibility to the usage?
>>>
>>> --NR
>>>
>>>> if the no. of arguments passed to _exit() is not 1?
>>>>
>>>> -ritesh
>>> -- 
>>> Nirjhar Roy
>>> Linux Kernel Developer
>>> IBM, Bangalore
>>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


