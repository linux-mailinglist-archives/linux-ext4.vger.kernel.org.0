Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78819B2EA6
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfIOGdv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 02:33:51 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45048 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfIOGdv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Sep 2019 02:33:51 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8F6XNJP021550;
        Sun, 15 Sep 2019 08:33:23 +0200
Date:   Sun, 15 Sep 2019 08:33:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190915063323.GA20811@1wt.eu>
References: <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190914211126.GA4355@darwi-home-pc>
 <20190914222432.GC19710@mit.edu>
 <CAHk-=wi-y26j4yX5JtwqwXc7zKX1K8FLQGVcx49aSYuW8JwM+w@mail.gmail.com>
 <20190915010037.GE19710@mit.edu>
 <CAHk-=wjGTV0e_P73V0B3cPVrfeoSZcV6CjQMgj-+yL-s38DKaw@mail.gmail.com>
 <20190915020521.GF19710@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915020521.GF19710@mit.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 10:05:21PM -0400, Theodore Y. Ts'o wrote:
> I'd be willing to let it take at least 2 minutes, since that's slow
> enough to be annoying.

It's an eternity, and prevents a backup system from being turned on in
time to replace a dead system. In fact the main problem with this is
that it destroys uptime on already configured systems for the sake of
making sure a private SSH key is produce correctly. It turns out that
if we instead give the info to this tool that the produced random is
not strong, this only tool that requires good entropy will be able to
ask the user to type something to add real entropy. But making the
system wait forever will not bring any extra entropy because the
services cannot start, it will not even receive network traffic and
will not be able to collect entropy. Sorry Ted, but I've been hit by
this already. It's a real problem to see a system not finish to boot
after a crash when you know your systems have only 5 minutes of total
downtime allowed per year (5 nines). And when the SSH keys, like the
rest of the config, were supposed to be either synchronized from the
network or pre-populated in a system image, nobody finds this a valid
justification for an extended downtime.

> Except the developer could (and *has) just ignored the warning, which
> is what happened with /dev/urandom when it was accessed too early.

That's why it's nice to have getrandom() return the error : it will
for once allow the developer of the program to care depending on the
program. Those proposing to choose the pieces to present in Tetris
will not care, those trying to generate an SSH key will care and will
have solid and well known fallbacks. And the rare ones who need good
randoms and ignore the error will be the ones *responsible* for this,
it will not be the kernel anymore giving bad random.

BTW I was thinking that EAGAIN was semantically better than EINVAL to
indicate that the same call should be done with blocking.

Just my two cents,
Willy
