Return-Path: <linux-ext4+bounces-7567-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011AAA42F4
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 08:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9394E20F4
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 06:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39931E5202;
	Wed, 30 Apr 2025 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs5ivuH1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270662DC77C;
	Wed, 30 Apr 2025 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745993623; cv=none; b=O7i4fTUywal4rjuPjE+MtQ3fgw0SZw4tj6veC1zvJk7f1AD7AQKXM0cTSrgcmOgIVITo2bveg91/3NXaMm9+gOVSlyx24EstE2SOokfbi8Rayem0zeDs8kiaQjw7YUjnijch6cta+CBBPMT5Hr4efg7hnkNGJrdAnOxezF2BNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745993623; c=relaxed/simple;
	bh=1cvfPZmaofIQtDWQteC/BCGBIrt3YANFDldfcr6KYS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpEobRUvY7x+aRAviGkyRMpWTHxryNF05JMsV0zt41Ac6/pbc5y42u4UyLSxIkxfdcwMmSaa8Njt6jxFdwp06EcXhfNT6PVq1TxvlOxtCn2YyaLebDc8J0m+v0EwaBrqY5PJ2duFwxsxHYAb3wapOSjZ8779Gf5LT8ZyF2/pDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs5ivuH1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-309d2e8c20cso8461847a91.0;
        Tue, 29 Apr 2025 23:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745993620; x=1746598420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hN5Yl40p5AFESlKpuouLWhq21mbi2YN00wrmIyLyfIs=;
        b=fs5ivuH1MF841Y9BOWzNj/7tx9APP4xr297c0IzvHqgem3+oRl7irflw+SR1YoqMaf
         Ja63BQjXTkvNkxH8OjC3iDgy/3USf116dpGRkbji4/b3gXQBXuGux6ui61Zssa8Glr7d
         FkQo3v4f2Uo44DFk4RLGXvPIeJ/8WQrVehBJi0tSHPiUhWsCBfYpE7oFYghGEPjkr85O
         3z7ibZtmFaZ20O/BvYcuicUIRFNQc2KOTHe8SQPYoX3Ku3ecM98ImggZGNFnz7h8einS
         6W1naN8iyvktPWZ+Ysc3jM4mCx/A7T1bXOOChgiLCEL6q0svOgeuf5rEGRTiGL3iQVdZ
         dViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745993620; x=1746598420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hN5Yl40p5AFESlKpuouLWhq21mbi2YN00wrmIyLyfIs=;
        b=BnlslKoSy8LL+JF4g1iiwsTDF1flF3bzezUtLsBldXAdj9worZisHneasByWbfB2r8
         kujwavphQpI/4nGVGz8DLl0835H+BVpcRX6H86/zoIK7R8KAAR3OLyVxDgILg3Eez6Vo
         Zd68K+5JWl2PuRx4KX2Q31LVne8CdVqHGNP0LLXl2q9YAFS4Q40xuvUFTNDoti7jzVRS
         5zjyO7cF/02Gg3ZDMZyfnGfK/XYZIiWCrFqyzX0d5LTI28KqsTWj3LEgH1f0Kh7Py+GV
         hOEsXc7YvihDDCornp3RV0XmdUsMEOSTkERWIg28qYXmgyWdhcNCgVL3gpZmYFBmfRTl
         MpQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUouQn1pdQXQrgafr8Njp5+WFfUQwUQp+x/FkpYMwjoQ0eayPFgs8Bu5AUsCXCRcGcfWwDX6Gj16bmR@vger.kernel.org, AJvYcCX1sI/dD+OUVu++sfvqtg7fqtVPZRqH1+Bjnqa2Z7uZ5sMi+whnJBRGNWpG9UAqTTEmGqp6drR6k7sc@vger.kernel.org
X-Gm-Message-State: AOJu0YzYouzAxLdn0LCJFiUkAEanLTvh7r97TNizFco9pGxFrZBwNZmm
	k3q7Juwfbeey8IZupqGzVVkRG/uRahVsFUq5uLw6LjejLRY/WNCT09HGlg==
X-Gm-Gg: ASbGncvIGsqkcs9YCpff0TCwWPojpJD7a+pV+I5A82jvbj/ns5iaI8vEtlG/UWQxor9
	4VXCqoOpTHK1NPLOR9hC1intPXfqCmLaOecRRYnRuK/D71+T2h4wqP8EWbdBjb/Nzw/yUF+Zq8t
	WngZSbxoECX4mik93sDa72EOnAjDU2BAQSVx1OrQdvlE4Zk1ne2uipBl0mrU0ks25CQ00nnRmKB
	C23Jm3pPQGEi6yCOuzDMRAxiwhYrIWrvGdZ3ny2emRJdCRKYLJdddL8eHonyojrLmCI1e0rE4xn
	vwinWKxoR0P5LJo0dcWQf9hmdh6h0F1o+6jM7IVGaSniAjkKDew=
