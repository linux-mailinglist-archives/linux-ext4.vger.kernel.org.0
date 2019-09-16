Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 679EEB33B3
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 05:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfIPDX7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 23:23:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41516 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbfIPDX7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 23:23:59 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8G3NR7m009538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Sep 2019 23:23:28 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3E031420811; Sun, 15 Sep 2019 23:23:27 -0400 (EDT)
Date:   Sun, 15 Sep 2019 23:23:27 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916032327.GB22035@mit.edu>
References: <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
 <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login>
 <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 10:02:18AM -0700, Linus Torvalds wrote:
> But on a PC, we can _almost_ guarantee entropy. Even with a golden
> image, we do mix in:
> 
>  - timestamp counter on every device interrupt (but "device interrupt"
> doesn't include things like the local CPU timer, so it really needs
> device activity)
> 
>  - random boot and BIOS memory (dmi tables, the EFI RNG entry, etc)
> 
>  - various device state (things like MAC addresses when registering
> network devices, USB device numbers, etc)
> 
>  - and obviously any CPU rdrand data
> 	....
> But also note the "on a PC" part.

Hopefully there is no disagreement with this.  I completely agree that
if we only care about user desktops running on PC's, getrandom(2)
should never block, and *hopefully* a big fact kernel stack dump will
cause developers to wake up and pay attention.  And even if they don't
essentially all modern systems have RDRAND, and RDRAND will save you.
We're also not using the EFI RNG yet, but we should, and once we do,
that will again help for all modern PC's.

However, there are exceptions here --- and we don't even need to leave
the X86 architecture.  If you are running in a VM, there won't be a
lot of interrutps, and some hosts may disable RDRAND (or are on a
system where RDRAND was buggy, and hence disabled), and the dmi tables
are pretty much constant and trivial for an attacker to deduce.

> But basically, you should never *ever* try to generate some long-lived
> key and then just wait for it without doing anything else. The
> "without doing anything else" is key here.
> 
> But every time we've had a blocking interface, that's exactly what
> somebody has done. Which is why I consider that long blocking thing to
> be completely unacceptable. There is no reason to believe that the
> wait will ever end, partly exactly because we don't consider timer
> interrupts to add any timer randomness. So if you are just waiting,
> nothing necessarily ever happen.

Ultimately, the question is whether blocking is unacceptable, or
compromising the user's security is unacceptable.  The former is much
more likely to cause users to whine on LKML and send complaints of
regressions to Linus.  No question about that.

But not blocking is *precisely* what lead us to weak keys in network
devices that were sold by the millions to users in their printers,
wifi routers, etc.  And with /dev/urandom, we didn't block, and we did
issue a warning messages, and it didn't stop consumer electronic
vendors from screwing up.  And then there will be another paper
published, and someone will contact security@kernel.org, and it will
be blamed on the Linux kernel, because best practice really *is* to
block until you can return cryptographic randomness, because we can
take it on *faith* that there will be some (and probably many) user
space programmers which rally don't know how to do system design,
especially secure systems design.  Many of them won't even bother to
look at system logs.

And even blocking for 15 seconds may not necessarily help much, since
consumer grade electronics won't have a serial console, and hardware
engineers might not even notice a 15 second delay.  Sure, someone who
is used to a laptop booting up in 3 seconds will be super annoyed by a
15 second delay --- but there are many contexts where a 15 second
delay is nothing.

It often takes a minute or more to start up a Cloud VM, for example,
and if users aren't checking the system logs --- and most IOT
application programmers won't be checking system logs, and 15 seconds
to boot might not even be noticed during development for some devices.
And even on a big x86 server, it can take 5+ minutes for it to boot
(between BIOS and kernel probe time), so 15 seconds won't be noticed.

Linus, I know you don't like the config approach, but the problem is
there is not going to be any "one size fits all" solution, because
Linux gets used in so many places.  We can set up defaults so that for
x86, we never block and just create a big fat warning, and cross our
fingers and hope that's enough.  But on other platforms, 15 seconds
won't be the right number, and you might actually need something
closer to two minutes before the delay will be noticed.  And on some
of these other platforms, the use of "best effort" randomness might be
***far*** more catastrophic from a security perspective than on an
x86.

This is why I really want the CONFIG option.  I'm willing to believe
that the x86 architecture will mostly be safe, so we could never ask
for the option on some set of architectures (unless CONFIG_EXPERT is
enabled).  But there will be other architectures and use cases where
"never blocking" and "return best effort randomness" is going to be
unacceptable, and lead to massive security problems, that could be
quite harmful.  So for those architectures, I'd really like to make
the CONFIG option be visible, and even default it to "block".

For the embedded use case, we want it to be blatently obvious that
there is a problem, so the developer finds it, and not the consumer.
And blocking forever really is the best way to force the embedded
programmer to notice that there is a problem, and then fix userspace,
or add a hardware RNG, etc.  And that's because for embeeded
arhictectures, blocking really is no big deal, but letting a product
escape with a massive security hole caused by "best efforts"
randomness being garbage is in my book, completely unacceptable.

Regards, 

						- Ted
