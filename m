Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB37D14F121
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jan 2020 18:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgAaROG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Jan 2020 12:14:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:34488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgAaROG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 31 Jan 2020 12:14:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 11B70AFB8;
        Fri, 31 Jan 2020 17:14:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 34FEC1E0D5D; Thu, 30 Jan 2020 17:25:30 +0100 (CET)
Date:   Thu, 30 Jan 2020 17:25:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: ext2fs_link() corrupting a directory
Message-ID: <20200130162530.GB15601@quack2.suse.cz>
References: <20200117122420.GJ17141@quack2.suse.cz>
 <20200117162927.GB448999@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117162927.GB448999@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 17-01-20 11:29:27, Theodore Y. Ts'o wrote:
> On Fri, Jan 17, 2020 at 01:24:20PM +0100, Jan Kara wrote:
> > 
> > I was tracking down a filesystem corruption issue with one proposed
> > xfstests testcase. After some debugging I've found out that the problem
> > actually is not in the kernel but rather in e2fsck (libext2fs
> > respectively). The testcase deletes lost+found, e2fsck recreates it. But
> > after the testcase / is h-tree directory. So ext2fs_link() creates
> > lost+found in / and clears EXT4_INODE_INDEX flag. Now because the
> > filesystem has metadata checksums, clearing the index flag needs to also
> > rewrite all directory blocks with h-tree index blocks because the layout
> > now needs to be different.  ext2fs_link() actually tries to do this in its
> > link_proc() but if the space for new directory entry is found before we
> > walk all the h-tree index blocks, we terminate the iteration and some index
> > blocks remain unconverted resulting in checksum errors and other weirdness
> > later on.
> 
> Ouch.  Nice catch.
> 
> I suspect we have a similar problem when the kernel discovers that the
> htree is corrupted; it will clear EXT4_INODE_INDEX flag, since before
> how we added metadata checksum, it was safe to do that.  Given our
> choice of where the stash the checksum, in order to not decrease the
> fanout of htree directories, this is no no longer safe to do.
> 
> I think what we will need to do is to set an in-memory "fallback"
> flag, which simply ignores the index blocks, but doesn't actually clear
> the EXT4_INODE_INDEX flag in the case where metadata_csum is enabled.

Yeah, that might be a good fix for the kernel.

> > The question is how to best fix this. The easiest fix is to just make
> > link_proc() iterate through all directory blocks when it needs to do the
> > index blocks conversion. But this seems somewhat stupid. Also there's
> > another problem with clearing EXT4_INODE_INDEX in ext2fs_link() - if the
> > directory has more than 65000 subdirectories, clearing EXT4_INODE_INDEX is
> > not allowed because large directory link count handling is supported only
> > for EXT4_INODE_INDEX directories.
> > 
> > So what do we do with this? For e2fsck, we could just link the new entry
> > into the directory and force rehashing later. But ext2fs_link() can be
> > called also from other tools and it should be a self-contained API... Any
> > ideas? Should we just bite the bullet and implement ext2fs_link() for
> > h-tree dirs properly?
> 
> Yes, I think that's what we are going to need to do; we had cheated
> and not bothered to implement htree support in ext2fs library, but if
> we're going to implement it for link_proc, we might as well also
> implement it for lookups as well.

JFYI (since I won't make today's ext4 call) I have full-featured insertion
into indexed dirs implemented, just need to write some decent testing
because it's quite a bit of new code and not exactly trivial...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
