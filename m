Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97265B3FDF
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 20:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbfIPSAg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 14:00:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46823 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfIPSAg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 14:00:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id e17so758253ljf.13;
        Mon, 16 Sep 2019 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=UnCBXuPORb4jzrwcSdm1E7EKU2IEVNQtDWn3VSD+eRU=;
        b=C4Xxi0KGV339SuDI+k29Oeowrl7/SohrVgH6j3OEilO6GBgIf0U588BLOhW48GPzOq
         6GmuNoR7lafHFZD1EXj2wmLLRpCswXZ+PlETNrNK7khJbAO22QmsnlXP+EhcSpz6y+qZ
         rb2lRUOGp6g1IWu8U+0HE7KVKsDeYm+2h+dp/svmjsPj1uZuJVgAXZRhGzXxt/zpEOdU
         uv1yqheLi2Jv/XQg+AGHxt5bpGoM3cvNBvr6hRomlgNjRbz4VDPFYkzjYNDxiGPJBK2V
         imHM6cwcubPPOOha8qcOPFmR5G3BZ5ysYt9RvFg7qI5PbTjsCaktkNC2uSt0QI2awgEl
         CtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=UnCBXuPORb4jzrwcSdm1E7EKU2IEVNQtDWn3VSD+eRU=;
        b=kR48feB3WX386i0zNh+X2yc7ocCJLfRNjj0d4J8VpSXKNb6Keai8csJwunNtCtOiLm
         PGJK9hOjmQa5vxeWtTGfa3fPl1RoZOjVI4Ptl0ryLTKV10x0ni7N3HjYr5eZVTCVUMkp
         sND4FvdfDhWdZ3Mx+PwQ/TUbykQ/uvXWGQFP/GqpukNhaTt/+0anGLPNLCRtxJdjdiSq
         F9XtsOoR/UAM5qScUNPHKZcQw2G0vQRiO9jfA/C/VcwII5tPgDwsoMNPnuIAWn3KQgQS
         dbBlCLETWxcnrw/deSrVPTCmvn4Sgqe1Q5V18XrD3b0qFCoA2YwEDpdNbzzWTTQ+nCRF
         QlhA==
X-Gm-Message-State: APjAAAUaNN0SzObaDbGTNCHJVImvrNiY66fCe+3rc4mfQrg63EPIN9Vq
        qyKTr4FSixw19RernLC74/Qjj/9mnIBxJw==
X-Google-Smtp-Source: APXvYqylEcS6uXMTbRUQ9KVsYkoSCRJMIhrcMiyQgMat+QcXR1Q3kdgBaifpFx81iDLZBdVi00Nb0Q==
X-Received: by 2002:a2e:8ec6:: with SMTP id e6mr440446ljl.231.1568656833260;
        Mon, 16 Sep 2019 11:00:33 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700:d63d:7eff:fed9:a39? ([2a02:17d0:4a6:5700:d63d:7eff:fed9:a39])
        by smtp.googlemail.com with ESMTPSA id f6sm3537145lfl.78.2019.09.16.11.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 11:00:31 -0700 (PDT)
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
 <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
 <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu> <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu>
 <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <d5b96d3e-4f29-c50a-24b6-145735001484@gmail.com>
Date:   Mon, 16 Sep 2019 23:00:29 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916172117.GB15263@mit.edu>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070009000902040307050200"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070009000902040307050200
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: quoted-printable

16.09.2019 22:21, Theodore Y. Ts'o =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Mon, Sep 16, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:
>> So the semantics that getrandom() should have had are:
>>
>>   getrandom(0) - just give me reasonable random numbers for any of a
>> million non-strict-long-term-security use (ie the old urandom)
>>
>>      - the nonblocking flag makes no sense here and would be a no-op
>=20
> That change is what I consider highly problematic.  There are a *huge*
> number of applications which use cryptography which assumes that
> getrandom(0) means, "I'm guaranteed to get something safe
> cryptographic use".  Changing his now would expose a very large number
> of applications to be insecure.  Part of the problem here is that
> there are many different actors.  There is the application or
> cryptographic library developer, who may want to be sure they have
> cryptographically secure random numbers.  They are the ones who will
> select getrandom(0).
>=20
> Then you have the distribution or consumer-grade electronics
> developers who may choose to run them too early in some init script or
> systemd unit files.  And some of these people may do something stupid,
> like run things too early, or omit the a hardware random number
> generator in their design, even though it's for a security critical
> purpose (say, a digital wallet for bitcoin).  Because some of these
> people might do something stupid, one argument (not mine) is that we
> must therefore not let getrandom() block.  But doing this penalizes
> the security of all the users of the application, not just the stupid
> ones.

