Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93615875EF
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 05:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiHBD0I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Aug 2022 23:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHBD0G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Aug 2022 23:26:06 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5739F32EDA
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 20:26:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 024A562CF42;
        Tue,  2 Aug 2022 13:26:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oIiXf-0088BG-5D; Tue, 02 Aug 2022 13:25:59 +1000
Date:   Tue, 2 Aug 2022 13:25:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, bugzilla-daemon@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Message-ID: <20220802032559.GB3861211@dread.disaster.area>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
 <YuBKMLw6dpERM95F@magnolia>
 <20220727115307.qco6dn2tqqw52pl7@fedora>
 <20220727232224.GW3600936@dread.disaster.area>
 <YuH4nY6DGodheXoE@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuH4nY6DGodheXoE@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62e89949
        a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
        a=IkcTkHD0fZMA:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=ZNkqnt-p47sspy0wAM4A:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 27, 2022 at 10:46:53PM -0400, Theodore Ts'o wrote:
> On Thu, Jul 28, 2022 at 09:22:24AM +1000, Dave Chinner wrote:
> > On Wed, Jul 27, 2022 at 01:53:07PM +0200, Lukas Czerner wrote:
> > > While I understand the frustration with the fuzzer bug reports like this
> > > I very much disagree with your statement about ethical and moral
> > > responsibility.
> > > 
> > > The bug is in the code, it would have been there even if Wenqing Liu
> > > didn't run the tool.
> > 
> > i.e. your argument implies they have no responsibility and hence are
> > entitled to say "We aren't responsible for helping anyone understand
> > the problem or mitigating the impact of the flaw - we've got our
> > publicity and secured tenure with discovery and publication!"
> > 
> > That's not _responsible disclosure_.
> 
> So I'm going to disagree here.  I understand that this is the XFS
> position,

Nope, nothing to do with XFS here - addressing how filesystem
fuzzing is approached and reported this is much wider engineering
and security process problem.

> and so a few years back, the Georgia Tech folks who were
> responsible for Janus and Hydra decided not to engage with the XFS
> community and stopped reporting XFS bugs.

That is at odds with the fact they engaged us repeatedly over a
period of 6 months to report and fix all the bugs the Janus
framework found.

Indeed, the Acknowledgements from the Janus paper read:

"We thank the anonymous reviewers, and our shepherd,
Thorsten Holz, for their helpful feedback. We also thank all
the file system developers, including Theodore Ts’o, Darrick
J. Wong, Dave Chinner, Eric Sandeen, Chao Yu, Wenruo
Qu and Ernesto A. Fernández for handling our bug reports."

Yup, there we all are - ext4, XFS and btrfs all represented.

And, well, we didn't form the opinion that fuzzer bugs should be
disclosed responsibly until early 2021. The interactions with GATech
researchers running the Janus project was back in 2018 and we
addressed all their bug reports quickly and with a minimum of fuss.

It's somewhat disingenious to claim that a policy taht wasn't
formulated until 2021 had a fundamental influence on decisions
made in late 2018....

> They continued to engage
> with the ext4 community, and I found their reports to be helpful.  We
> found and fixed quite a few bugs as a result of their work,

Yup, same with XFS - we fixed them all pretty quickly, and even so
still had half a dozen CVEs raised against those XFS bugs
post-humously by the linux security community. And I note that ext4
also had about a dozen CVEs raised against the bugs that Janus
found...

I'll also quote from the Hydra paper on their classification of the
bugs they were trying to uncover:

"Memory errors (ME). Memory errors are common in file
systems. Due to their high security impact, [...]"

The evidence at hand tells us that filesystem fuzzer bugs have
security implications. Hence we need to treat them accordingly.

> and I
> sponsored them to get some research funding from Google so they could
> do more file system fuzzing work, because I thought their work was a
> useful contribution.

I guess the funding you are talking about is for the Hydra paper
that GATech published later in 2019? The only upstream developer
mentioned in the acknowledgements is you, and I also note that
funding from Google is disclosed, too. True, they didn't engage with
upstream XFS at all during that work, or since, but I think there's
a completely different reason to what you are implying...

i.e., I don't think the "not engaging with upstream XFS" has
anything to do with reporting and fixing the bugs of the Janus era.
To quote the Hydra paper, from the "experimental setup" section:

"We also tested XFS, GFS2, HFS+, ReiserFS, and VFAT, but found only
memory-safety bugs."

Blink and you miss it, yet it's possibly the most important finding
in the paper: Hydra didn't find any crash inconsistencies, no
logic bugs, nor any POSIX spec violations in XFS.

IOWs, Hydra didn't find any of the problems the fuzzer was supposed
to find in the filesystems it was run on.  There was simply nothing
to report to upstream XFS, and nothing to write about in the paper.

It's hardly a compelling research paper that reports "new algorithm
found no new bugs at all". Yet that's what the result was with Hydra
on XFS.

