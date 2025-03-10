Return-Path: <linux-ext4+bounces-6759-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D786A5A6C8
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 23:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7BC16FBF5
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66F1E520E;
	Mon, 10 Mar 2025 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkNae5p5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896581D514E;
	Mon, 10 Mar 2025 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644769; cv=none; b=KyKyqXVAUQbuCzDJOpHo7s4ny76LsDvW38FjFYqqj+T4+uHQC1dAjvNlJ7XRXOPJ4x8Yh9t/D6skMsjRMejqbYPY3x9Aw/lE4w9cTbaxA1L1YcqhRf/I6MBLavfbBomcowt+VHMzb/A+BpOGnJFxHAF3vQHoEBwtMRTwFU6ENeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644769; c=relaxed/simple;
	bh=lTyqSLVLZ0kWBMHA53v7K6UIdBAn3oBWgOG9pMZ6oR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdAt8NPQBvHm6TAgW14N1LQKYVH6xeM/x3gYFIdp81esHa3HyMMjPNkpwsK3T6mtRE4UeZtSWKeFKqIwpmIMyc47tgGcNW4nKPnEo1x7fT5e7IQOwY47qTmQMhQ6KOowvsQetcmprqz0vl+MaT1V7GtDaRxdb0MVWiCXpCF00kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkNae5p5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-391342fc148so2193431f8f.2;
        Mon, 10 Mar 2025 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741644766; x=1742249566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcVXYzW6QMhtHVD+R6znA27GOFN+fRqBX35PKQ7T1MU=;
        b=OkNae5p5lGO5GI4VaWE8vnju2ITKA3PWiy0mc8lpu+4bHxXMCuqEIp2blEYR564qf8
         TVdX/RJVp64BTz83p0mt6R5TsN5XwvGoLlyAM0EbzXUl1M+oqFRl7qpkwLdrQ+L+pWyu
         y2IH9LMeG6f1e9NI6dpu9vMyLLX1czTCVZrSkAzDWtsVzAkHo23LnGM/bWqhQtzetjse
         q7YBYURZPLSA6RUJN/JveFOp4W4qbNpvhUKH1vO6y1v3R9UjrgW3cM1MsfESrfRBpb5g
         Q4/gVLgARdHUCam2YAztkc/g239tXwf9OgXkK99LhA188w/PVnRUJsqa++NFUtQQ0wj4
         DTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741644766; x=1742249566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcVXYzW6QMhtHVD+R6znA27GOFN+fRqBX35PKQ7T1MU=;
        b=jncG0cCHpkB4affNFgekBi08wIXWvy6rnMb8aplLFbUYGmUp9XtdWOtgdXKu21mXSh
         WxrQC3GIhqvCC7UgpI4nf9RYKn0dIxuJLszNJXy46akIgzgU5pJBE84dVBj/bC1W0IvV
         ZWgbgQ9geaRpIIYOIlzVWufbVtKaT/zFvEqEKvtEa0eABQibOgQYG7/3E0ld2O2v06DQ
         Lvx2QiDJAFNirJ2mI4dHa5tWgy51DJAbX2gNxQIjTrOtJejOBHPH94/xnpGbQQkT458q
         ftLTGbkxFhXIA9N1S91WGDVuvNK4mS9uLoisOIBO39NnCYor9WLEhVCw5vkKXEKyegAN
         Ickg==
X-Forwarded-Encrypted: i=1; AJvYcCX5PAK9LGq0aYBqVBY3H9znLRjq/rWu98Rw6/8rTHhYThhoxHqldwrv1cnpEG3SBW2zemDy2qhKOQLn@vger.kernel.org, AJvYcCXUcIXD10c9MgKsKKe582LXPME402aNugdjDptl7Vwp6xvLFFL3n1h15r3fmma5Wx8vGhSuoxfF+n8AMNfw@vger.kernel.org
X-Gm-Message-State: AOJu0YxwkjebyT/uaSVJOOG4wtkLcEsJQyTXJ2WDJyoSosI7SS8gTgY8
	ubPlQJJY0eEXVqcIswAvRBQuASM5Vm/0UNZWid4gzWtKl++YWgJ5
X-Gm-Gg: ASbGnctBIsfyBIQF+F630yhxEesiHI4GpWOGjNbdByABVfmCrevGVYSXNMN1yU6TiK3
	K62mnskOy82nvTAuvYZDU8gw+KaYQkOL6Y1FZhBTya+Rkxwivs/81eqaRBbLzz6BWzU7TCqCTcx
	SdtpEeEMKXKVmo8cZGPble8BRmKOxY8inMed8Nht5au+x4Fvd1m+3jbUqxLhf8gUnJc4Gnb8Bom
	5m0+Pz4yztWKC+eQiZ8QBh+lMBmFWtvDZivmTTeIkFVlJzzmErUnPJ0hCf+EmoQZ70Pj0FAXuWU
	fziq3a4iiMK5CTYsMEocENciBW4K1IwLZ/5DKeM5oQjNOjgos3cHdQAua2BiR358oj35kuS2/Z8
	vFQeaLYo=
X-Google-Smtp-Source: AGHT+IHGRnGHmjeW/QrfiL1VK1BAnH7qXDOZkSRYFW1+/V2MmFUb9TgOXFcqlPCSC6bj7yZ+Hxrp3A==
X-Received: by 2002:a05:6000:156a:b0:391:3fd2:610f with SMTP id ffacd0b85a97d-392641bcbfcmr1696778f8f.13.1741644765695;
        Mon, 10 Mar 2025 15:12:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2b8bsm16226413f8f.64.2025.03.10.15.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 15:12:45 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:12:43 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Artem S. Tashkinov" <aros@gmx.com>, linux-ext4@vger.kernel.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250310221243.0d5db7b3@pumpkin>
In-Reply-To: <20250310135828.GB8837@mit.edu>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
	<20250310135828.GB8837@mit.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 09:58:28 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Mon, Mar 10, 2025 at 07:26:00AM +0000, Artem S. Tashkinov wrote:
> > 
> > Why is it that the Linux kernel supports reading btime, but there's no
> > syscall to change it? At least for ext4 there's the debugfs utility, but
> > for other filesystems there's just nothing. And even debugfs is not a
> > solution, since it requires root privileges and an unmounted/mounted RO
> > filesystem.  
> 
> POSIX and Single Unix Specification also doesn't provide a way to
> allow userspace to set ctime (inode change time).  That's because the
> definition of "change time" is defined to include the time to change
> anything about the inode metadata --- including the inode timestamps.
> 

I'm sure that hadn't used to be the case.
But as some point the 'ctime' changed from something that was usually
the file create time (for some definition of create) to a pretty useless
time that is almost a waste of disk space.

	David

