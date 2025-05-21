Return-Path: <linux-ext4+bounces-8060-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF83ABEB3C
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 07:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016C54A7ED2
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 05:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723522F763;
	Wed, 21 May 2025 05:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfCbH8KQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C561EB39;
	Wed, 21 May 2025 05:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804950; cv=none; b=HrXFSqPz3BsQ3W8+q+K0J6HL6V3qherJHw0rvZCjUMvnmORFig45Qs9tFEasolT+Lvllvrp64ZR+n3udkw6pomMUw4gVhpfKgEEgCMA62F58AK215FAgUmHnRMFyCob9LTGzOrzbBYjvtzL63gCU0AiOUYjeIYM/JICQOOTtifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804950; c=relaxed/simple;
	bh=yS2FDzk2IyndOu/uLZqNGTmZqi7gABsUOkiEt0dzUuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBbYpI+576HWKV6kAbwcv/ot+vfHXTNtBaXgutK/HQXWnQ9E9ZCFAkAywnemBaD2YS1xQIiYhBnP1rCuoejMxIzV9ckUqfbp3QKJQG751pVjFSxSJeA544cGumq4eGG6t3mC9qVEszQJteqHI/W9s6aDecmqNOdK/9wQ7HOe28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfCbH8KQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso6366187b3a.2;
        Tue, 20 May 2025 22:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747804947; x=1748409747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HzUgKYXn0LXczq8FLr2PjSn8E6VE0fAraKDRlzM6lw=;
        b=YfCbH8KQB/aFoHZLfcDljUD7vwsKsqvkutBu2eTyE1N4ODZ5o5iSbhE18knmzPUYNK
         xNolpcx/guvR7fZqNRsh6S205rJB1+WjTXeQcFBGPISBKAOUcD3xcAi4WfW3Jha97h1V
         E6HwuaeH3OtqAyhUzl3Xo7Vorhty5u5PSthW/5ZsGhA9BD5iDJriCk+U+CPoQqhBPuBJ
         bTeA5y/IZjFRDVfLOvum3tM1mzav3qkalV2y83Xn9VKWavHoK1pNjJxOGGsECChrI9Oe
         29v5Le/6IbbFGWAYvd+c8V87j/+fwLjdMVWoPnCj5eWdFaUx8tD4Cd0oc1RzqbmUgLVM
         EYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747804947; x=1748409747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HzUgKYXn0LXczq8FLr2PjSn8E6VE0fAraKDRlzM6lw=;
        b=j5MBunQlUqUjbYYZLRC5fs/x8FLvMG1xSfTyOPgzQkK1igcGSaNAVhtDvGNw1PmeKw
         PdEPn2rVwkSYB4a3mUAY2P4qmzaKHh9fZIxZkW3LzMEcNhBRsdTeu52c5HjeJUs8tGGL
         iz4O3FOLcreFa0Dp4fFPDEFjh5JaD/k6TY35K4c4RYdqnRu0oqKs2iuuinjWatub+GnQ
         uqQOLFzi9RFuc8pgbDZf8PVhjWXutbPmv2Fp/ZBVFwDSfoV5L9mxzJzeAbUBPSYa7sZh
         KG897Vu8Ahm5wgIks4iXbOvAgemwdvOH+F2zDG5BXkWEEoXdIcYmLV/XvKUgYjjwrqV8
         gjAg==
X-Forwarded-Encrypted: i=1; AJvYcCUo9tA2OYIap4APVKCKYyfmjaOB20FknCc6fjbx4I4lDWluVmJfme7fXnyG/Je6AmK9CsE1OcP+irUK@vger.kernel.org, AJvYcCWegZ9vpDOuCUPOouod36Gpa4wB72t/4NwDSlZUoVy+mOqn+B2vst/8jdd+ZLMPAKHLEkLgvwN+ZPyD@vger.kernel.org
X-Gm-Message-State: AOJu0YwOA8gQF+Lnkc7lsheqb5izlQ9yY6LMgfa+1LxEaf7+HyWXgrrl
	+GVOdsAM1aD8thwOMfLyRVzp+DaNV8iQunGAjFNkz6PVVi7wWDMf/1eH
X-Gm-Gg: ASbGncuLx4a9xYCGANwcdALFkzLf9NGMIBbWtn6/jk2RJu0wQKsRlUZgrWtc+CcIGOI
	qtK1nAIul/FWyEeqPTiZFI42EY8dldGlgu9nPmStVcyT4CuO+z7q4QtKpAqHmG+jmk+KC23etAC
	TR0N3gx37DT7SkJJWkKJc73ucikzWRuyBD5qCEDcSEtzS+F75ghsLuIB3x9k2JAphr7XQkQHcT1
	jkSU9gZ8U9ljM7Z526sU9UXfq0aHaptAcM87E+NqqwpDNPYZYkh8wCNQj/i95fEYOB7GqUaIg5r
	fE7FvcExof63e/cwd0pswPEuOfI0OiZ2fAEZImqf+wfX7oSDS7rDv+tv0wVEag==
X-Google-Smtp-Source: AGHT+IHCNMqflhS0sfYJP9Boe2PUxeOde4RtqgDA1rD1GUGqb7AJ4Z5YdnH6jJ/eJ/d9tbfqB0tS4Q==
X-Received: by 2002:a17:90b:1dd1:b0:305:5f32:d9f5 with SMTP id 98e67ed59e1d1-30e7d4f9220mr33543530a91.7.1747804947456;
        Tue, 20 May 2025 22:22:27 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365e5b91sm2721207a91.39.2025.05.20.22.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 22:22:27 -0700 (PDT)
Message-ID: <12e307e0-2a28-4a42-a8b3-d2186c871be7@gmail.com>
Date: Wed, 21 May 2025 10:52:22 +0530
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
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC0Q2HIesHMXqVLG@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 05:01, Dave Chinner wrote:
> On Thu, May 15, 2025 at 11:00:16AM +0000, Nirjhar Roy (IBM) wrote:
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
> In many cases, this is incorrect.
>
> For people who are corporate employees, copyright for the code they
> write is typically owned by their employer, not the employee who
> wrote the code. i.e. this field generally contains something like
> "Red Hat, Inc", "Oracle, Inc", "IBM Corporation", etc in these
> cases, not the employee's name.

Yes. The existing placeholder is already "YOUR NAME HERE" (which I have 
kept unchanged). The author can always use the company's name from read 
-p prompt or simply chose to fill it up later, right? Or are you saying 
that the existing placeholder "YOUR NAME HERE" is incorrect?

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


