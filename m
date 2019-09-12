Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D833B073D
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2019 05:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfILDoc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 23:44:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41636 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfILDoc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Sep 2019 23:44:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so25758188wrw.8;
        Wed, 11 Sep 2019 20:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxEduo3QQvSGLEoFEsaFldsjgnTEowZk6PXnbKh1zXI=;
        b=qQD13WDNkrvxUnvOrfIfH4gWDpfu3RiWAWXW8OSyANhMcVdYHRdAiwoL2bvQTrvzV2
         MYY3EeCsjZl4ISCWLUk+KogXS8TwCiotJ1hBNdoCjSYlUkyVOtlaTkYE695aj0YrSOO9
         /fIwM4avsbtSLxV2wevvTUC91m+FHj22/KcYWeDRjuFBjcWI4T7CC+DF2cLAgA3ILPPY
         Ymgm5nC57BnzmvvPd7yAsXKoO1eVRNTKmDM9jHNMJidUnNuKNRzFFON1elDcpmmcDVqE
         Qxyeg2qlZHq5bosDearJ4BOrAkuwHuU/doPPgmWxRV1LTsN9Omamyty0KGmDUsICQkkU
         68HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxEduo3QQvSGLEoFEsaFldsjgnTEowZk6PXnbKh1zXI=;
        b=GxMpVyZ/Zvh8W0SgE3rrarAEfZD8Ss7b1oyCeKcKqRSP6ETbJFUOkWtQ0IJF/rRodf
         LEpim5PQq6r/P5DfgAcrYmIw+//cgk0smxGhJL+dYFZ861RghqkXazNHiyZKbW9Nh3AT
         wrlUXBH7lib3hhu+jdTE3/xlbbTgpMFkEP7XsuwiKvyTcw+RylrGe3RQ4INASSjXiijW
         l8TOXZ+qNA/m/ccIDOV1Jf+ttg/RsRSXqWeZpfFIjgBkCagw+5Ueb6vEKKOPxo7YVoCG
         z+1MXIF6VyYCKtFHWxwTDPgwZkVdLVI2L0t2NwCCeG+dAKMJTJe95aVE1EI7u+LDRF3x
         Uukw==
X-Gm-Message-State: APjAAAUCRARwN2OlGHpjz67Bx+1eZJi5vcNhv0me/ElPWtPDYBdEzuvS
        g4utP98CePZP51MNsyDnj40=
X-Google-Smtp-Source: APXvYqwR6oJongllr5UVCdlEIPZpLImYxiWMvoml6B/prU8jL9s9gYY56Fa954EsuaNkGh6X5NQHYw==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr2277959wrx.91.1568259869077;
        Wed, 11 Sep 2019 20:44:29 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D14CBD4495B592C99C920.dip0.t-ipconnect.de. [2003:d0:6f2d:14cb:d449:5b59:2c99:c920])
        by smtp.gmail.com with ESMTPSA id a15sm3756697wmj.25.2019.09.11.20.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 20:44:28 -0700 (PDT)
Date:   Thu, 12 Sep 2019 05:44:21 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190912034421.GA2085@darwi-home-pc>
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
 <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911173624.GI2740@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Wed, Sep 11, 2019 at 01:36:24PM -0400, Theodore Y. Ts'o wrote:
