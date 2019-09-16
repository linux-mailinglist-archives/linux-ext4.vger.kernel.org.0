Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB475B331F
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 03:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfIPB5R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 21:57:17 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:54288 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfIPB5Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 21:57:16 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 343D61A40603; Sun, 15 Sep 2019 18:48:34 -0700 (PDT)
Date:   Sun, 15 Sep 2019 18:48:34 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
References: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
 <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916014050.GA7002@darwi-home-pc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 03:40:50AM +0200, Ahmed S. Darwish wrote:
> On Sun, Sep 15, 2019 at 09:29:55AM -0700, Linus Torvalds wrote:
> > On Sat, Sep 14, 2019 at 11:51 PM Lennart Poettering
> > <mzxreary@0pointer.de> wrote:
> > >
> > > Oh man. Just spend 5min to understand the situation, before claiming
> > > this was garbage or that was garbage. The code above does not block
> > > boot.
> > 
> > Yes it does. You clearly didn't read the thread.
> > 
> > > It blocks startup of services that explicit order themselves
> > > after the code above. There's only a few services that should do that,
> > > and the main system boots up just fine without waiting for this.
> > 
> > That's a nice theory, but it doesn't actually match reality.
> > 
> > There are clearly broken setups that use this for things that it
> > really shouldn't be used for. Asking for true randomness at boot
> > before there is any indication that randomness exists, and then just
> > blocking with no further action that could actually _generate_ said
> > randomness.
> > 
> > If your description was true that the system would come up and be
> > usable while the blocked thread is waiting for that to happen, things
> > would be fine.
> >
> 
> A small note here, especially after I've just read the commit log of
> 72dbcf721566 ('Revert ext4: "make __ext4_get_inode_loc plug"'), which
> unfairly blames systemd there.
> 
> Yes, the systemd-random-seed(8) process blocks, but this is an
> isolated process, and it's only there as a synchronization point and
> to load/restore random seeds from disk across reboots.
> 
> The wisdom of having a sysnchronization service ("before/after urandom
> CRNG is inited") can be debated. That service though, and systemd in
> general, did _not_ block the overall system boot.
> 
> What blocked the system boot was GDM/gnome-session implicitly calling
> getrandom() for the Xorg MIT cookie. This was shown in the strace log
> below:
> 
>    https://lkml.kernel.org/r/20190910173243.GA3992@darwi-home-pc
> 

So did systemd-random-seed instead drain what little entropy there was
before GDM started, increasing the likelihood a subsequent getrandom()
call would block?

Regards,
Vito Caputo
