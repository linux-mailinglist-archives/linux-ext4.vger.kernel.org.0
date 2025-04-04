Return-Path: <linux-ext4+bounces-7081-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB06A7BF50
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97E317BD14
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 14:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF831F30DD;
	Fri,  4 Apr 2025 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHGc+HAF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B419E56F;
	Fri,  4 Apr 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777113; cv=none; b=ONBlzf0nKKKlfb9FsLR209ASlkKkuzQcZwbhh8I3AMVPnc+JnXy9FiUHquJRLcqXTFy8eBbkPbBceKxCMergzf0p5Pmhbf35chhAuq4fcH4FL1OUvNJo0+bbj2cca/e28LVpZo/HcriIFlfrRqbxb7Tg5c5BzcLs00jTXjrTYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777113; c=relaxed/simple;
	bh=pSeOl54WsmEGWar/94shLMKrtfiaE4mtt8Qn7st7U9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fz8bkiBwu/8au3ZwWUBG9pWGwbUQJdLZ0XmN2M3AbPk5gmXi/6tgKCXAcgnVa2ZiLWAUC7xv8pFLp4pSj8YvFUGm3NoUmtu/pA+ew/AlBMP31OXIDMM3gpzp0ZTDnQSueAmAiE4b//xnwT4XZmvDJGoECDEsz2uPBLu1r6RXYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHGc+HAF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7399838db7fso1971504b3a.0;
        Fri, 04 Apr 2025 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743777112; x=1744381912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIUpXcdKHB3PSOIcrF3ZU7/g9WoG6O8U5GhLcPaJPwE=;
        b=lHGc+HAFPsg3id7qyBEDVXq3F625qSRFRRa5oBpAM3ZfXdEs88CzbOV3W98cLCAjsT
         uYUPyq4fegkryUhwzGlhwNWv5Q8XfDZoRnwPcNWO73/lzzLJCxQAEV2FlrhYStuLuQbD
         p6c5gA97WnTif5beV+VPJbIJ/1fDAvvpayFdLoIJ6OyWIioVfSZnW2am2/YaSA1sEEp4
         Z8PM+LDUq9Hn3eR7iNABvx6Oal42DafFVY9HeX1XND5+g4SLbTYryopw6RMHOIUWehTP
         +REE+3E5UEhphsIB/4yqakGS2P/2Lt0nFtwti6Dfe9CRLXhfmb3ds3/8Uo2LQpxJSgjh
         f7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743777112; x=1744381912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIUpXcdKHB3PSOIcrF3ZU7/g9WoG6O8U5GhLcPaJPwE=;
        b=LL/HCWq13CwybbiwIKRC8y1m9+LRV3/UuU4umIzSgAlxr6MI9GFI87vzOJE+8Hlv1s
         82dLShUZB626c5hCVxTnRpm7ms1Pwk1Wka+dZp/9pISY/jTuohOcNS9x72SJsikJDYtV
         RcHdFeNikRwrXPyX8BhHWKOncn6C3BjBTui9waBmRTFEkw9QT+VSI1H4wsWY4zC0fH0K
         tX2PGN1yVBOkLqj0tiEhQIvdvNpA0nxHPtd+xSNQG6ERN8ObrCXaTcfWNfDBCKO1MCe1
         FWwbXcs4koX01P0aTiSP5Byjd5bn95cos1IaGNJnRWYYn/k3mtLOB01GiYyB/RkFYuvU
         qYxg==
X-Forwarded-Encrypted: i=1; AJvYcCVY4mX6S/6DNsrr/q1f2F8VKx6BlvykXUlsbvWknyCFP8pK1O/3SAyVkOJgHrGFj+6OYUcGaKuF@vger.kernel.org, AJvYcCX6cTBtVtfyytE43X5HZPp8WRIi0KqJHeQdhkFW7nvOolURK94XgVcgu5u3hkfFjmY1VN+OZvjudY4R@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32mTgTqVAFlvqCMNoVUQNokwDqwTdAdbpm05ZaXHWXCoiNrGb
	DtFL2/I4iC77+nRbq/f8ihvHL1VhRw3WnQR2CIBk5asXH/hKys9I
X-Gm-Gg: ASbGncuEZpWquoHwUjKaLg4UucqTEQ6wfj8E81cFv3TMHMoIr0KGkdID68C8RvW0Mcl
	yKrn1n0BQ19lM4P+dwTl7X1gIvhjKPDp/fczRN6pPOepP98HC/awncd6z5uGfZWT/H3sNwvaK1A
	ljk+0cwf/FlKSRCnjWbLS3WXPRC5DHh7a2MkPdgNZReRQgVPoiY1WvoJziYdzPibf6hLafRmp09
	vo2ugu59ZmQ7rLHpVB9Wk8w6EDayD0wGMCPwGcJloQxhhXXnpQEm1KRqQLjLGBqyN4jaSVhcytz
	hn2u2r/rgZZ3Cu5X/RoTXsT7dZ0U58DcGwv22P7QQ0YNa99aDfIWsng=
X-Google-Smtp-Source: AGHT+IHb2Ot8AMsFqMnHLfMhegzVUUhlOpaXPi56UiGjsxBbobBs9Kh/XX+JriZ0cxmwHfaiMsHXjA==
X-Received: by 2002:a05:6a00:2189:b0:736:9f2e:1357 with SMTP id d2e1a72fcca58-739e5a7b103mr5001341b3a.12.1743777111564;
        Fri, 04 Apr 2025 07:31:51 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc31af62sm2453385a12.22.2025.04.04.07.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:31:51 -0700 (PDT)
Message-ID: <3aaf8625-3e15-49c6-9e9a-2d9995600dd7@gmail.com>
Date: Fri, 4 Apr 2025 20:01:47 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] xfs/539: Ignore remount failures on v5 xfs
Content-Language: en-US
To: Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org, david@fromorbit.com
References: <cover.1741094926.git.nirjhar.roy.lists@gmail.com>
 <5cd91683c8eec72a6016914d3f9e631909e99da8.1741094926.git.nirjhar.roy.lists@gmail.com>
 <25ada3f9-0647-48ee-a506-92caa5129b2d@redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <25ada3f9-0647-48ee-a506-92caa5129b2d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/2/25 01:28, Pavel Reichl wrote:
>
> On 04/03/2025 14:48, Nirjhar Roy (IBM) wrote:
>> Remount with noattr2 fails on a v5 filesystem, however the deprecation
>> warnings still get printed and that is exactly what the test
>> is checking. So ignore the mount failures in this case.
>>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/xfs/539 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/xfs/539 b/tests/xfs/539
>> index b9bb7cc1..5098be4a 100755
>> --- a/tests/xfs/539
>> +++ b/tests/xfs/539
>> @@ -61,7 +61,7 @@ for VAR in {attr2,noikeep}; do
>>   done
>>   for VAR in {noattr2,ikeep}; do
>>       log_tag
>> -    _scratch_remount $VAR
>> +    _scratch_remount $VAR >> $seqres.full 2>&1
>>       check_dmesg_for_since_tag "XFS: $VAR mount option is 
>> deprecated" || \
>>           echo "Could not find deprecation warning for $VAR"
>>   done
>
>
> Reviewed-by: Pavel Reichl <preichl@redhat.com>

Thank you for the review.

--NR

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


