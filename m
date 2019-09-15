Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F26BB2EDF
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 08:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfIOG7r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 02:59:47 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:38278 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfIOG7r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 02:59:47 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 502B3E81176;
        Sun, 15 Sep 2019 08:51:43 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id C5A95160ADC; Sun, 15 Sep 2019 08:51:42 +0200 (CEST)
Date:   Sun, 15 Sep 2019 08:51:42 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190915065142.GA29681@gardel-login>
References: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sa, 14.09.19 09:30, Linus Torvalds (torvalds@linux-foundation.org) wrote:

> >     => src/random-seed/random-seed.c:
> >     /*
> >      * Let's make this whole job asynchronous, i.e. let's make
> >      * ourselves a barrier for proper initialization of the
> >      * random pool.
> >      */
> >      k = getrandom(buf, buf_size, GRND_NONBLOCK);
> >      if (k < 0 && errno == EAGAIN && synchronous) {
> >          log_notice("Kernel entropy pool is not initialized yet, "
> >                     "waiting until it is.");
> >
> >          k = getrandom(buf, buf_size, 0); /* retry synchronously */
> >      }
>
> Yeah, the above is yet another example of completely broken garbage.
>
> You can't just wait and block at boot. That is simply 100%
> unacceptable, and always has been, exactly because that may
> potentially mean waiting forever since you didn't do anything that
> actually is likely to add any entropy.

Oh man. Just spend 5min to understand the situation, before claiming
this was garbage or that was garbage. The code above does not block
boot. It blocks startup of services that explicit order themselves
after the code above. There's only a few services that should do that,
and the main system boots up just fine without waiting for this.

Primary example for stuff that orders itself after the above,
correctly: cryptsetup entries that specify /dev/urandom as password
source (i.e. swap space and stuff, that wants a new key on every
boot). If we don't wait for the initialized pool for cases like that
the password for that swap space is not actually going to be random,
and that defeats its purpose.

Another example: the storing of an updated random seed file on
disk. We should only do that if the seed on disk is actually properly
random, i.e. comes from an initialized pool. Hence we wait for the
pool to be initialized before reading the seed from the pool, and
writing it to disk.

I'd argue that doing things like this is not "garbage", like you say,
but *necessary* to make this stuff safe and secure.

And no, other stuff is not delayed for this (but there are bugs of
course, some random services in 3rd party packages that set too
agressive deps, but that needs to be fixed there, and not in the
kernel).

Anyway, I really don't appreciate your tone, and being sucked into
messy LKML discussions. I generally stay away from LKML, and gah, you
remind me why. Just tone it down, not everything you never bothered to
understand is "garbage".

And please don't break /dev/urandom again. The above code is the ony
way I see how we can make /dev/urandom-derived swap encryption safe,
and the only way I can see how we can sanely write a valid random seed
to disk after boot. You guys changed semantics on /dev/urandom all the
time in the past, don't break API again, thank you very much.

Lennart
