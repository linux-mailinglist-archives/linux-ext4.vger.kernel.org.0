Return-Path: <linux-ext4+bounces-5666-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC7C9F3043
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 13:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827D316498D
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C5B20459B;
	Mon, 16 Dec 2024 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQj3weIs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C538FA6
	for <linux-ext4@vger.kernel.org>; Mon, 16 Dec 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351281; cv=none; b=PDnJhuqRlkLRkikQiN7i9x7DacaWg7JavEsnaT7a4jhP/GZAx8xQhesH419xGX122o3PEq5TQwOWXHXjrLjUrWnPwY4/jP00MwqcGl8ByXAimkgdE6pOz68dxcc+ncomgSri2Ieaekvauyu/zqPcTCR4kFN2c8TBHM22CRj+q8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351281; c=relaxed/simple;
	bh=I8BRA+E+7sIy/PeX8Wl+oBzLMGuM9Kf3XA5Fd7iH730=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suzvdDHPsWw/sqA+UhjMPTbDDTS9gkcjH8YD3v5BXKXv39lTVUWpbSeDXB5Qkkj52kuhARYRZTu3EiD3vKRMm2TGU3gzEXXbvxXAzZxtFT1e5uoL7BMNt9uxb5IQQDw0sSxCBaRy4oK3pik3FpQiEYY0jiEbwmCyd3mbPPIILpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQj3weIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F918C4CED0
	for <linux-ext4@vger.kernel.org>; Mon, 16 Dec 2024 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734351281;
	bh=I8BRA+E+7sIy/PeX8Wl+oBzLMGuM9Kf3XA5Fd7iH730=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YQj3weIs3D0RsxFOU/sVgtLeEdSz667AUOEk+xDN2Rt5+CQ5obHd+6BZ+BI3Oqi5d
	 F8dUx6PBKhU/nCkpczkCgMi88tJl12LYcJd7/6YK1nXFETpZI2qb+nvOS60oawk04W
	 mNnpl4RtDPzZk+eKGgcdblBDtdHhywW59U4SA45xT62imOuhCDcHjHxXUTh8Q0oTSW
	 0JpM2fdGooco3+Y41nNqTbKB9emnqa6AW37N4ayDXEOtKwpSro0ffBzpA9mqH/WRyX
	 Leb6xYOctNK1ONLf9zc5rBWUlfsdWz3xUASV+3QzIitrmI6nzMvopeLLE9bGUufQU0
	 dDUgf9CwcX8YQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb6b16f1a0so1302620b6e.3
        for <linux-ext4@vger.kernel.org>; Mon, 16 Dec 2024 04:14:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJVRCqDSmvUdf0+Xfqdakm3/JIMQTassRvlo7sOefzP+DAi3ex+p5NysdsGifgC50CAMPTLwvuPWs2@vger.kernel.org
X-Gm-Message-State: AOJu0YxleJs3ej7oj5LhUETTysBUg6I+GzStP849plxQ5uwNr/dmQ0rU
	rKe+d2dfAoyyfQZnofX0SYlv6X3R1skCn/L/P+zvmo6L/1UwMwabyu+PSdW9Dxm1cZZzF7pxLdr
	q3U6EjlC5HQjx8+XcCyRZRCxs3uc=
X-Google-Smtp-Source: AGHT+IEhIKzcP+ystGs9qCnC3kW6RLBVF8CarVw7viRsnLYJ5LXOeqEfGVxJYtIBVsNYGyJ3I71rnEn8fd++4R7Silg=
X-Received: by 2002:a05:6808:201a:b0:3e8:1ed7:e6cf with SMTP id
 5614622812f47-3eba67fec07mr6100991b6e.7.1734351280709; Mon, 16 Dec 2024
 04:14:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldwl9g93.ffs@tglx> <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx> <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx> <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx>
 <Z1wfF6NJRZh1jROz@fedora> <87pllv90ow.ffs@tglx> <1a7c126f3ab8ae75e755d01a6bf9bc06730dd239.camel@infradead.org>
 <87msgz8qes.ffs@tglx> <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com>
 <CAJZ5v0hBUgOB4QhhwjusRcP+jksWFL-upR5En58g9RD5+n70JA@mail.gmail.com>
 <73E84E2B-001B-48D6-9BB4-B104D43F8FBF@infradead.org> <febd10dae881f29fa8236f3e2d6ad77a8f094d72.camel@infradead.org>
In-Reply-To: <febd10dae881f29fa8236f3e2d6ad77a8f094d72.camel@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 13:14:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jcOCffvfB3558eJxv39aMog1BtiJ1PQG0v-sJAPuV6JQ@mail.gmail.com>
Message-ID: <CAJZ5v0jcOCffvfB3558eJxv39aMog1BtiJ1PQG0v-sJAPuV6JQ@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ming Lei <ming.lei@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, 
	dyoung <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 10:57=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On Fri, 2024-12-13 at 20:16 +0000, David Woodhouse wrote:
> >
> > > As discussed with Dave over IRC, the current implementation isn't
> > > actually that bad.  It might use PMSG_THAW instead of PMSG_RESTORE in
> > > kernel_kexec(), but other than this it reflects the code flow around
> > > the jump from the restore kernel to the image one during resume from
> > > hibernation.
> > >
> > > This means that hibernation and kexec jump could be unified somewhat.
> >
> > Fair enough. I'm happy to do whatever cleanups or consolidation make
> > sense, if we have a consensus.
> >
> > There remains the question of why the blk-mq thing explodes on the
> > way down for both kjump and, apparently, even the plain kexec case.
>
> In case it's of any use, here's a test case I put together recently for
> kexec stress testing.
>
>  http://david.woodhou.se/kexec.initramfs
>
> It's just an initrd I boot in qemu with '-initrd kexec.initramfs' and
> it builds a copy of itself, then kexecs back into the same kernel with
> the same initrd. You'll need to drop your own bzImage into it.
>
> It was designed to run without a block device, but to trigger the
> blk-mq thing or the one at
> https://lore.kernel.org/linux-scsi/F991D40F7D096653+20241203211857.0291ab=
1b@john-PC/

Which BTW includes some quite convincing analysis of what's going on.

> we'd probably need to actually mount something and maybe do some disk
> I/O.

If I'm not mistaken, this should be also reproducible by echoing
"core" into /sys/power/pm_test and running "echo disk >
/sys/power/state" in a loop after that, unless the ksys_sync()
triggered by hibernate() makes it extremely unlikely.

