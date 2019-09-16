Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F7B4005
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 20:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbfIPSIE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 14:08:04 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:39562 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389924AbfIPSIE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 14:08:04 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 21DEFE80FFC;
        Mon, 16 Sep 2019 20:08:02 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id C5C67160ADC; Mon, 16 Sep 2019 20:08:01 +0200 (CEST)
Date:   Mon, 16 Sep 2019 20:08:01 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2] random: optionally block in getrandom(2) when the
 CRNG is uninitialized
Message-ID: <20190916180801.GB30990@gardel-login>
References: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On So, 15.09.19 10:32, Linus Torvalds (torvalds@linux-foundation.org) wrote:

> [ Added Lennart, who was active in the other thread ]
>
> On Sat, Sep 14, 2019 at 10:22 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > Thus, add an optional configuration option which stops getrandom(2)
> > from blocking, but instead returns "best efforts" randomness, which
> > might not be random or secure at all.
>
> So I hate having a config option for something like this.
>
> How about this attached patch instead? It only changes the waiting
> logic, and I'll quote the comment in full, because I think that
> explains not only the rationale, it explains every part of the patch
> (and is most of the patch anyway):
>
>  * We refuse to wait very long for a blocking getrandom().
>  *
>  * The crng may not be ready during boot, but if you ask for
>  * blocking random numbers very early, there is no guarantee
>  * that you'll ever get any timely entropy.
>  *
>  * If you are sure you need entropy and that you can generate
>  * it, you need to ask for non-blocking random state, and then
>  * if that fails you must actively _do_something_ that causes
>  * enough system activity, perhaps asking the user to type
>  * something on the keyboard.

You are requesting a UI change here. Maybe the kernel shouldn't be the
one figuring out UI.

I mean, as I understand you are unhappy with behaviour you saw on
systemd systems; we can certainly improve behaviour of systemd in
userspace alone, i.e. abort the getrandom() after a while in userspace
and log about it using typical userspace logging to the console. I am
not sure why you want to do all that in the kernel, the kernel isn't
great at user interaction, and really shouldn't be.

If all you want is abort the getrandom() after 30s and a friendly
message on screen, by all means, let's add that to systemd, I have
zero problem with that. systemd has infrastructure for pushing that to
the user, the kernel doesn't really have that so nicely.

It appears to me you subscribe too much to an idea that userspace
people are not smart enough and couldn't implement something like
this. Turns out we can though, and there's no need to add logic that
appears to follow the logic of "never trust userspace"...

i.e. why not just consider this all just a feature request for the
systemd-random-seed.service, i.e. the service you saw the issue with
to handle this on its own?

> Hmm? No strange behavior. No odd config variables. A bounded total
> boot-time wait of 30s (which is a completely random number, but I
> claimed it as the "big red button" time).

As mentioned, in systemd's case, updating the random seed on disk
is entirely fine to take 5h or so. I don't really think we really need
to bound this in kernel space.

Lennart

--
Lennart Poettering, Berlin
