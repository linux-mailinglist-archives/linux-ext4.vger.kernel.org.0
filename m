Return-Path: <linux-ext4+bounces-6466-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E29A37AA4
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Feb 2025 05:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4493AE726
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Feb 2025 04:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA817C21E;
	Mon, 17 Feb 2025 04:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/uySGqr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A314D444;
	Mon, 17 Feb 2025 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739767735; cv=none; b=nqMcTKq4JCaCdbAE9Sn7Zfb2M3entjW0aNfjw7g9/DpYQWWgnRGoKQCAgIWqfrso3FRlpDrQTUKePtYoKvK10xta6Ds9x9jhT2p9A+zs+MFCHHiKfnSC0lncVpoeYvZ+kiv9ypytjbG0XUiXrh/3VVJSKsJbj8pGW3yM5Edgfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739767735; c=relaxed/simple;
	bh=yxtqvjvTDqIij1LGHpxjGWFsPI3fTb+vvpE+kMUG9ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lD8F+rLFmtUW/nEZa5JYVwwvB1RSJ/UMljW34gYZ4RSDFQlrQtq3yKBDnP+Yh/QGpSSz1E0jrA+q1k2z4LWVjz9JOTzXePLGOHc2XX3n72WFRm5PRKiUBeOHVoSmZlURelBTwFht1wvRBqutvPitNLQh/Ix2h0sgKDzukbuNfN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/uySGqr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220f048c038so43987755ad.2;
        Sun, 16 Feb 2025 20:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739767733; x=1740372533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nNPAvCgER+r3gpVR5iIB8pwYzNl9MKOtaNUT/MoDVk=;
        b=l/uySGqr6YE3flhS91MPU4p8Bi6omy73BAEeFxh213mxOSsfBG6bkTiung5ASUJDs2
         rVxfYwgUKwZFQAgIRbWYKMQNmAtmsBWXGNYbp19pin2obIbZfUl2doLIHLdj/4b61Q6F
         7rIvz28orfFpeMrk9W66fs4yYStdD1e5lJSee1XoKpcvALvvwcogyB1lNCBYopzJMMsn
         WqBSnGJNbkWgBbiNDz79F/VVo9Qqr/t0h56nE3NklB73T9e06nrSjM5oD8Fn5jTiumYN
         fZ+rbZKmtKyYSg4SX9S8occxAdmb8tyUhvk+5D1IqordSZy17CkzugOe7Ya0LnS+KOSu
         r0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739767733; x=1740372533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nNPAvCgER+r3gpVR5iIB8pwYzNl9MKOtaNUT/MoDVk=;
        b=p2lQmyCeC59JDoFobjPWexKjGbuUxhX/rH4NgI5GyBvl7ixUlBVrZnZ1wvKfhw+17D
         8jFJCpDQSkC5uOPhvAT2LiLtmLFLwU+wFE3shWKQzx1UxdrP/+yirNQDKTcJ9YUNvCQj
         DnxMaflv2w+GZTHTZD93ys6xnu4FlLN3DwO/VPFDphdq+aAsv63F0+EbEx3DiTRZBuY6
         R5ynfssy7H61gBoNXNfvo53QrxcIkYdxjoZAyjWYH7U1kdnqhCyl+EkQai4Jm4vXAhw/
         kixUWon/yp05LW2ShFhxKGh2a39k1rYSuM7cpm9yz8oM7Tomz/k2pS+3Ur65LHBxGa9m
         NygA==
X-Forwarded-Encrypted: i=1; AJvYcCU27OgHNaMI7OVRl4Xg+SxJi4WGK3VsoAu8mbgOsIqDfxavaxkbznnJdXUWGgi5XohiRxaHPwrgXTpw@vger.kernel.org, AJvYcCUE6rLmEpi/A4PVZsFGSnEVMNzxu3WjmiPzxGhafR+cNHt72irPtR07b0JIvUyySHRakI6MPbtFDTw3@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMNpMIRVm868IcecSirlfTVRNbLKzJGINfZf96byiaErxX/jC
	izWM8X9QC6fwGFPyX1uIQs9S2higzQI9wCl8nqan84nfj/3kU8Ud
