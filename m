Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7EB40F8
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbfIPTQf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 15:16:35 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:46291 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfIPTQf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Sep 2019 15:16:35 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8GJGFgj025977;
        Mon, 16 Sep 2019 21:16:15 +0200
Date:   Mon, 16 Sep 2019 21:16:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2] random: optionally block in getrandom(2) when the
 CRNG is uninitialized
Message-ID: <20190916191615.GE24547@1wt.eu>
References: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190916180801.GB30990@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916180801.GB30990@gardel-login>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 08:08:01PM +0200, Lennart Poettering wrote:
> I mean, as I understand you are unhappy with behaviour you saw on
> systemd systems; we can certainly improve behaviour of systemd in
> userspace alone, i.e. abort the getrandom() after a while in userspace
> and log about it using typical userspace logging to the console. I am
> not sure why you want to do all that in the kernel, the kernel isn't
> great at user interaction, and really shouldn't be.

Because the syscall will have the option to return what random data
was available in this case, while if you try to fix it only from
within systemd you currently don't even get that data.

> It appears to me you subscribe too much to an idea that userspace
> people are not smart enough and couldn't implement something like
> this. Turns out we can though, and there's no need to add logic that
> appears to follow the logic of "never trust userspace"...

I personally see this very differently. If randoms were placed into a
kernel compared to other operating systems doing everything in userspace,
it's in part because it requires to collect data very widely to gather
some entropy and that no isolated userspace alone can collect as much
as the kernel. Or they each have to reimplement their own method, each
with their own bugs, instead of fixing them all at a single place. All
applications need random, there's no reason for having to force them
all to implement them in detail.

Willy
