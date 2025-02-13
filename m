Return-Path: <linux-ext4+bounces-6429-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7CCA33BDA
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 11:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D583A82F5
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC92A20FA81;
	Thu, 13 Feb 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlG/G8Hy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73820B21A;
	Thu, 13 Feb 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440857; cv=none; b=p/4Mgy22phYc2C2Z7zJfVOG5G7uwJtQyhJZuHkrL+dC3XYkTOr8pLFYJUn5qU9l17PwfPquniIMVcLrVMS5ZeA4lZVwu7+TJ83s2GRe7TH4UymtKI5WGN1dMWg84XcNlnbwEPLNjY6dbxRmLVVR2aqZhCffgj7cGYD/qeuIFKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440857; c=relaxed/simple;
	bh=kRL6Kyh553VKDx/mLqwSVeYdsSULTxJAUXdoiY3kwX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYk4ajAPg7Po+yraRHPL//6MsiGrjdZLB9icxnSl14nZxDQswUBVVoeD++k1xwunRnNhaIYANt8MLQZzzgX4mWmHEw91prf/7vAXttiD0XOTiXP84+/hQC1T6sK++DmdAJmE+qlWAgfjaQXm8y/v7oK87ELq2v8yc1Iqb0Ok8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlG/G8Hy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f40deb941so15123635ad.2;
        Thu, 13 Feb 2025 02:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739440855; x=1740045655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3P9zNL4ihHY9juY4bEAnbKKWnWiyNUurGP120I8NfBU=;
        b=PlG/G8Hyh44hEu7WlcJcncEVeRvNr6sqAl1npCaskHf+tpE/bt8dXSlb2kOgXVoCt+
         jxuB+NqELyID+mEv04jF3tGVRPqjdGdOnIrgOlx+5olY6oeA0WlwQyU+2AS4DUwbDRsK
         dqcGm81hx4F27uZI9Jb/c5lOAdWmuWslG1F8TKG8u0FYcDD9Qw167X0fsbWxxeAgW21G
         VCKKa3JeHhO9T9Bbd+j6c5aqZ86pHVWlnXu1O+R0B6lS/1cBJANtswk2AAHiNZfsfdGA
         c0WBFuwHr0Qml2U50kZgUc+Gjyv/7NMHzTGgX2lr8WaSovzAwaV4GpI+LakKfNTYNdtd
         DjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440855; x=1740045655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3P9zNL4ihHY9juY4bEAnbKKWnWiyNUurGP120I8NfBU=;
        b=Rr9Ant5qRl9cYVybgcfyyWolILzRvdOCsFkby6+gQIFyVC86OvYsP53eMo09fOwodV
         JCcXWOa0Io++5UBUDbNaWsIukLNfRTingyQoLXHtIcy32O31P1k2r1EKfGs2qX6Lazmv
         mA+QgA0wygISxjGVwzd/DmdLoZsKFRw7Q8EtUdIw4evXgYZxjq1Fl5GJ/oxyL1Jil7ys
         6iNULgTjAGoCmYwqqHYAM9Q74uqU0RNzedJwpZwdSW2utlxt/7kCuki+AlCNoPlp5oUt
         ZoDYmXIyjPauj3v/rrCkWcxRw4t3Td7xAKKAsZ5XsDS/wv5ImvnAys4lJf//5trVl1tf
         4+uw==
X-Forwarded-Encrypted: i=1; AJvYcCWSWo4APxTWUzoMOC4REawNfUIeLuDQQXCc+8yn7bplUAsrFP3rigUbb3Vz2eR4sY4OvQPaTYVzSg65@vger.kernel.org, AJvYcCWwa5Rk4cpx3BLlbOkWdoFrv4c6Mhp4IntDTDAp/VIxTdYNHTBD9RVZaz4CJLqIdC2mBCP6MoeEKBUz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn19sr7XceJ832XGqh6zBP4LgOMstEpdJKBxeTXmZ4cFXC7n9b
	TVqB+EJ7R+A7/YDqW9cnEghUK9YZx4pboaubD3RKebFkDbU5sqg7
