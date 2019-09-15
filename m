Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2DAB2EEA
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfIOHFo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 03:05:44 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:38286 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfIOHFn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 03:05:43 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 5F68CE81176;
        Sun, 15 Sep 2019 09:05:42 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 09FE7160ADC; Sun, 15 Sep 2019 09:05:41 +0200 (CEST)
Date:   Sun, 15 Sep 2019 09:05:41 +0200
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
Message-ID: <20190915070541.GC29681@gardel-login>
References: <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
 <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login>
 <20190915070103.GC20811@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915070103.GC20811@1wt.eu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On So, 15.09.19 09:01, Willy Tarreau (w@1wt.eu) wrote:

> On Sun, Sep 15, 2019 at 08:56:55AM +0200, Lennart Poettering wrote:
> > There's benefit in being able to wait until the pool is initialized
> > before we update the random seed stored on disk with a new one,
>
> And what exactly makes you think that waiting with arms crossed not
> doing anything else has any chance to make the situation change if
> you already had no such entropy available when reaching that first
> call, especially during early boot ?

That code can finish 5h after boot, it's entirely fine with this
specific usecase.

Again: we don't delay "the boot" for this. We just delay "writing a
new seed to disk" for this. And if that is 5h later, then that's
totally fine, because in the meantime it's just one bg process more that
hangs around waiting to do what it needs to do.

Lennart

--
Lennart Poettering, Berlin
