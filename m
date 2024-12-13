Return-Path: <linux-ext4+bounces-5619-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A618C9F0B51
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 12:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6211728375F
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765681E1C32;
	Fri, 13 Dec 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esRDtmUB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804791E1A32
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089634; cv=none; b=UkaEwkBTGaekaxu49+EqKtBxMsOUPb+U2T0lGAWhXzOLym6hIGodkh12x9fNpPjkDyALq0Dx81kryLymi5wt44YrT7Qt4oO0bQJikVouJwHI8SbQ+WKhT8htiJs1di50p2/21GNKhO9U5Ui4kyNEPbAq+4i6S8B5euY5njM9w9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089634; c=relaxed/simple;
	bh=V4JsKLaWMUv8sfBavf8T7EmKZcNGYpF4v8DlOLoE+88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxnm0x3ZtUlVNHMeBlAxV6LBzDhylhimet/yt/xC9YWYK7A1EIJkCTstz728IH0ZQ83bj/Mn0QwuV0LJh/bFNDnlc9/7PWq4laxtjD/RlVNoleXO3tkm4FD1KTdNcebQ6VhBp9TqJ4YsqhO4t6J6++xWrckb40SYeg+TkQBbnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esRDtmUB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734089631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Acbf4O5mwC8ef2Hr5VcWYBHCRMx3zMFSJ+cKK6lNDy0=;
	b=esRDtmUBI6muTpadRiO6rsilYT11Oun0qPO1ENmyXnXbQLGywRicflZkxq+qlWAZqQAWmX
	aDom/Sl4nJO/FzwoXtQ0tVMsdeZrJV83uGZjErX5Jo9S285mN0Ot8Y81NITVdd/hHcl3xW
	kPn2HkBoBF1fFnF8esfXvYTHjJ9VLYE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-RQSdDPSdNGeAeQYX5H1e4g-1; Fri,
 13 Dec 2024 06:33:48 -0500
X-MC-Unique: RQSdDPSdNGeAeQYX5H1e4g-1
X-Mimecast-MFC-AGG-ID: RQSdDPSdNGeAeQYX5H1e4g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C56D019560AE;
	Fri, 13 Dec 2024 11:33:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.91])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2D3B195605A;
	Fri, 13 Dec 2024 11:33:33 +0000 (UTC)
Date: Fri, 13 Dec 2024 19:33:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <Z1wbiF7FhkO5VQFJ@fedora>
References: <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx>
 <71ffc2acd355ceb2b0554b2410a772fd698aabd3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71ffc2acd355ceb2b0554b2410a772fd698aabd3.camel@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Dec 13, 2024 at 11:12:41AM +0000, David Woodhouse wrote:
> On Fri, 2024-12-13 at 11:42 +0100, Thomas Gleixner wrote:
> > 
> > That's the control thread on CPU0. The hotplug thread on CPU1 is stuck
> > here:
> > 
> >  task:cpuhp/1         state:D stack:0     pid:24    tgid:24    ppid:2      flags:0x00004000
> >  Call Trace:
> >   <TASK>
> >   __schedule+0x51f/0x1a80
> >   schedule+0x3a/0x140
> >   schedule_timeout+0x90/0x110
> >   msleep+0x2b/0x40
> >   blk_mq_hctx_notify_offline+0x160/0x3a0
> >   cpuhp_invoke_callback+0x2a8/0x6c0
> >   cpuhp_thread_fun+0x1ed/0x270
> >   smpboot_thread_fn+0xda/0x1d0
> > 
> > So something with those blk_mq fixes went sideways.
> 
>  $ git bisect bad
> 7678abee0867e6b7fb89aa40f6e9f575f755fb37 is the first bad commit
> commit 7678abee0867e6b7fb89aa40f6e9f575f755fb37 (HEAD)
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Tue Nov 12 20:58:21 2024 +0800
> 
>     virtio-blk: don't keep queue frozen during system suspend

The above commit just adds blk_mq_unfreeze_queue() in virtblk_freeze(),
which may wake up pending request allocation.

Seems frozen processes still can be woken up after suspend_freeze_processes()
returns, then new request allocation can't be completed because there
isn't good CPU for this allocation.

Is it expected to see frozen process to be wakeup during suspend?

If yes, the following patch may be helpful:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa340b097b6e..0cfc7a927e7e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -557,6 +557,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	if (tag == BLK_MQ_NO_TAG) {
 		if (data->flags & BLK_MQ_REQ_NOWAIT)
 			return NULL;
+
+		if (system_state != SYSTEM_RUNNING)
+			return NULL;
 		/*
 		 * Give up the CPU and sleep for a random short time to
 		 * ensure that thread using a realtime scheduling class


Thanks,
Ming


