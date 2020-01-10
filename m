Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64D1136896
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2020 08:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgAJHym (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Jan 2020 02:54:42 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:27725 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgAJHym (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Jan 2020 02:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578642879;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=d9JrHFY1UkMhvfJGn6qk0SYl17Rv3ChmBENr96iZE38=;
        b=s9RRt/QZ/SAqsApT14JzWW4LDTgUp7gO6hsP90nUJcsJTP8I749xpwNPiRgFy0UUuG
        2JBtYnj0VI9HFivCjLrMDSKkTS2TVkR7T3u6hhet3layTN5l6p8HD2pm0mdoAnjBxYjY
        NB4GgYzxscd1hInCzBX9ED0hUPANPo/yLbU/4OVTL+I8lAT83MRlOovM8ltgtK4fBlxc
        x5yITH3PONY9MKuBZoXUOmTAbUR1sBPh0JQxPu0AFQ8cYTAN9g4+tfAOc47XvI0t+g+0
        t1MjLD5dz0hCaDb0lqCpQVwptGgSWSfgj1uI3eRYY35htK/3NTTYLNPr4L1EZFcy5Ea1
        BoiA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHivh"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w0A7rs7kX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 10 Jan 2020 08:53:54 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Kurt Roeckx <kurt@roeckx.be>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
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
Date:   Fri, 10 Jan 2020 08:53:54 +0100
Message-ID: <7629501.YrHEAiJyVJ@tauon.chronox.de>
In-Reply-To: <20200109230237.GA2992@roeckx.be>
References: <20191226140423.GB3158@mit.edu> <20200109224011.GD41242@mit.edu> <20200109230237.GA2992@roeckx.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Am Freitag, 10. Januar 2020, 00:02:37 CET schrieb Kurt Roeckx:

Hi Kurt,

> On Thu, Jan 09, 2020 at 05:40:11PM -0500, Theodore Y. Ts'o wrote:
> > On Thu, Jan 09, 2020 at 11:02:30PM +0100, Kurt Roeckx wrote:
> > > One thing the NIST DRBGs have is prediction resistance, which is
> > > done by reseeding. If you chain DRBGs, you tell your parent DRBG
> > > that you want prediction resistance, so your parent will also
> > > reseed. There currently is no way to tell the kernel to reseed.
> > 
> > It would be simple enough to add a new flag, perhaps GRND_RESEED, to
> > getrandom() which requests that the kernel reseed first.  This would
> > require sufficient amounts of entropy in the input pool to do the
> > reseed; if there is not enough, the getrandom() call would block until
> > there was enough.  If GRND_NONBLOCK is supplied, then getrandom()
> > would return EAGAIN if there wasn't sufficient entropy.
> > 
> > Is this what you want?
> 
> I think some people might want to see it, but I think you
> shouldn't add it.

Just for your information: I played with that already as seen in [1] which 
does not require any kernel change.

The only issue that is currently there are the two races noted in [1]. These 
races seem to be only addressable when the reseeding and the gathering of 
random numbers are atomic. I was toying with the idea that the RNDRESEEDCRNG 
allows the user to specify an output buffer which would be filled in an atomic 
operation when the reseed is invoked. That buffer should only be at most in 
size of the security strength of the DRNG.

[1] https://github.com/smuellerDD/lrng/blob/master/test/syscall_test.c#L101
> 
> > > I don't think we want that. As far as I know, the only reason for
> > > using /dev/random is that /dev/urandom returns data before it
> > > has sufficient entropy.
> > 
> > Is there any objections to just using getrandom(2)?
> 
> It provides the interface we want, so no. But there are still
> people who don't have it for various reasons. OpenSSL actually
> does the system call itself if libc doesn't provider a wrapper for
> it.
> 
> 
> Kurt



Ciao
Stephan


