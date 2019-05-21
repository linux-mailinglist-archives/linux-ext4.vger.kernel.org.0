Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00512566B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2019 19:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfEURQa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 May 2019 13:16:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55465 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727898AbfEURQa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 May 2019 13:16:30 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4LHGJuA022351
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 May 2019 13:16:20 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 14474420481; Tue, 21 May 2019 13:16:19 -0400 (EDT)
Date:   Tue, 21 May 2019 13:16:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190521171618.GD2591@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
 <20190517102506.GU4319@dell>
 <20190517202810.GA21961@mit.edu>
 <20190518063834.GX4319@dell>
 <20190518195424.GC14277@mit.edu>
 <20190520082402.GZ4319@dell>
 <20190520153639.GB3933@mit.edu>
 <20190521072553.GA4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521072553.GA4319@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 21, 2019 at 08:25:53AM +0100, Lee Jones wrote:
> A Reviewed-by to me means that a person knows the area, including
> possible side-effects a patch may cause.  In this EXTx case, I do not
> consider myself a domain expert and thus am not in a position to
> provide that level of review.  Instead, the patch was reviewed on its
> own merits, and since it looked good (which it still does), an
> Acked-by was provided.

So that kind of "review", where "I'm not an expert, but it looks good
to me", has very, very little value as far as I'm concerned.  A
computer program can do a "it builds, ship it" test, and checkpatch
can find the whitespace nits.  So what value does a "I can't consider
side-effects" review have?  Again, as a maintainer, I can put very
little (read: zero) reliance on it.

> Exactly, there's that *if* I was talking about.  "IF, a patch affects
> multiple subsystems".  This patch does not.  The Acked by is also not
> coming from a maintainer from this subsystem, thus this statement does
> not come into play.

And my assertion is that if a patch does not affect multiple
subsystems, an Acked-by has close to zero value.  So why do it?  In my
opinion, we should tighten up the documentation to only use it for the
Maintainer reviewing a patch that's not flowing through the
Maintainer's tree.

> > > "at all" - wow!  What kind of message do you think this gives to first
> > > time contributors (like Philippe here), or would-be reviewers?  That
> > > there isn't any point in attempting to review patches, since
> > > Maintainers are unlikely to take it into consideration "at all"?  I
> > > know that when I come to review a patch, if *any* contributor has
> > > taken the time to review a patch, it always plays an important role.
> > 
> > So if I'm going to have to do a full review (which you approve), that
> > by definition means I'm not relying on the review at all, right?
> 
> Your review should not replace and over-ride another review (unless
> you disagree with it, obviously), it should compliment it.  Both *-bys
> should be added to the patch when/if it is applied.

We're using "reviewed" in two different ways.  I'm talking about an
empty "reviewed-by" or "acked-by", for which if it's an developer
unknown to me, I have no way of telling how much time they spent on
the review.  Was it 5 seconds?  Or 5 minutes?  Or something in
between?

You're saying that if someone sends a "Reviewed-by" or "Acked-by", I
*must* never drop it, even if I have no idea how much value it has
(and therefore, as far as I'm concerned, it has no value).  Sorry, I'm
not going to play things that way.  Feel free to call me bad if you
want, it's not going to change how I do things.

Worse, what value does it add if we record it for all posterity?  What
should someone who is reviewing the git log after the fact, perhaps a
year later, take from the fact that there is an unknowned Reviewed-By
or Acked-By attached to the commit?  Do you think someone reviewing a
commit year later will spend time crawling over the git history to
determine how many reviews someone has done?

(And if all maintainer's add empty Reviewed-by to their commit,
looking at Git histories might not tell you much anyway.  It cheapens
the Reviewed-by and Acked-by headers.  I consider part of the
maintianer's job to curate not just patches, but Reviewed-By and
Acked-by headers.)

And BTW, if the maintainer is using a non-rewinding git tree, and the
git has already been published on git.kernel.org, it's physically not
*possible* for them to add a late Reviewed-by, or Acked-by.  And I
think that's perfectly justifiable, since if the decision has already
been made to accept the commit, the Reviewed-By or Acked-By has no
value to the project.

> > So my personal approach is to not include Reviewed-by or
> > Acked-by if it didn't add any value to the project.
> 
> That's wrong of you.  I do not support this behaviour at all.  If
> someone has gone to the trouble to review a patch and provide a
> suitable *-by, you, as the maintainer have a duty to credit this work
> by applying it to the patch (if accepted).

But I don't *know* that someone has gone to the trouble to review a
patch.  If they made any kind of comment (positive or negative, or
evaluating tradeoffs), then I have some kind of signal about how much
time they spent reviewing the patch, and how much comprehension they
have about the patch.  This is why my metric is "value to the
subsystem / value to the project as a whole".

You yourself have asked me to count the number of Reviewed-by you have
as a sign of your technical ability.  Would you then want to make sure
that that signal isn't cheapened?

> That policy is crazy.  You are saying that people should only be
> providing negative reviews?  So what happens if someone conducts a
> review and they cannot find anything wrong with the submission?  You
> are suggesting that you are not going to apply their tag anyway, so
> what would be the point in them providing one?  You are essentially
> saying that unless they have previously given a patch a NACK, then
> don't bother to provide an ACK.  Bonkers!

It's a question of developer history.  Not just of a particular patch,
but their reviewer history as a whole.  If Jan Kara or Andreas Dilger
or Lukas Czerner sends me a empty Reviewed-By, it has great weight,
because they've found issues with other patches in the past, and we've
had design discussions about what is the right way to fix a particular
issue.  But for a someone with whom I've never interacted before, and
all I get is a drive-by, empty Acked-by?  No, it's not going to get
included by me.  Sorry.

					- Ted
