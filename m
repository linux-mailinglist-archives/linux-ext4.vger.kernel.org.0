Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4D512AC41
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 13:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLZMrK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 07:47:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37413 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfLZMrI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 07:47:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so13160888pfn.4
        for <linux-ext4@vger.kernel.org>; Thu, 26 Dec 2019 04:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=PhD3fzcXaiyg/tnRNmB1PHp90uiKGb3dtbUoxe3D81M=;
        b=j0Sr9BrQC8c4ydR3qnTOsxs5JBbHMOURHWk1OMF+jueydY6/R8MerHxfFK9aMjeUci
         qoTDLaUHDqccppNTClGJ//cvLmE2JnrWiRg5gwj4E+sb8t9iUIR9kSLxYhTVCL6YMTS0
         qvPpFyOfz0ynYef3nyD3WXBiWsiEg8mT9eSWc3biW2A/7z5GWOJ/4rBuh9F8TJjFn3pt
         sRvjeSXxOs+hNcHsw6GhundI6EYH2YPM1BSoBrMxmw5W6tElwlcMbJhP8HCmuP9zktxV
         lC6izpxnBJ7RcD+dxciYD0kKv41ev1ElZVP7tSDbFsC5w+b4e1KLDxnW8p0fn2MG+0Qw
         MuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=PhD3fzcXaiyg/tnRNmB1PHp90uiKGb3dtbUoxe3D81M=;
        b=pDPJJwpdzp3CUHvz2xKjy2cfcpaiqXSwIdWKECd2mm5g+TdKorD5ULWoLSQGOeLHMA
         gu8d7to9v7BqrvK+CCYznFkJaWV11LkNblL7uFEbdiOAIU+Usa617J3skFYa46lmgKDP
         vK849yigoc9cdZrXkhEBMhpjCFDjep4vafVb63gxHCbGbBKAQXe3913LwhMvi5GusJPY
         sjVRCH9+ZlVph3wLZS8I2DllA9RHBgvtIX05r1FXBRrow6ynJnGqn+69z9EnyhA1y3KL
         935+RbZVsqz6CaqNGs0fY7CIFmZKb+HkeM6sIcjzx0/EAhPUZqjb8sBMbENEuIdi9kV5
         KwpQ==
X-Gm-Message-State: APjAAAUUIQ56pq7eD/nEkFbHntJ0dZCWGp14iCJlJe1vXYQ8T4YLY0Gj
        LNweOxCKI4Qdt8C1HoN9AVaKUA==
X-Google-Smtp-Source: APXvYqzPa6VvdIr6Dl8mtjNyW3vIc35A2hn10EXkNtKJk3SGhwsdxozNFZ0TSQs/iz0ROixH9zEYWw==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr48236032pff.240.1577364426807;
        Thu, 26 Dec 2019 04:47:06 -0800 (PST)
Received: from [192.168.0.9] (111-255-104-19.dynamic-ip.hinet.net. [111.255.104.19])
        by smtp.gmail.com with ESMTPSA id 68sm33233315pge.14.2019.12.26.04.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 04:47:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/8] Rework random blocking
Date:   Thu, 26 Dec 2019 20:46:52 +0800
Message-Id: <E464D551-1631-4EA8-ADFB-852E16D29CA9@amacapital.net>
References: <4820831.xlnk3tY4r2@tauon.chronox.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ted Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
In-Reply-To: <4820831.xlnk3tY4r2@tauon.chronox.de>
To:     Stephan Mueller <smueller@chronox.de>
X-Mailer: iPhone Mail (17C54)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On Dec 26, 2019, at 8:04 PM, Stephan Mueller <smueller@chronox.de> wrote:
>=20
> =EF=BB=BFAm Donnerstag, 26. Dezember 2019, 12:12:29 CET schrieb Andy Lutom=
irski:
>=20
> Hi Andy,
>=20
>>>> On Dec 26, 2019, at 5:29 PM, Stephan M=C3=BCller <smueller@chronox.de> w=
rote:
>>>=20
>>> =EF=BB=BFAm Montag, 23. Dezember 2019, 09:20:43 CET schrieb Andy Lutomir=
ski:
>>>=20
>>> Hi Andy,
>>>=20
>>>> There are some open questions and future work here:
>>>>=20
>>>> Should the kernel provide an interface to get software-generated
>>>> "true random" numbers?  I can think of only one legitimate reason to
>>>> use such an interface: compliance with government standards.  If the
>>>> kernel provides such an interface going forward, I think it should
>>>> be a brand new character device, and it should have a default mode
>>>> 0440 or similar.  Software-generated "true random numbers" are a
>>>> very limited resource, and resource exhaustion is a big deal.  Ask
>>>> anyone who has twiddled their thumbs while waiting for gnupg to
>>>> generate a key.  If we think the kernel might do such a thing, then
>>>> patches 5-8 could be tabled for now.
>>>=20
>>> What about offering a compile-time option to enable or disable such code=
?
>>> Note, with the existing random.c code base, there is no need to have a
>>> separate blocking_pool. The ChaCha20 DRNG could be used for that very sa=
me
>>> purpose, provided that in case these true random numbers are generated
>>> when
>>> the Chacha20 DRNG received an equal amount of "unused" entropy.
>>=20
>> This scares me. The DRNG should be simple and easy to understand. If we=E2=
=80=99re
>> tapping extra numbers in some weird way, then I would be more comfortable=

