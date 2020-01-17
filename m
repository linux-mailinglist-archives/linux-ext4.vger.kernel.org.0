Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16977140EF8
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2020 17:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgAQQ3s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jan 2020 11:29:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37501 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbgAQQ3s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jan 2020 11:29:48 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00HGTRnp012675
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jan 2020 11:29:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A70684207DF; Fri, 17 Jan 2020 11:29:27 -0500 (EST)
Date:   Fri, 17 Jan 2020 11:29:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: ext2fs_link() corrupting a directory
Message-ID: <20200117162927.GB448999@mit.edu>
References: <20200117122420.GJ17141@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117122420.GJ17141@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 17, 2020 at 01:24:20PM +0100, Jan Kara wrote:
> 
> I was tracking down a filesystem corruption issue with one proposed
> xfstests testcase. After some debugging I've found out that the problem
> actually is not in the kernel but rather in e2fsck (libext2fs
> respectively). The testcase deletes lost+found, e2fsck recreates it. But
> after the testcase / is h-tree directory. So ext2fs_link() creates
> lost+found in / and clears EXT4_INODE_INDEX flag. Now because the
> filesystem has metadata checksums, clearing the index flag needs to also
> rewrite all directory blocks with h-tree index blocks because the layout
> now needs to be different.  ext2fs_link() actually tries to do this in its
> link_proc() but if the space for new directory entry is found before we
> walk all the h-tree index blocks, we terminate the iteration and some index
> blocks remain unconverted resulting in checksum errors and other weirdness
> later on.

Ouch.  Nice catch.

I suspect we have a similar problem when the kernel discovers that the
htree is corrupted; it will clear EXT4_INODE_INDEX flag, since before
how we added metadata checksum, it was safe to do that.  Given our
choice of where the stash the checksum, in order to not decrease the
fanout of htree directories, this is no no longer safe to do.

I think what we will need to do is to set an in-memory "fallback"
flag, which simply ignores the index blocks, but doesn't actually clear
the EXT4_INODE_INDEX flag in the case where metadata_csum is enabled.

> The question is how to best fix this. The easiest fix is to just make
> link_proc() iterate through all directory blocks when it needs to do the
> index blocks conversion. But this seems somewhat stupid. Also there's
> another problem with clearing EXT4_INODE_INDEX in ext2fs_link() - if the
> directory has more than 65000 subdirectories, clearing EXT4_INODE_INDEX is
> not allowed because large directory link count handling is supported only
> for EXT4_INODE_INDEX directories.
> 
> So what do we do with this? For e2fsck, we could just link the new entry
> into the directory and force rehashing later. But ext2fs_link() can be
> called also from other tools and it should be a self-contained API... Any
> ideas? Should we just bite the bullet and implement ext2fs_link() for
> h-tree dirs properly?

Yes, I think that's what we are going to need to do; we had cheated
and not bothered to implement htree support in ext2fs library, but if
we're going to implement it for link_proc, we might as well also
implement it for lookups as well.

					- Ted
