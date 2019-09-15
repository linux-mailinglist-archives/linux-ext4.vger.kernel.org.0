Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBDAB2F97
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 12:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfIOKkv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 06:40:51 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45192 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfIOKkv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Sep 2019 06:40:51 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8FAeRui021844;
        Sun, 15 Sep 2019 12:40:27 +0200
Date:   Sun, 15 Sep 2019 12:40:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v3] random: getrandom(2): optionally block when CRNG
 is uninitialized
Message-ID: <20190915104027.GG20811@1wt.eu>
References: <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <20190915081747.GA1058@darwi-home-pc>
 <20190915085907.GC29771@gardel-login>
 <20190915093057.GF20811@1wt.eu>
 <20190915100201.GA2663@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915100201.GA2663@darwi-home-pc>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 12:02:01PM +0200, Ahmed S. Darwish wrote:
> On Sun, Sep 15, 2019 at 11:30:57AM +0200, Willy Tarreau wrote:
> > On Sun, Sep 15, 2019 at 10:59:07AM +0200, Lennart Poettering wrote:
> > > We live in a world where people run HTTPS, SSH, and all that stuff in
> > > the initrd already. It's where SSH host keys are generated, and plenty
> > > session keys.
> > 
> > It is exactly the type of crap that create this situation : making
> > people developing such scripts believe that any random source was OK
> > to generate these, and as such forcing urandom to produce crypto-solid
> > randoms!
> 
> Willy, let's tone it down please... the thread is already getting a
> bit toxic.

I don't see what's wrong in my tone above, I'm sorry if it can be
perceived as such. My point was that things such as creating lifetime
keys while there's no entropy is the wrong thing to do and what
progressively led to this situation.

> > > If Linux lets all that stuff run with awful entropy then
> > > you pretend things where secure while they actually aren't. It's much
> > > better to fail loudly in that case, I am sure.
> > 
> > This is precisely what this change permits : fail instead of block
> > by default, and let applications decide based on the use case.
> >
> 
> Unfortunately, not exactly.
> 
> Linus didn't want getrandom to return an error code / "to fail" in
> that case, but to silently return CRNG-uninitialized /dev/urandom
> data, to avoid user-space even working around the error code through
> busy-loops.

But with this EINVAL you have the information that it only filled
the buffer with whatever it could, right ? At least that was the
last point I manage to catch in the discussion. Otherwise if it's
totally silent, I fear that it will reintroduce the problem in a
different form (i.e. libc will say "our randoms are not reliable
anymore, let us work around this and produce blocking, solid randoms
again to help all our users").

> I understand the rationale behind that, of course, and this is what
> I've done so far in the V3 RFC.
> 
> Nonetheless, this _will_, for example, make systemd-random-seed(8)
> save week seeds under /var/lib/systemd/random-seed, since the kernel
> didn't inform it about such weakness at all..

Then I am confused because I understood that the goal was to return
EINVAL or anything equivalent in which case the userspace knows what
it has to deal with :-/

Regards,
Willy
