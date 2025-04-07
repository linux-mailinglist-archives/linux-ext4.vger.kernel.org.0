Return-Path: <linux-ext4+bounces-7096-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7FAA7ED6E
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB66188A10A
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F9253F08;
	Mon,  7 Apr 2025 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ359qr5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9F222596;
	Mon,  7 Apr 2025 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053585; cv=none; b=NQGj3kc3rw7OTZnBbGifHhmgylXyvu1V6aHu4nPFjLxGS2q8VOe0W9PphDkdep11VZjrQcZePQukUa9dwlN7jTGy6bxenaBYy4VX/OFITPAZchisjZB3DoT1BIw8iMS33YbX6SIO1V8BGKw6SGzHNJjsGuRsMViPn8IUysrLuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053585; c=relaxed/simple;
	bh=JvyuFXZsK0xRmCXRLKdFwttlYhm1KxJIKLDh6gkb4g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwRI+kH4aUoXSe1pMeu4Sarax86XwwfT3i9d4TavyLvY+4caWyASlGcZE2601H4s944etEgrN4MPbcPBwRbyLkqpzpH4ocKDRSzVrQoS1WgTw3wEcP6nZWRG+0qQDea6PkeT2kama2/cmkV2PMT0Q2q8Q72YleB9NMmWxfsC8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ359qr5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4038078b3a.0;
        Mon, 07 Apr 2025 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744053583; x=1744658383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJIU9OPcaq3jp9kr0YRIuLsH63tKnb2woCTTN4F+W2E=;
        b=mZ359qr5yX8vv1L93hp08seg+ULXeYWaMr2w5IB+xeXiE7xpZldD64dgTIDdqMV/0g
         0FzglhUlNvexneF/fH0Q2ROcutrJPPzgooP1+cfuu2e4JsAaaXGPlt4dJBQ5ebc3svQj
         pcDwNdhnS7iNbqz+WpzPVwxKiZZxtV90puDRN1pxMqsMFw8RgVOiz2ZWKlS+6fXErF2a
         7unb/vTBwic2CQ812DX3x3oaVe57oJKtiGSEojeVOOxDfZp1x6BFQh1qXSEF4fiUchM5
         KBVys89iEEXs3sYicZoTbAlHSI5pZ3N3i0gAgL0e9XWvTKCv3/JDshLSay+UhKicMatQ
         sBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744053583; x=1744658383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJIU9OPcaq3jp9kr0YRIuLsH63tKnb2woCTTN4F+W2E=;
        b=P/oUW86x55TeDozZXYwd8bcXRjGQbFsabAGkVGMh6oo9nBOXvQKNJ4jXartvlAJLps
         0WfXFL23QFZ7DCS8O88oi4qY7ToOxLyNCcoL2yJbqmOGeeKBQPY5LkAxwGRAuEuMnadG
         Vk6zIjxkEvRul14oC2lvSYpZtQZUBKaIfbFkb75/rgtbo/tMPoTpwHx/dQZ8RfXVYyEC
         9vNVnLhBEkho5Zd1IbO13S245a3TMpjsF16urght8mPp5EZvX09Tg9C1broHY2p6JIBl
         KHjY5x5/dfPW/W3ha7NE5omn1OJ3L5+vyfHr0BfXMxh3glyNyWDati+OUz/LRoh3wGmi
         IUYw==
X-Forwarded-Encrypted: i=1; AJvYcCVaTk6lvIyalnMp9GbP0nTckbsiu6mNk+lGKMP1IdSgTq0EETaVZAit1edMQXTUGWyPK9W2eTTQbagQzg==@vger.kernel.org, AJvYcCXFmLKzuKltvDEhcoVZLsFE9+QajMzZtrEyyRwsT/eltk76YBKTb4fQuuflUvHniYCV497Hx61uzhRT@vger.kernel.org, AJvYcCXpQDg1AfmFcdBP7ooUozD65XwpuxcatR81ATgHevsmdX2sReizQXkjfiVshrNiDQZE1EvCL5dx@vger.kernel.org
X-Gm-Message-State: AOJu0YypdgMCUAKJU2Gne1U/YR8g8i3uAsw87rsrAWM+2jGBzd4OOkQs
	Ezg3e3BNBivdN1GPXxcF2rBNclFpnvezr0A9UG75YHe2Y03FAYh0
