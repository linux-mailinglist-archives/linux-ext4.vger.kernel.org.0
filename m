Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D112BB36
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 22:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfL0VXS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 16:23:18 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:33975 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0VXS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Dec 2019 16:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1577481793;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=48HBB2KfXhaTD/qKcyXvjDtuDdQKvhQn4iJRH8czAHc=;
        b=sHNc5GIJcBv1YC7VHqLOoxtLqIcvP+yKhYxHTW0BgzAHPjTfxgf7zwI66IjwpltvSj
        Dx4ffCMv9Hs4ay0lNwSt9h6/CdbylLT8CQqAIV9O6wFBngZrv/RiCAv/Kxuq+NfxdUDC
        Yw4o3AccmU+IUh73JJVxbRnfzN2vMd8X2yxUcUOonS7HuwElEsOLLdrRpcHz7vBRny7I
        tPfga5t/+j9es1w0txBMWLbdMsjnY6UP9Im5zaA0F2cyEXejLxgdCUzxgXEbIjzXcQ5W
        j6o4akOL/1kg6pPWcnTcevgdyRS1Pq0IboJKMjylJCDF+0BMx6XGRUSWharFlbcvsngJ
        SewA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbJ/ScSKV5"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.3 DYNA|AUTH)
        with ESMTPSA id e09841vBRLMNGRC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 27 Dec 2019 22:22:23 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
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
Date:   Fri, 27 Dec 2019 22:22:23 +0100
Message-ID: <15817620.rmTN4T87Wr@tauon.chronox.de>
In-Reply-To: <20191227130436.GC70060@mit.edu>
References: <20191226140423.GB3158@mit.edu> <4048434.Q8HajmOrkZ@tauon.chronox.de> <20191227130436.GC70060@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Am Freitag, 27. Dezember 2019, 14:04:36 CET schrieb Theodore Y. Ts'o:

Hi Theodore,

> On Fri, Dec 27, 2019 at 11:29:22AM +0100, Stephan Mueller wrote:
> > My definition of TRNG is identical to the German AIS 31 and I guess
> > identical to your definition of a TRNG.
> > 
> > A TRNG will produce an amount of random data that is equal to the amount
> > of
> > "fresh" entropy that was provided by the noise source. I.e. it should be
> > identical to the blocking_pool behavior.
> 
> This begs the question of determining: (a) how much "fresh entropy"
> you can actually get from a noise source, (b) at what rate the "fresh
> entropy" is arriving, and (c) what assurance(s) you have that the
> noise source is actually working correctly.
> 
> You can't make those assurances from software alone; it needs to be an
> aspect of holistic design of the hardware's design; the supply chain,
> and the software.  So if we are going to claime that we have something
> like GRND_TRUERANDOM or /dev/trandom, or whatever, it needs to work on
> IOT devices running ARM, RISC-V, MIPS, PowerPC, x86.  Some of these
> architectures have no instruction reordering and are stupid simple;
> some of these hardware platforms may have no high-resolution clock or
> cryptographic instructions.
> 
> In addition, if you use a hardware device which is USB attached, how
> does the kernel know that it really is the device that you think it
> is?  The only way you know that a ChaosKey is a ChaosKey is by its USB
> vendor and product id --- which can be easily forged by an attacker,
> either in the supply chain or delivery path, or who walks up to the
> laptop, yanks out the ChaosKey and replaces it with a "PutinKey" or a
> "NSAKey".
> 
> So creating somethinig which shows up as "true random number
> generator" as a generic Linux concept seems to me to be fraught
> endeavor, and I'm not at all convince people need it.

I am unsure but it sounds like you are refuting your blocking_pool 
implementation. Nothing more and nothing less than the blocking_pool, just 
with a more modern and further analyzed DRNG is what was referenced as a TRNG.

Or maybe the terminology of TRNG (i.e. "true") is offending. I have no concern 
to have it replaced with some other terminology. Yet, I was just taking one 
well-defined term.

Yet, I fully agree that a noise source always must be vetted. This is what I 
tried with random.c in [1], specifically section 6.1 for x86 systems.

For my LRNG, I tried that in [2] section 3.2 compliant to SP800-90B. In order 
to provide a means to everybody to perform such entropy analysis, the entire 
tool set required for it is provided:

- with CONFIG_LRNG_TESTING providing an interface to the raw unconditioned 
noise

- with [3] providing a tool set to gather all data needed for an SP800-90B 
compliant quantitative analysis

Unfortunately due to license restrictions, I cannot make the same tool set 
available used for the quantiative study provided with [1] section 6.1.

Finally, to support the conclusions drawn from a noise source analysis, the 
health tests provided with LRNG compliant to SP800-90B are available with 
CONFIG_LRNG_HEALTH_TESTS. These tests help in identifying weak or broken noise 
sources.

It is fully clear that such studies of non-physical noise sources do not have 
a stochastical model which implies that we cannot make global statements. That 
is the limitation when using such noise sources. Though, the implementation 
should have sufficient "leeway" (i.e. underestmation) when crediting entropy 
to some events.
> 
> > - add a new GRND_TRUERANDOM flag to getrandom(2) which allows access to
> > the
> > TRNG. Andy did not like it because he mentioned that it may be misused
> > since the syscall is unprivileged.
> 
> Even if we could solve the "how the hell can the kernel guarantee that
> the noise source is legitimate" problem in a general way that works
> across all of the architectures, we still have the problem that
> everyone thinks they need "the good stuff".
> 
> Suppose the system call was privileged and "true randomness" could
> only be accessed as root.  What would happen?  Application programmers
> would give instructions requiring that their application be installed
> as root to be more secure, "because that way you can get access the
> _really_ good random numbers".

That is why I think that it is no bug when this interface can DoS other users 
wanting to access the very same resource. This is the price to pay for getting 
access to this type of data.
> 
> So let's take a step back and ask the question: "Exactly what _value_
> do you want to provide by creating some kind of true random
> interface?"  What does this enable?  What applications does this
> really help?

There are simply cryptographers who have use cases for such random numbers. 
The core use case is to seed other DRNGs and avoiding the chaining of free-
running DRNGs.

This is a common approach that you can see in action with the RDSEED 
instruction, for example.
> 
> As I thought while watching the latest Star Wars movie: Why?  Why?
> Whywhywhy?
> 
> 					- Ted

[1] https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/Studies/
LinuxRNG/LinuxRNG_EN.pdf?__blob=publicationFile&v=11

[2] https://chronox.de/lrng/doc/lrng.pdf

[3] https://chronox.de/lrng/lrng-tests-20191123.tar.xz

Ciao
Stephan


