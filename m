Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25FC767447
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jul 2023 20:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjG1SKl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jul 2023 14:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjG1SKa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jul 2023 14:10:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F3B44BD
        for <linux-ext4@vger.kernel.org>; Fri, 28 Jul 2023 11:10:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-23.bstnma.fios.verizon.net [173.48.113.23])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36SIAFvh031473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 14:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690567816; bh=g+d4IjMFNjcS40MnJm7H5xhWANs4yJAkAPApqj2itHE=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=o4XMVyFRMZKghotFWRYuoXaPBpEjZKki+gaqxFDNBQ+Y2cLHHAKnTOArqqNuxaMOa
         8eMxrb8Gkg9K9Grg91aL4LIiKGEIEJoQCfLy7xityXWniwfStmDwsWEkPCuY1QapqW
         EFkH/4x48M2bohiSOS5b5of9dORjBCHzizcnwchVU1/VGw26Vgujqc4MFBAcJuuEVN
         /v+6Ne5leSz16oOIRwbOf7I2iHcyh2Xxb0yq+mRYYXb33/rpCDvSQ7EGHNL67M+bq6
         TR5LVXmyc27zDSZkjS4I7ywVr7NYAuIjdcnHMkyQG/YhBiE28ypYc2FGljLITVf1so
         cNOIfOj/Ej/6Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F315615C04EF; Fri, 28 Jul 2023 14:10:14 -0400 (EDT)
Date:   Fri, 28 Jul 2023 14:10:14 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Oscar Megia =?iso-8859-1?Q?L=F3pez?= <megia.oscar@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Contributing subsequent patch versions
Message-ID: <20230728181014.GA607743@mit.edu>
References: <877cqlmdpg.fsf@gmail.com>
 <8ef54195-4102-0c6c-e14d-efc9bc45cddc@web.de>
 <877cqk5zdt.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cqk5zdt.fsf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 28, 2023 at 08:22:22AM +0200, Oscar Megia López wrote:
> Yes, I read
> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
> yesterday and more online documentation and I didn't find any describing the
> correct way to send next patch version.
> 
> Today I found this
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
> but I still have some doubts.

What you're running into is the fact that there are multiple ways that
people will prepare patch versions, and so the process documentation
merely specify what the patch series should look like.

> Yes, I know, but I want to know how an expert programmer send
> next version (create new branch for each patch's version?, create new
> directory outgoing for each patch's version?, run git pull on patch's
> branch?, add --in-reply-to= to previous patch's version email?
> ¿cover letter or 1/1?, etc.).

Not only do many experienced programmers might have different
perferred workflows, they might use different procedures depending on
how complex the patch series would be.  For example, for the case for
a single patch, I'd probably just use "git format-patch -1 ...",
meaning "just format the top-most patch on the current branch".

For a really simple patch, I might just use "git commit --amend" to
make changes, and I might not bother rebasing unless it was necessary
to make sure it would apply on the top of the development branch.  If
it was necessary to rebase, assuming that you have the local branch
"origin_<topic>" which points as the base to your patch or patch
series, then what *I* typically do is just do:

git branch -f orgin_<topic> origin/master
git rebase origin_<topic>

Now the topic branch is rebased on the tip of the upstream development
branch, and now I might just do:

git format-patch -o /tmp/p origin_<topic>..

For a single patch, I might not bother with cover letter, and most of
the time, I'll just manually copy the cover letter from the previous
version into the current cover letter, append the description of what
changed from the last version, and then I'll send it out.

This just uses all basic git commands.  There *are* more sophisticated
systems that will automate things, and it's completely up to you
whether or not you want to use them.  Sometimes, the simpler methods
are best and systems which try to "automate" things can just confuse
you.

If you want to see an example of a much more sophistcated system, take
a look at the b4's "prep" command[1].  I don't use it, my self,
although I do use "b4 am" and "b4 ty" for my maintenance work.  So
don't feel like you have to use "b4 prep"; try it out, and see if it
makes your life easier.  If so, use it!  If not, just let it go, and
try something else.

[1] https://b4.docs.kernel.org/en/latest/contributor/prep.html

Finally, with respect to your original patch.  My apologies for not
looking at it eariler.  I'm pretty swamped these days, which means
that I'm prioritizing which patches get my attention.  As far as this
particular patch, I don't think it's actively harmful, but I also
don't quite see the point.  If you want to see how full a file system
might be, and it's disappearing too quickly because shortly after fsck
finishes, the graphical login has come up, you can always use the "df"
command, right?

						- Ted
