Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41BB3197
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfIOTSc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 15:18:32 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45445 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfIOTSc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Sep 2019 15:18:32 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8FJIEGx023230;
        Sun, 15 Sep 2019 21:18:14 +0200
Date:   Sun, 15 Sep 2019 21:18:14 +0200
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
Message-ID: <20190915191814.GB23212@1wt.eu>
References: <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190915183240.GA23155@1wt.eu>
 <20190915183659.GA23179@1wt.eu>
 <CAHk-=wgFrRCL3WP7vyuZ-92xyqb97ADc=JNyyVCucZ1Q9oh8TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgFrRCL3WP7vyuZ-92xyqb97ADc=JNyyVCucZ1Q9oh8TA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 12:08:31PM -0700, Linus Torvalds wrote:
> My suggested patch left the /dev/random blocking behavior, because
> hopefully people *know* about the problems there.
> 
> And hopefully people understand that getrandom(GRND_RANDOM) has all
> the same issues.

I think this one doesn't cause any issue to users. It's the only
one that should be used for long-lived crypto keys in my opinion.

> If you want that behavior, you can still use GRND_RANDOM or
> /dev/random, but they are simply not acceptable for boot-time
> schenarios.

Oh no I definitely don't want this behavior at all for urandom, what
I'm saying is that as long as getrandom() will have a lower quality
of service than /dev/urandom for non-important randoms, there will be
compelling reasons to avoid it. And I think that your bounded wait
could actually reconciliate both ends of the users spectrum, those
who want excellent randoms to run tetris and those who don't care
to always play the same party on every boot because they just want
to play. And by making /dev/urandom behave like getrandom() we could
actually tell users "both are now exactly the same, you have no valid
reason anymore not to use the new API". And it forces us to remain
very reasonable in getrandom() so that we don't break old applications
that relied on urandom to be fast.

Willy
