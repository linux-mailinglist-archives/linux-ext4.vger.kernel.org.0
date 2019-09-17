Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A47FB4E59
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 14:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfIQMrC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 08:47:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43988 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfIQMrC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 08:47:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id u3so2743009lfl.10;
        Tue, 17 Sep 2019 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Y2m0sHF7mgAZAJd/cOqVpD/LZcY5Tm+V3uvi7F+Pvxg=;
        b=ReypTjVoF5R9KlXn4TTM98RWvSwx91zCSl6EPy1aAfE1AN9mGRlaMQATRhCKWTvzmT
         TkAF2w+moZnsbzBjJLa5Kmaqtr2rLrMGGIS6RX+tg3cYSpKfeqfeQsb/nrbyRE7GL5G4
         XOey4rYyfCS9za8p4Gi7GhiZYqT1n3/iEXAiVWD7EKl5tvBzygAnGe442COvSDjF1Iy0
         Yj6Vm35xqRA494uaDyf48WyVuUuV0yBpU0uSk2aYedD5vACnl9M7UbFVrzwjRZLIClqh
         CECdRfojJjQn97JKRNZIZzr/y6zkDcUx8pH5ibB/DoflFHXlseZXAUfOxFT4TPjDGDkI
         yqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Y2m0sHF7mgAZAJd/cOqVpD/LZcY5Tm+V3uvi7F+Pvxg=;
        b=DteoXq8HwDqmQwEG6APbSxV0idDB0xJvCFXmdDXt0dIdkYCiv79uV35bPk/KXMiXvg
         WItLmiAEdt++TytW4bcCgABCilk4KFGNg07Zzx572uPqDAc12yz7GIpC0v+vWZ8sEMXn
         M7hxg0DZxVJ7ik2VR08qnYGZjA/nDBcmfNkaNgTqggxaZk3Jia0ZovfwQP9WugPlChm3
         hufXoYbaLglIof0X0DruzelxlJgfyXmKDuA2LO55aEUb4eBg6kfPkU4Uj8V2x3nETs5H
         WicDRd6zYf4tqgh3xCEaRONhI8CJm1dAVadLpTjr493PXLRWU1v3CKsO1IrCt2KZpow7
         5dlA==
X-Gm-Message-State: APjAAAXASl51AzFGT7DplaS6mAv4xgCDc3cD0KZMI6UhB8Z0Jd/0kza5
        JgXP7kCTYXvn0J603aIPKNX0ADNnUnh6Rw==
X-Google-Smtp-Source: APXvYqwFOwZA5jRS4ZOMZcLa09vFKI5S2CpWin0iglW2Plnu7IugTo7a2LNrk73aJ95kCqtlvbElfg==
X-Received: by 2002:ac2:418c:: with SMTP id z12mr2100360lfh.183.1568724418995;
        Tue, 17 Sep 2019 05:46:58 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700::72c? ([2a02:17d0:4a6:5700::72c])
        by smtp.googlemail.com with ESMTPSA id u8sm485984lfb.36.2019.09.17.05.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 05:46:58 -0700 (PDT)
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Martin Steigerwald <martin@lichtvoll.de>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu> <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <871a40ac-2e69-a0db-39a3-4f17abbd8b6b@gmail.com>
Date:   Tue, 17 Sep 2019 17:46:56 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050106000302080105070402"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050106000302080105070402
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: quoted-printable

17.09.2019 17:30, Ahmed S. Darwish =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Tue, Sep 17, 2019 at 08:11:56AM -0400, Theodore Y. Ts'o wrote:
>> On Tue, Sep 17, 2019 at 09:33:40AM +0200, Martin Steigerwald wrote:
>>> Willy Tarreau - 17.09.19, 07:24:38 CEST:
>>>> On Mon, Sep 16, 2019 at 06:46:07PM -0700, Matthew Garrett wrote:
>>>>>> Well, the patch actually made getrandom() return en error too, but=

>>>>>> you seem more interested in the hypotheticals than in arguing
>>>>>> actualities.>
>>>>> If you want to be safe, terminate the process.
>>>>
>>>> This is an interesting approach. At least it will cause bug reports =
in
>>>> application using getrandom() in an unreliable way and they will
>>>> check for other options. Because one of the issues with systems that=

>>>> do not finish to boot is that usually the user doesn't know what
>>>> process is hanging.
>>>
>>
>> I would be happy with a change which changes getrandom(0) to send a
>> kill -9 to the process if it is called too early, with a new flag,
>> getrandom(GRND_BLOCK) which blocks until entropy is available.  That
>> leaves it up to the application developer to decide what behavior they=

