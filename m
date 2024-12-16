Return-Path: <linux-ext4+bounces-5668-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7369F3166
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 14:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3987F7A2B1F
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDECF204C2C;
	Mon, 16 Dec 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oWdlwB4c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HU1NTDnL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0FF204C25
	for <linux-ext4@vger.kernel.org>; Mon, 16 Dec 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355261; cv=none; b=JFS3V5vA2p1pBkN66sbv7IgMQhRjMqcGih4MJPEBwYFNwfHqr7XEEf/81X9JMpPq3e5oEWIkhTGc9dPHooK0Ulw4atA2YAKVqF7dIWa98BjeOw0YtQw0UKxpXeN7Wg+iCnI4Y6MCp7DMo0gtfIqWsNbV5iPfjiGAzt5kFrbt9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355261; c=relaxed/simple;
	bh=D0o9Zf4NOUYwvxRhSMnrvg//Zsmdyl7Ko61gDuMa7QQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EgaD4o4AqYsy5S59XuU5MrGDv92XYxR5DRSePGovishQ2EEwwwtcrFm8QUmXLqezaqs06EBZybupXQWjnMHB5JvSjXs+5tlIBD/O7LQw1BGUhtswvdIS1EfIHTPCpLVi8FE6bFuOuujsa2WIa684sNPpMWb41+Ut0xRVVlZKP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oWdlwB4c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HU1NTDnL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734355256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SR4BYJA56VrvqQ4ml6U2AYvWFpo838DUlVvuAgtV018=;
	b=oWdlwB4cjjAzveebQzRVbyMbJ2H6W7Zxtm9ybHHZeHLXv9wLqt1Ockqs57yN80drVauxRq
	HTYdeimcZh4aoKw0BmHhfmVZ6bTllEBZVIDkSCEkmKXawILCjJG2Y6nI7hq22edVdxfqDK
	MpxNdT2Ekv5WnUidt/IOHjIa7c0uweesDxjhw5qDpKBN/G3YVBCW45krmLaI6oxwXslJ13
	/4zBOkaf2bvGp8CXamX+cuWNMYqfcyC5wencDVfCtdrOZhjMth3LtPCzrL8T6nQffOQ74d
	0tHoa+pD7am5+rKix526mRqKydYvO5dDoRwhcG+Emc88YndgPT9COdk2BPxniA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734355256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SR4BYJA56VrvqQ4ml6U2AYvWFpo838DUlVvuAgtV018=;
	b=HU1NTDnLFv7Qvrwyti0VGD5srlAwrHQgRIb3B38UWenC9CMYUjffp+tc9UlQ8miZRhSj+J
	GwVZuXZ6UI4e0oAg==
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, "x86@kernel.org"
 <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, kexec
 <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, Paolo Bonzini
 <bonzini@redhat.com>, ming.lei@redhat.com, Petr Mladek <pmladek@suse.com>,
 John Ogness <jogness@linutronix.de>
Subject: [PATCH] sched: Prevent rescheduling when interrupts are disabled
In-Reply-To: <87seqr914v.ffs@tglx>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <20241213112028.GE21636@noisy.programming.kicks-ass.net>
 <87seqr914v.ffs@tglx>
Date: Mon, 16 Dec 2024 14:20:56 +0100
Message-ID: <87a5cv932f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David reported a warning observed while loop testing kexec jump:

  Interrupts enabled after irqrouter_resume+0x0/0x50
  WARNING: CPU: 0 PID: 560 at drivers/base/syscore.c:103 syscore_resume+0x18a/0x220
   kernel_kexec+0xf6/0x180
   __do_sys_reboot+0x206/0x250
   do_syscall_64+0x95/0x180

The corresponding interrupt flag trace:

  hardirqs last  enabled at (15573): [<ffffffffa8281b8e>] __up_console_sem+0x7e/0x90
  hardirqs last disabled at (15580): [<ffffffffa8281b73>] __up_console_sem+0x63/0x90

That means __up_console_sem() was invoked with interrupts enabled. Further
instrumentation revealed that in the interrupt disabled section of kexec
jump one of the syscore_suspend() callbacks woke up a task, which set the
NEED_RESCHED flag. A later callback in the resume path invoked
cond_resched() which in turn led to the invocation of the scheduler:

  __cond_resched+0x21/0x60
  down_timeout+0x18/0x60
  acpi_os_wait_semaphore+0x4c/0x80
  acpi_ut_acquire_mutex+0x3d/0x100
  acpi_ns_get_node+0x27/0x60
  acpi_ns_evaluate+0x1cb/0x2d0
  acpi_rs_set_srs_method_data+0x156/0x190
  acpi_pci_link_set+0x11c/0x290
  irqrouter_resume+0x54/0x60
  syscore_resume+0x6a/0x200
  kernel_kexec+0x145/0x1c0
  __do_sys_reboot+0xeb/0x240
  do_syscall_64+0x95/0x180

This is a long standing problem, which probably got more visible with
the recent printk changes. Something does a task wakeup and the
scheduler sets the NEED_RESCHED flag. cond_resched() sees it set and
invokes schedule() from a completely bogus context. The scheduler
enables interrupts after context switching, which causes the above
warning at the end.

Quite some of the code paths in syscore_suspend()/resume() can result in
triggering a wakeup with the exactly same consequences. They might not
have done so yet, but as they share a lot of code with normal operations
it's just a question of time.

The problem only affects the PREEMPT_NONE and PREEMPT_VOLUNTARY scheduling
models. Full preemption is not affected as cond_resched() is disabled and
the preemption check preemptible() takes the interrupt disabled flag into
account.

Cure the problem by adding a corresponding check into cond_resched().

Reported-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: David Woodhouse <dwmw2@infradead.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org
---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7276,7 +7276,7 @@ void rt_mutex_setprio(struct task_struct
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 int __sched __cond_resched(void)
 {
-	if (should_resched(0)) {
+	if (should_resched(0) && !irqs_disabled()) {
 		preempt_schedule_common();
 		return 1;
 	}

