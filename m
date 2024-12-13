Return-Path: <linux-ext4+bounces-5631-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D79F13AD
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 18:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9BC188CF44
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF61B87E8;
	Fri, 13 Dec 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzD1SE58"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF57632
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111150; cv=none; b=q3ez5OaQ/riSRGQyqIwrV9wH+juSbsWj1xEpQRHois0o7lXpiGv/IQSa6PnNJ5UGzzRYOWfn75ndtRt06oJ5uG47s4hmsphGIyMyjMCcOeqmKBVcq0fY0Fza2BnB1GSMIRacy0xhs1ziDFNeTgX3UJ641Ft3hWD7VWqOmgwaDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111150; c=relaxed/simple;
	bh=CF08WCO9YuKQC0mJOaDTgK7Du1Q7g3g6IhdZFvpLNno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1B6U86crnFt8M/IIRM2J6+D2SsfNMuR2viR4YeVCIn23HIY20aB3QH7mnOyYztm/q+JNUrDl2f1/hTFbsdzUijPlnj8uReYCUxemBPJewKtYhF2EYzsCHDAzhJ7E5qsWUagq1ZhNZnB2NQ8RErrxBE42aOsZgI6yMpWwu03oFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzD1SE58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D81C4CEDD
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734111150;
	bh=CF08WCO9YuKQC0mJOaDTgK7Du1Q7g3g6IhdZFvpLNno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lzD1SE58v5Nq1phH9HPogH7xmQLl/dCGklMKO3/58GDI0MvboFYcgBFi98kO2Nli4
	 Wfo7RRfmxb/GP//4cYGOXGqG8ZPuA4dvwq+s33Arf3naJwvH/jdPa2to92PUe8PJRd
	 zAq8sz9uLiEg9APQN7FwHPrQlbsI4bT/abS5egdugOmhNE7nCWx4oMle2vOYq8UHLx
	 uobSz9H1dzmhzqIJpS+Ran9mccZ0rFgK/hnxmlm/VU1rGpIlbdosJkfm3x3JZEDsng
	 bQqWnm61RGqPrTU0nXxnsKBp1JLx/AFKneEMvkEjuSj+YVSImKJM0ugXQh7B+hwOJb
	 hzzsHLF1Nw8mw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e63e5c0c50so975479b6e.0
        for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 09:32:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqe69YI+FsFK7bGW32snLb3WO9vUQAthBr90kcSa4OrWnIbAxeudbbUwFNDqdpXMDjdB8mLvNozRov@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjl6iQQzs1MzRTbIulquPDs+z/v3Qz03vIPu/yCrEXrAAR+KrD
	/9syWuZ1S7PZnYWBZQHP6i2lzuyoFhrGqANYDLQrntBUTh6V8chLaBRf1RheK1k5A8gpCclcrYE
	4CApUBgRTx1+oTn0r3muNxoYHfX0=
X-Google-Smtp-Source: AGHT+IGiXZt+WBiBE09BAmIkicVAdGZ3SDRVxvwU9UwpvBHBwlc8M1ZEhUTEOrlND9qAksD/X38mvCXH2Lr/v3RQBGk=
X-Received: by 2002:a05:6808:152c:b0:3e5:f7c1:757b with SMTP id
 5614622812f47-3eb94ecaccfmr4706039b6e.9.1734111149525; Fri, 13 Dec 2024
 09:32:29 -0800 (PST)
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
 <87msgz8qes.ffs@tglx>
In-Reply-To: <87msgz8qes.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 18:32:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com>
Message-ID: <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Ming Lei <ming.lei@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, 
	kexec <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 6:05=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Fri, Dec 13 2024 at 14:07, David Woodhouse wrote:
> > On Fri, 2024-12-13 at 14:23 +0100, Thomas Gleixner wrote:
> >> That's only true for the case where the new kernel takes over.
> >>
> >> In the case KEXEC_JUMP=3Dn and kexec_image->preserve_context =3D=3D tr=
ue, then
> >> it is supposed to align with suspend/resume and if you look at the cod=
e
> >> then it actually mimics suspend/resume in the most dilettanteish way.
> >
> > Did you mean KEXEC_JUMP=3Dy there?
>
> Yes, of course.
>
> > I spent a while the other week trying to understand the case where
> > CONFIG_KEXEC_JUMP=3Dn and kexec_image->preserve_context=3Dtrue, and cam=
e to
> > the conclusion that it was a mirage. Userspace can't *actually* set the
> > KEXEC_PRESERVE_CONTEXT bit when setting up the image, if KEXEC_JUMP=3Dn=
.
> >
> > The whole of the code path for that case is dead code. It's confusing
> > because as discussed elsewhere, we don't just #ifdef out the whole of
> > that dead code path, but only the bits which don't actually *compile*
> > (like references to restore_processor_state() etc.).
>
> Yes, I had to stare at it quite a while. :)
>
> >> It's a patently bad idea to clobber the kernel with kexec jump "fixes"
> >> instead of using the well tested and established suspend/resume
> >> machinery.
> >>
> >> All it takes is to:
> >>
> >>     1) disable the wakeup logic
> >>
> >>     2) provide a mechanism to invoke machine_kexec() instead of the
> >>        actual suspend mechanism.
> >>
> >> No?
> >
> > Agreed. The hacky proof of concept I posted earlier invoking
> > machine_kexec() instead of suspend_ops->enter() works fine. I'll look
> > at cleaning it up and making it not invoke all the ACPI hooks for
> > *actual* suspend to RAM, etc.
>
> Something like the below? It survived an hour of loop testing.

I think that this KEXEC_JUMP thing can be dropped entirely and forgotten.

I'm not aware of anyone actually using it.

