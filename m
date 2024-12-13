Return-Path: <linux-ext4+bounces-5611-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA029F07EA
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 10:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC68188A2AA
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59571AD418;
	Fri, 13 Dec 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nO5qCSVd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBE364D6
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082281; cv=none; b=pWjUuyqblzDMyMQCwjzJgajfyPw06N9Ff+h6o00GGUhU3ScQOgeXPaAAlD46y3Yg/Rmvvwtuvlv7uRKO3ubeWA/FvImPnrGW7je1aX6jgvZbiQyh1zCZX8hW37Z24Pcaq1NyFf/DHwHq4EUJR5rKv6bPG3TIBR+l3oTkHaz0GDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082281; c=relaxed/simple;
	bh=sD58cz8YJdt/RsTPh0sQNzNUodzYstmf/pG9ECMsvJg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZz4d8QdUNhqeZVA/2mLHK7jokHXmprdQDCVbdTHuDDFuLNf12B25hDeLuS8ZDbP7taw7ORHKHIX3SOymzWRCsGllQsldvu9mpg9eK6kpWAGzpQ5xTk9FHWsU/SL06AMdvMOmV2MxyGpUJnSpITwd8PPDS7HJW/hkOmUimlS4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nO5qCSVd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Yt8vkxgcNYSCSMQD8sHeGSrvB09OexcomYaf9PsOXg=; b=nO5qCSVd7DK49os6k1ce4rqflv
	BTIRHbs/y624HsLTsnBrTIJnx5hDTSXiYLYko4Z9aesO3BwAVLI6N0V6jVud6H5hJX4w1JG9mjstb
	97eGijE5nh5WEDBS9oJPRN8WuNmzh/3JgSaX/YfBYzoyyjeyVqrIPHdK/85gtgtMSVshXWEwO4gkQ
	EKDlIso0f9BPZyjx3fjBcmXRy4lmZmPHynaVBwbrAZIWsL/a1iMm4ArQgM/WTSRh7QOmDxBTFkDZq
	GMB7E7I3N2UJ5vKlLzniHknXEJzaPdrK6GzkB7zPiadw4PvngiYS7+Hz0onTSTclA1jDQh4KaXzwO
	JpwJwhRA==;
