Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71E812B4C0
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfL0NFw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 08:05:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50541 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbfL0NFw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Dec 2019 08:05:52 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBRD4baO001674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Dec 2019 08:04:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id ACFE1420485; Fri, 27 Dec 2019 08:04:36 -0500 (EST)
Date:   Fri, 27 Dec 2019 08:04:36 -0500
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
Message-ID: <20191227130436.GC70060@mit.edu>
References: <20191226140423.GB3158@mit.edu>
 <26B7EEAE-1166-4B45-9534-E00C5B2767C1@amacapital.net>
 <4048434.Q8HajmOrkZ@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4048434.Q8HajmOrkZ@tauon.chronox.de>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 27, 2019 at 11:29:22AM +0100, Stephan Mueller wrote:
> 
> My definition of TRNG is identical to the German AIS 31 and I guess identical 
> to your definition of a TRNG.
> 
> A TRNG will produce an amount of random data that is equal to the amount of 
> "fresh" entropy that was provided by the noise source. I.e. it should be 
> identical to the blocking_pool behavior.

This begs the question of determining: (a) how much "fresh entropy"
you can actually get from a noise source, (b) at what rate the "fresh
entropy" is arriving, and (c) what assurance(s) you have that the
noise source is actually working correctly.

You can't make those assurances from software alone; it needs to be an
aspect of holistic design of the hardware's design; the supply chain,
and the software.  So if we are going to claime that we have something
like GRND_TRUERANDOM or /dev/trandom, or whatever, it needs to work on
IOT devices running ARM, RISC-V, MIPS, PowerPC, x86.  Some of these
architectures have no instruction reordering and are stupid simple;
some of these hardware platforms may have no high-resolution clock or
cryptographic instructions.

In addition, if you use a hardware device which is USB attached, how
does the kernel know that it really is the device that you think it
is?  The only way you know that a ChaosKey is a ChaosKey is by its USB
vendor and product id --- which can be easily forged by an attacker,
either in the supply chain or delivery path, or who walks up to the
laptop, yanks out the ChaosKey and replaces it with a "PutinKey" or a
"NSAKey".

So creating somethinig which shows up as "true random number
generator" as a generic Linux concept seems to me to be fraught
endeavor, and I'm not at all convince people need it.

> - add a new GRND_TRUERANDOM flag to getrandom(2) which allows access to the 
> TRNG. Andy did not like it because he mentioned that it may be misused since 
> the syscall is unprivileged.

Even if we could solve the "how the hell can the kernel guarantee that
the noise source is legitimate" problem in a general way that works
across all of the architectures, we still have the problem that
everyone thinks they need "the good stuff".

Suppose the system call was privileged and "true randomness" could
only be accessed as root.  What would happen?  Application programmers
would give instructions requiring that their application be installed
as root to be more secure, "because that way you can get access the
_really_ good random numbers".

So let's take a step back and ask the question: "Exactly what _value_
do you want to provide by creating some kind of true random
interface?"  What does this enable?  What applications does this
really help?

As I thought while watching the latest Star Wars movie: Why?  Why?
Whywhywhy?

					- Ted
