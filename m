Return-Path: <linux-ext4+bounces-5623-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ECD9F0D38
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 14:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA91188A22D
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CBD1DFE3A;
	Fri, 13 Dec 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NvOjPfiv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cN1c9G+m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8D1A8F85
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096195; cv=none; b=oXLOriZfFR215H1tV3P1VeUQZpMHjLUJUOg/kg3eyw7TM/5q/cx5wEFMJDcv3bXWqya8h20IdRat4JzVVKFwH6KheOFIx2Ova2YnMPn9wpe3gyfxhDuVjKL0YOpNXrv2luYWoMfe29dzPggjtCMjfVCx8Fo3kGFaCykpqpIcaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096195; c=relaxed/simple;
	bh=/5z72998Cu+wv6QNYlBZCj2Ll/VxvGxHGnxNZMcgghM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=axjDf2OPUpcoi5RIahX3dVB1F54o5xM786Brtq75elILIjaAa8JHsz3eyToSZjVuQauF3a3xto4Gcc9OWoBBzWVTCopER2dTYwQMgEXfAxOi6XHFT1oJs3ckMO1NG07NPZhD7U1ONGSInjh6iM3uuTtR5QhkWdyVqJAHzHX5y/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NvOjPfiv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cN1c9G+m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734096191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2BAPcHxdGhy0vmxEJ/sjgGoKxVfP+fnZ9WQuC3FZvA=;
	b=NvOjPfivC9xDA2DrB+2+7pnnSEcW0iw0pEsGQT1eWdf6kQvuxfkMRJ9Fofcbn5PXOxI57w
	KvVJf2mrpXTiDdehztwu3OplGW45CAHY0RfJTjRhM486A5j6RacfsDKnJ+p2IPQthpsQl+
	SIzx3zd2uUSaDPVlKRghJs25fbJq6n/059vAAljuWLOvCqkc+MCqe3hP0W8ds7lU04Q8IP
	NbixBKD/jzfyG8pOF0Fez9PXM0BfySnPXS82AhkNcahGauP5Zzp4pBKnwIcNDU4PH/BOEY
	lai0UbkyGIEv7nKREm8mK7RYcoNB/KVhgmqxVJDCv04xFQONZ6YibfUzJOqHiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734096191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2BAPcHxdGhy0vmxEJ/sjgGoKxVfP+fnZ9WQuC3FZvA=;
	b=cN1c9G+mWP0NNaOK1timD9IoG/manIkMNgEANGMAAaRoXJpsA05H5nfeWpq4Q2p2oVxZix
	Y6fbWzcukais7LBg==
To: Ming Lei <ming.lei@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, "x86@kernel.org"
 <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, kexec
 <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, Paolo Bonzini
 <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, John Ogness
 <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Jens Axboe
 <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
In-Reply-To: <Z1wfF6NJRZh1jROz@fedora>
References: <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx>
 <Z1wfF6NJRZh1jROz@fedora>
Date: Fri, 13 Dec 2024 14:23:11 +0100
Message-ID: <87pllv90ow.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 13 2024 at 19:48, Ming Lei wrote:
> On Fri, Dec 13, 2024 at 12:31:24PM +0100, Thomas Gleixner wrote:
>> I'd rather say, that's a kexec problem. On the same instance a loop test
>> of suspend to ram with pm_test=core just works fine. That's equivalent
>> to the kexec scenario. It goes down to syscore_suspend() and skips the
>> actual suspend low level magic. It then resumes with syscore_resume()
>> and brings the machine back up.
>> 
>> That runs for 2 hours now, while the kexec muck dies within 2
>> minutes....
>> 
>> And if you look at the difference of these implementations, you might
>> notice that kexec just implemented some rudimentary version of the
>> actual suspend logic. Based on let's hope it works that way.
>> 
>> This is just insane and should be rewritten to actually reuse the suspend
>> mechanism, which is way better tested than this kexec jump muck.
>
> But kexec is supposed to align with reboot/shutdown, instead of suspend,
> and it is calling ->shutdown() for notifying driver & device.

That's only true for the case where the new kernel takes over.

In the case KEXEC_JUMP=n and kexec_image->preserve_context == true, then
it is supposed to align with suspend/resume and if you look at the code
then it actually mimics suspend/resume in the most dilettanteish way.

It's a patently bad idea to clobber the kernel with kexec jump "fixes"
instead of using the well tested and established suspend/resume
machinery.

All it takes is to:

    1) disable the wakeup logic

    2) provide a mechanism to invoke machine_kexec() instead of the
       actual suspend mechanism.

No?

Thanks

        tglx




