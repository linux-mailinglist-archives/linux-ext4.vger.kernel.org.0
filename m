Return-Path: <linux-ext4+bounces-1734-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCCF886F07
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 15:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C61C224B5
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25850482DF;
	Fri, 22 Mar 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8ZPa+5o"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224274CE04;
	Fri, 22 Mar 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118997; cv=none; b=og0B0H/t554V+60lhWNTFywXSXeCrASrVY4XmeVHRgy/KD0nYgz24PiLnUwcQHLKWAcJSvZdx3kjLHEEjQU4t359g9r+FKoZ0bg69DZk5KbpBjm/Lnyhtsd4qigB5KqAE6V8zq79RiBqWl64CSNFvQdI20z45QYfQYf2wroTaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118997; c=relaxed/simple;
	bh=btyZ19KdM+48oDEVIASBYnaqJtcVpw+NiGTy/iKxkUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btJ5mcfC3E8VfZdJyUiwZ+707Xt38AaLZiFgKkpPc045c4Cm4GDtGfmXJJQ2rQP+De3pxjbPR+Y7JT2gm2EgiQMfArXfu33alFjYz1BzjOa5JEBwFuT1aZ4M2KWfn6fH8yp4IWd4CG8AKq9x5tS29YSGjlnZJVko18/ymbGsOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8ZPa+5o; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so1737573b3a.0;
        Fri, 22 Mar 2024 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118995; x=1711723795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q0pmr7UwjSN4H6aYmT6nyHQTXMXU/eulJ89qPTjQjw=;
        b=L8ZPa+5oN/Wxqbk3uRKbiCNye9hYCgxvYhJUhj9QdI6PpwUXbwnTiK36MJF+9eRi3O
         ey5CnmDzUQeBM4n9xXOMeEY/hE5O95DJjSEchzZyNBzmgZ/em3psOB7dlSfmayjVM2g0
         95dW4c1tNtdoTN0nWjTL4d8DVxd03/Zv0Bjw5Gpx33EypUTL47yYcTxIPwWX7SM6XXyF
         osQRmK9gf3Ctx4C49SMvZLnnsghkrgMfZBu3rcd6uuivae/U1IK7ULco9VIxroOBYaIF
         N0eGMQMkxAmZ/IJpWMZc+Vs17NtCV7KvRsxdvnpY9LCmV2fMdDr6da5V+npTodVfWkPO
         rVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118995; x=1711723795;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Q0pmr7UwjSN4H6aYmT6nyHQTXMXU/eulJ89qPTjQjw=;
        b=Mw30XujhOAxbwuSCE9TwQ+COc2nQWoeNV1nv0LjHXMl762lUx6RORkbptnh+4r/2s+
         3qxTeSXkgr+ApdBxmADny4K0DmrFNehwYjYveTtq1FOGlffeOywbHMs6OiUQzzjBbP7x
         6vcC02kpI58BUM6u8++/3Zak5Nd9Qi4TwlaEPAHQwA7LTHBIKe8LmGKiSHJVeWtPH+MZ
         0QFA9PplLBTJvhQjPLPGIxX2fc6H8LkCoEg6QZC4Cba2bYTfn98XMbIegdkhC5ZN3FSh
         nhm0G3Gx/5blzVG3e/DDmRXf9PcwQTld0agAyemRFEAaRrgab6clLNPMhAFQ7LX76u9o
         gD9A==
X-Forwarded-Encrypted: i=1; AJvYcCWOiXz1/WRQQT+I5ORSe8HeTbg9ge3d9KfwPM3eVOb4iOJseZzlnaBUHd59x7brpx3/tzpyeyFpieAy3naY/het14EwWxNASjZNSS1Lm9SM5bBBxcmjMSURB3miTHaJP+ws1q1DegB/RA==
X-Gm-Message-State: AOJu0Yx6DA26IxphNZ9yMTJMldPUT3alC9hW4/GGrWA/db/cs5FCPjQ8
	79B1LRlKt37qr4dTjKcXQj7qUajC18HXnNt64xnng8gw8du9e6no
