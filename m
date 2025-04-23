Return-Path: <linux-ext4+bounces-7399-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67F5A97E79
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 08:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC3017E2DE
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 06:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72E1C8633;
	Wed, 23 Apr 2025 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9Cye0xD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B114900B;
	Wed, 23 Apr 2025 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388176; cv=none; b=amrtOzpBlpiba1j6VNm2GGe2ZJrd3aLWKuTOePg/0iKph2VXp0JQXn0MEHQmpil5BcZDP6B7RVrjbsobrpkF6U/Azf8nglxHuI7OjQkaPMDfabwlGkJe3rWgYGYXgc7EptINHrwdwGdlDUDFyPyZMyZC8uN98dfOaOD7qLQp/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388176; c=relaxed/simple;
	bh=rY6PqrHqGzIE6R8mrMi04HII8o5r81P/XprkeaGWQwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=No4obpKSR3nsIz7MB955+rb43KDbqkCd3n92fodor+2u01ABsuZkaBXiPEzTgPFAUxbtlAEVjrs+gOiZhhuSTqeXkAmjZrd7mJNFCLrtQMyvtLbypYZr0K6o7QoxvKw0NlnJamYVMNPhTo8AGIR0Tu/FPRLJqvSAQ+1ceThAyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9Cye0xD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso7468521b3a.0;
        Tue, 22 Apr 2025 23:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745388174; x=1745992974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXZ5TRaDdNFNR1l8MfvxYLddFq49FbInV9BwUmDWSDc=;
        b=X9Cye0xDehqXRbKwtlGb3EPgoBXq7CCYSlcSLM9r5A2yJVEvkbjDBsZnsFGX4wUMWA
         hMarXUzcISbyd6FqK1Z9VR/7VjuYe+Vkc56zYPEsb/wPGNocz7WotP350OZFb2iBIz66
         4Mevc3MAUB5V8axFxgOW7sBEkgdxTF92U4A6WA41Z7EbBWUTtdJpLuPZwJME8UmEVpO6
         vki8bL1qcVpwgzfqtRXyT8YP12QMrTTCIEQqybXSzwrGzXPUUZ9jMsk3c9rwdadRI0wS
         nIac37nTfwBKKIPerTO7IHmF1Mlfu1mQF7oXDFX8PecDESFeI8nj1UGr2x0gdHEZ4/Ov
         TS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745388174; x=1745992974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXZ5TRaDdNFNR1l8MfvxYLddFq49FbInV9BwUmDWSDc=;
        b=OPayfq0UCocvOIJ6RJFUWCAQCoEPoaDKPfs6fdx33w3J4MsekQBLvm13xThyNxUXMS
         8kJMbEH0N3cCSAaaFE2Z4cNrRbAjd6mmgcGjcNWy/Sf3bs5DB7m0mL46kyegyESmftyG
         t8IqUAraWA/mpqZDGn0UMl7zJRy7UA7idFNxkOm3cTY+GbCxEpLhOOOVKDIROrSuLxLP
         aK2j1xL8rouytYyDmWIAFYctWHJSJ/VFwfQIMZH4aqqCnfkCYAUG8M7TDX3Ih0ptULqo
         IazYVnEqHpiGX4TKC0vVqeyUAltqozxd1GYQRORaJEAJSwv/bDFW14clAT1RbYexTUWS
         0TwA==
X-Forwarded-Encrypted: i=1; AJvYcCUSS7OpCqSJYQQhp2Bst3/2tjWtH0FanbK4nW8MhyBzByumPnygZgSBnAFBm2eYvxS/6KKYJIKQ@vger.kernel.org, AJvYcCVKLCZuUpzvK0pjX4KBW8coNsSRX1i5v32cG+OIz4Eryk+tIYtggQ8AWnTX4XCfnlGL8dO97nGay7khsA==@vger.kernel.org, AJvYcCW1y8fiRvRS04aDlwK3SB/2i2th5sWWeLFk/xZEFq4tFQVZxcH3NDG7a4+3ZQ4P319EsuNm7o69f842@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvJIvKe2mGnP+j5OXr4LP+0zYtdJNQcqcE8qFsJq6+fnGgeNO
	zouulZKlbmkodUwgsC6XhYBcHTNvASQllH5SNVCGOCQiIf9mXHSJ
X-Gm-Gg: ASbGncs+DUSmG5Ok8GV6gIPJkZH+H/TcTMThirx76UqYUQ9kLLJYVHUVQ1EVYcsdGgR
	tSEsI6Br8haPTeGxcFYpaIKtWABnadDHyJ52Eoy4zlVIZ4Dr3ND5EN98JKJldUri64vkWeo86mu
	Le8vcuthCMh7MibvsDqF0sAilzQPzQpM/6K1LNdLpY0frtTJY3ufq1cUzHieowY3Yy4ai3qN3DY
	7EtBpVSOmzFbxxi7sqGztRFy7IuuDvw/apMc1JtWONH16hUkheSMQkfuXo6iZlIjCSDXidsdG8B
	UD9SZV8zauzjakYU9G/0v08KJkRw7XQ3/6RrE+ox+NRhbdEi6Wg=
