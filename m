Return-Path: <linux-ext4+bounces-6770-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFF5A5D522
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 05:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B075B1787C2
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 04:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB71D7E37;
	Wed, 12 Mar 2025 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/8xX4AZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0C15853B;
	Wed, 12 Mar 2025 04:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741754526; cv=none; b=e65EOxEOMgu5YYliCvJzSjeTkqYJ3hkQaVWvV0GbvLZsoGzk2Q+/6SxN3Cqj8KdF+8aFNinrLAyVY42NYTNVMWLxPxHmMT+4hb4VIa6jcolhUzuRmPDit0B/AgkzBsSjUnNdA5zUaGSNjXGlRSNN1xsBbZsSAO+ovEdDqTSR8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741754526; c=relaxed/simple;
	bh=NZea968DwQL6TlP3yqnENmcOcIEXGjkaWrVrpAmV8UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQGKtW3T1f+qnKxUhFMCUVbyXD7Mq6VLXeh9uYVI5uB27G9kzI9GQ06oHYKjVoQuzTk+JPB6rfRZ8ZiRPbCwA3kqy3HYtyF3x1tMq6V871ocg0dm3UFfo9dO+uI23yRVBnSIfg6tGIXKrqfvlwR1iV1z/HgxWlb9tGPTyaxmQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/8xX4AZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2235189adaeso10019545ad.0;
        Tue, 11 Mar 2025 21:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741754524; x=1742359324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GeQRABs+I7cLnCp71um2Fr+rPmzQ9KeJaUzLYtsfpsk=;
        b=S/8xX4AZRArBWycR6GRRdsjVuDJ4Mhpn0YYrjPKJfJN/6Ivhmt7O221UG0FB+29k+o
         5eUcAjZqP3UbmD0q4erjVQBlTTEl1PzQM05u+LE/0yrEJTZoxDjtbSPXEBquKUdP0qMK
         KaEhLtr3F+Jm027HukUtyXBS+zbV5Y9yrVGVg4aenfAMb1n/A62lR63lOtpIbjJTvIh2
         efZ2QUxu/ZvpqwbAodfMLPpMIKwUPoq739/B0zphJUaCoAk4Ll8I6kano6v+7B8rtB6M
         xHZOk+C9zuvZ0PCyWh59a1YeFHFzIefYvKOAoVsl98vGGSmFxUkcWWdll1VeqdQgiSJ1
         WfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741754524; x=1742359324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeQRABs+I7cLnCp71um2Fr+rPmzQ9KeJaUzLYtsfpsk=;
        b=TH9G6gXZbXCOBw2oyK7/FGu4gHGz1wnZYtASVifVBUmrZqrv9zttnq+M3m4eqWxffO
         jl3JMEnH1nlRG3Mtd8fpIlJA3fzIMkftz+/sU4ElsFzb8NjP/10EDhvtnMJOrnHaohDC
         H3cg89oUSZ373QfYozHotM1C52Pg3/F1JpQZ0QyBOumlgK0455ps2PiJgdTjqzgz+aSK
         K3onf92HPo0d2yd2E69Yi00aMNNOnk18MC2vGJqV2y2jloWf4BvqK2QLQNg3OM+pPZf8
         EJfE8r4kZz2w6fuOQc+TH7nZNCelgGCVS7AuuRxK/TZ9Btf9V+dzVrBihY/0TUXvFzL4
         AkXw==
X-Forwarded-Encrypted: i=1; AJvYcCWAT/OpVkVBEqDLoSBrGhtrGc1G0YeVNIG9SJpd8CA2bj/sbztlKykOIGHoe8PjZkEe+NzXHn0N@vger.kernel.org, AJvYcCWMk5+ktWFQkaQepWJJgdvxyM6S/KGYNOPLuuBP8KJHaP0A0kPtF/eHDJpTbnIPVJrvFvkIBAKvUKxRYg==@vger.kernel.org, AJvYcCWvOXUYCpZyhEgUQm8jmq6gzxIJ47GZvjpMQ+WvET9lsLhQVr558Dd/YMhDRAIc94ZCEeA3LTLh7NBH@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnDRLUqZmNV9PP3gqRY/brv0xlbWQRSwoQdyehwvjEYnrXQKi
	Fv04HVm+IvJ5D62aiiAJEAvT79USlMBiIgkNHJCz8kLPK24j9R63
