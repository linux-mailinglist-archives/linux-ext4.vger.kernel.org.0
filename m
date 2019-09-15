Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A360DB2F5A
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 11:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfIOJbS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 05:31:18 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45156 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfIOJbS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Sep 2019 05:31:18 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8F9UvR6021757;
        Sun, 15 Sep 2019 11:30:57 +0200
Date:   Sun, 15 Sep 2019 11:30:57 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v3] random: getrandom(2): optionally block when CRNG
 is uninitialized
Message-ID: <20190915093057.GF20811@1wt.eu>
References: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <20190915081747.GA1058@darwi-home-pc>
 <20190915085907.GC29771@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915085907.GC29771@gardel-login>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 10:59:07AM +0200, Lennart Poettering wrote:
> We live in a world where people run HTTPS, SSH, and all that stuff in
> the initrd already. It's where SSH host keys are generated, and plenty
> session keys.

It is exactly the type of crap that create this situation : making
people developing such scripts believe that any random source was OK
to generate these, and as such forcing urandom to produce crypto-solid
randoms! No, distro developers must know that it's not acceptable to
generate lifetime crypto keys from the early boot when no entropy is
available. At least with this change they will get an error returned
from getrandom() and will be able to ask the user to feed entropy, or
be able to say "it was impossible to generate the SSH key right now,
the daemon will only be started once it's possible", or "the SSH key
we produced will not be saved because it's not safe and is only usable
for this recovery session".

> If Linux lets all that stuff run with awful entropy then
> you pretend things where secure while they actually aren't. It's much
> better to fail loudly in that case, I am sure.

This is precisely what this change permits : fail instead of block
by default, and let applications decide based on the use case.

> Quite frankly, I don't think this is something to fix in the
> kernel.

As long as it offers a single API to return randoms, and that it is
not possible not to block for low-quality randoms, it needs to be
at least addressed there. Then userspace can adapt. For now userspace
does not have this option just due to the kernel's way of exposing
randoms.

Willy
