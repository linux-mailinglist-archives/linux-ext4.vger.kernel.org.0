Return-Path: <linux-ext4+bounces-5629-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297829F1329
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 18:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6141718840ED
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4A1BBBFD;
	Fri, 13 Dec 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YgnvdUm+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zxfGSe97"
X-Original-To: linux-ext4@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9A1E379B
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109526; cv=none; b=nvVRWfYZVvIDyNFyoX6X3nLeAFttrewHiK/ziGkxR2rdTmVJwauq7nE+NJGdCPHXCGh869WjAdvHpjyl4WsZHloy2hUizzF2aT9E9dBpo4eDSX22rBxMyoUJdg1wakJ8lwRNZrGdiVx7lH3us+9qLe16/rXeH7lcqP8m+qoWGgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109526; c=relaxed/simple;
	bh=UEBzdJm/OuY2Dfp0sAR4lMwSSUb1hOjpfAJqq8BwbRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1S+iHlM9hq4rkKWREi2lgCqkxQ17EhWwR3NddE1Scexkh9S/4MZoaT+H81vABW/nPFbPcxPSXOUndAV0imbZXrAeTNVYzRWlI7Bxb82zgDsIi1X5GKrWyxlozEyRNOAIx5gzTHgDhlafvPrVdsR643iZGNseKi+VctviWMxiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YgnvdUm+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zxfGSe97; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734109516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBdPKun67Css+5UrWluOU97YS8JcEMaunCozIMvAfes=;
	b=YgnvdUm+LN9E0ZzXRi0mQu63bQ3o9/1zHKRQOyOFfK8QFbrrOJUUzGGJCxCgzvBq6gceEH
	RU6Uo4xBAy8ABgKgqYiXX+PyGcP8evnrm0kV/DeUN6OebuBtSBnRvDTXdCtLpv+1st6yl3
	wqrHiP3amOq+v1yJ+eiKn+m+jyV521s5NdQpL8T8mPAum26uO9QAkZUaVR9gUZZNasiBxr
	MFJcpuKb+PHuMkVFmvSGNo9oXTbasLG1RxkeUR4kcaTvMckiCJcqQD+K1KN7LBickpcLOA
	cos6oC9j7DUpgFSsm7+HfG+Qmt4gv0AGAZQCAxuHegkGTmkWONJKnMWTuzOGgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734109516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBdPKun67Css+5UrWluOU97YS8JcEMaunCozIMvAfes=;
	b=zxfGSe97sv3CS47QxpMY8c478RrS5aaKo49ftvSRPwi4lGlfh8Ylm/UPBhc9CoaRFnC46t
	gsLH6+gj3zSguxAg==
To: David Woodhouse <dwmw2@infradead.org>, Ming Lei <ming.lei@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung
 <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, linux-ext4
 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, John
 Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Jens
 Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
In-Reply-To: <1a7c126f3ab8ae75e755d01a6bf9bc06730dd239.camel@infradead.org>
References: <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx>
 <Z1wfF6NJRZh1jROz@fedora> <87pllv90ow.ffs@tglx>
 <1a7c126f3ab8ae75e755d01a6bf9bc06730dd239.camel@infradead.org>
Date: Fri, 13 Dec 2024 18:05:15 +0100
Message-ID: <87msgz8qes.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13 2024 at 14:07, David Woodhouse wrote:
> On Fri, 2024-12-13 at 14:23 +0100, Thomas Gleixner wrote:
>> That's only true for the case where the new kernel takes over.
>>=20
>> In the case KEXEC_JUMP=3Dn and kexec_image->preserve_context =3D=3D true=
, then
>> it is supposed to align with suspend/resume and if you look at the code
>> then it actually mimics suspend/resume in the most dilettanteish way.
>
> Did you mean KEXEC_JUMP=3Dy there?

Yes, of course.

