Return-Path: <linux-ext4+bounces-5588-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF49EE7C1
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 14:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD425282D8B
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB362135BE;
	Thu, 12 Dec 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Il3P1Cya";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NUuAh1PJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84921171A
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010499; cv=none; b=UySSHRRIM2Ca6/lVGvtx1eMbJp+CGGOG1+82DQCmU3vLgzbZHV43meTAjjeLd4pKL8ioEaGxdcvffUtZdWkjDYe4ZskS4FLPXmId7U+T9LfSbTXNgP1DYHjrVDabSores7Pqbm09L8eTcWN3LPYf0P9Nu7yfQjEErq6qYvkwJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010499; c=relaxed/simple;
	bh=4Y0SsUck5t/uAYfEHGBMYSFaoHRhFGa7LPS2FJ3iPHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UKVlh4IRWwWCdfnINI2PyJaeG8qXvvnb4rsL4yMR61huQEOXLLH7/pLL1+ylg/c9jR2BQ8ODTthf36x8cvOXMED9OqJ0OWCQFJf9FB29Uz+s/Az8rmBwBPRGAlopUtkVCZmzc5xqP3pFcSJeOi1nh+fEhjzP9mleafLE9WVN+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Il3P1Cya; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NUuAh1PJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734010488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/YEAnqap/rJ6jgVfRLP4W7QHOS4ftUKdpWunMcNvtU=;
	b=Il3P1CyaevdersvL/SRpL7+8iQ8DV3SRlEeiCcQqcbHMPzcw6qfvxHfkJFmefSsKKWCUwC
	ZlP7AeyWLG5Sqw+GTPyFE0q8H4wivKFeo2W/G7t7HBtaUJNuuAvTejdEGRxtcCy6W7w3Cw
	AyvFapSH1HTCueINuBRhGGr9P//Vhl7ZKZv4JJmwjmaxcRtdDTIKwD0VOXrkyfEAhe8mAU
	MP0h3g6265QdnBYtm7PKVc0+V+hkIEKC7sOnqtWH6u/CLg/vgjWrVPrRXnJRPNKdx7zaBs
	3rCHpg1gXXxTxu4qogTZv3+lTyRscX9KBpLmtO679LKIBUWu+YZoZKWpMCEzsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734010488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/YEAnqap/rJ6jgVfRLP4W7QHOS4ftUKdpWunMcNvtU=;
	b=NUuAh1PJpGgewv1eN45gGVtKj8o9wUe2H9R9SaVGmw1eG0w4iRwPEqRQyaIDt7FTovkKhF
	Xs2VNEqZmgxOH/Bg==
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
In-Reply-To: <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
Date: Thu, 12 Dec 2024 14:34:48 +0100
Message-ID: <87ldwl9g93.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

CC+ printk folks

On Thu, Dec 12 2024 at 11:07, David Woodhouse wrote:
> On Wed, 2024-12-11 at 07:42 -0500, Stefan Hajnoczi wrote:
>> On Tue, Dec 10, 2024 at 09:56:43AM +0800, Jason Wang wrote:
>> > Adding more virtio-blk people here.
>>=20
>> Please try Ming Lei's recent fix in Jens' tree:
>>=20
>> =C2=A0 virtio-blk: don't keep queue frozen during system suspend
>> =C2=A0 commit: 7678abee0867e6b7fb89aa40f6e9f575f755fb37
>>=20
>> https://git.kernel.dk/cgit/linux/commit/?h=3Dblock-6.13&id=3D7678abee086=
7e6b7fb89aa40f6e9f575f755fb37
>
> Thanks. That does make those warnings go away. I do still get this one
> occasionally though. It seems to go away without 'no_console_suspend'
> on the command line, but I'm not sure that makes it OK.

Not really.

> [   23.665790] Interrupts enabled after irqrouter_resume+0x0/0x50

The resume callback irqrouter_resume() returns with interrupts enabled,
but it's absolutely unclear where this happens. The lockdep tracking is
not really helpful:

