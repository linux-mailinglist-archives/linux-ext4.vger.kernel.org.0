Return-Path: <linux-ext4+bounces-9174-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED78B0FFE1
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 07:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491A69624AF
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 05:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6351F4C83;
	Thu, 24 Jul 2025 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f912kp1E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C612A1BB;
	Thu, 24 Jul 2025 05:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334432; cv=none; b=c8gl2z4LJL3le6/oH5UUtWj636Kkwlnxp8jMUQoOtMS3Wep7tAnykjNepS6F8kFhtCSPI6PdMuL1lMO2VdjBu+9IZnDzM4E7GyD3pym6AsuqcOYvxIsZc3HaGuWNpRkDUzD5TzAAjMXTfqaVcIexIdZmkA7wItE/HC4/jv70gvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334432; c=relaxed/simple;
	bh=LXUrEwGZi8cibUjPaCZYx9yVkzPJ0WzT0GTvKSQ+eXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oz8b6PgptSb8KfjOt9HOd/hT28S0PSAl2YGdvIuxJuWZRmj9V/1W4vAKWRJ5wyg9tZGzfl0ywlIjlzydHfBjg8AOhNc8qzgBD2vYrLyodr8Y82eRk9kAwSnwdH0R71C9RVDyDy7BpQvc3jDMuoGvBmkG11No//+YhtoPKRmmCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f912kp1E; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b1fd59851baso490332a12.0;
        Wed, 23 Jul 2025 22:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753334430; x=1753939230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cXgtKJT+tmq8GcfRhAaZNZ2mwAUdJ3iQ9bv2ueMLaJA=;
        b=f912kp1EOdKUUGh9Nr9R+C59SArBS/16J7WIUA4MRCoR6u9/BOsNfiZFvT3avQvfJc
         85FiPrsrsPoVhMZ/EibXbAJQ4eqYRl1H7NMdY9+NRlssY65muTkuuz9VguiJ01KRcDSb
         STJ5csiBIQnQ/RhxtzePzptMoVtQGMXTeexnEraphlwPe1iiUyMtlXX0fgXUkrghARy+
         STwXbsXcxhKRFfYB4ArBtNEvh/roWvnYQq690xCH/+/6Cjm3IS07fyLzJ39mqjTYhHCI
         nUf69tCSOeDCPgJ/vNk6iTzZbXgdleKzwaU4PAiixzuEDDH9/HyF9CVtm/v1YnZ9O7O7
         vhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753334430; x=1753939230;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXgtKJT+tmq8GcfRhAaZNZ2mwAUdJ3iQ9bv2ueMLaJA=;
        b=UAZ+JP0ENMfN4DIFE4RS5hvy7xsdeZKTVdTME0M6dXpGSHvgpZ6DIWOKpDjgJynWgS
         OXW4/36Za7nCm8RHtWKCuS3OaV93ll+EVghuZYfXbYrrcMwu3EYTS/BHJbnENwr/+MpN
         LaJv/r2MJOYA0N17+c2LG08pIMWZWutifMXMjETn4D1SpVn7C+boHxVp3HqbVYfAZ5K7
         /2pCAcdjlGSPLhEIIoskjddz3tiVFnky0Ch/5l+KHtiyJTZlsieaXxdinJS0W1bgakYb
         xAz1KaH92TASbbIbf7jsbRDiGaWsLSXrR59ZLQvGbyFBC6HIhXNOp9f25015uDnqT/Hb
         bSDg==
X-Forwarded-Encrypted: i=1; AJvYcCUEKrk3IEZJoDGSOJFrk60RwIlyUNf8xyBlAtj4JtKghxS+ATNzS6ScIoCVQNyDzbuFrYTZgDL1b27dWBFU@vger.kernel.org, AJvYcCVdqVtewEU2IvdSk4FXHuoopJrrnRKkeqGBTX55HfLfrpMnhE9n+z6qh7G0bLf6Rho0QgBD65QXmbVa@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvLRfndDdjl9UJiW3ziJhts/6cG+c8cXzRwZY12Hx/FxKPG2g
	U+k1VZgr5gc2DBOQ7pDb00BcdA9CFm8m5b7QFnH5wTym8jnG3drXNzL5
X-Gm-Gg: ASbGncuKdCnzg+3Xs3cFkyYh+xQWFwyMVPhaQ9pFcYh+o0VbkjBDq3hO+s4k69r/P+u
	mrGsGSGS+Yt91eEKaFHAw92qfpod4c9txeNc8/qUiW7snA7zDBv8MzXXUhDjAzrz2RamrTLApVm
	LGRTRL69VO0WqznISziCyzHcLxLclBFucJ0G53iG3JfAvN2XedhnQ+SXxoFPBBrpk09NJ5vXtLT
	EXHiARpkwTJGEEoJS06Lr3K0n+h2bhI2Uvik4sI64dCBnBu7czb+wfzwl+r+odm9iR1sfNoul5h
	2yonDNWF3hmQUASU0F1WENQBMnhPUbw5Nd+cRd0gfdGcb5020HNAtpc5QT1qObCUYvEwTY3ZlhO
	d/PD3VBHjqYeHVYAgnh/MisCyXDZJWIJ7zkvTCBw8t/rhd1AMH68F/UajJ9bsT4C/QBYMD0g=
X-Google-Smtp-Source: AGHT+IHQ3NIz2O0VojdWDl0gsecBm+SG5+yRhsEh8szmejSjDnzdLH+xnbx8a7HtHXVhPMYlSII7fQ==
X-Received: by 2002:a17:903:1b2d:b0:22f:b6d6:2737 with SMTP id d9443c01a7336-23f981640b5mr90814565ad.10.1753334429520;
        Wed, 23 Jul 2025 22:20:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa47601e5sm6045405ad.14.2025.07.23.22.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 22:20:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3710fdbf-9f3b-45d7-8de0-1a3351a58f63@roeck-us.net>
Date: Wed, 23 Jul 2025 22:20:27 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
To: Theodore Ts'o <tytso@mit.edu>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
 adilger.kernel@dilger.ca, jack@suse.cz, linux-kernel@vger.kernel.org,
 ojaswin@linux.ibm.com, julia.lawall@inria.fr, yi.zhang@huawei.com,
 yangerkun@huawei.com, libaokun@huaweicloud.com
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>
 <20250724045456.GA80823@mit.edu>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250724045456.GA80823@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 21:54, Theodore Ts'o wrote:
> On Wed, Jul 23, 2025 at 08:55:14PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Jul 14, 2025 at 09:03:25PM +0800, Baokun Li wrote:
>>> While traversing the list, holding a spin_lock prevents load_buddy, making
>>> direct use of ext4_try_lock_group impossible. This can lead to a bouncing
>>> scenario where spin_is_locked(grp_A) succeeds, but ext4_try_lock_group()
>>> fails, forcing the list traversal to repeatedly restart from grp_A.
>>>
>>
>> This patch causes crashes for pretty much every architecture when
>> running unit tests as part of booting.
> 
> I'm assuming that you're using a randconfig that happened to enable
> CONFIG_EXT4_KUNIT_TESTS=y.
> 

I enable as many kunit tests as possible, including CONFIG_EXT4_KUNIT_TESTS=y,
on top of various defconfigs. That results in:
	total: 637 pass: 59 fail: 578
with my qemu boot tests, which in a way is quite impressive ;-).

Guenter


