Return-Path: <linux-ext4+bounces-8192-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9296AC2A35
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 21:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E4D7B667A
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5A129B208;
	Fri, 23 May 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU2NO5Ju"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1D29ACCA;
	Fri, 23 May 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748027214; cv=none; b=tuMj1GT5WB8Wm4rZf/bPU4DBCf/ZbKUo+MwSlmuSG+srpwbJC97zHQZdAmLPzsJISd1QF+CZC8sZqKvJFuxk4z39Cj7IGMcuQNJ2VAscNwpsjY/GOYK+UmknGzGXkFzYb262nfAXDpJK++GMosBUBXEEsFTPFMbqslMJB42Qeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748027214; c=relaxed/simple;
	bh=/yhcV0nM7nJvqalwL9izUpj2r5Qyemir5wsgi5jyR0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keF4hQP4TdC3Poi313bIM6wRX3SDXN9wHPIjKdGtm2/6T+s2e8jZOtaVctDCscRdBs1O7hCfiKgkVJFKRq1bbkwan23S9KwLddDNM91QfFiofDo07VV8hKthRp34cpjmHmTxQMBvqvXVTCjK2AGVWVc4EkcNnh2ESGE1sK24PvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU2NO5Ju; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-231f5a7baa2so1707855ad.0;
        Fri, 23 May 2025 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748027212; x=1748632012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYis7B+fGnFFXHnsZl0mRWKYsE56tg/s7gqRDiDazlw=;
        b=VU2NO5Ju7cOu0wgS5eXw8p+lV+t6cJiNVINyJqHUUQHip+ntkJoQW0m3fX/nklUKyv
         U19+s65mRIDdR6GaCyJXsmZAv34VY2fiqhJipSFZbFC2UHyYm20Em7FMJO9ftWu48q4m
         J1faYnZxl7sdczJv8COYJV+Lupk8RLpbvonYWYLYL563LlxIzV7E72Ggk6SLSPCcZeyA
         mCGl6kloit2RmKtCzZJpUJktNqKnbRoX/73xf42ugjS1k8+pcpZEVBvpSme4Divy/Vh+
         b2EKf5O8hMzPyIu4jMFo6JLm5iI4JF2C4P6F5lJGkK9nlfGvCudMoQcdOcGhqa9Q1QG9
         1NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748027212; x=1748632012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYis7B+fGnFFXHnsZl0mRWKYsE56tg/s7gqRDiDazlw=;
        b=geFQGI4pIaAm7b8Gy628vxQs7P/xN2v5qmCHRAZmGeAavKEqqMlWgWauzD8vvSJzKp
         /yuhq+WB2bFrMj77hBz89zETi34jcjk0kTgjArwa5NbRqxVPPkGMhdVobj714iV2AuG1
         Is0F5KAkqYRpI+zVswB3Md9RYKYuFagwrAOLnIDqQg/lJ4UnqU7xtbH/UBGe+AX8tKyB
         aYWGgqy1M++wydD44msT7H7H0AHVRy0+afLSkrjJOewzDufdSyfJ3d3uvumPeG09ldPB
         KhS6jqwCg4wtNmYvHe1fUuNvFIUPlfsFGRsavMsX4RdiTVKVtBmKtkJRYUX742Ctz55B
         NNpw==
X-Forwarded-Encrypted: i=1; AJvYcCV6w8bNkKLA/5/p/LABi8w+kEwCLUOlYr9fCkuTL0DRfkS/9L7qVtLJF9pol/Tc9ggacFu4JHMpeCe0@vger.kernel.org, AJvYcCWsOyT6d8NFuBK+yc+op8vIUUsbj+hLWdnSK6EvH9kre8qb8VDePa9sl2S3LaU/XcvqVXJ1X8FwYpbM@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFBkTdkmu458qVCGGZgjZF1Z6we7+skbTnjRPP1jfgI2cVSJv
	HDaP8Y0o16XOq3JSjy+MNLMAEULpROYd4/jCzETzbmwjxj0YeAl//CgkMOIQjQ==
