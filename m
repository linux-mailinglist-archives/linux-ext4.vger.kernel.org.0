Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29B5B96C9
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 19:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405213AbfITRwp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 13:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392420AbfITRwo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 13:52:44 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3720B2184C
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 17:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569001963;
        bh=1nVW0u8uyywS8edWGo4g+NKsuGKiY1Wm8uCUOB6VI7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S/LPFo4p1KIujc03l9elDZ+9O5DBAbLMASS2RqP7aNVeF1/ySxAvLJ02+EAO0mxGq
         8lo4NT1IeXacbZ6knqcwfSPkhKnT24k7IEVTrSy8JPhaz1s7GhBpDY2RZZkFLIGSc3
         FpHyf5f+hPY8VMIQPDn7rSBugtVDVRydRRWezzMs=
Received: by mail-wr1-f46.google.com with SMTP id v8so7672531wrt.2
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 10:52:43 -0700 (PDT)
X-Gm-Message-State: APjAAAXNhdT1/wy7Zp2t6b/QmwhehrDu24uPU4Z7+erN3XiCVhMd77v5
        fEzteXrQ+UYHAym2+wVAZo8l+Vg6pQ6k1MGcYhNzWg==
X-Google-Smtp-Source: APXvYqyBpWOKTid9UnrJQovepev+3qeVGshpnybdai3tpKoUsDw+lTDZP6jYIinDA+mi8znUaIQj/oiFxIqvCVsmJoQ=
X-Received: by 2002:adf:cc0a:: with SMTP id x10mr12735231wrh.195.1569001961606;
 Fri, 20 Sep 2019 10:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc> <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
In-Reply-To: <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Sep 2019 10:52:30 -0700
X-Gmail-Original-Message-ID: <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
Message-ID: <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
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
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 9:30 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 20, 2019 at 7:34 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > What is this GRND_EXPLICIT thing?
>
> Your own email gives the explanation:
>
> > Linus, I disagree that blocking while waiting for randomness is an
> > error.  Sometimes you want to generate a key
>
> That's *exactly* why GRND_EXPLICIT needs to be done regardless.
>
> The keyword there is "Sometimes".
>
> But people currently use "getrandom(0)" when they DO NOT want a key,
> they just want some miscellaneous random numbers for some totally
> non-security-related reason.
>
> And that will continue. Exactly because the people who do not want a
> key by definition aren't thinking about it very hard.

I fully agree that this is a problem.  It's a problem we brought on
ourselves because we screwed up the ABI from the beginning.  The
question is what to do about it that doesn't cause its own set of
nasty problems.

> So GRND_EXPLICIT is there very much to make sure people who want true
> secure keys will say so, and five years from now we will not have the
> confusion between "Oh, I wasn't thinking about bootup". Because at a
> minimum, in the near future getrandom(0) will warn about the
> ambiguity. Or it will use some questionable jitter entropy that some
> real key users will look at sideways and go "I don't want that".

There are programs that call getrandom(0) *today* that expect secure
output.  openssl does a horrible dance in which it calls getentropy()
if available and falls back to syscall(__NR_getrandom, buf, buflen, 0)
otherwise.  We can't break this use case.  Changing the semantics of
getrandom(0) out from under them seems like the worst kind of ABI
break -- existing applications will *appear* to continue working but
will, in fact, become insecure.

IMO, from the beginning, we should have done this:

GRND_INSECURE: insecure.  always works.

GRND_SECURE_BLOCKING: does exactly what it says.

0: -EINVAL.

Using it correctly would be obvious.  Something like GRND_EXPLICIT
would be a head-scratcher: people would have to look at the man page
and actually think about it, and it's still easy to get wrong:

getrandom(..., GRND_EXPLICIT): just fscking give me a number.  it
seems to work and it shuts up the warning

And we're back to square one.


I think that, given existing software, we should make two or three
changes to fix the basic problems here:

1. Add GRND_INSECURE: at least let new applications do the right thing
going forward.

2. Fix what is arguably a straight up kernel bug, not even an ABI
issue: when a user program is blocking in getrandom(..., 0), the
kernel happily sits there doing absolutely nothing and deadlocks the
system as a result.  This IMO isn't an ABI issue -- it's an
implementation problem.  How about we make getrandom() (probably
actually wait_for_random_bytes()) do something useful to try to seed
the RNG if the system is otherwise not doing IO.

3. Optionally, entirely in user code: Get glibc to add new *library*
functions: getentropy_secure_blocking() and getentropy_insecure() or
whatever they want to call them.  Deprecate getentropy().

I think #2 is critical.  Right now, suppose someone has a system that
neets to do a secure network request (a la Red Hat's Clevis).  I have
no idea what Clevis actually does, but it wouldn't be particularly
crazy to do a DH exchange or sign with an EC key to ask some network
server to help unlock a dm-crypt volume.  If the system does this at
boot, it needs to use getrandom(..., 0), GRND_EXPLICIT, or whatever,
because it NEEDS a secure random number.  No about of ABI fiddling
will change this.  The kernel should *work* in this case rather than
deadlocking.

--Andy
