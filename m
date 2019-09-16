Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D6B3F90
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 19:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfIPRW0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 13:22:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48560 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727593AbfIPRW0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 13:22:26 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8GHLHLs008743
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 13:21:18 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 87E6E420811; Mon, 16 Sep 2019 13:21:17 -0400 (EDT)
Date:   Mon, 16 Sep 2019 13:21:17 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916172117.GB15263@mit.edu>
References: <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
 <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
 <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu>
 <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu>
 <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:
> So the semantics that getrandom() should have had are:
> 
>  getrandom(0) - just give me reasonable random numbers for any of a
> million non-strict-long-term-security use (ie the old urandom)
> 
>     - the nonblocking flag makes no sense here and would be a no-op

That change is what I consider highly problematic.  There are a *huge*
number of applications which use cryptography which assumes that
getrandom(0) means, "I'm guaranteed to get something safe
cryptographic use".  Changing his now would expose a very large number
of applications to be insecure.  Part of the problem here is that
there are many different actors.  There is the application or
cryptographic library developer, who may want to be sure they have
cryptographically secure random numbers.  They are the ones who will
select getrandom(0).

Then you have the distribution or consumer-grade electronics
developers who may choose to run them too early in some init script or
systemd unit files.  And some of these people may do something stupid,
like run things too early, or omit the a hardware random number
generator in their design, even though it's for a security critical
purpose (say, a digital wallet for bitcoin).  Because some of these
people might do something stupid, one argument (not mine) is that we
must therefore not let getrandom() block.  But doing this penalizes
the security of all the users of the application, not just the stupid
ones.

>  getrandom(GRND_RANDOM) - get me actual _secure_ random numbers with
> blocking until entropy pool fills (but not the completely invalid
> entropy decrease accounting)
> 
>     - the nonblocking flag is useful for bootup and for "I will
> actually try to generate entropy".
> 
> and both of those are very very sensible actions. That would actually
> have _fixed_ the problems we had with /dev/[u]random, both from a
> performance standpoint and for a filesystem access standpoint.
> 
> But that is sadly not what we have right now.
> 
> And I suspect we can't fix it, since people have grown to depend on
> the old behavior, and already know to avoid GRND_RANDOM because it's
> useless with old kernels even if we fixed it with new ones.

I don't think we can fix it, because it's the changing of
getrandom(0)'s behavior which is the problem, not GRND_RANDOM.  People
*expect* getrandom(0) to always return secure results.  I don't think
we can make it sometimes return not-necessarily secure results
depending on when the systems integrator or distribution decides to
run the application, and depending on the hardware platform (yes,
traditional x86 systems are probably fine, and fortunately x86
embedded CPU are too expensive and have lousy power management, so no
one really uses x86 for embedded yet, despite Intel's best efforts).
That would just be a purely irresponsible thing to do, IMO.

> Does anybody really seriously debate the above? Ted? Are you seriously
> trying to claim that the existing GRND_RANDOM has any sensible use?
> Are you seriously trying to claim that the fact that we don't have a
> sane urandom source is a "feature"?

There are people who can debate that GRND_RANDOM has any sensible use
cases.  GPG uses /dev/random, and that was a fully informed choice.
I'm not convinced, because I think that at least for now the CRNG is
perfectly fine for 99.999% of the use cases.  Yes, in a post-quantum
cryptography world, the CRNG might be screwed --- but so will most of
the other cryptographic algorithms in the kernel.  So if anyone ever
gets post-quantum cryptoanalytic attacks working, the use of the CRNG
is going to be least of our problems.

As I mentioned to you in Lisbon, I've been going back and forth about
whether or not to rip out the entire /dev/random infrastructure,
mainly for code maintainability reasons.  The only reason why I've
been holding back is because there are (very few) non-insane people
who do want to use it.  There are also a much larger of rational
people who use it because they want some insane PCI compliance labs to
go away.  What I suspect most of them are actually doing in practice
is they use /dev/random, but they also use a hardware random number
generator so /dev/random never actually blocks in practice.  The use
of /dev/random is enough to make the PCI compliance lab go away, and
the hardware random number generator (or virtio-rng on a VM) makes
/dev/random useable.

But I don't think we can reuse GRND_RANDOM for that reason.

We could create a new flag, GRND_INSECURE, which never blocks.  And
that that allows us to solve the problem for silly applications that
are using getrandom(2) for non-cryptographic use cases.  Use cases
might include Python dictionary seeds, gdm for MIT Magic Cookie, UUID
generation where best efforts probably is good enough, etc.  The
answer today is they should just use /dev/urandom, since that exists
today, and we have to support it for backwards compatibility anyway.
It sounds like gdm recently switched to getrandom(2), and I suspect
that it's going to get caught on some hardware configs anyway, even
without the ext4 optimization patch.  So I suspect gdm will switch
back to /dev/urandom, and this particular pain point will probably go
away.

						- Ted
