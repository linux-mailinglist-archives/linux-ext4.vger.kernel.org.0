Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21453B82DF
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2019 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfISUps (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Sep 2019 16:45:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42144 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfISUps (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Sep 2019 16:45:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so4939652lje.9;
        Thu, 19 Sep 2019 13:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=kCZ3f3UknN+JlMO3GLtJ8KXZoaqSJ47tpCRq0yGk7Dc=;
        b=a2sugheYlWf6t2UZx8G9y71zjw1xsf+A6wkSZm+IBYFbBLoKLYkXg3p9dVaGEeq+NP
         gWzzJz48bPCBHNRIdA+IjJ7GEv/mJguYKPnftVMpVR4KqpLKduihAlDcogCJ1TXMNsps
         bLzbu1L3ptzCo4BfPo3S4h+DlMEYTUr2EObfTWcPvI7gi4RUaoNs5kBS4ZtP5kWFRX/7
         0Qtoiuyu48kk5wnVL50CeXDy84a+Ru1ZKVMn8NQd4H/kh0AVksR0PcBsh+2lwDcaA4cf
         yO8zL1nHtZSd/cLP2+74K7zEuIYSP4maQc4s18AHUXD8yWvQbtAcY3R2MOAH34QyVK/D
         fwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=kCZ3f3UknN+JlMO3GLtJ8KXZoaqSJ47tpCRq0yGk7Dc=;
        b=K4UWu/5eRGvCA1s1WmlAQhr9cnMfU8MHPiu4I0DrdV6hn4LtW9pD5gibPwp/EC187g
         48hxV2MTFfsfT/SAKKY8ZFKIysnh3eau1+ionRG8RbdF5DslAUpUiKC4xQLPtC3Y7Cjs
         1TJaML0hOofOx/VXf3G7IeayihgyuZ3r4W4tbJepmdx+Jb9zEADtChsEelBoh3VziXTS
         aqhIHt6P4O0YCN5oKr4YYcwerF3AXj7hBFJye/WwRWIqMzrdMzTz+6sSyicKb5G4Wjeu
         q6blNtXFOhXUwsgPUIj6rObWQsetxcugF4ImTgXFYYDJV4pu1aHqDjYCzxFQwQCWTYft
         fyPg==
X-Gm-Message-State: APjAAAV74/g56uDMUlg/V3jlcjwC//w/a8FPbOMSGr3r06fD/osXhneg
        +f+aD1sa/0CoNzGh65sGg6uGTgFFm1b6FA==
X-Google-Smtp-Source: APXvYqykLUWcrmum+J0F14bs9oOcORFwj225QU7ucyM512SoNxrbpYxw35SlN/r7NkIVgheUN86bvg==
X-Received: by 2002:a2e:9a88:: with SMTP id p8mr6383903lji.86.1568925943966;
        Thu, 19 Sep 2019 13:45:43 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700::ae2? ([2a02:17d0:4a6:5700::ae2])
        by smtp.googlemail.com with ESMTPSA id g10sm1798240lfb.76.2019.09.19.13.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 13:45:42 -0700 (PDT)
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
References: <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190919143427.GQ6762@mit.edu>
 <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
 <CAHk-=wjTbpcyVevsy3g-syB5v9gk_rR-yRFrUAvTL8NFuGfCrw@mail.gmail.com>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <6adb02d4-c486-a945-7f51-d007d6de45b2@gmail.com>
Date:   Fri, 20 Sep 2019 01:45:40 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjTbpcyVevsy3g-syB5v9gk_rR-yRFrUAvTL8NFuGfCrw@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000304060005040105070706"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000304060005040105070706
Content-Type: multipart/mixed;
 boundary="------------84DCDD92DB3AA9B299024B99"
Content-Language: en-PH

This is a multi-part message in MIME format.
--------------84DCDD92DB3AA9B299024B99
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

20.09.2019 01:04, Linus Torvalds =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> instead. Yeah, it still doesn't help on machines that don't even have
> a cycle counter, but it at least means that you don't have to have a
> CPU rdrand (or equivalent) but you do have a cycle counter, now the
> extraction of randomness from the pool doesn't just do the
> (predictable) mutation for the backtracking, but actually means that
> you have some very hard to predict timing effects.
>=20
> Again, in this case a cycle counter really does add a small amount of
> entropy (everybody agrees that modern CPU's are simply too complex to
> be predictable at a cycle level), but that's not really the point. The
> point is that now doing the extraction really fundamentally changes
> the state in unpredictable ways, so that you don't have that "if I
> recognize a value, I know what the next value will be" kind of attack.

This already resembles in-kernel haveged (except that it doesn't credit=20
entropy), and Willy Tarreau said "collect the small entropy where it is, =

period" today. So, too many people touched upon the topic in one day,=20
and therefore I'll bite.

We already have user-space software (haveged and modern versions of=20
rngd) that extract supposed entropy from clock jitter and feed it back=20
to the kernel via /dev/random (crediting it). Indeed, at present, on=20
some hardware this is the only way for distributions and users to=20
collect enough entropy during boot and avoid stalls - all other=20
suggestions are simply non-constructive. Also, Google's Fuchsia OS does=20
use and credit jitter entropy.

For the record: I do not have a justifiable opinion whether haveged/rngd =

output (known as jitter entropy) actually contains any entropy. I=20
understand that there are two possible viewpoints here. The rest of the=20
email is written under the assumption that haveged does provide real=20
entropy and not fake one.

The problem that I have with the current situation is that distributions =

and users, when they set up their systems to run haveged or rngd, often=20
do it incorrectly (even, as mentioned, under the assumption that haveged =

is something valid and useful). The most common mistake is relying on=20
systemd-provided default dependencies, thus not starting such software=20
as early as possible. Even worse, no initramfs generator allows one to=20
easily include haveged/rngd in the initramfs and run it there. And for=20
me, the first urandom warning comes from the initramfs, so anything=20
started from the main system is, arguably, already too late.

Therefore, I think, an in-kernel hwrng that exposes jitter entropy is=20
something useful (for those who agree that jitter entropy is not fake),=20
because it avoids the pitfall-ridden userspace setup. Just as an=20
exercise, I have implemented a very simple driver (attached as a patch)=20
that does just that. I am only half-serious here, the driver is only=20
lightly tested in KVM without any devices except an unconnected virtio=20
network card, not on any real hardware. Someone else can also find it=20
useful as a test/fake hwrng driver.

I am aware that there was an earlier decision that jitter entropy should =

not be credited, i.e. effectively a pre-existing NAK from Theodore Ts'o. =

But, well, distributions are already overriding this decision in=20
userspace, and do it badly, so in my viewpoint, the driver would be a=20
net win if some mechanism is added that makes it a no-op by default even =

if the driver is built-in. E.g. an explicit "enable" parameter, but I am =

open to other suggestions, too.

--=20
Alexander E. Patrakov

--------------84DCDD92DB3AA9B299024B99
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hw_random-Add-jitterentropy_hwrng.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-hw_random-Add-jitterentropy_hwrng.patch"

=46rom 2836990aff5bc1dab6a4e927304247dae469c774 Mon Sep 17 00:00:00 2001
From: "Alexander E. Patrakov" <patrakov@gmail.com>
Date: Thu, 19 Sep 2019 01:18:39 +0500
Subject: [PATCH] hw_random: Add jitterentropy_hwrng

This re-exports the existing "jitterentropy_rng" cryptoapi RNG as a
hwrng. The use case is to replace haveged, which distributions
often misconfigure by running it too late, while it is really needed
even in the initramfs on some systems.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 drivers/char/hw_random/Kconfig               | 20 ++++++
 drivers/char/hw_random/Makefile              |  1 +
 drivers/char/hw_random/jitterentropy-hwrng.c | 70 ++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 drivers/char/hw_random/jitterentropy-hwrng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kcon=
fig
index 59f25286befe..ff2102c0159c 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -35,6 +35,26 @@ config HW_RANDOM_TIMERIOMEM
=20
 	  If unsure, say Y.
=20
+config HW_RANDOM_JITTERENTROPY
+        tristate "Jitter Entropy HW Random Number Generator support"
+        select CRYPTO_JITTERENTROPY
+        ---help---
+          This driver provides kernel-side support for extracting entrop=
y
+          from CPU and memory clock jitter.
+
+          jitterentropy-hwrng serves the same purpose as haveged, but is=
 in
+          the kernel. So, if you otherwise would have to run haveged, bu=
ild
+          this driver instead, it has an advantage of being available ve=
ry
+          early in the boot process.
+
+          Note that it is still not known whether clock jitter provides =
any
+          actual entropy.
+
+          To compile this driver as a module, choose M here: the
+          module will be called jitterentropy-hwrng.
+
+          If unsure, say N.
+
 config HW_RANDOM_INTEL
 	tristate "Intel HW Random Number Generator support"
 	depends on (X86 || IA64) && PCI
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Mak=
efile
index 7c9ef4a7667f..9c6d1d3626f6 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_HW_RANDOM) +=3D rng-core.o
 rng-core-y :=3D core.o
 obj-$(CONFIG_HW_RANDOM_TIMERIOMEM) +=3D timeriomem-rng.o
+obj-$(CONFIG_HW_RANDOM_JITTERENTROPY) +=3D jitterentropy-hwrng.o
 obj-$(CONFIG_HW_RANDOM_INTEL) +=3D intel-rng.o
 obj-$(CONFIG_HW_RANDOM_AMD) +=3D amd-rng.o
 obj-$(CONFIG_HW_RANDOM_ATMEL) +=3D atmel-rng.o
diff --git a/drivers/char/hw_random/jitterentropy-hwrng.c b/drivers/char/=
hw_random/jitterentropy-hwrng.c
new file mode 100644
index 000000000000..b7aeefe4f47d
--- /dev/null
+++ b/drivers/char/hw_random/jitterentropy-hwrng.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 Alexander E. Patrakov <patrakov@gmail.com>
+ *
+ * Driver that exposes CPU clock jitter as a hardware random number gene=
rator
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/hw_random.h>
+#include <crypto/rng.h>
+
+static struct crypto_rng *drng;
+
+static int jitterentropy_rng_read(struct hwrng *rng, void *data, size_t =
max, bool wait)
+{
+	int err;
+
+	/* Prevent the hwrng_fill thread from impeding progress of everything e=
lse */
+	if (wait)
+		schedule();
+
+	err =3D crypto_rng_get_bytes(drng, data, max);
+	if (err)
+		return err;
+	return max;
+}
+
+static struct hwrng jitterentropy_rng =3D {
+	.name		=3D KBUILD_MODNAME,
+	.read		=3D jitterentropy_rng_read,
+	.quality	=3D 4, /* minimum that guarantees progress in hwrng_fill threa=
d */
+};
+
+static int __init mod_init(void)
+{
+	int ret;
+
+	pr_info("Registering the driver\n");
+	drng =3D crypto_alloc_rng("jitterentropy_rng", 0, 0);
+	if (!drng) {
+		pr_err("crypto_alloc_rng() failed\n");
+		return -ENODEV;
+	}
+
+	ret =3D hwrng_register(&jitterentropy_rng);
+	if (ret) {
+		crypto_free_rng(drng);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit mod_exit(void)
+{
+	hwrng_unregister(&jitterentropy_rng);
+	crypto_free_rng(drng);
+}
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexander E. Patrakov <patrakov@gmail.com>");
+MODULE_DESCRIPTION("Exposes clock jitter as a hwrng");
+MODULE_SOFTDEP("pre: jitterentropy_rng");
--=20
2.23.0


--------------84DCDD92DB3AA9B299024B99--

--------------ms000304060005040105070706
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Криптографическая подпись S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
C5wwggVNMIIENaADAgECAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3DQEBCwUAMIGCMQsw
CQYDVQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoM
GkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBB
dXRoZW50aWNhdGlvbiBDQSBHMTAeFw0xOTA2MDYwODAxMzVaFw0yMDA2MDYwODAxMzVaMB0x
GzAZBgNVBAMMEnBhdHJha292QGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAOA0sb1ubDnIK32rbgW3BnjBcx1pYuEFOCU6aPVJ2gU+wtKJgAo9IdVUXG6kC1fF
hXjIcZHOgbEqzFjHK1yXlHIUWEv+N8KdmBDOK1UdKQj58d9A4hnH62iEiwQsOR5YT1UyHX4A
pfMjsBja7254cixR4jOPzfA4YUD6JTTPioyjDwuYQlhweVyXziKswLtGWfKeDcm3fOlKYxGy
hxjWJRamGTreNBVC9uMkF4DHszpUm07agR2U4mnWy7FsjBuRJ++iX0SvuxKWf19HQWgmgIys
jBVrArhVzgjOOnbvlklW849wIARF4Y0WAf91DsqPtuR8hu7+9KIVj2qk9BeNXXUCAwEAAaOC
AiEwggIdMAwGA1UdEwEB/wQCMAAwHwYDVR0jBBgwFoAUfmD8+GynPT3XrpOheQKPs3QpO/Uw
SwYIKwYBBQUHAQEEPzA9MDsGCCsGAQUFBzAChi9odHRwOi8vY2FjZXJ0LmFjdGFsaXMuaXQv
Y2VydHMvYWN0YWxpcy1hdXRjbGlnMTAdBgNVHREEFjAUgRJwYXRyYWtvdkBnbWFpbC5jb20w
RwYDVR0gBEAwPjA8BgYrgR8BGAEwMjAwBggrBgEFBQcCARYkaHR0cHM6Ly93d3cuYWN0YWxp
cy5pdC9hcmVhLWRvd25sb2FkMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDCB6AYD
VR0fBIHgMIHdMIGboIGYoIGVhoGSbGRhcDovL2xkYXAwNS5hY3RhbGlzLml0L2NuJTNkQWN0
YWxpcyUyMENsaWVudCUyMEF1dGhlbnRpY2F0aW9uJTIwQ0ElMjBHMSxvJTNkQWN0YWxpcyUy
MFMucC5BLi8wMzM1ODUyMDk2NyxjJTNkSVQ/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDti
aW5hcnkwPaA7oDmGN2h0dHA6Ly9jcmwwNS5hY3RhbGlzLml0L1JlcG9zaXRvcnkvQVVUSENM
LUcxL2dldExhc3RDUkwwHQYDVR0OBBYEFEhX9pz3jwI3+erfsAVB2b4xSsM8MA4GA1UdDwEB
/wQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAQEAVbKht9PGiUsUaqiyzJb6blSMNaLwopQr3AsI
FvthyqnSqxmSNYDeZsQYPgBnXvMCvHCn07pm1b96Y3XstBt2FWb9dpDr7y+ec3vxFHb3lKGb
3WREB1kEATnBu2++dPcILG58gdzgYde3RAJC3/OyOZhDqKwQA5CnXTHigTzw75iezdLne5pU
MjEQoxdqC+sgbrAueaEpMmRsGSKzgIX8eQ3DWwyIL56fYPJP3u4WZmBUKTFhhUWowG62QLtt
ZjkiX/j+vjcSRd2app8lYDwQRornZAqrDxy+c4qQJ5FN234p36opwespDCwLN3Z6wPzLvzS+
jAlmV3DF2xuZGMoebzCCBkcwggQvoAMCAQICCCzUitOxHg+JMA0GCSqGSIb3DQEBCwUAMGsx
CzAJBgNVBAYTAklUMQ4wDAYDVQQHDAVNaWxhbjEjMCEGA1UECgwaQWN0YWxpcyBTLnAuQS4v
MDMzNTg1MjA5NjcxJzAlBgNVBAMMHkFjdGFsaXMgQXV0aGVudGljYXRpb24gUm9vdCBDQTAe
Fw0xNTA1MTQwNzE0MTVaFw0zMDA1MTQwNzE0MTVaMIGCMQswCQYDVQQGEwJJVDEPMA0GA1UE
CAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAz
MzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBH
MTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMD8wYlW2Yji9ARlv80JNasoKTD+
DMr3J6scEe6GPV3k9WxEtgxXM5WX3oiKjS2p25Mqk8cnV2fpMaEvdO9alrGes0vqcUqly7Pk
U753RGlseYXR2XCjVhs4cuRYjuBmbxpRSJxRImmPnThKY41r0nl6b3A6Z2MOjPQF7h6OCYYw
tz/ziv/+UBV587U2uIlOukaS7Xjk4ArYkQsGTSsfBBXqqn06WL3xG+B/dRO5/mOtY5tHdhPH
ydsBk2kksI3PJ0yNgKV7o6HM7pG9pB6sGhj96uVLnnVnJ0WXOuV1ISv2eit9ir60LjT99hf+
TMZLxA5yaVJ57fYjBMbxM599cw0CAwEAAaOCAdUwggHRMEEGCCsGAQUFBwEBBDUwMzAxBggr
BgEFBQcwAYYlaHR0cDovL29jc3AwNS5hY3RhbGlzLml0L1ZBL0FVVEgtUk9PVDAdBgNVHQ4E
FgQUfmD8+GynPT3XrpOheQKPs3QpO/UwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRS
2Ig6yJ94Zu2J83s4cJTJAgI20DBFBgNVHSAEPjA8MDoGBFUdIAAwMjAwBggrBgEFBQcCARYk
aHR0cHM6Ly93d3cuYWN0YWxpcy5pdC9hcmVhLWRvd25sb2FkMIHjBgNVHR8EgdswgdgwgZag
gZOggZCGgY1sZGFwOi8vbGRhcDA1LmFjdGFsaXMuaXQvY24lM2RBY3RhbGlzJTIwQXV0aGVu
dGljYXRpb24lMjBSb290JTIwQ0EsbyUzZEFjdGFsaXMlMjBTLnAuQS4lMmYwMzM1ODUyMDk2
NyxjJTNkSVQ/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDtiaW5hcnkwPaA7oDmGN2h0dHA6
Ly9jcmwwNS5hY3RhbGlzLml0L1JlcG9zaXRvcnkvQVVUSC1ST09UL2dldExhc3RDUkwwDgYD
VR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQBNk87VJL5BG0oWWHNfZYny2Xo+WIy8
y8QP5VsWZ7LBS6Qz8kn8zJp3c9xdOkudZbcA3vm5U8HKXc1JdzNmpSh92zq/OeZLvUa+rnnc
mvhxkFE9Doag6NitggBPZwXHwDcYn430/F8wqAt3LX/bsd6INVrhPFk3C2SoAjLjUQZibXvQ
uFINMN4l6j86vCrkUaGzSqnXT45NxIivkAPhBQgpGtcTi4f+3DxkyTDbWtf9LuaC4l2jgB3g
C7f56nmdpGfpYsyvKE7+Ip+WryH93pWt6C+r68KU3Gu02cU1/dHvNOXWUDeKkVT3T26wZVrT
aMx+0nS3i63KDfJdhFzutfdBgCWHcp03NhOhMqy1RnAylF/dVZgkka6hKaWe1tOU21kS4uvs
D4wM5k6tl0pin2o6u47kyoJJMOxRSQcosWtDXUmaLHUG91ZC6hvBDmDmpmS6h/r+7mtPrpYO
xTr4hW3me2EfXkTvNTvBQtbi4LrZchg9vhi44EJ7L53g7GzQFn5KK8vqqgMb1c1+T0mkKdqS
edgGiB9TDdYtv4HkUj/N00TKxZMLiDMw4V8ShUL6bKTXNfb3E68s47cD+MatFjUuGFj0uFPv
ZlvlNAoJ7IMfXzIiTWy35X+akm+d49wBh54yv6icz2t/cBU1y1weuPBd8NUH/Ue3mXk0SXwk
GP3yVDGCA/YwggPyAgEBMIGXMIGCMQswCQYDVQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8w
DQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSww
KgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4r
qg9tGyNesDANBglghkgBZQMEAgEFAKCCAi8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMTkwOTE5MjA0NTQwWjAvBgkqhkiG9w0BCQQxIgQgImnlfwoQbLHl
mN6/LF2b2b7sHzXUsNK5jJfOvNzjHK4wbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASow
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqAYJKwYBBAGCNxAEMYGaMIGXMIGCMQswCQYD
VQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFj
dGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4rqg9tGyNesDCBqgYLKoZIhvcNAQkQAgsxgZqg
gZcwgYIxCzAJBgNVBAYTAklUMQ8wDQYDVQQIDAZNaWxhbm8xDzANBgNVBAcMBk1pbGFubzEj
MCEGA1UECgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5NjcxLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEcxAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3
DQEBAQUABIIBADTjTjIjbDuUdgxvLJssdHlBwQiUaozp2c6244FzldvPx62vYFdv+fyIrMdQ
mG1CwZSsuepqcieIVWWpLmNzhmFcdp/9Ex/AZScfpoNNb1NDjMeG08DMlZcWV5hwFFw94PFL
I8iEinfixgzGPmAh07eP4KmA8MvLmi78f4Ag0NkXyjj9vLvzEXEcxLdkJz74AHNSsKOPkCqv
A5UUjRioIXP0TikvF1PzcFvUZCTW0ZO+TbmdiLg3Dy7D8kVCtapYJhcvRi3wib1bgLA75V5m
FWvR8jXsPTTNDlKlAWNohiUI1XkFPD0E+rWXlIUAXe8ooEh0rgPMfZV9EOZ8ngM1N9wAAAAA
AAA=
--------------ms000304060005040105070706--
