Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1BC06C3
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2019 15:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfI0N5L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Sep 2019 09:57:11 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:51550 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0N5L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Sep 2019 09:57:11 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id D409AE80A99;
        Fri, 27 Sep 2019 15:57:08 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 88319160AE4; Fri, 27 Sep 2019 15:57:08 +0200 (CEST)
Date:   Fri, 27 Sep 2019 15:57:08 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190927135708.GD11791@gardel-login>
References: <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login>
 <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login>
 <87zhj15qgf.fsf@x220.int.ebiederm.org>
 <84824f79-2d12-0fd5-5b32-b0360eb075ac@gmail.com>
 <CAHk-=whYhC-qXHdEypy6iC7SzPA+KvWphLXSGF+mvGCGHGjNZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whYhC-qXHdEypy6iC7SzPA+KvWphLXSGF+mvGCGHGjNZw@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mi, 18.09.19 13:26, Linus Torvalds (torvalds@linux-foundation.org) wrote:

> On Wed, Sep 18, 2019 at 1:15 PM Alexander E. Patrakov
> <patrakov@gmail.com> wrote:
> >
> > No, this is not the solution, if we take seriously not only getrandom
> > hangs, but also urandom warnings. In some setups (root on LUKS is one of
> > them) they happen early in the initramfs. Therefore "restoring" entropy
> > from the previous boot by a script that runs from the main system is too
> > late. That's why it is suggested to load at least a part of the random
> > seed in the boot loader, and that has not been commonly implemented.
>
> Honestly, I think the bootloader suggestion is naive and silly too.
>
> Yes, we now support it. And no, I don't think people will trust that
> either. And I suspect for good reason: there's really very little
> reason to believe that bootloaders would be any better than any other
> part of the system.
>
> So right now some people trust bootloaders exactly _because_ there
> basically is just one or two that do this, and the people who use them
> are usually the people who wrote them or are at least closely
> associated with them. That will change, and then people will say "why
> would I trust that, when we know of bug Xyz".

Doing the random seed in the boot loader is nice for two reasons:

1. It runs very very early, so that the OS can come up with fully
   initialized entropy right from the beginning.

2. The boot loader generally has found some disk to read the kernel from,
   i.e. has a place where stuff can be stored and which can be updated
   (most modern boot loaders can write to disk these days, and so can
   EFI). Thus, it can derive a new random seed from a stored seed on disk
   and pass it to the OS *AND* update it right away on disk ensuring that
   it is never reused again. The point where the OS kernel comes to an
   equivalent point where it can write to disk is much much later,
   i.e. after the initrd, after the transition to the actual OS, ony
   after /var has been remounted writable.

So to me this is not about trust, but about "first place we can read
*AND* write a seed on disk".

i.e. the key to grok here: it's not OK to use a stored seed unless you
can at the same time update the it on disk, as only that protects you
from reusing the key if the system's startup is aborted due to power
failure or such.

> Adding an EFI variable (or other platform nonvolatile thing), and
> reading (and writing to it) purely from the kernel ends up being one
> of those things where you can then say "ok, if we trust the platform
> AT ALL, we can trust that". Since you can't reasonably do things like
> add EFI variables to your distro image by mistake.

NVRAM backing EFI vars sucks. Nothing you want to update on every
cycle. It's OK to update during OS installation, but during every
single boot? I'd rather not.

Lennart

--
Lennart Poettering, Berlin
