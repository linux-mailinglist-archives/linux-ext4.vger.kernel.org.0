Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1812FB054B
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Sep 2019 23:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfIKVly (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 17:41:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44931 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfIKVly (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Sep 2019 17:41:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id k6so14050357wrn.11;
        Wed, 11 Sep 2019 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wUQ0KtwI4JvmBE2NmHQlnqS911wm8Dp4miyti6AoRUo=;
        b=OcBl4ORbkMLxWZZZhAU68oS4rGZ0QlvvAX4lfklsyeVE8snDaUViMQsXeSG7XP1/vC
         cMhXlWWPhD7E3h/nR9utdchmtUNmkmm4+aNlyUZDRnk9sR9p++o8C7HTXvNXHRS85zh5
         GoNfii/IDYhgxrLi0RWHdt38OP0fRjcPQ6xdC0DZk7R/rGdeH0wMjAN29sWK2dyIYtu9
         a0Z1yPjVo+ppKZ5UMsfSmEGB62dRCA+OiYIWkNjAa5Ce2+GsWigDeoXzwW1CM6j4BCT+
         jRc8hIOwMJZu0ykUqCaa8p2womulHPFhZvRy4HtXC8DBU63IYHLx6q49L7u2IhLtU7eq
         VhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUQ0KtwI4JvmBE2NmHQlnqS911wm8Dp4miyti6AoRUo=;
        b=jbnmCuui6h4X6tKO2F8R2M5EppKOgtB/JE8kw8aFp+RR4/0nXcn1iec6Z7su7xNuB7
         j1kyFP4mijFdgdWBp8Tecg57rwP0KwR4wGfMu+5SUpUyihnxO/CcG+IvALuGfqmPq8tG
         gM8nozHliqoIRKIVHqwJF46wLmUTj35WdPYh+QleThXJiQLIXxzCUIezIov9/l1eWeAT
         /nnqS4eeY2XkvhKbeQU47lVABqM8x8k7ch27h6ZnSuJ8AAGK9qRuIL0a7XlvY33KriPV
         Xc1hpSxLmZHdJ7LyxuPY872ctQs0as4AQ7tzIRlUopoDI1Q3v8qe7lq4UW1SHRcQ89kH
         2gaA==
X-Gm-Message-State: APjAAAV99YCQ0w1eoFlWUl3yFmhc933wyQu3HMvZ0vDLT5xoeYZ8BJ1V
        1jwA8lmtZQnTI9/Ma+bTKaY=
X-Google-Smtp-Source: APXvYqwwcqRAU4uZN+OylUfTPf1i2wrI1PoXQG05Mx/ueeI4i/mR7ztwxo7ox8fUbclXC42yTd9Fcg==
X-Received: by 2002:adf:e48a:: with SMTP id i10mr32193682wrm.311.1568238111873;
        Wed, 11 Sep 2019 14:41:51 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D14CBD4495B592C99C920.dip0.t-ipconnect.de. [2003:d0:6f2d:14cb:d449:5b59:2c99:c920])
        by smtp.gmail.com with ESMTPSA id t14sm11246789wrs.6.2019.09.11.14.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 14:41:50 -0700 (PDT)
Date:   Wed, 11 Sep 2019 23:41:44 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190911214144.GA1840@darwi-home-pc>
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
 <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 11, 2019 at 05:45:38PM +0100, Linus Torvalds wrote:
> On Wed, Sep 11, 2019 at 5:07 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > >
> > > Ted, comments? I'd hate to revert the ext4 thing just because it
> > > happens to expose a bad thing in user space.
> >
> > Unfortuantely, I very much doubt this is going to work.  That's
> > because the add_disk_randomness() path is only used for legacy
> > /dev/random [...]
> >
> > Also, because by default, the vast majority of disks have
> > /sys/block/XXX/queue/add_random set to zero by default.
> 
> Gaah. I was looking at the input randomness, since I thought that was
> where the added randomness that Ahmed got things to work with came
> from.
> 
> And that then made me just look at the legacy disk randomness (for the
> obvious disk IO reasons) and I didn't look further.
>

Yup, I confirm that the quick patch kept the situation as-is. I was
going to debug why, but now we know the answer..

> > So the the way we get entropy these days for initializing the CRNG is
> > via the add_interrupt_randomness() path, where do something really
> > fast, and we assume that we get enough uncertainity from 8 interrupts
> > to give us one bit of entropy (64 interrupts to give us a byte of
> > entropy), and that we need 512 bits of entropy to consider the CRNG
> > fully initialized.  (Yeah, there's a lot of conservatism in those
> > estimates, and so what we could do is decide to say, cut down the
> > number of bits needed to initialize the CRNG to be 256 bits, since
> > that's the size of the CHACHA20 cipher.)
> 
> So that's 4k interrupts if I counted right, and yeah, maybe Ahmed was
> just close enough before, and the merging of the inode table IO then
> took him below that limit.
>
> > Ultimately, though, we need to find *some* way to fix userspace's
> > assumptions that they can always get high quality entropy in early
> > boot, or we need to get over people's distrust of Intel and RDRAND.
>
> Well, even on a PC, sometimes rdrand just isn't there. AMD has screwed
> it up a few times, and older Intel chips just don't have it.
> 
> So I'd be inclined to either lower the limit regardless -

ACK :)

> and perhaps make the "user space asked for randomness much too
> early" be a big *warning* instead of being a basically fatal hung
> machine?

Hmmm, regarding "randomness request much too early", how much is time
really a factor here?

I tested leaving the machine even for 15+ minutes, and it still didn't
continue booting: the boot is practically blocked forever...

Or is the thoery that hopefully once the machine is un-stuck, more
sources of entropy will be available? If that's the case, then
possibly (rate-limited):

  "urandom: process XX asked for YY bytes. CRNG not yet initialized"

> Linus

thanks,

--
darwi
http://darwish.chasingpointers.com
