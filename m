Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F47B02C2
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Sep 2019 19:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfIKRgs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 13:36:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52259 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729349AbfIKRgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Sep 2019 13:36:48 -0400
Received: from callcc.thunk.org (38.85.69.148.rev.vodafone.pt [148.69.85.38] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8BHaOjG004821
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 13:36:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 37C7442049E; Wed, 11 Sep 2019 13:36:24 -0400 (EDT)
Date:   Wed, 11 Sep 2019 13:36:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190911173624.GI2740@mit.edu>
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
 <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 11, 2019 at 06:00:19PM +0100, Linus Torvalds wrote:
>     [    0.231255] random: get_random_bytes called from
> start_kernel+0x323/0x4f5 with crng_init=0
> 
> and that's this code:
> 
>         add_latent_entropy();
>         add_device_randomness(command_line, strlen(command_line));
>         boot_init_stack_canary();
> 
> in particular, it's the boot_init_stack_canary() thing that asks for a
> random number for the canary.
> 
> I don't actually see the 'crng init done' until much much later:
> 
>     [   21.741125] random: crng init done

Yes, that's super early in the boot sequence.  IIRC the stack canary
gets reinitialized later (or maybe it was only for the other CPU's in
SMP mode; I don't recall the details of the top of my head).

I think this one always fails, and perhaps we should have a way of
suppressing it --- but that's correct the in-kernel interface doesn't
block.

The /dev/urandom device doesn't block either, despite security
eggheads continually asking me to change it to block ala getrandom(2),
but I have always pushed because because I *know* changing
/dev/urandom to block would be asking for userspace regressions.

The compromise we came up with was that since getrandom(2) is a new
interface, we could make this have the behavior that the security
heads wanted, which is to make blocking unconditional, since the
theory was that *this* interface would be sane, and that userspace
applications which used it too early was buggy, and we could make it
*their* problem.

People have suggested adding a new getrandom flag, GRND_I_KNOW_THIS_IS_INSECURE,
or some such, which wouldn't block and would return "best efforts"
randomness.  I haven't been super enthusiastic about such a flag
because I *know* it would be insecure.   However, the next time a massive
security bug shows up on the front pages of the Wall Street Journal,
or on some web site such as https://factorable.net, it won't be the kernel's fault
since the flag will be GRND_INSECURE_BROKEN_APPLICATION, or some such.
It doesn't really solve the problem, though.

> But this does show that
> 
>  (a) we have the same issue in the kernel, and we don't block there

Ultimately, I think the only right answer is to make it the
bootloader's responsibility to get us some decent entropy at boot
time.  There are patches to allow ARM systems to pass in entropy via
the device tree.  And in theory (assuming you trust the UEFI BIOS ---
stop laughing in the back!) we can use that get entropy which will
solve the problem for UEFI boot systems.  I've been talking to Ron
Minnich about trying to get this support into the NERF bootloader, at
which point new servers from the Open Compute Project will have a
solution as well.  (We can probably also get solutions for Chrome OS
devices, since those have TPM-like which are trusted to have a
comptently engineered hardware RNG --- I'm not sure I would trust all
TPM devices in commodity hardware, but again, at least we can shift
blame off of the kernel.  :-P)

Still, these are all point solutions, and don't really solve the
problem on older systems, or non-x86 systems.

>  (b) initializing the crng really can be a timing problem
> 
> The interrupt thing is only going to get worse as disks turn into
> ssd's and some of them end up using polling rather than interrupts..
> So we're likely to see _fewer_ interrupts in the future, not more.

Yeah, agreed.  Maybe we should have an "insecure_randomness" boot
option which blindly forces the CRNG to be initialized at boot, so
that at least people can get to a command line, if insecurely?  I
don't have any good ideas about how to solve this problem in general.
:-( :-( :-(

						- Ted
