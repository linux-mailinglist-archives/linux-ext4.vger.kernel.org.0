Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2933458740F
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 00:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiHAWp5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Aug 2022 18:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbiHAWpz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Aug 2022 18:45:55 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DE5E25C56
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 15:45:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 09E8B62CEA6;
        Tue,  2 Aug 2022 08:45:52 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oIeAZ-0083N5-A3; Tue, 02 Aug 2022 08:45:51 +1000
Date:   Tue, 2 Aug 2022 08:45:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, bugzilla-daemon@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Message-ID: <20220801224551.GA3861211@dread.disaster.area>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
 <YuBKMLw6dpERM95F@magnolia>
 <20220727115307.qco6dn2tqqw52pl7@fedora>
 <20220727232224.GW3600936@dread.disaster.area>
 <20220728072510.yunkzplfqx2vt4wb@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728072510.yunkzplfqx2vt4wb@fedora>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62e857a1
        a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=44fSUzyl4n50KK8z-JAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 28, 2022 at 09:25:10AM +0200, Lukas Czerner wrote:
> On Thu, Jul 28, 2022 at 09:22:24AM +1000, Dave Chinner wrote:
> > On Wed, Jul 27, 2022 at 01:53:07PM +0200, Lukas Czerner wrote:
> > > On Tue, Jul 26, 2022 at 01:10:24PM -0700, Darrick J. Wong wrote:
> > > > If you are going to run some scripted tool to randomly
> > > > corrupt the filesystem to find failures, then you have an
> > > > ethical and moral responsibility to do some of the work to
> > > > narrow down and identify the cause of the failure, not just
> > > > throw them at someone to do all the work.
> > > > 
> > > > --D
> > > 
> > > While I understand the frustration with the fuzzer bug reports like this
> > > I very much disagree with your statement about ethical and moral
> > > responsibility.
> > > 
> > > The bug is in the code, it would have been there even if Wenqing Liu
> > > didn't run the tool.
> > 
> > Yes, but it's not just a bug. It's a format parser exploit.
> 
> And what do you think this is exploiting? A bug in a "format parser"
> perhaps?
> 
> Are you trying both downplay it to not-a-bug and elevate it to 'security
> vulnerability' at the same time ? ;)

How did you come to that conclusion?

"not just a bug" != "not a bug".

i.e. I said the complete opposite of what your comment implies I
said...

> > > We know there are bugs in the code we just don't
> > > know where all of them are. Now, thanks to this report, we know a little
> > > bit more about at least one of them. That's at least a little useful.
> > > But you seem to argue that the reporter should put more work in, or not
> > > bother at all.
> > > 
> > > That's wrong. Really, Wenqing Liu has no more ethical and moral
> > > responsibility than you finding and fixing the problem regardless of the
> > > bug report.
> > 
> > By this reasoning, the researchers that discovered RetBleed
> > should have just published their findings without notify any of the
> > affected parties.
> > 
> > i.e. your argument implies they have no responsibility and hence are
> > entitled to say "We aren't responsible for helping anyone understand
> > the problem or mitigating the impact of the flaw - we've got our
> > publicity and secured tenure with discovery and publication!"
> > 
> > That's not _responsible disclosure_.
> 
> Look, your entire argument hinges on the assumption that this is a
> security vulnerability that could be exploited and the report makes the
> situation worse. And that's very much debatable. I don't think it is and
> Ted described it very well in his comment.

On systems that automount filesytsems when you plug in a USB drive
(which most distros do out of the box) then a crash bug during mount
is, at minimum, an annoying DOS vector. And if it can result in a
buffer overflow, then....

> Asking for more information, or even asking reported to try to narrow
> down the problem is of course fine.

Sure, nobody is questioning how we triage these issues - the
question is over how they are reported and the forum under which the
initial triage takes place

> But making sweeping claims about
> moral and ethical responsibilities is always a little suspicious and
> completely bogus in this case IMO.

Hand waving away the fact that fuzzer crash bugs won't be a security
issue without having done any investigation is pretty much the whole
problem here. This is not responsible behaviour.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
