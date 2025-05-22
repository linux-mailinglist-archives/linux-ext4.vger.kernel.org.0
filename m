Return-Path: <linux-ext4+bounces-8169-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E86AC0392
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 06:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B67946417
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 04:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4F1A072C;
	Thu, 22 May 2025 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO/98sqo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617F33985;
	Thu, 22 May 2025 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747889409; cv=none; b=Ck5VpO/f5LgADrV5Uh0cOk+UAaGWPNkNRShT0RrXWXZtAmPuW3NspQZsEryFWEsY70fJ1LKHpcSAwSWIE2sIxf9Bg7Ygn1I2X9tv+enIZxwj3wYMOdShRxeceWmsWNj5wtUFkoWkobWi/IkyKiCYHa+kp+IXNYIlwGqtHhb+CEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747889409; c=relaxed/simple;
	bh=/EeUPQ5pIqv9twthvvLocC6lcLHRN/Xzbnzccp7axqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AypH0Q3GVM5KEZPRok1/DrfPHBsdERJmiesa8/oy/6UatqGUKllZ/owux99uzkhj2Fww757UVbyU8GQ8IQiWuIggGplADLiavIRmaid2EAv0/la0dCyhBkfTtwwbvJg/2nPPc8PWffoo1YJgY96wJFOyWXHoCWssNhANwso+3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO/98sqo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e033a3a07so75552445ad.0;
        Wed, 21 May 2025 21:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747889407; x=1748494207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0pe6MxgRL+0gJYeT6ZvM46M+xztoIv4b0Ya8nisFxY=;
        b=GO/98sqoc820putE4jb2eFqb3PgfyWIEMZHkfsx07srpDBTANwR23Bk4EMi2ntdcZL
         7GV9WcQwxhogvHe5sYVhhSmswlhkkgL8FSWyMKl4Vs0dKiFu1atSBO3XfLFdyCkNW1gD
         iw01Hl3+YlrZllEYlMv4iIZ8NBqDVtk0RJDze9yf4aWnUDrNYj/82402KjDPSDGaAOXo
         j78d6xPsC+IU3iRDuvZY3Hxmtk9mUJ0C4aklY88vHJaPozLBZl660Zkhp2MosDkoGy3d
         tu5vE1dpfJZTqcTPopJZb7zpERC1SwyI8Rc13I/+fytVZvZsWadMRtwGvwY/RACv2J1r
         0WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747889407; x=1748494207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0pe6MxgRL+0gJYeT6ZvM46M+xztoIv4b0Ya8nisFxY=;
        b=T6TrkGzJX2/kVC7BujBMXq/+VVevD8K+YS9y2hzSbe3ylOIqeWNj4dgEdeJG4TD7Rn
         vfPVfkqByi+g/CzGnWXvg233/WO17XGlcs3SnrNK00G2WgZ767Vr/hbkk6DSL/+QeKKU
         Mod0rs+1kBgWHxyEM4+E58kzzr34heckMFUC1BoWGrc1g2nhOvJSjxtj5CViDkQpwFop
         nQLKm+LCPMW0FbV+nnenAgCsrAiOtkBQD3OK5MqxvLD7+eLzkqPs5R3zLqlHYwAOAee/
         zk6qE6dq5wdkmIxFF+sdwOtpybFuk5V/wIRf5ys5eEPSiC4nBI0sd21qL+ss13gFVocX
         G8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX4jnnhsFt7/+eJJQ2fK7fU1IdcdJ6GJAWKp/TfVRWay7BEiDfxeti4wbt6EL9d3ecQnwhrA41/ssNg@vger.kernel.org, AJvYcCXUOeFI8abS1K8bCoN0N2v6ce6PgKcFnlihXLUA9etP+BGhHPO3rTgL7lq8gl728ac/iJmehcjomdAU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3Os7B9FziDInHfd+Ckcn41B+IYZ77gSb33cfKizZOA5u03kv
	40/W4ClwIhenwQKvuxqDEkTA9PyzFziuGmG+GXKnUah4HW/rJmLPVIBLAv2dsQ==
