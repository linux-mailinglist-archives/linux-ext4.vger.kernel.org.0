Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FB4B31E4
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 21:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfIOTzH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 15:55:07 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45468 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfIOTzH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Sep 2019 15:55:07 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8FJsi6f023261;
        Sun, 15 Sep 2019 21:54:44 +0200
Date:   Sun, 15 Sep 2019 21:54:44 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH RFC v2] random: optionally block in getrandom(2) when the
 CRNG is uninitialized
Message-ID: <20190915195444.GA23245@1wt.eu>
References: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190915183240.GA23155@1wt.eu>
 <20190915183659.GA23179@1wt.eu>
 <CAHk-=wgFrRCL3WP7vyuZ-92xyqb97ADc=JNyyVCucZ1Q9oh8TA@mail.gmail.com>
 <20190915191814.GB23212@1wt.eu>
 <CAHk-=wiSdJ1ECOVz+T5iYc132m+XVVGi2nEiCQcT=+O-8FYUqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSdJ1ECOVz+T5iYc132m+XVVGi2nEiCQcT=+O-8FYUqA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 12:31:42PM -0700, Linus Torvalds wrote:
> On Sun, Sep 15, 2019 at 12:18 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > Oh no I definitely don't want this behavior at all for urandom, what
> > I'm saying is that as long as getrandom() will have a lower quality
> > of service than /dev/urandom for non-important randoms
> 
> Ahh, here you're talking about the fact that it can block at all being
> "lower quality".
> 
> I do agree that getrandom() is doing some odd things. It has the
> "total blocking mode" of /dev/random (if you pass it GRND_RANDOM), but
> it has no mode of replacing /dev/urandom.

Yep but with your change it's getting better.

> So if you want the /dev/urandom bvehavior, then no, getrandom() simply
> has never given you that.
> 
> Use /dev/urandom if you want that.

It's not available in chroot, which is the main driver for getrandom()
I guess.

> Sad, but there it is. We could have a new flag (GRND_URANDOM) that
> actually gives the /dev/urandom behavior. But the ostensible reason
> for getrandom() was the blocking for entropy. See commit c6e9d6f38894
> ("random: introduce getrandom(2) system call") from back in 2014.

Oh I definitely know it's been a long debate.

> The fact that it took five years to hit this problem is probably due
> to two reasons:
> 
>  (a) we're actually pretty good about initializing the entropy pool
> fairly quickly most of the time
> 
>  (b) people who started using 'getrandom()' and hit this issue
> presumably then backed away from it slowly and just used /dev/urandom
> instead.

We've hit it the hard way more than a year ago already, when openssl
adopted getrandom() instead of urandom for certain low-importance
things in order to work better in chroots and/or avoid fd leaks. And
even openssl had to work around these issues in multiple iterations
(I don't remember how however).

> So it needed an actual "oops, we don't get as much entropy from the
> filesystem accesses" situation to actually turn into a problem. And
> presumably the people who tried out things like nvdimm filesystems
> never used Arch, and never used a sufficiently new systemd to see the
> "oh, without disk interrupts you don't get enough randomness to boot".

In my case the whole system is in the initramfs and the only accesses
to the flash are to read the config. So that's pretty a limited source
of interrupts for a headless system ;-)

> One option is to just say that GRND_URANDOM is the default (ie never
> block, do the one-liner log entry to warn) and add a _new_ flag that
> says "block for entropy". But if we do that, then I seriously think
> that the new behavior should have that timeout limiter.

I think the timeout is a good thing to do, but it would be nice to
let the application know that what was provided was probably not as
good as expected (well if the application wants real random, it
should use GRND_RANDOM).

> For 5.3, I'll just revert the ext4 change, stupid as that is. That
> avoids the regression, even if it doesn't avoid the fundamental
> problem. And gives us time to discuss it.

It's sad to see that being excessive on randomness leads to forcing
totally unrelated subsystem to be less efficient :-(

Willy