X-Google-Smtp-Source: AGHT+IGNSmEikfSfw03qCayvFDR16u+jZPOpeh07SGPQv6P8EOvJ9e0WNSWVvx0DT3bQz5+ZyFT/VA==
X-Received: by 2002:a17:90b:2c8d:b0:2ea:7cd5:4ad6 with SMTP id 98e67ed59e1d1-30a333648bdmr2252935a91.32.1745993620215;
        Tue, 29 Apr 2025 23:13:40 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34a1f13fsm697489a91.30.2025.04.29.23.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 23:13:39 -0700 (PDT)
Message-ID: <46355124-c8a1-49ee-84fa-883774a11a03@gmail.com>
Date: Wed, 30 Apr 2025 11:43:35 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] common: Move exit related functions to a
 common/exit
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <cover.1745908976.git.nirjhar.roy.lists@gmail.com>
 <a2e20e1d74360a76fd2a1ef553cac6094897bff2.1745908976.git.nirjhar.roy.lists@gmail.com>
 <aBFl-eKBBwG-QxCm@dread.disaster.area>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aBFl-eKBBwG-QxCm@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/30/25 05:21, Dave Chinner wrote:
> On Tue, Apr 29, 2025 at 06:52:53AM +0000, Nirjhar Roy (IBM) wrote:
>> Introduce a new file common/exit that will contain all the exit
>> related functions. This will remove the dependencies these functions
>> have on other non-related helper files and they can be indepedently
>> sourced. This was suggested by Dave Chinner[1].
>>
>> [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
>> Suggested-by: Dave Chinner <david@fromorbit.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   common/config   | 17 +----------------
>>   common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   common/preamble |  1 +
>>   common/punch    |  5 -----
>>   common/rc       | 28 ---------------------------
>>   5 files changed, 52 insertions(+), 49 deletions(-)
>>   create mode 100644 common/exit
> Neither of my replys to v1 made it to the list [1], so I'll have to
> repeat what I said here.

I am really sorry. I didn't get any of your feedback in [v1]. I will 
address them here.

[v1] 
https://lore.kernel.org/all/cover.1745390030.git.nirjhar.roy.lists@gmail.com/

>
> I did point out that I had already sent this out here:
>
> https://lore.kernel.org/fstests/20250417031208.1852171-4-david@fromorbit.com/
>
> but now this version is mostly the same (except for things noted
> below) so I'm good with this.
>
>> diff --git a/common/config b/common/config
>> index eada3971..6a60d144 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -38,7 +38,7 @@
>>   # - this script shouldn't make any assertions about filesystem
>>   #   validity or mountedness.
>>   #
>> -
>> +. common/exit
>>   . common/test_names
> This isn't needed. Include it in check and other high level scripts
> (which need to include this, anyway) before including common/config.
Yeah, right.
>
>> diff --git a/common/exit b/common/exit
>> new file mode 100644
>> index 00000000..ad7e7498
>> --- /dev/null
>> +++ b/common/exit
>> @@ -0,0 +1,50 @@
>> +##/bin/bash
>> +
>> +# This functions sets the exit code to status and then exits. Don't use
>> +# exit directly, as it might not set the value of "$status" correctly, which is
>> +# used as an exit code in the trap handler routine set up by the check script.
>> +_exit()
>> +{
>> +	test -n "$1" && status="$1"
>> +	exit "$status"
>> +}
>> +
>> +_fatal()
>> +{
>> +    echo "$*"
>> +    _exit 1
>> +}
>> +
>> +_die()
>> +{
>> +        echo $@
>> +        _exit 1
>> +}
> This should be removed and replaced with _fatal
Okay.
>
>> +die_now()
>> +{
>> +	_exit 1
>> +}
> And this should be removed as well.
>
> i.e. These two functions are only used by common/punch, so change
> them to use _fatal and _exit rather than duplicating the wrappers.
Okay.
>
>> diff --git a/common/preamble b/common/preamble
>> index ba029a34..9b6b4b26 100644
>> --- a/common/preamble
>> +++ b/common/preamble
>> @@ -33,6 +33,7 @@ _register_cleanup()
>>   # explicitly as a member of the 'all' group.
>>   _begin_fstest()
>>   {
>> +	. common/exit
>>   	if [ -n "$seq" ]; then
>>   		echo "_begin_fstest can only be called once!"
>>   		_exit 1
> Please leave a blank line between includes and unrelated code.

Sure.

--NR

>
> -Dave.
>
> [1] Thanks Google, for removing mail auth methods without any
> warning and not reporting permanent delivery failure on attempts
> to send mail an unsupported auth method.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


