Return-Path: <linux-ext4+bounces-5633-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BCE9F1496
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 19:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A43280A1B
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B941E572F;
	Fri, 13 Dec 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0mTG0dG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88071E3775
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112785; cv=none; b=DSMgAmRHN+7+2cSkK/HB8a5rVUu9fZtnUH8s0ysT/0G6loCVlfPn/0LxmuqMp2Q7ta60fDM6mnIbQBY51CmjiUrE0L3UO1/DWnXgj4q0uHa4rmXUwz/cy06/CkyPMU/jiOwG7Yb5kRXjs2tSoajSqs+HWkBcPxM5HKaPgHbgw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112785; c=relaxed/simple;
	bh=zjLjGC0Wm6Penyvi0bRtriixu877r0yDPXOAbxTyqI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNwIOc4eaTmO3Y8AS9P++7yjqHSRb5RKTvkFxHxJ8S12qpRDgVv+11q5hr8SlymmIUk4BGFcQjEckwxelZAiSA9y8MsXMtatfV8OY/R2jEztQp3vb+2amYZg8M8gZQxbxjk9PeR0GrmHGZK8xlV61ynm9u8bLrQF+81G8PzZjZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0mTG0dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373B8C4AF09
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734112785;
	bh=zjLjGC0Wm6Penyvi0bRtriixu877r0yDPXOAbxTyqI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p0mTG0dGdoW/EvRnuc0qIjSxkk3cebKdEwFeLDDGuNiFRgmwV8NJqKi9gL4PyqG/S
	 aoH7UnUzjpWhV54spkjj5T8Mzr6/7/o/28ygFAd9nQXcOxuxkL5Qh5Ym9z3mBXp2L5
	 iZfcu6RZnxSpfibiM3zZ55qCvmfOD/OrllMDT7hrBTHuDQ4ipFcQRR4SitT4pT9gji
	 YyvOYF8YJZQC+MGS7DPstmf5yDRwnoLL66tZbQmYmnVBqxIODbD+LaXABi1LtBLCSw
	 HCU3/w3ksCAtY3dDF/cKExfZ/XSc2QrTzhR2xygsF+m1p6Za3USyLm1CqLRQmnlmJf
	 iUhB67wyoONbA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71e16519031so1022002a34.1
        for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 09:59:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0gyWSLFSK/MydUK8CdqO6WSLT6skV0iqVmUU2q1sEuw2IrB9J3jw5E7JPdLJyVBnfw3Ki0rhY76VB@vger.kernel.org
X-Gm-Message-State: AOJu0YybHgPzRQzbtezPA5Ad8QrgiiGPB1soe9QLZRYahphwVhDGp5W1
	/W3YzAxJx7Y2GAat6a1/j5J/kdh01ioaPXAMpnKgrKRqZ4Zunr4GJRqrgmpS10St78bruw0iofK
	Is/qTOnu1ZLWcVriPyHlb6LQhEbg=
X-Google-Smtp-Source: AGHT+IEWAd2R9BR7Iaj9OVW49dsexlbRcPKSmbWA8Me9y7Ru3dGZGKbl8MnJIyW56VdF9Az4aKYXmPytttxMu+PnQ0c=
X-Received: by 2002:a05:6830:350e:b0:718:9160:a3e6 with SMTP id
 46e09a7af769-71e36ab9d99mr2677674a34.0.1734112784405; Fri, 13 Dec 2024
 09:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldwl9g93.ffs@tglx> <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx> <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx> <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx>
 <Z1wfF6NJRZh1jROz@fedora> <87pllv90ow.ffs@tglx> <1a7c126f3ab8ae75e755d01a6bf9bc06730dd239.camel@infradead.org>
 <87msgz8qes.ffs@tglx>
In-Reply-To: <87msgz8qes.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 18:59:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_USMctXJr+gUZDM+AONk4wWH=a1+oZjCoJg+XZ5jmEw@mail.gmail.com>
Message-ID: <CAJZ5v0j_USMctXJr+gUZDM+AONk4wWH=a1+oZjCoJg+XZ5jmEw@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Ming Lei <ming.lei@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, 
	kexec <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 6:05=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Fri, Dec 13 2024 at 14:07, David Woodhouse wrote:
