Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC9B97E4
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 21:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfITThx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 15:37:53 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49284 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfITThx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 15:37:53 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8KJbe98001976;
        Fri, 20 Sep 2019 21:37:40 +0200
Date:   Fri, 20 Sep 2019 21:37:40 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190920193740.GD1889@1wt.eu>
References: <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc>
 <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
 <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
 <20190920181216.GA1889@1wt.eu>
 <CALCETrW_mw0qOR2oqYC0+T6V65c+t+Vdxk5Jb6S+sPTqN6SXfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW_mw0qOR2oqYC0+T6V65c+t+Vdxk5Jb6S+sPTqN6SXfw@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 12:22:17PM -0700, Andy Lutomirski wrote:
> Perhaps userland could register a helper that takes over and does
> something better?

If userland sees the failure it can do whatever the developer/distro
packager thought suitable for the system facing this condition.

> But I think the kernel really should do something
> vaguely reasonable all by itself.

Definitely, that's what Linus' proposal was doing. Sleeping for some time
is what I call "vaguely reasonable".

> If nothing else, we want the ext4
> patch that provoked this whole discussion to be applied,

Oh absolutely!

> which means
> that we need to unbreak userspace somehow, and returning garbage it to
> is not a good choice.

It depends how it's used. I'd claim that we certainly use randoms for
other things (such as ASLR/hashtables) *before* using them to generate
long lived keys thus we can have a bit more time to get some more
entropy before reaching the point of producing these keys.

> Here are some possible approaches that come to mind:
> 
> int count;
> while (crng isn't inited) {
>   msleep(1);
> }
> 
> and modify add_timer_randomness() to at least credit a tiny bit to
> crng_init_cnt.

Without a timeout it's sure we'll still face some situations where
it blocks forever, which is the current problem.

> Or we do something like intentionally triggering readahead on some
> offset on the root block device.

You don't necessarily have such a device, especially when you're
in an initramfs. It's precisely where userland can be smarter. When
the caller is sfdisk for example, it does have more chances to try
to perform I/O than when it's a tiny http server starting to present
a configuration page.

> We should definitely not trigger *blocking* IO.

I think I agree.

> Also, I wonder if the real problem preventing the RNG from staring up
> is that the crng_init_cnt threshold is too high.  We have a rather
> baroque accounting system, and it seems like we can accumulate and
> credit entropy for a very long time indeed without actually
> considering ourselves done.

I have no opinion on this, lacking the skills to evaluate the situation.
What I can say for sure is that I've faced the non-booting issue quite a
number of times on headless systems, and conversely in the 2.4 era, my
front reverse-proxy by then had the same SSH key as 89 other machines on
the net. So there's surely a sweet spot to find between those two extremes.
I tend to think that waiting *a little bit* for the *first* random is
acceptable, even 10-15s, by the time the user starts to think about
pressing the reset button the system might finish to boot. Hashing some
RAM locations and the RTC when present can also help a little bit. If
at least my machine by then had combined the RTC's date and time with
the hash, chances for a key collision would have gone down to one over
many thousands.

Willy
