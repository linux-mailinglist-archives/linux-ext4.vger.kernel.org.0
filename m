Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61A12B2D3B
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfINWZA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 18:25:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39962 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727584AbfINWY7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 18:24:59 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8EMOWFO000980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Sep 2019 18:24:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 843CB42049E; Sat, 14 Sep 2019 18:24:32 -0400 (EDT)
Date:   Sat, 14 Sep 2019 18:24:32 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190914222432.GC19710@mit.edu>
References: <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190914211126.GA4355@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914211126.GA4355@darwi-home-pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 11:11:26PM +0200, Ahmed S. Darwish wrote:
> > > I've sent an RFC patch at [1].
> > >
> > > [1] https://lkml.kernel.org/r/20190914122500.GA1425@darwi-home-pc
> > 
> > Looks reasonable to me. Except I'd just make it simpler and make it a
> > big WARN_ON_ONCE(), which is a lot harder to miss than pr_notice().
> > Make it clear that it is a *bug* if user space thinks it should wait
> > at boot time.

So I'd really rather not make a change as fundamental as this so close
to 5.3 being released.  This sort of thing is subtle since essentially
what we're trying to do is to work around broken userspace, and worse,
in many cases, obstinent, determined userspace application progammers.
We've told them to avoid trying to generate cryptographically secure
random numbers for *years*.  And they haven't listened.

This is also a fairly major functional change which is likely to be
very visible to userspace applications, and so it is likely to cause
*some* kind of breakage.  So if/when this breaks applications, are we
going to then have to revert it?

> > Also, we might even want to just fill the buffer and return 0 at that
> > point, to make sure that even more broken user space doesn't then try
> > to sleep manually and turn it into a "I'll wait myself" loop.

Ugh.  This makes getrandom(2) unreliable for application programers,
in that it returns success, but with the buffer filled with something
which is definitely not random.  Please, let's not.

Worse, it won't even accomplish something against an obstinant
programmers.  Someone who is going to change their program to sleep
loop waiting for getrandom(2) to not return with an error can just as
easily check for a buffer which is zero-filled, or an unchanged
buffer, and then sleep loop on that.  Again, remember we're trying to
work around malicious human beings --- except instead trying to fight
malicious attackers, we're trying to fight malicious userspace
programmers.  This is not a fight we can win.  We can't make
getrandom(2) idiot-proof, because idiots are too d*mned ingenious :-)

For 5.3, can we please consider my proposal in [1]?

[1] https://lore.kernel.org/linux-ext4/20190914162719.GA19710@mit.edu/

We can try to discuss different ways of working around broken/stupid
userspace, but let's wait until after the LTS release, and ultimately,
I still think we need to just try to get more randomness from hardware
whichever way we can.  Pretty much all x86 laptop/desktop have TPM's.
So let's use that, in combination with RDRAND, and UEFI provided
randomness, etc., etc.,

And if we want to put in a big WARN_ON_ONCE, sure.  But we've tried
not blocking before, and that way didn't end well[2], with almost 10%
of all publically accessible SSH keys across the entire internet being
shown to be week by an academic researcher.  (This ruined my July 4th
holidays in 2012 when I was working on patches to fix this on very
short notice.)  So let's *please* not be hasty with changes here.
We're dealing with a complex systems that includes some very
obstinent/strong personalities, including one which rhymes with
Loettering....

[2] https://factorable.net

						- Ted

