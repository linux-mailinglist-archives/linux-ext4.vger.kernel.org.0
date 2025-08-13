Return-Path: <linux-ext4+bounces-9365-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B52BB24E87
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB5BB63EE1
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B8627A917;
	Wed, 13 Aug 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NirD4G37"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A024467B
	for <linux-ext4@vger.kernel.org>; Wed, 13 Aug 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100737; cv=none; b=rFPOuDg1QalffAomcv5hreiOsUaY7rbFxlLuX4gvzCKQwJlK/kcoivHQkAqQ7GWbSbK9TV/fXodERjhvih4CTZZbME4Q0jJB1tUnVg5Pk5nmH9puSsFXCmQQ9H+gq+Y8urMIIhTs1GN1lX1IzHpjgcznusPZpW5gomQiXIu7DtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100737; c=relaxed/simple;
	bh=JCJTW/Ucx88U/k5zzDsfVlKugMbj9mbeM3mUGqS/nCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4ed/d61zsDd+cdSoKxRwwVOfPXoXY89l5zZY/sxIgD52gXgAJ7S4JipiAE8XdJ+/GWSoIzRdH15Q34CxbyHnY/YHTCS7ieyLgZJN/ILNuoTb0CgibtxKjQRZVdubxO04J6696gzVAEAU3cQWbQYyZASYv1TJ48KRGzBxAQAzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NirD4G37; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b792b0b829so6791453f8f.3
        for <linux-ext4@vger.kernel.org>; Wed, 13 Aug 2025 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755100733; x=1755705533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp6XeG0MyOuXPRX2EUNgzHzmYyd18LTitGQ6mKDCv5k=;
        b=NirD4G370wM0PVwO0+6k38cBSEWnpq4rq435W+rqUERDZ/xul1Lsm8AOr/TjSotCpK
         d70IdvxGMDhGcuquJtiIjWvIQTeF0I/hY1u3kQV6QVe5+xip9cimOWkZ/wi3213JXWDL
         4Fx+rs968PBViKBDgtCsN3+cEr9eTwHDP4zOmg2Y2wpgkha6Ny/+8Z7DGCwz//VZw/iP
         e7d9LaGppCP3QOmW+fsE7rfq97pHDz+pBr1QbLS1H4U7D0ymBzwPpY2s3KEKH8SoENJu
         eGviXitSx6wcnRDPSpnWSulz7yVXy/5PSKXWPLHwM0/frZXd6ld+11GXCfybwXcghy0D
         m5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100733; x=1755705533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp6XeG0MyOuXPRX2EUNgzHzmYyd18LTitGQ6mKDCv5k=;
        b=Jm4ghmbZ/Dkes1hKgWYDVz7pOsWl/8uot5m3XHAR/aaM51cQa/J7v7UPhHGS3kHlRH
         firaWAvX0jhOXqzfgF3TX06/0HItQTAjXG2ICUVDoHbTaoLiHHQsjL+tOOnv4Sf3WSrN
         zkCLI1T/vm1aattQo95UHcbTXtF3/xQOQrQATk29RiNwZzJM6lXN/U4Wy0I/u07LAgJE
         5rP6KcBXj+dBEz9B9GDqvgXfH9M9k71XrOQ0VH3inqvrNfsPgoAYVJGwDIlGy96ZqvKt
         eOPCr6CC4UbKl6hrheI7lWxzMYJHWkc+SqsYo+2Saou3nWvcW5YqER9gkndFHGO/6bmp
         wdJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN2jphC6GnUa17A8BqfyIHljjfvtcRPkVdmXtyf1J3Thh2D5+iyvY8kbbBKQgfGD0Z5L2gKxb2smaM@vger.kernel.org
X-Gm-Message-State: AOJu0YzIyxyhk1xgb8MeMEFCv3TqnKqcPBLNe70p3sD/pJ4ViYLfuFqX
	0XrkP8IaIAZaKLXRcUQIaL8xwxUScOiy9A00CSKaYcUbUTXh2DJnPUCkc0F2feX+Unk=
X-Gm-Gg: ASbGncvrmmpm+kavfoluE2PUAaosF8spiGQg6c3Wm/gSuuGGdHPJOtqrogC8/sweQrT
	552NwBrB7whD2ba8eTIAriBpSySYTjN9q4nuKJ4bRVO7h3EilcxP14Y9go2RP4ZkGGpLuLPSfrG
	U76citFyu7plYRYYdO4TaQKQAmNgwB82wGGvGlhfDZFvILE63fLzmUIaShbJQ1vIjyCwtYWSLmJ
	1BrnB8A4lcmGJHic1P3u3dpfcN0Pv4N1BX2Ulsqy/NpwtpU883DJPWgcFlj4CMdjiCvb9i6E408
	EOjNQIKRqeg++LgoiLh/BW8AQE0AwltbWj6IjbxlE+QElNYgLTnsRZtC3G7ud9d/KDzuwNFZc5J
	NuQ4EFdRDGvFOp1iYpa+1fdXEnHqjoaeI5VtFIFUxtHc=
X-Google-Smtp-Source: AGHT+IFmDnHCSl5CKkyh/D1IvMDkhgbQzh6CQ86Hu6D5gyD/dtG5m2liXMYcw3pmw6tZ+PFrvCebxA==
X-Received: by 2002:a5d:5f95:0:b0:3b7:8dd7:55ad with SMTP id ffacd0b85a97d-3b917f14804mr2882432f8f.39.1755100733462;
        Wed, 13 Aug 2025 08:58:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b91b05b28fsm1789186f8f.21.2025.08.13.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:58:53 -0700 (PDT)
Date: Wed, 13 Aug 2025 18:58:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
	Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Zhang Yi <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <aJy2OVhg4RUYbHHR@stanley.mountain>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
 <2025081311-purifier-reviver-aeb2@gregkh>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081311-purifier-reviver-aeb2@gregkh>

On Wed, Aug 13, 2025 at 04:53:37PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
> > Hi Greg,
> > 
> > > > 2)
> > > >
> > > > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > > > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> > > >
> > > > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > > > to disk space handling in the 64K page configuration on qemu-arm64.
> > > >
> > > > The issue is reproducible on multiple runs.
> > > >
> > > > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> > > >
> > > >   - fallocate04
> > > >   - fallocate05
> > > >   - fdatasync03
> > > >   - fsync01
> > > >   - fsync04
> > > >   - ioctl_fiemap01
> > > >   - swapoff01
> > > >   - swapoff02
> > > >   - swapon01
> > > >   - swapon02
> > > >   - swapon03
> > > >   - sync01
> > > >   - sync_file_range02
> > > >   - syncfs01
> > > >
> > > > Reproducibility:
> > > >  - 64K config above listed test fails
> > > >  - 4K config above listed test pass.
> > > >
> > > > Regression Analysis:
> > > > - New regression? yes
> > >
> > > Regression from 6.16?  Or just from 6.15.y?
> > 
> > Based on available data, the issue is not present in v6.16 or v6.15.
> > 
> > Anders, bisected this regression and found,
> > 
> >   ext4: correct the reserved credits for extent conversion
> >     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
> > 
> > Report lore link,
> > 
> > https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/
> 
> Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
> :)

Lol.

regards,
dan carpenter


