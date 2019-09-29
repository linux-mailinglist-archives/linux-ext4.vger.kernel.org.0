Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA01BC1406
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Sep 2019 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfI2JFP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Sep 2019 05:05:15 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:53304 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfI2JFP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Sep 2019 05:05:15 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 20337E80A99;
        Sun, 29 Sep 2019 11:05:13 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id BB79E160AE4; Sun, 29 Sep 2019 11:05:12 +0200 (CEST)
Date:   Sun, 29 Sep 2019 11:05:12 +0200
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
        zhangjs <zachary@baishancloud.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190929090512.GB13049@gardel-login>
References: <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login>
 <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login>
 <87zhj15qgf.fsf@x220.int.ebiederm.org>
 <84824f79-2d12-0fd5-5b32-b0360eb075ac@gmail.com>
 <CAHk-=whYhC-qXHdEypy6iC7SzPA+KvWphLXSGF+mvGCGHGjNZw@mail.gmail.com>
 <20190927135708.GD11791@gardel-login>
 <CAHk-=widBVsz+JZYnkV8xvCt+XMzkO6Gz3KZQ_gULXpMpUZfMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=widBVsz+JZYnkV8xvCt+XMzkO6Gz3KZQ_gULXpMpUZfMA@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fr, 27.09.19 08:58, Linus Torvalds (torvalds@linux-foundation.org) wrote:

> On Fri, Sep 27, 2019 at 6:57 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > Doing the random seed in the boot loader is nice for two reasons:
> >
> > 1. It runs very very early, so that the OS can come up with fully
> >    initialized entropy right from the beginning.
>
> Oh, that part I love.
>
> But I don't believe in your second case:
>
> > 2. The boot loader generally has found some disk to read the kernel from,
> >    i.e. has a place where stuff can be stored and which can be updated
> >    (most modern boot loaders can write to disk these days, and so can
> >    EFI). Thus, it can derive a new random seed from a stored seed on disk
> >    and pass it to the OS *AND* update it right away on disk ensuring that
> >    it is never reused again.
>
> No. This is absolutely no different at all from user space doing it
> early with a file.
>
> All the same "golden image" issues exist, and in general the less the
> boot loader writes to disk, the better.
>
> Plus it doesn't actually work anyway in the one situation where people
> _really_ want it - embedded devices, where the kernel image is quite
> possibly in read-only flash that needs major setup for updates.
>
> PLUS.
>
> Your "it can update it right away on disk" is just crazy talk. With
> WHAT? It has no randomness to play with, and it doesn't have time to
> do jitter entropy stuff.

So these two issues are addressed by the logic implemented in sd-boot
(systemd's boot loader) like this:

The old seed is read off the ESP seed file. We then calculate two hash
sums in counter mode from it (SHA256), one we pass to the OS as seed
to initialize the random pool from. The other we use to update the ESP
seed file with. Unless you are capable of breaking SHA256 this means
the seed passed to the OS and the new seed stored on disk are derived
from the same seed but in a way you cannot determine one if you
managed to learn the other. Moreover, on each boot you are guaranteed
to get two new seeds, each time, and you cannot derive the sums used
on previous boots from those. This means we are robust towards
potential seed reuse when turning the system forcibly off during boot.

Now, what's still missing in the above is protection against "golden
image" issues, as you correctly pointed out. To deal with that the
SHA256 sums are not just hashed from the old seed and the counter, but
also include a system specific "system token" (you may also call it
"salt") which is stored in an EFI variable, persistently, which was
created once, during system installation. This hence gives you the
behaviour your are looking for, using the NVRAM like you suggested,
but we don't need to write the EFI vars all the time, as instead we
update the seed file stored in the ESP each time, and updating the ESP
should be safer and less problematic (i.e. if everything is done right
it's a single sector write).

To make this safer, on EFI firmwares that support the RNG protocol we
also include some data derived from that in the hash, just for good
measure. To sumarize:

NEWDISKSEED = SHA256(OLDDISKSEED || SYSTEMTOKEN || EFIRNGVAL || "1")
SEEDFORLINUX = SHA256(OLDDISKSEED || SYSTEMTOKEN || EFIRNGVAL || "2")

(and no, this is not a crypto scheme I designed, but something
Dr. Bertram Poettering (my brother, a cryptographer) suggested)

> So all it can do is a really bad job at taking the previous random
> seed, doing some transformation on it, and add a little bit of
> whatever system randomness it can find. None of which is any better
> than what the kernel can do.

Well, the kernel cannot hash and rewrite the old seed file early enough,
it's that simple. It can do that only when /var becomes writable,
i.e. very late during boot, much later than when we need entropy
for. The boot loader on the hand, can hash and rewrite the old seed
file even before the kernel initializes, and that's the big benefit!

> End result: you'd need to have the kernel update whatever bootloader
> data later on, and I'm not seeing that happening. Afaik the current
> bootloader interface has no way to specify how to update it when you
> actually have better randomness.

So, you could, but don't have to update the ESP random seed file from
the OS too, every now and then, but the security of the model dos not
rely on that.

(And yes, the above doesn't help if you have a fully R/O medium, but
those tend to be embedded devices, and I am much less concerned about
those, the designers really can deal with the RNG seed issues
themselves, and maybe provide some hw to do it; it's the generic user
PCs that we should be concerned about, and for those the above should
generally work)

Lennart

--
Lennart Poettering, Berlin
