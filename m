Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC934248EB
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2019 09:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfEUHZ7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 May 2019 03:25:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36711 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfEUHZ6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 May 2019 03:25:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so17291995wru.3
        for <linux-ext4@vger.kernel.org>; Tue, 21 May 2019 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yf360FNlCAPATE8U7NKAhZIqQygb7bCL1oYKfMyPcLk=;
        b=hdWDgCKEUsA/UeC/x3hEmkJxMORmEqNwzt8tOWcZlggJqM7M+Zr8IFcI+O1dDpwXqx
         SSpSmsK0mRJgbEQZpKFl33MDtAfZLl3b0MG/JtWbMC2E9jA32v3TVRbmyga957U7xadY
         kuWQIB6r65q+l1xoybkULQA9ngxe4qw2sPShQspJCMg8kJX3ss7w3T/HvkKCxNWurT3L
         Rrg6Bm5aF+1qQJq3iEywYg+3/dsXmrS/JbpggGI7GKSYzbE92ALIuBJP3E2GBgPbz1OD
         k2b7bDz4Ki9snRrpc3qNZdX7ZngqT17ZYMs9kKbQ3qBrkPrZGW2lJWvGf+zl7JGDUKU8
         j2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yf360FNlCAPATE8U7NKAhZIqQygb7bCL1oYKfMyPcLk=;
        b=PScfOZmqfJm9hhjfPvUKkR2ILPzVoqvsQUp7Ry49gnt3xmbPO/vxN/Apuwp6VVH97r
         jTF4FXxQ8YyK0yYUHcDcStyMiVp0lrjQE2XiDGefNFEAsu1z6HSCbUMw4YrTAcPsZQ8z
         OG+qovLWDW62IF6CzzBBfh3BpwmMmV9KHs+W3BarWfbUew8EJ+BwKYkBLJ3dS9TQTBb/
         jTIm3RaJ3P/jkgQyqmwD9y5kSB+tDKbsz6oojcQ9fAJVeLVoSliiwjWeo4VBx35bbuq7
         9kv/hNeljtukmtotE5iHtSOVDg9lw6fktNvc+DeoG3vBRNxa0/6iqXstwQRJ++gYzOsP
         MuPQ==
X-Gm-Message-State: APjAAAX0VIG3FVCtk3hg9AyMAzdosKS8XJfCx8ycFWOAbaD0BTsyhbXm
        7gQ4EeIWvwbRnfeOANDafvRbDg==
X-Google-Smtp-Source: APXvYqxyqOMvmOu4ewM0t5HDU4iTO+n05TmYU3rC0qA9GRYqs2HfECZT5lDXouaeusND+aFVLenKtg==
X-Received: by 2002:adf:e902:: with SMTP id f2mr48617234wrm.301.1558423555952;
        Tue, 21 May 2019 00:25:55 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id j9sm23938862wrr.90.2019.05.21.00.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 00:25:54 -0700 (PDT)
Date:   Tue, 21 May 2019 08:25:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190521072553.GA4319@dell>
References: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
 <20190517102506.GU4319@dell>
 <20190517202810.GA21961@mit.edu>
 <20190518063834.GX4319@dell>
 <20190518195424.GC14277@mit.edu>
 <20190520082402.GZ4319@dell>
 <20190520153639.GB3933@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520153639.GB3933@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 20 May 2019, Theodore Ts'o wrote:

> On Mon, May 20, 2019 at 09:24:02AM +0100, Lee Jones wrote:
> > > "appropriate for inclusion into the kernel" means to me that you've
> > > done the same level of review as Reviewed-by.  So I have very
> > 
> > Actually it doesn't, or else the documentation text for Acked-by would
> > be just as intense as it is for Reviewed-by.  Reviewed-by IMHO has a
> > much stronger standing than an Acked-by (caveat: when not provided by
> > a maintainer of the appropriate subsystem).
> 
> Well quoting from submitting-patches: "It [Acked-by: ] is a record
> that the acker has AT LEAST REVIEWED THE PATCH" (emphasis mine).

Absolutely.  Anyone who hasn't reviewed a patch to the best of their
ability before providing their {Acked,Reviewed}-by would be a very
silly person indeed.

But that's not what you said and it not what I'm disagreeing with, is
it?  See above, you said "[an Acked-by] means to me that you've done
the same level of review as Reviewed-by", which I do not agree with.

A Reviewed-by to me means that a person knows the area, including
possible side-effects a patch may cause.  In this EXTx case, I do not
consider myself a domain expert and thus am not in a position to
provide that level of review.  Instead, the patch was reviewed on its
own merits, and since it looked good (which it still does), an
Acked-by was provided.

> The primary use of it is to "signify and record their approval of it".
> And...
> 
>     Acked-by: does not necessarily indicate acknowledgement of the
>     entire patch.  For example, if a patch affects multiple subsystems
>     and has an Acked-by: from one subsystem maintainer then this
>     usually indicates acknowledgement of just the part which affects
>     that maintainer's code.  Judgement should be used here.  When in
>     doubt people should refer to the original discussion in the
>     mailing list archives.

Exactly, there's that *if* I was talking about.  "IF, a patch affects
multiple subsystems".  This patch does not.  The Acked by is also not
coming from a maintainer from this subsystem, thus this statement does
not come into play.

> My question is what is the *point* of including a non-maintainer's
> Acked-by: to the git record?

You'll have to take that up with the documentation, which clearly
states:

 "Acked-by: indicates an agreement by another developer (often a
  maintainer of the relevant code) that the patch is appropriate for
  inclusion into the kernel.

