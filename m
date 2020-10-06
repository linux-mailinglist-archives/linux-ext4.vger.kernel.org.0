Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0BE284323
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 02:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFAFF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Oct 2020 20:05:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49070 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725865AbgJFAFF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Oct 2020 20:05:05 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09604k5j009329
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Oct 2020 20:04:47 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D0627420107; Mon,  5 Oct 2020 20:04:45 -0400 (EDT)
Date:   Mon, 5 Oct 2020 20:04:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201006000445.GC4540@mit.edu>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
 <20201005173639.GA2311765@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005173639.GA2311765@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 10:36:39AM -0700, Darrick J. Wong wrote:
> > Commit e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in
> > ext4_setup_system_zone()") breaks mounting of read-only ext4 filesystems
> > with intentionally overlapping bitmap blocks.
> > 
> > On an always-read-only filesystem explicitly marked with
> > EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS, prior to that commit, it's safe to
> > point all the block and inode bitmaps to a single block
> 
> LOL, WHAT?
> 
> I didn't know shared blocks applied to fs metadata.  I thought that
> "shared" only applied to file extent maps being able to share physical
> bloctks.
 
My understanding matches Darrick's.  I was going to track down the
Google engineer who has most recently (as far as I know) enhanced
e2fsprogs's support of the shared block feature (see the commits
returned by "git log --author dvander@google.com contrib/android") but
he's apparently out of the office today.  Hopefully I'll be able to
track him down and ask about this tomorrow.

> Oookay.  So that's not how you create these shared block ext4s,
> apparently...

Yeah, they are created by the e2fsdroid program.  See sources in
contrib/e2fsdroid.  I took a quick look, and I don't see anything
there which is frobbing with with the bitmaps; but perhaps I'm missing
something, which is why I'd ask David to see if he knows anything
about this.

More to the point, if we are have someone who is trying to dedup or
otherwise frob with bitmaps, I suspect this will break "e2fsck -E
unshare_blocks /dev/XXX", which is a way that you can take a root file
system which is using shared_blocks, and turn it into something that
can actually be mount read/write.  This is something that I believe
was being used by AOSP "debug" or "userdebug" (I'm a bit fuzzy on the
details) so that Android developers couldn't actually modify the root
file system.  (Of course, you have to also disable dm-verity in order
for this to work....)

Unfortunately, e2fsdroid is currently not buildable under the standard
Linux compilation environment.  For the reason why, see:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=928551#75

The first step would be to teach e2fsprogs's configure to check for
libsparse, and to link against it if it's available.  But before we
could enable this by default for Linux distribution, we need to link
against libsparse using dlopen(), since most distro release engineers
would be.... cranky.... if mke2fs were to drag in some random Android
libraries that have to be installed as shared libraries in their
installers.  Which is the point of comment #75 in the above bug.

Since the only use of shared_blocks is for Android, since very few
other projects want a completely read-only root file system, and where
dedup is actually significantly helpful, we've never tried to make
this work outside of the Android context.  At least in theory, though,
it might be useful if we could create shared_block file systems using
"mke2fs -O shared_blocks -d /path/to/embedded-root-fs system.img 1G".
Patches gratefully accepted....

Cheers,

					- Ted
