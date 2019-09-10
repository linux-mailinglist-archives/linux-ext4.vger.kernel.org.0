Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38EAF083
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 19:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437062AbfIJRdR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 13:33:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36812 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436774AbfIJRdR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Sep 2019 13:33:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id p13so492731wmh.1;
        Tue, 10 Sep 2019 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wt5JeczPrCBzCgehywueQJ61lZygPQJ472U+kIhvLrQ=;
        b=MgjPgu1diPg/vU26ZJEZ4SaIsGlgvuk87hug7Apxetu4ogdIBFhtK7fOez+vO9hgYv
         Iw474Le88m62b9l9kMEuMpo06G8GVRd7JMSFsz/fbo7uOLUbV92+DMuWOn9QD72vYogO
         3SvdPYAW7cBmmZEz6/0ZDOKcStVrIG1PNuFbAatjfUcWcEs3L4NNRJbfCKv9OO9yWCTx
         1JKqidVSrzGQ4jWdDluZ24Bb6ettRk8Qo9/qDAQbfWA0ONz/uez4HS4o5VKlTf1jQj+l
         U7TF1JazfDxx6avjv9BrgjuMhjEgFiuNc4VM2ySTzqd0wa7/nSr9sVih8Ppor4oCA4AK
         sc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wt5JeczPrCBzCgehywueQJ61lZygPQJ472U+kIhvLrQ=;
        b=kz6v9LxYN/2/tn8/N0W+O6TNmltRVc3LA7U4+abgBsaRQXe8d9XoIb2iQuoHY/KJQA
         fHfnW9rXtQnfcw3QR+O8/WkzTYHgW6CrwIxc0sd2L7thHDPRPOtc+uxNXhvNHyT+9NWp
         7mqtwDt3AO+xD9DPkBdGk2vQuaNwP4FlNuFwbAbQ6GP8Cs8EFfVB49PRFvM1QVSteL99
         u2dT6lDOdLKjoBWWeB0YnyMqqFTKBe9hoM2kJrZSpMu5XOFGIw8t14fiLn7fkFkKYPjr
         mOEXb9RzNfwMDSL8P4alNL+pZta2BwzySW9yC1ET/2nVLlGYW1Rq65y5zW4DJ60X3F/5
         9ckQ==
X-Gm-Message-State: APjAAAXyvnOqG/m4SGn74YblASSm+qYCcGZvmkJB/35ii8bc8Ci/sLb4
        ziBq/k80OMf3blACSSU0loo=
X-Google-Smtp-Source: APXvYqymzz3cJ6lzpTekYi4CrZ9yidlFwg56ZZE1gRSlX/QGn5wag2FH62iKVhiUIS1+/1ytdemN3g==
X-Received: by 2002:a1c:ef14:: with SMTP id n20mr520579wmh.89.1568136793312;
        Tue, 10 Sep 2019 10:33:13 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D144910CD9D07D5336EC2.dip0.t-ipconnect.de. [2003:d0:6f2d:1449:10cd:9d07:d533:6ec2])
        by smtp.gmail.com with ESMTPSA id n7sm17956584wrx.42.2019.09.10.10.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 10:33:12 -0700 (PDT)
Date:   Tue, 10 Sep 2019 19:33:04 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190910173243.GA3992@darwi-home-pc>
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
 <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 10, 2019 at 12:33:12PM +0100, Linus Torvalds wrote:
> On Tue, Sep 10, 2019 at 5:21 AM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> >
> > The commit b03755ad6f33 (ext4: make __ext4_get_inode_loc plug), [1]
> > which was merged in v5.3-rc1, *always* leads to a blocked boot on my
> > system due to low entropy.
>
> Exactly what is it that blocks on entropy? Nobody should do that
> during boot, because on some systems entropy is really really low
> (think flash memory with polling IO etc).
>

Ok, I've tracked it down further. It's unfortunately GDM
intentionally blocking on a getrandom(buf, 16, 0).

Booting the system with an straced GDM service
("ExecStart=strace -f /usr/bin/gdm") reveals:

  ...
  [  3.779375] strace[262]: [pid   323] execve("/usr/lib/gnome-session-binary",
                                                 ... /* 28 vars */) = 0
  ...
  [  4.019227] strace[262]: [pid   323] getrandom( <unfinished ...>
  [ 79.601433] kernel: random: crng init done
  [ 79.601443] kernel: random: 3 urandom warning(s) missed due to ratelimiting
  [ 79.601262] strace[262]: [pid   323] <... getrandom resumed>..., 16, 0) = 16
  [ 79.601262] strace[262]: [pid   323] getrandom(..., 16, 0) = 16
  [ 79.603041] strace[262]: [pid   323] getrandom(..., 16, 0) = 16
  [ 79.603041] strace[262]: [pid   323] getrandom(..., 16, 0) = 16
  [ 79.603041] strace[262]: [pid   323] getrandom(..., 16, 0) = 16

As can be seen in the timestamps, the GDM boot was only continued
by typing randomly on the keyboard..

> That said, I would have expected that any PC gets plenty of entropy.
> Are you sure it's entropy that is blocking, and not perhaps some odd
> "forgot to unplug" situation?
>

Yes, doing any of below steps makes the problem reliably disappear:

  - boot param "random.trust_cpu=on"
  - rngd(8) enabled at boot (entropy source: x86 RDRAND + jitter)
  - pressing random 3 or 4 keyboard keys while GDM boot is stuck

> > Can this even be considered a user-space breakage? I'm honestly not
> > sure. On my modern RDRAND-capable x86, just running rng-tools rngd(8)
> > early-on fixes the problem. I'm not sure about the status of older
> > CPUs though.
>
> It's definitely breakage, although rather odd. I would have expected
> us to have other sources of entropy than just the disk. Did we stop
> doing low bits of TSC from timer interrupts etc?
>

Exactly.

While gnome-session is obviously at fault here by requiring
*blocking* randomness at the boot path, it's still not requesting
much, just (5 * 16) bytes to be exact.

I guess an x86 laptop should be able to provide that, even without
RDRAND / random.trust_cpu=on (TSC jitter, etc.) ?

thanks,
--darwi

> Ted, either way - ext4 IO patterns or random number entropy - this is
> your code. Comments?
>
>                  Linus
