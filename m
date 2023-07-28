Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263377676B2
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jul 2023 22:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjG1UAL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jul 2023 16:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjG1UAK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jul 2023 16:00:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351403C1D
        for <linux-ext4@vger.kernel.org>; Fri, 28 Jul 2023 13:00:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-23.bstnma.fios.verizon.net [173.48.113.23])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36SJxx66023314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 16:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690574402; bh=Rr0teEryQs0w9W1G/buPf3/HX7UpIS/tnGSgH9tvnLQ=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=oAh07rAxFZKOrHsf0e377P2q7roMFDoSmuc9kqfzHy6yjyExZJWh4b0/DOnqi6GT0
         ADgQU5M98IqI0FKsi3KwlburKk1Sx/KtpFe57eoxB0i5rvrDFjlYELsIPrUKToF/yF
         XaJh23rkS0qGphj4a8PPlyRTWPCaDNbsclqWyujFCOJtaFchJcLuKwEcCV8IqjdPE1
         M+z1YNyAYvwc0tFOK+8oKlYP91kwN0QsE+0f67T6DIlg+ufgou4h5Rl0yUC7C7zp+l
         CCMX2oyu85itsL6BsZu4zBQAX89c/taJepR8UtQks0qG4OVWkCa5GDYCZT4X74/gq5
         aIF3nv8HE7sMg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 61E9015C04EF; Fri, 28 Jul 2023 15:59:59 -0400 (EDT)
Date:   Fri, 28 Jul 2023 15:59:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Oscar Megia =?iso-8859-1?Q?L=F3pez?= <megia.oscar@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: Contributing subsequent patch versions
Message-ID: <20230728195959.GB607743@mit.edu>
References: <877cqlmdpg.fsf@gmail.com>
 <8ef54195-4102-0c6c-e14d-efc9bc45cddc@web.de>
 <877cqk5zdt.fsf@gmail.com>
 <61a79836-3981-b6e0-cbbf-fe03507dbea4@web.de>
 <87tttnhohp.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tttnhohp.fsf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 28, 2023 at 08:36:50PM +0200, Oscar Megia López wrote:
> I don't know correct steps to send patch's v2 as above instance. Sorry,
> but I need step by step instructions, if not I think that I can make
> mistakes and I don't want. Sorry, but my experience says that is very
> easy make mistakes when I am newbie.

We all make mistakes; don't worry about it!  This includes myself,
which is why I often will run:

      git format-patch -o /tmp/p -5

<then examine the patches in /tmp/p very carefully to make sure they make sense>

before I run

       git send-email /tmp/e --to linux-<subsystem>

where I have a bunch of aliases in ~/.mail_aliases, e.g.:

alias linux-ext4 Ext4 Developers List <linux-ext4@vger.kernel.org>
alias linux-fsdevel Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>
alias linux-kernel Linux Kernel Developers List <linux-kernel@vger.kernel.org>
alias lkml Linux Kernel Developers List <linux-kernel@vger.kernel.org>
alias fstests fstests@vger.kernel.org
alias djwong Darrick J. Wong <djwong@kernel.org>
alias torvalds Linus Torvalds <torvalds@linux-foundation.org>

that way, I can just use a alias like "--to lkml" instead of having to
type linux-kernel@vger.kernel.org.

Now, do you *have* to do this?  No, of course not!  It's a short-cut,
which can use if it saves you time.


As far as wanting step-by-step instructions, the problem is that there
are always exception cases.  So it's very hard to have someone try to
anticipate every single contingency, and encode that in a step-by-step
recipe that someone follows blindly.

It's much more important that you understand *how* git works, for
example, and what might be happening at various steps, as opposed to,
"just give me the step by step formula and don't bother me with how
things works under the covers".

> No, I just want to know how an expert programmer will do the task that I
> need to do. I can try it myself with trial/error, but I'm not alone, am I?

Well, for something *really* simple, I might skep some of the steps.
That's because as an "expert" I understand what each of the steps are
doing, so I know when it might be safe to skip them.  For example, if
I'm only making spelling fixes in comments, I won't need to run
regression tests.  And to for a really, REALLY, simple patch, I might
not bother with checkpatch.pl --- but that's because I understand what
checkpatch.pl can and can't catch.

It also depends on what the maintainer wants.  In the case of fstests,
for example, the current maintainer doesn't mind making minor edits to
the commit before he applies it.  So I might not *send* a v2 version
of the patch, I'll just send a follow-up e-mail describing the typo
fixes that I failed to notice before sending out the patch.  For
example, see this email-thread:

   https://lore.kernel.org/all/20230727190512.357064-1-tytso@mit.edu/T/#u

In this particular case, it was pretty much "edit the Makefile", "git
commit -a", write up the commit, build fstests and make sure the
install worked properly, "git send-email -1 --to fstests --cc djwong".
There were no "9 steps", because I was in a hurry, and I knew when I
could skip some of the steps.


