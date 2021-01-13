Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463C52F4385
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jan 2021 06:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbhAMFKV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 00:10:21 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46196 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725858AbhAMFKV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jan 2021 00:10:21 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10D59GRj008260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 00:09:17 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6FBB915C3453; Wed, 13 Jan 2021 00:09:16 -0500 (EST)
Date:   Wed, 13 Jan 2021 00:09:16 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: Malicious fs images was Re: ext4 regression in v5.9-rc2 from
 e7bfb5c9bb3d on ro fs with overlapped bitmaps
Message-ID: <X/6AfBJuX/ye+yt/@mit.edu>
References: <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
 <20201008222259.GA45658@localhost>
 <20201009143732.GJ235506@mit.edu>
 <20210110184101.GA4625@amd>
 <X/4YArRJMgGjSyZY@mit.edu>
 <20210112222840.GA28214@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112222840.GA28214@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 12, 2021 at 11:28:40PM +0100, Pavel Machek wrote:
> 
> This thread suggested that kernel is _not_ supposed to be robust
> against corrupt filesystems (because fsck is not integrated in
> kernel). Which was news to me (and I'm not the person that needs
> warning in execve documentation).

Define "supposed to be".  In the ideal world, the kernel should be
robust against corrupt file systems.  In the ideal world, hard drives
would never die, and memory bits would never get flipped due to cosmic
rays, and so Intel would be correct that consumers don't need ECC
memory.  In the ideal world, drivers would never make mistakes, and so
seat belts would be completely unnecessasry.

Unfortunately, we live in the real world.

And so there is risk associated with using various technologies, and
that risk is not a binary 0% vs 100%.  In my mind, assuming that file
systems are robust against maliciously created images is much like
driving around without a seat belt.  There are plenty of people who
drive without seat belts for years, and they haven't been killed yet.
But it's not something *I* would do.  But hey, I also spent extra
money to buy a personal desktop computer with ECC memory, and I don't
go bicycling without a helment, either.

You're free to decide what *you* want to do.  But I wouldn't take a
random file system image from the Net and mount it without running
fsck on the darned thing first.

As far as secure boot is concerned, do you know how many zero days are
out there with Windows machines?  I'm pretty sure there are vast
numbers.  There are even more systems where the system adminsitrators
haven't bothered to install latest updates, as well.

> And if we have filesystems where corrupt image is known to allow
> arbitrary code execution, we need to

Define *known*.  If you look at the syzbot dashboard, there are
hundreds of reproducers where root is able to crash a Linux server.
Some number of them will almost certainly be exploitable.  The problem
is it takes a huge amount of time to analyze them, and Syzbot's file
system fuzzers are positively developer-hostile to root cause.  So
usually I find and fix ext4 file system fuzzing reports via reports
from other fuzzers, and then eventually syzbot realizes that the
reproducer no longer works, and it gets closed out.

I'd certainly be willing to bet a beer or two that there are
vulnerabilities in VFAT, but do I *know* that to be the case?  No,
because I don't have the time to take a syzbot report relating to a
file system and root cause it.  The time to extract out the image, and
then figure out how to get a simple reproducer (as opposed to the mess
that a syzbot reproducer that might be randomly toggling a network
bridge interface on one thread while messing with a file system image
on another) is easily 10-20 times the effort to actually *fix* the bug
once we're able to come up with a trivial reproducer with a file
system image which is a separate file so we can analyze it using file
system debugging tools.

I'm also *quite* confident that the NSA, KGB, and other state
intelligence agencies have dozens of zero days for Windows, Linux,
etc.  We just don't know in what subsystem they are in, so we can't
just "disable them when secure boot is enabled".

						- Ted
