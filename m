Return-Path: <linux-ext4+bounces-7521-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86B7A9EAFD
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Apr 2025 10:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE161188BAB6
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Apr 2025 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A5425E81B;
	Mon, 28 Apr 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQcok7Ev"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9CD530;
	Mon, 28 Apr 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829722; cv=none; b=sV+dsi8xkz1MoSUpVuI+S6USX5zKJfQrRTY34qW++GcReid+6RqD1Qo3Bsv0w1RTW4WGWcQHdvDGDuvov5xBwk7zyMmVkn4/oYdSgyyZAw1YHJZaw5b7TMIftKnG7Jt9Oh4C4bIS8SEbK8ad4CUdP3tx7GyPaO0T4ltHaz92fK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829722; c=relaxed/simple;
	bh=6wVjNnshTCAoQoQqT5T2QQYKqEXwmctTJ4Kd10bABco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHbGEGOjboRN8a5Xe+BcB4ebXSIXf+NE0P2NuyDK+HrYatDDZjwnKsI7mBHFX2iHhtWbZvIBZojk6UmCaf+JxSZQHIhfkWwIZiTEGyNgOUW779JGM9mUwfDOloRhZQ50NofOz1PB/C6IypZPLI+GIR0nqAvmAduVmox1fKCk5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQcok7Ev; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c336fcdaaso51909665ad.3;
        Mon, 28 Apr 2025 01:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745829720; x=1746434520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jl7SkQ6bwqME3ZfVsrbU3UEoFPmnxH6bqtlU1i02ubQ=;
        b=WQcok7EvOPautxQksA9PFpAKA1BvDXuOqYF1h7pehYQm81xHR3rTh+P+1KgT9csCQ+
         LW0dpGYiY76Amk4DCbO+M5LI2TtkuA+Ovby4u2L+KoEkx179ZHi1/h1SOyYCf85kl233
         qGWTeCj2ie1zvtL/vgjwQPIjTwlQjAweg9bIExnFZ5S7uWj6DQIrYKacqOAoJKiuDLoK
         jGyQWRVBUmqeeDmwcY3qahKg+hVG2cDKySH3lgdrUH2NleTf6NZRLco5bcx9iHHJojc0
         YWW3F/QC1olIbiZ+EjyTLRdyHF+6CpzhIw1n0FzmonwJ1sZfrZd+FbTGS4t985sJl+zQ
         DDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745829720; x=1746434520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl7SkQ6bwqME3ZfVsrbU3UEoFPmnxH6bqtlU1i02ubQ=;
        b=EK4F2EMXka6y29T41MmoTzvnfRZkv0t274V0PMr8Er0zG0+sp3tywriS991Vj3YJC4
         nsLarn33bz/lyOPRj0oIJ4KIBwS9iTRLWfLwkk4L3BfxToWLWQnr9ym7W37/2fABsWL7
         Co+Fp00zA2EkBwVOISwNDLgDNBCRux7jx7RgJfuiUClMWEbYDLIiaNQyHQjQj0hImVje
         Pr81jQAMiqcnrh8DGBuqYsmGajmQKaj/zNvzHUa53s1HPIetYAExEMIRGJ+iA3MOMH8z
         w+wPoDVvKZdRe0ooVJZOZIKtodX9dJvVQ/eT2+FDayBLtn7Ra0isPQ2lW67PY80c2k3I
         F82Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX86SAFc5kEkHCJEAXkqYkNtS1UJJ6SL7cexUffKBLCJdPVcyGgCFrkRhiwXWIoflOAWFoda5FlYPNvA==@vger.kernel.org, AJvYcCWpBAXTA87wcSmp3lxZb+WrpijQ95JMJl/jbacvKEbMehYk5DA4Iotr8b6eHxMfhzR94ZhMia67@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VS+RQQbZUJ3YhgsQh3QZzG5FJ3ax7k7DPNnMgKsPmdc+ob5R
	HLUqphtJkg3nm999phCmansA0kCd+dW0RsG5ZxQLPOk8vz1Pd9VL
X-Gm-Gg: ASbGncsrf3xkqkv5X7L76RziQ43frSQxRbFyIjOAFjpxnOOieHl75h0P5Po5qsck9f+
	Ho8+qi73GJHcfaAmZLnPCYp9T8pRZO4bgQcAu9uCYz9191LZvPdyTulQIw1i0yi/VWor9YQ/KRl
	ADaXnE0OYlLjf64EwUMUn3BM9zNSsSITY6YtD8Xs9KXuGJmHq5Uo4rfpz6lkZ0CIDyZ9IcFf/Re
	3IzXblbxAGi8Hr9Asct0H74VMWkRIhUuDS9e0rpkD851E2zWglz4mghRiZkRCbp8QhvPl4cwA1h
	r7KiO6QWBxBwfCeuqHUFp7fgxnifqjNJeaxWrnZ+eMPP2g5NoMs=
X-Google-Smtp-Source: AGHT+IEihZ/WOivxhajbJxZ5S/Ab6LeajS4srSHToBYrKggv82sg414no37PbyuA/XokqfIC8xpk3A==
X-Received: by 2002:a17:902:d591:b0:224:162:a3e0 with SMTP id d9443c01a7336-22dbf640949mr166221075ad.49.1745829719778;
        Mon, 28 Apr 2025 01:41:59 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f77641eesm6526835a91.25.2025.04.28.01.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 01:41:59 -0700 (PDT)
Message-ID: <4e9e20f3-6908-4969-90ee-8eb6b6d53e3f@gmail.com>
Date: Mon, 28 Apr 2025 14:11:55 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] xfs: Fail remount with noattr2 on a v5 xfs with
 CONFIG_XFS_SUPPORT_V4=y
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com>
 <Z_yhpwBQz7Xs4WLI@infradead.org>
 <0d1d7e6f-d2b9-4c38-9c8e-a25671b6380c@gmail.com>
 <Z_9JmaXJJVJFJ2Yl@infradead.org>
 <757190c8-f7e4-404b-88cd-772e0b62dea5@gmail.com>
 <aAuIn7zbSNRzQ3WH@infradead.org>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aAuIn7zbSNRzQ3WH@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/25/25 18:35, Christoph Hellwig wrote:
> Hi Nirjhar,
>
> sorry for the delay, I dropped the ball while on vacation.
>
> On Wed, Apr 16, 2025 at 01:05:46PM +0530, Nirjhar Roy (IBM) wrote:
>> Yes, we need a second pass and I think that is already being done by
>> xfs_finish_flags() in xfs_fs_fill_super(). However, in xfs_fs_reconfigure(),
>> we still need a check to make a transition from /* attr2 -> noattr2 */ and
>> /* noattr2 -> attr2 */ (only if it is permitted to) and update
>> mp->m_features accordingly, just like it is being done for inode32 <->
>> inode64, right?
> Yes.
Okay.
>
>> Also, in your previous reply[1], you did suggest moving the
>> crc+noattr2 check to xfs_fs_validate_params() - Are you suggesting to add
>> another optional (NULLable) parameter "new_mp" to xfs_fs_validate_params()
>> and then moving the check to xfs_fs_validate_params()?
> No, let's skip that.
>
> But we really should share the code for the validation.  So while a lot
> of the checks in xfs_finish_flags are uselss in remount, it might still
> be a good idea to just use that for the option validation so that we
> don't miss checks in remount.

Okay. I will make the changes in v2. Thank you for your suggestions.

--NR

>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


