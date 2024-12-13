Return-Path: <linux-ext4+bounces-5636-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343BB9F156F
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 20:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BAF1882681
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 19:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C71E2309;
	Fri, 13 Dec 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMEBZwT+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A22D13EFE3
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116825; cv=none; b=UM4g4vceqe6slTRhqRnEcfHRmSH26b1SjH3rVKVn9D3qlnQVOibBtGn1MF27cQ857182Tun1mP7zQjtYr+4wbT0e1MJRcFERwcMK6twMjmQC90diio357yURWGb/2i89fLJ1TbUQOl84r895+D5OdwsJcnYI55Zd96rnRchaItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116825; c=relaxed/simple;
	bh=JcLKws40yFdRTtJnXA+ZbB/1F7xJ4hkgw1EMwlWdgg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXrglCrNj3kxP815wPWCr4D4gk0Tj9x5ZFhARzsjbtjAxiDHrBek89b9pHU/y6XeCi5eTukAp2BmQblvbgEowCpfpWzpMVA/YcTEqxkTAIvn6HM+dxtCDaqiLUmlSmdAu/vnASJQ3e+Taon6ZFpRT/tA+qXhLpN5VcdLyc8ZGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMEBZwT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B86EC4CED4
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734116825;
	bh=JcLKws40yFdRTtJnXA+ZbB/1F7xJ4hkgw1EMwlWdgg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LMEBZwT+2QZrFWy8zFqPbM0WI52tOTRx+dAZwzonn0BRdAUAfgy4p4m2W0kYBgMe5
	 wtt+w7WMdfhUSyK93uYQJOiYAjft7DT17ZwmrmZyLJcyQml3MIpk3AlZJRBcS3q2dc
	 nkEZ7OtfFPFctNc+ZbQhMqKqpD19sIakDElH+Gh9Zu9IqXwpApbNWcL7458TRo3qtU
	 /DQV48tek5/6cf0TBT34vkqh9gEJMSEtc1mDSBKmo8I09tprpEn1jdXdSfgVnOp/qL
	 8IVRAAlHJ1z6MKwHso56StCj7jzdsGOMH3DgIDojyqD9irZN6UF182zbFdZ2r+kgyb
	 yEZOTzBBqfpXg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb6210742aso1062507b6e.1
        for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 11:07:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXq5NDIw45DPRLZYirom6CR/S8PYuDCelSGWIpwB5h5hPZzLYlWzeMIpFGU3c41RnFxyhGQxYZcMBG0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0u0LBQAsqTWyXg8GHdKg74W4eS4SdcC7SceiPUiUj8Rd6uPw5
	DH/KYJG4n1/isADJt45NQQd89zeT36vqhB6o/lX/YP3g8O5oGbqe6NGNtYfUz5fGmpGGyjQ2zpB
	oLPSmVR/iurGhPrd46RmqpyZqaZY=
X-Google-Smtp-Source: AGHT+IHFYlygRpUxhmDvsnKstQkQrdlDutDXvlyZYpQ3L20ftrb+3paxMS/AwESygHPU6Bu20IY9ZwiVsLsOqAgeuTc=
X-Received: by 2002:a05:6808:2191:b0:3ea:4b5c:60a8 with SMTP id
 5614622812f47-3eba6be35aamr1891339b6e.17.1734116824374; Fri, 13 Dec 2024
 11:07:04 -0800 (PST)
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
In-Reply-To: <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 20:06:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hBUgOB4QhhwjusRcP+jksWFL-upR5En58g9RD5+n70JA@mail.gmail.com>
Message-ID: <CAJZ5v0hBUgOB4QhhwjusRcP+jksWFL-upR5En58g9RD5+n70JA@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, 
	dyoung <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 6:32=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Dec 13, 2024 at 6:05=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> >
> > On Fri, Dec 13 2024 at 14:07, David Woodhouse wrote:
> > > On Fri, 2024-12-13 at 14:23 +0100, Thomas Gleixner wrote:
> > >> That's only true for the case where the new kernel takes over.
> > >>
> > >> In the case KEXEC_JUMP=3Dn and kexec_image->preserve_context =3D=3D =
true, then
> > >> it is supposed to align with suspend/resume and if you look at the c=
ode
> > >> then it actually mimics suspend/resume in the most dilettanteish way=
.
> > >
> > > Did you mean KEXEC_JUMP=3Dy there?
> >
> > Yes, of course.
> >
> > > I spent a while the other week trying to understand the case where
> > > CONFIG_KEXEC_JUMP=3Dn and kexec_image->preserve_context=3Dtrue, and c=
ame to
> > > the conclusion that it was a mirage. Userspace can't *actually* set t=
he
> > > KEXEC_PRESERVE_CONTEXT bit when setting up the image, if KEXEC_JUMP=
=3Dn.
> > >
> > > The whole of the code path for that case is dead code. It's confusing
> > > because as discussed elsewhere, we don't just #ifdef out the whole of
> > > that dead code path, but only the bits which don't actually *compile*
> > > (like references to restore_processor_state() etc.).
> >
> > Yes, I had to stare at it quite a while. :)
> >
> > >> It's a patently bad idea to clobber the kernel with kexec jump "fixe=
s"
> > >> instead of using the well tested and established suspend/resume
> > >> machinery.
> > >>
> > >> All it takes is to:
> > >>
> > >>     1) disable the wakeup logic
> > >>
> > >>     2) provide a mechanism to invoke machine_kexec() instead of the
> > >>        actual suspend mechanism.
> > >>
> > >> No?
> > >
> > > Agreed. The hacky proof of concept I posted earlier invoking
> > > machine_kexec() instead of suspend_ops->enter() works fine. I'll look
> > > at cleaning it up and making it not invoke all the ACPI hooks for
> > > *actual* suspend to RAM, etc.
> >
> > Something like the below? It survived an hour of loop testing.
>
> I think that this KEXEC_JUMP thing can be dropped entirely and forgotten.
>
> I'm not aware of anyone actually using it.

And now I've been made aware that it's used.  Oh well.

As discussed with Dave over IRC, the current implementation isn't
actually that bad.  It might use PMSG_THAW instead of PMSG_RESTORE in
kernel_kexec(), but other than this it reflects the code flow around
the jump from the restore kernel to the image one during resume from
hibernation.

This means that hibernation and kexec jump could be unified somewhat.

