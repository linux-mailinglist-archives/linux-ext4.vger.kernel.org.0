Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBFCAF0FA
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 20:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfIJSWO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 14:22:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37155 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfIJSWO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Sep 2019 14:22:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id y5so6631028lji.4
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5P9ttF1/2Ib5VFhEVo7KpreA5cagQcSElkprtXuPFJ4=;
        b=WcvbVXQUfce7X97DS/+cRl6BUfThxoccZ9u1qqXcfyW+V/5la2xd+dYPzdytVr9WfQ
         YAfdGXrYBS7pRh04zXbxpPlQsUQUoOYU69a0GyHQsU6Nz8Wxh+a4vOC9YvoH/MCgk7k2
         LqDI9SM9pQWth5YgA6y05WQlKk5GxmZWTfqfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5P9ttF1/2Ib5VFhEVo7KpreA5cagQcSElkprtXuPFJ4=;
        b=PifLe/pNX9h5Sc27rgUwKzwwkEip9BrAdqrAXK5P5kuSLhmhEOVowBw23n9lLUyHJq
         Xre96x4AIVmSzCl+HME7buEA8t87JbrI5/hMKJ04UYphULYAgaSV69RssvHAlfgI/Lfg
         6RO2pX+GBuT9F7XrUbUTOEJIQb9wdJNHM3HBm/72epkzqw7rWYCVDDaOL1gvh1OyY0nD
         eg+2P0e98LXNwMUu+sKKP8M2T6fOXKLGdE0CCVvil7oGFTe0hySAtzMH8R5sektdt6sx
         ySSfKkO306dIF74hhHe2BFczRwQPViw908uCZZM2LFZMl5xIbLgm9wzq5My8lFNZUMUF
         C73w==
X-Gm-Message-State: APjAAAW17vSxAoVRHVpNAr8W0DOUdcsbb3NdEnmTqVKR3vWOwEPGnrhI
        um7LJo4l1f3nt+p2xP2kvXf0XQYy0H9o2g==
X-Google-Smtp-Source: APXvYqxohWBSY4rWzFpHSzBZPpyjM5QaOTyUxVM01FxCL1MaGOoSmmPh1d7KFTLuiL12PL9wyOyAxQ==
X-Received: by 2002:a2e:b601:: with SMTP id r1mr1886338ljn.80.1568139732194;
        Tue, 10 Sep 2019 11:22:12 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 81sm4076045lje.70.2019.09.10.11.22.10
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 11:22:10 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id a22so17483410ljd.0
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 11:22:10 -0700 (PDT)
X-Received: by 2002:a05:651c:103c:: with SMTP id w28mr5866713ljm.90.1568139730101;
 Tue, 10 Sep 2019 11:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc> <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
In-Reply-To: <20190910173243.GA3992@darwi-home-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Sep 2019 19:21:54 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
Message-ID: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
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

On Tue, Sep 10, 2019 at 6:33 PM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> While gnome-session is obviously at fault here by requiring
> *blocking* randomness at the boot path, it's still not requesting
> much, just (5 * 16) bytes to be exact.
>
> I guess an x86 laptop should be able to provide that, even without
> RDRAND / random.trust_cpu=on (TSC jitter, etc.) ?

Yeah, the problem is partly because we can't trust "get_cycles()"
because not all architectures have it. So we use "jiffies" for the
entropy estimation, and my guess is that it just ends up estimating
you have little to no entropy from your disk IO.

So the timestamp counter value is added to the randomness pool, but
the jitter in the TSC values isn't then used to estimate the entropy
at all.

Just out of curiosity, what happens if you apply a patch like this
(intentionally whitespace-damaged, I don't want anybody to pick it up
without thinking about it) thing:

   diff --git a/drivers/char/random.c b/drivers/char/random.c
   index 5d5ea4ce1442..60709a7b4af1 100644
   --- a/drivers/char/random.c
   +++ b/drivers/char/random.c
   @@ -1223,6 +1223,7 @@ static void add_timer_randomness(struct
timer_rand_state *state, unsigned $
         * We take into account the first, second and third-order deltas
         * in order to make our estimate.
         */
   +    sample.jiffies += sample.cycles;
        delta = sample.jiffies - state->last_time;
        state->last_time = sample.jiffies;


which just makes the entropy estimation use the _sum_ of jiffies and
cycles as the base. On architectures that don't have a cycle counter,
it ends up being the same it used to be (just jiffies), and on
architectures that do have a timestamp counter the TSC differences
will overwhelm the jiffies differences, so you end up effectively
using the third-order TSC difference as the entropy estimation.

Which I think is what the code really wants - it's only using jiffies
because that is the only thing _guaranteed_ to change at all. But with
the sum, you get the best of both worlds, and should basically make
the entropy estimation use the "better of two counters".

Ted, comments? I'd hate to revert the ext4 thing just because it
happens to expose a bad thing in user space.

              Linus
