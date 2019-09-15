Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73868B2F41
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfIOIsF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 04:48:05 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:38372 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfIOIsF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 04:48:05 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 31C75E81176;
        Sun, 15 Sep 2019 10:48:03 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id D171B160ADC; Sun, 15 Sep 2019 10:48:02 +0200 (CEST)
Date:   Sun, 15 Sep 2019 10:48:02 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190915084802.GB29771@gardel-login>
References: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
 <20190915072705.GA12869@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190915072705.GA12869@darwi-home-pc>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On So, 15.09.19 09:27, Ahmed S. Darwish (darwish.07@gmail.com) wrote:

> On Sun, Sep 15, 2019 at 08:51:42AM +0200, Lennart Poettering wrote:
> > On Sa, 14.09.19 09:30, Linus Torvalds (torvalds@linux-foundation.org) wrote:
> [...]
> >
> > And please don't break /dev/urandom again. The above code is the ony
> > way I see how we can make /dev/urandom-derived swap encryption safe,
> > and the only way I can see how we can sanely write a valid random seed
> > to disk after boot.
> >
>
> Any hope in making systemd-random-seed(8) credit that "random seed
> from previous boot" file, through RNDADDENTROPY, *by default*?

No. For two reasons:

a) It's way too late. We shouldn't credit entropy from the disk seed
   if we cannot update the disk seed with a new one at the same time,
   otherwise we might end up crediting the same seed twice on
   subsequent reboots (think: user hard powers off a system after we
   credited but before we updated), in which case there would not be a
   point in doing that at all. Hence, we have to wait until /var is
   writable, but that's relatively late during boot. Long afer the
   initrd ran, long after iscsi and what not ran. Long after the
   network stack is up and so on. In a time where people load root
   images from the initrd via HTTPS thats's generally too late to be
   useful.

b) Golden images are a problem. There are probably more systems
   running off golden images in the wild, than those not running off
   them. This means: a random seed on disk is only safe to credit if
   it gets purged when the image is distributed to the systems it's
   supposed to be used on, because otherwise these systems will all
   come up with the very same seed, which makes it useless. So, by
   requesting people to explicitly acknowledge that they are aware of
   this problem (and either don't use golden images, or safely wipe
   the seed off the image before shipping it), by setting the env var,
   we protect ourselves from this.

Last time I looked at it most popular distro's live images didn't wipe
the random seed properly before distributing it to users...

This is all documented btw:

https://systemd.io/RANDOM_SEEDS#systemds-support-for-filling-the-kernel-entropy-pool

See point #2.

> I know that by v243, just released 12 days ago, this can be optionally
> done through SYSTEMD_RANDOM_SEED_CREDIT=1. I wonder though if it can
> ever be done by default, just like what the BSDs does... This would
> solve a big part of the current problem.

I think the best approach would be to do this in the boot loader. In
fact systemd does this in its own boot loader (sd-boot): it reads a
seed off the ESP, updates it (via a SHA256 hashed from the old one)
and passes that to the OS. PID 1 very early on then credits this to
the kernel's pool (ideally the kernel would just do this on its own
btw). The trick we employ to make this generally safe is that we
persistently store a "system token" as EFI var too, and include it in
the SHA sum. The "system token" is a per-system random blob. It is
created the first time it's needed and a good random source exists,
and then stays on the system, for all future live images to use. This
makes sure that even if sloppily put together live images are used
(which do not reset any random seed) every system will use a different
series of RNG seeds.

This then solves both problems: the golden image problem, and the
early-on problem. But of course only on ESP. Other systems should be
able to provide similar mechanisms though, it's not rocket science.

This is also documented here:

https://systemd.io/RANDOM_SEEDS#systemds-support-for-filling-the-kernel-entropy-pool

See point #3...

Ideally other boot loaders (grub, …) would support the same scheme,
but I am not sure the problem set is known to them.

Lennart

--
Lennart Poettering, Berlin
