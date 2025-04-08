Return-Path: <linux-ext4+bounces-7141-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDC5A81289
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6485318840C1
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9194122F152;
	Tue,  8 Apr 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cccxcjq5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DC1CB501;
	Tue,  8 Apr 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130138; cv=none; b=sVKKbT5R4OhWl40L4XX87o60FlSWXXo+vXzAZTv+CD13UBK0A1HOmHO1cwXSwts8BoTy/3IvYhrjXhnRfXTEGc+RkXfa+eMEVNaGYDgaRdp0GU4yi2PhKD4lCczrzJR4skElkR2d1gQbJvGt5mRpv3wFLJzhvLykj/Gl3nst5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130138; c=relaxed/simple;
	bh=MzXLgFjot5MLrqkIhtaFOJUnQ2r4uB408d67S2hgs0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hli2KEE/frRTho1DJ04X7i4YhsGQHzrRzw+YHGHwxkWlIVPvfQ6ZQsPEGf2RgV7SWu78KcCJnpe4bqSDVYLFE4InUPJDM8f6km2VqTW9WkXSh1zgTFv0IgWRVny5Dxq9XMlAccfnLPEJLHqkVkon6bgk9g7jFjbDjKrx3IguzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cccxcjq5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so4766745b3a.3;
        Tue, 08 Apr 2025 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744130136; x=1744734936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiC6J0IDcQn6FUFQpRktZ0NjARVBfwhMm3Smewc5FZM=;
        b=Cccxcjq5oZryJYyo3ydHSRZP1pr8GLzMjiaiZ2e/yAfNhEvwpD3znBufmn+POhVDlS
         Sa/R0cKhrewlI78E0qqq5jzPFyELr3aVXdry+nxQz+igPTDCAiJGHOmH26abEW0FP8XW
         1VZOe3+toK4AtrUKNCNuDBTur54xRMcqQ0lzroOvfjSzyzuFCb0tREJ0ctaPVHUl3rPG
         zFNMYDrBaAbu5/JnC5u+qkqAy+JnQTb08pyFShjPubshnbrDzCzWLnYW02NrqMHe8+Fl
         4sILHAWPfDgGKm0d0r0nCTk4XvybvmERp4lqJRCHVOoiS7jij3FyCbLUiEuzMjAVPcQl
         q81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744130136; x=1744734936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiC6J0IDcQn6FUFQpRktZ0NjARVBfwhMm3Smewc5FZM=;
        b=ZLBgSdbnP+UBrfL/Dxg5x0uCvxI+Ys+A8itmFN31HSyNbTdXAsu1MmtdYXvglnhMQ0
         gziBkSGlG0YSLl5ibGd9e8BW2KW7bsmgmUn7ig4ZfBsaX5WbBVIpQS03wShpQfxV1tHn
         s5AU4gRQg2o2OQBVma0bSz7Oy91vfSdds8aRxCB4k6zow4lT+s3keJVaFAUAP5u4dKbs
         pmX7vqVYkILNAR4ZTFtKFRX3z3hrsjNsd31jLDxxioCB0ew/9P93jGxpDSQVtI59DxV1
         uund9bcKGm74dBKDfASu8xdqI5j7U6exKgPUy70vHggmPDfhhzqPODbpKDz3fgcSt/Bz
         LH2g==
X-Forwarded-Encrypted: i=1; AJvYcCU096lKumo2SQeh8kFogb1kr0Knjfd3j5PJ8h1keZ2ZjFIRVzi8Tcbqa+01djJLo+vTSnn962FA@vger.kernel.org, AJvYcCWIfkWV6LQ4SsELshDzWt6eCR7t5Eoro3Mb8EOYtJYXR9Cu29J3VIlBb4sk+p9IZVDeOKkqLwWh6Cgl/w==@vger.kernel.org, AJvYcCWPeagwWlsCopTNFjbySaG/3xsL5Ud8WO0CLeHTDtKzlsI/vLghMZ0Dv7XJ7qy7Niz/8taS+1nWc7y/@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2xv/r75Aprhz54joyUsu7NrD5iV96qzrFKMe6EdWUznEP/je
	cZrRSfAHUdqSEt+lsgFaklVIbrCsvKLuR2SnlNMB8RUC87E/atL3
X-Gm-Gg: ASbGncuE+fHzQOTampho61W61IoL8JzNmefpukwBtJgkkoN2HMUVau0SjvrZYi5hOfC
	rv7z9KrmUhBuruy7v//dHlR+5UYGH3TS4ZXevF9lZtSKyZdHi6f8b2Ohj9gf/MFBvJ6+sLa3qRM
	x6QP0u3LJ8WxeOYEBNw4Enm1k7qvcBzsJFRv4mobdj4TQfNgEO2OUfns7Xc94dCgbDWKKd5nTCS
	Q9sUfiTF4QjDCn+XlBwF4z3mJXJSbEgj1myKcJBSplFjNMc99pSCbD2WUJFbXeXsAWBafznor9T
	U55+Y0qaJ3pvkdeCv0hdiAERgiZM9i2qRYg1SWuijdXwvrJ1k8i6LMznrw6YnzOfpQPtPGPF1B5
	9AfNAu7y9Z2F4eJPZ4XEfR9bmTKZ8Lt2QjIUVk0s=
