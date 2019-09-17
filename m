Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD52BB527D
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfIQQIq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 12:08:46 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:40620 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfIQQIq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 12:08:46 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id B3788E80FFC;
        Tue, 17 Sep 2019 18:08:44 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 6D90D160ADC; Tue, 17 Sep 2019 18:08:44 +0200 (CEST)
Date:   Tue, 17 Sep 2019 18:08:44 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917160844.GC31567@gardel-login>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Di, 17.09.19 12:30, Ahmed S. Darwish (darwish.07@gmail.com) wrote:

> 	  Ideally, systems would be configured with hardware random
> 	  number generators, and/or configured to trust the CPU-provided
> 	  RNG's (CONFIG_RANDOM_TRUST_CPU) or boot-loader provided ones
> 	  (CONFIG_RANDOM_TRUST_BOOTLOADER).  In addition, userspace
> 	  should generate cryptographic keys only as late as possible,
> 	  when they are needed, instead of during early boot.  (For
> 	  non-cryptographic use cases, such as dictionary seeds or MIT
> 	  Magic Cookies, other mechanisms such as /dev/urandom or
> 	  random(3) may be more appropropriate.)
>
> Sounds good?

This sounds mean. You make apps pay for something they aren't really
at fault for.

I mean, in the cloud people typically put together images that are
replicated to many systems, and as first thing generate an SSH key, on
the individual system. In fact, most big distros tend to ship SSH that
is precisely set up this way: on first boot the SSH key is
generated. They tend to call getrandom(0) for this right now, and
rightfully so. Now suddenly you kill them because they are doing
everything correctly? Those systems aren't going to be more useful if
they have no SSH key at all than they would be if they would hang at
boot: either way you can't log in.

Here's what I'd propose:

1) Add GRND_INSECURE to get those users of getrandom() who do not need
   high quality entropy off its use (systemd has uses for this, for
   seeding hash tables for example), thus reducing the places where
   things might block.

2) Add a kernel log message if a getrandom(0) client hung for 15s or
   more, explaining the situation briefly, but not otherwise changing
   behaviour.

3) Change systemd-random-seed.service to log to console in the same
   case, blocking boot cleanly and discoverably.

I am not a fan of randomly killing userspace processes that just
happened to be the unlucky ones, to call this first... I see no
benefit in killing stuff over letting boot hang in a discoverable way.

Lennart
