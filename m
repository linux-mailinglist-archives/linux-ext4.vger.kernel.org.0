Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06036B3192
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 21:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfIOTNQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 15:13:16 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45428 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfIOTNQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Sep 2019 15:13:16 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8FJCwW5023224;
        Sun, 15 Sep 2019 21:12:58 +0200
Date:   Sun, 15 Sep 2019 21:12:58 +0200
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
Message-ID: <20190915191258.GA23212@1wt.eu>
References: <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190915183240.GA23155@1wt.eu>
 <CAHk-=wi0tSUuxqaCDMtwqdVbwvTXw2ZH2k1URHz069RTznEfVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi0tSUuxqaCDMtwqdVbwvTXw2ZH2k1URHz069RTznEfVw@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 11:59:41AM -0700, Linus Torvalds wrote:
> > In addition, since you're leaving the door open to bikeshed around
> > the timeout valeue, I'd say that while 30s is usually not huge in a
> > desktop system's life, it actually is a lot in network environments
> > when it delays a switchover.
> 
> Oh, absolutely.
> 
> But in that situation you have a MIS person on call, and somebody who
> can fix it.
> 
> It's not like switchovers happen in a vacuum. What we should care
> about is that updating a kernel _works_. No regressions. But if you
> have some five-nines setup with switchover, you'd better have some
> competent MIS people there too. You don't just switch kernels without
> testing ;)

I mean maybe I didn't use the right term, but typically in networked
environments you'll have watchdogs on sensitive devices (e.g. the
default gateways and load balancers), which will trigger an instant
reboot of the system if something really bad happens. It can range
from a dirty oops, FS remounted R/O, pure freeze, OOM, missing
process, panic etc. And here the reset which used to take roughly
10s to get the whole services back up for operations suddenly takes
40s. My point is that I won't have issues explaining users that 10s
or 13s is the same when they rely on five nices, but trying to argue
that 40s is identical to 10s will be a hard position to stand by.

And actually there are other dirty cases. Such systems often work
in active-backup or active-active modes. One typical issue is that
the primary system reboots, the second takes over within one second,
and once the primary system is back *apparently* operating, some
processes which appear to be present and which possibly have already
bound their listening ports are waiting for 30s in getrandom() while
the monitoring systems around see them as ready, thus the primary
machine goes back to its role and cannot reliably run the service
for the first 30 seconds, which roughly multiplies the downtime by
30. That's why I'd like to make it possible to lower it this value
(either definitely or by cmdline, as I think it can be fine for
all those who care about down time).

Willy
