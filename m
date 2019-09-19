Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE98B7CEE
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2019 16:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfISOek (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Sep 2019 10:34:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46914 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732082AbfISOej (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Sep 2019 10:34:39 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8JEYRHU016692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Sep 2019 10:34:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6085D420811; Thu, 19 Sep 2019 10:34:27 -0400 (EDT)
Date:   Thu, 19 Sep 2019 10:34:27 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190919143427.GQ6762@mit.edu>
References: <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

(Adding linux-api since this patch proposes an API change; both by
changing the existing behavior, and adding new flags and possibly a
new system call.)

On Wed, Sep 18, 2019 at 04:57:58PM -0700, Linus Torvalds wrote:
> On Wed, Sep 18, 2019 at 2:17 PM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> >
> > Since Linux v3.17, getrandom(2) has been created as a new and more
> > secure interface for pseudorandom data requests.  It attempted to
> > solve three problems, as compared to /dev/urandom:
> 
> I don't think your patch is really _wrong_, but I think it's silly to
> introduce a new system call, when we have 30 bits left in the flags of
> the old one, and the old system call checked them.

The only reason to introduce a new system call is if we were going to
keep the existing behavior of getrandom.  Given that the patch changes
what getrandom(0), I agree there's no point to adding a new system
call.

> There is *one* other small semantic change: The old code did
> urandom_read() which added warnings, but each warning also _reset_ the
> crng_init_cnt. Until it decided not to warn any more, at which point
> it also stops that resetting of crng_init_cnt.
> 
> And that reset of crng_init_cnt, btw, is some cray cray.
> 
> It's basically a "we used up entropy" thing, which is very
> questionable to begin with as the whole discussion has shown, but
> since it stops doing it after 10 cases, it's not even good security
> assuming the "use up entropy" case makes sense in the first place.

It was a bug that it stopped doing it after 10 tries, and there's a
really good reason for it.  Yes, the "using up entropy" thing doesn't
make much sense in the general case.  But we still need some threshold
for deciding whether or not it's been sufficiently initialized such
that we consider the CRNG initialized.

The reason for zeroing it after we expose state is because otherwise
if the pool starts in a known state (the attacker knows the starting
configuration, knows the DMI table that we're mixing into the pool
since that's a constant, etc.), then after we've injected a small
amount of uncertainty in the pool --- say, we started with a single
known state of the pool, and after injecting some randomness, there
are 64 possible states of the pool.  If the attacker can read from
/dev/urandom, the attacker can know which of the 64 possible states of
the pool it's in.  Now suppose we inject more uncertainty, so that
there's another 64 unknown states, and the attacker is able to
constantly read from /dev/urandom in a tight loop; it'll be able to
keep up with the injection of entropy insertion, and so even though
we've injected 256 "bits" of uncertainty, the attacker will still know
the state of the pool.  That's why when we read from the pool, we need
to clear the entropy bits.

This is sometimes called a "state extension attack", and there have
been attacks that have been carried out against RNG's that's don't
protect against it.  What happened is when I added the rate-limiting
to the uninitialized /dev/urandom warning, I accidentally wiped out
the protection.  But it was there for a reason.

> And the new cases are defined to *not* warn. In particular,
> GRND_INSECURE very much does *not* warn about early urandom access
> when crng isn't ready. Because the whole point of that new mode is
> that the user knows it isn't secure.
> 
> So that should make getrandom(GRND_INSECURE) palatable to the systemd
> kind of use that wanted to avoid the pointless kernel warning.

Yes, that's clearly the right thing to do.  I do think we need to
restore the state extension attack protections, though.

> +	/*
> +	 * People are really confused about whether
> +	 * this is secure or insecure. Traditional
> +	 * behavior is secure, but there are users
> +	 * who clearly didn't want that, and just
> +	 * never thought about it.
> +	 */
> +	case 0:
>  		ret = wait_for_random_bytes();
> -		if (unlikely(ret))
> +		if (ret)
>  			return ret;
> +		break;

I'm happy this proposed is not changing the behavior of getrandom(0).
Why not just remap 0 to GRND_EXPLICIT | GRND_WAIT_ENTROPY, though?  It
will have the same effect, and it's make it clear what we're doing.

Later on, when we rip out /dev/random pool code (and make reading from
/dev/random the equivalent of getrandom(GRND_SECURE)), we'll need to
similarly map the legacy combination of flags for GRND_RANDOM and
GRND_RANDOM | GRND_NONBLOCK.

						- Ted
