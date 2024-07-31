Return-Path: <linux-ext4+bounces-3578-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D28943469
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C8E281368
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5751BD516;
	Wed, 31 Jul 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a56fyTbl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F51BD511
	for <linux-ext4@vger.kernel.org>; Wed, 31 Jul 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444590; cv=none; b=LSlnS53G1NcCoBX2UaIispmiNDDrKdUkfYNJZDCKUCqZA1oBeG19Pp72/210oDWy204ti1PTAj8gbljkq6Jy/AXgoq1si2VbI5czEs/IC+GCsjzBKViMOwP3hBVh0VuArGu+4yDZ+GuOkImrDmD9jA8lGGI/cWeWuf91XTrAWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444590; c=relaxed/simple;
	bh=8COUR4jon3L8f5VLwM53D1JRLAKJ/oJmYgFrKUa37Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4ecthceMW+wHKxrk/fTgsO1VLz3cHu5xMraXJwvXebbKUCKydoOXsiuSJs75c13JuKVem0LQ+lKhfUQdkBpYw/ar5CQeofKOWk9NXzzQe12naz88erFOtCJyHrwvAra50RHIL7nKYfc43ez5RbHhGcW71Dny6nd1vHD6Jq4PNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a56fyTbl; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-812796ac793so30525139f.3
        for <linux-ext4@vger.kernel.org>; Wed, 31 Jul 2024 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722444586; x=1723049386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9Gf2Q4Tk9nOZbWGuUSF4zfICmpYu5ZWAJDD+PJGym8=;
        b=a56fyTblju1VkljlT35HghqyruhAehBE4lbQnJMn+CsQjocg/d03bB8q3RUQOKcpn8
         2228aW18UJc+BOS6DSknq3mu8oJCvsVuZgAz8fNjeSJA8pbV6wlxhT+Qe4c7YblZ/PXW
         nNCCFwYlp1iZEKv7FLGXCb4v4cZEqTpPlTHYSYu3q4hJPagybOlBY/Zdl1elSpCHMAS/
         Fy/FpDfd+DmmozEoYf2c4t4jQMRiTRTvXmGRDsqVAMmiOZqerp+p7MviqkezKv4d3Vue
         coVIfiSMuaSW+dbK95Y4KLReWrbe5NlxCfP6Bvp5uX3bIXl/CK4mNVuqMChS4bQ44bm2
         EP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722444586; x=1723049386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9Gf2Q4Tk9nOZbWGuUSF4zfICmpYu5ZWAJDD+PJGym8=;
        b=dJMmb2P1wVO3J8OqYRDwXXLWEyfv7i7n6SzY7wt1fVZnQWEqhWiike5MGLt0hFlecb
         EY/fOMkYdrbCBIABsm/Klg/hfQsCZztKDDqC6prW6FRImfANnw6skOPjRjG9eWnnnZLx
         S3BoUShCHvgKrhmWiQxFfdBUsj1SMH/HgHKmF/5og2pHLTe3osD3fLry5hFrDNKLYzHa
         3zKDWnlQTlBOslbsnkNvgVc5FV9/yh2eNaUqB/c1cxbm3PIhux3/F2B/mpQOJ4QkmPCj
         ASMDyrAOj98g02Zt4zrGzDbNnQqsUNBsVO7dCczmk2x6JGrJEvprwltSbPjxc8EZv6g+
         J28Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOoeqQH8ONqzGGeSQTEZ93sdW6psVqDkKyQIUzHB4BbIBYCu42BofR+ebqyIFNWvWlcuCGPKOIZP6u@vger.kernel.org
X-Gm-Message-State: AOJu0YwatWX7x1bIrJPnTywMM7ZhbOYAgouU9dtBpkOlwC8GuVwwVesM
	La7WK4pi3kSWWc9lw4P9MMtncXkERX3HGluCWJVsmJwyifdv9jVGhR7c9So0QEc=
X-Google-Smtp-Source: AGHT+IEk+lGB0Kz5JVSDo0ASBT9BQfvixOonepbfiFsTxqUQPKZroqdGrUESKpSIwV9EY/KvPOv8jA==
X-Received: by 2002:a5e:c116:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-81f92194514mr1019042139f.2.1722444586625;
        Wed, 31 Jul 2024 09:49:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc0a133sm3243209173.125.2024.07.31.09.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:49:45 -0700 (PDT)
Message-ID: <45a5132a-592b-4fcb-abaa-89cec26a0334@kernel.dk>
Date: Wed, 31 Jul 2024 10:49:44 -0600
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20240730151615.753688326@linuxfoundation.org>
 <CA+G9fYuGGbhKgt6dD2pBCK1y4M3-KUhPZcw21gYtUFzQ32KLdg@mail.gmail.com>
 <ad4543e3-53bf-4e2c-8a3c-1e21b9cfa246@kernel.dk>
 <ea202d37-7460-4e45-9e19-6a2b23ada0a0@suswa.mountain>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ea202d37-7460-4e45-9e19-6a2b23ada0a0@suswa.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/24 10:46 AM, Dan Carpenter wrote:
> On Wed, Jul 31, 2024 at 10:13:26AM -0600, Jens Axboe wrote:
>>> ----------
>>>   ## Build
>>> * kernel: 6.1.103-rc1
>>> * git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>>> * git commit: a90fe3a941868870c281a880358b14d42f530b07
>>> * git describe: v6.1.102-441-ga90fe3a94186
>>> * test details:
>>> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.102-441-ga90fe3a94186
>>
>> I built and booted 6.1.103-rc3 and didn't hit anything. Does it still
>> trigger with that one? If yes, how do I reproduce this?
>>
>> There are no deadline changes since 6.1.102, and the block side is just
>> some integrity bits, which don't look suspicious. The other part this
>> could potentially be is the sbitmap changes, but...
>>
> 
> I believe these were fixed in -rc2.  We're on -rc3 now.

OK good, thanks.

-- 
Jens Axboe



