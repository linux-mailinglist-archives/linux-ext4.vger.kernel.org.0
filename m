Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4CFAB0EA8
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2019 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfILMMX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Sep 2019 08:12:23 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:43294 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbfILMMW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Sep 2019 08:12:22 -0400
X-Greylist: delayed 813 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 08:12:22 EDT
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8CBwOk1011171;
        Thu, 12 Sep 2019 13:58:24 +0200
Date:   Thu, 12 Sep 2019 13:58:24 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190912115824.GB11016@1wt.eu>
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 12, 2019 at 12:34:45PM +0100, Linus Torvalds wrote:
> An alternative might be to make getrandom() just return an error
> instead of waiting. Sure, fill the buffer with "as random as we can"
> stuff, but then return -EINVAL because you called us too early.

That's probably one of the most sensible approaches. I must say I feel
quite annoyed by what randomness has become due to the misuse of poor
random sources by security components suddenly forcing all these sources
to become strong and having to become unavailable for everything which
doesn't need strong random. And most of the time the stuff which doesn't
need a strong random happens during early boot. It can range from issuing
a MAC address before setting a link up (when you have no chance to get
entropy) to providing a UUID for a file system, or use of ephemeral
randoms for session keys for the first access to a device for its
configuration. A number of these often end up with a system not
booting, unable to self-configure itself, or not being available when
expected.

It's too late now to change existing applications, but probably that
doing something like above would at least allow applications to
implement a fall back with the choice of "hey Mr user, there's not
enough entropy yet to propose you a secure password, so please type
20 random chars on the keyboard so that I can complete it", or
conversely "the syscall failed but I know I can still use the
buffer's contents for a MAC address".

But having to make the syscall to wait longer is never going to serve
anyone. Two minutes is an eternity for certain devices, and some from
the security world will consider that the syscall waited long enough
to produce a good security so it's OK to use it as a reliable source.
Failing immediately with whatever could be obtained is by far the
best solution in my opinion as the application has to take the
responsibility for using that buffer's contents.

Willy
-- still dreaming about the day boot loaders will collect entropy from
the DDR training phase and pass it to the kernel.
