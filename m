Return-Path: <linux-ext4+bounces-10735-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E245BCBAB9
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 06:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03F55353965
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 04:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CCD26F297;
	Fri, 10 Oct 2025 04:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrdiTzbT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174C25A2A7
	for <linux-ext4@vger.kernel.org>; Fri, 10 Oct 2025 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072281; cv=none; b=C+eggMvukAUf7nzl6SU+etz9EGufJcpdAz+gDbh2b+EXqQoxdwx6ht8Yeme/cokoDDIn4WEMmsLI6XAG3hFqrEINqsBpzL6LeeUWX0Zncgp3WgFAL7slnqBCLLynKYbu0oibDUeZIla6keVZKc6ckijq3mtUfV07c9sIKRPHR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072281; c=relaxed/simple;
	bh=20zVq/I1A85ImSdUuzZ7bh9Qs7dqD4eEIEsQzzw5Ci4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADa4cN6FZt7RViPRHMlxvAucyzXlFznkPkqVMK+rXqyxFqPZSU8rm1yqaluEMULwEIJgKfw9tg2uAeULRXAiswt5583Ua7yljEAy7L6fNlJc2s5AuN4PfeU+AbFQnJmWPy4Eo+vlaLpt/NjFlPQtoJWDdKBYQlqfx8ciLp8818k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrdiTzbT; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63bc1aeb427so1693679d50.3
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760072278; x=1760677078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=;
        b=GrdiTzbTpmXrgj0/PjkohCZ6LgFNbxV45gb5L/ZVbzaWKAHJgA12/mfFqFdtOpY72m
         bZZCyt4k8jRvQo4unsWw4ZeaFcU/eOYR2U/wcLgsvZR/RYdUoV9fmyuViF8Of5PYj/l4
         634Gm0JHXypxB9ycdlhLckuOP80mjqw4wIO9HLiTQ6purdE8gu3SXgXaNMsYndjRbf75
         1dPvVv1bpLUsn7UsoLTsiGPIZ2KQmnwtMFB4nrm8RHlzLeSFwrO7OIHtu7G4t0f6Q3Az
         maevl8wn3jZRwLsUqzTevJOM0Q45hnxhlAkendZd7mXKlZsyaRmG6ugJRYjmZ1sxfyiy
         qCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760072278; x=1760677078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=;
        b=VdsRA4+gzX0Y33Ff8on3xP3Pi8ol7ZzTOgFqFwIM1nnGgjBOik9ZNIadgglGKUG0lh
         GOBxw9EIYvaL4VWvqDl4h2s1523tSDGkN37TZzVJmdBWKwekxYfDEFAr/rYobSCH1Ol0
         2YCTq2Du0KofWyicjWv+pjVadjDKjLgvNyVAfkhcivR831QUd8VFn27yymYeGJAMpCnb
         mW0CxTqUHkpm7Cnfg9O34l9zv8uYbmdvXuYnsUsYQVQSNo+FC5ryRJrWR5CWgk0CG1qT
         H9TVEMirEhyI+T/JP+SPQbqOGJEkyzBrSeHx7YwHyisWlPgyQZPdu9vL1+A8HeyXmSYc
         rEZw==
X-Forwarded-Encrypted: i=1; AJvYcCXnB2JC76FaxiwvTQv+lWYEa+xe5QwS4k69HjgMHZbJcAsRgUIpqFGEvnd2/hwA0PErbAzd/xNF8nLa@vger.kernel.org
X-Gm-Message-State: AOJu0YwWlGd49vQNXSXzSfKDepqcfipTexW9IIwYAkF1a1Lb+TVrUKgT
	hrWhyNyZUPlTt6dTIcEY/NT7JPnY2v3E2jU4T2JsHc8rx8ObYWDKFE28yEXOBN4tb/1E3I90NHL
	Nkfzz2L8mnqh48grKQt+qUn0wPchzveY=
X-Gm-Gg: ASbGnctbs4t0T1A8SOfWl11e3MD/g8HnBIbHwSGaN8CuOFYgsoNMCTqz+JCaewITsZz
	6HUVJ9kk8cjE+VJKOHM4SK775byGMXbgA0Y23OA2bjL5KBncXZbaRujE7p2uPezA7GIhhhWbgYY
	0pa2EKV+dujTEwjn8wxkONCQ5yMyqs0JFnJ1ZXcWc6Gfhn/Cbep8aNkyL+9icW8RzjCSIo5yuGh
	zNMDec/Wakdkr1cE8Pgf3sqkw==
X-Google-Smtp-Source: AGHT+IHqDciv7GAPYfMGdKr9Fwuo5GT168N8GcrpsJ5KozP5HqYqg/LDALxuogvzJXgNCm6zrA+DoCqu7lr8uhQrVc0=
X-Received: by 2002:a53:5009:0:b0:636:2420:d3ce with SMTP id
 956f58d0204a3-63ccb93456dmr7466309d50.51.1760072277565; Thu, 09 Oct 2025
 21:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
 <20250925131055.3933381-1-nschichan@freebox.fr>
In-Reply-To: <20250925131055.3933381-1-nschichan@freebox.fr>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 07:57:21 +0300
X-Gm-Features: AS18NWAQwCKadWHXCZjVUBNaD3TaKIilJiJAQzSbvGFaYuFuE8UDpW1_H3riB-k
Message-ID: <CAPnZJGBPyONjJoM6cskxysDnN4pxWuWJCK5A6TgikR2xHsrN5Q@mail.gmail.com>
Subject: Re: [PATCH-RFC] init: simplify initrd code (was Re: [PATCH RESEND
 00/62] initrd: remove classic initrd support).
To: nschichan@freebox.fr
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 4:12=E2=80=AFPM <nschichan@freebox.fr> wrote:
> - drop prompt_ramdisk and ramdisk_start kernel parameters
> - drop compression support
> - drop image autodetection, the whole /initrd.image content is now
>   copied into /dev/ram0
> - remove rd_load_disk() which doesn't seem to be used anywhere.

I welcome any initrd simplification!

> Hopefully my email config is now better and reaches gmail users
> correctly.

Yes, I got this email.

--
Askar Safin

