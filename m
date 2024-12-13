Return-Path: <linux-ext4+bounces-5609-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D29F00AD
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 01:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611B7188B03A
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A5B3234;
	Fri, 13 Dec 2024 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yysfRy72";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bU1relTO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34F9621
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734048902; cv=none; b=j9n6aFdaNICCsST7ptzcoguZs3W4bwBw51dLNIaYgCRmzeDP7/f35OPdwxfL5fegYMPpdRZLSlgGBxrMVP6q9wmwx9m1nkZRfmBFhTtGlnliBqKHjb08/tmam035/lYgGYZiNZmcJZcxrcdEsXioSt/iTMeiSo/L38z7tRZhha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734048902; c=relaxed/simple;
	bh=bL4mYJfXhlbDr/nT1KRNQGSRD8eA+Pqv4XjJUX6v83U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZ8jT7/pia/ovjkZLvCjYc6OpOi9650kGip/vq7Z36siUk8qOlWSbtqsd8l5gyB39IaoFET+CbWeAA/jER2kwJhZT1mz5mqPMsdZ4u8eIhIm2BrzLu8gflCTup9kcmn/wUQouCxomvoQphaqhq0R7XCN2jlm+uv+yDVHeie4wG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yysfRy72; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bU1relTO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734048896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp3xPwocfjm9qhxrmFTFMUFGxqVLS1Y07azwxFJGGUM=;
	b=yysfRy72t9wmeVCIufe4FiZ2N/H9tlGvU8ULVf52glj6jBzhuGIJeIhBPs3HR+H2G/MaOy
	B+PpJp80Ac8CJPnBgZGbWCP+gVcpQQNZ6kbTZWyz9yYC6yqtgy0kjJGSMjK4H9KWVFf5nC
	BkqNTVGzT3Qr5TjpLsd+QpchACHYiyYcUT+cF4w+L2ttcK368VNj0aDEM7IChf3LyrkjXB
	5o61J44AHy/n5rBXBMys5zaP4JwEyAZVjdvOxxsfjpq6zkDD7/MMbpjsD0lT3dU/5wQpR6
	mVaIBzL9yZ2g1fWVI6XbQtacXA54TXgr0BEh0NFF5lh3Qse93XGi2i+tWndcjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734048896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp3xPwocfjm9qhxrmFTFMUFGxqVLS1Y07azwxFJGGUM=;
	b=bU1relTOVcEd3jjsdmiYy5byo54/SifkfCHU9sulH5/j/dPuZRedInu6pvV84tlJcCgLaX
	EEwRwySyGoHTjMDQ==
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
In-Reply-To: <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
Date: Fri, 13 Dec 2024 01:14:54 +0100
Message-ID: <874j38a16p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 12 2024 at 19:19, David Woodhouse wrote:
> On Thu, 2024-12-12 at 19:04 +0100, Thomas Gleixner wrote:
> Build current master (231825b2e1ff here). The config I'm using is at
> http://david.woodhou.se/config-x86-kjump-irqs although I don't think
> there's anything special other than CONFIG_KEXEC_JUMP and enough
> lockdep to trigger the complaints.
>
> I've been running in qemu with the test case shoved into an initrd for
> faster testing, but it works just as well done manually. If it matters,
> the QEMU command line on my Haswell box is
>
>  qemu-system-x86_64 -accel kvm,kernel-irqchip=split -display none \
>    -serial mon:stdio -kernel arch/x86/boot/bzImage -smp 2 -m 2g \
>    -append "console=ttyS0 root=/dev/vda1 no_console_suspend earlyprintk=serial" \
>    -drive file=/var/lib/libvirt/images/fedora.qcow2,if=virtio \
>    -cpu host --no-reboot -nic user,model=virtio 
>
> Probably the only important part of that is the no_console_suspend.

I misread that and somehow thought it does _not_ happen with
no_console_suspend. Duh!

So that made it reproduce and after adding some more lockdep hacks here
is the culprit:

