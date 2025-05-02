Return-Path: <linux-ext4+bounces-7622-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439BCAA6A98
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 08:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97ED44A6BF1
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 06:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2281F03D6;
	Fri,  2 May 2025 06:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPw1N2RE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F31EF368;
	Fri,  2 May 2025 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166248; cv=none; b=DykuRbN4+U0yhM14j7e3Mvj6N6P8otSwVFIhvydcDtaJs4LxmDBZVLfCz7yu+emIZHNkcEo7FVrWRwH68V6WDeligIw0+AgVS5RTMMHQEOIIDqW+Vq7iG9p08rBjYnoHcLHyvImHpPnHtfiXSpBDpUsIuoS97mgYwMLDeZfjmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166248; c=relaxed/simple;
	bh=EFeV3uo76j7JbR5MRWK57bQJ4DAX0TQPbYT9YiaJF+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7NXUFrbkz4KY0WtKsA1P/HqL29wlVoD58hZfLZlokpQNIrIAAGKiNf1KSkG48dPAou04IIs5rQAymUtk3vEH7syfymSusiDme3tE883aD6Q7dM8gIE92mv7dxdFk8jxPwVuIDJFEufPdEocOMM6Ue/kggNuxeCi7QuiF5pexxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPw1N2RE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c3e7b390so1985440b3a.2;
        Thu, 01 May 2025 23:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746166245; x=1746771045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4Y/xj85ZOAkWmSQZsT4dY00KXP9EvcJEzUHPWf2vHU=;
        b=HPw1N2REHkDXI4nCGh3hPRvKPSAisHU7fLJyWZ14m9rC7Pq1JKyL2MBarY51cQrTSO
         sghi3JE51QEcx3EGD0PQWQhoeF85KQmpYBx6Ak3LcNaMQJiFbD3v7D3NAYPVcHqwm4zP
         SqtSJc7U79tGO7d2q+7rG7HisiVS05a53Yk/DD+jBABlrTA4b/Ifa4N9H6qD+7hpvgE3
         vIaoR6JkRB2p6WfAzzIUUcWLNbvEGCYFEsf7YG/Fc5UCxW7knf7lWQfAHfAD/rjO9ReY
         6zX+ZIDXMnyT2m2ruN3mhDZQknH7pEtDy2kRw36eeFQRWYkFxheA2Ph18ct3mdEQ7d6O
         qbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746166245; x=1746771045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4Y/xj85ZOAkWmSQZsT4dY00KXP9EvcJEzUHPWf2vHU=;
        b=R0VGAyRJgEE4x9Jst+OsQIFq1JZIt+25F/0Np9HIYzUcEpV9CrxZTNmnOwAeLpOOXJ
         lCpQMyk/GUPs3xX3eWTYjSz23E7ZJNygT9SdZAH179mVv0lBTARyy6Od3Gth5x+jp+/B
         MUGZizNKZ1m6yfqePrCuQuAgYVI4BEjN1MsrqTC9KQmrHRzCK2e11Uxnf2hG3Zk1K6If
         X32fpeqNiJYbCyq0jaV35V9Mz/5z+coCUzIl/tjuSSFW6U6Id3r5M5+57O7141L8hUjA
         qqq8a8uPbT5CGV+mQiBJUg4g31Mz3jDHW+3j901F6XitAkLFamv+FGKo+8wOGmnPi57o
         byjA==
X-Forwarded-Encrypted: i=1; AJvYcCV504n98fVLdJbw3ILgjzkSpKOGKibJ/In4qp5T2yOpMSFZqOkD79yno0kcdS70kVl2PyPlgOYQ@vger.kernel.org, AJvYcCWJy0h4fmdjpnUpHCAnTF1skJYuYUYTIsHUWS5rdIIONUqQPDVlQ7ho5OKCeLtydpNXET/a3md8bwjl@vger.kernel.org
X-Gm-Message-State: AOJu0YywPEFYxCnisuSedygC5WTHBnWpwwvt9EDTMjmBti57+JDAM3OY
	N8qhD6TFUrQSNPggOKTVNxxOaTQM9VvpYgk+SKL3gw/Dzx9yJWb8