> I spent a while the other week trying to understand the case where
> CONFIG_KEXEC_JUMP=3Dn and kexec_image->preserve_context=3Dtrue, and came =
to
> the conclusion that it was a mirage. Userspace can't *actually* set the
> KEXEC_PRESERVE_CONTEXT bit when setting up the image, if KEXEC_JUMP=3Dn.
>
> The whole of the code path for that case is dead code. It's confusing
> because as discussed elsewhere, we don't just #ifdef out the whole of
> that dead code path, but only the bits which don't actually *compile*
> (like references to restore_processor_state() etc.).

Yes, I had to stare at it quite a while. :)

>> It's a patently bad idea to clobber the kernel with kexec jump "fixes"
>> instead of using the well tested and established suspend/resume
>> machinery.
>>=20
>> All it takes is to:
>>=20
>> =C2=A0=C2=A0=C2=A0 1) disable the wakeup logic
>>=20
>> =C2=A0=C2=A0=C2=A0 2) provide a mechanism to invoke machine_kexec() inst=
ead of the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 actual suspend mechanism.
>>=20
>> No?
>
> Agreed. The hacky proof of concept I posted earlier invoking
> machine_kexec() instead of suspend_ops->enter() works fine. I'll look
> at cleaning it up and making it not invoke all the ACPI hooks for
> *actual* suspend to RAM, etc.

Something like the below? It survived an hour of loop testing.

> As I noted though, it doesn't address that linux-scsi report which was
> a *real* kexec, not a kjump.

I was not looking at that path at all.

Thanks,

        tglx
