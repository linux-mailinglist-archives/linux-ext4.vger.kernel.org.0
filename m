Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4BB7407
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2019 09:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbfISH2I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 19 Sep 2019 03:28:08 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:34167 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732034AbfISH2H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Sep 2019 03:28:07 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 2A05677F1C;
        Thu, 19 Sep 2019 09:28:04 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Date:   Thu, 19 Sep 2019 09:28:03 +0200
Message-ID: <4837188.Q7355LDvlW@merkaba>
In-Reply-To: <20190918135325.GC32346@gardel-login>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <3783292.MWR84v24fu@merkaba> <20190918135325.GC32346@gardel-login>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear Lennart.

Lennart Poettering - 18.09.19, 15:53:25 CEST:
> On Mi, 18.09.19 00:10, Martin Steigerwald (martin@lichtvoll.de) wrote:
> > > getrandom() will never "consume entropy" in a way that will block
> > > any
> > > users of getrandom(). If you don't have enough collected entropy
> > > to
> > > seed the rng, getrandom() will block. If you do, getrandom() will
> > > generate as many numbers as you ask it to, even if no more entropy
> > > is
> > > ever collected by the system. So it doesn't matter how many
> > > clients
> > > you have calling getrandom() in the boot process - either there'll
> > > be
> > > enough entropy available to satisfy all of them, or there'll be
> > > too
> > > little to satisfy any of them.
> > 
> > Right, but then Systemd would not use getrandom() for initial
> > hashmap/ UUID stuff since it
> 
> Actually things are more complex. In systemd there are four classes of
> random values we need:
> 
> 1. High "cryptographic" quality. There are very few needs for this in
[…]
> 2. High "non-cryptographic" quality. This is used for example for
[…]
> 3. Medium quality. This is used for seeding hash tables. These may be
[…]
> 4. Crap quality. There are only a few uses of this, where rand_r() is
>    is OK.
> 
> Of these four case, the first two might block boot. Because the first
> case is not common you won't see blocking that often though for
> them. The second case is very common, but since we use RDRAND you
> won't see it on any recent Intel machines.
> 
> Or to say this all differently: the hash table seeding and the uuid
> case are two distinct cases in systemd, and I am sure they should be.

Thank you very much for your summary of uses of random numbers in 
Systemd and also for your other mail that "neither RDRAND nor /dev/
urandom know a concept of of "depleting entropy"". I thought they would 
deplete entropy needed to the initial seeding of crng.

Thank you also for taking part in this discussion, even if someone put 
your mail address on carbon copy without asking with.

I do not claim I understand enough of this random number stuff. But I 
feel its important that kernel and userspace developers actually talk 
with each other about a sane approach for it. And I believe that the 
complexity involved is part of the issue. I feel an API for attaining 
random number with different quality levels needs to be much, much, much 
more simple to use *properly*.

I felt a bit overwhelmed by the discussion (and by what else is 
happening in my life, just having come back from holding a Linux 
performance workshop in front of about two dozen people), so I intend to 
step back from it. 

If one of my mails actually helped to encourage or facilitate kernel 
space and user space developers talking with each other about a sane 
approach to random numbers, then I may have used my soft skills in a way 
that brings some benefit. For the technical aspects certainly people are 
taking part in this discussion who are much much deeper into the 
intricacies of entropy in Linux and computers in general, so I just hope 
for a good outcome.

Best,
-- 
Martin


