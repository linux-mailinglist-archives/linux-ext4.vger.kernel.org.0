Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58ABF25E57
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2019 08:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfEVG7g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 May 2019 02:59:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55102 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfEVG7f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 May 2019 02:59:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so940697wml.4
        for <linux-ext4@vger.kernel.org>; Tue, 21 May 2019 23:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SmnPka2en7hn0xWeNXjh5rsr8dYH56lkpZolyGEOgME=;
        b=HXiiBTsRCnheoMCkMuJ+SYvOt3mpaCyTV2VNyfJrkBeWspmavpfmSRnq4jNO/4tS/a
         I5NfSo+nNDec0zO/taMM7vCw4t3AaCVOCp1S8He7h2E69+cWygHdRPAaoc7nbs61xh3B
         bAnclvxEyfJ1yeAkehNsS5yEbSmOC4s9pssi3xpzmIWDGeEWY+cjo9u1egA9aZT8lsn5
         9ONYcNXBjqyne60+ULg8rqcBWU1Kusvpt7T361pEFUVqE7KPapgumwsPByXZgc3/qxPh
         a9CH1kaclbvWz5tmwGIo4Yg4rv9/JzMzazio7DJbNxLw8cFD/CpFlRxV68IpXBW9tB1U
         CZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SmnPka2en7hn0xWeNXjh5rsr8dYH56lkpZolyGEOgME=;
        b=iKtRr4ThmHc22pU5ism1orHrx85EBERJVfKYnHlPul4zVupgt6xgrWdHrtzCRjQrM+
         hHRPhVkFhWkzDRWiP1f6mQ5EnKPRHzj9lNHDUtabdHElS7Wbq+9sQtxkz+jqj9AsYmp8
         qVy+PICqnQFpYhvCjtPEYTcxPDzPWUP+D6gmkK+eBDy1z/XglSKHhd5DjMW7kC7FQEcB
         KMJIFMw46nu4OXZVOeBB29pr1+ThLbMGO7yPHbu2H/731ByDwWvF9wx5oskoTlXxdDTE
         Zf/pPyLgc2uRmHLUDkNVm7RwVzYory3pYsUK6hZePZrNtqtPFDSbpB6Coi/8EZjnjDoH
         yEFA==
X-Gm-Message-State: APjAAAX34IvHpgF3J0tPVlhJNYH8441anLDmoXnTy32CfbBK1wF4odc5
        E7KaOCtZQJ5EfYLiY9Q+DrGGkw==
X-Google-Smtp-Source: APXvYqw/qZyAtX2Sw/Hw59CqZTyuXs0vNCQ8gbsNN1udb3Uw+OzaZRmZoC8wjZQ8vKkK21be2YtpQA==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr6251210wmg.121.1558508371887;
        Tue, 21 May 2019 23:59:31 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id f10sm33621727wrg.24.2019.05.21.23.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 23:59:31 -0700 (PDT)
Date:   Wed, 22 May 2019 07:59:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190522065929.GE4574@dell>
References: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
 <20190517102506.GU4319@dell>
 <20190517202810.GA21961@mit.edu>
 <20190518063834.GX4319@dell>
 <20190518195424.GC14277@mit.edu>
 <20190520082402.GZ4319@dell>
 <20190520153639.GB3933@mit.edu>
 <20190521072553.GA4319@dell>
 <20190521171618.GD2591@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521171618.GD2591@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 21 May 2019, Theodore Ts'o wrote:

> On Tue, May 21, 2019 at 08:25:53AM +0100, Lee Jones wrote:
> > A Reviewed-by to me means that a person knows the area, including
> > possible side-effects a patch may cause.  In this EXTx case, I do not
> > consider myself a domain expert and thus am not in a position to
> > provide that level of review.  Instead, the patch was reviewed on its
> > own merits, and since it looked good (which it still does), an
> > Acked-by was provided.
> 
> So that kind of "review", where "I'm not an expert, but it looks good
> to me", has very, very little value as far as I'm concerned.  A
> computer program can do a "it builds, ship it" test, and checkpatch
> can find the whitespace nits.  So what value does a "I can't consider
> side-effects" review have?  Again, as a maintainer, I can put very
> little (read: zero) reliance on it.

