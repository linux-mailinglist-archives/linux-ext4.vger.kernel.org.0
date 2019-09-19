Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861B5B8832
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 01:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394147AbfISXoi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Sep 2019 19:44:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34450 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732769AbfISXoh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Sep 2019 19:44:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19so3805095lja.1;
        Thu, 19 Sep 2019 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=i7RuiP19W1VhsgitsYVAzaqHOT4gNVIayT1+H/ObASg=;
        b=ZVV3OwmA72jygcagD5B0KAqIyLiyPww51wDkDJaO8LIneKYfe2QZ3m5QXOkL+pC2AO
         8Kdeop+eawtm0bdXcr53uhjpLYINXNqJPYgGDZ7ERf4hDrlejE4S7Xg/kJtYbJR4V0wx
         R/XdCVdRNweuqTfnt47FH+mDQzpOGJaLLmDa8FKZmPXmfk0snZ3ljSmiO3D+ZVpHg01X
         2+sgudXxJO9LHy5fIPBTBvO7ZrvEV367GleQIzkVSYRlLsw45R/PxC/k76iqczHjD1G8
         I0Ep2ck83c6yUV7kl1jAEaEyxRAnbldF7pVVHJinVkxnDrPVU9693VwwVuD7mxJeyK/K
         3+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=i7RuiP19W1VhsgitsYVAzaqHOT4gNVIayT1+H/ObASg=;
        b=RKgwmpuepyTaX41R7jn/IpzAADFUO1k6gD8Xi8sxtR/GajeRyVaEVCIna6XoZMdr+x
         TKtbH7PrXhp+13c7PfDEvqkPtq4UXBWp2Ll1h5rZrlgP5VQ3+vMQVYCRK7lVV2LZhUp1
         /2PCs+cObYo/L5bKDjo7mm1EoUulZTWDDm2GmYWbgET0bm7MJjLJ8WuxfOtlm53+tmKP
         NkT6eui6DM0rhaMkEBgzva69wIS4t3TRtqQ6Hg1GvXyw8JEuEwUV5VE1JMgv7fxHiayH
         7ax28PVkx4w8uSU2/R/vtUohdS/teJWXFit3erIvAsE0Kk9Qxh2AygZeQa8HobRv4jaX
         n2Ow==
X-Gm-Message-State: APjAAAV4dk9Zsgd8kDSJYmc/tLPyP79SP9NaKo6TTJy75SKb5xMqiTGc
        Y4M1TNmXAZX03t8NwjFXTVuK8eJ123N/TA==
X-Google-Smtp-Source: APXvYqxlnApVYXOOaxD88i0/CP5hDCXTm3cions2ZzKPjkoK6Fq96tp3e36TU5hXdS1YiPqNy30Eug==
X-Received: by 2002:a2e:1b56:: with SMTP id b83mr6816283ljb.107.1568936673639;
        Thu, 19 Sep 2019 16:44:33 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700::ae2? ([2a02:17d0:4a6:5700::ae2])
        by smtp.googlemail.com with ESMTPSA id q21sm85117lfc.2.2019.09.19.16.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 16:44:32 -0700 (PDT)
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
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
 <6adb02d4-c486-a945-7f51-d007d6de45b2@gmail.com>
 <CAHk-=wjGAaPAGnfok6fuZK1PYMkZ9bNOGkWXLYtS7+6bAWnAGQ@mail.gmail.com>
 <bd24cba4-b9c8-2ed8-6434-ee5932c24fb9@gmail.com>
Message-ID: <9f359f02-0b43-888c-2c05-8e6661bfa38f@gmail.com>
Date:   Fri, 20 Sep 2019 04:44:30 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <bd24cba4-b9c8-2ed8-6434-ee5932c24fb9@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010005020607080905000605"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010005020607080905000605
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: quoted-printable

20.09.2019 03:23, Alexander E. Patrakov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> 20.09.2019 02:47, Linus Torvalds =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On Thu, Sep 19, 2019 at 1:45 PM Alexander E. Patrakov
>> <patrakov@gmail.com> wrote:
>>>
>>> This already resembles in-kernel haveged (except that it doesn't cred=
it
>>> entropy), and Willy Tarreau said "collect the small entropy where it =
is,
>>> period" today. So, too many people touched upon the topic in one day,=

