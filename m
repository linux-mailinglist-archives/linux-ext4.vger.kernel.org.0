Return-Path: <linux-ext4+bounces-5596-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9919EFA5F
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 19:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7846173124
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25CA2288CD;
	Thu, 12 Dec 2024 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bz84LmJq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jmImqkd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763B22652F
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026701; cv=none; b=uqG7qJEnFDWt1z9aT6lapdmhX30Tsr9ncBV9EdAmCeYoc+ZsobcbC0sPMQOm/RKlR3E5FIfoNeGRHguv6GpWyVrMuij1m+UBgmuIDrFd7CvcTCh99c7vg/uNKQ8iIbai2jko5P1pOYzQgkZ5VxIo/vjHiIjqT+3LaY/kX9PuPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026701; c=relaxed/simple;
	bh=XM71HR3EjHGFNU+Y2prJ2jmIgXdxVISB7k1BuzKXkIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gxhxj1Z0XgpgXN2TwN4I4a/srFpdO62usfpsVambRuUrxrs7mfOISxUwgQeuxBjIHp1HU4NNO1u+kCeAea7nsMhK1ZIOXa4ICBG+YR94lrrGsYauDFfzuWFI4eqWfPSjZhlA1NhbbZgGZG3WIZNE8R5fUicIr+aTIf27x6Yj0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bz84LmJq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jmImqkd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734026696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYtUHevlD/VAi+BQIN1FQyz5FRV7Cxz6CcOV50CYjns=;
	b=bz84LmJqy0WgbpnPlL12Drayp6PdZXeOncH6+aJH2AW42ofiLIn/UzpiXx4qGBIwS/AZyQ
	LkpBXXvQWOpEOgqd85tAHfovIGCU9RebgtYAFsU7fbMztPpNXZuVtRl8P4uyJwa5hKpzGO
	z1h85VE0r+kIiQnpBMWTR4md5nuRJnX5x37mApezuilkulLSa/7yPwolcApBhPerqz3itw
	VMUlnKb6CiIqBdJRRWP8o4o4wNXssc7/T5sm8kIKheRH4llMqU38gj/yZmNf7fKChwHjJ1
	ycLLECfO7/5k8AYYRO+S7CC0yYwtpprF1zpH0SGHcZt+lFFYwfrozit8iJXTxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734026696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYtUHevlD/VAi+BQIN1FQyz5FRV7Cxz6CcOV50CYjns=;
	b=0jmImqkd7LLBEP58eu5FTlq0fFjlEsg1GOKACUNYIB6YPdezn/M4GCfFsykGaMZcltMDVy
	PAQLG/AAmnATNfAQ==
To: David Woodhouse <dwmw2@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung
 <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, linux-ext4
 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>, ming.lei@redhat.com, Petr Mladek
 <pmladek@suse.com>, John Ogness <jogness@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
In-Reply-To: <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
Date: Thu, 12 Dec 2024 19:04:55 +0100
Message-ID: <87a5d0aibc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 12 2024 at 13:46, David Woodhouse wrote:
> On Thu, 2024-12-12 at 14:34 +0100, Thomas Gleixner wrote:
>> 
>> David, can you retest with the debug patch below? That should pin-point
>> the real culprit.
>
> B[    1.545489] ------------[ cut here ]------------
> [    1.546338] DEBUG_LOCKS_WARN_ON(suspend_syscore_active)
> [    1.546375] WARNING: CPU: 0 PID: 18 at kernel/locking/lockdep.c:4471 lockdep_hardirqs_on+0x13a/0x140

Now this starts to be completely mysterious:

> [    1.571399]  finish_task_switch.isra.0+0xc4/0x2d0
> [    1.572062]  __schedule+0x50a/0x1a10

How on earth did this end up in schedule() on the rcu_gp_kthread between
syscore_suspend() and syscore_resume()?

> [    1.575896]  rcu_gp_fqs_loop+0x10b/0x5b0
> [    1.576455]  ? _raw_spin_unlock_irq+0x28/0x50
> [    1.577072]  rcu_gp_kthread+0xf8/0x1b0
> [    1.577621]  kthread+0xd5/0x100
> [    1.578066]  ? __pfx_kthread+0x10/0x10

I tried to reproduce, but failed. Do you have a simple reproducer
recipe?

Thanks,

        tglx

