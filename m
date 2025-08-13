Return-Path: <linux-ext4+bounces-9359-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECF9B24AE5
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 15:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FE91BC819B
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DFF2EB5BC;
	Wed, 13 Aug 2025 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvkvDwn6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E82EA483
	for <linux-ext4@vger.kernel.org>; Wed, 13 Aug 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092479; cv=none; b=WS0m6/sA5oNtv2Sm0m0T2jrKgC5Vz5enUw51IR4d9kq7mY47mfyvNSMcea1zQd6lwJQpDWn0+6Lu9bA0lh3+O/5+qoXPAik6CNVC+1Gwf0J/0u1+jfQ7HD7XJjDd6bW5BllvltWDQAvdu5KME/cbA5AYc/6r4wy9xeIDJ6sBGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092479; c=relaxed/simple;
	bh=cAR2FPV/ROme89E5VHNey3/dlly2/gqFm0nN2kQt4sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QGJTOt2CzSnZQwhs/48qlC8gPe8/gdXiR5O2SSbIGRaPW1W7eiVo5S+TjS1kGzSglueV4kEUb9/qoy1cGj8g4EIQWZyvF7VdPPpV4/CttqhMwBDwV8jcEok2rr5kXrpbCZWC5i447TnJxv2+JjS81iRlWuGvCOvZbF3W2QWz7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvkvDwn6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af51596da56so5124835a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 13 Aug 2025 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092477; x=1755697277; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuoYHGYkCh033zSzlMciRVTnS9J8QMWvk5NZ+OdGx/A=;
        b=dvkvDwn6Q69ZDEiOFDSsL7Dop7VF90MGADW9JBQw1QJNXOGwlo+PvbBIYBWQhsi+Hf
         rpIVh5RNYa+/exggyh3FUfaMidQ/OpITp9OFptcW1tIWt8j2nB3zqe9s+gVbo00HE3dy
         9m6STNrujQ5Ax8vh7NLrqyMZwC0GRHbE8GlfgZ2gsJsjHhP/7zGmSv1QY/QzafrG1UsH
         va/iMAC4DFLx2M6+biC8spPoN9lU2JJGP3DSYFxCH5ersoq2EyzJ4/csS4vPtU4a7jSB
         piZoeAj61M+nZ3NAAcZ2frN65DEP2NtiWNGOVogxl7gftDuUfyn+A0j19IHcEIwNSFv2
         oryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092477; x=1755697277;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuoYHGYkCh033zSzlMciRVTnS9J8QMWvk5NZ+OdGx/A=;
        b=pMgyNohL4rGkFFapWrRwFX6XOBAdtd7ScE37vGVkLchiqp73ZsUNAat4xUG9Ua6o3t
         3CdPYIEtOnQnaR+BwSrum40IQ3rNGPL0RsBqp37QgN/d6450XceEgwAfcKoaeX9yvA37
         Hk2m6kjW1DhkBXU2VS6VkQW7JK2T7idI8rstKfdcovxD1IyYI/4DOCSTZNcPZBk5Kqpj
         5dgcC8803XnpGMO0SHrDlLnDE5XcG2CvuzpGQTQh1vAS7qZONis/5aXzbFKhiJWj76RM
         UiWJgqytLciZ6HEXd+N+uMLCVa9+/WfBSkp/ZjyCExUVUD39ONN49gKdswDHV9QuVG4F
         Wx6g==
X-Forwarded-Encrypted: i=1; AJvYcCXDIgZRT6aTfENorTPOtlr1HQsETunm33RB5OsM/lOvySRB2Y2nzJtO0NQg2A8zHnYwVy/2Qb9Bi4eS@vger.kernel.org
X-Gm-Message-State: AOJu0YyngkLdsN0hbd0jNAk1pnb2jrSi7bidC7sPSlfHX2GwiwSyD7++
	xu2IUbxqBsUEo8nds2ZYiwBXCAL+iuLLF2JvgYW/sUFCfXVo03zXEY+tBpcD99hUZucoezi/d8W
	YphmkuRFakjiCH+u/e1bBT0LaUdxb6lY+msnjX+LpiA==
X-Gm-Gg: ASbGncsaUIcN8ourWOqOeOKRuLREWFsAlji+I9MWhk5H/XFwl5AEBc7ZX0HZavItNDt
	yq++J3XyS0BHVsUq12o2a/VXQLX5Ub5yaJNUlERyfxr1A0iEXnxQXfu2uy0MJra1qxRhbpMQLjT
	HWoBYlw8rxMNIFnFhEDUnrvaMA7G/KF/azTFL1fn+ZRuk3OTmFPFD6jnjAWMwXd5/Xkj71jkN8y
	GlW4cnfAv3xfkS2oo8cJr6YihtSo2UYtLvHBOyx
X-Google-Smtp-Source: AGHT+IHJ5NorMBOk/mMmvjq4NxC90d+IjwHZjpyxn70pQloc6AgGTp1y/wa+zMeluJYPNCBvRdh21gvKSjV030UR2Pk=
X-Received: by 2002:a17:902:f785:b0:23f:e51b:2189 with SMTP id
 d9443c01a7336-2430d0f9a4bmr54705775ad.17.1755092476818; Wed, 13 Aug 2025
 06:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org> <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
In-Reply-To: <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 19:11:05 +0530
X-Gm-Features: Ac12FXxKeYVh06szquTrecWrS7rqGYyi8ckXtXfcapehmWdAEuqul8ZUWvjf2tw
Message-ID: <CA+G9fYtjAWpeFfb3DesEY8y6aOefkLOVBE=zxsROWLzP_V_iDg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, achill@achill.org, 
	qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 18:21, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > On Tue, 12 Aug 2025 at 23:57, Greg Kroah-Hartman
>
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

These test failures are not seen on Linus tree v6.16 or v6.15.

>
> I'm also seeing epoll_ctl04 failing on Raspberry Pi 4, there's a bisect
> still running but I suspect given the error message:

Right !
LTP syscalls epoll_ctl04 test is failing on Linux mainline as well
with this error on LKFT CI system on several platforms.

>
> epoll_ctl04.c:59: TFAIL: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5 expected EINVAL: ELOOP (40)
>
> that it might be:
>
> # bad: [b47ce23d38c737a2f84af2b18c5e6b6e09e4932d] eventpoll: Fix semi-unbounded recursion
>
> which already got tested, or something adjacent.

A patch has been proposed to update the LTP test case to align with
recent changes in the Linux kernel code.

[LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos

-https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/

- Naresh