X-Gm-Gg: ASbGncsrS+WXy6Dltx6aYzt/bY4Vp77lS6egXTGdCp5qYqq9a4wDMTmRkA7fuZbBmUK
	ucexUL2615Bh5oYjRLIjBNz9NvqYvfAQMveacCIveeRC3iQOfLmyGpCw+/P/6ZJ9aMd4kmnit3l
	rUuEkFwwFThAZqULx+xnR0j/A/7lvYTCMIPMbA7O/3mfx5zUDYgZGId5tnHc3CxJqHWKroTOMDR
	it2ILYBJYlV96iN7pLqbmvLIiFVy5oZylHanMlxzXNOOU29yyuAs1E9qGtBpEBmfuMPh042EsLd
	BJ3lnrmwsbaoMvlBsSEmf0eAUQ==
X-Google-Smtp-Source: AGHT+IH5lSpvJ97lUtBQKRzYt35E38hRakJzlPUT/w669LrDHST2ae2+0ocYLc0tJ0nxAE6zRPqyCQ==
X-Received: by 2002:a05:6a21:3394:b0:1e1:aef4:9ce7 with SMTP id adf61e73a8af0-1ee8cb5d37dmr13149528637.17.1739767733051;
        Sun, 16 Feb 2025 20:48:53 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73256fb09e1sm5201720b3a.65.2025.02.16.20.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 20:48:52 -0800 (PST)