On Linux, there is no such thing as "too early", that's the problem.

First, we already had one lesson about this, regarding applications that =

require libraries from /usr. There, it was due to various programs that=20
run from udev rules, and dynamic/unpredictable dependencies. See=20
https://freedesktop.org/wiki/Software/systemd/separate-usr-is-broken/,=20
almost all arguments from there apply 1:1 here.

Second, people/distributions put unexpected stuff into their initramfs=20
images, and we cannot say that they have no right to do so. E.g., on my=20
system that's "cryptsetup" that unlocks the root partition, but manages=20
to read a few bytes of uninitialized urandom before that. A warning here =

is almost unavoidable, and thus will be treated as SPAM.

No such considerations apply to OpenBSD (initramfs does not exist, and=20
there is no equivalent of udev that reacts to cold-plug events by=20
running programs), that's why the getentropy() design works there.

If we were to fix it, we should focus on making true entropy available=20
unconditionally, even before /init in the initramfs starts, and warn not =

on the first access to urandom, but on the exec of /init. Look -=20
distributions are already running "haveged" which harvests entropy from=20
clock jitter. And they still manage to do it wrong (regardless whether=20
the "haveged" idea is wrong by itself), by running it too late (at least =

I don't know any kind of stock initramfs with either it or rngd=20
included). So it's too complex, and needs to be simplified.

The kernel already has jitterentropy-rng, it uses the same idea as=20
"haveged", but, alas, it is exposed as a crypto rng algorithm, not a=20
hwrng. And I think it is a bug: cryptoapi rng algorithms are for things=20
that get a seed and generate random numbers by rehashing it over and=20
over, while jitterentropy-rng requires no seed. Would a patch be=20
accepted to convert it to hwrng? (this is essentially the reverse of=20
what commit c46ea13 did for exynos-rng)

>=20
>>   getrandom(GRND_RANDOM) - get me actual _secure_ random numbers with
>> blocking until entropy pool fills (but not the completely invalid
>> entropy decrease accounting)
>>
>>      - the nonblocking flag is useful for bootup and for "I will
>> actually try to generate entropy".
>>
>> and both of those are very very sensible actions. That would actually
>> have _fixed_ the problems we had with /dev/[u]random, both from a
>> performance standpoint and for a filesystem access standpoint.
>>
>> But that is sadly not what we have right now.
>>
>> And I suspect we can't fix it, since people have grown to depend on
>> the old behavior, and already know to avoid GRND_RANDOM because it's
>> useless with old kernels even if we fixed it with new ones.
>=20
> I don't think we can fix it, because it's the changing of
> getrandom(0)'s behavior which is the problem, not GRND_RANDOM.  People
> *expect* getrandom(0) to always return secure results.  I don't think
> we can make it sometimes return not-necessarily secure results
> depending on when the systems integrator or distribution decides to
> run the application, and depending on the hardware platform (yes,
> traditional x86 systems are probably fine, and fortunately x86
> embedded CPU are too expensive and have lousy power management, so no
> one really uses x86 for embedded yet, despite Intel's best efforts).
> That would just be a purely irresponsible thing to do, IMO.
>=20
>> Does anybody really seriously debate the above? Ted? Are you seriously=

>> trying to claim that the existing GRND_RANDOM has any sensible use?
>> Are you seriously trying to claim that the fact that we don't have a
>> sane urandom source is a "feature"?
>=20
> There are people who can debate that GRND_RANDOM has any sensible use
> cases.  GPG uses /dev/random, and that was a fully informed choice.
> I'm not convinced, because I think that at least for now the CRNG is
> perfectly fine for 99.999% of the use cases.  Yes, in a post-quantum
> cryptography world, the CRNG might be screwed --- but so will most of
> the other cryptographic algorithms in the kernel.  So if anyone ever
> gets post-quantum cryptoanalytic attacks working, the use of the CRNG
> is going to be least of our problems.
>=20
> As I mentioned to you in Lisbon, I've been going back and forth about
> whether or not to rip out the entire /dev/random infrastructure,
> mainly for code maintainability reasons.  The only reason why I've
> been holding back is because there are (very few) non-insane people
> who do want to use it.  There are also a much larger of rational
> people who use it because they want some insane PCI compliance labs to
> go away.  What I suspect most of them are actually doing in practice
> is they use /dev/random, but they also use a hardware random number
> generator so /dev/random never actually blocks in practice.  The use
> of /dev/random is enough to make the PCI compliance lab go away, and
> the hardware random number generator (or virtio-rng on a VM) makes
> /dev/random useable.

Please don't forget about people who run Linux on Hyper-V, not on KVM,=20
and thus have no access to virtio-rng ;)

