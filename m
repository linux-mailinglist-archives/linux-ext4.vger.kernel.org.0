Return-Path: <linux-ext4+bounces-5343-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A289D533A
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 20:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222081F20FB3
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 19:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA61D4323;
	Thu, 21 Nov 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpoDArGg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72E1CD1EE;
	Thu, 21 Nov 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215416; cv=none; b=J1i/kb0D+GpA7CoH5q0DDW4XH85zFddG/sN0Zqh46N3Ehvkm4mAKo5U45wcHbWHNwjCYoTbtQyhmniOCgo8UooBD9KLr59DX4oQm4nL787RWmVyg1BXVwlHyHEUPTmVqkUOz+3qjuUzYDXtrxY8GQzD0KpWFG2mo/HQ3q3yInBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215416; c=relaxed/simple;
	bh=fdqgDVFUO3jqkK3S5ZKi3oxfBRiOYeXV3qcrZ4bkRAo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=uIQYh2BM2dXVkpgbYYhBsplBdnI+rtY0k6LdbMMV5/hCZuYTQ1Q2N10ruF3A1zrE2XpzhJRY/nj37UHfebvY73eIKqsIZXjHwqDefvL26J2KM5Ii+6WwUjtbBSgBvViamI39WCQX9xVhfZF3h4VOWr82YWb/A71pqGdYf7sLGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpoDArGg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21288ce11d7so10234625ad.2;
        Thu, 21 Nov 2024 10:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732215414; x=1732820214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/XMp4NQse7SQoayQYSdr/CkMRmm/AMXKkTgUK7QVDc=;
        b=TpoDArGgs0zrHjrkCuS7sbGqqK57rqCpQt13j10KzZYxXb+mcc8V1xH8Oxy7tKLYIr
         C6zNMZU43nsuUKG11dx4/3KWVHnWvId0Ldz55qA/oBpHHkGzOFVLVcrSZrVXD/+8vObT
         /zDegYghwkw1gDLEWJmqO4GEit3VRweLzrUmeHY4l9vTJginEXL3EgTwl5b37j8OPc8r
         N4llZJ75rWN6mjaSZx3xDtJx4V/j1CLDBrP5Z4stZCRejv0t1AKFAZH3PuPGQRR5MiOn
         jGxlC2jM/uPp5rrC0D7FZw4JV34Xhwk99YvvOd4beAROACjKIm6tSqfHOBlZo/5JpSRC
         DlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215414; x=1732820214;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/XMp4NQse7SQoayQYSdr/CkMRmm/AMXKkTgUK7QVDc=;
        b=u18mwDNbAWmu3gF5Yr28zpnPXKxbGEUOP9IaWQdp5Vod2zBgCm34ofvx2SzWCw7M4N
         BjgEbiWoIvCEmHrbBty9uMGwPAIJFlHe09GnF9iAJ/EDqwqXMy9FBi3+Bu0nxpZlIigA
         Qg5746vt1AgOuRQNw0ytlXQ11Svb4oz4o/97CY5BGR+CYZD6iHHPp7jZ2/JB6WfEbZlL
         mAM1Foit9EOCXngKeW0JpsTnmHrs1IvfnMx9GdKUH8cuuXXdKOBNwPl9zIPTvSNr/vV6
         G4Rss5Xnaf2q7ZIl6/yPJYyIaVbYbJDWdqu2YEoY/N9LFqlEsCfShtpdu7U/bR26Cq/g
         RAtg==
X-Forwarded-Encrypted: i=1; AJvYcCUoyu4g0xgCmHB+kz1HZgROBJZD4uU9Weg19gW2EVRRycmRAXTCIcEvQ9AUQJoRGlsM8LBcRhjqrLf7@vger.kernel.org, AJvYcCV7QCJEOecuP7LTMEEbs/3usiz1Tnp3Y4ukvWt7bOmsOe/6HyRWGeXqOABYe7jI7sg6UoGwLLUu@vger.kernel.org
X-Gm-Message-State: AOJu0YymviqGZzIFgMucWkfdAaHF2ZzTEb42dKg9mWVfRT0qCKAHVxpU
	XntETGJW389atti62X4ZQlgIftyX3IQTiY2lrF+HyzzrHgLaY3YIFnGRQBg8
