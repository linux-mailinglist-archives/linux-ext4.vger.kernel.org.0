Return-Path: <linux-ext4+bounces-6769-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5D2A5D51F
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 05:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45347AA982
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 04:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF61D7E37;
	Wed, 12 Mar 2025 04:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyvcXl9n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0FD22098;
	Wed, 12 Mar 2025 04:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741754483; cv=none; b=lU1tF//6eklv9girOLpj81gA3rIARkN8WaQeQvfNyp1K1HA3nBoYJ0jeMwCs+/s7ywYE6EmnIPIyXNFRTpqf9SrIsNAlGm52ci/zmTauyrDofTCsDttJofvWXndtietANKZemrj2oL8QrLj/3WquxjbPfUtgmtxMHYEZEAx68Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741754483; c=relaxed/simple;
	bh=VhuGfbQiAi1E4FjNNMN27pGX3DrTrJlaxXhSdQOLzLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5kFSNLSJctZQGA30PMUbVmjR+Ag+B6rpWjNJHJhIfqjPfOPbq3Hg/RCqBbPTqfXuFBqEw/jt9hLFbDOueBYpt32hKXcba0TfKvI36/MrhrqIfOtE1kLfMo5BWmctmlB1xLwCUmodlam8SsnY6mUdmem0XiY6TWKSAYJBrfbpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyvcXl9n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223594b3c6dso113639645ad.2;
        Tue, 11 Mar 2025 21:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741754481; x=1742359281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prIWCBRfy9KfwUTCFYPi925wPUiEgsj60Kr5IOCZZu4=;
        b=gyvcXl9nfHbq6rNrOtVOhVDGwlBoCHd+9lAcaH8hcy5Lw91nfKaimxtrHlQ5XJwIB1
         8LNA1GNBU9mObFTeIlEShRsobsxxYlzDhXwd8orI9ExTT6Ioy4ra8FEAAGEONfmB+/Yn
         6ep5QYWX62fjtAFAZ6ysB4mvVHNTBzK11J3SlR51XurbGw8TnXc5ZoJA5u/4J5uYOGLg
         OxExv3mgoak49glTj8US+MB8O+yVJxrtMShcfYe1/OfthJC+MzPz0cAhQiPTkliVz/Qv
         6RpTi+CE1S1ytiCm6ozVXSUVfEVnPR6OPvF1EMKjsUphd8HDGCz4fPoSWK9N1ZW2t+fv
         qGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741754481; x=1742359281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prIWCBRfy9KfwUTCFYPi925wPUiEgsj60Kr5IOCZZu4=;
        b=X/BlumprUmHPUX661lsVGJdOsUu8YVLWNyHwEHDI4QjgnyoEu2Ppk2EBRppCYVY5bv
         IzCNsIM6XY2Er0riQQwq/clEpWcWXJkf6QUB6EQsalXTRah53Is4T+ELftMdFKNjRBmz
         PL0AeIj5pmpzJ8LsHXnnUcbILruGJ57RPjpPSrD7orzUPiSM1aAAZTqj3AXuqmk2BVn9
         s7Xf9xFiqfHZ6nUiIstdr7dafgxa95rk3zbEVipLP0DrcCsYoGom6h3biPnYVAsfvO4u
         +nPFSezU7phxmOh7/z2diJgL8CH5AWF+FCwBMo9d5iVoKG3gPrJzu8foOWfaQELBTj4c
         4AyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+QE+N2ji7VolIqJUdzrrQtF7gVX9/zxzoNpR444CTuY9SP9AEHlTTP+t9j6zqvQW5OtnffAFGVFbLsA==@vger.kernel.org, AJvYcCVGE6uMb5gwyjh0AYKOTK77j2B2nMHwnacXoXQ5niZhV3YybZfvtkrTwS8/0/OEuu7Hcx5ZxPzeGbkL@vger.kernel.org, AJvYcCXzs2fXjPxI6BsJeM9LenFvoVlxui4L2YMcxVF4ocnHpmCFtWtnMYP2rx6XrMPq8FbKFK49PVnf@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDDYqGrLPvhC4RnE3aWFL3BD2VBJ3uuOxOelZHSavQydMzieb
	2cJMRaInbak8G7mf1S0EfQucfQhmNq9pTxuMP8meCAaw4Q8TYEvV
