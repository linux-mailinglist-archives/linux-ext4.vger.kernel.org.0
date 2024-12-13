Return-Path: <linux-ext4+bounces-5617-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B969F0AC7
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 12:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2264169D38
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3565D1DDC32;
	Fri, 13 Dec 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cwbEbcwY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ABF1DDC26
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088834; cv=none; b=uTutWUg1Kr+kPZYIe2mtmJe65g/06RTd1oenn3YSXb+49DL/9fEl42IwwfF4dp0d4Jsfi/gWWcJsOVp7t/kWpskBNFdeQygm0Lvogf6a28+EKzACkI3CxWFtIsrvzv2Few5jHUvJetiPfodNaFlrzwTEghu5CythFyYqJfFUWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088834; c=relaxed/simple;
	bh=eg4W9f1jDnJzzZ4g1xKPUPXcksmsk3KvDYWD+bOxVTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEYH8448jR5W4noklCcBaqJEM9t9gaZto2imDzdbuAb6XGzIVg03mSmbAcLHYPUS4x4qXovixMXyqu8OdHsBunVg3ypTETUOkcPnttB7bsgru1dn177+6l0OK75qozmWoIuSmvO2wtDUY89fv3NQeuv2zUKQFTnmCkX5YSKbSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cwbEbcwY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3E5inui+/Uaht5Te51wP/9nA3zKpMlHtnK0zFj+UdQ4=; b=cwbEbcwYkE8yAW/AuxrDbnSI7R
	tScVCTQss0nj07HYf8Qi5HzVfcREk8u81GASn9GBESjY0mvtrlOi7TN+WfN1iLA+GCjgp4SaMfIyw
	6/zFPqvLaqNKAyhTAD9hsdREjH+NnTxlylncMhXIgGLWC9fu48Oe3hQsC71wa5vJtYBOmMNm3ikkr
	5WZEp/vj5i/+uaCobXF12tEWfLmCkvlgPO5lu3F+UUleAQgpK3E8O0XPpFu+5PZtJ6PGGYq3FHIjk
	WQBWPeFKOFYP0QAjqX9NlpeFf0dGGs6opipZcXBHerEq840XSnCEBmatKM4j8UdOPF7ktaXpPaRD/
	XeA87Kmg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3if-0000000CTta-0ZKq;
	Fri, 13 Dec 2024 11:20:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38AA830049D; Fri, 13 Dec 2024 12:20:28 +0100 (CET)
Date: Fri, 13 Dec 2024 12:20:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
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
	ming.lei@redhat.com, Petr Mladek <pmladek@suse.com>,
	John Ogness <jogness@linutronix.de>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
Message-ID: <20241213112028.GE21636@noisy.programming.kicks-ass.net>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j38a16p.ffs@tglx>

On Fri, Dec 13, 2024 at 01:14:54AM +0100, Thomas Gleixner wrote:

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7276,7 +7276,7 @@ void rt_mutex_setprio(struct task_struct
>  #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
>  int __sched __cond_resched(void)
>  {
> -	if (should_resched(0)) {
> +	if (should_resched(0) && system_state != SYSTEM_SUSPEND) {
>  		preempt_schedule_common();
>  		return 1;
>  	}

Perhaps we should just do:

	if (should_resched(0) && !irqs_disabled())

That's more or less what preemptible() does too. Yes, mucking about with
IF is expensive, but it's only done if preempt_count is agreeing we
should schedule, which it shouldn't be most of the time.

