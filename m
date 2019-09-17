Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D48B57E5
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 00:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfIQWKh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 17 Sep 2019 18:10:37 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:40659 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727365AbfIQWKg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 18:10:36 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id DECBD77749;
        Wed, 18 Sep 2019 00:10:33 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Date:   Wed, 18 Sep 2019 00:10:33 +0200
Message-ID: <3783292.MWR84v24fu@merkaba>
In-Reply-To: <20190917215200.wtjim3t6zgt7gdmw@srcf.ucam.org>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <1722575.Y5XjozQscI@merkaba> <20190917215200.wtjim3t6zgt7gdmw@srcf.ucam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Matthew Garrett - 17.09.19, 23:52:00 CEST:
> On Tue, Sep 17, 2019 at 11:38:33PM +0200, Martin Steigerwald wrote:
> > My understanding of entropy always has been that only a certain
> > amount of it can be produced in a certain amount of time. If that
> > is wrong… please by all means, please teach me, how it would be.
> 
> getrandom() will never "consume entropy" in a way that will block any
> users of getrandom(). If you don't have enough collected entropy to
> seed the rng, getrandom() will block. If you do, getrandom() will
> generate as many numbers as you ask it to, even if no more entropy is
> ever collected by the system. So it doesn't matter how many clients
> you have calling getrandom() in the boot process - either there'll be
> enough entropy available to satisfy all of them, or there'll be too
> little to satisfy any of them.

Right, but then Systemd would not use getrandom() for initial hashmap/
UUID stuff since it

1) would block boot very early then, which is not desirable and

2) it does not need strong random numbers anyway.

At least that is how I understood Lennart's comments on the Systemd bug 
report I referenced.

AFAIK hashmap/UUID stuff uses *some* entropy *before* crng has been 
seeded with entropy and all I wondered was whether this using *some* 
entropy *before* crng has been seeded – by /dev/urandom initially, but 
now as far as I got with RDRAND if available – will delay the process of 
gathering the entropy  necessary to seed crng… if that is the case then 
anything that uses crng during or soon after boot, like gdm, sddm, 
OpenSSH ssh-keygen will be blocked for a longer time will the initial 
seeding of crng has been done.

Of course if hashmap/UUID stuff does not use any entropy that would be 
required for the *initial* seeding or crng, then… that would not be the 
case. But from what I understood, it does.

And yes, for "systemd-random-seed" it is true that it does not drain 
entropy for getrandom, cause it writes the seed to disk *after* crng has 
been initialized, i.e. at a time where getrandom would never block again 
as long as the system is running.

If I am still completely misunderstanding something there, then it may 
be better to go to sleep. Which I will do now anyway.

Or I may just not be very good at explaining what I mean.

-- 
Martin


