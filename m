Return-Path: <linux-ext4+bounces-7164-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DDEA81DE9
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 09:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006AB1BA260F
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 07:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBF8241122;
	Wed,  9 Apr 2025 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAwIUIxr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA072356AF;
	Wed,  9 Apr 2025 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182432; cv=none; b=sACsPdlLZwCLGpOH/ezRXFfFOT8NSDjnCP1xO0OXIDViDugTFpgzZCjvlYDHAYXW0QPwAQRibWbS76V7/VjUqJThfmvUc4+9s0B+kTrjj7pnmXYitIho+GaUn6QoTKsxE6k6YWcuBklH55L9WvBcTIGbqbRWsgba9LTXCn1IP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182432; c=relaxed/simple;
	bh=9F2B1FKM4o2kYJPf4nCGipUmzvhwdKVBsdYZuETfcjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTOQJ/xmtox+jIfOWJjobm8IixtrAXlgHshTErbl32IJxQy/py7qSWq8OJ0UA6nJbYaddGBXlLW8KMjR6E0f8SQ1oXy048afbBMhL0y0UOxc3go6T8qLpvmA3jz5NbZvwDpsH8HNqgB5Zb7KPpwJhEG63lprMtxR0f+Y0fENXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAwIUIxr; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af55e518773so4056568a12.1;
        Wed, 09 Apr 2025 00:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744182431; x=1744787231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eK1qdCjwktWCG21S3nV6hABOL2iPyiSWy5bzuvPT5Rg=;
        b=gAwIUIxrn1EN0CRUShFtqkUOp8/plBmv/hcBnuRHIPqnE5efmrKBs5AK5CD+0SqFv2
         NqjErV/EUhLAdg/GNDvnEzGbNCJc1GRrI5nAtURyxRqTrCQ3yV0lAtrZfIUs8+aRdx3a
         QlEzG8thZExgFa/Zeqq3ySw8k/j7kM8Iku6RR65Z3ZtJkLXkh59yLWhcb5eQAwRL6Iqi
         I4HGUqFAoqMAlpcH+x6RQKQ9J5uYUMGrv+JBBAzO5XVz6e/iyOU/hdeZIsRf1iv+ihGv
         aZ6b27+wONufzNRHoXfPj35S5sucUknIxnQwLRfV/jdn9HrZ0mtiJtmyoAz4EPgs/u6L
         hIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182431; x=1744787231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eK1qdCjwktWCG21S3nV6hABOL2iPyiSWy5bzuvPT5Rg=;
        b=GBYiHgzGP8DSS2p9O9tj3drlV9BjKHDA8w1Jeo+eDaU0KFYn1mJnMGIvhmUlHLELn+
         bUwouNyk8HQS7hiWnEpFONLHHJS+OiMHBYpLT23pf99g+E0xo8FumAQcPVdYc6qOSXLG
         ZCwdq+a+El0iXQ9NvqzQSV+5o8tkaGnkNbLQTXPn3DyO2aRfLin67T2Wy34Sok6kMgHS
         abWOTBq8JF73L58rTt9Z+FdRHMafVH/JTek9d5Apf0FZdLvDT/VvX9Vb1AHjtJGJ83V+
         jLvcinmun3EuKPxi+slBe6XNNSELRQzD7yj96zhnE36Yarv4knLBNENqr5btAvTLMTQp
         qxDw==
X-Forwarded-Encrypted: i=1; AJvYcCVYiDtH2ouPx5JRGr0garo/wPbmTR2l98qjw9PJwlVe+LN+oz0wwInT+kpyuUPhdePo9UNsugumTvQP@vger.kernel.org, AJvYcCW1bychnnnFCviVLVv32OBZwQfMky5b2Oni3W+MMsFn8H73EZqbX3s66VUitiMOc0KBCKInkPax4Nqu@vger.kernel.org
X-Gm-Message-State: AOJu0YwFmr+i2HIo92zPd2UN/I3iu6rGvL9P+bSYTBCovZU5HaFzIvs6
	/4nSBhS0QU/WhaWC5CkOVBoZ/j4UNwnhtWTlVj7yf0bvQeyh/1uabeuCIQ==
