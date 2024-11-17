Return-Path: <linux-ext4+bounces-5228-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C61979D023B
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Nov 2024 07:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA0CB23AB5
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Nov 2024 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD93D0A4;
	Sun, 17 Nov 2024 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVulAZPv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259B62746A
	for <linux-ext4@vger.kernel.org>; Sun, 17 Nov 2024 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731825111; cv=none; b=YrK8PiJfIcGteFMH02XorOrHuXys/Ym6ftawaiZrlmRAaqlIVNpYEwuonlnt/qeuxr5A5FVG9nikWzt1rXM3s8yBgGBqBnU8r68n0KpOO2b+SfYw+KZeUVhEVvFwRVvjyj4k2R74XAkqU8AzhiCFsykk0k5mLVDdJ0hxd605YWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731825111; c=relaxed/simple;
	bh=yd2zwn0wlj+NbxenpRi9sMhG0mcKte7JQ3p9L9raCJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueEAf2GKdRyvVH4DkDN8XBQkBoXp35IYXdZpXL3ZVP+O4ysfww4mj+L/9cqzu/A6eGPldeRKwoA0Q8En7W8uWsqEASG3egfw9Pa3Xo5VxCHcGx3IYWzb6hMaS7I/13jJ4hQUqA6IflVbyJIDnZGeHN5iv6gyzd1smoQYXMUdJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVulAZPv; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5101c527611so341934e0c.3
        for <linux-ext4@vger.kernel.org>; Sat, 16 Nov 2024 22:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731825109; x=1732429909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1KsO7fhbqBh+hX2RZRKwEK+dIR/PJ/dpnv1LOiA+CE=;
        b=FVulAZPvmImIALOBcYrIBXYnDHCjFqEfgOdysA9WqFPq9RqRuZqOvXSciUvbvwPJj9
         pipBjHPy5rn3Qi0IDDAIj+SlrPfFCtfdyqazOiichxmigyGODA/uFZMP4IR/rnkbef1A
         B9mDTxS6mB4vg/+d8nWk2oeHKyM+biDrExxG2lbSGOUK6d515EiHa7B7dlk8VAVVQgwW
         m/GrDVpv7bpxo0AmgrJD6I4Q41EH8+h8W18yxy0lorzc/0smzPISD9WecpjM9zYn/Orh
         QFyDBUpTMBju8BzbjVKEUMAS0WmdXlFOon86mPlPhtF/rqb3Qr2cU+iTcN4/DWVIw+oK
         qGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731825109; x=1732429909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1KsO7fhbqBh+hX2RZRKwEK+dIR/PJ/dpnv1LOiA+CE=;
        b=eezQuKyWAjebPrQPx4aQPdpTcXIdYFDKwu4ST6xN87GH6UGoUd7XU9b+YFm/Z2XPnZ
         TJwc/eE7/LuJXi/vAyVEjSJrveBX5dFFYGEp8pYSfeC892mJpeSoOhvnq8OwetkfOqLG
         DITCTLgY8l3hH/W9yD1oLpdZEv1L6MjLM/U0VL2/ESIGhfFkVO82YodxFWGuOnutpMfc
         wTv1+++OY5I5t4bVSLWHl8n7xtwhIxUe2sPt8NLifxaCyH6HJCFTq6xFl7tlSthXVhQ2
         ymkbmzVEN//yPFoCIgf+D+VOWO//aDj4SAK9kfzlSebIC8taJ8CC1BdByv8SCp9zg09c
         /xrw==
X-Forwarded-Encrypted: i=1; AJvYcCXwL5305N5NkDQEOEC4FtmPiajn9GruaO/2m3cCPMnqVtfKoWkMATSH2ar/fKyb/5mvoO1aCU1kW3mP@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIet7Y5XtAxteoOZ6zboJeCsj/UGz12MaHav88r+G7xnhvqLj
	U79FYUqJnJsNY8O05RC8cHoPSFgj51HCPFo7XCndeu/6Wd5b0wsYF+ArrfIGklgIfhT4KlfeIi8
	gqP5B22wkphBgLZiQ0zmhsVvsG6e5I2JKXOJf/w==
X-Google-Smtp-Source: AGHT+IE0wjqTMn8vWA+CUqA+H8uhTPOUX7xVAI/iXRb8BGy44kgJ/lwA3+K61804buL+g42069AriVPGWNBQWHsrA9g=
X-Received: by 2002:a05:6122:1696:b0:507:81f0:f952 with SMTP id
 71dfb90a1353d-51477f7c9e8mr6385384e0c.9.1731825109088; Sat, 16 Nov 2024
 22:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvVAvEBbFzhQQ_UBf+PYMojtN1O4qHKXngu33AT8HqEnA@mail.gmail.com>
 <61473df2-2ea2-4dc7-94a1-5e58ee02cd78@suse.cz>
In-Reply-To: <61473df2-2ea2-4dc7-94a1-5e58ee02cd78@suse.cz>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 17 Nov 2024 12:01:36 +0530
Message-ID: <CA+G9fYsLZeFtoA6-7CWpezAuCBMLq6jS-=XQMFKPHrypBP+KfA@mail.gmail.com>
Subject: Re: ltp-syscalls/ioctl04: sysfs: cannot create duplicate filename '/kernel/slab/:a-0000176'
To: Vlastimil Babka <vbabka@suse.cz>
Cc: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-ext4 <linux-ext4@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 02:25, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/16/24 17:50, Naresh Kamboju wrote:
> > The LTP syscalls ioctl04 and sequence test cases reported failures due
> > to following
> > reasons in the test log on the following environments on
> > sashal/linus-next.git tree.
> >  - qemu-x86_64
> >  - qemu-x86_64-compat
> >  - testing still in progress
> >
> > LTP test failed log:
> > ---------------
> > <4>[   70.931891] sysfs: cannot create duplicate filename
> > '/kernel/slab/:a-0000176'
> > ...
> > <0>[   70.969266] EXT4-fs: no memory for groupinfo slab cache
> > <3>[   70.970744] EXT4-fs (loop0): failed to initialize mballoc (-12)
> > <3>[   70.977680] EXT4-fs (loop0): mount failed
> > ioctl04.c:67: TFAIL: Mounting RO device RO failed: ENOMEM (12)
> >
> > First seen on commit sha id c12cd257292c0c29463aa305967e64fc31a514d8.
> >   Good: 7ff71d62bdc4828b0917c97eb6caebe5f4c07220
> >   Bad:  c12cd257292c0c29463aa305967e64fc31a514d8
> >   (not able to fetch these ^ commit ids now)
>
> The problem was in the slab tree not fs, sorry for the noise:
> https://lore.kernel.org/all/52be272d-009b-477b-9929-564f75208168%40suse.cz

The reported regressions have been fixed in latest commits on the
sashal/linus-next.git tree.

- Naresh

