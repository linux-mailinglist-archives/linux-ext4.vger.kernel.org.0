Return-Path: <linux-ext4+bounces-5622-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D419F0D2D
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 14:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0300E168529
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F601DA5F;
	Fri, 13 Dec 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t4mVdt+M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F71DFE2C
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095877; cv=none; b=gX80WW/ZnnY4+WkmKsdE52dEC7HPwSyTSlEVNoRuqmZMfi41V2bigKsTYzrCRDPb6r2EElrmkfvyEkynXVJQlM0bYrpMzyzVOXXOU1qFFLBSkYF6XMOUSRCd0pwEDZci/CnYg1gPTWAOI5E0RkdjKs/WymFpNObOT1P18djN3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095877; c=relaxed/simple;
	bh=jl/9SKvgbeLhCX2PhylWS/J1XnOHSf9AzxZAL/poCNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJ+DZ8g2Yl5QA36PUM8m1EhAn8I/aAEFK8dnal356N//4qusd2733zDsnS9VA78M9GP5bShDLm47BXKnfMfeAHLcZziTqplR1HBqebRvhb3ODUiDdajwxLZvQyMzPG2EtPM8kmovPNE2ZhNzqTnKpLQOASdAUsYwVvPoyknzHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t4mVdt+M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zolgw/uBT0T85On+9719ZvxuzDJUaIV9lpUsYYP/RTU=; b=t4mVdt+MzVNyOpL/rrG5AXOmlS
	cMKNYjX4K3XfqEz0jU2ZlS8/OF7BqaJckYi2kkeu+KIH1WVDRx2Asj6vKl+xpptYtUKELPImWMUXS
	QB9Gf4CfK0dDUonxs9tSFht8uZQ6uCA1jKyFwk4XIIDJYe/GCLqRSv/vh/RYQl8hTFuaNBBvI2Nwu
	WKgwV76CNpTPo1koq7cxr6u4Qv4b8jw0SrsVtSGsk/g526t5enmXxYmpWK3qKLVB2DpgKfEwHswZy
	7I210YVSFye8I6q+cmMEXga+6XdOe6LrtMdBIcM1eQkVv8PQXTLy3KfLUmmpYOrkU47e1dxm6oL/Z
	WCAZTrqA==;
Received: from [54.240.197.239] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM5YD-0000000D7TS-33O8;
	Fri, 13 Dec 2024 13:17:49 +0000
Message-ID: <044c030594018a8382e7364614c61eb799da8acd.camel@infradead.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
  "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung
 <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, linux-ext4
 <linux-ext4@vger.kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, John
 Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Jens
 Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 13:17:48 +0000
In-Reply-To: <87y10j95v7.ffs@tglx>
References: <20241211124240.GA310916@fedora>
	 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
	 <87ldwl9g93.ffs@tglx>
	 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
	 <87a5d0aibc.ffs@tglx>
	 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
	 <874j38a16p.ffs@tglx>
	 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
	 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
	 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-tGeYf3Jy9VWdA9CAyV22"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-tGeYf3Jy9VWdA9CAyV22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-12-13 at 12:31 +0100, Thomas Gleixner wrote:
> On Fri, Dec 13 2024 at 19:09, Ming Lei wrote:
> > On Fri, Dec 13, 2024 at 11:42:59AM +0100, Thomas Gleixner wrote:
> > > That's the control thread on CPU0. The hotplug thread on CPU1 is stuc=
k
> > > here:
> > >=20
> > > =C2=A0task:cpuhp/1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ate:D stack:0=C2=A0=C2=A0=C2=A0=C2=A0 pid:24=C2=A0=C2=A0=C2=A0 tgid:24=C2=
=A0=C2=A0=C2=A0 ppid:2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:0x00004000
> > > =C2=A0Call Trace:
> > > =C2=A0 <TASK>
> > > =C2=A0 __schedule+0x51f/0x1a80
> > > =C2=A0 schedule+0x3a/0x140
> > > =C2=A0 schedule_timeout+0x90/0x110
> > > =C2=A0 msleep+0x2b/0x40
> > > =C2=A0 blk_mq_hctx_notify_offline+0x160/0x3a0
> > > =C2=A0 cpuhp_invoke_callback+0x2a8/0x6c0
> > > =C2=A0 cpuhp_thread_fun+0x1ed/0x270
> > > =C2=A0 smpboot_thread_fn+0xda/0x1d0
> > >=20
> > > So something with those blk_mq fixes went sideways.
> >=20
> > The cpuhp callback is just waiting for inflight IOs to be completed whe=
n
> > the irq is still live.
> >=20
> > It looks same with the following report:
> >=20
> > https://lore.kernel.org/linux-scsi/F991D40F7D096653+20241203211857.0291=
ab1b@john-PC/
> >=20
> > Still triggered in case of kexec & qemu, which should be one qemu
> > problem.
>=20
> I'd rather say, that's a kexec problem. On the same instance a loop test
> of suspend to ram with pm_test=3Dcore just works fine. That's equivalent
> to the kexec scenario. It goes down to syscore_suspend() and skips the
> actual suspend low level magic. It then resumes with syscore_resume()
> and brings the machine back up.
>=20
> That runs for 2 hours now, while the kexec muck dies within 2
> minutes....
>=20
> And if you look at the difference of these implementations, you might
> notice that kexec just implemented some rudimentary version of the
> actual suspend logic. Based on let's hope it works that way.
>=20
> This is just insane and should be rewritten to actually reuse the suspend
> mechanism, which is way better tested than this kexec jump muck.

