Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8985112BCEE
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Dec 2019 08:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfL1HBb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Dec 2019 02:01:31 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:29841 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfL1HBb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 28 Dec 2019 02:01:31 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id xBS71BFU002595;
        Sat, 28 Dec 2019 08:01:11 +0100
Date:   Sat, 28 Dec 2019 08:01:11 +0100
From:   Willy Tarreau <w@1wt.eu>
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
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] Rework random blocking
Message-ID: <20191228070111.GB2519@1wt.eu>
References: <20191226140423.GB3158@mit.edu>
 <4048434.Q8HajmOrkZ@tauon.chronox.de>
 <20191227130436.GC70060@mit.edu>
 <15817620.rmTN4T87Wr@tauon.chronox.de>
 <20191227220857.GD70060@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227220857.GD70060@mit.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 27, 2019 at 05:08:57PM -0500, Theodore Y. Ts'o wrote:
> > Or maybe the terminology of TRNG (i.e. "true") is offending. I have no concern 
> > to have it replaced with some other terminology. Yet, I was just taking one 
> > well-defined term.
> 
> But my point is that it *isn't* a well defined term, precisely because
> it's completely unclear what application programmer can expect when
> they try to use some hypothetical GRANDOM_TRUERANDOM flag.  What does
> that *mean*?

I've also seen this term used and abused too many times and this bothers
me because the expectations around it are the cause of the current
situation.

Randomness doesn't exist by itself. It's what characterizes the
unpredictable nature of something. I.e. our inability to model it and
guess what will happen based on what we know. 200 years ago we'd have
considered the weather as a true random source. Now we have super
computers making this moot. In the current state of art we consider
that cesium decay or tunnel noise are unpredictable and excellent
random sources, until one day we figure that magnetic fields,
temperature or gamma rays strongly affect them.

So in practice we should only talk about the complexity of the model we
rely on. The more complex it is (i.e. the most independent variables it
relies on), the less predictable it is and the more random it is. Jitter
entropy and RAM contents are good examples of this: they may be highly
unpredictable on some platforms and almost constant on others. And for
sure, software cannot fix this, it can at best make the output *look*
like it's unpredictable. Once someone can model all variables of the
environment this is not true random anymore.

That's why the best we can do is to combine as many sources as possible
hoping that nobody can model enough of them, and produce an output which
never ever reveals these sources' internal states. *This* is what software
can and must do. And once the initial entropy is hidden enough and there
is enough of it, there's no reason for it to ever get depleted if these
initial bits cannot be guessed nor brute-forced.

And quite frankly I'd rather just speak about the diversity of sources
than "true" randomness. Just asking a user to press 10 random keys and
to enter a random word for some operations can break many assumptions
an attacker could have about the environment, by just adding one extra,
less controllable, source.

Just my two cents,
Willy
