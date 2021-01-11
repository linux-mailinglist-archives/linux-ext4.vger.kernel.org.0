Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AF2F1FA5
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jan 2021 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbhAKTj7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Jan 2021 14:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbhAKTj7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 Jan 2021 14:39:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAD8E22BEF;
        Mon, 11 Jan 2021 19:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610393958;
        bh=KZ1tcssLWBKHdqy7Whf+ZpeaQJYSP4Yx5gwpkCQHCh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKgWgrLdvinyaTUIkOWxcm/2XBCS3ibBdprg4hD4FVi7CWts9lw1Idn2UQZ4b4WDu
         CqI7ygwTUft+3/7hg1rjyccxk+eMpzjs3wF48QZtDXQgcUqpZSXJUjBGo7hWWFkbQN
         6auwz5JhDd0PmGKG62OAZTD97pN+bB66wJefWEGlnbzZUeLsYKcsMqP5lLS1kz4Rp6
         r1vmWa7j7GzY6/Pf7/an9ic4TJesMRlVdZE13KhtNmDGe7fjZug4NKERsRXozWU+Ld
         sRgwFiz98KH1do3Sqq4FSN771axpq/39ElCeFV3eL08DTzaks3gXZynqqd1ztzpIjx
         riBSGS+b1A2YA==
Date:   Mon, 11 Jan 2021 11:39:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Josh Triplett <josh@joshtriplett.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: Malicious fs images was Re: ext4 regression in v5.9-rc2 from
 e7bfb5c9bb3d on ro fs with overlapped bitmaps
Message-ID: <X/ypZFpMMCnHZtd4@sol.localdomain>
References: <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
 <20201008222259.GA45658@localhost>
 <20201009143732.GJ235506@mit.edu>
 <20210110184101.GA4625@amd>
 <20210111185120.GA1164237@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111185120.GA1164237@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 11, 2021 at 10:51:20AM -0800, Darrick J. Wong wrote:
> On Sun, Jan 10, 2021 at 07:41:02PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > On Fri 2020-10-09 10:37:32, Theodore Y. Ts'o wrote:
> > > On Thu, Oct 08, 2020 at 03:22:59PM -0700, Josh Triplett wrote:
> > > > 
> > > > I wasn't trying to make a *new* general principle or policy. I was under
> > > > the impression that this *was* the policy, because it never occurred to
> > > > me that it could be otherwise. It seemed like a natural aspect of the
> > > > kernel/userspace boundary, to the point that the idea of it *not* being
> > > > part of the kernel's stability guarantees didn't cross my mind. 
> > > 
> > > >From our perspective (and Darrick and I discussed this on this week's
> > > ext4 video conference, so it represents the ext4 and xfs maintainer's
> > > position) is that the file system format is different.  First, the
> > > on-disk format is not an ABI, and it is several orders more complex
> > > than a system call interface.  Second, we make no guarantees about
> > > what the file system created by malicious tools will do.  For example,
> > > XFS developers reject bug reports from file system fuzzers, because
> 
> My recollection of this is quite different -- sybot was sending multiple
> zeroday exploits per week to the public xfs list, and nobody at Google
> was helping us to /fix/ those bugs.Each report took hours of developer
> time to extract the malicious image (because Dmitry couldn't figure out
> how to add that ability to syzbot) and syscall sequence from the
> reproducer program, plus whatever time it took to craft a patch, test
> it, and push it through review.
> 
> Dave and I complained to Dmitry about how the community had zero input
> into the rate at which syzbot was allowed to look for xfs bugs.  Nobody
> at Google would commit to helping fix any of the XFS bugs, and Dmitry
> would not give us better choices than (a) Google AI continuing to create
> zerodays and leaving the community to clean up the mess, or (b) shutting
> off syzbot entirely.  At the time I said I would accept letting syzbot
> run against xfs until it finds something, and turning it off until we
> resolve the issue.  That wasn't acceptable, because (I guess) nobody at
> Google wants to put /any/ staff time into XFS at all.
> 
> TLDR: XFS /does/ accept bug reports about fuzzed and broken images.
> What we don't want is make-work Google AIs spraying zeroday code in
> public places and the community developers having to clean up the mess.

syzkaller is an open source project that implements a coverage-guided fuzzer for
multiple operating system kernels; it's not "Google AI".

Anyone can run syzkaller (either by itself, or as part of a syzbot instance) and
find the same bugs.

- Eric