X-Gm-Gg: ASbGncvWPNq+3FvhARglPvlY/FM0RBhfPKHHAt3X//iUXoq1/eiNyCZGGDsvaUGVwDS
	QR5Iu3IaDQYVM2wYHeYmyVISN96tGSyMfkVTSfnO+0+fvylbasfxaVe7yb8+aRqQGZM8RhPdssW
	4MgfYfaJMd6cux/lBMJajKX665mUsbe/H39dVXPDrlEdj3Pe0ObAeWUEGYsfPtRliS4TY1ylCGn
	BWNYl8/2Z/CO1aQsq98Hhv7fU/Z/9CELC0SVP0VmoG/6CEXgyengHrJzZPIJnQjlUjRFEWq1rvq
	6Sw5SucnHjOkKqkMJ/HyphplbQn9vOT9E9hC0Quu/He2D9FKtfKU7h+bvuRbDDPkxI+eEa3tE2v
	KZcdc1SjK6UhjYO7DV8Z26j/h
X-Google-Smtp-Source: AGHT+IGg4P17hTx3gidRot0w51ZXBNK4ulaGQTIrwNFXzOJcS4td4I76e7T/r4hj+61KG+wuInlU4w==
X-Received: by 2002:a17:90b:2e10:b0:2ff:71ad:e84e with SMTP id 98e67ed59e1d1-306dbbae2femr3280074a91.10.1744182430609;
        Wed, 09 Apr 2025 00:07:10 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f2a:4b1d:fee1:8dac:3556:836f? ([2401:4900:1f2a:4b1d:fee1:8dac:3556:836f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c99f23sm4637125ad.154.2025.04.09.00.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 00:07:10 -0700 (PDT)
Message-ID: <eebed3b3-f79b-4a27-8a8f-6d8bb09b8f73@gmail.com>
Date: Wed, 9 Apr 2025 12:37:05 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] common/config: Introduce _exit wrapper around exit
 command
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
 <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>
 <Z_UJ7XcpmtkPRhTr@dread.disaster.area>
 <37155b56-34ba-4d5d-a023-242abbe525b5@gmail.com>
 <Z_XC0sMObxxHOWM5@dread.disaster.area>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z_XC0sMObxxHOWM5@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/9/25 06:14, Dave Chinner wrote:
> On Tue, Apr 08, 2025 at 10:13:54PM +0530, Nirjhar Roy (IBM) wrote:
>> On 4/8/25 17:05, Dave Chinner wrote:
>>> On Tue, Apr 08, 2025 at 05:37:21AM +0000, Nirjhar Roy (IBM) wrote:
>>>> diff --git a/common/config b/common/config
>>>> index 79bec87f..eb6af35a 100644
>>>> --- a/common/config
>>>> +++ b/common/config
>>>> @@ -96,6 +96,14 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>>>>    export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>>>> +# This functions sets the exit code to status and then exits. Don't use
>>>> +# exit directly, as it might not set the value of "status" correctly.
>>>> +_exit()
>>>> +{
>>>> +	status="$1"
>>>> +	exit "$status"
>>>> +}
>>> The only issue with putting this helper in common/config is that
>>> calling _exit() requires sourcing common/config from the shell
>>> context that calls it.
>>>
>>> This means every test must source common/config and re-execute the
>>> environment setup, even though we already have all the environment
>>> set up because it was exported from check when it sourced
>>> common/config.
>>>
>>> We have the same problem with _fatal() - it is defined in
>>> common/config instead of an independent common file. If we put such
>>> functions in their own common file, they can be sourced
>>> without dependencies on any other common file being included first.
>>>
>>> e.g. we create common/exit and place all the functions that
>>> terminate tests in it - _fatal, _notrun, _exit, etc and source that
>>> file once per shell context before we source common/config,
>>> common/rc, etc. This means we can source and call those termination
>>> functions from any context without having to worry about
>>> dependencies...
>> Yes, I agree to the above. Do you want this refactoring to be done as a part
>> of this patch series in the further revisions, or can this be sent as a
>> separate series?
> Seperate series is fine. You're not making the dependency mess any
> worse than it already is with this change...

Okay, got it. I will add this list of ToDos. Thank you so much for this 
suggestion.

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


