Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72A4B2D34
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 00:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfINWO7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sat, 14 Sep 2019 18:14:59 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:33051 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725835AbfINWO7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 18:14:59 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Sep 2019 18:14:58 EDT
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id CEDC47667D;
        Sun, 15 Sep 2019 00:05:24 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Date:   Sun, 15 Sep 2019 00:05:24 +0200
Message-ID: <9686307.bD1gDyONvH@merkaba>
In-Reply-To: <20190914211126.GA4355@darwi-home-pc>
References: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com> <20190914211126.GA4355@darwi-home-pc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ahmed S. Darwish - 14.09.19, 23:11:26 CEST:
> > Yeah, the above is yet another example of completely broken garbage.
> > 
> > You can't just wait and block at boot. That is simply 100%
> > unacceptable, and always has been, exactly because that may
> > potentially mean waiting forever since you didn't do anything that
> > actually is likely to add any entropy.
> 
> ACK, the systemd commit which introduced that code also does:
> 
>    => 26ded5570994 (random-seed: rework systemd-random-seed.service..)
> [...]
>     --- a/units/systemd-random-seed.service.in
>     +++ b/units/systemd-random-seed.service.in
>     @@ -22,4 +22,9 @@ Type=oneshot
>     RemainAfterExit=yes
>     ExecStart=@rootlibexecdir@/systemd-random-seed load
>     ExecStop=@rootlibexecdir@/systemd-random-seed save
>    -TimeoutSec=30s
>    +
>    +# This service waits until the kernel's entropy pool is
>    +# initialized, and may be used as ordering barrier for service
>    +# that require an initialized entropy pool. Since initialization
>    +# can take a while on entropy-starved systems, let's increase the
>    +# time-out substantially here.
>    +TimeoutSec=10min
> 
> This 10min wait thing is really broken... it's basically "forever".

I am so happy to use Sysvinit on my systems again. Depending on entropy 
for just booting a machine is broken¹.

Of course regenerating SSH keys on boot, probably due to cloud-init 
replacing the old key after a VM has been cloned from template, may 
still be a challenge to handle well². I'd probably replace SSH keys in 
the background and restart the service then, but this may lead to 
spurious man in the middle warnings.


[1] Debian Buster release notes: 5.1.4. Daemons fail to start or system 
appears to hang during boot

https://www.debian.org/releases/stable/amd64/release-notes/ch-information.en.html#entropy-starvation

[2] Openssh taking minutes to become available, booting takes half an 
hour ... because your server waits for a few bytes of randomness

https://daniel-lange.com/archives/152-hello-buster.html

Thanks,
-- 
Martin