X-Gm-Gg: ASbGncsJCt6n8jy8IfpDj3ezI/hXSZfo8uhUOD0fJovB9yCAWbivyaJmr3ef6MxeAN8
	NnUGze5iO/5pBtegVkw86qbjOeJ4FoFM3fP7F6q/yLTn7KHdpkuvTv7mZVEE6yRwnMCY+YZ1FiR
	STYYCV2fJ8UOt4wGpBLT3dgK5dftBsnyKxiO5IbfmEFS6ZHqdE2d6m3UoP67D4BveTffZoiACBx
	y9qMO79ASsR9ocSchYh3REWLPXNmi2CjTE6ib+Lv00jW1cC70qqaY8GqB3QfDXX5xAR/QvLHNMd
	lrbCE38diErm4CgeYlQgtibZW3bipugVIapdhT86SzBoAyrlV0kgM9lhatopLg==
X-Google-Smtp-Source: AGHT+IEA9XAcO3GZPDy9CIIZkuRnHcffjQYxs/+5mDozGrY0rB54TyYeMzLeL9CsMRJmaMYF5yO8zg==
X-Received: by 2002:a17:903:138a:b0:225:abd2:5e4b with SMTP id d9443c01a7336-23414f5b7bdmr7554635ad.16.1748027212402;
        Fri, 23 May 2025 12:06:52 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed5426sm127418655ad.237.2025.05.23.12.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 12:06:52 -0700 (PDT)
Message-ID: <c95fc356-d7e5-4a0a-9e0f-8581893da189@gmail.com>
Date: Sat, 24 May 2025 00:36:46 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] new: Add a new parameter (name) in the "new"
 script
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <cover.1747635261.git.nirjhar.roy.lists@gmail.com>
 <2b59f6ae707e45e9d0d5b0fe30d6c44a8cde0fec.1747635261.git.nirjhar.roy.lists@gmail.com>
 <20250523140343.nabmzlbss346faue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250523141221.dnndb3b24w27ocmu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250523141221.dnndb3b24w27ocmu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/23/25 19:42, Zorro Lang wrote:
> On Fri, May 23, 2025 at 10:03:43PM +0800, Zorro Lang wrote:
>> On Mon, May 19, 2025 at 06:16:41AM +0000, Nirjhar Roy (IBM) wrote:
>>> This patch another optional interactive prompt to enter the
>>> author name for each new test file that is created using
>>> the "new" file.
>>>
>>> The sample output looks like something like the following:
>>>
>>> ./new selftest
>>> Next test id is 007
>>> Append a name to the ID? Test name will be 007-$name. y,[n]:
>>> Creating test file '007'
>>> Add to group(s) [auto] (separate by space, ? for list): selftest quick
>>> Enter <author_name>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
>>> Creating skeletal script for you to edit ...
>>>   done.
>>>
>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>> ---
>>>   new | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/new b/new
>>> index 6b50ffed..636648e2 100755
>>> --- a/new
>>> +++ b/new
>>> @@ -136,6 +136,9 @@ else
>>>   	check_groups "${new_groups[@]}" || exit 1
>>>   fi
>>>   
>>> +read -p "Enter <author_name>: " -r
>>> +author_name="${REPLY:=YOUR NAME HERE}"
>>> +
>>>   echo -n "Creating skeletal script for you to edit ..."
>>>   
>>>   year=`date +%Y`
>>> @@ -143,7 +146,7 @@ year=`date +%Y`
>>>   cat <<End-of-File >$tdir/$id
>>>   #! /bin/bash
>>>   # SPDX-License-Identifier: GPL-2.0
>>> -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
>>> +# Copyright (c) $year $author_name.  All Rights Reserved.
>> Dave thought we shouldn't use "author_name" at here:
>> https://lore.kernel.org/fstests/aC509xXxgZJKKZVE@dread.disaster.area/
>>
>> If you don't mind, I'll merge PATCH 2/2 this week. If you still hope to
>> have the 1/2, please consider the review point from Dave.
> Oh, sorry, you've sent a V4... Please ignore this one, I'm going to review
> your V4.

Yes, I have sent the v4 after addressing the review comments.

--NR

>
>> Thanks,
>> Zorro
>>
>>>   #
>>>   # FS QA Test $id
>>>   #
>>> -- 
>>> 2.34.1
>>>
>>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


