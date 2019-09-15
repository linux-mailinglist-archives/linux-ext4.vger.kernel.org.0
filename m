Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BD8B2EDE
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 08:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfIOG46 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 02:56:58 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:38262 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfIOG45 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 02:56:57 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Sep 2019 02:56:57 EDT
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 51E95E811E1;
        Sun, 15 Sep 2019 08:56:56 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id F3F4B160ADC; Sun, 15 Sep 2019 08:56:55 +0200 (CEST)
Date:   Sun, 15 Sep 2019 08:56:55 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190915065655.GB29681@gardel-login>
References: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
 <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sa, 14.09.19 09:52, Linus Torvalds (torvalds@linux-foundation.org) wrote:

> On Sat, Sep 14, 2019 at 9:35 AM Alexander E. Patrakov
> <patrakov@gmail.com> wrote:
> >
> > Let me repeat: not -EINVAL, please. Please find some other error code,
> > so that the application could sensibly distinguish between this case
> > (low quality entropy is in the buffer) and the "kernel is too dumb" case
> > (and no entropy is in the buffer).
>
> I'm not convinced we want applications to see that difference.
>
> The fact is, every time an application thinks it cares, it has caused
> problems. I can just see systemd saying "ok, the kernel didn't block,
> so I'll just do
>
>    while (getrandom(x) == -ENOENTROPY)
>        sleep(1);
>
> instead. Which is still completely buggy garbage.
>
> The fact is, we can't guarantee entropy in general. It's probably
> there is practice, particularly with user space saving randomness from
> last boot etc, but that kind of data may be real entropy, but the
> kernel cannot *guarantee* that it is.

I am not expecting the kernel to guarantee entropy. I just expecting
the kernel to not give me garbage knowingly. It's OK if it gives me
garbage unknowingly, but I have a problem if it gives me trash all the
time.

There's benefit in being able to wait until the pool is initialized
before we update the random seed stored on disk with a new one, and
there's benefit in being able to wait until the pool is initialized
before we let cryptsetup read a fresh, one-time key for dm-crypt from
/dev/urandom. I fully understand that any such reporting for
initialization is "best-effort", i.e. to the point where we don't know
anything to the contrary, but at least give userspace that.

Lennart

--
Lennart Poettering, Berlin
