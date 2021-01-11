Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BCC2F1E45
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jan 2021 19:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390426AbhAKSwC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Jan 2021 13:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbhAKSwC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 Jan 2021 13:52:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB635223C8;
        Mon, 11 Jan 2021 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610391080;
        bh=GnqAIDT2zbdj2sD4nrMIzONtU2qQ++gboXNZ4jbXnbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyow4n+Tm1Qa2vnaxd/nnds4Ey+nUFCfUKSGjaa9gVasDwovgU2xIqhqE9w5W51WP
         xky64IPEBJ1Ztkpeq+nAAktWRR+yD2ZakEYpA+jHBm0dIKZcrALP27aNOODZnNNpYo
         2PKzHhIlQPl9T22U4Evks5d0NXXpeJEcHS37bkvLZnJNREIGkwrF3pr6Z++udcDbsV
         VDu17uLIMLJIeo5BbX2xVErLNXWWBFC+w3K376Cv+eOVh6IZeG2n04VUYMeR9DHWU5
         nMPPtKZFj/8WB9ZqWXX9ZxsLOm4J8XxIN/Apzxe1gvTihQKdrnjQTTdikDVr4oRzGP
         oucwhJl4Flncg==
Date:   Mon, 11 Jan 2021 10:51:20 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Josh Triplett <josh@joshtriplett.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: Malicious fs images was Re: ext4 regression in v5.9-rc2 from
 e7bfb5c9bb3d on ro fs with overlapped bitmaps
Message-ID: <20210111185120.GA1164237@magnolia>
References: <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
 <20201008222259.GA45658@localhost>
 <20201009143732.GJ235506@mit.edu>
 <20210110184101.GA4625@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110184101.GA4625@amd>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jan 10, 2021 at 07:41:02PM +0100, Pavel Machek wrote:
> Hi!
> 
> On Fri 2020-10-09 10:37:32, Theodore Y. Ts'o wrote:
> > On Thu, Oct 08, 2020 at 03:22:59PM -0700, Josh Triplett wrote:
> > > 
> > > I wasn't trying to make a *new* general principle or policy. I was under
> > > the impression that this *was* the policy, because it never occurred to
> > > me that it could be otherwise. It seemed like a natural aspect of the
> > > kernel/userspace boundary, to the point that the idea of it *not* being
> > > part of the kernel's stability guarantees didn't cross my mind. 
> > 
> > >From our perspective (and Darrick and I discussed this on this week's
> > ext4 video conference, so it represents the ext4 and xfs maintainer's
> > position) is that the file system format is different.  First, the
> > on-disk format is not an ABI, and it is several orders more complex
> > than a system call interface.  Second, we make no guarantees about
> > what the file system created by malicious tools will do.  For example,
> > XFS developers reject bug reports from file system fuzzers, because

My recollection of this is quite different -- sybot was sending multiple
zeroday exploits per week to the public xfs list, and nobody at Google
was helping us to /fix/ those bugs.  Each report took hours of developer
time to extract the malicious image (because Dmitry couldn't figure out
how to add that ability to syzbot) and syscall sequence from the
reproducer program, plus whatever time it took to craft a patch, test
it, and push it through review.

Dave and I complained to Dmitry about how the community had zero input
into the rate at which syzbot was allowed to look for xfs bugs.  Nobody
at Google would commit to helping fix any of the XFS bugs, and Dmitry
would not give us better choices than (a) Google AI continuing to create
zerodays and leaving the community to clean up the mess, or (b) shutting
off syzbot entirely.  At the time I said I would accept letting syzbot
run against xfs until it finds something, and turning it off until we
resolve the issue.  That wasn't acceptable, because (I guess) nobody at
Google wants to put /any/ staff time into XFS at all.

TLDR: XFS /does/ accept bug reports about fuzzed and broken images.
What we don't want is make-work Google AIs spraying zeroday code in
public places and the community developers having to clean up the mess.

> > the v5 format has CRC checks, so randomly corrupted file systems
> > won't
> > crash the kernel.  Yes, this doesn't protect against maliciously
> > created file systems where the attacker makes sure the checksums are
> > valid, but only crazy people who think containers are just as secure
> 
> Well, it is not just containers. It is also USB sticks. And people who
> believe secure boot is good idea and try to protect kernel against
> root. And crazy people who encrypt pointers in dmesg. And...
> 
> People want to use USB sticks from time to time. And while I
> understand XFS is so complex it is unsuitable for such use, I'd still
> expect bugs to be fixed there.
> 
> I hope VFAT to be safe to mount, because that is very common on USB.
> 
> I also hope ext2/3/4 is safe in that regard.

None of them are, that's why you can't mount local filesystems as an
unprivileged user by default.  At a bare minimum you'd have to audit the
fs driver code to make sure it's robust against unexpected metadata; and
since filesystems store complex relational data across multiple indices,
you end up needing to hoist a full fsck into the mount process.

Or retain the current behavior, which is to delegate the trust decision
to the sysadmin.  It's not just an XFS thing.

--D

> Anyway it would be nice to have documentation explaining this. If I'm
> wrong about VFAT being safe, it would be good to know, and I guess
> many will be surprised that XFS is using different rules.
> 
> Best regards,
> 								Pavel
> -- 
> http://www.livejournal.com/~pavelmachek


