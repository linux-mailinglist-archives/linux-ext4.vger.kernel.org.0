Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92517B57B2
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 23:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfIQVih convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 17 Sep 2019 17:38:37 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:48061 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726999AbfIQVig (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 17:38:36 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 4277D77722;
        Tue, 17 Sep 2019 23:38:33 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Date:   Tue, 17 Sep 2019 23:38:33 +0200
Message-ID: <1722575.Y5XjozQscI@merkaba>
In-Reply-To: <20190917205234.GA1765@darwi-home-pc>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <2658007.Cequ2ms4lF@merkaba> <20190917205234.GA1765@darwi-home-pc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ahmed S. Darwish - 17.09.19, 22:52:34 CEST:
> On Tue, Sep 17, 2019 at 10:28:47PM +0200, Martin Steigerwald wrote:
> [...]
> 
> > I don't have any kernel logs old enough to see whether whether crng
> > init times have been different with Systemd due to asking for
> > randomness for UUID/hashmaps.
> 
> Please stop claiming this. It has been pointed out to you, __multiple
> times__, that this makes no difference. For example:
> 
>     https://lkml.kernel.org/r/20190916024904.GA22035@mit.edu
> 
>     No. getrandom(2) uses the new CRNG, which is either initialized,
>     or it's not ... So to the extent that systemd has made systems
>     boot faster, you could call that systemd's "fault".
> 
> You've claimed this like 3 times before in this thread already, and
> multiple people replied with the same response. If you don't get the
> paragraph above, then please don't continue replying further on this
> thread.

First off, this mail you referenced has not been an answer to a mail of 
mine. It does not have my mail address in Cc. So no, it has not been 
pointed out directly to me in that mail.

Secondly: Pardon me, but I do not see how asking for entropy early at 
boot times or not doing so has *no effect* on the available entropy¹. And 
I do not see the above mail actually saying this. To my knowledge 
Sysvinit does not need entropy for itself². The above mail merely talks 
about the blocking on boot. And whether systemd-random-seed would drain 
entropy, not whether hashmaps/UUID do. And also not the effect that 
asking for entropy early has on the available entropy and on the 
*initial* initialization time of the new CRNG. However I did not claim 
that Systemd would block booting. *Not at all*.

Thirdly: I disagree with the tone you use in your mail. And for that 
alone I feel it may be better for me to let go of this discussion.

My understanding of entropy always has been that only a certain amount 
of it can be produced in a certain amount of time. If that is wrong… 
please by all means, please teach me, how it would be.

However I am not even claiming anything. All I wrote above is that I do 
not have any measurements. But I'd expect that the more entropy is asked 
for early during boot, the longer the initial initialization of the new 
CRNG will take. And if someone else relies on this initialization, that 
something else would block for a longer time.

I got that it the new crng won't block after that anymore.

[1] https://github.com/systemd/systemd/issues/4167

(I know that it still with /dev/urandom, so if it is using RDRAND now, 
this may indeed be different, but would it then deplete entropy the CPU 
has available and that by default is fed into the Linux crng as well 
(even without trusting it completely)?)

[2] According to

https://daniel-lange.com/archives/152-Openssh-taking-minutes-to-become-available,-booting-takes-half-an-hour-...-because-your-server-waits-for-a-few-bytes-of-randomness.html

sysvinit does not contain a single line of code about entropy or random 
numbers.

Daniel even updated his blog post with a hint to this discussion.

Thanks,
-- 
Martin


