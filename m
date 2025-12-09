Return-Path: <linux-ext4+bounces-12238-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2DCAF816
	for <lists+linux-ext4@lfdr.de>; Tue, 09 Dec 2025 10:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A5830AD6AA
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Dec 2025 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1667A2FCBF5;
	Tue,  9 Dec 2025 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PMVH3Wmr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41FA2FC877
	for <linux-ext4@vger.kernel.org>; Tue,  9 Dec 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273588; cv=none; b=TgDVbBwIpG97RhBCVqV9FSfcQegrPvq9eO2DPDLYlLTO0c2WOzNKF7hNbX6D4lnkhPiEkreF5VfE1mnIFt2ZzmvJxNgQdkKwyfVdjgaED6lMCY/ZGI8Yp8QMIPSMYMS7X2ByLO4kXqGM2XU5gA+Czol8wNgVg87pHiBp5ibjU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273588; c=relaxed/simple;
	bh=3U08kyr/AID++fRRop6dnO7khqAtMKg0AXs6GgRqoeI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=If3bbM0QJWWY+2Ehee0ym9vZdRprHfOiU3ocHbj1dFejA1LXhqH52Jg897MGRrRPiCqVXs0Zdysj75PnzK3rdppv8TU/cmtOx+mLKRxITcxmKKCWKuvpXlN5kX6KV0w0IdSDzeh7pKOhjf9rbVUD520alzwDXNan5FZVFETgcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PMVH3Wmr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29808a9a96aso58941935ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Dec 2025 01:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765273586; x=1765878386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfxmzUUooqkWpOC9gnra+ZEKbDrqCeaM9bSxezRioDM=;
        b=PMVH3Wmrw5EnONYLYmTo5A7nWucllInD/BaNBa2sx+NLw0HqlhDVmmX8YAPSgFhQsr
         WBGknEiJbZwIw435zrEtv1Ek38QDcFnVpBeLF9u2ynFnCGYcaj7BVFxEBM6o37QkwOtD
         Bb+lItTcpRcWg1+Y3uZj5y512njsQS/Q/CprvdgkBAP8fNkhl6yqws8YZ8tb9t0WDzVU
         JK9gNT42kNZvtwIRGCqyEtK6F/jvrDb/CCkd2/tGX+iM9avstjmdj8NxjjtAaluUN6hh
         pdR2okxmfU+Y+cJ13COQJe5YRPIeLIc64mt1eonzzXPIzznsGJsVdkKeCLy4hew0xHvn
         1OAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765273586; x=1765878386;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfxmzUUooqkWpOC9gnra+ZEKbDrqCeaM9bSxezRioDM=;
        b=C8hTFu2EcnhlfkPJnIs5dx89NgW1RRoFZAJTN5KJRbXXphxhQvvFjgJhMROG9qVP00
         c08A7RCSJCoV8/nnSiSkiOvyzQD2wu4EIynEVxlZYxXDUYPBRYgeixgyjrUMoOP8z/TH
         pOq9Z4AnwidA+fOKIaNk69AxT9vZkdOdP1NTPGxwQUdAw1LyxXsbg7N+XEqIRg46t71V
         6QxGfF4Fo0XWuUJXnF36oktMQJxwHYQ+JrB6A/5BzPhATklH8UjW9qfw7+M/KDKBgUA8
         YljqJ0NtT1ZQThKuVTAhhEVRyOvipNkwCWj/On7w0PJDRVUR/uhUPX37HGh+AEFSNok5
         jbeA==
X-Forwarded-Encrypted: i=1; AJvYcCU5lsM9mxB0jr5PclgZlkpKNii0issng2+SvryIUkymce96MfBV17129G+7n2b9wHwcdSYpTeGizer7@vger.kernel.org
X-Gm-Message-State: AOJu0YzbBD6nfrNpsVuRio/SaDTUMfNNUfihFtRwQwv/cQkFem9LPCxm
	VcMhedKXOSf0UM0J3TUghbonx1C/kbWnH0jjblTXAghacqlqDwHt7P5FKZrzwEStrcpRYnlwKaY
	Fva0KE+Q=
X-Gm-Gg: AY/fxX5VEWdbddH8PRPqFGv+KzzmpzTUpo+bmEEbFcxpfuprlGz30uLhivUsW4+u5I9
	1Tt4gSltGpoXgzySAz7/Wnx9kMnMA38MW/4g23oaxBD0vdNIodcIUyawWUSa8YdwNvL9/Y3MKpu
	d+57pUIEK8s4GNrmepvNt6SqAzUq2xmc/Xfp7fvZPG4tVo44S2w7+bjZP5RxlK5jniy1Fpqozwz
	CEb7wFUbyPXtaQJaXjmczYdprW/NOpnGbBCAzj0eB9xDDzJHXUIwi3OBNPTu6gpqWg8YsBuGa5d
	yBCWzKOCqZNJO/JIsQrUeRCufSPBTHRnK/ut9MmJDV7fr718imLiZ1oLB9FUbLiJSUSqfgsl76+
	qVBwF+xuWQvNu8ivtvbZ0QF5V8JrDujVSH2jc7oSaI0HrIhXtaRan2IUvl15nY2aZGd+OERhh02
	+AmV6h/VvkZsY24djYSoEEEE2y42g9XNc6hPhmkaRmzwInJ3X+9Jd5tVU=
X-Google-Smtp-Source: AGHT+IFuwmk2xdGIgTR4QMuN31UghMotRLmnNnpfquXV4iJJBSRjfXf6m6sms80zyvq08rvdLu3hjw==
X-Received: by 2002:a17:903:240d:b0:24b:25f:5f81 with SMTP id d9443c01a7336-29df59a8bfamr131500195ad.17.1765273586025;
        Tue, 09 Dec 2025 01:46:26 -0800 (PST)
Received: from [10.88.210.107] ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaac07csm147849245ad.86.2025.12.09.01.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 01:46:25 -0800 (PST)
Message-ID: <dfb1479b-8aef-4f55-ba5b-4ae0595c4f99@bytedance.com>
Date: Tue, 9 Dec 2025 17:46:22 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ext4/004 hangs with -o inlinecrypt,test_dummy_encryption
From: Julian Sun <sunjunchao@bytedance.com>
To: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org
References: <aTZ3ahPop7q8O5cE@infradead.org>
 <80f77860-2d5d-4ff9-9bb8-1e5bc46a4692@bytedance.com>
Cc: linux-fscrypt@vger.kernel.org
In-Reply-To: <80f77860-2d5d-4ff9-9bb8-1e5bc46a4692@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/9/25 4:40 PM, Julian Sun wrote:
> 
> I can reproduce this issue locally with both v6.18 and v6.0. The problem 
> disappears after removing test_dummy_encryption, and it still reproduces 
> when test_dummy_encryption is set alone in MOUNT_OPTIONS. Therefore, I 
> believe the issue lies in test_dummy_encryption — it is an 
> implementation of fscrypt.
> 
> CC: linux-fscrypt
> 
> Thanks,

cc linux-fscrypt

-- 
Julian Sun <sunjunchao@bytedance.com>

