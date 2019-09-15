Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE3B2EDB
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 08:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfIOGx7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 02:53:59 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45069 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfIOGx7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Sep 2019 02:53:59 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8F6rdfG021602;
        Sun, 15 Sep 2019 08:53:39 +0200
Date:   Sun, 15 Sep 2019 08:53:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190915065338.GB20811@1wt.eu>
References: <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190914211126.GA4355@darwi-home-pc>
 <20190914222432.GC19710@mit.edu>
 <CAHk-=wi-y26j4yX5JtwqwXc7zKX1K8FLQGVcx49aSYuW8JwM+w@mail.gmail.com>
 <20190915010037.GE19710@mit.edu>
 <CAHk-=wjGTV0e_P73V0B3cPVrfeoSZcV6CjQMgj-+yL-s38DKaw@mail.gmail.com>
 <20190915020521.GF19710@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915020521.GF19710@mit.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 10:05:21PM -0400, Theodore Y. Ts'o wrote:
> You basically want to turn getrandom into /dev/urandom.  And that's
> how we got into the mess where 10% of the publically accessible ssh
> keys could be guessed.

Not exactly. This was an *API* issue that created this situation. The
fact that you had a single random() call in the libc, either mapped
to /dev/urandom or to /dev/random. By then many of us were used to rely
on one or the other and finding systems where /dev/random was a symlink
to /dev/urandom to avoid blocking was extremely common. In fact it was
caused by the exact same situation: we try to enforce good random for
everyone, it cannot work all the time and breaks programs which do not
need such randoms, so the user breaks the trust on randomness by
configuring the system so that randoms work all the time for the most
common programs. And that's how you end up with SSH trusting a broken
random generator without knowing it was misconfigured.

Your getrandom() API does have the ability to fix this. In my opinion
the best way to proceed is to consider that all those who don't care
about randomness quality never block and that those who care can be
sure they will either get good randoms or will know about it. Ideally
calling getrandom() without any flag should be equivalent to what you
have with /dev/urandom and be good enough to put a UUID on a file
system. And calling it with "SECURE" or something like this will be
the indication that it will not betray you and will only return good
randoms (which is what GRND_RANDOM does in my opinion).

The huge difference between getrandom() and /dev/*random here is that
each application can decide what type of random to use without relying
on what system-wide breakage was applied just for the sake of fixing
another simple application. This could even help OpenSSL use two different
calls for RAND_bytes() and RAND_pseudo_bytes(), instead of using the
same call and blocking.

Last but not least, I think we need to educate developers regarding
random number consumption, asking "if you could produce only 16 bytes
of random in your whole system's lifetime, where would you use them?".
Entropy is extremely precious and yet the most poorly used resource. I
almost wouldn't mind seeing GRND_RANDOM requiring a special capability
since it does have a system-wide impact!

Regards,
Willy
