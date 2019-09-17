Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 471A0B56F8
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfIQU2u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 17 Sep 2019 16:28:50 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:45411 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726285AbfIQU2u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 16:28:50 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 7A6C8776D7;
        Tue, 17 Sep 2019 22:28:47 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
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
Date:   Tue, 17 Sep 2019 22:28:47 +0200
Message-ID: <2658007.Cequ2ms4lF@merkaba>
In-Reply-To: <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <20190917174219.GD31798@gardel-login> <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Linus Torvalds - 17.09.19, 20:01:23 CEST:
> > We can make boot hang in "sane", discoverable way.
> 
> That is certainly a huge advantage, yes. Right now I suspect that what
> has happened is that this has probably been going on as some
> low-level background noise for a while, and people either figured it
> out and switched away from gdm (example: Christoph), or more likely
> some unexplained boot problems that people just didn't chase down. So
> it took basically a random happenstance to make this a kernel issue.
> 
> But "easily discoverable" would be good.

Well I meanwhile remembered how it was with sddm:

Without CPU assistance (RDRAND) or haveged or any other source of
entropy, sddm would simply not appear and I'd see the tty1 login. Then
I start to type something and after a while sddm popped up. If I would
not type anything it took easily at least have a minute till it appeared.

Actually I used my system like this quite a while, cause I did not feel
comfortable with haveged and RDRAND.

AFAIR this was as this Debian still ran with Systemd. What Debian
maintainer for sddm did was this:

sddm (0.18.0-1) unstable; urgency=medium
[…]
  [ Maximiliano Curia ]
  * Workaround entropy starvation by recommending haveged
  * Release to unstable

 -- Maximiliano Curia […]  Sun, 22 Jul 2018 13:26:44 +0200

With Sysvinit I still have neither haveged nor RDRAND enabled, but
behavior changed a bit. crng init still takes a while

% zgrep -h "crng init" /var/log/kern.log*
Sep 16 09:06:23 merkaba kernel: [   16.910096][    C3] random: crng init done
Sep  8 14:08:39 merkaba kernel: [   16.682014][    C2] random: crng init done
Sep  9 09:16:43 merkaba kernel: [   46.084188][    C2] random: crng init done
Sep 11 10:52:37 merkaba kernel: [   47.209825][    C3] random: crng init done
Sep 12 08:32:08 merkaba kernel: [   76.624375][    C3] random: crng init done
Sep 12 20:07:29 merkaba kernel: [   10.726349][    C2] random: crng init done
Sep  8 10:02:42 merkaba kernel: [   37.391577][    C2] random: crng init done
Aug 26 09:23:51 merkaba kernel: [   40.555337][    C3] random: crng init done
Aug 28 09:45:28 merkaba kernel: [   39.446847][    C1] random: crng init done
Aug 20 10:14:59 merkaba kernel: [   12.242467][    C1] random: crng init done

and there might be a slight delay before sddm appears, before tty has been
initialized. I am not completely sure whether it is related to sddm or
something else. But AFAIR delays have been in the range of a maximum of
5-10 seconds, so I did not bother to check more closely.

Note this is on a ThinkPad T520 which is a PC. And if I read above kernel log
excerpts right, it can still take up to 76 second for crng to be initialized with
entropy. Would be interesting to see other people's numbers there.

There might be a different ordering with Sysvinit and it may still be sddm.
But I never have seen a delay of 76 seconds AFAIR… so something else
might be different or I just did not notice the delay. Sometimes I switch
on the laptop and do something else to come back in a minute or so.

I don't have any kernel logs old enough to see whether whether crng init
times have been different with Systemd due to asking for randomness for
UUID/hashmaps.

Thanks,
-- 
Martin