[   15.177945] DEBUG_LOCKS_WARN_ON(suspend_syscore_active)
[   15.178980] CPU: 0 UID: 0 PID: 410 Comm: k.1 Not tainted 6.13.0-rc2+ #118
[   15.185613] Call Trace:
[   15.185760]  <TASK>
[   15.187678]  __cond_resched+0x21/0x60
[   15.187923]  down_timeout+0x18/0x60
[   15.188159]  acpi_os_wait_semaphore+0x4c/0x80
[   15.188424]  acpi_ut_acquire_mutex+0x3d/0x100
[   15.188665]  acpi_ns_get_node+0x27/0x60
[   15.188879]  acpi_ns_evaluate+0x1cb/0x2d0
[   15.189106]  acpi_rs_set_srs_method_data+0x156/0x190
[   15.189382]  acpi_pci_link_set+0x11c/0x290
[   15.189618]  irqrouter_resume+0x54/0x60
[   15.189826]  syscore_resume+0x6a/0x200
[   15.190033]  kernel_kexec+0x145/0x1c0
[   15.190239]  __do_sys_reboot+0xeb/0x240
[   15.190561]  do_syscall_64+0x95/0x180

This is a long standing problem, which probably got more visible with
the recent printk changes. Something does a wakeup and the scheduler
sets the NEED_RESCHED flag.

cond_resched() sees it set and invokes schedule() from a completely bogus
context.

Nothing knowns about the current system state and therefore happily
assumes that everything is cool and shiny.

I also found that kexec jump fails to set system_state = SYSTEM_SUSPEND
before syscore_suspend() and back to SYSTEM_RUNNING after
syscore_resume().  See suspend/hibernate...

But setting this does not solve the problem because NEED_RESCHED still
gets set and cond_resched() is oblivious of the state.

Quite some of the code paths in syscore_suspend()/resume() can result in
triggering a wakeup with the exactly same consequences. They might not
have done so yet, but as they share a lot of code with normal operation
it's just a question of time.

And of course then you need a code path which is invoked after that,
which actually invokes cond_resched().

Adding more debug, there are indeed a couple of ways to set NEED_RESCHED
between invoking syscore_suspend() and returning from syscore_resume().
Some stuff schedules work [un]conditonally.

So the real question is how to deal with the general problem, which
obviously affects suspend as well.

The only thing I came up with so far is the hack below. It cures the
problem for PREEMPT_NONE and PREEMPT_VOLUNTARY. PREEMPT_FULL is not
affected because preemptible() checks whether the preemption count is
zero and interrupts are enabled and cond_resched() not active.

We could check for interrupts enabled in cond_resched() too, but that's
not pretty either.

With that applied the problem goes away, but after a lot of repetitions
of the reproducer in a tight loop the whole machinery stops dead:

[   29.913179] Disabling non-boot CPUs ...
[   29.930328] smpboot: CPU 1 is now offline
[   29.930593] crash hp: kexec_trylock() failed, kdump image may be inaccurate
B[   29.940588] Enabling non-boot CPUs ...
[   29.940856] crash hp: kexec_trylock() failed, kdump image may be inaccurate
[   29.941242] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   29.942654] CPU1 is up
[   29.945856] virtio_blk virtio1: 2/0/0 default/read/poll queues
[   29.948556] OOM killer enabled.
[   29.948750] Restarting tasks ... done.
Success
[   29.960044] Freezing user space processes
[   29.961447] Freezing user space processes completed (elapsed 0.001 seconds)
[   29.961861] OOM killer disabled.
[   30.102485] ata2: found unknown device (class 0)
[   30.107387] Disabling non-boot CPUs ...

That happens without 'no_console_suspend' on the command line as
well, but that's for tomorrow ...

Thanks,

        tglx
---
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1025,6 +1025,7 @@ int kernel_kexec(void)
 		if (error)
 			goto Enable_cpus;
 		local_irq_disable();
+		system_state = SYSTEM_SUSPEND;
 		error = syscore_suspend();
 		if (error)
 			goto Enable_irqs;
@@ -1054,6 +1055,7 @@ int kernel_kexec(void)
 	if (kexec_image->preserve_context) {
 		syscore_resume();
  Enable_irqs:
+		system_state = SYSTEM_RUNNING;
 		local_irq_enable();
  Enable_cpus:
 		suspend_enable_secondary_cpus();
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7276,7 +7276,7 @@ void rt_mutex_setprio(struct task_struct
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 int __sched __cond_resched(void)
 {
-	if (should_resched(0)) {
+	if (should_resched(0) && system_state != SYSTEM_SUSPEND) {
 		preempt_schedule_common();
 		return 1;
 	}