X-Gm-Gg: ASbGncv38Jx9OsxX6u2Itzhthw+8tdKu83ERibBVj0lGxDU1C2620Oy/PsrYA/MK72x
	TBP2pKl8uaP/EGMB3TZBM0ILR0O5vNMi2+xdQDBlzFj1aYbhPlu5iEM084VH5Y32QIyzo2DmbzY
	gvoe8nhr4syNmuu1QSjJNoJabbLRFlfOUXdhLnwHQk+b/wNb4hfAUPs8WgaIW8oFigUYOAEDncM
	Ug8mVqAibjdLAee7BCfqy8vL4iAk0aYlfP1HW+n/KF7zdrN6bO6YDekPjGWSjyZcjUfwuANeBF1
	nolKfPzR8e6BNX1CfYdxc9SnJeaDoKUM5mguhuIpFeL7itLSXN8Azi/ReicZ+upFLQTITYBa
X-Google-Smtp-Source: AGHT+IG1PaiNlAjWPBlE2EwlDf6MSAmKwBqsihY1yF4P8oJWPiBc0NJ9HSKIFrMXJSuRIH6lAsakOg==
X-Received: by 2002:a17:903:2ec8:b0:224:1943:c65 with SMTP id d9443c01a7336-231d44e64e6mr343148555ad.14.1747889406867;
        Wed, 21 May 2025 21:50:06 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-232053579d7sm81644965ad.80.2025.05.21.21.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 21:50:06 -0700 (PDT)
Message-ID: <663e86d5-4e79-4f37-b2af-9c671c8948ef@gmail.com>
Date: Thu, 22 May 2025 10:20:02 +0530
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
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <cover.1747306604.git.nirjhar.roy.lists@gmail.com>
 <2df3e3af8eb607025707e120c1b824879e254a01.1747306604.git.nirjhar.roy.lists@gmail.com>
 <aC0Q2HIesHMXqVLG@dread.disaster.area>
 <12e307e0-2a28-4a42-a8b3-d2186c871be7@gmail.com>
 <aC509xXxgZJKKZVE@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC509xXxgZJKKZVE@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/22/25 06:21, Dave Chinner wrote:
> On Wed, May 21, 2025 at 10:52:22AM +0530, Nirjhar Roy (IBM) wrote:
>> On 5/21/25 05:01, Dave Chinner wrote:
>>> On Thu, May 15, 2025 at 11:00:16AM +0000, Nirjhar Roy (IBM) wrote:
>>>> This patch another optional interactive prompt to enter the
>>>> author name and email id for each new test file that is
>>>> created using the "new" file.
>>>>
>>>> The sample output looks like something like the following:
>>>>
>>>> ./new selftest
>>>> Next test id is 007
>>>> Append a name to the ID? Test name will be 007-$name. y,[n]:
>>>> Creating test file '007'
>>>> Add to group(s) [auto] (separate by space, ? for list): selftest quick
>>>> Enter <author_name> <email-id>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
>>>> Creating skeletal script for you to edit ...
>>>>    done.
>>>>
>>>> ...
>>>> ...
>>>>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> ---
>>>>    new | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/new b/new
>>>> index 6b50ffed..636648e2 100755
>>>> --- a/new
>>>> +++ b/new
>>>> @@ -136,6 +136,9 @@ else
>>>>    	check_groups "${new_groups[@]}" || exit 1
>>>>    fi
>>>> +read -p "Enter <author_name>: " -r
>>>> +author_name="${REPLY:=YOUR NAME HERE}"
>>>> +
>>>>    echo -n "Creating skeletal script for you to edit ..."
>>>>    year=`date +%Y`
>>>> @@ -143,7 +146,7 @@ year=`date +%Y`
>>>>    cat <<End-of-File >$tdir/$id
>>>>    #! /bin/bash
>>>>    # SPDX-License-Identifier: GPL-2.0
>>>> -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
>>>> +# Copyright (c) $year $author_name.  All Rights Reserved.
>>> In many cases, this is incorrect.
>>>
>>> For people who are corporate employees, copyright for the code they
>>> write is typically owned by their employer, not the employee who
>>> wrote the code. i.e. this field generally contains something like
>>> "Red Hat, Inc", "Oracle, Inc", "IBM Corporation", etc in these
>>> cases, not the employee's name.
>> Yes. The existing placeholder is already "YOUR NAME HERE" (which I have kept
>> unchanged). The author can always use the company's name from read -p prompt
>> or simply chose to fill it up later, right? Or are you saying that the
>> existing placeholder "YOUR NAME HERE" is incorrect?
> I'm noting that your prompt - <author_name> - is incorrect
> for this "YOUR NAME HERE" field. That field is supposed to contain
> the -copyright owner-, not the author of the patch. Sometimes they
> are the same, but in many cases they are not.

Oh, okay. I can change the prompt to "Enter <copyright-owner>: ".

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


