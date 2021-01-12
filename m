Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28932F3DB9
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jan 2021 01:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbhALVpD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jan 2021 16:45:03 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42051 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388340AbhALVo7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jan 2021 16:44:59 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10CLhUgC011740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 16:43:31 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8A66015C3453; Tue, 12 Jan 2021 16:43:30 -0500 (EST)
Date:   Tue, 12 Jan 2021 16:43:30 -0500
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
Message-ID: <X/4YArRJMgGjSyZY@mit.edu>
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
> > >From our perspective (and Darrick and I discussed this on this week's
> > ext4 video conference, so it represents the ext4 and xfs maintainer's
> > position) is that the file system format is different.  First, the
> > on-disk format is not an ABI, and it is several orders more complex
> > than a system call interface.  Second, we make no guarantees about
> > what the file system created by malicious tools will do.  For example,
> > XFS developers reject bug reports from file system fuzzers, because
> > the v5 format has CRC checks, so randomly corrupted file systems won't
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

Ext4 will fix file system fuzzing attack bugs on a best efforts basis.
That is, when I have time, I've been known to stay up late to bugs
reported by fuzzers.  I hope ext4 is safe, but I'm not going to make
any guarantees that it is Bug-Free(tm).  If you want to trust it in
that way, you do so at your risk.

As far as VFS is concerned, I'm not aware of anyone who has been
working on fuzz-proofing VFAT, and looking at the Vault 2016 for
"American Fuzzy Lop"[1] while VFAT wasn't specifically tested, for the
vast majority of file systems, the "time to first bug" typically
ranged from seconds to minutes, with the exception of XFS and ext4
(where it was roughly 2 hours).  The specific bugs which triggered in
the 2016 AFL presentation have been fixed, at least for the file
systems which get regular maintainer attention, but this is why I try
to caution people not to count on file systems being proof against
maliciously formatted images.

[1] https://events.static.linuxfound.org/sites/events/files/slides/AFL%20filesystem%20fuzzing,%20Vault%202016_0.pdf

> Anyway it would be nice to have documentation explaining this. If I'm
> wrong about VFAT being safe, it would be good to know, and I guess
> many will be surprised that XFS is using different rules.

Using USB sticks is fine, so long as you trust the provenance of the
drive.  If you take a random USB stick that is handed to you by
someone whom you don't trust implicitly, or worse, that you picked up
abandoned on the sidewalk, there have been plenty of articles which
describe why this is a REALLY BAD IDEA, and even if you ignore
OS-level vuleranbilities, there are also firwmare and hardware based
vulerabilities that would put your computer at risk.  See [2] and [3]
for more details; there's a reason why I've visited at least one
financial institution where they put epoxy in USB ports to prevent
clueless workers from potentially compromising the bank's computers.

[2] https://www.redteamsecure.com/blog/usb-drop-attacks-the-danger-of-lost-and-found-thumb-drives/
[3] https://www.bleepingcomputer.com/news/security/heres-a-list-of-29-different-types-of-usb-attacks/

As far as documentation is concerned, how far should we go?  Should
there be a warning in the execve(2) system call man page that you
shouldn't download random binaries from the network and execute them?  :-)

Cheers,

					- Ted
