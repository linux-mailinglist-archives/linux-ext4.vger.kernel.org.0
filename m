Return-Path: <linux-ext4+bounces-7181-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B186EA82CA6
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 18:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E548B8825BF
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3826FDB4;
	Wed,  9 Apr 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1k3vKS/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8226FD9C;
	Wed,  9 Apr 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216463; cv=none; b=qbQZqZSgpMEy4LQq675tvtoqpXShIizq0wCxuiO6GmJIXOGDOM0+8BLIw+wGCeR4A3NCNTAyFvh3GaGiZK5DtluSn27GrZdwp9DNMfTVa1y2VdMZE9xMxCBxI8CkOn4ZUm/GByHQ+dnCi7oylYQ557E27mF7FN7R9AkeVc3AUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216463; c=relaxed/simple;
	bh=EremEWMasVlJk3LTL6PjVKmV0xokZhfa/uoTRrk4g9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIFgDOGMgqP0syJNaIvhv60NgX5sBTO19O+Ugk9fjgUdGTskv2kp5PsXTGgV6V4qihovcziT2CulwlYbp5IMDyZjv90ocjJwPtPMrgIlbauXZ2FKFT2YKZBVULuY9Tohw/pNthHogqKCGrLChNM8E/wyYD54TG8kNefa9Ik/VjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1k3vKS/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af55b7d56a1so5157539a12.2;
        Wed, 09 Apr 2025 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744216461; x=1744821261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZ2C8tIFmAu5kEooWenazNsrY2NtLDuu+KlEV618Zn4=;
        b=M1k3vKS/JdcFzSGZCVYYE3OQFy8bYwktVPmnPStqyc32NuHndrc7cYOd1CO9tTED4W
         PVqbqc7FqmiMmrOzD0+emOUT1f6krw1y3CeV556IhOCONgXtwy4UsY0SnEwidTcV9ohp
         vryi14YCqNLFNLw0dm6h3WhvIMOb7cxqNHrfNoJ0B6AhbFnfrcHossHK+xbZOoctucKk
         2/9baDX3OX0yIsW4LUvdeHFIV6f7ot9lnRxFCk9y/2WAvI+plpUteWeX9NzHZqotXhjN
         adCNSbn3errKtbMaGV92JLFwxpubm2BmzaiKK41YETTg6kA90Ey5+2bEdQGXF0uGUcg8
         Fbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744216461; x=1744821261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ2C8tIFmAu5kEooWenazNsrY2NtLDuu+KlEV618Zn4=;
        b=MnL1hDqEV9K/fNto5xohbQB3KTWUwfvUR9yTCrrrnudK+lrCBQDX7APgYbFpxySjap
         ONP7gjnuqJgyX5qOH0tIO0RxmiFDE0jZcgEsU56nov9GbHGyeEpm5fctNvc3TwHuh9ZD
         8l15RS6gcsaloq3LgqovoubHMXRkQW7E67r4NIPEK0Eq5GuLrGGnruy2bYpxa/NcxaAy
         NewuH+NANe/tIQwXy8/VuoQlDe/iQp034WdBtNYh1aMKUVt6rKdL7u7sH8cHmSRS/fLH
         qOFIDmtQepIv1zA2PSxE2YSYEEa6+uNRxSbtlIgdW+T7eOHF0+rAnPtT6CSo5avLjGwD
         4pDA==
X-Forwarded-Encrypted: i=1; AJvYcCUrxkFTBnI/O6pK+JP5RB6ivK74JPlhss61TPM+L63yaqnKejwV0tCcL2rh5LWUJ+XSgrilBslHrj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2LyXiqiK/ess9hCaFU1x2PcfOhmXkvea2udNGMCtXTiZ70Axi
	o8h1RPrOecigmxYLuytplskQOo9jy7Lp13PiUx5P28C07zZGG0VmLSr+xg==
X-Gm-Gg: ASbGncuZlsjbVXMMumzLm8uDI8gWuhegkpdE/3bgPRVZEz/OgAY1VcgP4N1KKEtD9aY
	MaPKKME04dNt/od0J6C2zMvljNbHRmyEBqjBYvUZ34Y+MtXFiDm81xoSIVsee0T0DfLEgz8tgRM
	/NuxkW7FFs7G46V5lS7cpJ3tNZ1nu3ufrZs9MG44A5vsuAEiiRWg4i40SynoLFKRe3op1bpcU2+
	Sxm4JAIWkL8tYpeuqn+d+35ElBzmLauoDyl76ZTSKmTFy0oqHcEjtokij31UCeyBFcVGyvY0Ot+
	YlFu59RCKNNRWnragYPAnA4ZcYSesWXLF+Il2QbWp1MaD7CfX3+CdsYv1MIPTwHN27nRCY4SQni
	mSuzEfGwyS2mT17srd8FqImQl
X-Google-Smtp-Source: AGHT+IHvhfLK8skiyLL79m+oiKF/yHha0xeNSGpW2szrTw8cF1fKp/yNKAOHWUaSovtXFLX3dJ3xLQ==
X-Received: by 2002:a05:6a20:e306:b0:1f5:6e71:e45 with SMTP id adf61e73a8af0-201592b0deamr5439456637.27.1744216460818;
        Wed, 09 Apr 2025 09:34:20 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f2a:4b1d:fee1:8dac:3556:836f? ([2401:4900:1f2a:4b1d:fee1:8dac:3556:836f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf1d6csm1460437a12.18.2025.04.09.09.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 09:34:20 -0700 (PDT)
Message-ID: <5fe56381-72c4-41ed-a4b6-d13eff1e427a@gmail.com>
Date: Wed, 9 Apr 2025 22:04:14 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add support for -q <n> unconditional loop
Content-Language: en-US
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org, david@fromorbit.com
References: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/3/25 14:28, Nirjhar Roy (IBM) wrote:
> This series introduces "-q <n>" option to support unconditional looping.
> Along with this, it also brings some improvements to output data both, in stdout
> and in result.log.
>
> -q <n> option can be useful for fast unconditional looping (compared to
> -I <n>) to test a certain flakey test and get it's pass/fail metrics.
>
> This is similar to -L <n>, although with -L the test only loops if it
> fails the 1st time.
> The individual patches can provide more details about other changes and
> improvements.

Can I please get some reviews on this patch series?

--NR

>
> [v1] -> [v2]
>   1. This patch series removes the central config fs feature from [v1] (patch 4
>      patch 5) so that this can be reviewed separately. No functional changes.
>   2. Added R.B tag of Darrick is patch  1/5.
>
> [v1] https://lore.kernel.org/all/cover.1736496620.git.nirjhar.roy.lists@gmail.com/
>
> Nirjhar Roy (IBM) (3):
>    tests/selftest: Add a new pseudo flaky test.
>    check: Add -q <n> option to support unconditional looping.
>    check: Improve pass/fail metrics and section config output
>
>   check                  | 113 ++++++++++++++++++++++++++++++-----------
>   tests/selftest/007     |  21 ++++++++
>   tests/selftest/007.out |   2 +
>   3 files changed, 105 insertions(+), 31 deletions(-)
>   create mode 100755 tests/selftest/007
>   create mode 100644 tests/selftest/007.out
>
> --
> 2.34.1
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


