Return-Path: <linux-ext4+bounces-5620-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE29F0B9D
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 12:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B39163283
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF21DF265;
	Fri, 13 Dec 2024 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXcUB8qQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B21DE3BA
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090544; cv=none; b=hGYavThYmY2duOdkYgeyugNmMFjhIBAgeE63J/B3X0kMVaqceM0ZESejw1CA3Ah5ik0VZP0kCIPOvKR7H2DW3XohtkEmGrFgojU+FJHOwH08taSuwneYBICkAWpz3s6tWmszaV/oTE0KhlXNlYnFHPUNVLzZcEHGkHMdxbnTrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090544; c=relaxed/simple;
	bh=w6eEvjW0Y23K8Xyr2CrdpGAgALerym8PubNYNZVjT/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSy9vstLqnsuYJB84CgwCZiMFvVHHSXaejaYGvq2N60MNilDEgTdkaoXkXgAvwMm5X0F51PpdoFnySq8D7WOGD9ug2QTqahx52o25vJ0/S96jvBrKKf3tvngMx/86e0jEjbNz/jLExtSTKq0C//HiWTmA/VVf+e0OWtYR6w0dow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXcUB8qQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734090541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dv3t7bZUI3+tqYgjemQqhW+HuqlPgsCuhawdU9w0NMo=;
	b=HXcUB8qQK/1UVIDRsMnc8V6E7IjSw/1KtabYmEW+I6okWPeT4Hch6GOkoKX8DzLP7zF8qN
	KXWMm7eqMMk6EkuNfvQTPElaC35vxu6gKlXrGvyTO3VD+spJuGj2jlEN1fihChGOA+EpgB
	nGKa8RY+rRuP486K9KYfbIeclqgepuY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-JM6VGjjpNjCfIaQUCLIzbA-1; Fri,
 13 Dec 2024 06:48:58 -0500
X-MC-Unique: JM6VGjjpNjCfIaQUCLIzbA-1
X-Mimecast-MFC-AGG-ID: JM6VGjjpNjCfIaQUCLIzbA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 202E2195604F;
	Fri, 13 Dec 2024 11:48:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7702300FA98;
	Fri, 13 Dec 2024 11:48:44 +0000 (UTC)
Date: Fri, 13 Dec 2024 19:48:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>,
	kexec <kexec@lists.infradead.org>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	eperezma <eperezma@redhat.com>, Paolo Bonzini <bonzini@redhat.com>,
	Petr Mladek <pmladek@suse.com>, John Ogness <jogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
Message-ID: <Z1wfF6NJRZh1jROz@fedora>
References: <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx>
 <Z1wV9SsaVe3torbO@fedora>
 <87y10j95v7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y10j95v7.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Dec 13, 2024 at 12:31:24PM +0100, Thomas Gleixner wrote:
> On Fri, Dec 13 2024 at 19:09, Ming Lei wrote:
> > On Fri, Dec 13, 2024 at 11:42:59AM +0100, Thomas Gleixner wrote:
> >> That's the control thread on CPU0. The hotplug thread on CPU1 is stuck
> >> here:
> >> 
> >>  task:cpuhp/1         state:D stack:0     pid:24    tgid:24    ppid:2      flags:0x00004000
> >>  Call Trace:
> >>   <TASK>
> >>   __schedule+0x51f/0x1a80
> >>   schedule+0x3a/0x140
> >>   schedule_timeout+0x90/0x110
> >>   msleep+0x2b/0x40
> >>   blk_mq_hctx_notify_offline+0x160/0x3a0
> >>   cpuhp_invoke_callback+0x2a8/0x6c0
> >>   cpuhp_thread_fun+0x1ed/0x270
> >>   smpboot_thread_fn+0xda/0x1d0
> >> 
> >> So something with those blk_mq fixes went sideways.
> >
> > The cpuhp callback is just waiting for inflight IOs to be completed when
> > the irq is still live.
> >
> > It looks same with the following report:
> >
> > https://lore.kernel.org/linux-scsi/F991D40F7D096653+20241203211857.0291ab1b@john-PC/
> >
> > Still triggered in case of kexec & qemu, which should be one qemu
> > problem.
> 
> I'd rather say, that's a kexec problem. On the same instance a loop test
> of suspend to ram with pm_test=core just works fine. That's equivalent
> to the kexec scenario. It goes down to syscore_suspend() and skips the
> actual suspend low level magic. It then resumes with syscore_resume()
> and brings the machine back up.
> 
> That runs for 2 hours now, while the kexec muck dies within 2
> minutes....
> 
> And if you look at the difference of these implementations, you might
> notice that kexec just implemented some rudimentary version of the
> actual suspend logic. Based on let's hope it works that way.
> 
> This is just insane and should be rewritten to actually reuse the suspend
> mechanism, which is way better tested than this kexec jump muck.

But kexec is supposed to align with reboot/shutdown, instead of suspend,
and it is calling ->shutdown() for notifying driver & device.

Thanks,
Ming


