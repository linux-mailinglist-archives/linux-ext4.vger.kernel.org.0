Return-Path: <linux-ext4+bounces-6704-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE1A5622F
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 09:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001A0189697D
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 08:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342BE1A5B86;
	Fri,  7 Mar 2025 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ldv6xr7q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779EC28E8;
	Fri,  7 Mar 2025 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334709; cv=none; b=q4fnhyOkK4sGGP5MvSj5Ein2AiGJnKHaeRedThkZ7bvV6yL5zMRMSn3/csTXpClurtG/INr2tuS0Prira5vTgi4L8SmdWv2NTNV8gvX5gii1bY/F/HYq+7QJkiDuxbszY3AaYZWG3B4YDSs2eqeUGeQhOmXIE6Mgq2psRD+hOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334709; c=relaxed/simple;
	bh=cewBzhj/Uh7V6W/nPAL4b9bf4vo+Ggi4E/ZzoSluG+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0eZULC62Vixt7IzCVDs2GyhW9KNFJyfOf1mzWzDq4QWu+nR69Q5ZLkK55zMPcU2NDfXXVlIRttonV2QIN0+74JkPFRPcl/9Obf0BrMsIbjlPK++5ejiKYPP+SLk1NkeqdplL2DJlxxpHqxAy/9GWdmSsShcP201t3t1fXVoOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ldv6xr7q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22185cddbffso51261535ad.1;
        Fri, 07 Mar 2025 00:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741334708; x=1741939508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQd7MCLMb5m6gKXonhGoh77RnzkJR75ioCNoJkyZULo=;
        b=Ldv6xr7qDPHt4svFmJmw9vqJmPThS2NfU4prvMSsciX1iz9NK+fYv873+SMsoB25Sn
         YzMgDhIu7cCQwGtaLnWJEHE4JNMHlV9E7BdA1ur//oLHZNQ94MDR2XqAdDQ4HSiRO02U
         6dXn3h58ealQITdV3l2UkuYkIA+pTBz8vFljndbaFvFEWFnplzJKCOKqJ1mP/7i7PekB
         KWNI3IQ2CHhwK6bk+d1g08lnlaW/QDCf5BMO0jz0OldjH9q5Prurfc2CtI1EpzLZKvlH
         k+6w6PifK4vjjagfIxrT118++QRnATUo1wnIKN6iw0Zp51GikCnod0QCMMtE4f0n3dYn
         qi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741334708; x=1741939508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQd7MCLMb5m6gKXonhGoh77RnzkJR75ioCNoJkyZULo=;
        b=gg5Yu81SJEDUokKCzBLAZCAD+HPKKpZ4QbM0vExE3OqyWks+Dxst+PmZrEwVQLXjhU
         BLyC2QCvNK9ZZ05uHH2BWOY9q5bFaEyeBnObuRKu43DbL+f8IKH/sYFJJZg2oh0jBpeH
         kIYOV+ASBXZkAMr9g+m3prifCofEkiRPnbhiFrNcrkuRRJQqisnM9hAdOsYKDsibiD5N
         +C93BS2+dyz7t1ZBNho435x3j+u8DaJCYlr+TV7qA93U+N9RR3dDKU5jTWlMm2LCa8xX
         DBhTSk67kKkvl+MLY5Tm79OCDJ1KaRYhcjn42PTtosx0ZURwpjldpWV1z4PpI1b/Hi44
         xjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0kFJNClYMWiIYn1EQs5UkOxUQTX6u9dUR1cZCqCtb7O0wbPU+JHTFQQTAKOBsnkF1BRAWb2TfAI8p@vger.kernel.org, AJvYcCUofAvjn1CpY7bJ9eEjrB5WgznJgrp6e1rzULkS0or4Ao5TmL+HZk4YmhBBUIZDAKrK40RWrf1aurZo@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjEoJREmcbitqIi/Bom0v9ZfWCnxhwNf38yR2xHJE0DPvNrR6
	81wE4LWcwa7eqyP1Sm6AaRj+PMSssH/4F7j85BfKbXD2J/RwGMCbd2RQYQ==
X-Gm-Gg: ASbGncuqRYH2JPvUq6dGMfgT5ZEil80Qb0yeZZf3W05nOsNNnQ/N7/4VhFf9H+9qiH7
	p/gFEGh9Gx04soRw5cQ46ykh2TnYJoekQLvL7uGXt0Hdv/bdGVKSiMa79JzanmdjJtu74Sj2I1K
	JvqF2T7bHXPVdb/ZvkhNefuB/Qoq/T+fn9kCN/rj78t6AeZJgazTMKIVNgGDS5wzbea/nqX3L/T
	2wK9cFgpk06CpCuV2REXuWGFf4xP/P67SFJD9gI+RUyDpMvEVbt5Pz0YUQTHNn4HK5Jp4nTJ21U
	WSGuaX1Awaql0hTATJ/5QoL0jLKy1GSv/paRe3a33BaRn6S/IKKBzcQ=
X-Google-Smtp-Source: AGHT+IEeX9zHsHYMraDYVg5YvJ/5yBas/htzAmlGee+kx193lJTrTuqODs/is/rwpnkP7FynH8tGVA==
X-Received: by 2002:a05:6a00:2e17:b0:730:9637:b2ff with SMTP id d2e1a72fcca58-736a97bbbddmr4662660b3a.7.1741334707160;
        Fri, 07 Mar 2025 00:05:07 -0800 (PST)
Received: from [192.168.0.120] ([49.205.39.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b2da32c6sm421059b3a.149.2025.03.07.00.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 00:05:06 -0800 (PST)
Message-ID: <5c38f84d-cc60-49e7-951e-6a7ef488f9df@gmail.com>
Date: Fri, 7 Mar 2025 13:35:02 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
 <Z8oT_tBYG-a79CjA@dread.disaster.area>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z8oT_tBYG-a79CjA@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/7/25 03:00, Dave Chinner wrote:
> On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
>> Silently executing scripts during sourcing common/rc doesn't look good
>> and also causes unnecessary script execution. Decouple init_rc() call
>> and call init_rc() explicitly where required.
>>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> FWIW, I've just done somethign similar for check-parallel. I need to
> decouple common/config from common/rc and not run any code from
> either common/config or common/rc.
>
> I've included the patch below (it won't apply because there's all
> sorts of refactoring for test list and config-section parsing in the
> series before it), but it should give you an idea of how I think we
> should be separating one-off initialisation environment varaibles,
> common code inclusion and the repeated initialisation of section
> specific parameters....
Thank you so much. I can a look at this.
>
> .....
>> diff --git a/soak b/soak
>> index d5c4229a..5734d854 100755
>> --- a/soak
>> +++ b/soak
>> @@ -5,6 +5,7 @@
>>   
>>   # get standard environment, filters and checks
>>   . ./common/rc
>> +# ToDo: Do we need an init_rc() here? How is soak used?
>>   . ./common/filter
> I've also go a patch series that removes all these old 2000-era SGI
> QE scripts that have not been used by anyone for the last 15
> years. I did that to get rid of the technical debt that these
> scripts have gathered over years of neglect. They aren't used, we
> shouldn't even attempt to maintain them anymore.

Okay. What do you mean by SGI QE script (sorry, not familiar with this)? 
Do you mean some kind of CI/automation-test script?

--NR

>
> -Dave.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


