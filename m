Return-Path: <linux-ext4+bounces-7876-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CD4AB6351
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 08:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9231893355
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09396202962;
	Wed, 14 May 2025 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enYfJ7Wk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2688C1FF7DC;
	Wed, 14 May 2025 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204794; cv=none; b=GWV4mjvK9TQ6yUqqdKm86+w+xtCUVnWSFTtDC7Mgf5apyJMdJj/lyHPmFA4SaDQT/4i9VNr7CuHwhF5T1Tm3nCg/H84YiQzuLrB8ffAiGaOke1zYRUajRXsQeHfpbZsb6b09rvnPVNk4Ly+zoEGh6nNZxprsRSodYSNUuIeVJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204794; c=relaxed/simple;
	bh=z6DQSKdw7EiVWmZwf/G5KbeaepfjMYq7nmJkT1ToHkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIYqwfoQpmQYFAi/tEXfb6Sg0yYZNXcZi7wKLjEUJRZRsKgPU6qR6OwSBw3BzPjrr16147zvbFAqn+OOuVE97LqVDrFoDsV2eTSRtX4BWeEcY8WCkAeGB0VcE7SIdNn4GDtT6md146tOav9PqEKncpI30Sc8q+FPdMl2KwEw8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enYfJ7Wk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so4415959a12.3;
        Tue, 13 May 2025 23:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747204792; x=1747809592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBUK5rK0vdJYC5VtpgCa8FhtwrE+9PvxaVDa6TzT4po=;
        b=enYfJ7WkBz+zyu5SNxfO8mOZSH8/MPRYaJ0G1dkyNFmQsqt9UAuGAkYXRcPG9SmpMH
         z/67zq4fKWUl3GWoM3oBKSidFIBiAQyYN/8DHQ8r6e9JT9FdwFSuciTvOa/Si5rur08Q
         3eR6zaqQrT70YjifaeeuvtJVuRkPhwbRd0daJoLK8tFdnWcveVjxiaGe4J2OoDIOp1bx
         t9WKt9irJC+qlAdVVGfqmhV7tN43bNPe7aJCkX7uUoEHYTMCfGqA1s0ZymKgcJoBaJGs
         w6j827JM4upkfeNKCqqvNeDhZWAGsA+pRa9CmU744x89+aIx3qEL1bolI01JDdRMEf62
         sFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747204792; x=1747809592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBUK5rK0vdJYC5VtpgCa8FhtwrE+9PvxaVDa6TzT4po=;
        b=utcjlDmnxbDTApGJLfwv3q8m23rn1xp2fGd9dvyrKpSJiCgInno905AS89kL9xlQz6
         orHz0H6WhCRSoMLUIChQ+yewZtPfp4rxshIXtkf+nrUIk1SucMz2vS5ZisXYz3BpGjaU
         dIU/3omZdjG/TCR/GXiL+a3sEg0eYpxZpgARLKq5/Fa/EL00tJM7mk/8wzAjuUfbioTu
         zXfpPL2u+OI4aosGs98/O3JmeA6/VhUgUBBSKvePyu9rfEcXMeY6dQDGuvzKMmID6u8d
         bN5SfGnpmxqI/MPTx4yG6EWR+FyioghoNvDlFWhWfdOA8or2IL7yIzh90QhW/ppuQbB/
         Giog==
X-Forwarded-Encrypted: i=1; AJvYcCUkFM5WRhomVdYfUl+KNocxXPfKBYV/sC+eViKeryorYGb65bd532Ft9QDZUwigoUjA0mLbrhYoCz7h@vger.kernel.org, AJvYcCWtMwcsolx+n3JV4YZvBey4AsO2KRVTYSpfrXj+aXVCC2/euCxy7nSQzEwxdp1M3rPJvPFBvh8LrvAY@vger.kernel.org
X-Gm-Message-State: AOJu0YzcuRcCUTN5N2Ua5iTZhB2w9ld8uY+6J8S75LM8tmEVGX6tTMka
	SmS95gYzdQ9K0B6gQLBFLFniqQPYWLtCMDPVj56H0hUKcezW8+tD
X-Gm-Gg: ASbGnctRYVH2wSnHpmlfOgWH4cDNgO13LMLMfpsPoqndOemH6JvQzfqDOApmUjT6CTh
	jTeqdYdlLS1013IgDffhHbJcK84CTM3Nw/u+KthwpIhFE7wWqf4t7Ms8TKL0rCJCDHrNUS5COPK
	nNgr5UibFnITvL+kc10GODipxNjk5YnBCliXB2qs9B911QL564KD1/G/kyAs5ANQOB69EgPRdyE
	oToa+jNimcqGEHlBsJnJ0lTDbfBiDm0UDpNjONuU5u3ymkzCqRnrVgKrscfoKVS54rD8/UiHRi4
	DEj2H8kXo0Exu0cMclO1dAlZlPc6oL1U7h5IF/mVwagY2nywKSDBo92kKTtEQA==
X-Google-Smtp-Source: AGHT+IGKyP8yrveuzqGXNmGc4S+UTEIIokIwrGOcw4E4efNRJSjF2Tzf8ZCqFwFuIsGI5ccMJlAMXg==
X-Received: by 2002:a17:903:2f89:b0:22e:6d46:a5d7 with SMTP id d9443c01a7336-231981a27ffmr37214785ad.35.1747204792223;
        Tue, 13 May 2025 23:39:52 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271aacsm90963895ad.152.2025.05.13.23.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 23:39:51 -0700 (PDT)
Message-ID: <2b85b6eb-e163-464f-8c7e-4377a03a0cae@gmail.com>
Date: Wed, 14 May 2025 12:09:47 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] new: Add a new parameter (name/emailid) in the
 "new" script
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
 <837f220a24b8cbaaaeb2bc91287f2d7db930001a.1747123422.git.nirjhar.roy.lists@gmail.com>
 <20250514053644.q2yzlhceclxvvffn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250514053644.q2yzlhceclxvvffn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/14/25 11:06, Zorro Lang wrote:
> On Tue, May 13, 2025 at 08:10:10AM +0000, Nirjhar Roy (IBM) wrote:
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
>> index 6b50ffed..139715bf 100755
>> --- a/new
>> +++ b/new
>> @@ -136,6 +136,9 @@ else
>>   	check_groups "${new_groups[@]}" || exit 1
>>   fi
>>   
>> +read -p "Enter <author_name> <email-id>: " -r
> I think most of "YOUR NAME HERE" are the name of company, e.g.
> "Oracle, Inc", "Red Hat, Inc". Some authors just write their names, e.g.
> "Filipe Manana", "Chao Yu"...
>
> So I think the "<email-id>" hint isn't necessary. If someone need that, he
> can write it with his name together.

Okay, I can change it to in V2:

read -p "Enter <author_name> " -r

Does this look good?

--NR

>
> Thanks,
> Zorro
>
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
>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


