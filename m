Return-Path: <linux-ext4+bounces-5615-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8689F0A73
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 12:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B61D2836F1
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF811CDA02;
	Fri, 13 Dec 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+yZYazj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B801B87FD
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088210; cv=none; b=VuVHcBz+mw+PjZBBx+vbb+iDPDeFoBlJIDGC7dFJGW1Aju5dA/7F8/thMfzPFHwhWgHFa9ukcdu/cNVURZPr6Fagv6u0AWh0YenHeLAQ8PCZ61dbpGzbhH1E9F+o1rygSl2LdthwQTRJooqpG2uupgSAgrSpI6Wrn+2QHXxCG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088210; c=relaxed/simple;
	bh=QVINjB2G8IvulEdr2DtHkqMFNSr0D/cyFc6vAqV0yHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObNDLVz9jfA+MjiS3Kn7OngLVForkdpSrz6kdXJXi16kdu9LEV1BZsQh3F5+1H0mewkeqXcneGTR7jzimedZSq263wmgnbparhu5etKdfY6H6JvtXcyW4egVKebbVdT2K0ua9sC+AJ62bG0/Lkzfcmo0njGPQ4Hn+8kwihjssuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+yZYazj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734088207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uxy6mePHA2mFbKxl3XRp7ln++RG16/GzEJG31dpj1nE=;
	b=R+yZYazjGXgEtlAwCUoXkhdA0CHz8HfPaMsRYOinaxSvVmHcTjgRXd1I2kMayc2A1PZW28
	1IIkqpFcWZqP/kvPiIq2NOVlawmYVs2W3vym912HwKOTMZgEPpFK0BWSut9EcXW94/6xym
	ZS9VH1MtRhXrb+rVm/+m1fGeDGfTzKo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-GML14rjxNomuNcIIJA4JxQ-1; Fri,
 13 Dec 2024 06:10:02 -0500
X-MC-Unique: GML14rjxNomuNcIIJA4JxQ-1
X-Mimecast-MFC-AGG-ID: GML14rjxNomuNcIIJA4JxQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73631195608E;
	Fri, 13 Dec 2024 11:09:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.91])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88A1D1956086;
	Fri, 13 Dec 2024 11:09:47 +0000 (UTC)
Date: Fri, 13 Dec 2024 19:09:41 +0800
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
	Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
Message-ID: <Z1wV9SsaVe3torbO@fedora>
References: <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pybamoc.ffs@tglx>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Dec 13, 2024 at 11:42:59AM +0100, Thomas Gleixner wrote:
> On Fri, Dec 13 2024 at 09:43, David Woodhouse wrote:
> > On Fri, 2024-12-13 at 09:31 +0000, David Woodhouse wrote:
> >> 
> >> (gdb) p sysrq_handle_showstate('t')
> >> 
> >> That didn't work. Maybe if I'd actually had no_console_suspend on this
> >> boot. Will try again.
> >
> > With your fix I get the same thing (both CPUs in idle thread). And with
> > no_console_suspend on the command line, 'p sysrq_handle_showstate('t')'
> > does work...
> >
> > [  113.462898] task:loadret         state:D stack:0     pid:707   tgid:707   ppid:531    flags:0x00004002
> > [  113.463615] Call Trace:
> > [  113.463841]  <TASK>
> > [  113.464029]  __schedule+0x502/0x1a10
> > [  113.464961]  schedule+0x3a/0x140
> > [  113.465234]  schedule_timeout+0xcc/0x110
> > [  113.465580]  __wait_for_common+0x91/0x1c0
> > [  113.466304]  cpuhp_kick_ap_work+0x13e/0x390
> > [  113.466657]  _cpu_down+0xd4/0x370
> > [  113.466936]  freeze_secondary_cpus.cold+0x3f/0xd4
> > [  113.467326]  kernel_kexec+0xa2/0x1a0
> 
> That's the control thread on CPU0. The hotplug thread on CPU1 is stuck
> here:
> 
>  task:cpuhp/1         state:D stack:0     pid:24    tgid:24    ppid:2      flags:0x00004000
>  Call Trace:
>   <TASK>
>   __schedule+0x51f/0x1a80
>   schedule+0x3a/0x140
>   schedule_timeout+0x90/0x110
>   msleep+0x2b/0x40
>   blk_mq_hctx_notify_offline+0x160/0x3a0
>   cpuhp_invoke_callback+0x2a8/0x6c0
>   cpuhp_thread_fun+0x1ed/0x270
>   smpboot_thread_fn+0xda/0x1d0
> 
> So something with those blk_mq fixes went sideways.

The cpuhp callback is just waiting for inflight IOs to be completed when
the irq is still live.

It looks same with the following report:

https://lore.kernel.org/linux-scsi/F991D40F7D096653+20241203211857.0291ab1b@john-PC/

Still triggered in case of kexec & qemu, which should be one qemu
problem.


Thanks, 
Ming


