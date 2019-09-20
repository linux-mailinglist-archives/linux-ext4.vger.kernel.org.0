Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC424B979E
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436732AbfITTMS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 15:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389212AbfITTMS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 15:12:18 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 955FD217F5
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 19:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569006736;
        bh=lVnEe8Jn8F2DGIN9/szyr6J/Q78TK+MBqRbgvLHED2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K+RGN2fRSCqQMuwSwlgL5cRll9t73JlHCp8hIdVNw+6wRmZSwS5aJxXtE8wrjupwG
         ptmGH9gqrBbZMVRKJc+wZedzFpA7qz5UfuhtLU698uq/tI6VKdvquxesniEoJhhmBt
         k4J8mOqcIzx2hAo5hbLggZPkJ/akXFeSt3LHY934=
Received: by mail-wm1-f47.google.com with SMTP id i16so3654231wmd.3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 12:12:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVHaHanTQURp0ZjgnZQay25APdWN4wavWm4sweZYJRt8iUah8oU
        8MMCFwNntcUaxDLh6soEkq+I2wDvQzSFAPa4Oe4Rzg==
X-Google-Smtp-Source: APXvYqwH/6NGIAyFO4wmW+u/jVjWqaPV836Nh9IkcLg5TuW/r6fV08h0IPLeJGsJtJlc303Kxe9V/+oy/jUA//LUs8U=
X-Received: by 2002:a1c:5f0b:: with SMTP id t11mr4646168wmb.76.1569006735061;
 Fri, 20 Sep 2019 12:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc> <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
 <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com> <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
In-Reply-To: <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Sep 2019 12:12:03 -0700
X-Gmail-Original-Message-ID: <CALCETrUEqjFmPvpcJQwJe3dNbz8eaJ4k3_AV2u0v96MffjLn+g@mail.gmail.com>
Message-ID: <CALCETrUEqjFmPvpcJQwJe3dNbz8eaJ4k3_AV2u0v96MffjLn+g@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> On Sep 20, 2019, at 11:10 AM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>
> =EF=BB=BFOn Fri, Sep 20, 2019 at 10:52 AM Andy Lutomirski <luto@kernel.or=
g> wrote:
>>
>> IMO, from the beginning, we should have done this:
>>
>> GRND_INSECURE: insecure.  always works.
>>
>> GRND_SECURE_BLOCKING: does exactly what it says.
>>
>> 0: -EINVAL.
>
> Violently agreed. And that's kind of what the GRND_EXPLICIT is really
> aiming for.
>
> However, it's worth noting that nobody should ever use GRND_EXPLICIT
> directly. That's just the name for the bit. The actual users would use
> GRND_INSECURE or GRND_SECURE.
>
> And yes, maybe it's worth making the name be GRND_SECURE_BLOCKING just
> to make people see what the big deal is.
>
> In the meantime, we need that new bit just to be able to create the
> new semantics eventually. With a warning to nudge people in the right
> direction.
>
> We may never be able to return -EINVAL, but we can add the pr_notice()
> to discourage people from using it.
>

The problem is that new programs will have to try the new flag value
and, if it returns -EINVAL, fall back to 0.  This isn't so great.

> And yes, we'll have to block - at least for a time - to get some
> entropy. But at some point we either start making entropy up, or we
> say "0 means jitter-entropy for ten seconds".
>
> That will _work_, but it will also make the security-people nervous,
> which is just one more hint that they should move to
> GRND_SECURE[_BLOCKING].

Wait, are you suggesting that 0 means invoke jitter-entropy or
whatever and GRND_SECURE_BLOCKING means not wait forever and deadlock?
 That's no good -- people will want to continue using 0 because the
behavior is better. My point here is that asking for secure random
numbers isn=E2=80=99t some legacy oddity =E2=80=94 it=E2=80=99s genuinely n=
ecessary. The
kernel should do whatever it needs to in order to make it work.  We
really don=E2=80=99t want a situation where 0 means get me secure random
numbers reliably but spam the logs and GRND_SECURE_BLOCKING means
don=E2=80=99t spam the logs but risk deadlocking. This will encourage peopl=
e
to pass 0 to get the improved behavior.

> So GRND_EXPLICIT is a bit that basically means "I am explicit about
> what behavior I want". But part of that is that you need to _state_
> the behavior too.
>
> So:
>
> - GRND_INSECURE is (GRND_EXPLICIT | GRND_NONBLOCK)
>
>   As in "I explicitly ask you not to just not ever block": urandom

IMO this is confusing.  The GRND_RANDOM flag was IMO a mistake and
should just be retired.  Let's enumerate useful cases and then give
them sane values.

>
> - GRND_SECURE_BLOCKING is (GRND_EXPLICIT | GRND_RANDOM)
>
>   As in "I explicitly ask you for those secure random numbers"
>
> - GRND_SECURE_NONBLOCKING is (GRND_EXPLICIT | GRND_RANDOM | GRND_NONBLOCK=
)
>
>   As in "I want explicitly secure random numbers, but return -EAGAIN
> if that would block".
>
> Which are the three sane behaviors (that last one is useful for the "I
> can try to generate entropy if you don't have any" case. I'm not sure
> anybody will do it, but it definitely conceptually makes sense).
>
> And I agree that your naming is better.

I think this is the complete list of "good" behaviors for new programs:

"insecure": always works, never warns.

"secure, blocking": always returns *eventually* with secure output,
i.e., does something to avoid deadlocks

"secure, nonblocking" returns secure output immediately or returns -EAGAIN.

And the only real question is how to map existing users to these
semantics.  I see two sensible choices:

1. 0 means "secure, blocking". I think this is not what we'd do if we
could go back in time and chage the ABI from day 1, but I think it's
actually good enough.  As long as this mode won't deadlock, it's not
*that* bad if programs are using it when they wanted "insecure".

2. 0 means "secure, blocking, but warn".  Some new value means
"secure, blocking, don't warn".  The problem is that new applications
will have to fall back to 0 to continue supporting old kernels.

I briefly thought that maybe GRND_RANDOM would be a reasonable choice
for "secure, blocking, don't warn", but the effect on new programs on
old kernels will be unfortunate.

I'm willing to go along with #2 if you like it better than #1, and
I'll update my patches accordingly, but I prefer #1.

I do think we should make all the ABI changes that we want to make all
in one release.  Let's not make programs think about their behavior on
more versions than necessary.  So I'd like to get rid of the current
/dev/random semantics, add "insecure" mode, and do whatever deadlock
avoidance scheme we settle on in a single release.

--Andy
