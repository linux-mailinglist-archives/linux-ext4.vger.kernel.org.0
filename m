Return-Path: <linux-ext4+bounces-6508-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061A0A3C31D
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2025 16:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489783B9FE1
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2025 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59D1F4167;
	Wed, 19 Feb 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1J5y1H5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC391F3BB2;
	Wed, 19 Feb 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977492; cv=none; b=dbDhxBxWedY4IoBVnvkSaxaWtt8RZtwpQTM7DqOUKsjRb/XN79Oss4S4UNde7hm6VOvF54KpE6na3O5ojSPjceHy9+prtDIppgWy8IM8iGc/CpPZIR6psnOATS+tg7UKFB1djGS/c6YUTyp3w2AOTJcXmvOt78uhDiVgRZizu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977492; c=relaxed/simple;
	bh=ljNhr3gioO5BrDd9zykPmvUpWyLxX/ZGib1/O/4tlBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WD6Waf4xuLbPDNpjs7Ia29zoNDQU2Fcqz/bfUfRooILGyzfCN9hkCqHREcjAlkl0SGuuNTZKadZtg4Ridse1oNgIbqstJq8l6LGtGWwt9SuuZ5fV0ehKfl9v80fPrwBKJd5kuAZuE8+Fg3HwUoWuaE+xrZc5xJM8J2nk68OXLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1J5y1H5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2212a930001so8006645ad.0;
        Wed, 19 Feb 2025 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739977490; x=1740582290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTdD+bQIdz3RWZ4KMHlskhNWncYorBHEeG1RebeT8zs=;
        b=E1J5y1H5D4TXvgFNaO47qrO+b8QsQ4GL30IcigUFudaCE1FV1hmS8+BF23mAR1RSLs
         PhwJ5bVR4FhsReNfWVyiBbRuwgYH3pwSIRvZX12Oq2hwyLzL3m0SynOqlcgkVgtt/5IP
         /RAjfL6+r8zO3Z1WWfj80aW51KWTR+QzK21pZMbJYT71qk56PFNuHUdFJ/AO8vmutcTg
         stnlSTptLkS5hoIQyGg2IVZ1xr6lOoHZiNJGAaCNIZ18ZYVqloi+qSaDN+N87HcsIYzS
         oIlmveg1nUFXJY1ZNe6wQAQ9QFh4olg+hNTq9EEvOmiz9BA0IXcv5/uKgpZZDp8X8la6
         fG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977490; x=1740582290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTdD+bQIdz3RWZ4KMHlskhNWncYorBHEeG1RebeT8zs=;
        b=UJKiGxlhlxmehIWRzzbx6rgUPNr7K4gIEJEEJjQj+oc9hfAgjpypANjFEur+zz5RCu
         ezzQ2ZVzh1a5WQuQ8FFCLyymvlfobZdOVopGtEBE2Ek9nO6Mo458rjxxUm1vx3I+HSsU
         AG24dXYHML/DqMjY7BTcSmSFoS1RDIlAJ62k/n+dP9s//QUjnagDkjcN+3vJQDubPbS0
         ysu1LBt7b81KugRQ1ciBLZwQJog+lH/kAUHVQKg+/1zU8nSc/cZjoR9fXGme/gsUS41d
         iABy+x7KMAmU+OzLguP9tE5kdEYz0ZFO/9w2jkwVj3TGvh8A8NhVBuncAlkDC0tLWwF+
         6vnw==
X-Forwarded-Encrypted: i=1; AJvYcCUc102IZIPrKFb9Qbd/AgrnSAYq1Wa+CQVsR2hPwOBSIKHZhhvWY4DtDqxOfTwbMsqe8fUzBvyZA0nc@vger.kernel.org, AJvYcCUzqHU7hd1yek++PPbHqrKwM2VHrtSfYvrTqIHlZiW/3bFGXd+acR/2QXhiYknxAsCCUdiNriFgJrhd@vger.kernel.org
X-Gm-Message-State: AOJu0YxgZcLfXynHeHFdscCPqhrAwOmv7KoeLGc4PemCWnDXUPIcf7Ry
	1rU3qpbsMwcLwVaXcTp0p1/iifYBMOGDIrAXmU4qpUEQQ51W5MI7