>> want.
>>
>=20
> Yup, I'm convinced that's the sanest option too. I'll send a final RFC
> patch tonight implementing the following:
>=20
> config GETRANDOM_CRNG_ENTROPY_MAX_WAIT_MS
> 	int
> 	default 3000
> 	help
> 	  Default max wait in milliseconds, for the getrandom(2) system
> 	  call when asking for entropy from the urandom source, until
> 	  the Cryptographic Random Number Generator (CRNG) gets
> 	  initialized.  Any process exceeding this duration for entropy
> 	  wait will get killed by kernel. The maximum wait can be
> 	  overriden through the "random.getrandom_max_wait_ms" kernel
> 	  boot parameter. Rationale follows.
>=20
> 	  When the getrandom(2) system call was created, it came with
> 	  the clear warning: "Any userspace program which uses this new
> 	  functionality must take care to assure that if it is used
> 	  during the boot process, that it will not cause the init
> 	  scripts or other portions of the system startup to hang
> 	  indefinitely.
>=20
> 	  Unfortunately, due to multiple factors, including not having
> 	  this warning written in a scary enough language in the
> 	  manpages, and due to glibc since v2.25 implementing a BSD-like
> 	  getentropy(3) in terms of getrandom(2), modern user-space is
> 	  calling getrandom(2) in the boot path everywhere.
>=20
> 	  Embedded Linux systems were first hit by this, and reports of
> 	  embedded system "getting stuck at boot" began to be
> 	  common. Over time, the issue began to even creep into consumer
> 	  level x86 laptops: mainstream distributions, like Debian
> 	  Buster, began to recommend installing haveged as a workaround,
> 	  just to let the system boot.
>=20
> 	  Filesystem optimizations in EXT4 and XFS exagerated the
> 	  problem, due to aggressive batching of IO requests, and thus
> 	  minimizing sources of entropy at boot. This led to large
> 	  delays until the kernel's Cryptographic Random Number
> 	  Generator (CRNG) got initialized, and thus having reports of
> 	  getrandom(2) inidifinitely stuck at boot.
>=20
> 	  Solve this problem by setting a conservative upper bound for
> 	  getrandom(2) wait. Kill the process, instead of returning an
> 	  error code, because otherwise crypto-sensitive applications
> 	  may revert to less secure mechanisms (e.g. /dev/urandom). We
> 	  __deeply encourage__ system integrators and distribution
> 	  builders not to considerably increase this value: during
> 	  system boot, you either have entropy, or you don't. And if you
> 	  didn't have entropy, it will stay like this forever, because
> 	  if you had, you wouldn't have blocked in the first place. It's
> 	  an atomic "either/or" situation, with no middle ground. Please
> 	  think twice.
>=20
> 	  Ideally, systems would be configured with hardware random
> 	  number generators, and/or configured to trust the CPU-provided
> 	  RNG's (CONFIG_RANDOM_TRUST_CPU) or boot-loader provided ones
> 	  (CONFIG_RANDOM_TRUST_BOOTLOADER).  In addition, userspace
> 	  should generate cryptographic keys only as late as possible,
> 	  when they are needed, instead of during early boot.  (For
> 	  non-cryptographic use cases, such as dictionary seeds or MIT
> 	  Magic Cookies, other mechanisms such as /dev/urandom or
> 	  random(3) may be more appropropriate.)
>=20
> Sounds good?
>=20
> thanks,
>=20
> --
> Ahmed Darwish
> http://darwish.chasingpointers.com
>=20

This would fail the litmus test that started this thread, re-explained=20
below.

0. Linus applies your patch.
1. A kernel release happens, and it boots fine.
2. Ted Ts'o invents yet another brilliant ext4 optimization, and it gets =

merged.
3. Somebody discovers that the new kernel kills all his processes, up to =

and including gnome-session, and that's obviously a regression.
4. Linus is forced to revert (2), nobody wins.

--=20
Alexander E. Patrakov


--------------ms050106000302080105070402
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
BgkqhkiG9w0BCQUxDxcNMTkwOTE3MTI0NjU2WjAvBgkqhkiG9w0BCQQxIgQga8y8Mn82UFT/
sj1JYkoaG1aX79XTVermW/RyVS97YoswbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASow
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqAYJKwYBBAGCNxAEMYGaMIGXMIGCMQswCQYD
VQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFj
dGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4rqg9tGyNesDCBqgYLKoZIhvcNAQkQAgsxgZqg
gZcwgYIxCzAJBgNVBAYTAklUMQ8wDQYDVQQIDAZNaWxhbm8xDzANBgNVBAcMBk1pbGFubzEj
MCEGA1UECgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5NjcxLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEcxAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3
DQEBAQUABIIBANbIEFhU+IUyk+ChR5NhSDZwLGqq4WVDc4xL7DfaMSV5aWLlp8qwPLvt/oss
nMzoQVSaQ8GtTuFiPSSCg3u/OtXmXZ+9yuL1hn45UVM80K20qt4S2Mz8DpWpIyD7g2HfyJgx
OQm5UoR1UykB4+dFKY74WfGQQLQV5fe5qCjY46G0UZlHC4u37JXZpOa21ZL8c0yhXlkCqfwZ
znOTF+oAVyA+tQbs0hhmvkY0Pc60s/SK8cOdeeUTpE42jRqYbcepVOoBtkl5SnIac1vdacVy
4UIGi02VlhP1WQ4AOMWe1aq6e35zIpAh5slXTtLMPMiw/0fy66kyS48hw6sa1mjgR10AAAAA
AAA=
--------------ms050106000302080105070402--
