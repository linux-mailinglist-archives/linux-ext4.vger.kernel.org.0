Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85790B4D93
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 14:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfIQMNg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 08:13:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45621 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725270AbfIQMNg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 08:13:36 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8HCBvaY011073
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 08:11:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DC55C420811; Tue, 17 Sep 2019 08:11:56 -0400 (EDT)
Date:   Tue, 17 Sep 2019 08:11:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Willy Tarreau <w@1wt.eu>, Matthew Garrett <mjg59@srcf.ucam.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917121156.GC6762@mit.edu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2508489.jOnZlRuxVn@merkaba>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 09:33:40AM +0200, Martin Steigerwald wrote:
> Willy Tarreau - 17.09.19, 07:24:38 CEST:
> > On Mon, Sep 16, 2019 at 06:46:07PM -0700, Matthew Garrett wrote:
> > > >Well, the patch actually made getrandom() return en error too, but
> > > >you seem more interested in the hypotheticals than in arguing
> > > >actualities.> 
> > > If you want to be safe, terminate the process.
> > 
> > This is an interesting approach. At least it will cause bug reports in
> > application using getrandom() in an unreliable way and they will
> > check for other options. Because one of the issues with systems that
> > do not finish to boot is that usually the user doesn't know what
> > process is hanging.
> 

I would be happy with a change which changes getrandom(0) to send a
kill -9 to the process if it is called too early, with a new flag,
getrandom(GRND_BLOCK) which blocks until entropy is available.  That
leaves it up to the application developer to decide what behavior they
want.

Userspace applications which want to do something more sophisticated
could set a timer which will cause getrandom(GRND_BLOCK) to return
with EINTR (or the signal handler could use longjmp; whatever) to
abort and do something else, like calling random_r if it's for some
pathetic use of random numbers like MIT-MAGIC-COOKIE.

> A userspace process could just poll on the kernel by forking a process 
> to use getrandom() and waiting until it does not get terminated anymore. 
> And then it would still hang.

So.... I'm not too worried about that, because if a process is
determined to do something stupid, they can always do something
stupid.

This could potentially be a problem, as would GRND_BLOCK, in that if
an application author decides to use to do something to wait for real
randomness, because in the good judgement of the application author,
it d*mned needs real security because otherwise an attacker could,
say, force a launch of nuclear weapons and cause world war III, and
then some small 3rd-tier distro decides to repurpose that application
for some other use, and puts it in early boot, it's possible that a
user will report it as a "regression", and we'll be back to the
question of whether we revert a performance optimization patch.

There are only two ways out of this mess.  The first option is we take
functionality away from a userspace author who Really Wants A Secure
Random Number Generator.  And there are an awful lot of programs who
really want secure crypto, becuase this is not a hypothetical.  The
result in "Mining your P's and Q's" did happen before.  If we forget
the history, we are doomed to repeat it.

The only other way is that we need to try to get the CRNG initialized
securely in early boot, before we let userspace start.  If we do it
early enough, we can also make the kernel facilities like KASLR and
Stack Canaries more secure.  And this is *doable*, at least for most
common platforms.  We can leverage UEFI; we cn try to use the TPM's
random number generator, etc.  It won't help so much for certain
brain-dead architectures, like MIPS and ARM, but if they are used for
embedded use cases, it will be caught before the product is released
for consumer use.  And this is where blocking is *way* better than a
big fat warning, or sleeping for 15 seconds, both of which can easily
get missed in the embedded case.  If we can fix this for traditional
servers/desktops/laptops, then users won't be complaining to Linus,
and I think we can all be happy.

Regards,

					- Ted