So what your asking is that only domain experts are to review
patches in the subsystems you maintain.  That's absurd, and among the
least inclusive statements I've heard in a while.  No wonder we have
an issue attracting new reviewers/maintainers to the fray.

> > Exactly, there's that *if* I was talking about.  "IF, a patch affects
> > multiple subsystems".  This patch does not.  The Acked by is also not
> > coming from a maintainer from this subsystem, thus this statement does
> > not come into play.
> 
> And my assertion is that if a patch does not affect multiple
> subsystems, an Acked-by has close to zero value.  So why do it?  In my

At the moment, your assertion isn't based on the documented meaning.
So you're enforcing rules based on what you think it should mean,
rather than what it actually means (according to the current
and up-to-date documentation).

> opinion, we should tighten up the documentation to only use it for the
> Maintainer reviewing a patch that's not flowing through the
> Maintainer's tree.

That's your opinion, and you're entitled to it.  But frankly that's
all it is at the moment.  If you wish to push this meaning onto
others, you need to start a conversation and/or submit patches for
review.

> > > > "at all" - wow!  What kind of message do you think this gives to first
> > > > time contributors (like Philippe here), or would-be reviewers?  That
> > > > there isn't any point in attempting to review patches, since
> > > > Maintainers are unlikely to take it into consideration "at all"?  I
> > > > know that when I come to review a patch, if *any* contributor has
> > > > taken the time to review a patch, it always plays an important role.
> > > 
> > > So if I'm going to have to do a full review (which you approve), that
> > > by definition means I'm not relying on the review at all, right?
> > 
> > Your review should not replace and over-ride another review (unless
> > you disagree with it, obviously), it should compliment it.  Both *-bys
> > should be added to the patch when/if it is applied.
> 
> We're using "reviewed" in two different ways.  I'm talking about an
> empty "reviewed-by" or "acked-by", for which if it's an developer
> unknown to me, I have no way of telling how much time they spent on
> the review.  Was it 5 seconds?  Or 5 minutes?  Or something in
> between?

What is an empty {Acked,Reviewed}-by?  We have no provision for
indicating time taken to review.  As maintainers we have to make the
call on how many 'credits' to award the {Acked,Reviewed}-by based on
our experiences of that person.  I have reviewers I trust and
reviewers who are new to me.  My trust levels of a patch increase a
given amount depending on who they are and how many I receive.  That
level is seldom zero though!

