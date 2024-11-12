Return-Path: <linux-ext4+bounces-5116-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445819C62F3
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 21:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03357B677C0
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 19:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BABB219CA1;
	Tue, 12 Nov 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hu5pVYR0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1A21858F
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441279; cv=none; b=WpAdNXab+Cw71RfeLn9fElOt4yKvZbvFNM0nejSvICKflpjqMJO2xBlbryFRSXKeXfhOgZ5Gg3oYAUrM3rx/gQCPItbcbiZwI6fEG73vjnO1c/xnEu+lI5QNFWHkpcrwiT/ob/3StAIdyaOcQL2RCiu/DXpa/ivJ4ezIxyPqBco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441279; c=relaxed/simple;
	bh=w5M4DdbV0JDQqGXDCjJMEXFd24rwLm/qJCT5r02ClmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay7V/kt8bfB0ewj/p9wPNnb7zxwWRlhpflPizxzrvoq2rvQTGeJlrqvyRQMK4m3QlQlZfpwzvqk3ymzzWMxhm4jiyq9mBaqSdSQCaEbkqIVk9X1cpklYY6wIbllA5tOBzIM1TZPzVF6uQk/bMbAk9xAfEXu/TegIZ8jnfxZpdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hu5pVYR0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso975648466b.1
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731441275; x=1732046075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5b0rySYUL4FjfsS4jGUX3HJrYE8uK75+UecupTqejZA=;
        b=hu5pVYR0mz1FJoA4GR9DYhAkDz0lBba3sZ2VH2T1/cnRy9T4/TFP6K2mburFcsFm0x
         VDwWRVjsidGKgAp6MG2gBS4eNRGHG+E+0qonvyPFM8q3nTioyhZQOfLnZhxZIwVBROqA
         zRDZN0N68mWHAwuU4i7qGCU6mmoamB4dTM+8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441275; x=1732046075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5b0rySYUL4FjfsS4jGUX3HJrYE8uK75+UecupTqejZA=;
        b=nOoSu+t8GJnceWp/Aagq8PAW+2sUBlhXTu3+fguEpuW0MlnPAyhKQVWIYn8T7fDVJT
         tUH50OA7piAnXUOW9hRDwRsF98YLIf+DJEBcDRCGyABR0OrNHEoIG6bc1WiSHh67l/5e
         zxsf1Jf/wpM4g4ZeCrq06YPzj9JAfOzbQx2PeeKtDEiv+2rN3tKi641t3tq3zbCvK1Iw
         M8zmFZ2wp42A89ino4GsuXo/YWxS4kIuNDWGWJhqfsuTnGStlNIR7dSecVd264xsWetk
         AZbLSGUcx+ab5CoGS3u45tEUjFaRvb4KUqKcvNKwJilHL/ZqY58j8kuisJDUn01eybnA
         lRVA==
X-Forwarded-Encrypted: i=1; AJvYcCUYMjCzWeLnDWUmwPNrzXHiBXCIp7+ehzGEfR26N4N8OC4fgYi3YLpuPj7MaEgwANzYEZX9WwHo1lGC@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPacIAAZ8WqzLTS1UbwEHq5T+fR7TcozehNbC7Oygp/bbLsBe
	DBEl7XirFn4p8VpBr915KaLJty5JA5ZDnsyNBWm222Jvf6RV7mXoLshhvckEwopGl2GIouZkUEK
	ADyxZIg==
X-Google-Smtp-Source: AGHT+IFv5JcM1BBcAPYKaoHwo10dwh2gYbcsvJLpJxT9IsSXLYFA1FjaBK+gL/kyeZkXJ3h2gO63uQ==
X-Received: by 2002:a17:907:94cf:b0:a9a:17b9:77a4 with SMTP id a640c23a62f3a-a9eefee60cdmr1705566966b.20.1731441274731;
        Tue, 12 Nov 2024 11:54:34 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa1f73b6cd5sm12304966b.115.2024.11.12.11.54.33
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 11:54:33 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so6850357a12.3
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 11:54:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWc/3OaWV2J/anAj+sBt1TT1sOQ/bS7zcNtNArz6+rVED55GwvXBgPUXCULppJOl8JoWUr7zGhMbqbK@vger.kernel.org
X-Received: by 2002:a17:907:1b21:b0:a99:ff70:3abd with SMTP id
 a640c23a62f3a-a9eeff25d17mr1761977066b.31.1731441272860; Tue, 12 Nov 2024
 11:54:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
In-Reply-To: <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 11:54:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com>
Message-ID: <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] fsnotify: generate pre-content permission event
 on open
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
>
> +       /*
> +        * This permission hook is different than fsnotify_open_perm() hook.
> +        * This is a pre-content hook that is called without sb_writers held
> +        * and after the file was truncated.
> +        */
> +       return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0);
>  }

I still object to this all.

You can't say "permission denied" after you've already truncated the
file. It's not a sane model. I complained about that earlier, it seems
that complaint was missed in the other complaints.

Also, this whole "This permission hook is different than
fsnotify_open_perm() hook" statement is purely because
fsnotify_open_perm() itself was broken and called from the wrong place
as mentioned in the other email.

Fix *THAT* first, then unify the two places that should *not* be
different into one single "this is the fsnotify_open" code. And that
place explicitly sets that FMODE_NOTIFY_PERM bit, and makes sure that
it does *not* set it for FMODE_NONOTIFY or FMODE_PATH cases.

And then please work on making sure that that isn't called unless
actually required.

The actual real "pre-content permission events" should then ONLY test
the FMODE_NOTIFY_PERM bit. Nothing else. None of this "re-use the
existing fsnotify_file() logic" stuff. Noe extra tests, no extra
logic.

Don't make me jump through filve layers of inline functions that all
test different 'mask' bits, just to verify that the open / read /
write paths don't do something stupid.

IOW, make it straightforward and obvious what you are doing, and make
it very clear that you're not pointlessly testing things like
FMODE_NONOTIFY when the *ONLY* thing that should be tested is whether
FMODE_NOTIFY_PERM is set.

Please.

              Linus

