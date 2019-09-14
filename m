Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A59AB2C3C
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfINQam (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 12:30:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39668 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfINQam (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 12:30:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id j16so29932541ljg.6
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QtC/f2hJx2ppzGwikyhiUUGfw6v6V8CYE/OQaTbY7U=;
        b=XOEL1ROFEhWIlOr/kpF+Xmv1cOHfZvVJqWci/babAShogjn0G0G2KAwGvxWlSSiYT1
         EcyJi67/ISiMlt/SeSt8nJbkhD6pVZnMSqd65N/zAAXMs0EW9BPxJrCJ3gx/zz55metR
         hCSidt7nSarlIY/sOgjiRVEIldlOlPQvKoVrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QtC/f2hJx2ppzGwikyhiUUGfw6v6V8CYE/OQaTbY7U=;
        b=h8SnHWzz3KzdCdHZWmEhovcF4hdrpVBwbbkXS2rdeswaNu/E+3f2cjgaCxPCKq0sEv
         fqi1iuYh9G4Tz9iE/gtVaEPhqsBstqOS9GjWuBijdEzy//5sEz+akOQajrIFKsYP4NG3
         JplaD9cNW0XBnwA5vGU6MqeinfOlHv9mAe7pmEFeqCVXzWW00H/7fZuYygwy9khfoskW
         XH6+y+5LFnYh6QbV/uZeZOtVG1pwXmd+Yv1CCSbHQHXZfj0Xivm+R8fHS/7z7T49Nof9
         KiOsmnJOdZ5QlSm1BnhFPFMAD9/wNur+jXVkaADWUz+LwG2IXYTZLZvwsC9PKyb2JEKw
         LZGQ==
X-Gm-Message-State: APjAAAWziDrXmem5RKx9zhmXx/CXmdWTxMToWhyDKt24ZRxSRGU72cPk
        3uVHQVAs9XIgUNHYDrYvUtoiZw25OWQ=
X-Google-Smtp-Source: APXvYqx9i5aTWA7qTVwUnUVPaYdEoLp+nCdLcD8Nc2yYDuhmP8WBvQmcxIpmprceXUAkZPy+zK3usA==
X-Received: by 2002:a2e:934f:: with SMTP id m15mr7531974ljh.101.1568478639450;
        Sat, 14 Sep 2019 09:30:39 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id h25sm9195563lfj.81.2019.09.14.09.30.37
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 09:30:39 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h2so23396718ljk.1
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 09:30:37 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr363387lji.52.1568478635956;
 Sat, 14 Sep 2019 09:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
In-Reply-To: <20190914150206.GA2270@darwi-home-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 09:30:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
Message-ID: <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 8:02 AM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> On Thu, Sep 12, 2019 at 12:34:45PM +0100, Linus Torvalds wrote:
> >
> > An alternative might be to make getrandom() just return an error
> > instead of waiting. Sure, fill the buffer with "as random as we can"
> > stuff, but then return -EINVAL because you called us too early.
>
> ACK, that's probably _the_ most sensible approach. Only caveat is
> the slight change in user-space API semantics though...
>
> For example, this breaks the just released systemd-random-seed(8)
> as it _explicitly_ requests blocking behvior from getrandom() here:
>

Actually, I would argue that the "don't ever block, instead fill
buffer and return error instead" fixes this broken case.

>     => src/random-seed/random-seed.c:
>     /*
>      * Let's make this whole job asynchronous, i.e. let's make
>      * ourselves a barrier for proper initialization of the
>      * random pool.
>      */
>      k = getrandom(buf, buf_size, GRND_NONBLOCK);
>      if (k < 0 && errno == EAGAIN && synchronous) {
>          log_notice("Kernel entropy pool is not initialized yet, "
>                     "waiting until it is.");
>
>          k = getrandom(buf, buf_size, 0); /* retry synchronously */
>      }

Yeah, the above is yet another example of completely broken garbage.

You can't just wait and block at boot. That is simply 100%
unacceptable, and always has been, exactly because that may
potentially mean waiting forever since you didn't do anything that
actually is likely to add any entropy.

>      if (k < 0) {
>          log_debug_errno(errno, "Failed to read random data with "
>                          "getrandom(), falling back to "
>                          "/dev/urandom: %m");

At least it gets a log message.

So I think the right thing to do is to just make getrandom() return
-EINVAL, and refuse to block.

As mentioned, this has already historically been a huge issue on
embedded devices, and with disks turnign not just to NVMe but to
actual polling nvdimm/xpoint/flash, the amount of true "entropy"
randomness we can give at boot is very questionable.

We can (and will) continue to do a best-effort thing (including very
much using rdread and friends), but the whole "wait for entropy"
simply *must* stop.

> I've sent an RFC patch at [1].
>
> [1] https://lkml.kernel.org/r/20190914122500.GA1425@darwi-home-pc

Looks reasonable to me. Except I'd just make it simpler and make it a
big WARN_ON_ONCE(), which is a lot harder to miss than pr_notice().
Make it clear that it is a *bug* if user space thinks it should wait
at boot time.

Also, we might even want to just fill the buffer and return 0 at that
point, to make sure that even more broken user space doesn't then try
to sleep manually and turn it into a "I'll wait myself" loop.

                 Linus