Let's consider that finding in the wider context of academia
looking into new filesystem fuzzing techniques. If you have a
filesystem that is immune to fuzzing, then it doesn't really help
you prove that you've advanced the start of the fuzzing art, does
it?

Hence a filesystem that is becoming largely immmune to randomised
fuzzing techniques then becomes the least appealing research target
for filesystem fuzzing. If a new fuzzer can't find bugs in a complex
filesystem that we all know is full of bugs, it doesn't make for
very compelling research, does it?

Indeed, the Hydra paper spends a lot of time at the start explaining
how fstests doesn't exercise filesysetms using semantic fuzzer
techniques that can be used to discover format corruption bugs.
However, it ignores the fact that fstests contains extensive
directed structure corruption based fuzzing tests for XFS. This is
one of the reasons why Hydra didn't find any new format fuzzing bugs
- it's semantic algorithms and crafted images didn't exercise the
XFS in a way that wasn't already covered by fstests.

IOWs, if a new fuzzer isn't any better than what we already have in
fstests, then the new fuzzer research is going to come up a great
big donut on XFS, as we see with Hydra.

Hence, if we are seeing researchers barely mention XFS because their
new technique is not finding bugs in XFS, and we see them instead
focus on ext4, btrfs, and other filesystems that do actually crash
or have inconsistencies, what does that say about how XFS developers
have been going about fuzz testing and run-time on-disk format
validation? What does that say about ext4, f2fs, btrfs, etc? What
does that say about the researcher's selective presentation of the
results?

IOWs, the lack of upstream XFS community engagement from fuzzer
researchers has nothing to do with interactions with the XFS
community - it has everything to do with the fact we've raised the
bar higher than new fuzzer projects can reach in a short period of
time. If the research doesn't bear fruit on XFS, then the
researchers have no reason to engage the upstream community during
the course of their research.....

The bottom line is that we want filesystems to be immune to fuzzer
fault injection.  Hence if XFS is doing better at rejecting fuzzed
input than other linux filesystems, then perhaps the XFS developers
are doing something right and perhaps there's something to the
approach they take and processes they have brought to filesystem
fuzzing.

The state of the art is not always defined by academic research
papers....

> I don't particularly worry about "responsible disclosure" because I
> don't consider fuzzed file system crashes to be a particularly serious
> security concern.  There are some crazy container folks who think
> containers are just as secure(tm) as VM's, and who advocate allowing
> untrusted containers to mount arbitrary file system images and expect
> that this not cause the "host" OS to crash or get compromised.  Those
> people are insane(tm), and I don't particularly worry about their use
> cases.

They may be "crazy container" use cases, but anything we can do to
make that safer is a good thing.


But if the filesystem crashes or has a bug that can be exploited
during the mount process....

> If you have a Linux laptop with an automounter enabled it's possible
> that when you plug in a USB stick containing a corrupted file system,
> it could cause the system to crash.  But that requires physical access
> to the machine, and if you have physical access, there is no shortage
> of problems you could cause in any case.

Yes, the real issue is that distros automount filesystems with
"noexec,nosuid,nodev". They use these mount options so that the OS
protects against trojanned permissions and binaries on the untrusted
filesystem, thereby preventing most of the vectors an untrusted
filesystem can use to subvert the security of the system without the
user first making an explicit choice to allow the system to run
untrusted code.

But exploiting an automoutner does not require physical access at
all. Anyone who says this is ignoring the elephant in the room:
supply chain attacks.

All it requires is a supply chain to be subverted somehere, and now
the USB drive that contains the drivers for your special hardware
from a manufacturer you trust (and with manufacturer
trust/anti-tamper seals intact) now powns your machine when you plug
it in.

Did the user do anything wrong? No, not at all. But they could
have a big problem if filesystem developers don't care about
threat models like subverted supply chains and leave the door wide
open even when the user does all the right things...

> > Public reports like this require immediate work to determine the
> > scope, impact and risk of the problem to decide what needs to be
> > done next.  All public disclosure does is start a race and force
> > developers to have to address it immediately.
> 
> Nope.  I'll address these when I have time, and I don't consider them
> to be particularly urgent, for the reasons described above.

Your choice, but....

> I actually consider this fuzzer bug report to be particularly
> well-formed.

.... that's not the issue here, and ....

> In any case, I've taken a closer look at this report, and it's

.... regardless of whether you consider it urgent or not, you have
now gone out of your way to determine the risk the reported problem
now poses.....

> Again, it's not an *urgent* issue,

.... and so finally we have an answer to the risk and scope
question. This should have been known before the bug was made
public.

Giving developers a short window to determine the scope of the
problem before it is made public avoids all the potential problems
of the corruption bug having system security implications. It
generally doesn't take long to determine this (especially when the
reporter has a reproducer), but it needs to be done *before* the
flaw is made public...

Anything that can attract a CVE (and filesystem fuzzer bugs do,
indeed, attract CVEs) needs to be treated as a potential security
issue, not as a normal bug.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
