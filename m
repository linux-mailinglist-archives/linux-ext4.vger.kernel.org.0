Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D856EB2F3B
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfIOIeU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 04:34:20 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:38350 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIOIeT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 04:34:19 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 00E66E81176;
        Sun, 15 Sep 2019 10:34:16 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 90BA6160ADC; Sun, 15 Sep 2019 10:34:16 +0200 (CEST)
Date:   Sun, 15 Sep 2019 10:34:16 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190915083416.GA29771@gardel-login>
References: <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
 <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login>
 <20190915070103.GC20811@1wt.eu>
 <20190915070541.GC29681@gardel-login>
 <20190915070722.GD20811@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915070722.GD20811@1wt.eu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On So, 15.09.19 09:07, Willy Tarreau (w@1wt.eu) wrote:

> > That code can finish 5h after boot, it's entirely fine with this
> > specific usecase.
> >
> > Again: we don't delay "the boot" for this. We just delay "writing a
> > new seed to disk" for this. And if that is 5h later, then that's
> > totally fine, because in the meantime it's just one bg process more that
> > hangs around waiting to do what it needs to do.
>
> Didn't you say it could also happen when using encrypted swap ? If so
> I suspect this could happen very early during boot, before any services
> may be started ?

Depends on the deps, and what options are used in /etc/crypttab. If
people hard rely on swap to be enabled for boot to proceed and also
use one-time passwords from /dev/urandom they better provide some form
of hw rng, too. Otherwise the boot will block, yes.

Basically, just add "nofail" to a line in /etc/crypttab, and the entry
will be activated at boot, but we won't delay boot for it. It's going
to be activated as soon as the deps are fulfilled (and thus the pool
initialized), but that may well be 5h after boot, and that's totally
OK as long as nothing else hard depends on it.

Lennart

--
Lennart Poettering, Berlin
