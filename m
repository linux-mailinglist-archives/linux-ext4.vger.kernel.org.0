Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79313B3F63
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfIPRBO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 13:01:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43672 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726082AbfIPRBO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 13:01:14 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8GH0SBJ032514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 13:00:30 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B581A420811; Mon, 16 Sep 2019 13:00:28 -0400 (EDT)
Date:   Mon, 16 Sep 2019 13:00:28 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916170028.GA15263@mit.edu>
References: <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
 <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login>
 <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
 <20190916032327.GB22035@mit.edu>
 <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 08:40:30PM -0700, Linus Torvalds wrote:
> On Sun, Sep 15, 2019 at 8:23 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > But not blocking is *precisely* what lead us to weak keys in network
> > devices that were sold by the millions to users in their printers,
> > wifi routers, etc.
> 
> Ted, just admit that you are wrong on this, instead of writing the
> above kind of bad fantasy.
> 
> We have *always* supported blocking. It's called "/dev/random". And
> guess what? Not blocking wasn't what lead to weak keys like you try to
> imply.
> 
> What led to weak keys is that /dev/random is useless and nobody sane
> uses it, exactly because it always blocks.

How /dev/random blocks is very different from how getrandom(2) blocks.
Getrandom(2) blocks until the CRNG, and then it never blocks again.
/dev/random tries to do entropy accounting, and it blocks randomly all
the time.  *That* is why it is useless.  I agree that /dev/random is
bad, but I think you're taking the wrong message from it.  It's not
that blocking is always bad; it's that insisting on entropy accounting
and "true randomness" is bad.

The getrandom(2) system call is modelled after *BSD's getentropy(2)
call, and the fact that everyone is using is because for most use
cases, it really is the right way to go.

I think that's the core of my disagreement with you.  I agree that
what /dev/random does is wrong, and to date, we've kept it for
backwards compatibility reasons.  Some of these reasons could be
rational, or at least debated.  For example, GPG wants to use
/dev/random because it thinks it's more secure, and if they are
generating 4096 bit RSA keys, or something else which might be
"post-quantuum cryptography", it's possible that /dev/random is going
to be better than the CRNG for the hyper-paranoid.  Other use cases,
such as some PCI compliance labs who think that getrandom(2) is not
sufficiently secure, are just purely insane --- but that's assuming
today's getrandom(2) is guaranteed to return cryptographically strong
results, or nothing at all.

If we change the existing behavior of getrandom(2) with the default
flags to mean, "we return whatever we feel like, and this includes
something which looks random, but might be trivially reverse
engineered by a research engineer", that is in my mind, a Really Bad
Thing To Do.  And no, a big fat warning isn't sufficient, because
there will be some systems integrators and application programmers who
will ignore the kernel warning message.  They might not even look at
dmesg, and a system console might not exist.

					- Ted
