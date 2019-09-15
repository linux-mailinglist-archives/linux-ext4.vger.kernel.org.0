Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BB0B2F4C
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfIOI7J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 04:59:09 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:38412 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfIOI7J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 04:59:09 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 9F34EE81176;
        Sun, 15 Sep 2019 10:59:07 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 48AF2160ADC; Sun, 15 Sep 2019 10:59:07 +0200 (CEST)
Date:   Sun, 15 Sep 2019 10:59:07 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v3] random: getrandom(2): optionally block when CRNG
 is uninitialized
Message-ID: <20190915085907.GC29771@gardel-login>
References: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <20190915081747.GA1058@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915081747.GA1058@darwi-home-pc>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On So, 15.09.19 10:17, Ahmed S. Darwish (darwish.07@gmail.com) wrote:

> Thus, don't trust user-space on calling getrandom(2) from the right
> context. Never block, by default, and just return data from the
> urandom source if entropy is not yet available. This is an explicit
> decision not to let user-space work around this through busy loops on
> error-codes.
>
> Note: this lowers the quality of random data returned by getrandom(2)
> to the level of randomness returned by /dev/urandom, with all the
> original security implications coming out of that, as discussed in
> problem "3." at the top of this commit log. If this is not desirable,
> offer users a fallback to old behavior, by CONFIG_RANDOM_BLOCK=y, or
> random.getrandom_block=true bootparam.

This is an awful idea. It just means that all crypto that needs
entropy doing during early boot will now be using weak keys, and
doesn't even know it.

Yeah, it's a bad situation, but I am very sure that failing loudly in
this case is better than just sticking your head in the sand and
ignoring the issue without letting userspace know is an exceptionally
bad idea.

We live in a world where people run HTTPS, SSH, and all that stuff in
the initrd already. It's where SSH host keys are generated, and plenty
session keys. If Linux lets all that stuff run with awful entropy then
you pretend things where secure while they actually aren't. It's much
better to fail loudly in that case, I am sure.

Quite frankly, I don't think this is something to fix in the
kernel. Let the people putting together systems deal with this. Let
them provide a creditable hw rng, and let them pay the price if they
don't.

Lennart

--
Lennart Poettering, Berlin