X-Gm-Gg: ASbGncu0KoATie50Tb/rLPaUs/Ks+dR8enWHDgufMOr7CqfD1dRurlSi/Ew8XJB+BQY
	29Nj0xNvL4WGPy5z5gR7gnI884rMb4kyMwPqRNkEZzIHq2MD/I0bKyftUoL9zwMr1MSKGwSStgL
	sswHFXLDqpSJ32DpOHMw/3E+wXnUTBDDbKYUFdHsTIHJQv+6S+DAAfIxmavyUYi28o/XKQ7vFKB
	SO53KNP9FmV/EyqXPlo+dwQFBsyvtGoIDvXQrF7w2BbFHwKydNqFm0DVfI7pTUAQZv0qUKGMvAN
	qVcUBDASkWhadHqujVrGRAh0WA==
X-Google-Smtp-Source: AGHT+IHroTG+cAWh+aiuCKZP0IeC6sxXeDOJDrhhpcsamnqf28wbiLaRulLy5RNvn47zqPhwnM3Xyw==
X-Received: by 2002:a17:902:e807:b0:220:e1e6:4472 with SMTP id d9443c01a7336-220e1e6474fmr8600405ad.13.1739440855192;
        Thu, 13 Feb 2025 02:00:55 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d4e3sm8988135ad.175.2025.02.13.02.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:00:54 -0800 (PST)
Message-ID: <b43e4cd9-d8aa-4cc0-a5ff-35f2e0553682@gmail.com>
Date: Thu, 13 Feb 2025 15:30:50 +0530
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
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z60W2U8raqzRKYdy@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/13/25 03:17, Dave Chinner wrote:
> On Wed, Feb 12, 2025 at 12:39:58PM +0000, Nirjhar Roy (IBM) wrote:
>> This testcase reproduces the following bug:
>> Bug:
>> mount -o remount,noattr2 <device> <mount_point> succeeds
>> unexpectedly on a v5 xfs when CONFIG_XFS_SUPPORT_V4 is set.
> AFAICT, this is expected behaviour. Remount intentionally ignores
> options that cannot be changed.
>
>> Ideally the above mount command should always fail with a v5 xfs
>> filesystem irrespective of whether CONFIG_XFS_SUPPORT_V4 is set
>> or not.
> No, we cannot fail remount when invalid options are passed to the
> kernel by the mount command for historical reasons. i.e. the mount
> command has historically passed invalid options to the kernel on
> remount, but expects the kernel to apply just the new options that
> they understand and ignore the rest without error.
>
> i.e. to keep compatibility with older userspace, we cannot fail a
> remount because userspace passed an option the kernel does not
> understand or cannot change.
>
> Hence, in this case, XFS emits a deprecation warning for the noattr2
> mount option on remount (because it is understood), then ignores
> because it it isn't a valid option that remount can change.

Thank you, Dave, for the background. This was really helpful. So just to 
confirm the behavior of mount - remount with noattr2 (or any other 
invalid option) should always pass irrespective of whether 
CONFIG_XFS_SUPPORT_V4 is set or not, correct?

This is the behavior that I have observed with CONFIG_XFS_SUPPORT_V4=n 
on v5 xfs:

$ mount -o "remount,noattr2" /dev/loop0 /mnt1/test
mount: /mnt1/test: mount point not mounted or bad option.
$ echo "$?"
32

With this test, I am also parallelly working on a kernel fix to make the 
behavior of remount with noattr2 same irrespective of the 
CONFIG_XFS_SUPPORT_V4's value, and I was under the impression that it 
should always fail. But, it seems like it should always pass (silently 
ignoring the invalid mount options) and the failure when 
CONFIG_XFS_SUPPORT_V4=n is a bug. Is my understanding correct?

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


