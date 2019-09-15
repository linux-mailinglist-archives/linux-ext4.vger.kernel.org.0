Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA61B315D
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfIOSdH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 14:33:07 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45394 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfIOSdH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Sep 2019 14:33:07 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8FIWecx023178;
        Sun, 15 Sep 2019 20:32:40 +0200
Date:   Sun, 15 Sep 2019 20:32:40 +0200
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
Message-ID: <20190915183240.GA23155@1wt.eu>
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
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 10:32:15AM -0700, Linus Torvalds wrote:
>  * We will block for at most 15 seconds at a time, and if called
>  * sequentially will decrease the blocking amount so that we'll
>  * block for at most 30s total - and if people continue to ask
>  * for blocking, at that point we'll just return whatever random
>  * state we have acquired.

I think that the exponential decay will either not be used or
be totally used, so in practice you'll always end up with 0 or
30s depending on the entropy situation, because I really do not
see any valid reason for entropy to suddenly start to appear
after 15s if it didn't prior to this. As such I do think that
a single timeout should be enough.

In addition, since you're leaving the door open to bikeshed around
the timeout valeue, I'd say that while 30s is usually not huge in a
desktop system's life, it actually is a lot in network environments
when it delays a switchover. It can cause other timeouts to occur
and leave quite a long embarrassing black out. I'd guess that a max
total wait time of 2-3s should be OK though since application timeouts
rarely are lower due to TCP generally starting to retransmit at 3s.
And even in 3s we're supposed to see quite some interrupts or it's
unlikely that much more will happen between 3 and 30s.

If the setting had to be made user-changeable then it could make
sense to let it be overridden on the kernel's command line though
I don't think that it should be necessary with a low enough value.

Thanks,
Willy