> On Wed, Sep 11, 2019 at 06:00:19PM +0100, Linus Torvalds wrote:
> >     [    0.231255] random: get_random_bytes called from
> > start_kernel+0x323/0x4f5 with crng_init=0
> >
> > and that's this code:
> >
> >         add_latent_entropy();
> >         add_device_randomness(command_line, strlen(command_line));
> >         boot_init_stack_canary();
> >
> > in particular, it's the boot_init_stack_canary() thing that asks for a
> > random number for the canary.
> >
> > I don't actually see the 'crng init done' until much much later:
> >
> >     [   21.741125] random: crng init done
>
> Yes, that's super early in the boot sequence.  IIRC the stack canary
> gets reinitialized later (or maybe it was only for the other CPU's in
> SMP mode; I don't recall the details of the top of my head).
>
> I think this one always fails, and perhaps we should have a way of
> suppressing it --- but that's correct the in-kernel interface doesn't
> block.
>
> The /dev/urandom device doesn't block either, despite security
> eggheads continually asking me to change it to block ala getrandom(2),
> but I have always pushed because because I *know* changing
> /dev/urandom to block would be asking for userspace regressions.
>
> The compromise we came up with was that since getrandom(2) is a new
> interface, we could make this have the behavior that the security
> heads wanted, which is to make blocking unconditional, since the
> theory was that *this* interface would be sane, and that userspace
> applications which used it too early was buggy, and we could make it
> *their* problem.
>

Hmmmm, IMHO it's almost impossible to define "too early" here... Does
it mean applications in the critical boot path? Does gnome-session =>
libICE => libbsd => getentropy() => getrandom() => generated MIT magic
cookie count as being too early? It's very hazy...

getrandom(2) basically has no guaranteed upper bound for the waiting
time. And in the report I submitted in the parent thread, the upper
bound is really "infinitely locked"...

Here is a trace_printk() log of all the getrandom() calls done from
system boot:

    systemd-random--179   2.510228: getrandom(512 bytes, flags = 1)
    systemd-random--179   2.510239: getrandom(512 bytes, flags = 0)
            polkitd-294   3.903699: getrandom(8 bytes, flags = 1)
            polkitd-294   3.904191: getrandom(8 bytes, flags = 1)

                          ... + 45 similar instances

    gnome-session-b-327   4.400620: getrandom(16 bytes, flags = 0)

                          ... boot blocks here, until
                              pressing some keys

    gnome-session-b-327   49.32140: getrandom(16 bytes, flags = 0)

                          ... + 3 similar instances

        gnome-shell-335   49.553594: getrandom(8 bytes, flags = 1)
        gnome-shell-335   49.553600: getrandom(8 bytes, flags = 1)

                          ... + 10 similar instances

           Xwayland-345   50.129401: getrandom(8 bytes, flags = 1)
           Xwayland-345   50.129491: getrandom(8 bytes, flags = 1)

                          ... + 9 similar instances

        gnome-shell-335   50.487543: getrandom(8 bytes, flags = 1)
        gnome-shell-335   50.487550: getrandom(8 bytes, flags = 1)

                          ... + 79 similar instances

      gsd-xsettings-390   51.431638: getrandom(8 bytes, flags = 1)
      gsd-clipboard-389   51.432693: getrandom(8 bytes, flags = 1)
      gsd-xsettings-390   51.433899: getrandom(8 bytes, flags = 1)
      gsd-smartcard-388   51.433924: getrandom(110 bytes, flags = 0)
      gsd-smartcard-388   51.433936: getrandom(256 bytes, flags = 0)

                          ... + 3 similar instances

And it goes on, including processes like gsd-power-, gsd-xsettings-,
gsd-clipboard-, gsd-print-notif, gsd-clipboard-, gsd-color,
gst-keyboard-, etc.

What's the boundary of "too early" here? It's kinda undefinable..

> People have suggested adding a new getrandom flag, GRND_I_KNOW_THIS_IS_INSECURE,
> or some such, which wouldn't block and would return "best efforts"
> randomness.  I haven't been super enthusiastic about such a flag
> because I *know* it would be insecure.   However, the next time a massive
> security bug shows up on the front pages of the Wall Street Journal,
> or on some web site such as https://factorable.net, it won't be the kernel's fault
> since the flag will be GRND_INSECURE_BROKEN_APPLICATION, or some such.
> It doesn't really solve the problem, though.
>

At least for generating the MIT cookie, it would make some sort of
sense... Really caring about truly random-numbers while using Xorg
is almost like perfecting a hard-metal door for the paper house ;)

(Jokes aside, I understand that this cannot be the solution)

> > But this does show that
> >
> >  (a) we have the same issue in the kernel, and we don't block there
>
> Ultimately, I think the only right answer is to make it the
> bootloader's responsibility to get us some decent entropy at boot
> time.

Just 8 days ago, systemd v243 was released, with systemd-random-seed(8)
now supporting *crediting* the entropy while loading the random seed:

    https://systemd.io/RANDOM_SEEDS

systemd-random-seed do something similar to what OpenBSD does, by
preserving the seed across reboots at /var/lib/systemd/random-seed.

This is not enabled by default though. Will distributions enable it by
default in the future? I have no idea \_(.)_/

> There are patches to allow ARM systems to pass in entropy via
> the device tree.  And in theory (assuming you trust the UEFI BIOS ---
> stop laughing in the back!) we can use that get entropy which will
> solve the problem for UEFI boot systems.

Hmmmm ...

> I've been talking to Ron
> Minnich about trying to get this support into the NERF bootloader, at
> which point new servers from the Open Compute Project will have a
> solution as well.  (We can probably also get solutions for Chrome OS
> devices, since those have TPM-like which are trusted to have a
> comptently engineered hardware RNG --- I'm not sure I would trust all
> TPM devices in commodity hardware, but again, at least we can shift
> blame off of the kernel.  :-P)
>
> Still, these are all point solutions, and don't really solve the
> problem on older systems, or non-x86 systems.
>

For non-x86 _embedded_ systems at least, usually the BSP provider
enables the necessary hwrng driver in question and credit its entropy;
e.g. 62f95ae805fa (hwrng: omap - Set default quality).

> >  (b) initializing the crng really can be a timing problem
> >
> > The interrupt thing is only going to get worse as disks turn into
> > ssd's and some of them end up using polling rather than interrupts..
> > So we're likely to see _fewer_ interrupts in the future, not more.
>
> Yeah, agreed.  Maybe we should have an "insecure_randomness" boot
> option which blindly forces the CRNG to be initialized at boot, so
> that at least people can get to a command line, if insecurely?  I
> don't have any good ideas about how to solve this problem in general.
> :-( :-( :-(
>
> 						- Ted

Yeah, this is a hard engineering problem. You've earlier summarized it
perfectly here:

    https://lore.kernel.org/r/20180514003034.GI14763@thunk.org

I guess, to summarize earlier e-mails, a nice path would be:

    1. Cutting down the number of bits needed to initialize the CRNG
       to 256 bits (CHACHA20 cipher)

    2. Complaining loudly when getrandom() is used while the CRNG is
       not yet initialized.

    3. Hopefully #2 will force distributions to act: either trusting
       RDRANDOM when it's sane, configuring systmed-random-seed(8) to
       credit the entropy by default, etc.

Thanks!

--
darwi
http://darwish.chasingpointers.com