X-Gm-Gg: ASbGncu9MdqMih1N5yVV41TvrbKqox6S16ipC6VafCQGKqMbAW+T/DEgfAl1UBui6dE
	DSlrfAFBIQUSKwx/IPVFJAb7r14wzhOC2Y6r8pAiiFbkcE/zR/JY+U5J6GmRXYPFfJU6JGhaaKQ
	bgwCs9aO0PZLJ4eufUKK7sh0UjX0dhtpTxlGKkSLq0SETPo4dXKNDW4nL7moBW0InoFnYJifNX+
	0jcMuS0ncCHMk5bvfYCE7SEK6YRZMeGpZzL1BWfNf+vrsNsdLl8/ml2rSRHXOS50aUIydYtHD3j
	yztj1YGtq/pZl3ZVzIkXqKqQdcP8S+jo+5pVK/xOIHt5itAe/jsNvEY=
X-Google-Smtp-Source: AGHT+IHWdcpOQQM0t8gzFgNW+qNs1S2yMekXX7JNZrHkDbSoqceMBI2X2Z+wCpEsMp4tyjCvatu+xA==
X-Received: by 2002:a05:6a21:32a2:b0:1f5:75a9:5257 with SMTP id adf61e73a8af0-20113c57dfcmr12931177637.13.1744053583440;
        Mon, 07 Apr 2025 12:19:43 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc35137csm7583519a12.44.2025.04.07.12.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 12:19:43 -0700 (PDT)
Message-ID: <46e9b9f0-8ab5-41d6-989b-b1a010d0587a@gmail.com>
Date: Tue, 8 Apr 2025 00:49:38 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] common: exit --> _exit
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87mscwv7o0.fsf@gmail.com>
 <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <877c3vzu5p.fsf@gmail.com> <20250407191206.GD6307@frogsfrogsfrogs>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250407191206.GD6307@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/8/25 00:42, Darrick J. Wong wrote:
> On Tue, Apr 08, 2025 at 12:16:42AM +0530, Ritesh Harjani wrote:
>> Zorro Lang <zlang@redhat.com> writes:
> <snip>
>
>>> Yeah, nice catch! As the defination of _exit:
>>>
>>>    _exit()
>>>    {
>>>         status="$1"
>>>         exit "$status"
>>>    }
>>>
>>> The
>>>    "
>>>    status=1
>>>    exit
>>>    "
>>> should be equal to:
>>>    "
>>>    _exit 1
>>>    "
>>>
>>> And "_exit" looks not make sense, due to it gives null to status.
>>>
>>> Same problem likes below:
>>>
>>>
>>> @@ -3776,7 +3773,7 @@ _get_os_name()
>>>                  echo 'linux'
>>>          else
>>>                  echo Unknown operating system: `uname`
>>> -               exit
>>> +               _exit
>>>
>>>
>>> The "_exit" without argument looks not make sense.
>>>
>> That's right. _exit called with no argument could make status as null.
>> To prevent such misuse in future, should we add a warning/echo message
>> if the no. of arguments passed to _exit() is not 1?
> Why not set status only if the caller provides an argument?
>
> 	test -n "$1" && status="$1"

And if the caller doesn't provide any, should status hold some default 
value? I have suggested something in [1]

[1] 
https://lore.kernel.org/all/3c1d608d-4ea0-4e24-9abc-95eb226101c2@gmail.com/

--NR

>
> perhaps?
>
> --D
>
>> -ritesh

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