>=20
> But I don't think we can reuse GRND_RANDOM for that reason.
>=20
> We could create a new flag, GRND_INSECURE, which never blocks.  And
> that that allows us to solve the problem for silly applications that
> are using getrandom(2) for non-cryptographic use cases.  Use cases
> might include Python dictionary seeds, gdm for MIT Magic Cookie, UUID
> generation where best efforts probably is good enough, etc.  The
> answer today is they should just use /dev/urandom, since that exists
> today, and we have to support it for backwards compatibility anyway.
> It sounds like gdm recently switched to getrandom(2), and I suspect
> that it's going to get caught on some hardware configs anyway, even
> without the ext4 optimization patch.  So I suspect gdm will switch
> back to /dev/urandom, and this particular pain point will probably go
> away.
>=20
> 						- Ted
>=20

Well, at this point, I see that there is a lot of disagreement about how =

getrandom() should behave, aggravated by the baggage of existing=20
applications and libraries with contradictory requirements regarding=20
getrandom(0) (so not really solvable). I am almost convinced that we=20
might want to return -ENOSYS unconditionally, and create a different=20
system call with sane flags.

--=20
Alexander E. Patrakov


--------------ms070009000902040307050200
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
BgkqhkiG9w0BCQUxDxcNMTkwOTE2MTgwMDI5WjAvBgkqhkiG9w0BCQQxIgQgYrtV8Huhs74i
BO9qCmC+jrsW0bHRZEI+6SFyrx9BaBMwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASow
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqAYJKwYBBAGCNxAEMYGaMIGXMIGCMQswCQYD
VQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFj
dGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4rqg9tGyNesDCBqgYLKoZIhvcNAQkQAgsxgZqg
gZcwgYIxCzAJBgNVBAYTAklUMQ8wDQYDVQQIDAZNaWxhbm8xDzANBgNVBAcMBk1pbGFubzEj
MCEGA1UECgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5NjcxLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEcxAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3
DQEBAQUABIIBAC6Fif94h4pHIZXnh8q6zn2hyFzWXEyWOF/bRiR3cbHzW5lbyAhvwiDTJHDc
liIEkmCubt9FvCN2KgDl2tTPN+3GLX3d/cQJEjtcLoUSLoKAgJ1kX0fOIM9jVwCmkJf8/T1l
Lhg68jLmbjvUzgUu1pxGlU/qeRvPW0yPeWHulby9M3d5QDVPEnTO+C/ZBKWGCo6ocJwtmBlS
Ga1EqEyJ/1Y/Z6a7674mi7+xGPd9rUne53qqMzPaGBkDIdvmPFRNOvUndg90st1MQ6f10Rx+
BrIvYdVvx0l2Q5/F5j9pULOmcn16r9u+6Y2BQv5Hgzun7/VIcF5eR5JRDqexrgtgMm0AAAAA
AAA=
--------------ms070009000902040307050200--
