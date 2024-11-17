Return-Path: <linux-ext4+bounces-5229-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F879D023E
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Nov 2024 07:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D103283445
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Nov 2024 06:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE438FAD;
	Sun, 17 Nov 2024 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPdLBZA+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EAF26AC3
	for <linux-ext4@vger.kernel.org>; Sun, 17 Nov 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731825142; cv=none; b=mJzXnBn7ZN1G93A+T4Bmi2YCmBlJtaLneUw7Fb3ZZ4hVcFC1FUdvFDEhxkm41xNwcUkkwXM+C5snV7PnjZxrGehrzLZJobB/aPXwIGNcmL5IbgybuT5LsuQfeQYw4P2rOMQSTgr8fFR4vSMOmRQBN43pMHOX5kzfGCdJU4yk6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731825142; c=relaxed/simple;
	bh=js5ER6/mUai+uomy9jo/Q+NnireaZP5PHNtj0eg7FsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlYGaTXYj+jk3JOYSbNdxGmoKqp5wWqdqANaq72OGrFCg3vCQDFxoxPASB3YDijpl/M3FfdVBDgNjR/05TzbhJETyk/GWaOALRNXQeb7oUYXkROBjSQPGiLEcOSAxmAWe70AWhVFo0XQZGALtzHwUF2Lkf8m3ulFk4L7aWTvcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QPdLBZA+; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5142468fa79so846294e0c.3
        for <linux-ext4@vger.kernel.org>; Sat, 16 Nov 2024 22:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731825140; x=1732429940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+7qSc1fVHmPer1xJUptlyE/yxio3bMTRubjYEAtyecg=;
        b=QPdLBZA+3gO9DF5mDLfaCplY9+U1Wgo0jCtFAYv0D/59FIbe8ZCTOagQkIbofwT35h
         WWwVU3AL/ZNYzUV3Js2bG7dggN5bf+h+e0hPH16rHP7ko2my9Ibzw/cQuuTVNE5Cszc3
         Xr2YNIZmFz9Gb9w8OsnkJTiVn6uOqSxf/9QzC9jp56GNBTMOdL60s8juoxEJRsZRliJR
         0NaIsRagm7qAHBJDA0lZGHwhWNgTaBC1AATISUlEjZBf2VWaJQGX4kLRuffuXiDQBtI5
         jCywYg0LvdH8g/I8qHamEvaX08wdM6Wa3OeL9qm9S7Sv7U8YfsL4cBtFlBoVv22bukbA
         xq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731825140; x=1732429940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7qSc1fVHmPer1xJUptlyE/yxio3bMTRubjYEAtyecg=;
        b=j5aXr2rUAtTinUGKj46EtZNZej0tInTfsCvJwJb6ww9B8Ik2qKj5/bR4NgWl3znrAR
         1fomaYSYQzMcxlwgB4G6YdC2UZP3QcyreS88v5y0ZkyljmPQIS+l4JmZouSzVSiJJIbp
         ij9q3jeydA6y+ICSiyyctnUIievQ/IkqaBc/SpEDjVOBczjk/LU1KqO4RWjFNYqiVfBA
         P7Pz6cOIkqlCGRJhG3S76d1HdEuxKGUUE+yvUy0+y054LLySIakIKw3v0o2MZNNSeSHU
         GEabiUvQosoEIDV9aAiDwMUbSkvZ1f+u7h5QX3NEJXSrSe7mxdJYxL/6EH9tc4JZrXJ+
         aG+w==
X-Forwarded-Encrypted: i=1; AJvYcCX7UnvFSHIiZgRTAbZsqT7pGt3lR4yqhaCXJdutZP78Ep0m9WdXrc38vh4sUqKtUOySV4swJyCv/xNN@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZL0g6uauM2ZuzI33PLpJUV0U3uHuerfFi/IAjofLwGd4VzSL
	g4ItfyY6weH9dtGtwOEJY1OURIoOeSkYXzOOZMV6DJbF2O3TbdVdrcrypXzNgfU6kKKgnX4FyDe
	Yc3H2Xgs7wx1bTScfd8nn3dPgPSmdyWuN7mxvdQ==
X-Google-Smtp-Source: AGHT+IGRh8YruUGu07jFRPzp370nbfvg/Y5tJl8pnw3Rt1hrLahShOnGJFL+33z9fqviT6zuUFmq+IrxpExykzDX1MM=
X-Received: by 2002:a05:6102:e08:b0:4ad:5beb:4048 with SMTP id
 ada2fe7eead31-4ad62d5a317mr7754717137.24.1731825140429; Sat, 16 Nov 2024
 22:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs9R7DwZVkA_MRaqWwrfuuvZ-3wMcYuk3oHA0prN3bKRA@mail.gmail.com>
In-Reply-To: <CA+G9fYs9R7DwZVkA_MRaqWwrfuuvZ-3wMcYuk3oHA0prN3bKRA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 17 Nov 2024 12:02:07 +0530
Message-ID: <CA+G9fYtTgghGirzqYmRFtxjgr_38Tt4oLvcyjEinqh41UVRqnA@mail.gmail.com>
Subject: Re: arm64: __kmem_cache_create_args(ext4_groupinfo_4k) failed with
 error -22 - Boot failed
To: open list <linux-kernel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Nov 2024 at 22:51, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The qemu-arm64, qemu-armv7 and qemu-riscv boot failed on Sasha Linus-next tree
> due to ext4 crash. Please find more details below
>
> First seen on commit sha id c12cd257292c0c29463aa305967e64fc31a514d8.
> Good: 7ff71d62bdc4828b0917c97eb6caebe5f4c07220
> Bad:  d11b462aa01e0ffd5f8cc81bd5d2cfe4e48c8fbd
>
> qemu-arm64:
>  * boot/gcc-13-lkftconfig
>  * boot/clang-nightly-lkftconfig
>  * boot/gcc-13-lkftconfig-perf
>
> qemu-armv7:
>  * boot/gcc-13-lkftconfig
>  * boot/clang-19-lkftconfig
>
> qemu-riscv64:
>  * boot/clang-19-lkftconfig
>  * boot/gcc-13-lkftconfig

The reported regressions have been fixed in latest commits on the
sashal/linus-next.git tree.

- Naresh

