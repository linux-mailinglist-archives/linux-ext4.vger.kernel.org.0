Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 916E2B9060
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 15:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfITNJI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 09:09:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51553 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725842AbfITNJH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Sep 2019 09:09:07 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8KD8v4h017107
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 09:08:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 017D7420811; Fri, 20 Sep 2019 09:08:56 -0400 (EDT)
Date:   Fri, 20 Sep 2019 09:08:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190920130856.GA16111@mit.edu>
References: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190919143427.GQ6762@mit.edu>
 <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 19, 2019 at 08:20:57AM -0700, Linus Torvalds wrote:
> And unlike your theoretical state extension attack, I can point you to
> black hat presentations that literally talk about using the fact that
> we delay m,ixing in the input pull hash to know what's going on:
> 
>   https://www.blackhat.com/docs/eu-14/materials/eu-14-Kedmi-Attacking-The-Linux-PRNG-On-Android-Weaknesses-In-Seeding-Of-Entropic-Pools-And-Low-Boot-Time-Entropy.pdf
> 
> That's a real attack. Based on the REAL fact that we currently have to
> use the urandom logic because the entropy-waiting one is useless, and
> in fact depends on the re-seeding happening too late.

Actually, that particular case proves my point.

In that particular attack was against Android 4.3 (Android KitKat).
In the 3.4 kernel used by KitKat, before the urandom pool is
considered initialized, 100% of the entropy from
add_interrupt_randomness() goes to the urandom pool, NOT the input
pool.  add_device_entropy() also fed the urandom pool.  And on an
Android device, it doesn't have a keyboard, mouse, or spinning HDD, so
add_timer_randomness() and add_disk_randomness() weren't a factor.

The real problem was that the Android zygote process sampled the the
urandom pool too early, and what the attack did was essentially one
where they were trying to determine the state of the pool by looking
at that sampled output of /dev/urandom.

If we make getrandom(0) work like /dev/urandom, it doesn't solve the
problem, because if you read from the entropy pool before we can get
high quality randomness, you're screwed.  The only real answers are
(a) try to get better entropy early, or (b) get userspace to wait
until it's safe to read from /dev/urandom.

Long-term, (a) is the only real way to solve the problem, and whether
you trust the bootloader, or trust the built-in hardware random number
generator (whether it's RDRAND, or some secure element in the device,
etc), we can't control userspace.  We can try to enforce userspace to
be safe by blocking, but that makes people unhappy.  We can certainly
try to influence userspace by annoying them with WARN() stack traces
in the logs, and hope they pay attention, but that's not guaranteed.

> But honestly, this isn't realistic. I can point to emails where *you*
> are  arguing against other hashing algorithms because the whole state
> extension attack simply isn't realistic.

The blackhat presentation which you pointed at *was* actually a state
extension attack.  When I argued against state extension attacks, that
was in cases where people worried about recovery after the pool is
exposed --- and my argument was if you can read from kernel memory
enough to grab the pool state, you have other problems.  Your
observation that if you can install malware that runs at system
initscript/userspace bootup time, you probably have other problems, is
a similar argument, and it's a fair one.  But it *has* happened, as
the blackhat paper demonstrates.

My thinking at the time is that if people are reading from the CRNG
before it's initialized (which could only happen via /dev/urandom),
that was kind of a disaster anyway, so resetting the initialization
count would at least get us to the point where when the CRNG *was*
declared to be initialized, that was something could state with high
confidence that we were in a secure state.  

> > I'm happy this proposed is not changing the behavior of getrandom(0).
> > Why not just remap 0 to GRND_EXPLICIT | GRND_WAIT_ENTROPY, though?  It
> > will have the same effect, and it's make it clear what we're doing.
> 
> Have you you not followed the whole discussion? Didn't you read the comment?
> 
> People use "getrandom(0)" not because they want secure randomness, but
> because that's the default.
> 
> And we *will* do something about it. This patch didn't, because I want
> to be able to backport it to stable, so that everybody is happier with
> saying "ok, I'll use the new getrandom(GRND_INSECURE)".
> 
> Because getrandom(0) will NOT be the the same as GRND_EXPLICIT |
> GRND_WAIT_ENTROPY.

No, I did read the comment.  And I agree that at the moment, that yes,
it is ambiguous.  What I really care about though, is the HUGE
DEPLOYED BASE which is using getrandom(0) *because* they are
generating cryptographic keys, and we will be changing things out from
under them.

We agree that we don't want to change things out from under the stable
users.  I'm pleading that we not screw over existing userspace --- at
least not right away.  Give them *time* to release update their source
bases to use getrandom(GRND_SECURE).  So what if we make getrandom(0)
print a ratelimited KERN_ERR deprecation notice that program should
switch to either specify either GRND_INSECURE or GRND_SECURE, and not
change the current semantics of getrandom(0) for some period of time?
Say, a year.  Or even six months.

If that's not good enough, what if we change getrandom(0) immediately,
but only for those platforms which have a functional
arch_get_random_long() or random_get_entropy()?  That gets us the x86
platform, which is where pretty much all of the users who have
complained have been coming from.  For the IOT/embedded user cases,
blocking is actually a feature, because the problem will be caught
while the product is in development, when the userspace code can be
fixed.

						- Ted
