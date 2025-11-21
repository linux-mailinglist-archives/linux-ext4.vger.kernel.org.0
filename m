Return-Path: <linux-ext4+bounces-11992-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8378FC786C1
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 11:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42B424EC665
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4EC34886A;
	Fri, 21 Nov 2025 10:07:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ABE347BC7
	for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719666; cv=none; b=RWfrQ75HN0HaQnKhYv3ybcWt5dbDiC1QadHwV0WrXuLvCPRaz4ha7W0MZkp177yze9jthIbDYJ76is1XcyaLGiM8KgO/W44TS5WtFYgpVeoREq+9Log0OqINAItZdMJ0fAbvE9DezYeN0WYYZq7owkCCbNuAewLt80+2Xs+SZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719666; c=relaxed/simple;
	bh=V9KhnxJVeDaCZq6zHSpU3qk83+Nk3B97c2ewV4vRfXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rutwOVkTepm4/hDv06EE1+uEn9wYp85fNnjfh8FCVsTPTqcTEX7CIhk77apn3VwLAKoDCqB0eNuUqUXhwwrqVTz7gD+3QA9oEiPgv9VQHsFZVbXRG9vViZt+vZKV7VofCl6lXk0eK5J32V1myBxizBOZzG4Ic+YNhmPogcJoPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d758dba570so844146137.2
        for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 02:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719663; x=1764324463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZbBe/ThurAADsMV6qfsbx/lHsHAAhMbty9lujcUMQ0=;
        b=ejAqJ07aZ+vPzDhpJKtZ1wKRB6dTeMfJeVtkIcz4yCfGwnIHtH7T38sXeEl11U11Sd
         +cfmdzktxMxv8IdLIj76xCvibP/iN5/qBVLB/pRK/MbySZBakODXaS5Z9oWVK+hPEj84
         TnE+2ft2CuFULpcMrg7B60NczJlzm/uQCDmhJOLz3t02d8xnlsPs1BlzurWvSz0SkTHF
         vVjkhN5zgop5k3JJZfFy/8HTGTm+rej+w/9xAy51FO4oRKmATScBr958UGkWkZ5b8KQE
         a3MaLaWYiJ8fYRE0aRqT75PyxWmRuvyEWpz7jGhoxHDdvZYeLkE7N9J1c/ch4rnvfK+f
         snYg==
X-Forwarded-Encrypted: i=1; AJvYcCVWZ7bk8C/vxzSPaAugwCp5odSdNl8fiQkX7v85d9T7Kr95siTS4hXUoJwwFTfYEZGqRvoIrta1zhvV@vger.kernel.org
X-Gm-Message-State: AOJu0YygwiXa7NHX3Hhjkp0sJmIsgoXbgkkCafmX8R99oNqUw2hAR048
	el7wI914IZahmh/IVxzcgivKqsB/a1+AgxaMitM0yIoL5YSEkREO/3pU/cEjn9ou
X-Gm-Gg: ASbGncviV9MZCHAuokTTJf0CbiJQlhY5s7xt/JkfXLqgpAQzwSDpivA1cfu/ZRSjNMv
	A3qEt/FjColK6d0Ih1j99KdSXdPrOjWZljoOnTdw1a0XYwo8V/ZcaDkPT2e2TQqpUdyS+S2QMEE
	lxN9BAbDgMvioi9scn/v2bDi79htIGvmc/GUr5Lq0Z5GjQyh1yZGM4ENZL4bLzVoUdkS/r66Qth
	w9lwdqkst7k+b7EnMsUveWC9TUcCQXpmMPTFriFPZ7Dn6aH5yDzfu/fuvfrHt7Sv/ijfMNwlkZL
	QhrKgdK8ZIxj8OXkTpr33Jar7qGvhjvfkodXpi8so9UYFX8o50y2z/cK17zQzv/aXZj8Ay+ICGt
	X5phXh4Ajyr0bXAf+nrUNTHCucM9lWEF+9/nstHXlZS7XujglMQCZnCv2yZDnHukTF+uHHb4TMC
	fYw6eQXG4CUnpiYlOLCSE4h58jVgH3bOHC0XvMwK/YxCzPN7P3oVG3
X-Google-Smtp-Source: AGHT+IH24N8QMPa1EbjccdrKdE/aYH48vn5TstC55Gnq7eJR0xajE5QnpJ/EoLx3M4ftyJsIvBtcRw==
X-Received: by 2002:a05:6102:e0e:b0:5df:3b19:4125 with SMTP id ada2fe7eead31-5e1de2695femr330793137.26.1763719663205;
        Fri, 21 Nov 2025 02:07:43 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c56276527sm2054607241.8.2025.11.21.02.07.42
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 02:07:42 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-559966a86caso499818e0c.2
        for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 02:07:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2AKScIrWwFy2s9cUSZE7BSE6OomsLmHH+7VygilMCTgzi/AhXFmlKvVf03q59x4srlSQlHP/bDr5o@vger.kernel.org
X-Received: by 2002:a05:6102:943:b0:5df:c4ec:6607 with SMTP id
 ada2fe7eead31-5e1de26960bmr362818137.21.1763719662510; Fri, 21 Nov 2025
 02:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116130105.1988020-1-409411716@gms.tku.edu.tw>
 <20251116193513.0f90712a@pumpkin> <20251120155816.GB13687@macsyma-3.local>
In-Reply-To: <20251120155816.GB13687@macsyma-3.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 11:07:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWc-y_Ar4KzZE=HcNXvcO389ooinCL+6srLUtZfJT0OEw@mail.gmail.com>
X-Gm-Features: AWmQ_bk6JAtRKD51fdcVACNo0YgHUUZbvZ51lJPGy4pP4nR0gbNUSZ4cblql9JQ
Message-ID: <CAMuHMdWc-y_Ar4KzZE=HcNXvcO389ooinCL+6srLUtZfJT0OEw@mail.gmail.com>
Subject: Re: [PATCH] ext4: improve str2hashbuf by processing 4-byte chunks
To: Theodore Tso <tytso@mit.edu>
Cc: David Laight <david.laight.linux@gmail.com>, Guan-Chun Wu <409411716@gms.tku.edu.tw>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, visitorckw@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 17:11, Theodore Tso <tytso@mit.edu> wrote:
> "char" is not always signed.  It can be signed or unsigned; the C
> specification allows either.  In this particular case, scp is a
> "signed char", not "char".

This is Linux, so commit 3bc753c06dd02a35 ("kbuild: treat char as
always unsigned") in v6.2 and later applies to plain "char".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

