Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAB6B01F3
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Sep 2019 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfIKQp6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 12:45:58 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:34892 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbfIKQp5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Sep 2019 12:45:57 -0400
Received: by mail-lj1-f178.google.com with SMTP id q22so16081501ljj.2
        for <linux-ext4@vger.kernel.org>; Wed, 11 Sep 2019 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wf1+jULNUBIRfuJ/ktIVdHO9nr5Te4e7BDdkxRDxruc=;
        b=NiGsioIWb1UrmV45MfrUxasndeSXyXrMUZYdOcd3rJFap5jXHj8y8efpflvu/A89aC
         +Eb6BGydyvMIPB/pNWEOTC2hB+shmjmGnnFt1qyQ4ahtmT/L1kXFudMp/Tn9yUYjwqW2
         ZmmpG2iBfK5s/ihr9utJJ9/iI0iLKcbwFjrTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wf1+jULNUBIRfuJ/ktIVdHO9nr5Te4e7BDdkxRDxruc=;
        b=Z/vPLKlW1H3c+K66nWrosVgNaspGAnNs9PmYg4oLrAikfMcLGlFM8q9GLtRQKSG784
         0ty+qhH0FkscOj6OTL6yBDpIbBCQZCBRXzYGXNywZG/FzxU8JbR6JDfx0R2D+t9SO7kX
         Toq+MPv2LSbRhjLCKXplQt3fte5FnIzKoYcQXWb4UcCsdE6ICNYOu9cPJrMVF95cwzuZ
         E+oOlJMcOOvcNz9gqElC8cqkZYp7h9yM99ow1XDeSABOJhumQxXAK8B36jSS/4lufX8/
         z98fAyn3KQE59Ynb56QysQCfpjilyujwU7igzcj8yOgdJMG/HBFQmEElkQnj4lTACFV8
         dKUg==
X-Gm-Message-State: APjAAAXKF7+ZK/yCS937SSmFwJFQmVeXZw3pyCWGQpi/mDH6ouVAzCkx
        HXebulGymhmRxDUJ5VjeMlu/8t+kkizmuw==
X-Google-Smtp-Source: APXvYqzmyfCw/17YsoDEpP18MZQXaqov1B8RgFrqGkp3gfYLsCY1HdoR4vwZATEEbcEVUq7WG/NyKw==
X-Received: by 2002:a2e:504f:: with SMTP id v15mr24250404ljd.67.1568220355560;
        Wed, 11 Sep 2019 09:45:55 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id u26sm5272045lfd.19.2019.09.11.09.45.54
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:45:54 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id y23so20643965lje.9
        for <linux-ext4@vger.kernel.org>; Wed, 11 Sep 2019 09:45:54 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr16069144ljo.180.1568220354002;
 Wed, 11 Sep 2019 09:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc> <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
In-Reply-To: <20190911160729.GF2740@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Sep 2019 17:45:38 +0100
X-Gmail-Original-Message-ID: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
Message-ID: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 11, 2019 at 5:07 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > Ted, comments? I'd hate to revert the ext4 thing just because it
> > happens to expose a bad thing in user space.
>
> Unfortuantely, I very much doubt this is going to work.  That's
> because the add_disk_randomness() path is only used for legacy
> /dev/random [...]
>
> Also, because by default, the vast majority of disks have
> /sys/block/XXX/queue/add_random set to zero by default.

Gaah. I was looking at the input randomness, since I thought that was
where the added randomness that Ahmed got things to work with came
from.

And that then made me just look at the legacy disk randomness (for the
obvious disk IO reasons) and I didn't look further.

> So the the way we get entropy these days for initializing the CRNG is
> via the add_interrupt_randomness() path, where do something really
> fast, and we assume that we get enough uncertainity from 8 interrupts
> to give us one bit of entropy (64 interrupts to give us a byte of
> entropy), and that we need 512 bits of entropy to consider the CRNG
> fully initialized.  (Yeah, there's a lot of conservatism in those
> estimates, and so what we could do is decide to say, cut down the
> number of bits needed to initialize the CRNG to be 256 bits, since
> that's the size of the CHACHA20 cipher.)

So that's 4k interrupts if I counted right, and yeah, maybe Ahmed was
just close enough before, and the merging of the inode table IO then
took him below that limit.

> Ultimately, though, we need to find *some* way to fix userspace's
> assumptions that they can always get high quality entropy in early
> boot, or we need to get over people's distrust of Intel and RDRAND.

Well, even on a PC, sometimes rdrand just isn't there. AMD has screwed
it up a few times, and older Intel chips just don't have it.

So I'd be inclined to either lower the limit regardless - and perhaps
make the "user space asked for randomness much too early" be a big
*warning* instead of being a basically fatal hung machine?

                Linus
