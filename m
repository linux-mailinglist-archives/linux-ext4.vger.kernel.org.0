Return-Path: <linux-ext4+bounces-1507-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D28716F6
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Mar 2024 08:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4EF1F23933
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Mar 2024 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA477F467;
	Tue,  5 Mar 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYv9KH4C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA77EEF8;
	Tue,  5 Mar 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623984; cv=none; b=nIaDqhCefRlPEUMARwcNl0uMSr0RUbymX8UZp+QHmisiy24h/6wk6QRNZPLBrwUVsZ6mV8dAVAGEshw5ghGK5ImZlsiuIfwp9eS6mfv4IUG5IM1zRBQ79o6yqhhmjRdOTBD6XFh9/bgUlsxoh6WiaAIq8ydAf+3DmUNw5a+X2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623984; c=relaxed/simple;
	bh=Q1S4GZ3onZcZAjNh5fEHY45BHKEGBq5D/pZHzh8ILTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTp9CH2/LUJtEOSoKoDwogynaAC0J8UVvsB9MZHKG/1KEskoYOo7Yc2VG7lwwxX0LeK5T79mjYg+L8VJE6KeMl4AmWuwSiNcEO0vZAnodS0J2LTQsgG6RijRSRbexLm1m1grc6FjWbSXkVyUlCjUkKqtEFxJM4mtP6Nv1uIou8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYv9KH4C; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc29f1956cso42063605ad.0;
        Mon, 04 Mar 2024 23:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709623982; x=1710228782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=k7L522V9EVGc5fO4EHhNq2/tM0ZoePaWWwpPgdoJUqQ=;
        b=bYv9KH4CmmCWlqM+tx4/WBzA1qRI0J1umyGVSsvNQyAyvxqnQLuEASv4M+neX/WiVd
         2rMDpVXYYirDiH1sO3fv5Wd4HhSae+Iral507SvoOLWkjvYj3vB5kF/4SX41k54x/lLa
         YwOZ+GtDHMoSh75TvdJjWu3GXZ9HvzI3Qy4X9IJaOttaf2WyCBv8R2ia2fdClb+wbaon
         bpnP8qtHfifXKloBliyx8FUuFPOwlcMc1bUewuOrr3N2jGCBYigFOQVqP9wW+bjPEwCd
         NSZJDMnC6elwJWCqSnzSYS8GDFl1chi4kjN2Mr0vCTakho3ZBg81yygPzjgFHakZsMAz
         bFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709623982; x=1710228782;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7L522V9EVGc5fO4EHhNq2/tM0ZoePaWWwpPgdoJUqQ=;
        b=k3JnK78pK9QFw7wPnoesH2AS1GkGl3T6/potP0lUXNvHcvB/Uj0Sdvs/JITwAlfvFP
         seKAVhBWAP0Lqf5SBMH2jvz7qYCbSnd2KUq6dHNa5mRZtfpQb3uF3HoKMXiO4wVV+uXt
         +d9dftgkTuRb8uw90Ifddymdm0aBz9JuJXNe6MyJNhATajP3lYEGJ4mIQ1MkMjZeqYQK
         7NU7sjZsKqaQQDgh/RvrcKKGYbiKyXd0qYqG1QCnlujEDYGDngvqM34C0WxZoKND/tM8
         c+D0yRM1tps3fbBtmb6RJ3xtzaTTV3vHxsXVLomSU40UtKDf8zCbVdBpxiVtfJ4jBKGT
         9nfw==
X-Forwarded-Encrypted: i=1; AJvYcCUMoZ27x47JQjP1QbNm5QOfZuxr55XrpJbJi8TaUVmtOaK00rMDLD9abiGQ3dOwiOssxhXGRsOkmywpS5fwV3TlK2sCRW13F2LzDjrfZhKkW+3kgU/dB33YUOLXmpTsvRbK6dZ4r/jx1g==
X-Gm-Message-State: AOJu0YxcS4m9RUZA/p0X+Pnq2GqcRzASbVm0iybTqKvAiNA0HiHyXNmC
	8AxVLi2BAdKu42ntFrJ37hZbUaR3eGvchuakX03/VA+KR6tQDE9I
X-Google-Smtp-Source: AGHT+IGkqsKbH/lmRSPwwZ6DxDcuTGW5/Viz3MO+Srw+fK/UE/iflqaIlcWSskM2QKPxWBvde0B+zQ==
X-Received: by 2002:a17:902:fc44:b0:1dc:3261:ab7 with SMTP id me4-20020a170902fc4400b001dc32610ab7mr1376414plb.49.1709623981828;
        Mon, 04 Mar 2024 23:33:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jb5-20020a170903258500b001dcc29b985csm9783534plb.134.2024.03.04.23.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 23:33:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <917bf576-f6f9-4092-8cfa-e95508c022e7@roeck-us.net>
Date: Mon, 4 Mar 2024 23:32:59 -0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Fix crashes and warnings in ext4 unit test
Content-Language: en-US
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
 daniel.diaz@linaro.org, brauner@kernel.org
References: <20240304163543.6700-1-shikemeng@huaweicloud.com>
 <8d0506f8-7df2-45f6-85a4-2a0075b00050@roeck-us.net>
 <81b872cf-440e-b1c1-3d95-570bd65fe4fa@huaweicloud.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <81b872cf-440e-b1c1-3d95-570bd65fe4fa@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 23:14, Kemeng Shi wrote:
> 
> 
> on 3/5/2024 2:55 AM, Guenter Roeck wrote:
>> On Tue, Mar 05, 2024 at 12:35:40AM +0800, Kemeng Shi wrote:
>>> v3->v4:
>>> -fix that sbi->s_dirtyclusters_counter is used before
>>> initialization.
>>>
>>
>> I see no more ext4 related crashes, unit test failures, or tracebacks
>> with this version of the series applied on top of next-20240304.
>>
>> I'll send Tested-by: tags as response to the individual patches.
> I'm so glad that the unit test works better. Thanks a lot for testing and
> letting me konw.

My pleasure. Thanks a lot for taking care of the problems!

Guenter