X-Gm-Gg: ASbGncvG9yKgDQxF1bfVAcuWVqIp88lqvtXfUmUMPcbRtu2R3I9mqaq4r+shni+Gttw
	eGqH1ZbXatT10p9d8wfjosEyYnvgH7Bh1hzcDae/FaGTHCUfJdftO9YuCPHqmoJPAlOWjuBhEEr
	Ljsf6nf2FI2nQX0Im0j+vwphrzIAOTUE9eV2K9f7zQHwG+TB4BQ6evFSO8DnZ0wwcN6y70DeFTe
	osS9llx3bOwQJScpexMf+hWf6qFvTZ6PIdXSFXgjhKEi7EDBFl10cp1BCHAdKnBUXpjoFW1fB6x
	aNBfacSfRfLffoy5ed7drFoggu+CjgqMVZlfO8Js6TgGTG/bIcW+V8Y=
X-Google-Smtp-Source: AGHT+IGVwFR4aK/mm4/rRs7xXf9cLhuoHJPICmtCc5wwCrvmtJRiIcB43Sf2rAhYskIQfh8/pI8HmQ==
X-Received: by 2002:a17:902:d4ce:b0:224:3994:8a8c with SMTP id d9443c01a7336-22593d5ef24mr70419625ad.8.1741754523951;
        Tue, 11 Mar 2025 21:42:03 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.39.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f75dsm107093935ad.122.2025.03.11.21.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 21:42:03 -0700 (PDT)
Message-ID: <2bf0ffc6-e696-46fe-aca2-d26770d9da03@gmail.com>
Date: Wed, 12 Mar 2025 10:11:59 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
 <Z8oT_tBYG-a79CjA@dread.disaster.area>
 <5c38f84d-cc60-49e7-951e-6a7ef488f9df@gmail.com>
 <20250308072034.t7y2d3u4wgxvrhgd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250308072034.t7y2d3u4wgxvrhgd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/8/25 12:50, Zorro Lang wrote:
> On Fri, Mar 07, 2025 at 01:35:02PM +0530, Nirjhar Roy (IBM) wrote:
>> On 3/7/25 03:00, Dave Chinner wrote:
>>> On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
>>>> Silently executing scripts during sourcing common/rc doesn't look good
>>>> and also causes unnecessary script execution. Decouple init_rc() call
>>>> and call init_rc() explicitly where required.
>>>>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>> FWIW, I've just done somethign similar for check-parallel. I need to
>>> decouple common/config from common/rc and not run any code from
>>> either common/config or common/rc.
>>>
>>> I've included the patch below (it won't apply because there's all
>>> sorts of refactoring for test list and config-section parsing in the
>>> series before it), but it should give you an idea of how I think we
>>> should be separating one-off initialisation environment varaibles,
>>> common code inclusion and the repeated initialisation of section
>>> specific parameters....
>> Thank you so much. I can a look at this.
>>> .....
>>>> diff --git a/soak b/soak
>>>> index d5c4229a..5734d854 100755
>>>> --- a/soak
>>>> +++ b/soak
>>>> @@ -5,6 +5,7 @@
>>>>    # get standard environment, filters and checks
>>>>    . ./common/rc
>>>> +# ToDo: Do we need an init_rc() here? How is soak used?
>>>>    . ./common/filter
>>> I've also go a patch series that removes all these old 2000-era SGI
>>> QE scripts that have not been used by anyone for the last 15
>>> years. I did that to get rid of the technical debt that these
>>> scripts have gathered over years of neglect. They aren't used, we
>>> shouldn't even attempt to maintain them anymore.
>> Okay. What do you mean by SGI QE script (sorry, not familiar with this)? Do
>> you mean some kind of CI/automation-test script?
> SGI is Silicon Graphics International Corp. :
> https://en.wikipedia.org/wiki/Silicon_Graphics_International
>
> xfstests was created to test xfs on IRIX (https://en.wikipedia.org/wiki/IRIX)
> of SGI. Dave Chinner worked in SGI company long time ago, so he's the expert
> of all these things, and knows lots of past details :)
>
> Thanks,
> Zorro

Okay, got it. Thank you.

--NR

>
>> --NR
>>
>>> -Dave.
>>>
>> -- 
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore
>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