> I apologize if I said anything that was confusing (English is not my
> native tongue). My question was if expert developers create a different
> name for outgoing directory for each patch's version on
> git format-patch ... -o outgoing/ master command.
> For instance: -o outgoing_v1 for v1, -o outgoing_v2 for v2 and so on.
> I ask this because you can lost patch files from previous
> patches if you run this command several times (it makes backup ending
> with ~, but usually last backup is lost after update). Or not?

So *I* don't bother saving the older patch versions.  One of the
reasons for that is I have the older patches in my e-mail archives,
and I can find my e-mail archives much more quickly than I can
archiving other things.  Worse case, I can always search for older
versions of the patch set using https://lore.kernel.org, and I can
fetch previous versions of the patches via:

git am -o /tmp/m <message-id>

But that doesn't mean that there might not be *some* expert developers
who might keep older versions of the directories around.  Although to
be honest, in the case where I expect that I might need to resend a
patch series many times, I'd probably just have a series of branches
in git, named <topic>_v2, <topic>_v3, etc. and then it's not all that
hard to regenerate them using "git format-patch" if I really need
them.  (In actual practice, it's rare that I need refer to anything
but the immediate patch set, and only when I'm assembling toe
differences between the v<n-1> and v<n> patch set.  And most of the
time, I try very hard to keep my patch sets small, so I can usually
write the changes from memory, and I don't need to run diffs on the
patches.)

> >>               add --in-reply-to= to previous patch's version email?
> >
> > Replies can generally be attempted according to previous messages
> > (by different communication tools).

So in *general* I don't recommend adding an --in-reply-to for the
previous version of the messages.  If I need to find the earlier
versions of the patches, I'll just search for them on lore.kernel.org.
Having --in-reply-to= for older versions of the patches can sometimes
confuse the b4 program, and as a maintainer, I generally prefer to do
something like this:

     b4 am -o /tmp/m -c <message-id>

Where the -c option means, "check for newer versions of the patch
series".  But if you have later patch series set as a reply, and
one-line patch summaries have changed, this can sometimes confuse b4's
automated algorithms for determining when a patch is patch of a patch
series or not.

It's not a *disaster* if you do this; it just means more manual work
on my part.

> 
> I apologize if I said anything that was confusing (English is not my
> native tongue). I wanted to say that I created new branch from branch
> for patch v1 to run git reset or whatever without modify branch patch
> v1. If I make any mistake or something harmful I can checkout to
> original branch for patch v1 and delete this test branch.

Sure, one of the ways that I might do things is something like this:

    git branch topic_v2 topic

and then use a command like "git checkout topic_v2 ; git rebase -i
HEAD^^^" to edit the patches.  That is *one* way of doing things.


On the other hand, there has been times when I'll export the patches
as a patch series, e.g:

    git format-patch -o /tmp/p -7

and then edit the patches in /tmp/p, so I can use features like global
search and replace on the diff files, if I want to change the name of
a variable across multiple patches, and then reapply the patch series:

    # origin is the branch name I typically use for the base of my patch series
    git branch topic_v2 origin      
    git am /tmp/p


See?  There is no *one* way to do things.  They all have benefits and
tradeoffs.  Editing patches in a way that you don't break them such
that they don't apply is a bit of an advanced skill, and it's possible
that you can break things.  But as long as you know enough git
commands so that you are creating new branches and then modifying the
commits on the newer branches, it's actually pretty hard to lose data
with git.

> I apologize if I said anything that was confusing (English is not my
> native tongue). I wanted to say that is not necessary send previous
> patch v1 because I sent it before. For instance, if I send v20, is
> necessary send 19 previous versions to mailing list? How usually is
> managed? As format-patch do?, sending only last version with links to
> previous versions? Sorry for my question, but I think that send again
> the previous versions is not necessary and will saturate the mailing
> list, but it is only my modest opinion, the important thing is how it is
> usually done.

So in *general* it's pretty rare that you'll need to send that many
versions of the patch series to the list.  If you are getting to v20,
it may be a sign that you have too many patches in a patch series.  In
general, it's hard for people to maintain enough concentation to
review more than 6 to 10 patches in a patch series.  So see if you can
break up your patch series into smaller chunks.  An additional benefit
is if you're going in the wrong direction, you can course course
correct that much easier.

Most of the time, for complex patches, the cover letter will have
something like this at the end of the letter:

    v4
      * list of changes since V3
      * more changes
    v3
      * list of changes since v2
      * lorem ipsum...
    v2
      * list of changes since v1
      * ...

That's mostly because people are copying the cover letter from the
previous version and then editing it, and it's a bit eaisier to just
to add the list of changes since the last version, and it's extra
effort to delete the previous changes, so why not?

						- Ted
