Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B26B00F5
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Sep 2019 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfIKQH7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 12:07:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52526 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729017AbfIKQH7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Sep 2019 12:07:59 -0400
Received: from callcc.thunk.org (38.85.69.148.rev.vodafone.pt [148.69.85.38] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8BG7Uor002355
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 12:07:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7CEFF42049E; Wed, 11 Sep 2019 12:07:29 -0400 (EDT)
Date:   Wed, 11 Sep 2019 12:07:29 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190911160729.GF2740@mit.edu>
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
 <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 10, 2019 at 07:21:54PM +0100, Linus Torvalds wrote:
> On Tue, Sep 10, 2019 at 6:33 PM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> >
> > While gnome-session is obviously at fault here by requiring
> > *blocking* randomness at the boot path, it's still not requesting
> > much, just (5 * 16) bytes to be exact.

It doesn't matter how much randomness it's requesting.  With the new
cryptographic random number generator, the CRNG is either
initialized.... or it's not.

> Just out of curiosity, what happens if you apply a patch like this
> (intentionally whitespace-damaged, I don't want anybody to pick it up
> without thinking about it) thing...

> Which I think is what the code really wants - it's only using jiffies
> because that is the only thing _guaranteed_ to change at all. But with
> the sum, you get the best of both worlds, and should basically make
> the entropy estimation use the "better of two counters".
> 
> Ted, comments? I'd hate to revert the ext4 thing just because it
> happens to expose a bad thing in user space.

Unfortuantely, I very much doubt this is going to work.  That's
because the add_disk_randomness() path is only used for legacy
/dev/random (which actually only still exists because of some insane
PCI compliance issues which a number of end users really care about
--- or they care about because it makes the insane PCI complaince labs
go away).

Also, because by default, the vast majority of disks have
/sys/block/XXX/queue/add_random set to zero by default.

So the the way we get entropy these days for initializing the CRNG is
via the add_interrupt_randomness() path, where do something really
fast, and we assume that we get enough uncertainity from 8 interrupts
to give us one bit of entropy (64 interrupts to give us a byte of
entropy), and that we need 512 bits of entropy to consider the CRNG
fully initialized.  (Yeah, there's a lot of conservatism in those
estimates, and so what we could do is decide to say, cut down the
number of bits needed to initialize the CRNG to be 256 bits, since
that's the size of the CHACHA20 cipher.)

Ultimately, though, we need to find *some* way to fix userspace's
assumptions that they can always get high quality entropy in early
boot, or we need to get over people's distrust of Intel and RDRAND.
Otherwise, future performance improvements in any part of the system
which reduces the number of interrupts is always going to potentially
result in somebody's misconfigured system or badly written
applications to fail to boot.  :-(

					- Ted
