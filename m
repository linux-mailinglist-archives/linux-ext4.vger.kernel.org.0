Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD7AB6140
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 12:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfIRKQu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 06:16:50 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:47697 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbfIRKQu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Sep 2019 06:16:50 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8IAGGrf029569;
        Wed, 18 Sep 2019 12:16:16 +0200
Date:   Wed, 18 Sep 2019 12:16:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190918101616.GA29565@1wt.eu>
References: <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login>
 <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login>
 <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
 <CAHk-=wgOCv2eOT2M8Vw9GD_yOpsTwF364-hkeADyEu9erHgMGw@mail.gmail.com>
 <89aeae9d-0bca-2a59-5ce2-1e18f6479936@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89aeae9d-0bca-2a59-5ce2-1e18f6479936@rasmusvillemoes.dk>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 18, 2019 at 11:33:39AM +0200, Rasmus Villemoes wrote:
> On 17/09/2019 22.58, Linus Torvalds wrote:
> > Side note, and entirely unrelated to this particular problem, but
> > _because_ I was looking at the entropy init and sources of randomness
> > we have, I notice that we still don't use the ToD clock as a source.
> 
> And unrelated to the non-use of the RTC (which I agree seems weird), but
> because there's no better place in this thread: How "random" is the
> contents of RAM after boot? Sure, for virtualized environments one
> probably always gets zeroed pages from the host (otherwise the host has
> a problem...), and on PCs maybe the BIOS interferes.
>
> But for cheap embedded devices with non-ECC RAM and not a lot of
> value-add firmware between power-on and start_kernel(), would it make
> sense to read a few MB of memory outside of where the kernel was loaded
> and feed those to add_device_randomness() (of course, doing it as early
> as possible, maybe first thing in start_kernel())? Or do the reading in
> the bootloader and pass on the sha256() in the DT/rng-seed property?
> 
> A quick "kitchen-table" experiment with the board I have on my desk
> shows that there are at least some randomness to be had after a cold boot.
> 
> Maybe this has already been suggested and rejected?

We've already discussed that point a few times. The issue is that
bootloaders and/or BIOSes tend to wipe everything. Ideally we should
let the boot loader collect entropy from the DDR training phase since
it's a period where noise is observed. It's also the right moment to
collect some random contents that may lie in the RAM cells.

Similarly asynchronous clocks driving external components can be used
as well if you can measure their phase with the CPU's clock.

Regards,
Willy
