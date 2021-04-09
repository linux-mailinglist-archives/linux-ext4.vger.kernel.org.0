Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46679359235
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 04:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhDICv3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 22:51:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57647 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232616AbhDICv2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 22:51:28 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1392p9M5030936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Apr 2021 22:51:09 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4A06215C3B12; Thu,  8 Apr 2021 22:51:09 -0400 (EDT)
Date:   Thu, 8 Apr 2021 22:51:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: wipe filename upon file deletion
Message-ID: <YG/BHfB3arzT4x6W@mit.edu>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-2-leah.rumancik@gmail.com>
 <YG4lG2B9Wf4t6IfA@gmail.com>
 <YG59GE+8bhtVLOQr@mit.edu>
 <20210408052155.GK1990290@dread.disaster.area>
 <YG9YqkHfslwAdh2/@mit.edu>
 <20210409000207.GJ22091@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409000207.GJ22091@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 08, 2021 at 05:02:07PM -0700, Darrick J. Wong wrote:
> > In the ideal world, sure, all or most of them would agree that they
> > *shouldn't* be storing any kind of PII at rest unencrypted, but they
> > can't be sure, and so from the perspective of keeping their audit and
> > I/T compliance committees happy, this requirement is desirable from a
> > "belt and suspenders" perspective.
> > 
> > > This seems like a better fit for FITRIM than anything else.
> > > 
> > > Ooohh. We sure do suck at APIs, don't we? FITRIM has no flags field,
> > > so we can't extend that.
> > 
> > I don't have any serious objections to defining FITRIM2; OTOH, for
> 
> Er, are we talking about the directory name wiping, or the journal
> discarding?

Sorry, I was talking about journal wiping.  The conflation is because
the reason why we want to wipe the journal is because of the directory
names in the journal, so the two are very much connected for our use
case, but yes, directory names in directories is very from directory
names in the journal.

We don't actually need any kind of interface for wiping names in
directories, since it doesn't cost us anything to unconditionally wipe
the directory entries as opposed to just setting the inode number to
zero.

> I didn't think it was any more difficult than changing xfs_removename to
> zero out the name and ftype fields at the same time it adds the whiteout
> to the dirent.  But TBH I haven't thought through this too deeply.
> 
> I /do/ think that if you ever want to add "secure" deletion to XFS, I'd
> want to do it by implementing FS_SECRM_FL for XFS, and not by adding
> more mount options.

The original meaning of FS_SECRM_FL was that the data blocks would be
zero'ed --- when the inode was deleted.  We don't intend to have a
mount option for ext4 for zero'ing the directory entry, since it
really doesn't cost us anything to memset the directory entry to zero
at unlink time.  I guess for a DAX file system, zero'ing the directory
entry might cost a an extra cache line write, but for block-oriented
devices, for us it's essentially cost-free --- so why add an extra
mount option, and instead just zero the directory entry of everything
other than rec_len?

> Question -- does e2image have the ability to obscure names like
> xfs_metadump will do if you don't pass it "-o" ?

Yes, e2image has had the -s option to scramble file names since
E2fsprogs 1.36 (February, 2005).

						- Ted
