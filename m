Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFADB0A43
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2019 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfILI0D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Sep 2019 04:26:03 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43235 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbfILI0D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Sep 2019 04:26:03 -0400
Received: from callcc.thunk.org (38.85.69.148.rev.vodafone.pt [148.69.85.38] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8C8PVKg015863
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 04:25:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A129142049E; Thu, 12 Sep 2019 04:25:30 -0400 (EDT)
Date:   Thu, 12 Sep 2019 04:25:30 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190912082530.GA27365@mit.edu>
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
 <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912034421.GA2085@darwi-home-pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 12, 2019 at 05:44:21AM +0200, Ahmed S. Darwish wrote:
> > People have suggested adding a new getrandom flag, GRND_I_KNOW_THIS_IS_INSECURE,
> > or some such, which wouldn't block and would return "best efforts"
> > randomness.  I haven't been super enthusiastic about such a flag
> > because I *know* it would be abused.   However, the next time a massive
> > security bug shows up on the front pages of the Wall Street Journal,
> > or on some web site such as https://factorable.net, it won't be the kernel's fault
> > since the flag will be GRND_INSECURE_BROKEN_APPLICATION, or some such.
> > It doesn't really solve the problem, though.

Hmm, one thought might be GRND_FAILSAFE, which will wait up to two
minutes before returning "best efforts" randomness and issuing a huge
massive warning if it is triggered?

> At least for generating the MIT cookie, it would make some sort of
> sense... Really caring about truly random-numbers while using Xorg
> is almost like perfecting a hard-metal door for the paper house ;)

For the MIT Magic Cookie, it might as well use GRND_NONBLOCK, and if
it fails due to randomness being not available, it should just fall
back to random_r(3).  Or heck, just use random_r(3) all the time,
since it's not at all secure anyway....

> Just 8 days ago, systemd v243 was released, with systemd-random-seed(8)
> now supporting *crediting* the entropy while loading the random seed:
> 
>     https://systemd.io/RANDOM_SEEDS
> 
> systemd-random-seed do something similar to what OpenBSD does, by
> preserving the seed across reboots at /var/lib/systemd/random-seed.

That makes it systemd's responsibility to properly manage the random
seed file, and if the random seed file gets imaged, or if it gets read
while the system is off, that's on systemd....   which is fine.

The real problem here is that we're trying to engineer a system which
makes it safe for real cryptographic systems, but there's no way to
distinguish between real cryptographic systems where proper entropy is
critical and pretend security systems like X.org's MIT Magic Cookie
--- or python trying to get random numbers seeding its dictionary hash
tables to avoid DOS attacks when python is used for CGI scripts ---
but guess what happens when python is used for systemd generator
scripts in early boot.... before the random seed file might even be
mounted?  In that case, python reverted to using /dev/urandom, which
was probably the right choice --- it didn't *need* to use getrandom.

>     1. Cutting down the number of bits needed to initialize the CRNG
>        to 256 bits (CHACHA20 cipher)

Does the attach patch (see below) help?

>     2. Complaining loudly when getrandom() is used while the CRNG is
>        not yet initialized.

A kernel printk will make it easier for people to understand why their
system is hung, in any case --- and which process is to blame.  So
that's definitely a good thing.

						- Ted

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..b9b3a5a82abf 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -500,7 +500,7 @@ static int crng_init = 0;
 #define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
 static unsigned long crng_global_init_time = 0;
-#define CRNG_INIT_CNT_THRESH (2*CHACHA_KEY_SIZE)
+#define CRNG_INIT_CNT_THRESH	CHACHA_KEY_SIZE
 static void _extract_crng(struct crng_state *crng, __u8 out[CHACHA_BLOCK_SIZE]);
 static void _crng_backtrack_protect(struct crng_state *crng,
 				    __u8 tmp[CHACHA_BLOCK_SIZE], int used);
