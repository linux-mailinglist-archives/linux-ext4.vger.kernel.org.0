Return-Path: <linux-ext4+bounces-7108-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE66A7F44B
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 07:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0C717CB2E
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 05:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16F921506E;
	Tue,  8 Apr 2025 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKz7ElQL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D61D5144;
	Tue,  8 Apr 2025 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090884; cv=none; b=mH2+Ezjk9Nan9ryCdHEjXH+XjXO/z6vsLpj9lwbSldv+rB6s+AB8qunMVtwhLUaP37nwRJ2dFr1k7suesx5aP2DdvhpbOyfM5SV9Ko/5cxzGPUIgYDsiM3KIvl394TUNKEMxX4yCcxF23oofu+LjWSvkrVGIGLpdMIGafh8IB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090884; c=relaxed/simple;
	bh=RNPbe9sK5OefkB2GhBRw7Q6Y9Hp7pvWeEnbBu1154FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoTfjFz+hhGapYsPGmp91wEb/0QTJvEYzc6RiOp965e1Io11e029CykIyUTsa5ZWhWYpx8AnBNDi1esOuAGXbL5DH4EbSntYM0R9fq5Mk52HmsA8GrpugqePwAlnhcdG0E7ghPjm7tg1hZ5ESMuB5ycE5Jj3qkHExXkTh5zjKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKz7ElQL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736a72220edso5247221b3a.3;
        Mon, 07 Apr 2025 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744090882; x=1744695682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWs86YRo+cVYQgXljkBHojnscWfLXLHK+sR/OXARPiI=;
        b=YKz7ElQLbINCYNKGTal3bdZd84ADweh3rM/UbfSpYm8PmvLvg6vV7EuybBejWC5F3E
         jUFH8BRBl7s4Y5/SbMF3HYgCH+4M4u7ssxxoWq3iUodYP5ME6Tpb2fiJMEllNs395jQk
         5sLrPiOpq+eHaeIzGwEb92ATZETnvnrVGdAV5W9x1BhkZAzaWAPnKB+bidgW9nQ00oV2
         Wu2u6TahEyhQGHx0aY1fj8E7hLX96+aH3JcyM3YbviNSR/VAjmcxXWRG+fgrKL2GFS9E
         2RE65riGkQdRU6jpTyCf+tQJIKg5YsG3H8AFgr8ywYHWDJw/aWTze6VAzLxr/PP6DmlX
         zcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090882; x=1744695682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWs86YRo+cVYQgXljkBHojnscWfLXLHK+sR/OXARPiI=;
        b=tpIKP1WaXAkOTZs4JoMl35zh+9JoJUsBDFw1IFeQc4Xt9lxoHXLdzWKxMznsvtPGmL
         ybF8sheZqPq8ZRxsVzkM2m3PSDeYjqjm97oPDiEfHrMbKKG3nvE/8vbx4xt0iBY6ylk0
         wrCGh2oV/d7AQVvJzDExtu7FyAi2GEhjnhqnvpQwa+rtVr6lOFhNbRgg2wL/PlJJrX6F
         FGihH9aPMkfLLj0eDOWHkiEPClCcjGpEuozZ2Ye9Ay16FwQuAZ5D0ipk4MKWGFzLJqfO
         4wNpqSJSP1BrUb5brwr42eLkgMUkMjJ1QB+M5lyW4plApB7heXw3F6vIwitlPo3U11qU
         NymQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBtRuGW6wWy2YMhAFmW07L7HxCAgH/rMU61mHQol81lOdtOZ1gaeX+uOA9QW5bsf8nHoWLRYcaJX10@vger.kernel.org, AJvYcCVJ46Z4tN1Wbo0kFS0yCsVQlCIB557JNz7z1TJcspe9Y4g1bBdN5P+syi8u6pwM4URhWaYFJEBw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3V63Sp/19uGGf/0lPgztZlBhgI/uZuy42RCc++aV9VOGrzT13
	Etv1X/S2YK8vFJy9yfurwf8NxpRsgRf1ZAOpKPR08KqFFNQS+iCGX6zgiQ==
X-Gm-Gg: ASbGncvYzB/EwLCJaB0FKLdtOk1DNCkLFnHfS5s/pRuLffbP3IsmeaqCR+6ZGJoUJam
	XwwPgmL8Fp9bLgK9yo1k4HsK5At2iqbM02LnFF+1EdLs6keZAgUXUX5UaLkKDrfp5vifw9kSYqU
	6Y3JORGfYnHXgZfQPXAbNP0tVrRGkeGW97vO7+I9BgbykRsQ1w+ahtW+CUFPJ1tVi4oCwVuveix
	I9qzOOxX70P9tDPfgUipgdwEhHUs9NiYjEXdK2K7V/Wgq44T/3ssA0aX+v4EyELpsNV/MVShA5d
	Wv1cNai5znAyoePXPzeGOQQWVp07U/8M9CnLi8EqQmKNMTiG5EVdxdU=
X-Google-Smtp-Source: AGHT+IF65DIa0kLB1x7KJhroOuRvIwDP4/l5EzKZLCaQ6jzC02pq6nKFhtIftmPWO2b2x9IILksNOA==
X-Received: by 2002:a05:6a21:9102:b0:1ee:efa5:6573 with SMTP id adf61e73a8af0-20113c0947fmr16844287637.8.1744090882152;
        Mon, 07 Apr 2025 22:41:22 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc34fc97sm8252141a12.42.2025.04.07.22.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 22:41:21 -0700 (PDT)
Message-ID: <e48b457e-115b-45fb-87ac-0dc6ad4eebe9@gmail.com>
Date: Tue, 8 Apr 2025 11:11:17 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] check: Remove redundant _test_mount in check
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 david@fromorbit.com
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <6a8a7c590e9631c0bc6499e9d2986a6d638c582a.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87semovbrk.fsf@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <87semovbrk.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/4/25 09:06, Ritesh Harjani (IBM) wrote:
> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>
>> init_rc already does a _test_mount. Hence removing the additional
>> _test_mount call when OLD_TEST_FS_MOUNT_OPTS != TEST_FS_MOUNT_OPTS.
>>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   check | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/check b/check
>> index 32890470..16bf1586 100755
>> --- a/check
>> +++ b/check
>> @@ -792,12 +792,6 @@ function run_section()
>>   		_prepare_test_list
>>   	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>   		_test_unmount 2> /dev/null
> Would have been nicer if there was a small comment here like:
>
>    	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>          # Unmount TEST_DEV to apply the updated mount options.
>          # It will be mounted again by init_rc(), called shortly after.
>          _test_unmount 2> /dev/null
>      fi
>
>      init_rc
>
> But either ways, no strong preference for adding comments here.

Added in [v3]

[v3] 
https://lore.kernel.org/all/ffefbe485f71206dd2a0a27256d1101d2b0c7a64.1744090313.git.nirjhar.roy.lists@gmail.com/

Thank you for pointing out.

--NR

>
> Feel free to add -
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>
>> -		if ! _test_mount
>> -		then
>> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>> -			status=1
>> -			exit
>> -		fi
>>   	fi
>>   
>>   	init_rc
>> -- 
>> 2.34.1

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


