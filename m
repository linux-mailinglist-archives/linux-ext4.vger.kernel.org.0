Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BCBB3422
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 06:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfIPEaU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 00:30:20 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45652 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfIPEaU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Sep 2019 00:30:20 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8G4Tqla023841;
        Mon, 16 Sep 2019 06:29:52 +0200
Date:   Mon, 16 Sep 2019 06:29:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916042952.GB23719@1wt.eu>
References: <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
 <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
 <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916024904.GA22035@mit.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Sun, Sep 15, 2019 at 10:49:04PM -0400, Theodore Y. Ts'o wrote:
> No matter *what* we do, it's going to either (a) make some
> systems insecure, or (b) make some systems more likely hang while
> booting.

I continue to strongly disagree with opposing these two. (b) is
caused precisely because of this conflation. Life long keys are
produced around once per system's life (at least this order of
magnitude). Boot happens way more often. Users would not complain
that systems fail to start if the two types of random are properly
distinguished so that we don't fail to boot just for the sake of
secure randoms that will never be consumed as such.

Before systems had HWRNGs it was pretty common for some tools to
ask the user to type hundreds of characters on the keyboard and
use that (content+timings) to feed entropy while generating a key.
This is acceptable once in a system's life. And on some systems
with no entropy like VMs, it's commonly generated from a central
place and never from the VM itself, so it's not a problem either.

In my opinion the problem recently happened because getrandom()
was perceived as a good replacement for /dev/urandom and is way
more convenient to use, so applications progressively started to
use it without realizing that contrary to its ancestor it can
block. And each time a system fails to boot confirms that entropy
still remains a problem even on PCs in 2019. This is one more
reason for clearly keeping two interfaces depending on what type
of random is needed.

I'd be in favor of adding in the man page something like "this
random source is only suitable for applications which will not be
harmed by getting a predictable value on output, and as such it is
not suitable for generation of system keys or passwords, please
use GRND_RANDOM for this". This distinction currently is not clear
enough for people who don't know this subtle difference, and can
increase the interface's misuse.

Regards,
Willy
