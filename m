Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32098583599
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jul 2022 01:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiG0XWd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 19:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiG0XW3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 19:22:29 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 449485927F
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 16:22:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E512410C895B;
        Thu, 28 Jul 2022 09:22:25 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oGqMC-0065wU-QA; Thu, 28 Jul 2022 09:22:24 +1000
Date:   Thu, 28 Jul 2022 09:22:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, bugzilla-daemon@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Message-ID: <20220727232224.GW3600936@dread.disaster.area>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
 <YuBKMLw6dpERM95F@magnolia>
 <20220727115307.qco6dn2tqqw52pl7@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727115307.qco6dn2tqqw52pl7@fedora>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62e1c8b2
        a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
        a=MTImU-Fj9aQAwu4MaV8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 27, 2022 at 01:53:07PM +0200, Lukas Czerner wrote:
> On Tue, Jul 26, 2022 at 01:10:24PM -0700, Darrick J. Wong wrote:
> > If you are going to run some scripted tool to randomly
> > corrupt the filesystem to find failures, then you have an
> > ethical and moral responsibility to do some of the work to
> > narrow down and identify the cause of the failure, not just
> > throw them at someone to do all the work.
> > 
> > --D
> 
> While I understand the frustration with the fuzzer bug reports like this
> I very much disagree with your statement about ethical and moral
> responsibility.
> 
> The bug is in the code, it would have been there even if Wenqing Liu
> didn't run the tool.

Yes, but it's not just a bug. It's a format parser exploit.

> We know there are bugs in the code we just don't
> know where all of them are. Now, thanks to this report, we know a little
> bit more about at least one of them. That's at least a little useful.
> But you seem to argue that the reporter should put more work in, or not
> bother at all.
> 
> That's wrong. Really, Wenqing Liu has no more ethical and moral
> responsibility than you finding and fixing the problem regardless of the
> bug report.

By this reasoning, the researchers that discovered RetBleed
should have just published their findings without notify any of the
affected parties.

i.e. your argument implies they have no responsibility and hence are
entitled to say "We aren't responsible for helping anyone understand
the problem or mitigating the impact of the flaw - we've got our
publicity and secured tenure with discovery and publication!"

That's not _responsible disclosure_.

Yup, this is important enough that we actually have a name for it:
responsible disclosure.

And where do those responsibilities come from? You  guessed it -
they are based on the ethics and morals that guide us towards doing
what is best for the wider community.

> I think the frustration comes from the fact that it's potentially a lot
> of work to untangle and fix the real problem and now when it is out
> there we feel obligated to fix it. And while bug reports and tools
> generating these can always be better and reporters can always be a bit
> more active in narrowing the problem down, you're of course free to
> ignore this until you, or anyone else, has a bit of spare time and
> energy to investigate.

It has nothing to do with the amount of work, nor does it change the
fact that us developers will need to do most of the work. The
problem here is the lack of responsible disclosure that we see
repeatedly with filesystem flaws found by fuzzing the on-disk
format.

Public reports like this require immediate work to determine the
scope, impact and risk of the problem to decide what needs to be
done next.  All public disclosure does is start a race and force
developers to have to address it immediately.

Responsible disclosure gives developers a short window in which they
can perform that analysis without fear that somebody might already
be actively exploiting the problem discovered by the fuzzer. We can
address the problem without extreme urgency, knowing a day or two
while we wait for private discussion and bug fixing to take place
isn't going to make things worse.

That's the issue with drive-by fuzzer bug reporting - the people
that do this have little clue about the potential impact of the
flaws they are discovering. Those people need to be taught that
their responsibility is not to through issues over the wall at other
people, but to work closely with the people that can fix the issues
to have a fix for the problem ready at the same time the issue is
disclosed.

IOWs, they have an ethical and moral responsibility to the wider
community to disclose these issues to relevant developers in a
responsible manner and work with them to fix the problems before the
issues are made public.

Once you look at filesystem fuzzing bugs from a security and exploit
perspective, _everything changes_.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