X-Google-Smtp-Source: AGHT+IEZpvJH4HC9c3qma1VGNkuMkVpNUpjGXQ1Tk94J3zVtpViwAEnMn0QUg9MpAfG6rjM6Z0svcg==
X-Received: by 2002:a17:903:487:b0:1de:faa5:552 with SMTP id jj7-20020a170903048700b001defaa50552mr2734549plb.56.1711118995281;
        Fri, 22 Mar 2024 07:49:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c12-20020a170903234c00b001dda336de37sm1994339plh.240.2024.03.22.07.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 07:49:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d9cf3b5c-e6f1-4bb8-897a-b555ffe3bc94@roeck-us.net>
Date: Fri, 22 Mar 2024 07:49:53 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ext4: Add unit test of ext4_mb_generate_buddy
Content-Language: en-US
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240103104900.464789-1-shikemeng@huaweicloud.com>
 <20240103104900.464789-3-shikemeng@huaweicloud.com>
 <30a8ce01-84d1-48ef-a93d-d14cc61723e3@roeck-us.net>
 <6e062fdd-c2b8-d28f-2b0c-a130855d65ce@huaweicloud.com>
 <03b1cc3d-de26-e473-68c6-8c904472095e@huaweicloud.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <03b1cc3d-de26-e473-68c6-8c904472095e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 02:27, Kemeng Shi wrote:
> 
> 
> on 3/21/2024 3:16 PM, Kemeng Shi wrote:
>>
>>
>> on 3/21/2024 12:23 AM, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Wed, Jan 03, 2024 at 06:48:57PM +0800, Kemeng Shi wrote:
>>>> Add unit test of ext4_mb_generate_buddy
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>
>>> With this and other new ext4 tests test in the tree, I see a variety
>>> of backtraces in the upstream kernel if debug options are enabled.
>>> An example is
>>>
>>> [    6.821447]         KTAP version 1
>>> [    6.821769]         # Subtest: test_mb_generate_buddy
>>> [    6.824787] =============================================================================
>>> [    6.825568] BUG inode_cache (Tainted: G                 N): Padding overwritten. 0xfffff80006223f68-0xfffff80006223f6f @offset=16232
>>> ...
>>> [    6.894341] ok 7 ext4_inode_test
>>> [    6.895411] =============================================================================
>>> [    6.895777] BUG inode_cache (Tainted: G    B            N): Padding overwritten. 0xfffff80006223f68-0xfffff80006223f6f @offset=16232
>>>
>>> Another example, from another test run, is
>>>
>>> [    3.938551]         # Subtest: test_new_blocks_simple
>>> [    3.947171]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>>> [    3.952988]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>>> [    3.958403]         ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>>> [    3.958890] =============================================================================
>>> [    3.959159] BUG inode_cache (Tainted: G                 N): Padding overwritten. 0xffff8de881adbf68-0xffff8de881adbf6f @offset=16232
>>>
>>> Another one:
>>>
>>> [   18.730473]         # Subtest: test_new_blocks_simple
>>> [   18.760547]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>>> [   18.778477] ==================================================================
>>> [   18.778950] BUG: KFENCE: out-of-bounds write in ext4_mb_init+0x5d7/0xa60
>>>
>>> This is just a sample, taken from a quick look at test results.
>>>
>>> Are those backtraces expected ? If so, would it be possible to execute the
>>> tests without generating such backtraces ? The backtraces, if intentional,
>>> hide real problems in the noise.
>> Thanks for the report. The backtrace is not expected, I will look into this. Thansk!
>>>
> Hi Guenter, I could not reproduce this in my local vm. From the reported backtraces, it's
> likely there is a out-of-bounds write to sbi->s_buddy_cache. I try to fix this in [1] and
> it works fine in my local vm. I wish this work for you to elimate the reported nosie.
> Look forward to your reply, Thanks.
> 

You would need to have CONFIG_SLUB_DEBUG=y, CONFIG_SLUB_DEBUG_ON=y, and CONFIG_KFENCE=y
to see the problems.

Guenter


