Return-Path: <linux-ext4+bounces-7960-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DA5ABB46F
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 07:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DBB3B5924
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 05:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBBD1F3B91;
	Mon, 19 May 2025 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDTX4W0N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BC01EF38C;
	Mon, 19 May 2025 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747632108; cv=none; b=U/CxpZtH/FOM/jzXW3G9hdQJXBrMElAnmITJXjigOQLlLB4oDu8ydP4KOdXP4U2tZtj0R1LcmUgQykxa49lcepeMg+Jnaqn2Q6/WfWbZC/UXUvT4xUQizpYcumrYGtm8HpoQMNSu9iCMuSgzelj9vN+gZKJNl6xGJ9YRFRQoPZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747632108; c=relaxed/simple;
	bh=hRSGTZ/TCqdXc/wHCs7bXw3k0TyKsAyUPjwx2yKa4lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWzA3p21WaZDlcvERf35lkp6PjZx874DMre08GwkORq7o5hdymohNS67SoRqZQ2hqTKOKZTWqRcR0UvS9ZgCvp94LZMmbKp2+zyFr/fBNt5L+bBUrVsSiSX2yazGOGSVtXZ1O0fh75Jtoc/bvlxU6qfpizIj1F+yBwl7x78HNjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDTX4W0N; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c73f82dfso609640b3a.2;
        Sun, 18 May 2025 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747632106; x=1748236906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rp1k/HpI+Gv6FeFGvkOUZD9sHzNzRonAcKHbeMCNeWo=;
        b=TDTX4W0NJWKnUKiHqjbO8AurtJEAjZUmXQPK8QaKF14jJKZd2D4O+5lwLaw9ouLH0r
         HsnhM93uIBkwWOvVnuPMJWFoPJfqmgxSDqcde18VJFATzzfK1up3tkyHpEomDTBNx5cX
         C9qT7pzJBzETftkNtPDZ+3EzOc6vGIrPXviJMVuSS2YN4UKY0BNXcY4Wqu0cxrFX78Is
         5O7i6WAbs96PWUlLelyL2Xm6vu4KO738sZuT8U7CQNLwrctayN7poki0flL4B+US7cjm
         NA8ZS1Ozyf8/oZzQkWSRSvG+v1KKloLAS49CZrv5OlynA6xKI0zWjDYdzbrzzLA8LHfW
         MP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747632106; x=1748236906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rp1k/HpI+Gv6FeFGvkOUZD9sHzNzRonAcKHbeMCNeWo=;
        b=PHOg7/Gf+HNTuzhb2+mco+rKGKiL75AOYe52uXHDKHAl6TNfV8zOyT6B4bgP0t6K2g
         sC6eVint3YOUr8CpkuWcEFxFxFZ4GYTe9hMUQ/S44CjbSJ94xIVoQQ3+4Ae5nrzhCQbA
         vxXA6CMMiyaEM5WJ8ukrwtfYNkRTlW+PQv+FaeMHtpLSecKNZZlrDkaPIJldqm8i+0En
         kgLA3e4exEbFV1G4lE9EeHdM/VQHMdY5F8hcd3MWIC48Zu/FufDvDulOAHdC0J5Je8Qw
         CePfSBsnuqWODY+hG0/ZeqpgxYLOLaQZzEk9XAzNuRp5Fzncz45+axV8Gybn4i1+jUYe
         LiTw==
X-Forwarded-Encrypted: i=1; AJvYcCV+DWiQdd1AE+YJp9fbWhfW5dZeHRGvRQSQBQRVQRkVpfdZqOg6yfmu0mSGbig6/DJ3WheutwTr@vger.kernel.org, AJvYcCXInxF3VLnbvLKcBL5XTXStWatBBddNhhFkcmhGu3+MFhxlUW4lPhNwD9e6W+JPKqC84fE7EP/0Xw00@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6zZRjcQ2zSDCNZuQCTrTEEUhWPWcxI1kyrZCJ6QmQ2CQtyaj
	piYU7cxlZ/4lUG536RHLCoci/pukc8/nq/SmYXHiumBDUzVAXNVfpfMgF5l91Q==
