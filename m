Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD3B34A0
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 08:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfIPGN3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 02:13:29 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45723 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfIPGN3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Sep 2019 02:13:29 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8G6Cqap024026;
        Mon, 16 Sep 2019 08:12:52 +0200
Date:   Mon, 16 Sep 2019 08:12:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916061252.GA24002@1wt.eu>
References: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
 <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
 <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu>
 <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 10:02:02PM -0700, Linus Torvalds wrote:
> On Sun, Sep 15, 2019 at 9:30 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > I'd be in favor of adding in the man page something like "this
> > random source is only suitable for applications which will not be
> > harmed by getting a predictable value on output, and as such it is
> > not suitable for generation of system keys or passwords, please
> > use GRND_RANDOM for this".
> 
> The problem with GRND_RANDOM is that it also ends up extracting
> entropy, and has absolutely horrendous performance behavior. It's why
> hardly anybody uses /dev/random.
>
> Which nobody should really ever do. I don't understand why people want
> that thing, considering that the second law of thermodynamics really
> pretty much applies. If you can crack the cryptographic hashes well
> enough to break them despite reseeding etc, people will have much more
> serious issues than the entropy accounting.

That's exactly what I was thinking about a few minutes ago and which
drove me back to mutt :-)

> So the problem with getrandom() is that it only offered two flags, and
> to make things worse they were the wrong ones.
(...)
>  - GRND_RANDOM | GRND_NONBLOCK - don't use
> 
>    This won't block, but it will decrease the blocking pool entropy.
> 
>    It might be an acceptable "get me a truly secure ring with reliable
> performance", but when it fails, you're going to be unhappy, and there
> is no obvious fallback.
> 
> So three out of four flag combinations end up being mostly "don't
> use", and the fourth one isn't what you'd normally want (which is just
> plain /dev/urandom semantics).

I'm seeing it from a different angle. I now understand better why
getrandom() absolutely wants to have an initialized pool, it's to
encourage private key producers to use a secure, infinite source of
randomness. Something that neither /dev/random nor /dev/urandom
reliably provide. Unfortunately it does it by changing how urandom
works while it ought to have done it as the replacement of /dev/random.

The 3 random generation behaviors we currently support are :

  - /dev/random: only returns safe random (blocks), AND depletes entropy.
    getrandom(GRND_RANDOM) does the same.
  - /dev/urandom: returns whatever (never blocks), inexhaustible
  - getrandom(0): returns safe random (blocks), inexhaustible

Historically we used to want to rely on /dev/random for SSH keys and
certificates. It's arguable that with the massive increase of crypto
usage, what used to be done only once in a system's life happens a
bit more often and using /dev/random here can sometimes become a
problem because it harms the whole system (thus why I said I think that
we could almost require CAP_something to access it). Applications
falling back to /dev/urandom obviously resulted in the massive mess
we've seen years ago, even if it apparently solved the problem for
their users. Thus getrandom(0) does make sense, but not as an
alternative to urandom but to random, since it returns randoms safe
for use for long lived keys.

Couldn't we simply change the way things work ? Make GRND_RANDOM *not*
deplate entropy, and document it as the only safe source, and make the
default call return the same as /dev/urandom ? We can then use your
timeout mechanism for the first one (which is not supposed to be called
often and would be more accepted with a moderately long delay).

Applications need to evolve as well. It's fine to use libraries to do
whatever you need for you but ultimately the lib exports a function for
a generic use case and doesn't know how to best adapt to the use case.
Typically I would expect an SSH/HTTP daemon running in a recovery
initramfs to produce unsafe randoms so that I can connect there without
having to dance around it. However the self-signed cert produced there
must not be saved, just like the SSH host key. But this means that the
application (here the ssh-keygen or openssl) also need to be taught to
purposely produce insecure keys when explicitly instructed to do so.
Otherwise we know what will happen in the long term, since history
repeats itself as long as the conditions are not changed :-/

Willy
