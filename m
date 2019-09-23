Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0783BBD4E
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2019 22:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502528AbfIWUtu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Sep 2019 16:49:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38778 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389848AbfIWUtu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Sep 2019 16:49:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C47F88062D; Mon, 23 Sep 2019 22:49:31 +0200 (CEST)
Date:   Mon, 23 Sep 2019 22:49:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: chaos generating driver was Re: Linux 5.3-rc8
Message-ID: <20190923204944.GA1107@bug>
References: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

> >     => src/random-seed/random-seed.c:
> >     /*
> >      * Let's make this whole job asynchronous, i.e. let's make
> >      * ourselves a barrier for proper initialization of the
> >      * random pool.
> >      */
...
> >      k = getrandom(buf, buf_size, GRND_NONBLOCK);
> >      if (k < 0 && errno == EAGAIN && synchronous) {
> >          log_notice("Kernel entropy pool is not initialized yet, "
> >                     "waiting until it is.");
> >
> >          k = getrandom(buf, buf_size, 0); /* retry synchronously */
> >      }
> 
> Yeah, the above is yet another example of completely broken garbage.
> 
> You can't just wait and block at boot. That is simply 100%
> unacceptable, and always has been, exactly because that may
> potentially mean waiting forever since you didn't do anything that
> actually is likely to add any entropy.

Hmm. This actually points to a solution, and I believe solution is in the
kernel. Userspace is not the best place to decide what is the best way to
generate entropy.

> As mentioned, this has already historically been a huge issue on
> embedded devices, and with disks turnign not just to NVMe but to
> actual polling nvdimm/xpoint/flash, the amount of true "entropy"
> randomness we can give at boot is very questionable.
> 
> We can (and will) continue to do a best-effort thing (including very
> much using rdread and friends), but the whole "wait for entropy"
> simply *must* stop.

And we can stop it... from kernel, and without hacks. Simply by generating some
entropy. We do not need to sit quietly while userspace waits for entropy to appear.

We can for example do some reads from the disk. (find / should be good for generating
entropy on many systems). For systems with rtc but not timestamp counter, we can
actually just increase register, then read it from interrupt...
...to get precise timings. We know system is blocked waiting for entropy, we can
do expensive things we would not "normally" do.

Yes, it would probably mean new kind of "driver" whose purpose is to generate some
kind of activity so that interrupts happen and entropy is generated... But that is
still better solution than fixing all of the userspace.

(With some proposals here, userspace _could_ do 

while (getrandom() == -EINVAL) {
    system("find / &");
    sleep(1);
}

...but I believe we really want to do it once, in kernel, and less hacky than this)

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
