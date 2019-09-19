Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B749B83A9
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2019 23:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbfISVsS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Sep 2019 17:48:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46726 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbfISVsR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Sep 2019 17:48:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so5044901ljf.13
        for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2019 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edBNiUCAkfvN/3XpQNySJ3URni0Ib/sxF2qoxmEcdPs=;
        b=aVaV1zCjOFb/oCr3LlveP0iW40Bbf85kACXi2TPOzhPig+J6nPBdquOOmmczmq3Pvz
         eAU+3Jy03OQ31MfO232+fud/OluIqVj1sjHgRJxGMQN/Cu5OAgjExkpNb+RVnX54oHiP
         ko0EAsEVkDpJzJdh060J1gEBSzBA17aW3PG2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edBNiUCAkfvN/3XpQNySJ3URni0Ib/sxF2qoxmEcdPs=;
        b=Xd84LXDEA6lDex7i/06qm3tQftB+J+X9RSa5UET323R4ZEkV3SSxyUAVzXzTMlC/IM
         Fri1nPWeC/crBbi6yblCfuB77iB3idkr5zBXQ0c3E7ZYWd5JJ5QNpO1z2QY2jnxcGVRG
         GKuFDHKWsXYcVLIJeaGUvDIdyvB5+JxnRbZ7cA3nyM2doPyEHwDrY1BXfijlVrfUzA00
         /Iw31o2uTDv4XL4J04APU1zVxBbwwlFvOyjmbPS3cPbV7yrBsUhkMqsjgcCEnVCjxEE2
         skS5DODQ7eev7/7FmzrYtzwN0VCkaSZiOr7OZK0CrHM2LbKCgEuhIY9MDTRMJVhQBeU/
         pZqg==
X-Gm-Message-State: APjAAAUlRO2NuboYjSGf9+YPTqYhLlvDlL3BzduATSu9+84vD6NYtA91
        t4I8PBM6wLZX0hRrxwisRpPvZavOwKA=
X-Google-Smtp-Source: APXvYqxWVwvB3Ta/V1Z7H0DZsiAaIkqgyPBL27R7QSMJP0i7X6x3qVXMI86S2FmrmxGpljn3EQIM7w==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr6523172ljj.189.1568929695061;
        Thu, 19 Sep 2019 14:48:15 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q88sm1948751lje.57.2019.09.19.14.48.14
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 14:48:14 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id q11so3453517lfc.11
        for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2019 14:48:14 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr6182150lfp.134.1568929693778;
 Thu, 19 Sep 2019 14:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190919143427.GQ6762@mit.edu> <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
 <CAHk-=wjTbpcyVevsy3g-syB5v9gk_rR-yRFrUAvTL8NFuGfCrw@mail.gmail.com> <6adb02d4-c486-a945-7f51-d007d6de45b2@gmail.com>
In-Reply-To: <6adb02d4-c486-a945-7f51-d007d6de45b2@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 14:47:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGAaPAGnfok6fuZK1PYMkZ9bNOGkWXLYtS7+6bAWnAGQ@mail.gmail.com>
Message-ID: <CAHk-=wjGAaPAGnfok6fuZK1PYMkZ9bNOGkWXLYtS7+6bAWnAGQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 19, 2019 at 1:45 PM Alexander E. Patrakov
<patrakov@gmail.com> wrote:
>
> This already resembles in-kernel haveged (except that it doesn't credit
> entropy), and Willy Tarreau said "collect the small entropy where it is,
> period" today. So, too many people touched upon the topic in one day,
> and therefore I'll bite.

I'm one of the people who aren't entirely convinced by the jitter
entropy - I definitely believe it exists, I just am not necessarily
convinced about the actual entropy calculations.

So while I do think we should take things like the cycle counter into
account just because I think it's a a useful way to force some noise,
I am *not* a huge fan of the jitter entropy driver either, because of
the whole "I'm not convinced about the amount of entropy".

The whole "third order time difference" thing would make sense if the
time difference was some kind of smooth function - which it is at a
macro level.

But at a micro level, I could easily see the time difference having
some very simple pattern - say that your cycle counter isn't really
cycle-granular, and the load takes 5.33 "cycles" and you see a time
difference pattern of (5, 5, 6, 5, 5, 6, ...). No real entropy at all
there, it is 100% reliable.

At a macro level, that's a very smooth curve, and you'd say "ok, time
difference is 5.3333 (repeating)". But that's not what the jitter
entropy code does. It just does differences of differences.

And that completely non-random pattern has a first-order difference of
0, 1, 1, 0, 1, 1.. and a second order of 1, 0, 1, 1, 0,  and so on
forever. So the "jitter entropy" logic will assign that completely
repeatable thing entropy, because the delta difference doesn't ever go
away.

Maybe I misread it.

We used to (we still do, but we used to too) do that same third-order
delta difference ourselves for the interrupt timing entropy estimation
in add_timer_randomness(). But I think it's more valid with something
that likely has more noise (interrupt timing really _should_ be
noisy). It's not clear that the jitterentropy load really has all that
much noise.

That said, I'm _also_ not a fan of the user mode models - they happen
too late anyway for some users, and as you say, it leaves us open to
random (heh) user mode distribution choices that may be more or less
broken.

I would perhaps be willing to just put my foot down, and say "ok,
we'll solve the 'getrandom(0)' issue by just saying that if that
blocks too  much, we'll do the jitter entropy thing".

Making absolutely nobody happy, but working in practice. And maybe
encouraging the people who don't like jitter entropy to use
GRND_SECURE instead.

              Linus
