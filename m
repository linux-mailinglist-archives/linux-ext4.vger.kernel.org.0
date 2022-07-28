Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF658372D
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jul 2022 04:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiG1CrQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 22:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiG1CrP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 22:47:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F594AD61
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 19:47:10 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26S2kscZ022654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 22:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658976415; bh=ejSHHiLjBcMpnwLBkyTMf+ExkkZ3cdcIkm+gshBhsYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aj4DEkjfY9KpmSLMl8WIosfRSIbnNgqojWHC+qJhn6W9QeP1+cksDpLg0YsgUlOvH
         YuJIZTAWjHbAeb43e5p608BSFhIpgDvK1fd2PUsXFK6v/3volvnd5/9c872FpH5Csi
         EN0kw9eOVz0F41P+VFiw0ZGqMM1Fk7X2c4b8vtlU3N3vXLhXrbfYL1xHTDVXPeBzu/
         DIrHE0vIkf7i+lDCMkLkctwOkse9EgKJorJIdCR3SJuE04I6gJG4EpRlonpDwLX5RU
         cBKWJexcuRkWa4xaoDb2JrhCVWsldy61a+G4SyzuD/aqXt6+jTfBJIFdgTeer91yf4
         i35lrLf0szkCg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D289C15C3487; Wed, 27 Jul 2022 22:46:53 -0400 (EDT)
Date:   Wed, 27 Jul 2022 22:46:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, bugzilla-daemon@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Message-ID: <YuH4nY6DGodheXoE@mit.edu>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
 <YuBKMLw6dpERM95F@magnolia>
 <20220727115307.qco6dn2tqqw52pl7@fedora>
 <20220727232224.GW3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727232224.GW3600936@dread.disaster.area>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 28, 2022 at 09:22:24AM +1000, Dave Chinner wrote:
> On Wed, Jul 27, 2022 at 01:53:07PM +0200, Lukas Czerner wrote:
> > While I understand the frustration with the fuzzer bug reports like this
> > I very much disagree with your statement about ethical and moral
> > responsibility.
> > 
> > The bug is in the code, it would have been there even if Wenqing Liu
> > didn't run the tool.
> 
> i.e. your argument implies they have no responsibility and hence are
> entitled to say "We aren't responsible for helping anyone understand
> the problem or mitigating the impact of the flaw - we've got our
> publicity and secured tenure with discovery and publication!"
> 
> That's not _responsible disclosure_.

So I'm going to disagree here.  I understand that this is the XFS
position, and so a few years back, the Georgia Tech folks who were
responsible for Janus and Hydra decided not to engage with the XFS
community and stopped reporting XFS bugs.  They continued to engage
with the ext4 community, and I found their reports to be helpful.  We
found and fixed quite a few bugs as a result of their work, and I
sponsored them to get some research funding from Google so they could
do more file system fuzzing work, because I thought their work was a
useful contribution.

I don't particularly worry about "responsible disclosure" because I
don't consider fuzzed file system crashes to be a particularly serious
security concern.  There are some crazy container folks who think
containers are just as secure(tm) as VM's, and who advocate allowing
untrusted containers to mount arbitrary file system images and expect
that this not cause the "host" OS to crash or get compromised.  Those
people are insane(tm), and I don't particularly worry about their use
cases.

If you have a Linux laptop with an automounter enabled it's possible
that when you plug in a USB stick containing a corrupted file system,
it could cause the system to crash.  But that requires physical access
to the machine, and if you have physical access, there is no shortage
of problems you could cause in any case.


> Public reports like this require immediate work to determine the
> scope, impact and risk of the problem to decide what needs to be
> done next.  All public disclosure does is start a race and force
> developers to have to address it immediately.

Nope.  I'll address these when I have time, and I don't consider them
to be particularly urgent, for the reasons described above.

I actually consider this fuzzer bug report to be particularly
well-formed.  Unlike Syzkaller, the file system image was in a
separate file, and wasn't embedded in the reproducer.c file in a way
that made it super-inconvenient to extract.  Furthermore, like the
Georgia Tech fuzzing reports, I appreciate that it was filed in
Bugzilla, since it won't easily get lost, with all of the information
that we need.

In any case, I've taken a closer look at this report, and it's
actually quite the interesting problem.  The issue is that we have an
non-leaf node in the extent tree where eh_entries header field is
zero.  This should never happen:

debugfs: extents <16>
Level Entries       Logical      Physical Length Flags
 0/ 2   1/  1     0 - 98030  9284          98031
 1/ 2   1/  0     0 - 98030  9282          98031 <======
          ^^^
 2/ 2   1/ 84     0 -     0  9730 -  9730      1 
 2/ 2   2/ 84     5 -     7  9739 -  9741      3 
 2/ 2   3/ 84    16 -    17  9750 -  9751      2 
 2/ 2   4/ 84    26 -    26  9768 -  9768      1 
 2/ 2   5/ 84    36 -    36  9787 -  9787      1 

This causes len to go negative in ext4_extent_insert_extent:

[   26.419401] ino 16 len -1 logical 98040 eh_entries 0 eh_max 84 depth 1

... which is what triggers the BUG_ON(len < 0).

What makes this particularly interesting is that neither the kernel
*nor* e2fsck is flagging this extent tree as corrupt.  So this is an
opportunity to improve both the kernel as well as fsck.ext4.

Again, it's not an *urgent* issue, but it is something that is worth
trying to improve in ext4 from the perspective of improving the
quality of our implementation.  And since it's not an urgent issue,
concerns of "responsble disclosure" don't arise, at least not in my
opinion.

					- Ted
