Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD386B2C41
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfINQfU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 12:35:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34038 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfINQfU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 12:35:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so13031223lfm.1;
        Sat, 14 Sep 2019 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=zF94AwdVKK7RKbQpXTMiMshxoycEBwVhKtPGWg7jXVE=;
        b=N2ulPpyZnI66VnzTH5ZKle/GAd4ONKC6p82dg0VPD/IRMPfcftpiUx87amcc0j9mjG
         LW6r1XrVX5xskRSdHK9lFUeOakxuB15ezFrK/nnEinxhZHWxVj2+ncxBYBWfQwHU0QTv
         ehtaX/T1TCtkwfZM9lBp27EQiBypfFzWqTZYNr666FYi9ZoQbrtAsrZdgViYUFig7+DL
         TQl/QJzF+u6bhgOoqZxMBwClOTQMafQcTOewoBFNmuV0B6sVGx14vgSBEiBCCy9ji7kq
         x7Bt/o5sExTnx7nV3QmIYT36ime1DLN2ISIgOnf8PUJa+G6uXL11zZ42IKcT/hiIdQNk
         FFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=zF94AwdVKK7RKbQpXTMiMshxoycEBwVhKtPGWg7jXVE=;
        b=mcHbgnDgLCY/oCjkWzKbKFg9jPfzVrSWKLwJlKDh6Bs5tOgV5ZyeHDz+r+iryPQaAb
         bicABOKtljZKG9gq7OrGkIvwnDVP0xvJw9f38Hyr1tuPiKWXujFlx8lX6LIOXlzq8Vij
         NGFh2tGkhJIub+pRlU64cGYF+7F/gV9KjOefiFBV5oHW9LAKBpLOg4QuNSZ05yivokF5
         29kxSpMw8W+sgBVJB1aqrTdA435CoLg7lKr3pThFbGvMzg0AMaiUQ3R0eA1trUrIGt/W
         5YjMXaxVowm6dyYHKmmV8iO1LZpKShUnCX2VMzgrrR3yg+knaXP6ONOAvPHa6CRriTD0
         PPuw==
X-Gm-Message-State: APjAAAUGDd+9Dj3kJ8sb5IsmEgXhUxYl/QxE5XjuGlSHt31MgyGcOJLP
        aFRBSKJuxFJJ4brvQ943Dtx1fB4hNWDw1A==
X-Google-Smtp-Source: APXvYqy1PGAimQOp2TqbN4+wz6fFTFN0b45RNi2V4HZoC5+5fEgOmiOcfypGRQ4oiBv5Ve0Nrj6nkQ==
X-Received: by 2002:a19:5d53:: with SMTP id p19mr12612716lfj.109.1568478914802;
        Sat, 14 Sep 2019 09:35:14 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700::a11? ([2a02:17d0:4a6:5700::a11])
        by smtp.googlemail.com with ESMTPSA id z20sm694288ljk.63.2019.09.14.09.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 09:35:13 -0700 (PDT)
Subject: Re: Linux 5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
Date:   Sat, 14 Sep 2019 21:35:12 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070301000708070209070806"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070301000708070209070806
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: quoted-printable

14.09.2019 21:30, Linus Torvalds =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Sat, Sep 14, 2019 at 8:02 AM Ahmed S. Darwish <darwish.07@gmail.com>=
 wrote:
>>
>> On Thu, Sep 12, 2019 at 12:34:45PM +0100, Linus Torvalds wrote:
>>>
>>> An alternative might be to make getrandom() just return an error
>>> instead of waiting. Sure, fill the buffer with "as random as we can"
>>> stuff, but then return -EINVAL because you called us too early.
>>
>> ACK, that's probably _the_ most sensible approach. Only caveat is
>> the slight change in user-space API semantics though...
>>
>> For example, this breaks the just released systemd-random-seed(8)
>> as it _explicitly_ requests blocking behvior from getrandom() here:
>>
>=20
> Actually, I would argue that the "don't ever block, instead fill
> buffer and return error instead" fixes this broken case.
>=20
>>      =3D> src/random-seed/random-seed.c:
>>      /*
>>       * Let's make this whole job asynchronous, i.e. let's make
>>       * ourselves a barrier for proper initialization of the
>>       * random pool.
>>       */
>>       k =3D getrandom(buf, buf_size, GRND_NONBLOCK);
>>       if (k < 0 && errno =3D=3D EAGAIN && synchronous) {
>>           log_notice("Kernel entropy pool is not initialized yet, "
>>                      "waiting until it is.");
>>
>>           k =3D getrandom(buf, buf_size, 0); /* retry synchronously */=

>>       }
>=20
> Yeah, the above is yet another example of completely broken garbage.
>=20
> You can't just wait and block at boot. That is simply 100%
> unacceptable, and always has been, exactly because that may
> potentially mean waiting forever since you didn't do anything that
> actually is likely to add any entropy.
>=20
>>       if (k < 0) {
>>           log_debug_errno(errno, "Failed to read random data with "
>>                           "getrandom(), falling back to "
>>                           "/dev/urandom: %m");
>=20
> At least it gets a log message.
>=20
> So I think the right thing to do is to just make getrandom() return
> -EINVAL, and refuse to block.

Let me repeat: not -EINVAL, please. Please find some other error code,=20
so that the application could sensibly distinguish between this case=20
(low quality entropy is in the buffer) and the "kernel is too dumb" case =

(and no entropy is in the buffer).


--=20
Alexander E. Patrakov


--------------ms070301000708070209070806
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
BgkqhkiG9w0BCQUxDxcNMTkwOTE0MTYzNTEyWjAvBgkqhkiG9w0BCQQxIgQgJNZnMxGZ0OlP
HdNNtMBPW3ELoyD7QnFVgA0JObW459QwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASow
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqAYJKwYBBAGCNxAEMYGaMIGXMIGCMQswCQYD
VQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFj
dGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4rqg9tGyNesDCBqgYLKoZIhvcNAQkQAgsxgZqg
gZcwgYIxCzAJBgNVBAYTAklUMQ8wDQYDVQQIDAZNaWxhbm8xDzANBgNVBAcMBk1pbGFubzEj
MCEGA1UECgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5NjcxLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEcxAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3
DQEBAQUABIIBAGr9NwO/u+Xp8Pkb4dH9FVUl8rcBibktzhueuHzBvUdp7slRsYyyl1GOzAf+
4Fg81FefOYQJhcupA2ixswrVVfdtd/m/dH9dMn2uaOhv9Jcfnbn10Aw4JcDHeugDtCD7p2ok
BYJNmRA0qvNlWKx7Mht5FRl0tPKRdYg7Gf4/Ez64zBGDh2jFjX+faY+SBpIpNgBF2Jrjd6CE
QRKqCLrMJBHTrnE+PC6Lzt3UxYDL6JtAzcRQ6fa8doDveY8K2qbM2AgPfXSbXbwz3qx0DWL9
B12jKgYiiFmkTABtODXUjyhfPjUbNuct1HMmXzQz0VVW+uwff4p2GwniLNDj7IZhbAcAAAAA
AAA=
--------------ms070301000708070209070806--
