Return-Path: <linux-ext4+bounces-7110-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BAFA7F45A
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 07:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630CA1897169
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 05:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5FD2153CC;
	Tue,  8 Apr 2025 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZlpIkcJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296673C2F;
	Tue,  8 Apr 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744091126; cv=none; b=G7PM73RwtxAcg8FBFQbMoVgSJNBpWMtWsHWhBIIBDp322aWoGJKh8z/xv3EvQi1I39J0jVHzIy/IUfJUQMt63GLYg07s0Pd1TNE8tJuj8mH1xLUEdicWwMtdTPBuscRFS7xiFPbTo+yAoiXAEgOHWXC6mhH+A7Sl7Df2eI0d0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744091126; c=relaxed/simple;
	bh=lHC5FGT9o6+gcFknOCxXniSijFnfdZ4aJIQynyBc72U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mb4C6Kg67N2WF84JhC+05IGzlnzkKy3MYiLSToOkh/RnZcbqpf8/zMwVmgzuohIiytul/0aPEWErw809Wl9LgFuF5OdWlGggdJEH5NAwUQfU6zbrQ4qIt3IyIVMjWj65GYL02Dt8Qj2SPDiP7sibtpBaqq7OQx3SFGD1T6uNsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZlpIkcJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7340e6f3ce1so3968605b3a.0;
        Mon, 07 Apr 2025 22:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744091124; x=1744695924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLBk5n0ltL8xAxyv+Wj+u9dmKp4IIoRT8qTdS3qbDJA=;
        b=TZlpIkcJzXWu2YkFn3daw59afxhBuqhO3ujm1yktLun4uvj/8lDtNbJxnCGOSxL9nM
         PrK2YelWT4FqZds3ei7L4MGhCKnCm2E8Dn59/VVIfaZrVFuPtH7VdPZe9K3M6rpjnlaY
         pa5+fTMhRY3EMssz63pgmig53LRXfCP3wp6tilzNMyUaSnCJAxvdmRzOf/MPD1qQkdYb
         bTSOsIrUMmxh0wq0uBttSvD+XDpMeTWjmsWIWqYqDyGV3Jo16MUO0uyfAzCFaGjGpGcM
         x9tKdWRdsOecvAFWfwp21KKZjOYTgxZte//u3DO896r7HHs7yERETrASRN7EhwDRdVa+
         Bhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744091124; x=1744695924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLBk5n0ltL8xAxyv+Wj+u9dmKp4IIoRT8qTdS3qbDJA=;
        b=b4zWIXF37P3qw/revC4Q+mPN9khD3LiC1GeNDb8xQGQKapAcM/C+6W6bKmuCxvVlEL
         /pG72bIMztjbmcUL2BQ7XGc6MmZ4X/meI0x1ZRUmiCOkVsA7e3crhbfK0Igfn1JAThTu
         jJKFGS8M+OlxFUwYdp80GFsLODUEjd04CniBlKDN9aYNZmNUafXLIUznuvOpeOYu3hqx
         uaMuzhZpQXfqF35VZTpdQikUDcxTrgmk3Jvinj8kV4XbuHoFcC7hpdp5eBb6Wr6CZXlJ
         BDeMFteXnjhINl4NeT+ISOsWIkAup/SQiBRBhRqovK18JWtsCEX31kfoRrT/ZZ87rUvN
         6dmg==
X-Forwarded-Encrypted: i=1; AJvYcCVsMrZMwAUCPQHyLuzMHJ1NiIPb7LFTEqsHwLhkoLTOsaPuW4rdRUjg2Cv/foBxkJkf1nBoAJ+8bhvt@vger.kernel.org, AJvYcCWiPQnF+VnMKO79EA5W8F9yhiH7cD8CEY7PJIHcv2oypVYOPZ0jPV+DAaBQhQlRVSTlOZbm+sKU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1TF15KAZs7g38OpjxS4TDLAh6AMdgKXkXBUC+7+zgyEU9nhtS
	QwXQ4CQjGVi1w4frt7gexmvLpojEU/jqz+H1GD8ChgT4rUXsGbb7
X-Gm-Gg: ASbGncsN/q7c6Bj7GMlWvApW7HtML3v9d0PO9x8aE5K8Q24Ux/FXLXp2Qsv3MlGjQSx
	OyUS79vrz6NkjriIahtz3XHcfzpl6AOxXopYMUoDFa4Zo+WYc287alEw8iBwTVgfPn9CvBstmZG
	JnLq+S1UlJnLJr9eefe+i8JfELk9dhKmtE4t4GrP+C1GDjmb1RxAuHYqgKXUtFSF/QlKK1Q3NUO
	ICHaOFeUs85eMgWZnnMln2EfNE0k3gwW3rgmiUFDpSGCsp/9cpCFGOlWjqZ/dcqdXj8j37gtr8p
	mXCeBzBTE3lxaFPRRVH1F9d3JdBipzzZtY+RfbSl51KVT8sdCB8heZE=
X-Google-Smtp-Source: AGHT+IE6SxuWI8vXyH1z69PewnGRINL8FTVGsbyZxIlmKpdT+YD7k+O1yokLEw1daBiHU9JWFrsv8g==
X-Received: by 2002:a05:6a00:3906:b0:736:b402:533a with SMTP id d2e1a72fcca58-739e48d58admr19602624b3a.1.1744091124272;
        Mon, 07 Apr 2025 22:45:24 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0deddfsm9638591b3a.162.2025.04.07.22.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 22:45:23 -0700 (PDT)
Message-ID: <aeb7dd52-58a4-49fd-874c-540ae87cbc36@gmail.com>
Date: Tue, 8 Apr 2025 11:15:19 +0530
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

Addressed in 
https://lore.kernel.org/all/fa1bfd04d6b592f4d812a90039c643a02d7e1033.1744090313.git.nirjhar.roy.lists@gmail.com/ 
. Please ignore the previous link. I mistakenly gave the link to patch 2/6.

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