X-Google-Smtp-Source: AGHT+IGbpb2C4BoZVgWkMH7mSKy8EpASdLJRRqOzZfJIkWnLm5PxEM26mimNlHgM48JvE9hXUJbpLg==
X-Received: by 2002:a05:6a21:9987:b0:1ee:efa5:6573 with SMTP id adf61e73a8af0-203cbbee8a9mr27678918637.8.1745388174246;
        Tue, 22 Apr 2025 23:02:54 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db1590cb1sm8266560a12.78.2025.04.22.23.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 23:02:53 -0700 (PDT)
Message-ID: <b15906c4-3cd0-481f-8f8b-3dc3e581d817@gmail.com>
Date: Wed, 23 Apr 2025 11:32:47 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] check: Add -q <n> option to support unconditional
 looping.
To: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org
References: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
 <762d80d522724f975df087c1e92cdd202fd18cae.1743670253.git.nirjhar.roy.lists@gmail.com>
 <20250413214858.GA3219283@mit.edu>
 <9619fb07-1d2c-4f23-8a62-3c73ca37bec3@gmail.com>
 <Z_7rqLbQCLAY5zbN@dread.disaster.area>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z_7rqLbQCLAY5zbN@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/16/25 04:58, Dave Chinner wrote:
> On Tue, Apr 15, 2025 at 01:02:49PM +0530, Nirjhar Roy (IBM) wrote:
>> On 4/14/25 03:18, Theodore Ts'o wrote:
>>> On Thu, Apr 03, 2025 at 08:58:19AM +0000, Nirjhar Roy (IBM) wrote:
>>>> This patch adds -q <n> option through which one can run a given test <n>
>>>> times unconditionally. It also prints pass/fail metrics at the end.
>>>>
>>>> The advantage of this over -L <n> and -i/-I <n> is that:
>>>>       a. -L <n> will not re-run a flakey test if the test passes for the first time.
>>>>       b. -I/-i <n> sets up devices during each iteration and hence slower.
>>>> Note -q <n> will override -L <n>.
>>> I'm wondering if we need to keep the current behavior of -I/-i.  The
>>> primary difference between them and how your proposed -q works is that
>>> instead of iterating over the section, your proposed option iterates
>>> over each test.  So for example, if a section contains generic/001 and
>>> generic/002, iterating using -i 3 will do this:
>> Yes, the motivation to introduce -q was to:
>>
>> 1. Make the re-run faster and not re-format the device. -i re-formats the
>> device and hence is slightly slower.
> Why does -i reformat the test device on every run in your setup?
> i.e. if the FSTYP is not changing from iteration to iteration, then
> each iteration should not reformat the test device at all. Unless, of
> course, you have told it to do so via the RECREATE_TEST_DEV env
> variable....

No, it doesn't re-format the test device. It re-formats the scratch 
device. With -q, there will be no re-formatting of the scratch device too.

>
> Hence it seems to me like this is working around some other setup or
> section iteration problem here...
>
>> 2. To unconditionally loop a test - useful for scenarios when a flaky test
>> doesn't fail for the first time (something that -L) does.
> That's what -i does. it will unconditionally loop over the specified
> tests N times regardless of success or failure.
>
> OTOH, -I will abort on first failure. i.e. to enable flakey tests
> to be run until it eventually fails and leave the corpse behind for
> debugging.
>
>> So, are saying that re-formatting a disk on every run, something that -i
>> does, doesn't have much value and can be removed?
> -i does not imply that the test device should be reformatted on
> every loop. If that is happening, that is likely a result of test
> config or environment conditions.
>
> Can you tell us why the test device is getting reformatted on every
> iteration in your setup?

As mentioned above, -i isn't reformatting our test device. It is 
re-formatting scratch device and we introduced -q to unconditionally 
loop without even reformatting the scratch device, and hence making the 
re-runs faster.

--NR

>
>>> generic/001
>>> generic/002
>>> generic/001
>>> generic/002
>>> generic/001
>>> generic/002
>>>
>>> While generic -q 3 would do this instead:
>>>
>>> generic/001
>>> generic/001
>>> generic/001
>>> generic/002
>>> generic/002
>>> generic/002
> There are arguments both for and against the different iteration
> orders. However, if there is no overriding reason to change the
> existing order of test execution, then we should not change the
> order or test execution....
>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


