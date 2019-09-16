Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878ACB337F
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 04:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfIPCth (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 22:49:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36611 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727373AbfIPCth (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 22:49:37 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8G2n5mh000962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Sep 2019 22:49:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A349E420811; Sun, 15 Sep 2019 22:49:04 -0400 (EDT)
Date:   Sun, 15 Sep 2019 22:49:04 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916024904.GA22035@mit.edu>
References: <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
 <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
 <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 06:48:34PM -0700, Vito Caputo wrote:
> > A small note here, especially after I've just read the commit log of
> > 72dbcf721566 ('Revert ext4: "make __ext4_get_inode_loc plug"'), which
> > unfairly blames systemd there.
    ...
> > What blocked the system boot was GDM/gnome-session implicitly calling
> > getrandom() for the Xorg MIT cookie. This was shown in the strace log
> > below:
> > 
> >    https://lkml.kernel.org/r/20190910173243.GA3992@darwi-home-pc

Yes, that's correct, this isn't really systemd's fault.  It's a
combination of GDM/gnome-session stupidly using MIT Magic Cookie at
*all* (it was a bad idea 30 years ago, and it's a bad idea in 2019),
GDM/gnome-session using getrandom(2) at all; it should have just stuck
with /dev/urandom, or heck just used random_r(3) since when we're
talking about MIT Magic Cookie, there's no real security *anyway*.

It's also a combination of the hardware used by this particular user,
the init scripts in use that were probably not generating enough read
requests compared to other distributions (ironically, distributions
and init systems that try the hardest to accelerate the boot make this
problem worse by reducing the entropy that can be harvested from I/O).
And then when we optimzied ext4 so it would be more efficient, that
tipped this particular user over the edge.

Linus might not have liked my proposal to disable the optimization if
the CRNG isn't optimized, but ultimately this problem *has* gotten
worse because we've optimized things more.  So to the extent that
systemd has made systems boot faster, you could call that systemd's
"fault" --- just as Linus reverting ext4's performance optimization is
ssaying that it's ext4 "fault" because we had the temerity to try to
make the file system be more efficient, and hence, reduce entropy that
can be collected.


Ultimately, though, the person who touches this last is whose "fault"
it is.  And the problem is because it really is a no-win situation
here.  No matter *what* we do, it's going to either (a) make some
systems insecure, or (b) make some systems more likely hang while
booting.  Whether you consider the risk of (a) or (b) to be worse is
ultimately going to cause you to say that people of the contrary
opinion are either "being reckless with system security", or
"incompetent at system design".

And really, it's all going to depend on how the Linux kernel is being
used.  The fact that Linux is being used in IOT devices, mobile
handsets, desktops, servers running in VM's, user desktops, etc.,
means that there will be some situations where blocking is going to be
terrible, and some situations where a failure to provide system
security could result in risking someone's life, health, or mission
failure in some critical system.

That's why this discussion can easily get toxic.  If you are only
focusing on one part of Linux market, then obviously *you* are the
only sane one, and everyone *else* who disagrees with you must be
incompetent.  When, perhaps, they may simply be focusing on a
different part of the ecosystem where Linux is used.

> So did systemd-random-seed instead drain what little entropy there was
> before GDM started, increasing the likelihood a subsequent getrandom()
> call would block?

No.  Getrandom(2) uses the new CRNG, which is either initialized, or
it's not.  Once it's initialized, it won't block again ever.

     	   	     		     	   - Ted
