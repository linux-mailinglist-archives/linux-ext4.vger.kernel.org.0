Return-Path: <linux-ext4+bounces-5038-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6EC9C4888
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 22:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3597282E17
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 21:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9AD1BBBE5;
	Mon, 11 Nov 2024 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YFd6xClp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6201A76DD
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361927; cv=none; b=NEM1hxChIPK8gL1goVbNmvXVmaIO1StNYEdL6D9qeI6a474HR2L4KtvEDE3tQVEEQOM4BRAEaxHrQQuHF2V7NQyOM1Dl8T+sb3h84GZJhFeDLFqXSnUQ8mUo5bhDQl+yq2D7SgItsFOGYyy/ZOr2hlbNSP+TlywxZoQt0XVCWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361927; c=relaxed/simple;
	bh=q/zqChwYsrx4Zy33qGdG8SBhmqndzWb5CoC2UrWb3jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ke3RlwnFrfwSY7aS2bx2NELdZZS6ASjBaF8tKLbI2ww0oJHghlOUpeSXSV3uqfclEUfgF/6AfUeQeEKZ610VzyGFmc8NM+gkIjyJfCc24Klai3pOFzCNZpgk1RforplsFmYWnnYoZstYZnjBrcb+J1hEc9pp8OwZsa7C4fEEFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YFd6xClp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a850270e2so916889166b.0
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 13:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731361923; x=1731966723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L24fLxFCjFl/hQH9TQaBFKqNsNfJNVwL6H3wGfP4DSE=;
        b=YFd6xClpm5Z/rzg6DadchCVqpv8DOwXHjqj7Ko3l56u5zz1yKHyyRc++0S8eIDO4YE
         PrJNVpOWHb9kX2FZ1dN3np/6q828VkOeD8J08UZorF8kSUuiqZs0hPz5hgC93h5Z4Foz
         tq762Jj4K6vCkVxZIif89KrBNQm8lDNWnrgNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731361923; x=1731966723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L24fLxFCjFl/hQH9TQaBFKqNsNfJNVwL6H3wGfP4DSE=;
        b=r73hfNI9JNXXy0iA6LOnIod0NLcm2ytup9erfK7UlMGTfVL6P4J1CHUBcsqZN+2Q9i
         K8Zn/XSkhgZJgEzZ5NiCNT7KtLldJSA7pQjKvdLWjl4K4TWBcdYPQm4QdM9Xxbg7VxHV
         GoaRfOw1nO485CMyd3pjZ4GoKgK38Us0N0ZvDHSqNUUxSiURoaJsZWH+++Cj07uXdeUv
         5bpK1ab/ZOyV8iTobt72ljWUuA6pdvsEAe5Myp9efHC59jTZVjd/sLJ81R+RMUj/NbDF
         uJToFDAjPMtdreJ9rGLNGixWw9YRNuRzhUgIha7stEE/nOHo/8km8VQLhfSea+0XHfFa
         BXfg==
X-Forwarded-Encrypted: i=1; AJvYcCWDzVD3DSxKIo6IHen2GbbdcRIouOsuIDAj2UaZ4LEQoxk1wxyhd1UedXCNC+huJ7Ka/e9SsZNYbPJa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0+QTZ6rs41ra11hrVzW+PF5HttyxHGKXcRZKwrxH2qTnh1Mlc
	77/W1gcCm3ekp07yU7AWAgANCxWULsnBApc44A9nHuWB9O/AsQh05ibmwRHNCQyaHI9Mx9ozpze
	ZjVg=
X-Google-Smtp-Source: AGHT+IEosthPWE5V2pBjdlRck3b1dNq5+LS7IOYqzfu2v+gGL2vXDfOPe8cXUB0ALgdwNqSn9NAzCA==
X-Received: by 2002:a17:906:f598:b0:a9a:4a1f:c97d with SMTP id a640c23a62f3a-a9eefeaf039mr1389476666b.7.1731361923376;
        Mon, 11 Nov 2024 13:52:03 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0df0c85sm634729766b.171.2024.11.11.13.52.01
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 13:52:01 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9e8522445dso882334166b.1
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 13:52:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZmMIfSOR+KbBSpSNslp0GqwFhnJz6aRMXqM4ycThhhWo86//qk6PGYYGZMhF0oqDVwyT8/ifZuF9E@vger.kernel.org
X-Received: by 2002:a17:906:730d:b0:a89:f5f6:395 with SMTP id
 a640c23a62f3a-a9eefeade4cmr1373427066b.1.1731361921497; Mon, 11 Nov 2024
 13:52:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
In-Reply-To: <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 13:51:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
Message-ID: <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 12:19, Josef Bacik <josef@toxicpanda.com> wrote:
>
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3782,7 +3782,15 @@ static int do_open(struct nameidata *nd,
> +       /*
> +        * This permission hook is different than fsnotify_open_perm() hook.
> +        * This is a pre-content hook that is called without sb_writers held
> +        * and after the file was truncated.
> +        */
> +       return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0);
>  }

Stop adding sh*t like this to the VFS layer.

Seriously. I spend time and effort looking at profiles, and then
people who do *not* seem to spend the time and effort just willy nilly
add fsnotify and security events and show down basic paths.

I'm going to NAK any new fsnotify and permission hooks unless people
show that they don't add any overhead.

Because I'm really really tired of having to wade through various
permission hooks in the profiles that I can not fix or optimize,
because those hoosk have no sane defined semantics, just "let user
space know".

Yes, right now it's mostly just the security layer. But this really
looks to me like now fsnotify will be the same kind of pain.

And that location is STUPID. Dammit, it is even *documented* to be
stupid. It's a "pre-content" hook that happens after the contents have
already been truncated. WTF? That's no "pre".

I tried to follow the deep chain of inlines to see what actually ends
up happening, and it looks like if the *whole* filesystem has no
notify events at all, the fsnotify_sb_has_watchers() check will make
this mostly go away, except for all the D$ accesses needed just to
check for it.

But even *one* entirely unrelated event will now force every single
open to typically call __fsnotify_parent() (or possibly "just"
fsnotify), because there's no sane "nobody cares about this dentry"
kind of thing.

So effectively this is a new hook that gets called on every single
open call that nobody else cares about than you, and that people have
lived without for three decades.

Stop it, or at least add the code to not do this all completely pointlessly.

Because otherwise I will not take this kind of stuff any more. I just
spent time trying to figure out how to avoid the pointless cache
misses we did for every path component traversal.

So I *really* don't want to see another pointless stupid fsnotify hook
in my profiles.

                Linus

