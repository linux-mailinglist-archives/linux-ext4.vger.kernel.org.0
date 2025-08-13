Return-Path: <linux-ext4+bounces-9363-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E753B24BF6
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5626A1BC48B5
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A592F0674;
	Wed, 13 Aug 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OagzIKxm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679811D63EF
	for <linux-ext4@vger.kernel.org>; Wed, 13 Aug 2025 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095527; cv=none; b=nL1S2h8GjaxOzyY/NoxFQ2665YBPcNi8vIy+pkMl1Lr1jhgD2/pILU/kXr/RitXiQ0He+fX0lN9+bP/tRlZcqnYr2jhecZb1mYf0fTtTKC70cV1pm61330KAprb84JviDn8mtQanZbkiPrIPEftHHlu71xWM3uBvGZGdoWlZtu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095527; c=relaxed/simple;
	bh=ipApUWXD/vc+gn0dpjkARbKTGMwSNJWFy53h/IiXXnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWr0VsQSzLQJmPp5rga8RJRFYi9VFJlCLxeduG2CUUM5HNgcCenf36XY+fYrlECItaXEOXveGFcZalOOtlETnkYFK5ahwQASIitemWY2FEQbJCZKQkRs9lz+sHxHqw/WBlfwDLrqVmxJw+lvmPq2vdvBa7UscgapXyTzqH54wcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OagzIKxm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31f4e49dca0so7753694a91.1
        for <linux-ext4@vger.kernel.org>; Wed, 13 Aug 2025 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755095525; x=1755700325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SdEySWA9pjFNhAetIdOe+TeBj+YFSkBbS61Z6xuGeG0=;
        b=OagzIKxmmqyqb3udhiQ9X5ZnsWD902l4tGC1vq8DetSlLgrd6fiX/6jJ5aWzUO0HT7
         1RPrXod7+PDSTjjPFoitGwp20HiGZAdEFGsHo8dZ3whAMwLYQWGNIEOGVcSHMpyRjOs0
         RUQId8z4UfQW7cF5AtY6qbu+QGbRtIy3TlPp4aCUyCCy/0EksNlxUBKYGjiASAaW6IIZ
         ZcoOBfbd6FhhqUdZh6KscUfL4HUo5RomEeu12790Kn6Zr2OoEd8jyX+QDzwY+Sb31dk6
         QMfQSBXeHI3VbV4gkL3sLqfOdbl58htcmv1HP8iQ8qjFLVNFMssDSxTCg+qhZPM7eEne
         VQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755095525; x=1755700325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdEySWA9pjFNhAetIdOe+TeBj+YFSkBbS61Z6xuGeG0=;
        b=fNHhEUWRO+w7H9pxTB17JKi+c8dsH7F4jEbUEcRpkvXibcydtIXiLecgUv/x0ylBFE
         LZHwSyV3Q/2Q491zppD8m67LbYBIsiu0jp+6j6uiDEcL1HEM+g1b16k3R+qu1o1Etn/u
         z07dDiyLAFY4R2i52wzWIydNgoCTtoENcr4hkSVCXcAtXlb86FZgbjz2zTxoAHYI9hRj
         FYggeEwp4MH8rDX67uIXJLz6zEcJlXFCxwV9kZshlo15dduIyOffYmehCx6EkiOAxirU
         yk/dWLAffFagNE5mlrkGDAUKqsS8YhrndwJukpS4jj72NKWGVb14L+MhkC4ZK9Z6dgM2
         Uoww==
X-Forwarded-Encrypted: i=1; AJvYcCXbA+n+N8yltsBho/Hiqsi7nKsuEr2+q34ZNXegzOQkdkghscdA3Q+CrTorRS/BFk6tbGLed5SditdW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0AlY2bY7cbAWAMlBwzQ4aXYP3N+4bC1pqgAolo6EBDhlMRzt0
	fqgvH5rNSHsxxKWFopP88wpuQRfcLMmSR0L2jSv7i5T3Rp0KUpEhqwp78K2SLmPYiDrT9qMtnx8
	RJ1zdsBvYVJVhcOVbFQq2ph+cst9WHNgMErEFSE7Xpw==
X-Gm-Gg: ASbGnct/MOBf6neGkvJn5Ux2gVxUYRx8UWR67R26MWdUe6L5cbVtCSvZlh7fdOsAP3a
	JHlbjto3FZw7tlrujWxkoMJd9krIjiaPqi57BbnMDopGiNsbMni5ZL8yVCkAwAC35w6vuINZ8mt
	2zYlMtJ40euL5TKGRkZga7La/SydQF1mm69lw6wzTaF5VhKhNVTxwkDXNaYty1Sd4QEcdda9IwW
	TBLuHN0EJIBJWy7iVFeHc8Zmf4gFpxf1zEEEUgBsQ3WFRxo9sclo0v6WG3CBg==
X-Google-Smtp-Source: AGHT+IFzsa7z2LB/NwMV+7ODMzwtQZ5c6SDjL/beKBH/4CiDe3n9MltwqzwrpDodhDWNKfzJI3ZmU6XpdnvXzSkeC14=
X-Received: by 2002:a17:90b:39c7:b0:321:cfbf:cbd6 with SMTP id
 98e67ed59e1d1-321d0d6912bmr4596811a91.6.1755095524619; Wed, 13 Aug 2025
 07:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org> <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
In-Reply-To: <2025081300-frown-sketch-f5bd@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 20:01:51 +0530
X-Gm-Features: Ac12FXzTlKbJUDUafTa4ZlpVkqfN8sdY7Wfx9w4NKXTaujZ4mJCVSf-u4y5vZP8
Message-ID: <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, qemu-devel@nongnu.org, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>, 
	Zhang Yi <yi.zhang@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

> > 2)
> >
> > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> >
> > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > to disk space handling in the 64K page configuration on qemu-arm64.
> >
> > The issue is reproducible on multiple runs.
> >
> > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> >
> >   - fallocate04
> >   - fallocate05
> >   - fdatasync03
> >   - fsync01
> >   - fsync04
> >   - ioctl_fiemap01
> >   - swapoff01
> >   - swapoff02
> >   - swapon01
> >   - swapon02
> >   - swapon03
> >   - sync01
> >   - sync_file_range02
> >   - syncfs01
> >
> > Reproducibility:
> >  - 64K config above listed test fails
> >  - 4K config above listed test pass.
> >
> > Regression Analysis:
> > - New regression? yes
>
> Regression from 6.16?  Or just from 6.15.y?

Based on available data, the issue is not present in v6.16 or v6.15.

Anders, bisected this regression and found,

  ext4: correct the reserved credits for extent conversion
    [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]

Report lore link,

https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