> You're saying that if someone sends a "Reviewed-by" or "Acked-by", I
> *must* never drop it, even if I have no idea how much value it has
> (and therefore, as far as I'm concerned, it has no value).  Sorry, I'm
> not going to play things that way.  Feel free to call me bad if you
> want, it's not going to change how I do things.

Yes, that's bad.

> Worse, what value does it add if we record it for all posterity?  What
> should someone who is reviewing the git log after the fact, perhaps a
> year later, take from the fact that there is an unknowned Reviewed-By
> or Acked-By attached to the commit?  Do you think someone reviewing a
> commit year later will spend time crawling over the git history to
> determine how many reviews someone has done?

Don't forget these reviewers you speak of, they are only "unknown" to
you.  They will have; friends, co-workers, employers, potential
employers, community colleagues, etc.  Their interest in a patch,
driver or sub-system may not be known to you, but may be intrinsic to
their role else where.  Who are you (we) to decide who is unimportant
when it comes to our areas of responsibility?  Or who should and
should not gain credit for their efforts?

It's about given credit where credit is due.

> (And if all maintainer's add empty Reviewed-by to their commit,
> looking at Git histories might not tell you much anyway.  It cheapens
> the Reviewed-by and Acked-by headers.  I consider part of the
> maintianer's job to curate not just patches, but Reviewed-By and
> Acked-by headers.)

There is no such thing as an empty {Acked,Reviewed}-by - you made that
up.  Unless someone is gaming the Git statistics and giving out *-bys
willy-nilly, it means they have put some effort into reviewing a
patch.

Cheapens the headers?  Total nonsense!  Any review, even by non-domain
experts only serves to strengthen the likelihood that the patch is of
the required quality.

I'm sorry to say, but I find your views dated, elitist and arrogant.

> And BTW, if the maintainer is using a non-rewinding git tree, and the
> git has already been published on git.kernel.org, it's physically not
> *possible* for them to add a late Reviewed-by, or Acked-by.  And I
> think that's perfectly justifiable, since if the decision has already
> been made to accept the commit, the Reviewed-By or Acked-By has no
> value to the project.

Agreed.  Late reviews are generally not credited.

> > > So my personal approach is to not include Reviewed-by or
> > > Acked-by if it didn't add any value to the project.
> > 
> > That's wrong of you.  I do not support this behaviour at all.  If
> > someone has gone to the trouble to review a patch and provide a
> > suitable *-by, you, as the maintainer have a duty to credit this work
> > by applying it to the patch (if accepted).
> 
> But I don't *know* that someone has gone to the trouble to review a
> patch.  If they made any kind of comment (positive or negative, or
> evaluating tradeoffs), then I have some kind of signal about how much
> time they spent reviewing the patch, and how much comprehension they
> have about the patch.  This is why my metric is "value to the
> subsystem / value to the project as a whole".

No, you don't know.  You can never know.  That's why you have to give
the benefit of the doubt in most cases.  How much credit you actually
give to the review is your decision as the maintainer - it should not
be your decision to dismiss it completely based on your (our)
ignorance of who this person might be.

> You yourself have asked me to count the number of Reviewed-by you have
> as a sign of your technical ability.  Would you then want to make sure
> that that signal isn't cheapened?

Actually my SoBs would have been more important, but that's by the
by.

Granted, some (not all, not most, not even many) people write lots of
trivial patches, submit reviews which have not been thought out
properly, game Git statistics, etc.  They should be dealt with in the
appropriate manor.  However until proven guilty, reviewers should be
guided and encouraged to do continue doing so.  These are our future
maintainers and should be nurtured.  You absolutely should not ignore
their efforts.  Doing so will only make them feel undervalued and will
likely discourage them from further contributions.

> > That policy is crazy.  You are saying that people should only be
> > providing negative reviews?  So what happens if someone conducts a
> > review and they cannot find anything wrong with the submission?  You
> > are suggesting that you are not going to apply their tag anyway, so
> > what would be the point in them providing one?  You are essentially
> > saying that unless they have previously given a patch a NACK, then
> > don't bother to provide an ACK.  Bonkers!
> 
> It's a question of developer history.  Not just of a particular patch,
> but their reviewer history as a whole.  If Jan Kara or Andreas Dilger
> or Lukas Czerner sends me a empty Reviewed-By, it has great weight,
> because they've found issues with other patches in the past, and we've
> had design discussions about what is the right way to fix a particular
> issue.  But for a someone with whom I've never interacted before, and
> all I get is a drive-by, empty Acked-by?  No, it's not going to get
> included by me.  Sorry.

That's not a question of developer history.  If you'd conducted your
due diligence on me (just using this patch as an example), you would
have seen that I have a solid 'developer history'.  What you're
judging on is your own opinion based on your experiences alone.  As I
said before, people shouldn't be ignored/discouraged based on our
ignorance of their existence.

Deciding not to apply a *-by because you have no way to gauge the
level quality of the review, due solely to a gap in your own knowledge
is an awful policy.

This discussion is starting to take up a lot of my time now, so I'd
like it to come to a close.  I guess the summary is; if you wish to
continue being; discouraging, exclusive and elitist, you continue
doing things your way.  If you wish other contributors to adhere to
your meanings of the various *-by tags, you'll have to conduct a
discussion and update the documentation accordingly.  I'd certainly be
happy to change the way I use them, but only if reflected clearly in
the documentation.

Have a lovely day Ted.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