>> with some clear assurance that this doesn=E2=80=99t break the security. I=
f we=E2=80=99re
>> tapping numbers in the same way as normal urandom, then I don=E2=80=99t r=
eally see
>> the point.
>=20
> Agreed. I was just trying to outline that the removal of the blocking_pool=
 is=20
> a good thing. Even when we decide that random.c should receive a TRNG, we d=
o=20
> not need to re-add a blocking pool, but can easily use the existing ChaCha=
20=20
> DRNG (most likely with its own instance).

Fair enough.

>=20
>>>> Alternatively, perhaps the kernel should instead provide a
>>>> privileged interface to read out raw samples from the various
>>>> entropy sources, and users who care could have a user daemon that
>>>> does something intelligent with them.  This would push the mess of
>>>> trying to comply with whatever standards are involved to userspace.
>>>> Userspace could then export "true randomness" via CUSE if it is so
>>>> inclined, or could have a socket with a well-known name, or whatever
>>>> else seems appropriate.
>>>=20
>>> With the patch set v26 of my LRNG I offer another possible alternative
>>> avoiding any additional character device file and preventing the
>>> starvation of legitimate use cases: the LRNG has an entropy pool that
>>> leaves different levels of entropy in the pool depending on the use case=
s
>>> of this data.
>>>=20
>>> If an unprivileged caller requests true random data, at least 1024 bits o=
f
>>> entropy is left in the pool. I.e. all entropy above that point is
>>> available
>>> for this request type. Note, even namespaces fall into this category
>>> considering that unprivileged users can create a user name space in whic=
h
>>> they can become root.
>>=20
>> This doesn=E2=80=99t solve the problem. If two different users run stupid=
 programs
>> like gnupg, they will starve each other.
>=20
> But such scenario will always occur, will it not? If there are two callers=
 for=20
> a limited resource, they will content if one "over-uses" the resource. My i=
dea=20
> was to provide an interface where its use does not starve other more relev=
ant=20
> use cases (e.g. seeding of the DRNGs). I.e. a user of a TRNG has the right=
 to=20
> be DoSed - that is the price to pay when using this concept.

Maybe I=E2=80=99m just cynical, but I expect that, if the feature is availab=
le to everyone, then lots of user programmers will use it even though they d=
on=E2=80=99t need to.  If, on the other hand, there is a barrier to entry, t=
hen people will be more likely to stop and think.

Even gnupg could have been more clever =E2=80=94 when generating a 4096-bit R=
SA key, there is no actual need for 4096 bits of entropy, however entropy is=
 defined. 256 bits would have been more than adequate.

(FWIW, my personal view is that 512 bits, in the sense of =E2=80=9Cthe distr=
ibution being sampled produces no output with probability greater than about=
 2^-512=E2=80=9D, is a good upper limit for even the most paranoid.  This is=
 because it=E2=80=99s reasonable to assume that an attacker can=E2=80=99t do=
 more than 2^128 operations. As djb has noted, multi-target attacks mean tha=
t you can amplify success probability in some cases by a factor that won=E2=80=
=99t exceed 2^128.  Some day, quantum computers might square-root everything=
, giving 512 bits. Actually, quantum computers won=E2=80=99t square root eve=
rything, but much more complicated analysis is needed to get a believable bo=
und.)

=E2=80=94Andy