X-Gm-Gg: ASbGncvfczJE8Njo9KByiTlRo4VhbiEQvClSLQjw5JdtGa0k5PJduugKh5iRTbETw7k
	M2h2IvKaIu50IdpTGpE9Qb6YnNiXwKkbdHXysQ2/KU54njAx3oFYd14tWT8oRo08nyJVqJ2Si1B
	/vweZqSUeL2tUkwzEpXe7XyjcMlDAmWLnHW0m9jnYWV8wH/ctpS+OMR04PA8jKYM9V5uUmsQINz
	SOlxNq6UIc5hjWBK4/ig+yaHCocMMs8j9VJRNPRuYTEw5scy0xUIhX329kHB5v8sEIIWUoSLq3Y
	+RY/8FKqUdsmsO40xRc/U2IXLESTik+JyUCGC6iYskj//cRmYoE85pcMUj+cGg==
X-Google-Smtp-Source: AGHT+IFEV6EE0vkktibpKDphiXz78TddxK0PMaiWUUFfj1VZAoihAAFBx6SRtt+TabsF6gdNEfWaIg==
X-Received: by 2002:a05:6a20:1587:b0:1f5:889c:3cdb with SMTP id adf61e73a8af0-20cde46bb06mr2822952637.8.1746166245137;
        Thu, 01 May 2025 23:10:45 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fa82abfc5sm632452a12.38.2025.05.01.23.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 23:10:44 -0700 (PDT)
Message-ID: <dd3c9f54-8b68-4025-a368-91fe014e8eaf@gmail.com>
Date: Fri, 2 May 2025 11:40:40 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] check: Replace exit with _fatal and _exit in check
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 david@fromorbit.com, hch@infradead.org
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
 <34273527dab73c9e03415a7c3d6d118980929396.1746015588.git.nirjhar.roy.lists@gmail.com>
 <87bjsdqa5x.fsf@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <87bjsdqa5x.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/1/25 09:01, Ritesh Harjani (IBM) wrote:
> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>
>> Some of the "status=<val>;exit" and "exit <val>" were not
>> replaced with _exit <val> and _fatal. Doing it now.
>>
> Indeed a nice cleanup. The changes in this patch looks good to me.
>
> Please feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Thank you.
>
>
> So I guess these couple of series was to cleanup exit routines from
> common bash scripts. Do we plan to update the tests/ as well where
> we call...
>      status=X
>      exit
>
> ...or updating tests/ is not needed since we didn't find any wrong usage of
> "exit X" routines there?

Thank you for pointing this out. The exit command is used in 2 ways in 
the tests:

1. "exit 1"

2. "status=0; exit"

1) works because we set the value of "status" to 1 (failure by default) 
in _begin_fstest() - so even if "exit 1" is not correctly explicitly 
setting the value of "status", it simply works. However, "exit <any 
value != 1>" will not work (although I didn't find any place in tests 
where exit has been used with any other value apart from 0 and 1).

2) This works since we are setting the value of "status" correcting 
before "exit"ing.

But yes, we should ideally replace direct usage of exit with either 
_exit or _fatal (depending on the exit value). I will add this to my 
ToDo list and send a separate patch series with this and the README 
change you have suggested below.

>
>
> Either ways - I think we might need to update the README at some point
> in time which carries this snip. You might need to add that there are
> helper routines like  _exit() and _fatal() perhaps for use in common
> scripts.
>
> <snip>
>      To force a non-zero exit status use:
> 	status=1
> 	exit
>
>      Note that:
> 	exit 1
>      won't have the desired effect because of the way the exit trap
>      works.

I agree. I will send a separate patch with this and the exit call 
replacement of the tests.

--NR

>
>
> -ritesh

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


