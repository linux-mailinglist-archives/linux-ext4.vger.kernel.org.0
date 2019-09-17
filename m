Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2302B5470
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 19:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfIQRmW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 13:42:22 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:40808 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfIQRmV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 13:42:21 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 53EA6E80FFC;
        Tue, 17 Sep 2019 19:42:20 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 06FB9160ADC; Tue, 17 Sep 2019 19:42:19 +0200 (CEST)
Date:   Tue, 17 Sep 2019 19:42:19 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917174219.GD31798@gardel-login>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login>
 <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Di, 17.09.19 09:23, Linus Torvalds (torvalds@linux-foundation.org) wrote:

> On Tue, Sep 17, 2019 at 9:08 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > Here's what I'd propose:
>
> So I think this is ok, but I have another proposal. Before I post that
> one, though, I just wanted to point out:
>
> > 1) Add GRND_INSECURE to get those users of getrandom() who do not need
> >    high quality entropy off its use (systemd has uses for this, for
> >    seeding hash tables for example), thus reducing the places where
> >    things might block.
>
> I really think that trhe logic should be the other way around.
>
> The getrandom() users that don't need high quality entropy are the
> ones that don't really think about this, and so _they_ shouldn't be
> the ones that have to explicitly state anything. To those users,
> "random is random". By definition they don't much care, and quite
> possibly they don't even know what "entropy" really means in that
> context.

So I think people nowadays prefer getrandom() over /dev/urandom
primarily because of the noisy logging the kernel does when you use
the latter on a non-initialized pool. If that'd be dropped then I am
pretty sure that the porting from /dev/urandom to getrandom() you see
in various projects (such as gdm/x11) would probably not take place.

In fact, speaking for systemd: the noisy logging in the kernel is the
primary (actually: only) reason that we prefer using RDRAND (if
available) over /dev/urandom if we need "medium quality" random
numbers, for example to seed hash tables and such. If the log message
wasn't there we wouldn't be tempted to bother with RDRAND and would
just use /dev/urandom like we used to for that.

> > 2) Add a kernel log message if a getrandom(0) client hung for 15s or
> >    more, explaining the situation briefly, but not otherwise changing
> >    behaviour.
>
> The problem is that when you have some graphical boot, you'll not even
> see the kernel messages ;(

Well, but as mentioned, there's infrastructure for this, that's why I
suggested changing systemd-random-seed.service.

We can make boot hang in "sane", discoverable way.

The reason why I think this should also be logged by the kernel since
people use netconsole and pstore and whatnot and they should see this
there. If systemd with its infrastructure brings this to screen via
plymouth then this wouldn't help people who debug much more low-level.

(I mean, there have been requests to add a logic to systemd that
refuses booting — or delays it — if the system has a battery and it is
nearly empty. I am pretty sure adding a cleanm discoverable concept of
"uh, i can't boot for a good reason which is this" wouldn't be the
worst of ideas)

Lennart

--
Lennart Poettering, Berlin
