Return-Path: <linux-ext4+bounces-7109-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16BA7F453
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 07:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E871896FCB
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 05:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40C1216605;
	Tue,  8 Apr 2025 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDlpwHES"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9C2116F0;
	Tue,  8 Apr 2025 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090985; cv=none; b=FvqhRAZbXPhz8PFX9NApotYXX/p2FffOFV6fzXRehQbaBtbbEmp8cgFCb5ZmZzGwTIF6/PXe0aZI7sXMlERXo9dE4HKKmdpDwy+sjJ6onzzNyW7WMaFcvJ8fsn0zgmaecCshjQvgek1/H7pDkQLOCg1kIB2Wv1X3GUJQfXkFYsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090985; c=relaxed/simple;
	bh=IqhbxcZATupq26Lc3hVtcuxJnnq2W7qn84ulYWrvVIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlO5LINa7XKbSCdmMsD4FfKi8h17xbfvIMGmHdphks/M2w9adcgSgs652DZ2ND5scrQugqLuv7XCMm+aTjBCiIUhUS1qPMAR68zHA22b1hrUlpwdQQNYDYwEpiVGobv1JlhMrIPwjQtKIqESWsCySPgvNGEFSr+7DBPPGyCjBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDlpwHES; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224191d92e4so47626315ad.3;
        Mon, 07 Apr 2025 22:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744090983; x=1744695783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iv12n3F9Znu4d7M0q5HyONxHvxoitrAxQPbp7ZL/y80=;
        b=FDlpwHESE9F8WU89DR9TlQX0wJJ9fgWxfrT/MtBjpE95pDmdfzcrKtCxzsQ7DrzTC+
         w4RcKhzXo2BdMoyWjkCZ50uFXSvqloTU8wRkJ/Ay8d/vibVN8gmslRv1sPA+EmJG7iiG
         7yxNE6PSFLcDIeXgI3OKdN4XalmqpluhtDmDWFbIbaMEfFH1o+gA3UPchXLiIoP9WEOY
         5SZo425xcLOo7CC/MVs5DtNH+FXooC2a1FoWy3D1tNkmHMLUkn8vga87ZD1aB+ncFOLA
         Z9t7SUq6ImGsXAOQCm2X+lrxRsEJGyDFUISK67EpHZHdTPxSpecMt2P+81k0xO294dqK
         2NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090983; x=1744695783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv12n3F9Znu4d7M0q5HyONxHvxoitrAxQPbp7ZL/y80=;
        b=pwyqR/eI1Btvy5eIfYpOd3FmTVPN3wNPK5beq32+FCcytvNyfm/R+b9VqEK2m4gXE2
         X+v4HOoWRSbzF/6BKCI1aKRHq8oc/44cx2Jl5Dj6arb0tgieDRAEcwBUOz+d8NhZc3UT
         gYAkhdobHwkSHp3aEJGkhJxa7ZF7q8moBNU0wdu11F37LxJOAX430O8ULfPICNE4FTUk
         6TZQf4MB9qDilYX3/zr/dhzCyRS7hUbuVVa+IY/Qmx3ESNy6LYO2wqtP9wNLBA+d5iC7
         v0SCxsT7nJZN0URPXF4vqxsnjG59vo48mbVwLxmPtP+vupCiDygMa4ghXP7yJ1zizJHB
         RIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlO+u0izNbifSbWe7VzY52JyND9pF7CqpmbR+2ud5OkrlikCb1F+JRWAI+zxdCOb8K/4qu5mwYXvuj@vger.kernel.org, AJvYcCV9VvAc4LcndYppluenV719ASRS59v0BacBa8SesjU4w5Ks1HHa62mKcnimhcYBKkfLeCkFs/+1@vger.kernel.org
X-Gm-Message-State: AOJu0YzZITd4CBynNKry+v4nQ9n5vrtMNlIUM8AdHb/3BZqzoKZRmkOD
	hp0utrEgKyl6+LkQE/V+GkN2FZ73XDHl0UM51dyZVkRc2VpkUm7Z