X-Gm-Gg: ASbGncvaLyW3hQSINbx48TLGfUKBailro644wtHzfGqnlGAgBOPxAwukT0lJoMFgkkG
	xemDqQXnVts/kzggAKec9TAjLW2nG6iNS1AwMtiYxXvVSxDmRH+ckFEyishJ004SrPTLXY3zwfd
	iBEIz5tIqmVvCwe8VO0zbZ4YU2JA5Ejrtr8T4uhaUejecUkpuVWseDBqKj6ZDHpmBW5/2BKNBZx
	xFNh4l7DBpXMuq2n/WKAXGO5ZgOW3eCNUscbe8PzcY=
X-Google-Smtp-Source: AGHT+IGUlOjhDYMtft773rL5jurVlHY/VYMS8xLagffaj/hq+hcYvyB0o8qNGYP6FbCZRUx44/RURw==
X-Received: by 2002:a17:90b:1d48:b0:2ea:98f1:c17b with SMTP id 98e67ed59e1d1-2eaca6c072emr9302091a91.5.1732215413925;
        Thu, 21 Nov 2024 10:56:53 -0800 (PST)
Received: from dw-tp ([171.76.85.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d06299dsm55116a91.53.2024.11.21.10.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:56:53 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v3 2/3] common/rc: Add a new _require_scratch_extsize helper function
In-Reply-To: <52dce21e-9b34-4a3d-9f2c-86634cd10750@linux.ibm.com>
Date: Fri, 22 Nov 2024 00:22:41 +0530
Message-ID: <871pz4xvuu.fsf@gmail.com>
References: <cover.1732126365.git.nirjhar@linux.ibm.com> <4412cece5c3f2175fa076a3b29fe6d0bb4c43a6e.1732126365.git.nirjhar@linux.ibm.com> <87plmp81km.fsf@gmail.com> <52dce21e-9b34-4a3d-9f2c-86634cd10750@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Nirjhar Roy <nirjhar@linux.ibm.com> writes:

> On 11/21/24 13:23, Ritesh Harjani (IBM) wrote:
>> Nirjhar Roy <nirjhar@linux.ibm.com> writes:
>>
>>> _require_scratch_extsize helper function will be used in the
>>> the next patch to make the test run only on filesystems with
>>> extsize support.
>>>
>>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
>>> ---
>>>   common/rc | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>>>
>>> diff --git a/common/rc b/common/rc
>>> index cccc98f5..995979e9 100644
>>> --- a/common/rc
>>> +++ b/common/rc
>>> @@ -48,6 +48,23 @@ _test_fsxattr_xflag()
>>>   	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
>>>   }
>>>   
>>> +# This test requires extsize support on the  filesystem
>>> +_require_scratch_extsize()
>>> +{
>>> +	_require_scratch
>> _require_xfs_io_command "extsize"
>>
>> ^^^ Don't we need this too?
> Yes, good point. I will add this in the next revision.
>>
>>> +	_scratch_mkfs > /dev/null
>>> +	_scratch_mount
>>> +	local filename=$SCRATCH_MNT/$RANDOM
>>> +	local blksz=$(_get_block_size $SCRATCH_MNT)
>>> +	local extsz=$(( blksz*2 ))
>>> +	local res=$($XFS_IO_PROG -c "open -f $filename" -c "extsize $extsz" \
>>> +		-c "extsize")
>>> +	_scratch_unmount
>>> +	grep -q "\[$extsz\] $filename" <(echo $res) || \
>>> +		_notrun "this test requires extsize support on the filesystem"
>> Why grep when we can simply just check the return value of previous xfs_io command?
> No, I don't think we can rely on the return value of xfs_io. For ex, 
> let's look at the following set of commands which are ran on an ext4 system:
>
> root@AMARPC: /mnt1/test$ xfs_io -V
> xfs_io version 5.13.0
> root@AMARPC: /mnt1/test$ touch new
> root@AMARPC: /mnt1/test$ xfs_io -c "extsize 8k"  new
> foreign file active, extsize command is for XFS filesystems only
> root@AMARPC: /mnt1/test$ echo "$?"
> 0
> This incorrect return value might have been fixed in some later versions 
> of xfs_io but there are still versions where we can't solely rely on the 
> return value.

Ok. That's bad, we then have to rely on grep.
Sure, thanks for checking and confirming that.

-ritesh

