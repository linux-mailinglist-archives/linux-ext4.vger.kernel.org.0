Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED75F287EBD
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 00:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgJHWjI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 18:39:08 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34035 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgJHWjI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 18:39:08 -0400
X-Originating-IP: 67.5.25.97
Received: from localhost (unknown [67.5.25.97])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 83D1CC0007;
        Thu,  8 Oct 2020 22:39:01 +0000 (UTC)
Date:   Thu, 8 Oct 2020 15:38:58 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201008223858.GC45658@localhost>
References: <20201006003216.GB6553@localhost>
 <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
 <20201008175448.GA6532@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008175448.GA6532@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 08, 2020 at 10:54:48AM -0700, Darrick J. Wong wrote:
> IMO, the prominent free software filesystem projects offer (at least)
> four layers of social structures to keep everyone on the same page,
> including people writing competing implementations.

(I certainly hope that this isn't a *competing* implementation. It's
more that it serves a different purpose than the existing tools.)

> The first is "Does
> everything we write still work with the kernel", which I guess you
> clearly did since you're complaining about this change in 5.9-rc2.

Right.

> The second layer is "Does it pass fsck?" which, given that you're asking
> for changes to e2fsck elsewhere in this thread and I couldn't figure out
> how to generate a shared-bitmaps ext4 fs that didn't also cause e2fsck
> to complain about the overlap doesn't make me confident that you went
> beyond the first step before shipping something.

I did ensure that, other than the one top-level complaint that the
bitmaps overlapped, I got no complaints from e2fsck. I also confirmed
that with a patch to that one item, e2fsck passed with no issues.

> The third layer is consulting the ondisk format documentation to see if
> it points out anything that the kernel or fsck didn't notice.  That
> one's kind of on Ted for not updating Documentation/ to spell out what
> SHARED_BLOCKS actually means, but that just leads me to the fourth thing.

I've been making *extensive* use of Documentation/filesystems/ext4 by
the way, and I greatly appreciate it. I know you've done a ton of work
in that area.

> The fourth layer is emailing the list to ask "Hey, I was thinking of
> ___, does anyone see a problem with my interpretation?".  That clearly
> hasn't been done for shared bitmaps until now, which is all the more
> strange since you /did/ ask linux-ext4 about the inline data topic
> months ago.

That one was on me, you're right. Because Ted is the maintainer of
e2fsprogs in Debian, and conversations about ext4 often happen in the
Debian BTS, reporting a bug on e2fsprogs there felt like starting an
upstream conversation. That was my mistake; in the future, I'll make
sure that things make it to linux-ext4. I already did so for
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=971014 , and I
*should* have gone back and done so for the shared bitmap blocks issue.

> ext* and XFS have been around for 25 years.  The software validation of
> both is imperfect and incomplete because the complexity of the ondisk
> formats is vast and we haven't caught up with the technical debt that
> resulted from not writing rigorous checks that would have been very
> difficult with mid-90s hardware.  I know, because I've been writing
> online checking for XFS and have seen the wide the gap between what the
> existing software looks for and what the ondisk format documentation
> allows.
> 
> The only chance that we as a community have at managing the complexity
> of a filesystem is to use those four tools I outlined above to try to
> keep the mental models of everyone who participates in close enough
> alignment.  That's how we usually avoid discussions that end in rancor
> and confusion.
> 
> That was a very long way of reiterating "If you're going to interpret
> aspects of the software, please come talk to us before you start writing
> code".  That is key to ext4's long history of compatibility, because a
> project cannot maintain continuity when actors develop conflicting code
> in the shadows.  Look at all the mutations FAT and UFS that have
> appeared over the years-- the codebases became a mess as a result.

Understood, agreed, and acknowledged. I'll make sure that any future
potentially "adventurous" filesystem experiments get discussed on
linux-ext4 first, not just in a distro bugtracker with a limited
audience.

> > > the head", and continued with the notion that anything other than
> > > e2fsprogs making something to be mounted by mount(2) and handled by
> > > fs/ext4 is being "inflicted", and if the goal didn't still seem to be
> > > "how do we make it go away so that only e2fsprogs and the kernel ever
> > > touch ext4". I started this thread because I'd written some userspace
> > > code, a new version of the kernel made that userspace code stop working,
> > > so I wanted to report that the moment I'd discovered that, along with a
> > > potential way to address it with as little disrupton to ext4 as
> > > possible.
> 
> Ted: I don't think it's a good idea to make SHARED_BLOCKS disable block
> validity checking by default.  You could someday enable users to write
> to block-sharing files by teaching ext4 how to COW, at which point you'd
> need correct bitmaps and block validity to prevent accidental overwrite
> of critical metadata.  At that point you'd either be stuck with the
> precedent that SHARED_BLOCKS implies noblock_validity, or you'd end up
> breaking Josh's images again.

That's a fair point (though I think a writable COW version of
SHARED_BLOCKS would need a different flag). It'd make more sense to key
this logic off of RO_COMPAT_READONLY or similar. But even better:

> "noblock_validity" in the superblock mount options field of the images
> you create.

Yeah, I can do that. That's a much better solution, thank you. It would
have been problematic to have to change the userspace that mounts the
filesystem to pass new mount options ("noblock_validity") for the new
kernel. But if I can embed it in the filesystem, that'll work.

I'll do that, and please feel free to drop the original proposed patch
as it's no longer needed. Thanks, Darrick.

- Josh Triplett