Message-ID: <1b8a4074-ae78-4ba2-9d8a-9e5e85437df5@gmail.com>
Date: Mon, 17 Feb 2025 10:18:48 +0530
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
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z65o6nWxT00MaUrW@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/14/25 03:19, Dave Chinner wrote:
> On Thu, Feb 13, 2025 at 03:30:50PM +0530, Nirjhar Roy (IBM) wrote:
>> On 2/13/25 03:17, Dave Chinner wrote:
>>> On Wed, Feb 12, 2025 at 12:39:58PM +0000, Nirjhar Roy (IBM) wrote:
>>>> This testcase reproduces the following bug:
>>>> Bug:
>>>> mount -o remount,noattr2 <device> <mount_point> succeeds
>>>> unexpectedly on a v5 xfs when CONFIG_XFS_SUPPORT_V4 is set.
>>> AFAICT, this is expected behaviour. Remount intentionally ignores
>>> options that cannot be changed.
>>>
>>>> Ideally the above mount command should always fail with a v5 xfs
>>>> filesystem irrespective of whether CONFIG_XFS_SUPPORT_V4 is set
>>>> or not.
>>> No, we cannot fail remount when invalid options are passed to the
>>> kernel by the mount command for historical reasons. i.e. the mount
>>> command has historically passed invalid options to the kernel on
>>> remount, but expects the kernel to apply just the new options that
>>> they understand and ignore the rest without error.
>>>
>>> i.e. to keep compatibility with older userspace, we cannot fail a
>>> remount because userspace passed an option the kernel does not
>>> understand or cannot change.
>>>
>>> Hence, in this case, XFS emits a deprecation warning for the noattr2
>>> mount option on remount (because it is understood), then ignores
>>> because it it isn't a valid option that remount can change.
>> Thank you, Dave, for the background. This was really helpful. So just to
>> confirm the behavior of mount - remount with noattr2 (or any other invalid
>> option) should always pass irrespective of whether CONFIG_XFS_SUPPORT_V4 is
>> set or not, correct?
> Not necessarily.
>
> It depends on whether the filesystem considers it a known option or
> not. noattr2 is a known option, so if it is invalid to use it as a
> remount option, the remount should always fail.
>
> If the option is -unknown-, then the behaviour of remount is largely
> dependent on filesystem implementation -and- what mount syscall
> interface is being used by userspace.
>
> e.g. a modern mount binary using
> fsconfig(2) allows the kernel to reject unknown options before the
> filesystem is remounted. However, we cannot do that with the
> mount(2) interface because of the historic behaviour of the mount
> binary (see the comment above xfs_fs_reconfigure() about this).
Okay, I will look into the comments above xfs_fs_reconfigure(). Thank 
you for the pointer.
>
> Hence with a modern mount binary using the fsconfig(2) interface,
> the kernel can actually reject bad/unknown mount options without
> breaking anything. i.e. kernel behaviour is dependent on userspace
> implementation...
>
>> This is the behavior that I have observed with CONFIG_XFS_SUPPORT_V4=n on v5
>> xfs:
>>
>> $ mount -o "remount,noattr2" /dev/loop0 /mnt1/test
>> mount: /mnt1/test: mount point not mounted or bad option.
>> $ echo "$?"
>> 32
> This is not useful in itself because of all the above possibilities.
> i.e. What generated that error?
>
> Was if from the mount binary, or the kernel?  What syscall is mount
> using - strace output will tell us if it is fsconfig(2) or mount(2)
> and what is being passed to the kernel.  What does dmesg say - did
> the kernel parse the option and then fail, or something else?
>
> i.e. this is actually really hard to write a kernel and userspace
> version agnostic regression test for.
>
>> With this test, I am also parallelly working on a kernel fix to make the
>> behavior of remount with noattr2 same irrespective of the
>> CONFIG_XFS_SUPPORT_V4's value, and I was under the impression that it should
>> always fail. But, it seems like it should always pass (silently ignoring the
>> invalid mount options) and the failure when CONFIG_XFS_SUPPORT_V4=n is a
>> bug. Is my understanding correct?
> As per above, the behaviour we expose to userspace is actually
> dependent on the syscall interface the mount is using.
>
> That said, I still don't see why CONFIG_XFS_SUPPORT_V4 would change
> how we parse and process noattr2.....
>
> .... Ohhh.
>
> The new xfs_mount being used for reconfiguring the
> superblock on remount doesn't have the superblock feature
> flags initialised. attr2 is defined as:
>
> __XFS_ADD_V4_FEAT(attr2, ATTR2)
>
> Which means if CONFIG_XFS_SUPPORT_V4=n it will always return true.
>
> However, if CONFIG_XFS_SUPPORT_V4=y, then it checks for the ATTR2
> feature flag in the xfs_mount.
>
> Hence when we are validating the noattr2 flag in
> xfs_fs_validate_params(), this check:
>
> 	/*
>           * We have not read the superblock at this point, so only the attr2
>           * mount option can set the attr2 feature by this stage.
>           */
>          if (xfs_has_attr2(mp) && xfs_has_noattr2(mp)) {
>                  xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
>                  return -EINVAL;
>          }
>
> Never triggers on remount when CONFIG_XFS_SUPPORT_V4=y because
> xfs_has_attr2(mp) is always false.  OTOH, when
> CONFIG_XFS_SUPPORT_V4=n, xfs_has_attr2(mp) is always true because of
> the __XFS_ADD_V4_FEAT() macro implementation, and so now it rejects
> the noattr2 mount option because it isn't valid on a v5 filesystem.
Yes, that is correct. This is my analysis too.
>
> Ok, so CONFIG_XFS_SUPPORT_V4=n is the correct behaviour (known mount
> option, invalid configuration being asked for), and it is the
> CONFIG_XFS_SUPPORT_V4=y behaviour that is broken.

Okay, so do you find this testcase (patch 3/3 xfs: Add a testcase to 
check remount with noattr2 on a v5 xfs) useful, and shall I work on the 
corresponding kernel fix for it? I can make the change in "[patch1/3] 
xfs/539: Skip noattr2 remount option on v5 filesystems" to ignore the 
mount failures (since that test is checking for dmesg warnings), what do 
you think? Do you have any other suggestions?

--NR

>
> This likely has been broken since the mount option parsing was
> first changed to use the fscontext interfaces....
>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