> [   23.697043] hardirqs last  enabled at (15573): [<ffffffffa8281b8e>] __=
up_console_sem+0x7e/0x90
> [   23.697855] hardirqs last disabled at (15580): [<ffffffffa8281b73>] __=
up_console_sem+0x63/0x90

__up_console_sem()
{
	printk_safe_enter_irqsave(flags);       // Assuming this is __up_console_s=
em+0x63/0x90
                                                // Saves state in @flags an=
d disables interrupts
        up(&console_sem);
        printk_safe_exit_irqrestore(flags);     // Assuming this is __up_co=
nsole_sem+0x7e/0x90
                                                // Restores the interrupt s=
tate from @flags
}

Though the events are in reverse order:

    last enabled  at 15573
    last disabled at 15580

At event #15573 printk_safe_exit_irqrestore(flags) enabled interrupts,
which means the preceeding printk_safe_enter_irqsave(flags) was invoked
with interrupts enabled. But that enable event wiped the real culprit,
which enabled interrupts before __up_console_sem() was invoked.

At event #15580 printk_safe_enter_irqsave(flags); disables interrupts
again, which is probably at the point where printk() dumps the bug, but
I might be misreading this.

Now David's observation that the problem "goes away" when he adds
"no_console_suspend" on the command line is definitely interesting, but
does not really help in figuring out the root cause.

> [   23.698673] softirqs last  enabled at (14798): [<ffffffffa81c6c12>] __=
irq_exit_rcu+0xe2/0x100
> [   23.699481] softirqs last disabled at (14777): [<ffffffffa81c6c12>] __=
irq_exit_rcu+0xe2/0x100
> [   23.700284] ---[ end trace 0000000000000000 ]---
> [   23.702460] ------------[ cut here ]------------
> [   23.702963] WARNING: CPU: 0 PID: 560 at kernel/time/hrtimer.c:995 hrti=
mers_resume_local+0x29/0x40

This one is just a consequence of the above.

David, can you retest with the debug patch below? That should pin-point
the real culprit.

Thanks,

        tglx
---
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -621,6 +621,9 @@ do {									\
=20
 extern void lockdep_assert_in_softirq_func(void);
=20
+extern void lockdep_suspend_syscore_enter(void);
+extern void lockdep_suspend_syscore_exit(void);
+
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
@@ -635,6 +638,8 @@ extern void lockdep_assert_in_softirq_fu
 # define lockdep_assert_preemption_disabled() do { } while (0)
 # define lockdep_assert_in_softirq() do { } while (0)
 # define lockdep_assert_in_softirq_func() do { } while (0)
+static inline void lockdep_suspend_syscore_enter(void) { }
+static inline void lockdep_suspend_syscore_exit(void) { }
 #endif
=20
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1025,6 +1025,7 @@ int kernel_kexec(void)
 		if (error)
 			goto Enable_cpus;
 		local_irq_disable();
+		lockdep_suspend_syscore_enter();
 		error =3D syscore_suspend();
 		if (error)
 			goto Enable_irqs;
@@ -1054,6 +1055,7 @@ int kernel_kexec(void)
 	if (kexec_image->preserve_context) {
 		syscore_resume();
  Enable_irqs:
+		lockdep_suspend_syscore_exit();
 		local_irq_enable();
  Enable_cpus:
 		suspend_enable_secondary_cpus();
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4408,6 +4408,18 @@ void lockdep_hardirqs_on_prepare(void)
 }
 EXPORT_SYMBOL_GPL(lockdep_hardirqs_on_prepare);
=20
+static bool suspend_syscore_active;
+
+void noinstr lockdep_suspend_syscore_enter(void)
+{
+	suspend_syscore_active =3D true;
+}
+
+void noinstr lockdep_suspend_syscore_exit(void)
+{
+	suspend_syscore_active =3D false;
+}
+
 void noinstr lockdep_hardirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace =3D &current->irqtrace;
@@ -4456,6 +4468,8 @@ void noinstr lockdep_hardirqs_on(unsigne
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
=20
+	DEBUG_LOCKS_WARN_ON(suspend_syscore_active);
+
 	/*
 	 * Ensure the lock stack remained unchanged between
 	 * lockdep_hardirqs_on_prepare() and lockdep_hardirqs_on().

