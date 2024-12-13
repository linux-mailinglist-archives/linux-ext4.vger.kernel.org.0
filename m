Return-Path: <linux-ext4+bounces-5632-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0779F144B
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 18:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6663A188D339
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B32E18452C;
	Fri, 13 Dec 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD+x9xI4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB85632
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112134; cv=none; b=jzFUBDo37LSW3oDvPa3S8USMqV2qr81XnrdniqYMW7jOXbJdd83iqM4Un2QEGnWsbm3X90oDPd0faGz7l8qKrRR6Uu0qB209KTA7rEJJMl4M6NAni8FWUuNdviJWZ1z9stK1RDq3WGFIM7yJTEM3z2LBByxjVnBSJjIIjI0YYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112134; c=relaxed/simple;
	bh=M7b7tnarEwfwtqSCYix3bezpHJTuYsFwpxXq61WSVIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlGJ/omeTJ4v7dDL3Jv1NQ8N17DcVleuFJSy+7th/kqrTwfSoetlVZ9bmvf4lbmYX628pUTLk7l8FlgP4SC4ifkzhjayP7FblbTmthAuADK+pcVWmniFTR9x4tjEUVoAcdEHXru8tHV/9nrM9SLjRysl+Gmoi1iE+YrC9Thlpcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD+x9xI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02527C4CED6
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734112134;
	bh=M7b7tnarEwfwtqSCYix3bezpHJTuYsFwpxXq61WSVIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vD+x9xI498336CXrIcipnGQtwPWE+Y8PtGBEoTA4qYZc1sEDVdhDhdeSVu2dH+7yh
	 POqVBPztBXeOs4yRsK8rgFr3HYOR0g3kt1+eyQb8ywyYTIStULKzhCAXJ9H5Y1izUw
	 8xfHxQDqeTm4KbpOE9lD2L+2qZTwrntOhIa3gHDt200F8v4O51jeFPlwHPweUdZwG6
	 00NXDJObSjW7SBHUmyHZC1ajrqKr2X9V6rLVsnLtjzsVBY306nlOty1OOzuo6voagU
	 udltc6zFfe3IkbfSKN37PDbXu4nWQgaVDNOD2oSwvhlzWC+2Xk1o8URkeHG5gXl4hC
	 DAtcpCJXfXE2A==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eba7784112so424236b6e.2
        for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 09:48:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFD+J3NqtQy2+pn1D4BD08aHwrdqA0qf4PDaf5gV08GepoiIcEKQIqnmRaTNaeR3rDuKjpCsQAPDVL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+UohhzZxbc/2idUHwhotJNzSn2/deXhr+Ke9nBF3Oap3FMjq9
	KeoQlw3GDaVFtitSEdGdWhSWvB6Iec6ZLdcFumGnPrNQLtyRfzlLC6k+TtlQtAeq8Vc/fHIUpJk
	yENKjHToi6ouIgNUFWDvjp+EVeB0=
X-Google-Smtp-Source: AGHT+IESFvKvWgj0dsEUDhhOZwimz3mooi2zlVcwYeEqdYKyZ7y1bibxTfBmH+X1npm8QzPhPSM3ze32YUu1NO+yIWo=
X-Received: by 2002:a05:6808:f01:b0:3eb:3b6e:a74b with SMTP id
 5614622812f47-3eba686b29dmr1982583b6e.17.1734112133232; Fri, 13 Dec 2024
 09:48:53 -0800 (PST)
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
 <87msgz8qes.ffs@tglx> <52850c8dbeb7c30d5bca007998f7ffd9a9b18d0f.camel@infradead.org>
In-Reply-To: <52850c8dbeb7c30d5bca007998f7ffd9a9b18d0f.camel@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 18:48:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hbWxKaVPM+sKqxj=bes1OqOEgFLXyWuzYUR9EHjHVf3A@mail.gmail.com>
Message-ID: <CAJZ5v0hbWxKaVPM+sKqxj=bes1OqOEgFLXyWuzYUR9EHjHVf3A@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, 
	kexec <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 6:17=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Fri, 2024-12-13 at 18:05 +0100, Thomas Gleixner wrote:
> >
> > > Agreed. The hacky proof of concept I posted earlier invoking
> > > machine_kexec() instead of suspend_ops->enter() works fine. I'll look
> > > at cleaning it up and making it not invoke all the ACPI hooks for
> > > *actual* suspend to RAM, etc.
> >
> > Something like the below? It survived an hour of loop testing.
>
> If I read that correctly, it's still invoking the standard platform
> (e.g. ACPI) hooks for suspend-to-RAM, when it probably shouldn't?
>
> I suspect it wants its *own* set of platform_suspend_ops, which are
> mostly empty apart from the ->enter() ?
>
> I started looking at that, but now my eyes are currently bleeding after
> seeing the existing platform_suspend_ops vs. platform_s2idle_ops
> structures, which are kind of similar but not the same. And the set of
> helper functions which invoke one or the other, from the barely
> tolerable platform_resume_end()...
>
> static void platform_resume_end(suspend_state_t state)
> {
>         if (state =3D=3D PM_SUSPEND_TO_IDLE && s2idle_ops && s2idle_ops->=
end)
>                 s2idle_ops->end();
>         else if (suspend_ops && suspend_ops->end)
>                 suspend_ops->end();
> }
>
> ... to the extra-special platform_resume_noirq() which is similar
> except that it needs three *different* names (_resume_noirq vs.
> restore_early vs. wake):
>
> static void platform_resume_noirq(suspend_state_t state)
> {
>         if (state =3D=3D PM_SUSPEND_TO_IDLE) {
>                 if (s2idle_ops && s2idle_ops->restore_early)
>                         s2idle_ops->restore_early();
>         } else if (suspend_ops->wake) {
>                 suspend_ops->wake();
>         }
> }
>
>
> I wonder if we end up wanting a *third* set there, for the kjump_ops?

No, no.

The "vision" behind kexec jump was to use it for implementing
hibernation, but that never happened.

It doesn't actually need any platform ops at all because everything it
does is to jump from one kernel to another, both residing in memory at
this point.  No firmware is involved.

> Except can we unify the structure definitions and then just *use* the
> appropriate one of the three, which is either passed down or selected
> using the 'state'?

That can be done I suppose, but it won't help much in the kexec jump case.