X-Gm-Gg: ASbGncukyXsL8k923RrDWRKJ5WECzQXCNokr9OnSw7hAAN8lPcFx2XVdAL8pRj7SNWd
	3yPVIBmd4qGdXRFz5eFr0LHnxvF/8UxoWfYzrRgkm/6lNFTbpkES5smpmwbm30bI8Lo5TeSJBwo
	U9MFesHkpOdAKqDSKsmHS1c14Q4wteN/TXaNGDIWcflT0ZB8MlBKbCUKI9DRSvoVhCjwPFYuN4z
	xts3+Ezz20TIKUKQVuMfaKAE2/LN0VhU0i0ez2yDK2DbeIdoBmU8FF11e1gWcU7c2xGendp7VFL
	2ThbMRAVcNpdCzgomF63/a99tw==
X-Google-Smtp-Source: AGHT+IHgGwjUZhfDYX8Qm0YJ2oNs1GP4Gis0CwmFBq5y3bH9gBxqoItHzmVLiLnLPcxaunc4g7TZdw==
X-Received: by 2002:a17:902:d58b:b0:220:ea90:1925 with SMTP id d9443c01a7336-221040ab9b3mr348915455ad.35.1739977490038;
        Wed, 19 Feb 2025 07:04:50 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f7asm106922385ad.23.2025.02.19.07.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 07:04:49 -0800 (PST)
Message-ID: <90be3350-67e5-4dec-bc65-442762f5f856@gmail.com>
Date: Wed, 19 Feb 2025 20:34:44 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] xfs: Add a testcase to check remount with noattr2
 on a v5 xfs
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <de61a54dcf5f7240d971150cb51faf0038d3d835.1739363803.git.nirjhar.roy.lists@gmail.com>
 <Z60W2U8raqzRKYdy@dread.disaster.area>
 <b43e4cd9-d8aa-4cc0-a5ff-35f2e0553682@gmail.com>
 <Z65o6nWxT00MaUrW@dread.disaster.area>
 <1b8a4074-ae78-4ba2-9d8a-9e5e85437df5@gmail.com>
 <Z7O4MZ0xOpO_GTKE@dread.disaster.area>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z7O4MZ0xOpO_GTKE@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/18/25 03:59, Dave Chinner wrote:
> On Mon, Feb 17, 2025 at 10:18:48AM +0530, Nirjhar Roy (IBM) wrote:
>> On 2/14/25 03:19, Dave Chinner wrote:
>>> On Thu, Feb 13, 2025 at 03:30:50PM +0530, Nirjhar Roy (IBM) wrote:
>>>> On 2/13/25 03:17, Dave Chinner wrote:
>>>>> On Wed, Feb 12, 2025 at 12:39:58PM +0000, Nirjhar Roy (IBM) wrote:
>>> Ok, so CONFIG_XFS_SUPPORT_V4=n is the correct behaviour (known mount
>>> option, invalid configuration being asked for), and it is the
>>> CONFIG_XFS_SUPPORT_V4=y behaviour that is broken.
>> Okay, so do you find this testcase (patch 3/3 xfs: Add a testcase to check
>> remount with noattr2 on a v5 xfs) useful,
> Not at this point in time, because xfs/189 is supposed to exercise
> attr2/noattr2 mount/remount behaviour and take into account all the
> weirdness of the historic mount behaviour.
>
> Obviously, it is not detecting that this noattr2 remount behaviour
> was broken, so that test needs fixing/additions.  Indeed, it's
> probably important to understand why xfs/189 isn't detecting this
> failure before going any further, right?
Yes. Let me look into what xfs/189 does and why it isn't detecting the 
noattr2 remount broken behavior. Thank you for the pointer.

About "Patch 1/3: xfs/539: Skip noattr2 remount option on v5 file 
systems" --> I wrote the patch because xfs/539 has started failing in 
one of fstests CI runs because RHEL 10 has started disabling xfs v4 
support i.e, CONFIG_XFS_SUPPORT_V4=n. Do you think modifying patch 
1/3(xfs/539) in such a way that the test ignores the remount failures 
with noattr2 and continues the test is an appropriate idea (since the 
test xfs/539 only intends to check the dmesg warnings)?

--NR

>
> IMO, it is better to fix existing tests that exercise the behaviour
> in question than it is to add a new test that covers just what the
> old test missed.
>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


