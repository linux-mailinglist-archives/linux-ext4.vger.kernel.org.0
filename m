Return-Path: <linux-ext4+bounces-5640-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B919F1DDA
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Dec 2024 10:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFA6188B8DC
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Dec 2024 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F6156C6A;
	Sat, 14 Dec 2024 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iIVgzBdl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D290433D8
	for <linux-ext4@vger.kernel.org>; Sat, 14 Dec 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734170277; cv=none; b=WHy+r8tv7aVIkQ30x5pbuJ2x1tWeJ+seXPhA0C2g/at2saiPfPYXZHyWQZCT/30vp5QvMAvv00yBUo+VmPRZtiePOlk+j7aeHUZPqH+rQE3zWTKb1PzdNoIRzodca2qsZBGZLj2lJE9cYXOE/orsOthSyxPtRVHy4jLnHMNfZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734170277; c=relaxed/simple;
	bh=if2DZ6/Oj0mYipUOvDkOqEjQidW7l48J8ESXcx3sOLI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=skgqe5LlTTYBDALSZzcme8Kew8ybzqJ5iYYTlUPUdmzEghI9KsNfBL+1cXav2Jp4UyhiCeMVo+uRQNEK3fYA8OPx685YYjqPYxBebenf81QHGRmeS4YS07Pw22nG1p0cBrtOJ6KJVePQHWRk0OYWak0P/PCqehnh4seGSIfvL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iIVgzBdl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HROOz1jnArq5bSt6mkcKD2c8jVNtju58yB7qeOd+yyk=; b=iIVgzBdlGc8rpyoLrpIA+5r1dg
	Kb7wkinbiXGVuf7BDY5LiG27qPwhcyYwzoHWQ6GUYoMFrRjxTP8HEBOnelSQDxb5uxLSXIb1H6Ox3
	IgRFFSR/BFWcXHcOrGHQJ8sKyYwQcnwbMNn23qAetdsVrr2iquO4c4bjFOKp1o4QBgYJ5at1tuMoz
	7vi9vDLMCUGLqdFpKmFGti5osjMQE1IkQhRFwyHMF4yZwH4gjDbnaXGYKr4EjyI1uqr2FASWYbmm/
	R7mkXYazkIBBxfMyCHXXSEp5qXlaFXnpQUkPTniZI6g1pI4nfePSMz9LyeNy+naCfmAQFUa+K+z8e
	ijdMWnuA==;
Received: from [172.31.31.142] (helo=u09cd745991455d.lumleys.internal)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMOuC-00000001jIB-0Ekt;
	Sat, 14 Dec 2024 09:57:48 +0000
Message-ID: <febd10dae881f29fa8236f3e2d6ad77a8f094d72.camel@infradead.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
From: David Woodhouse <dwmw2@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
	 <tglx@linutronix.de>
Cc: Ming Lei <ming.lei@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, hpa
 <hpa@zytor.com>, dyoung <dyoung@redhat.com>, kexec
 <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, Paolo Bonzini
 <bonzini@redhat.com>,  Petr Mladek <pmladek@suse.com>, John Ogness
 <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,  Jens Axboe
 <axboe@kernel.dk>
Date: Sat, 14 Dec 2024 09:57:47 +0000
In-Reply-To: <73E84E2B-001B-48D6-9BB4-B104D43F8FBF@infradead.org>
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
	 <87msgz8qes.ffs@tglx>
	 <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com>
	 <CAJZ5v0hBUgOB4QhhwjusRcP+jksWFL-upR5En58g9RD5+n70JA@mail.gmail.com>
	 <73E84E2B-001B-48D6-9BB4-B104D43F8FBF@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-2uiQt9Gj1bLQhTpWG53w"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-2uiQt9Gj1bLQhTpWG53w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-12-13 at 20:16 +0000, David Woodhouse wrote:
>=20
> > As discussed with Dave over IRC, the current implementation isn't
> > actually that bad.=C2=A0 It might use PMSG_THAW instead of PMSG_RESTORE=
 in
> > kernel_kexec(), but other than this it reflects the code flow around
> > the jump from the restore kernel to the image one during resume from
> > hibernation.
> >=20
> > This means that hibernation and kexec jump could be unified somewhat.
>=20
> Fair enough. I'm happy to do whatever cleanups or consolidation make
> sense, if we have a consensus.
>=20
> There remains the question of why the blk-mq thing explodes on the
> way down for both kjump and, apparently, even the plain kexec case.

