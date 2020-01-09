Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6567136354
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 23:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgAIWlc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 17:41:32 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58864 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725807AbgAIWlb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jan 2020 17:41:31 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 009MeBo3011340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Jan 2020 17:40:12 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 57CE24207DF; Thu,  9 Jan 2020 17:40:11 -0500 (EST)
Date:   Thu, 9 Jan 2020 17:40:11 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Kurt Roeckx <kurt@roeckx.be>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
Message-ID: <20200109224011.GD41242@mit.edu>
References: <20191226140423.GB3158@mit.edu>
 <4048434.Q8HajmOrkZ@tauon.chronox.de>
 <20191227130436.GC70060@mit.edu>
 <15817620.rmTN4T87Wr@tauon.chronox.de>
 <20191227220857.GD70060@mit.edu>
 <20200109220230.GA39185@roeckx.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109220230.GA39185@roeckx.be>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 09, 2020 at 11:02:30PM +0100, Kurt Roeckx wrote:
> 
> One thing the NIST DRBGs have is prediction resistance, which is
> done by reseeding. If you chain DRBGs, you tell your parent DRBG
> that you want prediction resistance, so your parent will also
> reseed. There currently is no way to tell the kernel to reseed.

It would be simple enough to add a new flag, perhaps GRND_RESEED, to
getrandom() which requests that the kernel reseed first.  This would
require sufficient amounts of entropy in the input pool to do the
reseed; if there is not enough, the getrandom() call would block until
there was enough.  If GRND_NONBLOCK is supplied, then getrandom()
would return EAGAIN if there wasn't sufficient entropy.

Is this what you want?

What should happen if two racing processes simultaneously call
getrandom(2) with GRND_RESEED?  Do they need to be serialized with a
separate reseed for each one?  Does it matter whether, after the
reseed, some other process calling getrandom(2) manages to get output
from the CRNG before the process requesting the RESEED gets a chance
to use the reseeded CRNG?

This can all be fixed by adding more locking, of course, but then the
crazy people who think that:

      dd if=/dev/random of=/dev/sdb

needs to be able to work at HDD, SSD, or networking line speeds, will
complain that all of this locking has slowed down /dev/[u]random, and
they can't get their hundreds of megabytes/second out of the CRNG....

> I would check my own hardware if such an option was available. I
> think it can be useful to see if the current estimates in the
> kernel are conservative enough or not. But it would require that
> you can know what the entropy source is, like the keyboard or
> harddisk.

Creating such an interface is not high on my priority list.  If
someone wants to send a proposal for such an interface, followed by a
patch, I'm happy to take a look at it.  I am worried about the
potential information leakage that such an interface might provide,
though.  So at the very least, it should be something that can be
disabled via build-time config, and perhaps hidden behind
CONFIG_EXPERIMENTAL.  I really would want to make it clear that it's
only for use by experts who are interesting in tinkering, and not
something which is enabled in a distro kernel.

> I don't think we want that. As far as I know, the only reason for
> using /dev/random is that /dev/urandom returns data before it
> has sufficient entropy.

Is there any objections to just using getrandom(2)?

   	     		   	      - Ted

