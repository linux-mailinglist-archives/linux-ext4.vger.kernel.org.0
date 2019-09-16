Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7259B343A
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 06:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfIPEx7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 00:53:59 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45673 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfIPEx6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Sep 2019 00:53:58 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8G4rVbY023928;
        Mon, 16 Sep 2019 06:53:31 +0200
Date:   Mon, 16 Sep 2019 06:53:31 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916045331.GC23719@1wt.eu>
References: <20190911160729.GF2740@mit.edu>
 <20190916035228.GA1767@gondor.apana.org.au>
 <CAHk-=wjQeiYu8Q_wcMgM-nAcW7KsBfG1+90DaTD5WF2cCeGCgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQeiYu8Q_wcMgM-nAcW7KsBfG1+90DaTD5WF2cCeGCgA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 09:21:06PM -0700, Linus Torvalds wrote:
> The timer interrupt could be somewhat interesting if you are also
> CPU-bound on a non-trivial load, because then "what program counter
> got interrupted" ends up being possibly unpredictable - even with a
> very stable timer interrupt source - and effectively stand in for a
> cycle counter even on hardware that doesn't have a native TSC. Lots of
> possible low-level jitter there to use for entropy. But especially if
> you're just idly _waiting_ for entropy, you won't be "CPU-bound on an
> interesting load" - you'll just hit the CPU idle loop all the time so
> even that wouldn't work.

In the old DOS era, I used to produce randoms by measuring the time it
took for some devices to reset themselves (typically 8250 UARTs could
take in the order of milliseconds). And reading their status registers
during the reset phase used to show various sequences of flags at
approximate timings.

I suspect this method is still usable, even with SoCs full of peripherals,
in part because not all clocks are synchronous, so we can retrieve a
little bit of entropy by measuring edge transitions. I don't know how
we can assess the number of bits provided by such method (probably
log2(card(discrete values))) but maybe this is something we should
progressively encourage drivers authors to do in the various device
probing functions once we figure the best way to do it.

The idea is around this. Instead of :

     probe(dev)
     {
          (...)
          while (timeout && !(status_reg & STATUS_RDY))
               timeout--;
          (...)
     }

We could do something like this (assuming 1 bit of randomness here) :

     probe(dev)
     {
          (...)
          prev_timeout = timeout;
          prev_reg     = status_reg;
          while (timeout && !(status_reg & STATUS_RDY)) {
               if (status_reg != prev_reg) {
                     add_device_randomness_bits(timeout - prev_timeout, 1);
                     prev_timeout = timeout;
                     prev_reg = status_reg;
               }
               timeout--;
          }
          (...)
     }

It's also interesting to note that on many motherboards there are still
multiple crystal oscillators (typically one per ethernet port) and that
such types of independent, free-running clocks do present unpredictable
edges compared to the CPU's clock, so when they affect the device's
setup time, this does help quite a bit.

Willy
