Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04C6B4F6E
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 15:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfIQNhf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 09:37:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40185 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfIQNhe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 09:37:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so3548571ljw.7;
        Tue, 17 Sep 2019 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=FbvSBTZNtszguQDI9rTH0oC8VcHjwmxUhGV6gMIwuLA=;
        b=nPRGxln+JvzxKYmEeV4c3p24xQeiy+moRIh61GhA6v5V+J6Nlo58x4n7WHtt/9rrpk
         JuAqf2FH76iOTkUrQVofNhTFmagMDkr4iCVLvLYPPROyxuw7PnB2CF1saX7x7PzzE2Og
         g2DAxTL1L/6n6z1daEJqYAe+64R88QtHxWbK04wxOV643lwRppDqR6vC2xsrVEdC9nbT
         N1CR5FQGDgQF3+n68makPvUX+HnZTmAL7xTFIwhmzBvsbRovdsrG5bLnuaPcZg/V/cvs
         bo6t8mSO56wk3nLV45m35p7KiwmCSuhCPWYVxPgzhOzHAL54PH+FPU6kV9GTGknDXghV
         rRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=FbvSBTZNtszguQDI9rTH0oC8VcHjwmxUhGV6gMIwuLA=;
        b=p66z09wujZcaiY3UqdmLPCmHD4cRyOeD0CBlH1iKneS+MUBcWkFjTan3oT09CwxXkI
         Dq7OZ1AZksqGeiDLOEG/hMFMG8rCqLnT0EuBrNFHzUKIhRLd6CihDrKyD17ycdGcGfKW
         8c6IcV1RGvmksfqJeXwixvOqimte60b3eeA+W0aWlighigVmy+vtUwm6X97WCzGfKFI0
         gleHi3YBC+4/jHgr2DpXhSfAm1Leo4lG2pFE6RqJLM1NuRaa9sE9JKv3V7mfc7VjbAJm
         NjjlnFQiSiNRHmiHU55QAsKKrdHDEwbaHsbpSuIFQUfDqZoyRBBe6ewdTYJJ2oq/rQDa
         RODg==
X-Gm-Message-State: APjAAAWYlt5RvDGGAToKbJ7a6um7rERnFFnnsTMXMht8K4VrIk0uJwzh
        7n0V8aNm12tgWNaXE0r5THSIUP6cd49hmw==
X-Google-Smtp-Source: APXvYqw+665/b6v76srsM0m1rcRW4588C0l7r+wPguXZs3T/ntaTYX9mdvoJjIz9vbw3JrzPp/Jj8A==
X-Received: by 2002:a05:651c:111c:: with SMTP id d28mr2041032ljo.138.1568727452085;
        Tue, 17 Sep 2019 06:37:32 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700::72c? ([2a02:17d0:4a6:5700::72c])
        by smtp.googlemail.com with ESMTPSA id p27sm445367lfo.95.2019.09.17.06.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:37:31 -0700 (PDT)
Subject: Re: Linux 5.3-rc8
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Martin Steigerwald <martin@lichtvoll.de>
Cc:     Willy Tarreau <w@1wt.eu>, Matthew Garrett <mjg59@srcf.ucam.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
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
 <6601569a-f339-bc2c-0459-5548a21d0595@gmail.com>
Message-ID: <fb0dbfd6-d183-01cd-cdaf-f45eaf826c52@gmail.com>
Date:   Tue, 17 Sep 2019 18:37:29 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <6601569a-f339-bc2c-0459-5548a21d0595@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090507060509090405070701"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090507060509090405070701
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: quoted-printable

17.09.2019 18:11, Alexander E. Patrakov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> 17.09.2019 17:11, Theodore Y. Ts'o =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> There are only two ways out of this mess.=C2=A0 The first option is we=
 take
>> functionality away from a userspace author who Really Wants A Secure
>> Random Number Generator.=C2=A0 And there are an awful lot of programs =
who
>> really want secure crypto, becuase this is not a hypothetical.=C2=A0 T=
he
>> result in "Mining your P's and Q's" did happen before.=C2=A0 If we for=
get
>> the history, we are doomed to repeat it.
>=20
> You cannot take away functionality that does not really exist. Every=20
> time somebody tries to use it, there is a huge news, "the boot process =

> is blocked on application FOO", followed by an insecure fallback to=20
> /dev/urandom in the said application or library.
>=20
> Regarding the "Mining your P's and Q's" paper: I would say it is a=20
> combination of TWO faults, only one of which (poor, or, as explained=20
> below, "marginally poor" entropy) is discussed and the other one (not=20
> really sound crypto when deriving the RSA key from the=20
> presumedly-available entropy) is ignored.
>=20
> The authors of the paper factored the weak keys by applying the=20
> generalized GCD algorithm, thus looking for common factors in the RSA=20
> public keys. For two RSA public keys to be detected as faulty, they mus=
t=20
> share exactly one of their prime factors. In other words: repeated keys=
=20
> were specifically excluded from the study by the paper authors.
>=20
> Sharing only one of the two primes means that that the systems in=20
> question behaved identically when they generated the first prime, but=20
> diverged (possibly due to the extra entropy becoming available) when=20
> they generated the second one. And asking the randomness for p and for =
q=20
> separately is what I would call the application bug here that nobody=20
> wants to talk about: both p and q should have been derived from a CSPRN=
G=20
> seeded by a single read from a random source. If that practice were=20
> followed, then it would either result in a duplicate key (which is not =

> as bad as a factorable one), or in completely unrelated keys.

I take this back. Of course, completely duplicate keys are weak keys,=20
and they are even more dangerous because they are not distinguishable=20
from intentionally copied good keys by the method in the paper.

--=20
Alexander E. Patrakov


--------------ms090507060509090405070701
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
BgkqhkiG9w0BCQUxDxcNMTkwOTE3MTMzNzI5WjAvBgkqhkiG9w0BCQQxIgQg/3vsbifzUodB
OjB+YydwqFbrlZ2gCVITdFz8FQ7/8X8wbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASow
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqAYJKwYBBAGCNxAEMYGaMIGXMIGCMQswCQYD
VQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFj
dGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4rqg9tGyNesDCBqgYLKoZIhvcNAQkQAgsxgZqg
gZcwgYIxCzAJBgNVBAYTAklUMQ8wDQYDVQQIDAZNaWxhbm8xDzANBgNVBAcMBk1pbGFubzEj
MCEGA1UECgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5NjcxLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEcxAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3
DQEBAQUABIIBAJugPVLnlYgkgXViGZhYGsp4UsLhQrYpssT7e4ylbDo/swie/1d/a7tOtblU
4pnI7q2TySi9G4Bowm6//2t5OghjDe5//OnmrhwAdfwYk0rJ1w5K/ULosCNCxnwMQYGT8SvE
07xIk7goJMeTdFyhwMDwCfDqKkxEyN5bmoW+mDi9EZ26N3Bx0+NpJNkwSBElomb7bKM1QOPq
8rLehLThDWmGrhH/xV6+2NQ06tCXKfzxbR/Krf9gnrOFT7kzTbYRuJ4smoff6NuMQOhUhivr
WMw4DY8uisOn4i1T3gU3vdlylOOIDE5X2/9GztUVP02GMALliHVe90RrauZFhdx8tEMAAAAA
AAA=
--------------ms090507060509090405070701--