X-Gm-Gg: ASbGnctZdoZumQTicPCV//bf+/XRxRqG/Zn0AlPDMiInRee7O+gb6F0XNJVwl9Xr4wW
	JA5HONv7uhqLO3vPE85A44seSBL0ITihXGQb2/lJ+d+oixdoNt48tcoNnYwfyClMpB2cytSAghY
	53XwPB8FTQT3089P3O4p4oMcCtW2zegUyQ1V9qj7uUulPpN6Gt6SFNBitcGWSc3Bwrka8mWXA+y
	PulLpdaXb6UF/cq7R+fZcZ80waDhVm/qbxMqumS8ihBAZuE58Wk9tXdVUIxBA87L4Tx68Sdfdx7
	bfYsyrOuf7TqEWw3Y1Zt2Nd2ghLPyo6iKrT7sXVskmmyFuhZlED6TPTGMWvVq1+1ui+xnULm
X-Google-Smtp-Source: AGHT+IEa9piqsycGr5dVtgMxUzC1ptzHLucSwtJh1qbjrNy10hMLozOg9bpfvgMKFIGeJAW2vtj6jA==
X-Received: by 2002:a05:6a00:1824:b0:742:3cc1:9485 with SMTP id d2e1a72fcca58-742a97e0b31mr14879726b3a.12.1747632105924;
        Sun, 18 May 2025 22:21:45 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96defa1sm5513162b3a.12.2025.05.18.22.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 22:21:45 -0700 (PDT)
Message-ID: <4e66af48-686b-43b6-970a-91d927fbe5a3@gmail.com>
Date: Mon, 19 May 2025 10:51:41 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] new: Add a new parameter (name/emailid) in the
 "new" script
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 david@fromorbit.com
References: <cover.1747306604.git.nirjhar.roy.lists@gmail.com>
 <2df3e3af8eb607025707e120c1b824879e254a01.1747306604.git.nirjhar.roy.lists@gmail.com>
 <87jz6gvto1.fsf@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <87jz6gvto1.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/17/25 08:18, Ritesh Harjani (IBM) wrote:
> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>
>> This patch another optional interactive prompt to enter the
>> author name and email id for each new test file that is
>> created using the "new" file.
>>
>> The sample output looks like something like the following:
>>
>> ./new selftest
>> Next test id is 007
>> Append a name to the ID? Test name will be 007-$name. y,[n]:
>> Creating test file '007'
>> Add to group(s) [auto] (separate by space, ? for list): selftest quick
>> Enter <author_name> <email-id>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
> I don't see much of a value add in this change here, as folks or
> atleast I prefer to quickly get into writing my test first and later
> worry about these details :). But I guess I understand where you are
> coming from, a lot of times people miss to update this and end up
> sending a test with "YOUR NAME HERE" placeholder.
>
> So, sure if we are doing this - then please fix the commit message too,
> as it still shows <email-id> above.

Sure. I will update the commit message in the next revision.

--NR

>
> -ritesh
>
>> Creating skeletal script for you to edit ...
>>   done.
>>
>> ...
>> ...
>>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   new | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/new b/new
>> index 6b50ffed..636648e2 100755
>> --- a/new
>> +++ b/new
>> @@ -136,6 +136,9 @@ else
>>   	check_groups "${new_groups[@]}" || exit 1
>>   fi
>>   
>> +read -p "Enter <author_name>: " -r
>> +author_name="${REPLY:=YOUR NAME HERE}"
>> +
>>   echo -n "Creating skeletal script for you to edit ..."
>>   
>>   year=`date +%Y`
>> @@ -143,7 +146,7 @@ year=`date +%Y`
>>   cat <<End-of-File >$tdir/$id
>>   #! /bin/bash
>>   # SPDX-License-Identifier: GPL-2.0
>> -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
>> +# Copyright (c) $year $author_name.  All Rights Reserved.
>>   #
>>   # FS QA Test $id
>>   #
>> -- 
>> 2.34.1

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