X-Gm-Gg: ASbGnctxW4Ulq2b5xfnVVvvlk2+Ew1akt/GKH/wIMnmQfQikknzXOIrmHB3kkY0tvb5
	G3hz1rjJSiE3rCl6kHne1+KVlj3plv99bY1KKcXdp3SZV4McFM72+AndTQtaobcvbGsDgW41DAN
	ErWyPot9A/8x+DWNq7bT0obO6vFDflZ/fvUouwZIHiERfcrF4Pa3RwCtrX5r9RImSPDgNJ7cJQK
	8HoqoMcU3vQG9dN0mCti29JHcSuAGm8+J3Bfu8Boq2bdXQeno+idhkIxqcB7qX4QifJVhMiG+K7
	Hg8N9S4+wUj3I6SyQQFf4koUGyFSQCJYWktyY4ajxRaydk+NdMVuViE=
X-Google-Smtp-Source: AGHT+IGR2xlRV/28n/ntkVhaewfIG+IuUPgiScgLih+ElQX2SKuVm0nmnezoPm5qzTDdCgpAqDD6tw==
X-Received: by 2002:a17:902:ce06:b0:223:4b8d:32f1 with SMTP id d9443c01a7336-22a8a045b80mr214079335ad.1.1744090983230;
        Mon, 07 Apr 2025 22:43:03 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c0180sm91048825ad.76.2025.04.07.22.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 22:43:02 -0700 (PDT)
Message-ID: <fbe22939-f1bf-40bd-8ed1-d818167479d3@gmail.com>
Date: Tue, 8 Apr 2025 11:12:58 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] check,common{rc,preamble}: Decouple init_rc() call
 from sourcing common/rc
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 david@fromorbit.com
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <ad86fdf39bfac1862960fb159bb2757e100db898.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87r028vamn.fsf@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <87r028vamn.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/4/25 09:30, Ritesh Harjani (IBM) wrote:
> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>
>> Silently executing scripts during sourcing common/rc isn't good practice
>> and also causes unnecessary script execution. Decouple init_rc() call
>> and call init_rc() explicitly where required.
> This patch looks good to me. Please feel free to add:
>       Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>
> While reviewing this patch, I also noticed couple of related cleanups
> which you might be interested in:
>
> 1. common/rc sources common/config which executes a function
> _canonicalize_devices()
>
> 2. tests/generic/367 sources common/config which is not really
> required since _begin_fstests() will anyways source common/rc and
> common/config will get sourced automatically.

Addressed 2 in [v3].

[v3] 
https://lore.kernel.org/all/ffefbe485f71206dd2a0a27256d1101d2b0c7a64.1744090313.git.nirjhar.roy.lists@gmail.com/

Thanks.

--NR

>
> -ritesh
>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   check           | 2 ++
>>   common/preamble | 1 +
>>   common/rc       | 2 --
>>   3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/check b/check
>> index 16bf1586..2d2c82ac 100755
>> --- a/check
>> +++ b/check
>> @@ -364,6 +364,8 @@ if ! . ./common/rc; then
>>   	exit 1
>>   fi
>>   
>> +init_rc
>> +
>>   # If the test config specified a soak test duration, see if there are any
>>   # unit suffixes that need converting to an integer seconds count.
>>   if [ -n "$SOAK_DURATION" ]; then
>> diff --git a/common/preamble b/common/preamble
>> index 0c9ee2e0..c92e55bb 100644
>> --- a/common/preamble
>> +++ b/common/preamble
>> @@ -50,6 +50,7 @@ _begin_fstest()
>>   	_register_cleanup _cleanup
>>   
>>   	. ./common/rc
>> +	init_rc
>>   
>>   	# remove previous $seqres.full before test
>>   	rm -f $seqres.full $seqres.hints
>> diff --git a/common/rc b/common/rc
>> index 16d627e1..038c22f6 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -5817,8 +5817,6 @@ _require_program() {
>>   	_have_program "$1" || _notrun "$tag required"
>>   }
>>   
>> -init_rc
>> -
>>   ################################################################################
>>   # make sure this script returns success
>>   /bin/true
>> -- 
>> 2.34.1

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


