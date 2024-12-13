Return-Path: <linux-ext4+bounces-5618-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417D19F0B0C
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 12:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D042831AD
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192E1DDC32;
	Fri, 13 Dec 2024 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VywlZE7O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+x5pgMyG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488051AB528
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089489; cv=none; b=updPdsA0FWA3VwtuFa3WjFFDyCb2RiZHgV4zmETlb0WYYTgdBYCplp1t7mnpDpesmPW1RkKJv2UFtNInsjaKGQU8kvOmyeqRdj94zDGuzkm9DGlXKGTQM9uuzZ6B3Ni18qEdNEMqh7N0kmQ1oziHPD7PsMsaDxMIBmJ6/uB07iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089489; c=relaxed/simple;
	bh=r0MJZPKrDzpcBrGv8nq3jnaS5w0z7l7JndZI+tRdzO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4tU2KdupkARyCzJqhpOyNjg/GqkA0HYTln4BojWwvpLSFYwsbIg53DVHFOvQgLguKahaZ83+UM6hhgZ41h05HeEoMoUeKAXY1BIpJGlIGiwTd5jzJ6ynV+P4mWeLtzZ+rOweL80WtZ7CUxanTczKDwtunnyT352Az5ml1X1wOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VywlZE7O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+x5pgMyG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734089485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTLtkHzy12odtnIO1vKXAuWcEdu57bgB/Jv6GnuDHv8=;
	b=VywlZE7Op2Oh8h+Qlwj9/jXaq+/RyeLicQk7Cq7agGYzio/IP444cZ0fqTF4crgtZeKEiQ
	WhibYjTmNouqzSDV+dtuyrxRoRBMoX6r9ZlJ/eTidYA3HuKAf2knJvM/QDjKoo+GC06QWg
	lEDuKIWbHtvcugxjWd2Juscycw6ixuUL3kU/63GRN2KsvzRJE/DuNKEY3ojFsGrdtatOVd
	//p7WDMdMQSnv817KZcjy8Wyra596mrxLMiR+asbRc2zoA/8cTQnSByAhHSjwNYqxRCsQi
	L4h/rawJ6TV2WgdFbHWGHzSibCpKSI7H1NuHHPgXGUoDD1Oi5bvvAtqrJFn0QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734089485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTLtkHzy12odtnIO1vKXAuWcEdu57bgB/Jv6GnuDHv8=;
	b=+x5pgMyGr+foe7ZajdaaP14Qe3MGcUj0dv86Jw9Nzc8gz6PaSG+97PvZOjrqYUiGnAzc02
	x2Z4VBjRu+Gh8JAw==
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
In-Reply-To: <Z1wV9SsaVe3torbO@fedora>
References: <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora>
Date: Fri, 13 Dec 2024 12:31:24 +0100
Message-ID: <87y10j95v7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 13 2024 at 19:09, Ming Lei wrote:
> On Fri, Dec 13, 2024 at 11:42:59AM +0100, Thomas Gleixner wrote:
>> That's the control thread on CPU0. The hotplug thread on CPU1 is stuck
>> here:
>> 
>>  task:cpuhp/1         state:D stack:0     pid:24    tgid:24    ppid:2      flags:0x00004000
>>  Call Trace:
>>   <TASK>
>>   __schedule+0x51f/0x1a80
>>   schedule+0x3a/0x140
>>   schedule_timeout+0x90/0x110
>>   msleep+0x2b/0x40
>>   blk_mq_hctx_notify_offline+0x160/0x3a0
>>   cpuhp_invoke_callback+0x2a8/0x6c0
>>   cpuhp_thread_fun+0x1ed/0x270
>>   smpboot_thread_fn+0xda/0x1d0
>> 
>> So something with those blk_mq fixes went sideways.
>
> The cpuhp callback is just waiting for inflight IOs to be completed when
> the irq is still live.
>
> It looks same with the following report:
>
> https://lore.kernel.org/linux-scsi/F991D40F7D096653+20241203211857.0291ab1b@john-PC/
>
> Still triggered in case of kexec & qemu, which should be one qemu
> problem.

I'd rather say, that's a kexec problem. On the same instance a loop test
of suspend to ram with pm_test=core just works fine. That's equivalent
to the kexec scenario. It goes down to syscore_suspend() and skips the
actual suspend low level magic. It then resumes with syscore_resume()
and brings the machine back up.

That runs for 2 hours now, while the kexec muck dies within 2
minutes....

And if you look at the difference of these implementations, you might
notice that kexec just implemented some rudimentary version of the
actual suspend logic. Based on let's hope it works that way.

This is just insane and should be rewritten to actually reuse the suspend
mechanism, which is way better tested than this kexec jump muck.

Thanks,

        tglx