X-Gm-Gg: ASbGnctdTarsilYbqzGJPSm3idohX8Sdm0U4o5lK9KfIoWZ21H/Ga+Z188ev0PlLT0U
	g+jg6ibGflDBG3+V0AyS6Rot8BEqd+nTsBfqfp5W/WkT8NgodZ5zCWX/G2ZDo4g8wePsl1m2JQH
	gHT6BQLNL9yTRqc5b0ErEIbgCseYkrCQIG/OB6+MpenCCFeh7szTXG2f+U+41Eh//R6GBI0ua3W
	uhpUwvMdz/7EccFTcgIOTkpFtMlaDrigedcO2Wj1HPaXfoNxsZnlgy6o9F5SS9pscRQLU9DYpvm
	zlWhv55nI5O+YhJyhrceo/Sy+Zp2ojUUB2Iefnzw5VfUNE/gsAfIaKU=
X-Google-Smtp-Source: AGHT+IGa+xo0J/bjyiHZoADJ1aV9uoEH+Elwp3tvSBwT3t6dHEjeUlBPHjydJGw1nQ09WdXUTw+ebg==
X-Received: by 2002:a17:902:f686:b0:224:1ec0:8a1d with SMTP id d9443c01a7336-22428ab535bmr267702285ad.30.1741754480795;
        Tue, 11 Mar 2025 21:41:20 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.39.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aaa9e7sm106983855ad.244.2025.03.11.21.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 21:41:20 -0700 (PDT)
Message-ID: <aa13b199-c6e4-4692-829d-4f73b714081f@gmail.com>
Date: Wed, 12 Mar 2025 10:11:15 +0530
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
 <20250310080630.4lnscrcbaputlocv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250310080630.4lnscrcbaputlocv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/10/25 13:36, Zorro Lang wrote:
> On Sat, Mar 08, 2025 at 03:20:34PM +0800, Zorro Lang wrote:
>> On Fri, Mar 07, 2025 at 01:35:02PM +0530, Nirjhar Roy (IBM) wrote:
>>> On 3/7/25 03:00, Dave Chinner wrote:
>>>> On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
>>>>> Silently executing scripts during sourcing common/rc doesn't look good
>>>>> and also causes unnecessary script execution. Decouple init_rc() call
>>>>> and call init_rc() explicitly where required.
>>>>>
>>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> FWIW, I've just done somethign similar for check-parallel. I need to
>>>> decouple common/config from common/rc and not run any code from
>>>> either common/config or common/rc.
>>>>
>>>> I've included the patch below (it won't apply because there's all
>>>> sorts of refactoring for test list and config-section parsing in the
>>>> series before it), but it should give you an idea of how I think we
>>>> should be separating one-off initialisation environment varaibles,
>>>> common code inclusion and the repeated initialisation of section
>>>> specific parameters....
>>> Thank you so much. I can a look at this.
>>>> .....
>>>>> diff --git a/soak b/soak
>>>>> index d5c4229a..5734d854 100755
>>>>> --- a/soak
>>>>> +++ b/soak
>>>>> @@ -5,6 +5,7 @@
>>>>>    # get standard environment, filters and checks
>>>>>    . ./common/rc
>>>>> +# ToDo: Do we need an init_rc() here? How is soak used?
>>>>>    . ./common/filter
>>>> I've also go a patch series that removes all these old 2000-era SGI
>>>> QE scripts that have not been used by anyone for the last 15
>>>> years. I did that to get rid of the technical debt that these
>>>> scripts have gathered over years of neglect. They aren't used, we
>>>> shouldn't even attempt to maintain them anymore.
>>> Okay. What do you mean by SGI QE script (sorry, not familiar with this)? Do
>>> you mean some kind of CI/automation-test script?
>> SGI is Silicon Graphics International Corp. :
>> https://en.wikipedia.org/wiki/Silicon_Graphics_International
>>
>> xfstests was created to test xfs on IRIX (https://en.wikipedia.org/wiki/IRIX)
>> of SGI. Dave Chinner worked in SGI company long time ago, so he's the expert
>> of all these things, and knows lots of past details :)
> Hi Nirjhar,
>
> I've merged Dave's "[PATCH 0/5] fstests: remove old SGI QE scripts" into
> patches-in-queue branch. You can base on that to write your V2, to avoid
> dealing with the "soak" file.
>
> Thanks,
> Zorro

Okay, thank you for the pointer. I will send the v2 after rebasing.

--NR

>
>> Thanks,
>> Zorro
>>
>>> --NR
>>>
>>>> -Dave.
>>>>
>>> -- 
>>> Nirjhar Roy
>>> Linux Kernel Developer
>>> IBM, Bangalore
>>>
>>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


