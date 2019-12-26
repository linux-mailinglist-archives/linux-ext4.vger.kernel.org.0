Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0191612ACC2
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 15:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLZOFe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 09:05:34 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36057 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727146AbfLZOFd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 09:05:33 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBQE4NwC001450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Dec 2019 09:04:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7CE45420485; Thu, 26 Dec 2019 09:04:23 -0500 (EST)
Date:   Thu, 26 Dec 2019 09:04:23 -0500
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
Message-ID: <20191226140423.GB3158@mit.edu>
References: <9872655.prSdhymlXK@positron.chronox.de>
 <888017FA-06A1-42EF-9FC0-46629138DA9E@amacapital.net>
 <4820831.xlnk3tY4r2@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4820831.xlnk3tY4r2@tauon.chronox.de>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 26, 2019 at 01:03:34PM +0100, Stephan Mueller wrote:
> Agreed. I was just trying to outline that the removal of the blocking_pool is 
> a good thing. Even when we decide that random.c should receive a TRNG, we do 
> not need to re-add a blocking pool, but can easily use the existing ChaCha20 
> DRNG (most likely with its own instance).

Well, it depends on what you mean by "TRNG" --- the ChaCha20 DRNG only
has a state of 256 bits.  So if you want to only depend on "true
entropy" you can't extract more than 256 bits without violating that
assumption, at least if you're using a very strict definition of TRNG.

By getting rid of the blocking pool, and making /dev/random work like
getrandom with flags set to 0, we're effectively abandoning any kind
of assertion that /dev/random is some kind of TRNG.  This is not
insane; this is what the *BSD's have always done.

But once we do this, and /dev/random takes on the semantics of "block
until the CRNG has been initialized, and then it won't block after
that", if we change it so that it now has some different semantics,
such as "one you extract a 256-bit key, the read from /dev/random will
block until we can refill it, which might take seconds, minutes or
hours", will be considered a regression, and we can't do that.

Of course, we can hope that people will be using getrandom() and there
will be very few new users of the /dev/random pathname.  But nothing
is ever guaranteed..

						- Ted
