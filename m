Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3619F12BB90
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 23:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfL0WKM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 17:10:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51298 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725306AbfL0WKL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Dec 2019 17:10:11 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBRM8vac001407
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Dec 2019 17:08:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 75080420485; Fri, 27 Dec 2019 17:08:57 -0500 (EST)
Date:   Fri, 27 Dec 2019 17:08:57 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] Rework random blocking
Message-ID: <20191227220857.GD70060@mit.edu>
References: <20191226140423.GB3158@mit.edu>
 <4048434.Q8HajmOrkZ@tauon.chronox.de>
 <20191227130436.GC70060@mit.edu>
 <15817620.rmTN4T87Wr@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15817620.rmTN4T87Wr@tauon.chronox.de>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 27, 2019 at 10:22:23PM +0100, Stephan Mueller wrote:
> 
> I am unsure but it sounds like you are refuting your blocking_pool 
> implementation. Nothing more and nothing less than the blocking_pool, just 
> with a more modern and further analyzed DRNG is what was referenced as a TRNG.

Yes, and that's why I am planning on taking Andy's patches to drop the
blocking pool.  Trying to make the claim that you can read one byte
from /dev/random if and only if one byte of entropy has flowed into
it.... is a mug's game, for the reasons I gave above.

> Or maybe the terminology of TRNG (i.e. "true") is offending. I have no concern 
> to have it replaced with some other terminology. Yet, I was just taking one 
> well-defined term.

But my point is that it *isn't* a well defined term, precisely because
it's completely unclear what application programmer can expect when
they try to use some hypothetical GRANDOM_TRUERANDOM flag.  What does
that *mean*?  The kernel can't offer up any guarantees about whether
or not the noise source has been appropriately characterized.  All
say, a GPG or OpenSSL developer can do is get the vague sense that
TRUERANDOM is "better" and of course, they want the best security, so
of *course* they are going to try to use it.  At which point it will
block, and when some other clever user (maybe a distro release
engineer) puts it into an init script, then systems will stop working
and users will complain to Linus.

And then we'll have companies like Intel claiming that RDSEED has been
very carefully characterized --- by them --- and we should *obviously*
trust it, and wire up RDSEED so that TRUERANDOM will have a near
infinite supply of really good entropy.  And they might even be
correct.  But this way lies a huge mess which is fundamentally social,
not technical.

The claim we can make for getrandom(2) is that we do the best job that
we can, and we feed in as many sources as possible and hope that at
least one or more sources is not known to the attacker.  One of the
sources could very well be AES(NSA_KEY, SEQ++).  But that still will
protect us from the Chinese and Russian crypto teams.  And we can hope
that the NSA doesn't have access to the inter-packet arrival times on
the local area network, or the radio strength as recorded from the
WiFi radio, etc. etc.  But note that we didn't make any claims of how
many bits of entropy that we have; it helps that we are implicitly
making a claim that we trust the crypto algorithms.   

> > So let's take a step back and ask the question: "Exactly what _value_
> > do you want to provide by creating some kind of true random
> > interface?"  What does this enable?  What applications does this
> > really help?
> 
> There are simply cryptographers who have use cases for such random numbers. 
> The core use case is to seed other DRNGs and avoiding the chaining of free-
> running DRNGs.

For this very specialized use case, what I think the kernel should
provide is maximal transparency; that is, given the DRBG direct access
to the TPM's random number generator, or direct access to the
ChaosKey, and the userspace DRBG should be able to get a list of the
various hardware RNG's, and select one, with the characterization
being done userspace, not in the kernel.

The kernel shouldn't be mixing various noise sources together, and it
certainly shouldn't be trying to claim that it knows how many bits of
entropy that it gets when is trying to play some jitter entropy game
on a stupid-simple CPU architecture for IOT/Embedded user cases where
everything is synchronized off of a single master oscillator, and
there is no CPU instruction reordering or register renaming, etc.,
etc.

You can talk about providing tools that try to make these estimations
--- but these sorts of things would have to be done on each user's
hardware, and for most distro users, it's just not practical.

So if it's just for cryptographers, then let it all be done in
userspace, and let's not make it easy for GPG, OpenSSL, etc., to all
say, "We want TrueRandom(tm); we won't settle for less".  We can talk
about how do we provide the interfaces so that those cryptographers
can get the information they need so they can get access to the raw
noise sources, separated out and named, and with possibly some way
that the noise source can authenticate itself to the Cryptographer's
userspace library/application.

But all of this should probably not be in drivers/char/random.c, and
we probably need to figure out a better kernel to userspace interface
than what we have with /dev/hwrng.

					- Ted