---
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -582,4 +582,7 @@ enum suspend_stat_step {
 void dpm_save_failed_dev(const char *name);
 void dpm_save_failed_step(enum suspend_stat_step step);
=20
+int kexec_suspend(void);
+void kexec_machine_execute(void);
+
 #endif /* _LINUX_SUSPEND_H */
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -984,6 +984,12 @@ bool kexec_load_permitted(int kexec_imag
 	return true;
 }
=20
+void kexec_machine_execute(void)
+{
+	kmsg_dump(KMSG_DUMP_SHUTDOWN);
+	machine_kexec(kexec_image);
+}
+
 /*
  * Move into place and start executing a preloaded standalone
  * executable.  If nothing was preloaded return an error.
@@ -999,38 +1005,9 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
=20
-#ifdef CONFIG_KEXEC_JUMP
-	if (kexec_image->preserve_context) {
-		pm_prepare_console();
-		error =3D freeze_processes();
-		if (error) {
-			error =3D -EBUSY;
-			goto Restore_console;
-		}
-		suspend_console();
-		error =3D dpm_suspend_start(PMSG_FREEZE);
-		if (error)
-			goto Resume_console;
-		/* At this point, dpm_suspend_start() has been called,
-		 * but *not* dpm_suspend_end(). We *must* call
-		 * dpm_suspend_end() now.  Otherwise, drivers for
-		 * some devices (e.g. interrupt controllers) become
-		 * desynchronized with the actual state of the
-		 * hardware at resume time, and evil weirdness ensues.
-		 */
-		error =3D dpm_suspend_end(PMSG_FREEZE);
-		if (error)
-			goto Resume_devices;
-		error =3D suspend_disable_secondary_cpus();
-		if (error)
-			goto Enable_cpus;
-		local_irq_disable();
-		error =3D syscore_suspend();
-		if (error)
-			goto Enable_irqs;
-	} else
-#endif
-	{
+	if (IS_ENABLED(CONFIG_KEXEC_JUMP) && kexec_image->preserve_context) {
+		error =3D kexec_suspend();
+	} else {
 		kexec_in_progress =3D true;
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
@@ -1045,30 +1022,10 @@ int kernel_kexec(void)
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
+		kexec_machine_execute();
 	}
=20
-	kmsg_dump(KMSG_DUMP_SHUTDOWN);
-	machine_kexec(kexec_image);
-
-#ifdef CONFIG_KEXEC_JUMP
-	if (kexec_image->preserve_context) {
-		syscore_resume();
- Enable_irqs:
-		local_irq_enable();
- Enable_cpus:
-		suspend_enable_secondary_cpus();
-		dpm_resume_start(PMSG_RESTORE);
- Resume_devices:
-		dpm_resume_end(PMSG_RESTORE);
- Resume_console:
-		resume_console();
-		thaw_processes();
- Restore_console:
-		pm_restore_console();
-	}
-#endif
-
- Unlock:
+Unlock:
 	kexec_unlock();
 	return error;
 }
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -400,7 +400,7 @@ void __weak arch_suspend_enable_irqs(voi
  *
  * This function should be called after devices have been suspended.
  */
-static int suspend_enter(suspend_state_t state, bool *wakeup)
+static int suspend_enter(suspend_state_t state, bool *wakeup, bool kexec_j=
ump)
 {
 	int error;
=20
@@ -445,15 +445,19 @@ static int suspend_enter(suspend_state_t
=20
 	error =3D syscore_suspend();
 	if (!error) {
-		*wakeup =3D pm_wakeup_pending();
-		if (!(suspend_test(TEST_CORE) || *wakeup)) {
-			trace_suspend_resume(TPS("machine_suspend"),
-				state, true);
-			error =3D suspend_ops->enter(state);
-			trace_suspend_resume(TPS("machine_suspend"),
-				state, false);
-		} else if (*wakeup) {
-			error =3D -EBUSY;
+		if (IS_ENABLED(CONFIG_KEXEC_JUMP) && kexec_jump) {
+			kexec_machine_execute();
+		} else {
+			*wakeup =3D pm_wakeup_pending();
+			if (!(suspend_test(TEST_CORE) || *wakeup)) {
+				trace_suspend_resume(TPS("machine_suspend"),
+						     state, true);
+				error =3D suspend_ops->enter(state);
+				trace_suspend_resume(TPS("machine_suspend"),
+						     state, false);
+			} else if (*wakeup) {
+				error =3D -EBUSY;
+			}
 		}
 		syscore_resume();
 	}
@@ -485,7 +489,7 @@ static int suspend_enter(suspend_state_t
  * suspend_devices_and_enter - Suspend devices and enter system sleep stat=
e.
  * @state: System sleep state to enter.
  */
-int suspend_devices_and_enter(suspend_state_t state)
+static int __suspend_devices_and_enter(suspend_state_t state, bool kexec_j=
ump)
 {
 	int error;
 	bool wakeup =3D false;
@@ -514,7 +518,7 @@ int suspend_devices_and_enter(suspend_st
 		goto Recover_platform;
=20
 	do {
-		error =3D suspend_enter(state, &wakeup);
+		error =3D suspend_enter(state, &wakeup, kexec_jump);
 	} while (!error && !wakeup && platform_suspend_again(state));
=20
  Resume_devices:
@@ -536,6 +540,15 @@ int suspend_devices_and_enter(suspend_st
 }
=20
 /**
+ * suspend_devices_and_enter - Suspend devices and enter system sleep stat=
e.
+ * @state: System sleep state to enter.
+ */
+int suspend_devices_and_enter(suspend_state_t state)
+{
+	return __suspend_devices_and_enter(state, false);
+}
+
+/**
  * suspend_finish - Clean up before finishing the suspend sequence.
  *
  * Call platform code to clean up, restart processes, and free the console=
 that
@@ -607,6 +620,21 @@ static int enter_state(suspend_state_t s
 	return error;
 }
=20
+#ifdef CONFIG_KEXEC_JUMP
+int kexec_suspend(void)
+{
+	int error;
+
+	ksys_sync_helper();
+	error =3D freeze_processes();
+	if (error)
+		return error;
+	error =3D __suspend_devices_and_enter(PM_SUSPEND_MEM, true);
+	thaw_processes();
+	return error;
+}
+#endif
+
 /**
  * pm_suspend - Externally visible function for suspending the system.
  * @state: System sleep state to enter.