>>> and therefore I'll bite.
>>
>> I'm one of the people who aren't entirely convinced by the jitter
>> entropy - I definitely believe it exists, I just am not necessarily
>> convinced about the actual entropy calculations.
>>
>> So while I do think we should take things like the cycle counter into
>> account just because I think it's a a useful way to force some noise,
>> I am *not* a huge fan of the jitter entropy driver either, because of
>> the whole "I'm not convinced about the amount of entropy".
>>
>> The whole "third order time difference" thing would make sense if the
>> time difference was some kind of smooth function - which it is at a
>> macro level.
>>
>> But at a micro level, I could easily see the time difference having
>> some very simple pattern - say that your cycle counter isn't really
>> cycle-granular, and the load takes 5.33 "cycles" and you see a time
>> difference pattern of (5, 5, 6, 5, 5, 6, ...). No real entropy at all
>> there, it is 100% reliable.
>>
>> At a macro level, that's a very smooth curve, and you'd say "ok, time
>> difference is 5.3333 (repeating)". But that's not what the jitter
>> entropy code does. It just does differences of differences.
>>
>> And that completely non-random pattern has a first-order difference of=

>> 0, 1, 1, 0, 1, 1.. and a second order of 1, 0, 1, 1, 0,=C2=A0 and so o=
n
>> forever. So the "jitter entropy" logic will assign that completely
>> repeatable thing entropy, because the delta difference doesn't ever go=

>> away.
>>
>> Maybe I misread it.
>=20
> You didn't. Let me generalize and rephrase the part of the concern that=
=20
> I agree with, in my own words:
>=20
> The same code is used in cryptoapi rng, and also a userspace version=20
> exists. These two have been tested by the author via the "dieharder"=20
> tool (see the message for commit d9d67c87), so we know that on his=20
> machine it actually produces good-quality random bits. However, the=20
> in-kernel self-test is much, much weaker, and would not catch the=20
> situation when someone's machine is deterministic in a way that you=20
> describe, or something similar.

A constructive suggestion here would be to put the first few thousands=20
(ok, a completely made up number) raw timing intervals through a "gzip=20
compression test" in addition to the third derivative test, just based=20
on what we already have in the kernel.

--=20
Alexander E. Patrakov


--------------ms010005020607080905000605
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
BgkqhkiG9w0BCQUxDxcNMTkwOTE5MjM0NDMwWjAvBgkqhkiG9w0BCQQxIgQgK58SpgVGaQoV
xcP19nLEx4xA7QmyVd88OE/p90T5jDcwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASow
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqAYJKwYBBAGCNxAEMYGaMIGXMIGCMQswCQYD
VQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFj
dGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4rqg9tGyNesDCBqgYLKoZIhvcNAQkQAgsxgZqg
gZcwgYIxCzAJBgNVBAYTAklUMQ8wDQYDVQQIDAZNaWxhbm8xDzANBgNVBAcMBk1pbGFubzEj
MCEGA1UECgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5NjcxLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEcxAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3
DQEBAQUABIIBAIcUJdnriZ4quPoWUWaiu3YJCrjY2O7MXIzcv5YE6BamPiLVtAbNvv1/+mi+
MzSZrxlJM9Pv71qLJcyRgXKO1UXJg0OGyqaPnz1rXz1BKF5UAT44O9zEw1ELV5biqs70OcGh
dKVBmos1CdMvHnLR0WB3z5DgUFHGuUjTH2RApvv29be0NYqoG3gqu7OVDKlu8Dh83lIFPusw
DANMUXQ9+1M6oREFYrpVTZilsN/PtFZnDO7BRuWa7nY6YSEeeMddvNWX3yVhpIr4aOBvGMp3
N6Iksr7QscLmGuz+zZEUKGp5zB85rRF2gwJq+5MTYCrfiBdgrYhna4En8Z6s+3OdWfEAAAAA
AAA=
--------------ms010005020607080905000605--