In case it's of any use, here's a test case I put together recently for
kexec stress testing.

 http://david.woodhou.se/kexec.initramfs

It's just an initrd I boot in qemu with '-initrd kexec.initramfs' and
it builds a copy of itself, then kexecs back into the same kernel with
the same initrd. You'll need to drop your own bzImage into it.

It was designed to run without a block device, but to trigger the
blk-mq thing or the one at
https://lore.kernel.org/linux-scsi/F991D40F7D096653+20241203211857.0291ab1b=
@john-PC/
we'd probably need to actually mount something and maybe do some disk
I/O.

(Which means the fact that the initrd can rebuild itself with cpio is
no longer quite so useful, as it could have just loaded the initrd for
the next kernel from the file system. But I already did that part, so
whatever.)


 $ cat init
#!/bin/sh

find . > files.txt
mount -tproc none /proc

cat /proc/sys/kernel/watchdog_thresh
echo 20 >  /proc/sys/kernel/watchdog_thresh

mount -tramfs none /tmp
NEXTCOUNT=3D$(($LOOPCOUNT+1))
CMDLINE=3D$(cat /proc/cmdline)
NEWCMDLINE=3D"${CMDLINE/LOOPCOUNT=3D$LOOPCOUNT/} LOOPCOUNT=3D$NEXTCOUNT"

echo KEXEC LOOP $LOOPCOUNT
echo $NEWCMDLINE

cpio --quiet -H newc -o < files.txt | gzip -n9 > /tmp/initramfs.gz
kexec -f /bzImage --initrd /tmp/initramfs.gz --append "$NEWCMDLINE"


 $ cp ~/git/linux/arch/x86/boot/bzImage .
 $ find . | cpio --quiet -H newc -o  | gzip -n9 > ../kexec.initramfs
 $ ls -d `find .`
.              ./bin/mount              ./lib64/ld-linux-x86-64.so.2
./bin          ./bin/sh                 ./lib64/libc.so.6
./bin/busybox  ./bin/sleep              ./lib64/liblzma.so.5
./bin/cat      ./dev                    ./lib64/liblzma.so.5.4.4
./bin/cpio     ./dev/console            ./lib64/libz.so.1
./bin/echo     ./dev/null               ./lib64/libz.so.1.2.13
./bin/find     ./dev/ttyS5              ./loadret
./bin/gzip     ./init                   ./loadret.c
./bin/kexec    ./init.preserve-context  ./proc
./bin/mknod    ./lib64                  ./tmp


--=-2uiQt9Gj1bLQhTpWG53w
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMjE0MDk1NzQ3WjAvBgkqhkiG9w0BCQQxIgQgf2x9Y5T7
1vF65OaWjm81GzfVjPZwkdJEoHTlRWlEAUwwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCkZPFx6BO7rcmZ6cYchu7ZUFsj2+MFgz2Z
N85F5u0D5vSv5GuolokAqOGVOH8lh5/hyn9Ie1JvYCIApmyvLIDl0p5Ux1YNR/mPxqdJPufoo3Ii
aYkvzcTdEcfQWl3+qpxp8Jzpxjh7MxeGIU3DFPvxxzNifUlhqqgHgmCX6aOhDPzQ4zyFRLoO0YDA
roFZUPO60Y82nqDB9iiCJIdPdvBjXhfVjDtcN/Eo59Q3cxI4R31/AaIPOzphOkJLhykWHDScnF1P
CdpBCnlR9zHKRzOpd4HBcTAXrsYu8pux8CkaaoE59o4Y3XO+7U3B36E0+qUslB07cQnez8xlzFhF
hXjLQqj3UIiyDe3hGpyD8o438FddDLwI3Hm58rGO3tuy3Mt0pGLcK6WOCVWxcC2w57OHgk5gq9Of
CfOcculK/8AVeup36v6A6kRsTZIMWwlUuQSxaVYXo4mMZFDjG5Iy/IPzrfNvmYG7Hm69ErB1TDHO
Pjjjwvs1qcR16+QyCAqg0MZ2zxnFapPq72bjIS5RLkYrtuWHrLtrLI3ntyRKyA7dlJVzQsuIzdtT
x7xuk4oqAbjYrst0Z8skrie7VA740P1hGHSxC3VxleuP+/EUVHIH7ftRFdKk4C4BF3AXQ/c/ixJi
wCuCpDHOxfHiEI4H9I+xDoIMVouwNqEqth5MydtWSQAAAAAAAA==


--=-2uiQt9Gj1bLQhTpWG53w--

