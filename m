Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92C136314
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 23:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAIWKs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 17:10:48 -0500
Received: from excelsior.roeckx.be ([195.234.45.115]:36751 "EHLO
        excelsior.roeckx.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIWKs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jan 2020 17:10:48 -0500
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 17:10:46 EST
Received: from intrepid.roeckx.be (localhost [127.0.0.1])
        by excelsior.roeckx.be (Postfix) with ESMTP id 3842EA8A05A9;
        Thu,  9 Jan 2020 22:02:31 +0000 (UTC)
Received: by intrepid.roeckx.be (Postfix, from userid 1000)
        id EB6ED1FE0C79; Thu,  9 Jan 2020 23:02:30 +0100 (CET)
Date:   Thu, 9 Jan 2020 23:02:30 +0100
From:   Kurt Roeckx <kurt@roeckx.be>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
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
Message-ID: <20200109220230.GA39185@roeckx.be>
References: <20191226140423.GB3158@mit.edu>
 <4048434.Q8HajmOrkZ@tauon.chronox.de>
 <20191227130436.GC70060@mit.edu>
 <15817620.rmTN4T87Wr@tauon.chronox.de>
 <20191227220857.GD70060@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227220857.GD70060@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 27, 2019 at 05:08:57PM -0500, Theodore Y. Ts'o wrote:
> On Fri, Dec 27, 2019 at 10:22:23PM +0100, Stephan Mueller wrote:
> > > So let's take a step back and ask the question: "Exactly what _value_
> > > do you want to provide by creating some kind of true random
> > > interface?"  What does this enable?  What applications does this
> > > really help?
> > 
> > There are simply cryptographers who have use cases for such random numbers. 
> > The core use case is to seed other DRNGs and avoiding the chaining of free-
> > running DRNGs.
> 
> For this very specialized use case, what I think the kernel should
> provide is maximal transparency; that is, given the DRBG direct access
> to the TPM's random number generator, or direct access to the
> ChaosKey, and the userspace DRBG should be able to get a list of the
> various hardware RNG's, and select one, with the characterization
> being done userspace, not in the kernel.

One thing the NIST DRBGs have is prediction resistance, which is
done by reseeding. If you chain DRBGs, you tell your parent DRBG
that you want prediction resistance, so your parent will also
reseed. There currently is no way to tell the kernel to reseed.

This reseed option might be something that some people would like
to see. If such an option is added, I expect that the kernel might
block until it has gotten enough new entropy from it's entropy
sources. But I don't actually see a need to add such an option.

If the kernel provides a good RNG, the only reason I can see why
you would like to have direct access to a hwrng is to verify that
it's working correctly. That might mean that you put it in some
special mode where it returns raw unprocessed values. If the device
is in such a mode, it's output will not provide the same entropy
per bit, and so I would expect the kernel to stop using it directly.

I guess there might be people who would like to use it directly,
but I think we should instead encourage them kernel RNG.

> You can talk about providing tools that try to make these estimations
> --- but these sorts of things would have to be done on each user's
> hardware, and for most distro users, it's just not practical.

I would check my own hardware if such an option was available. I
think it can be useful to see if the current estimates in the
kernel are conservative enough or not. But it would require that
you can know what the entropy source is, like the keyboard or
harddisk.

> So if it's just for cryptographers, then let it all be done in
> userspace, and let's not make it easy for GPG, OpenSSL, etc., to all
> say, "We want TrueRandom(tm); we won't settle for less".

I don't think we want that. As far as I know, the only reason for
using /dev/random is that /dev/urandom returns data before it
has sufficient entropy.


Kurt