... which is *exactly* as I meant it.  I, as 'another developer', do
consider this patch appropriate for the inclusion into the kernel.

How is that less than totally clear?  If the documentation is wrong,
something needs to be done about that.  Until then, I shall continue
using Acked-bys to mean "I'm not an expert in this area, but based on
the patch alone, the change looks good to me".

> And if it's not the maintainer (or a
> core developer for a subsystem), then it becomes unclear what portion
> of the patch the non-Maintainer has reviewed.

A reviewer will normally indicate which portion of the code has been
reviewed, which can then be reflected in the change-log.  If a
maintainer Ack is applied, it can be assumed that only the part under
their jurisdiction is relevant.  If not a maintainer or core-dev, and
no extra indication is provided, then I think we can assume they
reviewed the whole patch.  Extra indication can look like this in the
*rare cases* a non-maintainer/core-dev provides a part-review:

  Acked-by: Joe Bloggs <j.b@someemail.com> [ext2]

See 8a7f97b902f4 ("treewide: add checks for the return value of
memblock_alloc*()") as the first example I came across.

> So at that point, how
> can a Maintainer rely on a non-Maintainer Acked-by at all in the first
> place?

At what point?

> > > and so I'd be doing a full review myself
> > 
> > I'd think a great deal less of you if you didn't.
> > 
> > > and not rely on your review at all....
> > 
> > "at all" - wow!  What kind of message do you think this gives to first
> > time contributors (like Philippe here), or would-be reviewers?  That
> > there isn't any point in attempting to review patches, since
> > Maintainers are unlikely to take it into consideration "at all"?  I
> > know that when I come to review a patch, if *any* contributor has
> > taken the time to review a patch, it always plays an important role.
> 
> So if I'm going to have to do a full review (which you approve), that
> by definition means I'm not relying on the review at all, right?

Your review should not replace and over-ride another review (unless
you disagree with it, obviously), it should compliment it.  Both *-bys
should be added to the patch when/if it is applied.

> The way I handle things is that while I'm not going to rely on a
> Reviewed-by from an unknown reviewer, I do remember who provides
> reviews, and this will bump up their reputation so that perhaps in the
> future, I will rely on their reviews.  Reviews that including some
> kind of substantive comments (if correct) will enhance the reviewer's
> reputation much more than a blind "Reviewd-by: ".

Perfect.  This is a positive statement. The way you worded this before
was very negative and almost sounded like a threat.

> BTW, empty reviews for a patch authored by alice@company-foo.com,
> coming from bob@company-foo.com (e.g., where the only content of the
> review is Reviewed-by: bob@company-foo.com) are things that I give
> much less weight, especially when bob@company-foo.com is not a known
> developer to me.

Absolutely.  I even alluded to this in my previous email.  Ah bugger!
After trying and find that part in order to quote it, it became
apparent that I took that sentence out.  But yes, I totally agree with
you, reviews mean more if they are from an independent source.

> (Yes, I know that sometimes patches get developed behind closed doors,
> and then squirt out fully formed with a four or five Reviewed-by:
> lines.  But if I haven't seen the process, it doesn't give much value
> to the maintainer trying to judge the suitability of the patch.  Red
> Hat's approach to do all patch discussions in the open is highly to be
> commended here.)

+1

NB: I still keep the *-bys applied when merging a patch, even if they
do not hold much gravitas during my review process.

> > Again, not really sure of your intentions when you write this out, or
> > what it has to do with this patch submission or the review there
> > after, but IMHO this is sending the wrong message to new and would-be
> > contributors.  As a community we're supposed to be providing a
> > supportive, encouraging atmosphere.  This paragraph is likely to do
> > nothing more than scare off people who would otherwise be willing
> > to have a go [at submitting or reviewing a patch].
> 
> One of the things that I worry about are people who game git
> statistics by submitting a lot of empty Reviewed-by or Acked-by lines.

I can't think of a time I have been on either end of this situation.
If I saw anyone doing this I would call them out on it.

Just to clarify, in case you think that's what is happening here (I'm
sure you've looked though the Git log and seen for yourself, but
still); I reviewed this patch solely because I am helping Philippe
through the process of becoming a Kernel contributor, since he showed
a great deal of interest and enthusiasm for it when I met him a few
weeks ago whilst rock climbing.

> It's right up there with people who send huge numbers of whitespace
> fixes.

Right, this drives me mad also.

> So my personal approach is to not include Reviewed-by or
> Acked-by if it didn't add any value to the project.

That's wrong of you.  I do not support this behaviour at all.  If
someone has gone to the trouble to review a patch and provide a
suitable *-by, you, as the maintainer have a duty to credit this work
by applying it to the patch (if accepted).

Of course the statement above comes with some caveats.  For example if
you think someone is gaming the Git statistics, then you have a right
to call them out and not apply the tag.  However, you really should be
giving people (especially people you don't know) the benefit of the
doubt.

> It may indeed
> still value to the reviewer's reputation, and if the reviewer has
> helped to improve the patch, I'll make sure they get credit.
> 
> I do agree that we should provide a supportive atmosphere.  But we
> also need provide encouragement that contributors provide more
> substantive patches and more substantive reviewes.

That policy is crazy.  You are saying that people should only be
providing negative reviews?  So what happens if someone conducts a
review and they cannot find anything wrong with the submission?  You
are suggesting that you are not going to apply their tag anyway, so
what would be the point in them providing one?  You are essentially
saying that unless they have previously given a patch a NACK, then
don't bother to provide an ACK.  Bonkers!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