> > On Fri, 2024-12-13 at 14:23 +0100, Thomas Gleixner wrote:
> >> That's only true for the case where the new kernel takes over.
> >>
> >> In the case KEXEC_JUMP=3Dn and kexec_image->preserve_context =3D=3D tr=
ue, then
> >> it is supposed to align with suspend/resume and if you look at the cod=
e
> >> then it actually mimics suspend/resume in the most dilettanteish way.
> >
> > Did you mean KEXEC_JUMP=3Dy there?
>
> Yes, of course.
>
> > I spent a while the other week trying to understand the case where
> > CONFIG_KEXEC_JUMP=3Dn and kexec_image->preserve_context=3Dtrue, and cam=
e to
> > the conclusion that it was a mirage. Userspace can't *actually* set the
> > KEXEC_PRESERVE_CONTEXT bit when setting up the image, if KEXEC_JUMP=3Dn=
.
> >
> > The whole of the code path for that case is dead code. It's confusing
> > because as discussed elsewhere, we don't just #ifdef out the whole of
> > that dead code path, but only the bits which don't actually *compile*
> > (like references to restore_processor_state() etc.).
>
> Yes, I had to stare at it quite a while. :)
>
> >> It's a patently bad idea to clobber the kernel with kexec jump "fixes"
> >> instead of using the well tested and established suspend/resume
> >> machinery.
> >>
> >> All it takes is to:
> >>
> >>     1) disable the wakeup logic
> >>
> >>     2) provide a mechanism to invoke machine_kexec() instead of the
> >>        actual suspend mechanism.
> >>
> >> No?
> >
> > Agreed. The hacky proof of concept I posted earlier invoking
> > machine_kexec() instead of suspend_ops->enter() works fine. I'll look
> > at cleaning it up and making it not invoke all the ACPI hooks for
> > *actual* suspend to RAM, etc.
>
> Something like the below? It survived an hour of loop testing.
>
> > As I noted though, it doesn't address that linux-scsi report which was
> > a *real* kexec, not a kjump.
>
> I was not looking at that path at all.
>
> Thanks,
>
>         tglx
> ---
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -582,4 +582,7 @@ enum suspend_stat_step {
>  void dpm_save_failed_dev(const char *name);
>  void dpm_save_failed_step(enum suspend_stat_step step);
>
> +int kexec_suspend(void);
> +void kexec_machine_execute(void);
> +
>  #endif /* _LINUX_SUSPEND_H */
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -984,6 +984,12 @@ bool kexec_load_permitted(int kexec_imag
>         return true;
>  }
>
> +void kexec_machine_execute(void)
> +{
> +       kmsg_dump(KMSG_DUMP_SHUTDOWN);
> +       machine_kexec(kexec_image);
> +}
> +
>  /*
>   * Move into place and start executing a preloaded standalone
>   * executable.  If nothing was preloaded return an error.
> @@ -999,38 +1005,9 @@ int kernel_kexec(void)
>                 goto Unlock;
>         }
>
> -#ifdef CONFIG_KEXEC_JUMP
> -       if (kexec_image->preserve_context) {
> -               pm_prepare_console();
> -               error =3D freeze_processes();
> -               if (error) {
> -                       error =3D -EBUSY;
> -                       goto Restore_console;
> -               }
> -               suspend_console();
> -               error =3D dpm_suspend_start(PMSG_FREEZE);
> -               if (error)
> -                       goto Resume_console;
> -               /* At this point, dpm_suspend_start() has been called,
> -                * but *not* dpm_suspend_end(). We *must* call
> -                * dpm_suspend_end() now.  Otherwise, drivers for
> -                * some devices (e.g. interrupt controllers) become
> -                * desynchronized with the actual state of the
> -                * hardware at resume time, and evil weirdness ensues.
> -                */
> -               error =3D dpm_suspend_end(PMSG_FREEZE);
> -               if (error)
> -                       goto Resume_devices;
> -               error =3D suspend_disable_secondary_cpus();
> -               if (error)
> -                       goto Enable_cpus;
> -               local_irq_disable();
> -               error =3D syscore_suspend();
> -               if (error)
> -                       goto Enable_irqs;
> -       } else
> -#endif
> -       {
> +       if (IS_ENABLED(CONFIG_KEXEC_JUMP) && kexec_image->preserve_contex=
t) {
> +               error =3D kexec_suspend();
> +       } else {
>                 kexec_in_progress =3D true;
>                 kernel_restart_prepare("kexec reboot");
>                 migrate_to_reboot_cpu();
> @@ -1045,30 +1022,10 @@ int kernel_kexec(void)
>                 cpu_hotplug_enable();
>                 pr_notice("Starting new kernel\n");
>                 machine_shutdown();
> +               kexec_machine_execute();
>         }
>
> -       kmsg_dump(KMSG_DUMP_SHUTDOWN);
> -       machine_kexec(kexec_image);
> -
> -#ifdef CONFIG_KEXEC_JUMP
> -       if (kexec_image->preserve_context) {
> -               syscore_resume();
> - Enable_irqs:
> -               local_irq_enable();
> - Enable_cpus:
> -               suspend_enable_secondary_cpus();
> -               dpm_resume_start(PMSG_RESTORE);
> - Resume_devices:
> -               dpm_resume_end(PMSG_RESTORE);
> - Resume_console:
> -               resume_console();
> -               thaw_processes();
> - Restore_console:
> -               pm_restore_console();
> -       }
> -#endif
> -
> - Unlock:
> +Unlock:
>         kexec_unlock();
>         return error;
>  }
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -400,7 +400,7 @@ void __weak arch_suspend_enable_irqs(voi
>   *
>   * This function should be called after devices have been suspended.
>   */
> -static int suspend_enter(suspend_state_t state, bool *wakeup)
> +static int suspend_enter(suspend_state_t state, bool *wakeup, bool kexec=
_jump)
>  {
>         int error;
>
> @@ -445,15 +445,19 @@ static int suspend_enter(suspend_state_t
>
>         error =3D syscore_suspend();
>         if (!error) {
> -               *wakeup =3D pm_wakeup_pending();
> -               if (!(suspend_test(TEST_CORE) || *wakeup)) {
> -                       trace_suspend_resume(TPS("machine_suspend"),
> -                               state, true);
> -                       error =3D suspend_ops->enter(state);
> -                       trace_suspend_resume(TPS("machine_suspend"),
> -                               state, false);
> -               } else if (*wakeup) {
> -                       error =3D -EBUSY;
> +               if (IS_ENABLED(CONFIG_KEXEC_JUMP) && kexec_jump) {
> +                       kexec_machine_execute();
> +               } else {
> +                       *wakeup =3D pm_wakeup_pending();
> +                       if (!(suspend_test(TEST_CORE) || *wakeup)) {
> +                               trace_suspend_resume(TPS("machine_suspend=
"),
> +                                                    state, true);
> +                               error =3D suspend_ops->enter(state);
> +                               trace_suspend_resume(TPS("machine_suspend=
"),
> +                                                    state, false);
> +                       } else if (*wakeup) {
> +                               error =3D -EBUSY;
> +                       }
>                 }
>                 syscore_resume();
>         }
> @@ -485,7 +489,7 @@ static int suspend_enter(suspend_state_t
>   * suspend_devices_and_enter - Suspend devices and enter system sleep st=
ate.
>   * @state: System sleep state to enter.
>   */
> -int suspend_devices_and_enter(suspend_state_t state)
> +static int __suspend_devices_and_enter(suspend_state_t state, bool kexec=
_jump)
>  {
>         int error;
>         bool wakeup =3D false;
> @@ -514,7 +518,7 @@ int suspend_devices_and_enter(suspend_st
>                 goto Recover_platform;
>
>         do {
> -               error =3D suspend_enter(state, &wakeup);
> +               error =3D suspend_enter(state, &wakeup, kexec_jump);
>         } while (!error && !wakeup && platform_suspend_again(state));
>
>   Resume_devices:
> @@ -536,6 +540,15 @@ int suspend_devices_and_enter(suspend_st
>  }
>
>  /**
> + * suspend_devices_and_enter - Suspend devices and enter system sleep st=
ate.
> + * @state: System sleep state to enter.
> + */
> +int suspend_devices_and_enter(suspend_state_t state)
> +{
> +       return __suspend_devices_and_enter(state, false);
> +}
> +
> +/**
>   * suspend_finish - Clean up before finishing the suspend sequence.
>   *
>   * Call platform code to clean up, restart processes, and free the conso=
le that
> @@ -607,6 +620,21 @@ static int enter_state(suspend_state_t s
>         return error;
>  }
>
> +#ifdef CONFIG_KEXEC_JUMP
> +int kexec_suspend(void)
> +{
> +       int error;
> +
> +       ksys_sync_helper();
> +       error =3D freeze_processes();
> +       if (error)
> +               return error;
> +       error =3D __suspend_devices_and_enter(PM_SUSPEND_MEM, true);

Why do you want to hook this up to the suspend code?

