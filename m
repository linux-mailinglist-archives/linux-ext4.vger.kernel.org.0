Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADAF4B2D7F
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 03:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfIOBBC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 21:01:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44338 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726878AbfIOBBC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 21:01:02 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8F10bDk003842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Sep 2019 21:00:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4A917420811; Sat, 14 Sep 2019 21:00:37 -0400 (EDT)
Date:   Sat, 14 Sep 2019 21:00:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190915010037.GE19710@mit.edu>
References: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190914211126.GA4355@darwi-home-pc>
 <20190914222432.GC19710@mit.edu>
 <CAHk-=wi-y26j4yX5JtwqwXc7zKX1K8FLQGVcx49aSYuW8JwM+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi-y26j4yX5JtwqwXc7zKX1K8FLQGVcx49aSYuW8JwM+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 03:32:46PM -0700, Linus Torvalds wrote:
> > Worse, it won't even accomplish something against an obstinant
> > programmers.  Someone who is going to change their program to sleep
> > loop waiting for getrandom(2) to not return with an error can just as
> > easily check for a buffer which is zero-filled, or an unchanged
> > buffer, and then sleep loop on that.
> 
> Again,  no they can't. They'll get random data in the buffer. And
> there is no way they can tell how much entropy that random data has.

That makes me even more worried.  It's probably going to be OK for
modern x86 systems, since "best we can do" will include RDRAND
(whether or not it's trusted).  But on systems without something like
RDRAND --- e.g., ARM --- the "best we can do" could potentially be
Really Bad.  Again, look back at the Mining Your P's and Q's paper
from factorable.net.

If we don't block, and we just return "the best we can do", and some
insane userspace tries to generate a long-term private key (for SSH or
TLS) in super-early boot, I think we owe them something beyond a big
fat WARN_ON_ONCE.  We could return 0 for success, and yet "the best we
can do" could be really terrible.

> > For 5.3, can we please consider my proposal in [1]?
> >
> > [1] https://lore.kernel.org/linux-ext4/20190914162719.GA19710@mit.edu/
> 
> Honestly, to me that looks *much* worse than just saying that we need
> to stop allowing insane user mode boot programs make insane choices
> that have no basis in reality.
> 
> It may be the safest thing to do, but at that point we might as well
> just revert the ext4 change entirely. I'd rather do that, than have
> random filesystems start making random decisions based on crazy user
> space behavior.

All we're doing is omitting the plug; I disagree that it's really all
that random.  Honestly, I'd much rather just let distributions hang,
and force them to fix it that way.  That's *much* better than silently
give them "the best we can do", which might be "not really random at
all".

The reality is that there will be some platforms where we will block
for a very long time, given certain kernel configs and certain really
stupid userspace decisions --- OR, we can open up a really massive
security hole given stupid userspace decisions.  Ext4 just got unlocky
that a performance improvement patch happened to toggle one or two
configurations from "working" to "not working".   

But just saying, "oh well" and returning something which might not
really be random with a success code is SUCH A TERRIBLE IDEA, that if
you really prefer that, I'll accept the ext4 revert, even though I
don't think we should be penalizing all ext4 performance just because
of a few distros being stupid.

If the choice is between that and making some unsuspecting
distributions being potentially completely insecure, it's no contest.
I won't have that on my conscience.

						- Ted
