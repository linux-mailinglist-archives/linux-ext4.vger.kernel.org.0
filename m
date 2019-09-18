Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DCBB6521
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfIRNx1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 09:53:27 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:41690 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfIRNx1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Sep 2019 09:53:27 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id D981EE80FFC;
        Wed, 18 Sep 2019 15:53:25 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 8C524160ADC; Wed, 18 Sep 2019 15:53:25 +0200 (CEST)
Date:   Wed, 18 Sep 2019 15:53:25 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190918135325.GC32346@gardel-login>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <1722575.Y5XjozQscI@merkaba>
 <20190917215200.wtjim3t6zgt7gdmw@srcf.ucam.org>
 <3783292.MWR84v24fu@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3783292.MWR84v24fu@merkaba>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mi, 18.09.19 00:10, Martin Steigerwald (martin@lichtvoll.de) wrote:

> > getrandom() will never "consume entropy" in a way that will block any
> > users of getrandom(). If you don't have enough collected entropy to
> > seed the rng, getrandom() will block. If you do, getrandom() will
> > generate as many numbers as you ask it to, even if no more entropy is
> > ever collected by the system. So it doesn't matter how many clients
> > you have calling getrandom() in the boot process - either there'll be
> > enough entropy available to satisfy all of them, or there'll be too
> > little to satisfy any of them.
>
> Right, but then Systemd would not use getrandom() for initial hashmap/
> UUID stuff since it

Actually things are more complex. In systemd there are four classes of
random values we need:

1. High "cryptographic" quality. There are very few needs for this in
   systemd, as we do very little in this area. It's basically only
   used for generating salt values for hashed passwords, in the
   systemd-firstboot component, which can be used to set the root
   pw. systemd uses synchronous getrandom() for this. It does not use
   RDRAND for this.

2. High "non-cryptographic" quality. This is used for example for
   generating type 4 uuids, i.e uuids that are supposed to be globally
   unique, but aren't key material. We use RDRAND for this if
   available, falling back to synchronous getrandom(). Type 3 UUIDs
   are frequently needed by systemd, as we assign a uuid to each
   service invocation implicitly, so that people can match logging
   data and such to a specific instance and runtime of a service.

3. Medium quality. This is used for seeding hash tables. These may be
   crap initially, but should not be guessable in the long
   run. /dev/urandom would be perfect for this, but the mentioned log
   message sucks, hence we use RDRAND for this if available, and fall
   back to /dev/urandom if that isn't available, accepting the log
   message.

4. Crap quality. There are only a few uses of this, where rand_r() is
   is OK.

Of these four case, the first two might block boot. Because the first
case is not common you won't see blocking that often though for
them. The second case is very common, but since we use RDRAND you
won't see it on any recent Intel machines.

Or to say this all differently: the hash table seeding and the uuid
case are two distinct cases in systemd, and I am sure they should be.

Lennart

--
Lennart Poettering, Berlin
