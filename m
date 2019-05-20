Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0A823C40
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2019 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbfETPgu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 May 2019 11:36:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38844 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732280AbfETPgu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 May 2019 11:36:50 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4KFaePI015626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 11:36:41 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EF219420027; Mon, 20 May 2019 11:36:39 -0400 (EDT)
Date:   Mon, 20 May 2019 11:36:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190520153639.GB3933@mit.edu>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520082402.GZ4319@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 20, 2019 at 09:24:02AM +0100, Lee Jones wrote:
> > "appropriate for inclusion into the kernel" means to me that you've
> > done the same level of review as Reviewed-by.  So I have very
> 
> Actually it doesn't, or else the documentation text for Acked-by would
> be just as intense as it is for Reviewed-by.  Reviewed-by IMHO has a
> much stronger standing than an Acked-by (caveat: when not provided by
> a maintainer of the appropriate subsystem).

Well quoting from submitting-patches: "It [Acked-by: ] is a record
that the acker has AT LEAST REVIEWED THE PATCH" (emphasis mine).

The primary use of it is to "signify and record their approval of it".
And...

    Acked-by: does not necessarily indicate acknowledgement of the
    entire patch.  For example, if a patch affects multiple subsystems
    and has an Acked-by: from one subsystem maintainer then this
    usually indicates acknowledgement of just the part which affects
    that maintainer's code.  Judgement should be used here.  When in
    doubt people should refer to the original discussion in the
    mailing list archives.

My question is what is the *point* of including a non-maintainer's
Acked-by: to the git record?  And if it's not the maintainer (or a
core developer for a subsystem), then it becomes unclear what portion
of the patch the non-Maintainer has reviewed.  So at that point, how
can a Maintainer rely on a non-Maintainer Acked-by at all in the first
place?

> > and so I'd be doing a full review myself
> 
> I'd think a great deal less of you if you didn't.
> 
> > and not rely on your review at all....
> 
> "at all" - wow!  What kind of message do you think this gives to first
> time contributors (like Philippe here), or would-be reviewers?  That
> there isn't any point in attempting to review patches, since
> Maintainers are unlikely to take it into consideration "at all"?  I
> know that when I come to review a patch, if *any* contributor has
> taken the time to review a patch, it always plays an important role.

So if I'm going to have to do a full review (which you approve), that
by definition means I'm not relying on the review at all, right?

The way I handle things is that while I'm not going to rely on a
Reviewed-by from an unknown reviewer, I do remember who provides
reviews, and this will bump up their reputation so that perhaps in the
future, I will rely on their reviews.  Reviews that including some
kind of substantive comments (if correct) will enhance the reviewer's
reputation much more than a blind "Reviewd-by: ".

BTW, empty reviews for a patch authored by alice@company-foo.com,
coming from bob@company-foo.com (e.g., where the only content of the
review is Reviewed-by: bob@company-foo.com) are things that I give
much less weight, especially when bob@company-foo.com is not a known
developer to me.

(Yes, I know that sometimes patches get developed behind closed doors,
and then squirt out fully formed with a four or five Reviewed-by:
lines.  But if I haven't seen the process, it doesn't give much value
to the maintainer trying to judge the suitability of the patch.  Red
Hat's approach to do all patch discussions in the open is highly to be
commended here.)

> Again, not really sure of your intentions when you write this out, or
> what it has to do with this patch submission or the review there
> after, but IMHO this is sending the wrong message to new and would-be
> contributors.  As a community we're supposed to be providing a
> supportive, encouraging atmosphere.  This paragraph is likely to do
> nothing more than scare off people who would otherwise be willing
> to have a go [at submitting or reviewing a patch].

One of the things that I worry about are people who game git
statistics by submitting a lot of empty Reviewed-by or Acked-by lines.
It's right up there with people who send huge numbers of whitespace
fixes.  So my personal approach is to not include Reviewed-by or
Acked-by if it didn't add any value to the project.  It may indeed
still value to the reviewer's reputation, and if the reviewer has
helped to improve the patch, I'll make sure they get credit.

I do agree that we should provide a supportive atmosphere.  But we
also need provide encouragement that contributors provide more
substantive patches and more substantive reviewes.

Cheers,

					- Ted