X-Google-Smtp-Source: AGHT+IF+LctoHLYbFqAQgqCG9RSw62hwy8hkXLTLfJumVgOMhLVU4uD6r5hST7UokYBtK4m6mvGJUw==
X-Received: by 2002:a05:6a00:14d4:b0:736:476b:fcd3 with SMTP id d2e1a72fcca58-73b6b8fd296mr21160763b3a.24.1744130135585;
        Tue, 08 Apr 2025 09:35:35 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f2a:4b1d:fee1:8dac:3556:836f? ([2401:4900:1f2a:4b1d:fee1:8dac:3556:836f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d1b9esm11147290b3a.18.2025.04.08.09.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 09:35:35 -0700 (PDT)
Message-ID: <1b923260-2879-40d1-8543-15272a296ca6@gmail.com>
Date: Tue, 8 Apr 2025 22:05:30 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] common/config: Introduce _exit wrapper around exit
 command
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
 <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>
 <87y0wbj9ru.fsf@gmail.com> <0e4817b5-bd20-4ea6-93f4-ec0bee9bf833@gmail.com>
 <20250408163244.GH6307@frogsfrogsfrogs>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250408163244.GH6307@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/8/25 22:02, Darrick J. Wong wrote:
> On Tue, Apr 08, 2025 at 09:45:53PM +0530, Nirjhar Roy (IBM) wrote:
>> On 4/8/25 14:43, Ritesh Harjani (IBM) wrote:
>>> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>>>
>>>> We should always set the value of status correctly when we are exiting.
>>>> Else, "$?" might not give us the correct value.
>>>> If we see the following trap
>>>> handler registration in the check script:
>>>>
>>>> if $OPTIONS_HAVE_SECTIONS; then
>>>>        trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
>>>> else
>>>>        trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
>>>> fi
>>>>
>>>> So, "exit 1" will exit the check script without setting the correct
>>>> return value. I ran with the following local.config file:
>>>>
>>>> [xfs_4k_valid]
>>>> FSTYP=xfs
>>>> TEST_DEV=/dev/loop0
>>>> TEST_DIR=/mnt1/test
>>>> SCRATCH_DEV=/dev/loop1
>>>> SCRATCH_MNT=/mnt1/scratch
>>>>
>>>> [xfs_4k_invalid]
>>>> FSTYP=xfs
>>>> TEST_DEV=/dev/loop0
>>>> TEST_DIR=/mnt1/invalid_dir
>>>> SCRATCH_DEV=/dev/loop1
>>>> SCRATCH_MNT=/mnt1/scratch
>>>>
>>>> This caused the init_rc() to catch the case of invalid _test_mount
>>>> options. Although the check script correctly failed during the execution
>>>> of the "xfs_4k_invalid" section, the return value was 0, i.e "echo $?"
>>>> returned 0. This is because init_rc exits with "exit 1" without
>>>> correctly setting the value of "status". IMO, the correct behavior
>>>> should have been that "$?" should have been non-zero.
>>>>
>>>> The next patch will replace exit with _exit.
>>>>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> Reviewed-by: Dave Chinner <dchinner@redhat.com>
>>>> ---
>>>>    common/config | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/common/config b/common/config
>>>> index 79bec87f..eb6af35a 100644
>>>> --- a/common/config
>>>> +++ b/common/config
>>>> @@ -96,6 +96,14 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>>>>    export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>>>> +# This functions sets the exit code to status and then exits. Don't use
>>>> +# exit directly, as it might not set the value of "status" correctly.
>>> ...as it might not set the value of "$status" correctly, which is used
>>> as an exit code in the trap handler routine set up by the check script.
>>>
>>>> +_exit()
>>>> +{
>>>> +	status="$1"
>>>> +	exit "$status"
>>>> +}
>>>> +
>>> I agree with Darrick’s suggestion here. It’s safer to update status only
>>> when an argument is passed - otherwise, it’s easy to trip over this.
>>>
>>> Let’s also avoid defaulting status to 0 inside _exit(). That way, if the
>>> caller forgets to pass an argument but has explicitly set status
>>> earlier, we preserve the intended value.
>>>
>>> We should update _exit() with...
>>>
>>> test -n "$1" && status="$1"
>> Okay, so in that case if someone does "status=<value>;_exit", we should end
>> up with the "<value>" instead of something else, right?
> Right.  I think.  AFAICT the following simple program actually does
> return 5 despite the cleanup:
>
> trap 'echo cleanup' INT QUIT TERM EXIT
> exit 5
>
> But since fstests set a variable named "status" and then "exit $status"
> from cleanup, I think it doesn't matter how status gets set as long as
> it /does/ get set somewhere.

Right, I have got the idea. I will make the changes in next revision.

--NR

>
> --D
>
>> --NR
>>
>>> -ritesh
>>>
>>>
>>>>    # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>>>>    set_mkfs_prog_path_with_opts()
>>>>    {
>>>> -- 
>>>> 2.34.1
>> -- 
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