Not sure it helps for the above linux-scsi issue since that's an
*actual* kexec, not 'kexec jump muck'. But for the kjump this dirty
proof of concept seems to work:

--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -19,6 +19,7 @@
 #include <linux/gfp.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
@@ -446,6 +447,9 @@ static int suspend_enter(suspend_state_t state, bool *w=
akeup)
        error =3D syscore_suspend();
        if (!error) {
                *wakeup =3D pm_wakeup_pending();
+               if (kexec_image && kexec_image->preserve_context) {
+                       machine_kexec(kexec_image);
+               } else
                if (!(suspend_test(TEST_CORE) || *wakeup)) {
                        trace_suspend_resume(TPS("machine_suspend"),
                                state, true);


[root@localhost ~]# echo mem > /sys/power/state
[   61.854085] PM: suspend entry (deep)
[   61.868380] Filesystems sync: 0.013 seconds
[   61.873692] Freezing user space processes
[   61.876739] Freezing user space processes completed (elapsed 0.002 secon=
ds)
[   61.878175] OOM killer disabled.
[   61.878861] Freezing remaining freezable tasks
[   61.880818] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[   61.889138] ata2.00: Check power mode failed (err_mask=3D0x1)
[   61.893351] PM: suspend devices took 0.011 seconds
[   61.899373] ACPI: PM: Preparing to enter system sleep state S3
[   61.900802] ACPI: PM: Saving platform NVS memory
[   61.901861] Disabling non-boot CPUs ...
[   61.906841] smpboot: CPU 1 is now offline
Exc:0000000000000003
Err:0000000000000000
rip:0000228e60970000
rax:0000000000000018
rbx:0000000000000000
rcx:0000000000000001
rdx:0000000000000000
rsi:00000000228e6540
rdi:00000000228e4002
r8 :0000000000000000
r9 :0000000022927000
r10:0000000000000000
r11:0000000000000001
r12:0000000000170e70
r13:0000000000170ef0
r14:ffff888006064110
r15:ffff888006f61e20
cr2:00007f408f990098
B[   61.925154] Enabling non-boot CPUs ...
[   61.925987] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   61.929886] CPU1 is up
[   61.930514] ACPI: PM: Waking up from system sleep state S3
[   61.950391] virtio_blk virtio1: 2/0/0 default/read/poll queues
[   61.954844] PM: resume devices took 0.020 seconds
[   61.955968] OOM killer enabled.
[   61.956500] Restarting tasks ... done.
[   61.958890] random: crng reseeded on system resumption
[   61.962280] PM: suspend exit


--=-tGeYf3Jy9VWdA9CAyV22
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMjEzMTMxNzQ4WjAvBgkqhkiG9w0BCQQxIgQgMQbTtmt9
Q3lTyF18hO0xG8B4ff0Bpm7QlMN9bn96Mekwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgByhjTGj6O0sycPXv332z9XozS5nEAXDk/u
qkKVxcRVKZYlSb6GCTRpIqQOlp12UMBPDUtxpLo/qlSy+ck6pxcVPnXy9L32TZMQSepV5Z/JYXD/
ipnML0Z6tsRUailX4x0YiYsxHUN+aroJJQ6sCzASvCjjF8j5B6Ff65yaGwlufubf4wrCsuJVmNIo
Wu0Baeq4v47cA9lbYUB0zRmfKUmyF9Xgr7dMQQtj9HvB46HpM7hREfIwakS+e5qnSEyrSVhaQNwm
bcNcDOMSSs97ml/I6tWo12NJJVsNIzPFikN63x1QC83gKCnfERo7RkxVzl8XI3kYpzum7fYDTB3F
y6jClgdZJmndYQ9EIOO4377ZZ35gkJAKspt4mQEJrf5F7B3W5DiAxVV/FisKRiz36kUTxY25TQfN
OJ288dlm69MaXUDToQasJIaSE39QOLEi618qNtNpfysiCgG4Er+FRbpcGdyX0oaxbI5Aaecuebqj
l9ziermqNdyJBdSgy4zgA9Av5k4i5kaYfIeLuoGJ+5iKj9GIMm5ADV/JyvcqDml27t0FqpSN4nYL
kZExoejl+WVRht8ifOTPkDFsPoXvUxw/2UxEaGo0IWa5FtZI6bUKDV4/HTlni7eY+Rv+JSm52+Ca
x2jSFZfVuYiV4hfFxQ7zUjy6GW/F7l+5VP/3SvCeZAAAAAAAAA==


--=-tGeYf3Jy9VWdA9CAyV22--

