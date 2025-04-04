Return-Path: <linux-ext4+bounces-7080-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A7BA7BF4C
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 16:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5B217B17A
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C834C1F30DD;
	Fri,  4 Apr 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNUtOads"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B481EB1A9;
	Fri,  4 Apr 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777094; cv=none; b=QGomv9wq1BA2+OWm020ThEP+8TCeX13taexHI99iQegVFIbNlu505P+Xe0xTq9L63JiE0n1jdIczcpg+Ea/bMEf6l+H8fqNWywd8zhYqlMNSWCAti9HCl/M23dTVv5LSsvOF8MmhcsZnZqohaHYLhkpEb4M2d3bhLcAcs90JNdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777094; c=relaxed/simple;
	bh=J9k3/Xu6T8oE2uNpN/95kf50yLJZy0y7cvG9cU0uuwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4x9aIJzdh88s4mXm3tFWgNtqnk95U2K0gdJBylF1gEheOZSljY1sST0GClc/MqUMpQxuk+4KzK2SU2P1qTPG2l0p3zeRBtxPylX109mr9tfMOEh6tkEzKrUSHUaLQIPvIC2Nqzn+wNX3xUG5+VdZj7D1jVtlciIz0k5WtKpYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNUtOads; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736ee709c11so1822510b3a.1;
        Fri, 04 Apr 2025 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743777091; x=1744381891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwBzzxLbupVRfnHoMBzuCCdhVsLx3aPsZvQnxpPPy2M=;
        b=gNUtOadsMeVEboxImC/fzg7Kc1fFfXEUJxM1WenuSe64/bgfmZf9K+xId7vc3QR8zL
         NqaUo/jBbp6gNbIoKiy9V4ll7OX6OmwqTSZgw6INvswPHVnMsEP3/HYdi9zO+9AHqy1W
         ABwOyKSod0PS6LXD6q+i0X7WOPlvIyVwS+sjv+JLZi8haQCO8/wdF8rAD89S0/OHC+DB
         6TcQhboevs4OdSnYl3xud3GNOe8HDnYdJJpJ5feT/uijjJKJbmfEKk9ygyMiRLuMxmTo
         RiG3sjouYEQBSR+rqR4hWa2hy792lrQqLSmFLwsLaFbWOFghmLgYEU5aRsHQM3cHP6dp
         jjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743777091; x=1744381891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwBzzxLbupVRfnHoMBzuCCdhVsLx3aPsZvQnxpPPy2M=;
        b=WFe42sngHraWBVRg5IKkC7+kc+clt5V+YDsgE6rQ9ibYVqlMTKgtNXCe4qSVzJ2M6N
         aKxcFZe1kzKSP22ChJdG0t3kN11Yj3Dq2AGh3P/bN5LCGyQiDvcY6DKchaM8k9aVZzrj
         XxwaOVZrXIq+w9zvSJxJmsm1oGaqLNkjTpkMu0qgdqY14ToKgc/G7B7V2P10U5kf/FFK
         qpRZ1DA8IfcfzPT0zqVFBoH+G6ATJlWbxIrHeAHboLM+iEOA9utoBD4sBIufOIhmz5/1
         44bF0JwQXHgtQOPxH1QlVm1Of/oNSnICh2eYp1yC2eBSjqf5rwm1nHoTRLAuyxyu8RGZ
         3vhA==
X-Forwarded-Encrypted: i=1; AJvYcCUOriTapkUsYoZH7uHemaM2+raH5Hp2wJo/p6csoz1l3R0fFBODx8hyzHolfqmVS6j1ICbN7ULEEg21@vger.kernel.org, AJvYcCXeRZuKR+EodjN+9cQODts3+FKZnPahKsNlIyoehWVVk9v9UElJucJPobEoaPANS5cjNhDd05J27hfR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkv/3onphdFMmZvNoAuHrxRad3ndPrJvjviCrbfLuK3tdMHKcn
	8qJYYE4lFS7zUYCSdn8kJXCcwo5qP7WwVC0Kd1u1/P3iV8u4634RmBKXDA==
X-Gm-Gg: ASbGncuDZAnzVnmX4M2LAJ7cH9B4CZdmWYCAPfuDM7HyOghd8aKewfh8GacxK2datq7
	PfxFBz3tEEF90UoGvgIC3sJ8zdup81tlflDsvvL224JUnPPjO6j26kfZTuJGFcysFo1WbZr+Sr/
	UhEuxBupNjizK4GymNtey0xKq/w2xWZgv07p7sdsrv9+D4k98PZMRf4fycrzXqDKn/7sXk9K+qf
	+3ITQnDdwIgI7kmLR7lJ3CcDfHK8wE5C/M46EQPGgu0h0c/ZZ5lWWyv/8cYsHWQthXk+edYgG1x
	azb/9chcfJSCa57sOgXYeXNWEwIxGTysHvRge9/18XwMPOzLI6nC2SPqHBBCuXpknw==
X-Google-Smtp-Source: AGHT+IG+ehWRKga4emksI5D5y5ByqOxRAz/CGLATYH1hvJkc8tvjFLbYaHa7S8jERgEpmdpvgPGAdw==
X-Received: by 2002:a05:6a20:c887:b0:1f5:57d0:7014 with SMTP id adf61e73a8af0-2010801c97fmr4260921637.25.1743777091120;
        Fri, 04 Apr 2025 07:31:31 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc3fd627sm2926140a12.58.2025.04.04.07.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:31:30 -0700 (PDT)
Message-ID: <f9548540-a390-430c-886b-3ec533e687d7@gmail.com>
Date: Fri, 4 Apr 2025 20:01:26 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Minor cleanups in common/
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <Z-xcne3f5Klvuxcq@dread.disaster.area>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z-xcne3f5Klvuxcq@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/2/25 03:07, Dave Chinner wrote:
> On Tue, Apr 01, 2025 at 06:43:55AM +0000, Nirjhar Roy (IBM) wrote:
>> This patch series removes some unnecessary sourcing of common/rc
>> and decouples the call to init_rc() from the sourcing of common/rc.
>> This is proposed in [1] and [2]. It also removes direct usage of exit command
>> with a _exit wrapper. The individual patches have the details.
>>
>> [v1] --> v[2]
>>   1. Added R.B from Darrick in patch 1 of [v1]
>>   2. Kept the init_rc call that was deleted in the v1.
>>   3. Introduced _exit wrapper around exit command. This will help us get correct
>>      exit codes ("$?") on failures.
>>
>> [1] https://lore.kernel.org/all/20250206155251.GA21787@frogsfrogsfrogs/
>>
>> [2] https://lore.kernel.org/all/20250210142322.tptpphdntglsz4eq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
>>
>> [v1] https://lore.kernel.org/all/cover.1741248214.git.nirjhar.roy.lists@gmail.com/
>>
>> Nirjhar Roy (IBM) (5):
>>    generic/749: Remove redundant sourcing of common/rc
>>    check: Remove redundant _test_mount in check
>>    check,common{rc,preamble}: Decouple init_rc() call from sourcing
>>      common/rc
>>    common/config: Introduce _exit wrapper around exit command
>>    common: exit --> _exit
> Whole series looks fine to me. I've got similar patches in my
> current check-parallel stack, as well as changing common/config to
> match the "don't run setup code when sourcing the file" behaviour.
>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Thank you for the review.

--NR

>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


