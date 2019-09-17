Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70C8B47F1
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 09:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbfIQHPi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 17 Sep 2019 03:15:38 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:52607 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727126AbfIQHPi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 03:15:38 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 4ADD4772C8;
        Tue, 17 Sep 2019 09:15:35 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: a sane approach to random numbers (was: Re: Linux 5.3-rc8)
Date:   Tue, 17 Sep 2019 09:15:35 +0200
Message-ID: <4727002.QyS4NGTWcj@merkaba>
In-Reply-To: <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
References: <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com> <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org> <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As this is not about Linux 5.3-rc8 anymore I took the liberty to change 
the subject.

Linus Torvalds - 17.09.19, 01:05:47 CEST:
> On Mon, Sep 16, 2019 at 4:02 PM Matthew Garrett <mjg59@srcf.ucam.org> 
> wrote:
> > The semantics many people want for secure key generation is urandom,
> > but with a guarantee that it's seeded.
> 
> And that is exactly what I'd suggest GRND_SECURE should do.
> 
> The problem with:
> > getrandom()'s default behaviour at present provides that
> 
> is that exactly because it's the "default" (ie when you don't pass any
> flags at all), that behavior is what all the random people get who do
> *not* really intentionally want it, they just don't think about it.
> > Changing the default (even with kernel warnings) seems like
> > it risks people generating keys from an unseeded prng, and that
> > seems
> > like a bad thing?
> 
> I agree that it's a horrible thing, but the fact that the default 0
> behavior had that "wait for entropy" is what now causes boot problems
> for people.

Seeing all the discussion, I just got the impression that it may be best 
to start from scratch. To stop trying to fix something that was broken to 
begin with – at least that was what I got from the discussion here.

Do a sane API with new function names, new flag names and over time 
deprecate the old one completely so that one day it hopefully could be 
gradually disabled until it can be removed. Similar like with statx() 
replacing stat() someday hopefully.

And do some documentation about how it is to be used by userspace 
developers. I.e. like: If the kernel says it is not random, do not block 
and poll on it, but do something to generate entropy.

But maybe that is naive, too.

However, in the end, what ever you kernel developers will come up with, 
I bet there will be no way to make the kernel control userspace 
developers. However I have the impression that that is what you attempt 
to do here. As long as you have an API to obtain guaranteed random 
numbers or at least somewhat guaranteed random numbers that is not 
directly available at boot time, userspace could poll on its 
availability. At least as long as the kernel would be honest about its 
unavailability and tell about it. And if it doesn't applications that 
*require* random numbers can never know whether they got some from the 
kernel.

Maybe you can make an API that is hard to abuse, yes. And that is good. 
But impossible?

I wonder: How could the Linux experience look like if kernel developers 
and userspace developers actually work together instead of finding ways 
to fight each other? I mean, for the most common userspace applications 
in the free software continuum, there would not be all that many people 
to talk with, or would there? It is basically gdm, sddm, some other 
display managers probably, SSH, GnuPG and probably a few more. For 
example for gdm someone could open a bug report about its use of the 
current API and ask it to use something that is non blocking? And does 
Systemd really need to deplete the random pool early at boot in order to 
generate UUIDs? Even tough I do not use GNOME I'd be willing to help 
with doing a few bug reports there and there. AFAIR there has been 
something similar with sddm which I used, but I believe there it has 
been fixed already with sddm.

Sometimes I wonder what would happen if kernel and userspace developers 
actually *talk* to each other, or better *with* each other.

But instead for example with Lennart appears to be afraid to interact 
with the kernel community and some kernel developers just talked about 
personalities that they find difficult to interact it, judging them to be 
like this and like that.

There is a social, soft skill issue here that no amount of technical 
excellence will resolve. That is at least how I observe this.

Does it make it easier? Probably not. I fully appreciate that some 
people may have a difficult time to talk with each other, I experienced 
this myself often enough. I did not report a bug report with Systemd I 
found  recently just cause I do not like to repeat the experience I had 
when I reported bugs about it before and I do not use it anymore 
personally anyway. So I totally get that.

However… not talking with each other is not going to resolve those 
userspace uses kernel API in a way kernel developers do not agree with 
and that causes issues like stalled boots. Cause basically userspace can 
abuse any kernel API and in the end the kernel can do nothing about it.

Of course feel free to ignore this, if you think it is not useful.

Thanks,
-- 
Martin