Received: from 54-240-197-239.amazon.com ([54.240.197.239] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM20u-0000000Bsp2-28Wt;
	Fri, 13 Dec 2024 09:31:12 +0000
Message-ID: <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>, Stefan Hajnoczi
 <stefanha@redhat.com>,  Jason Wang <jasowang@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung
 <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, linux-ext4
 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>,  ming.lei@redhat.com, Petr Mladek
 <pmladek@suse.com>, John Ogness <jogness@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>
Date: Fri, 13 Dec 2024 09:31:11 +0000
In-Reply-To: <874j38a16p.ffs@tglx>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
	 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
	 <20241211124240.GA310916@fedora>
	 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
	 <87ldwl9g93.ffs@tglx>
	 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
	 <87a5d0aibc.ffs@tglx>
	 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
	 <874j38a16p.ffs@tglx>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-1uJmaDHLw7yA+QPcwn6V"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-1uJmaDHLw7yA+QPcwn6V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-12-13 at 01:14 +0100, Thomas Gleixner wrote:
>=20
> With that applied the problem goes away, but after a lot of repetitions
> of the reproducer in a tight loop the whole machinery stops dead:
>=20
> [=C2=A0=C2=A0 29.913179] Disabling non-boot CPUs ...
> [=C2=A0=C2=A0 29.930328] smpboot: CPU 1 is now offline
> [=C2=A0=C2=A0 29.930593] crash hp: kexec_trylock() failed, kdump image ma=
y be inaccurate
> B[=C2=A0=C2=A0 29.940588] Enabling non-boot CPUs ...
> [=C2=A0=C2=A0 29.940856] crash hp: kexec_trylock() failed, kdump image ma=
y be inaccurate
> [=C2=A0=C2=A0 29.941242] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [=C2=A0=C2=A0 29.942654] CPU1 is up
> [=C2=A0=C2=A0 29.945856] virtio_blk virtio1: 2/0/0 default/read/poll queu=
es
> [=C2=A0=C2=A0 29.948556] OOM killer enabled.
> [=C2=A0=C2=A0 29.948750] Restarting tasks ... done.
> Success
> [=C2=A0=C2=A0 29.960044] Freezing user space processes
> [=C2=A0=C2=A0 29.961447] Freezing user space processes completed (elapsed=
 0.001 seconds)
> [=C2=A0=C2=A0 29.961861] OOM killer disabled.
> [=C2=A0=C2=A0 30.102485] ata2: found unknown device (class 0)
> [=C2=A0=C2=A0 30.107387] Disabling non-boot CPUs ...
>=20
> That happens without 'no_console_suspend' on the command line as
> well, but that's for tomorrow ...

I think I saw that lockup once last night too. This morning I did not
see it after hundreds of invocations on my kexec-debug tree (based on
tip/x86/boot which is 6.13-rc1).

I switched to master (231825b2e1 still) and saw it after a few
attempts.

[   34.250006] Freezing user space processes
[   34.251930] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[   34.252730] OOM killer disabled.
[   34.253141] printk: Suspending console(s) (use no_console_suspend to deb=
ug)

(gdb) t a a bt

Thread 2 (Thread 1.2 (CPU#1 [halted ])):
#0  0xffffffff8235886f in pv_native_safe_halt () at arch/x86/kernel/paravir=
t.c:127
#1  0xffffffff8235b699 in arch_safe_halt () at ./arch/x86/include/asm/parav=
irt.h:175
#2  default_idle () at arch/x86/kernel/process.c:742
#3  0xffffffff8235bb0a in default_idle_call () at kernel/sched/idle.c:117
#4  0xffffffff81243195 in cpuidle_idle_call () at kernel/sched/idle.c:185
#5  do_idle () at kernel/sched/idle.c:325
#6  0xffffffff812434b9 in cpu_startup_entry (state=3Dstate@entry=3DCPUHP_AP=
_ONLINE_IDLE) at kernel/sched/idle.c:423
#7  0xffffffff8115b572 in start_secondary (unused=3D<optimized out>) at arc=
h/x86/kernel/smpboot.c:314
#8  0xffffffff8110a38d in secondary_startup_64 () at arch/x86/kernel/head_6=
4.S:414
#9  0x0000000000000000 in ?? ()

Thread 1 (Thread 1.1 (CPU#0 [halted ])):
#0  0xffffffff8235886f in pv_native_safe_halt () at arch/x86/kernel/paravir=
t.c:127
#1  0xffffffff8235b699 in arch_safe_halt () at ./arch/x86/include/asm/parav=
irt.h:175
#2  default_idle () at arch/x86/kernel/process.c:742
#3  0xffffffff8235bb0a in default_idle_call () at kernel/sched/idle.c:117
#4  0xffffffff81243195 in cpuidle_idle_call () at kernel/sched/idle.c:185
#5  do_idle () at kernel/sched/idle.c:325
#6  0xffffffff812434b9 in cpu_startup_entry (state=3Dstate@entry=3DCPUHP_ON=
LINE) at kernel/sched/idle.c:423
#7  0xffffffff8235c9c7 in rest_init () at init/main.c:747
#8  0xffffffff8419a694 in start_kernel () at init/main.c:1102
#9  0xffffffff841ac6a4 in x86_64_start_reservations (real_mode_data=3Dreal_=
mode_data@entry=3D0x147b0 <exception_stacks+34736> <error: Cannot access me=
mory at address 0x147b0>) at arch/x86/kernel/head64.c:507
#10 0xffffffff841ac7fd in x86_64_start_kernel (real_mode_data=3D0x147b0 <ex=
ception_stacks+34736> <error: Cannot access memory at address 0x147b0>) at =
arch/x86/kernel/head64.c:488
#11 0xffffffff8110a38d in secondary_startup_64 () at arch/x86/kernel/head_6=
4.S:414
#12 0x0000000000000000 in ?? ()
(gdb)=20


But I haven't ingested your fix yet, maybe so I can't be entirely
surprised if CPU0 scheduled away and ended up in the idle thread?=20

If I were cleverer I'd remember how to make gdb give me a backtrace for
the process which is actually in the kexec sys_reboot() system call,
instead of the boring idle thread.

(gdb) p sysrq_handle_showstate('t')

That didn't work. Maybe if I'd actually had no_console_suspend on this
boot. Will try again.

--=-1uJmaDHLw7yA+QPcwn6V
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMjEzMDkzMTExWjAvBgkqhkiG9w0BCQQxIgQgPcqmAxBP
PrDT4KkhfvPgbIIJe7A2u4Cws+tHB2WZV2Ewgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAfDkKjebw7R5AaWQhrpTlcG51P4Low21z1
lNWvfD3R1QepCWCbhBMkzrtagWLqs/wxtF4HpPCO/J9vHq1/B62WnNrMCZY6IRQVsHsk4zFsn2wQ
BQ0OH06KOZASIlWqkQueMPBx51WCC8QRR3PbtiRAQu3TYDf+zGuQrICxG1h5f7nfyrhat4FWi89o
JUOIDWSsctoAwRkx5MVqwo1ch0jbEMOifQ8Te214BOwSxUH3DQXBHWxt4Xpe20qsWSx/6w12+ZR5
KPyISX6y7GgR3N041nY+a4BFeee1y8elQpd3zxuL2YiuDEOdoKwAT7bnahPquslAtT0SNeo16fxn
kee8692X7n5GQafV8tnuYBv14OK+DA1/bMG8hBGIGrGvn2+Q5jwzVuUtRhvXiSR+M96LwRR+PSqU
zEMJvHcQtbCe91ZNBIewcbZm4otsj+6UzmGQluku854rUdMig3BMK6qD8vrgGr0KBLPD9UQob8MN
6Rl48Gf9YqdeRQzjoBgPL237PooJi5iVchOVKMyRYSp4Fe5fOUQPQ6Tse3hG89n8h0hyGUY9FhSA
onKnTPeJKC9Oow9U/Y57j/bygMHZDP4lW+TZBNfaEAQfXY8gUVIxvX3sq28MrmeRdhmNqZ00047+
8i3Y4uftLJF7pV1LhylCX5Lrh+evJmQWpXkJ1FbujQAAAAAAAA==


--=-1uJmaDHLw7yA+QPcwn6V--

