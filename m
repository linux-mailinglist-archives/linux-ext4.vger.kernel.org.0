Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B32B2FB4
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 13:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfIOLRv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 07:17:51 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45215 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfIOLRv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Sep 2019 07:17:51 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8FBHUCn022005;
        Sun, 15 Sep 2019 13:17:30 +0200
Date:   Sun, 15 Sep 2019 13:17:30 +0200
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
Message-ID: <20190915111730.GA21993@1wt.eu>
References: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <20190915081747.GA1058@darwi-home-pc>
 <20190915085907.GC29771@gardel-login>
 <20190915093057.GF20811@1wt.eu>
 <20190915100201.GA2663@darwi-home-pc>
 <20190915104027.GG20811@1wt.eu>
 <20190915105539.GA1082@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915105539.GA1082@darwi-home-pc>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 12:55:39PM +0200, Ahmed S. Darwish wrote:
> On Sun, Sep 15, 2019 at 12:40:27PM +0200, Willy Tarreau wrote:
> > On Sun, Sep 15, 2019 at 12:02:01PM +0200, Ahmed S. Darwish wrote:
> > > On Sun, Sep 15, 2019 at 11:30:57AM +0200, Willy Tarreau wrote:
> > > > On Sun, Sep 15, 2019 at 10:59:07AM +0200, Lennart Poettering wrote:
> [...]
> > > > > If Linux lets all that stuff run with awful entropy then
> > > > > you pretend things where secure while they actually aren't. It's much
> > > > > better to fail loudly in that case, I am sure.
> > > > 
> > > > This is precisely what this change permits : fail instead of block
> > > > by default, and let applications decide based on the use case.
> > > >
> > > 
> > > Unfortunately, not exactly.
> > > 
> > > Linus didn't want getrandom to return an error code / "to fail" in
> > > that case, but to silently return CRNG-uninitialized /dev/urandom
> > > data, to avoid user-space even working around the error code through
> > > busy-loops.
> > 
> > But with this EINVAL you have the information that it only filled
> > the buffer with whatever it could, right ? At least that was the
> > last point I manage to catch in the discussion. Otherwise if it's
> > totally silent, I fear that it will reintroduce the problem in a
> > different form (i.e. libc will say "our randoms are not reliable
> > anymore, let us work around this and produce blocking, solid randoms
> > again to help all our users").
> >
> 
> V1 of the patch I posted did indeed return -EINVAL. Linus then
> suggested that this might make still some user-space act smart and
> just busy-loop around that, basically blocking the boot again:
> 
>     https://lkml.kernel.org/r/CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com
>     https://lkml.kernel.org/r/CAHk-=whSbo=dBiqozLoa6TFmMgbeB8d9krXXvXBKtpRWkG0rMQ@mail.gmail.com
> 
> So it was then requested to actually return what /dev/urandom would
> return, so that user-space has no way whatsoever in knowing if
> getrandom has failed. Then, it's the job of system integratos / BSP
> builders to fix the inspect the big fat WARN on the kernel and fix
> that.

Then I was indeed a bit confused in the middle of the discussion as
I didn't understand exactly this, thanks for the clarifying :-)

But does it still block when called with GRND_RANDOM ? If so I guess
I'm fine as it translates exactly the previous behavior of random vs
urandom, and that GRND_NONBLOCK allows the application to fall back
to reliable sources if needed (typically human interactions).

Thanks,
Willy
