Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3DB2CC5C8
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Dec 2020 19:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgLBSps (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Dec 2020 13:45:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53468 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730984AbgLBSps (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Dec 2020 13:45:48 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B2IiwaK013549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Dec 2020 13:44:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C4B32420136; Wed,  2 Dec 2020 13:44:58 -0500 (EST)
Date:   Wed, 2 Dec 2020 13:44:58 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/15] ext2fs: add new APIs needed for fast commits
Message-ID: <20201202184458.GJ390058@mit.edu>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
 <20201120191606.2224881-7-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120191606.2224881-7-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 20, 2020 at 11:15:57AM -0800, Harshad Shirwadkar wrote:
> This patch adds the following new APIs:
> 
> Count the total number of blocks occupied by inode including
> intermediate extent tree nodes.
> extern blk64_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
>                                        struct ext2_inode *inode);
> 
> Convert ext3_extent to ext2fs_extent.
> extern void ext2fs_convert_extent(struct ext2fs_extent *to,
>                                        struct ext3_extent *from);

So one of the reasons why I've intentionally never exposed "struct
ext3_extent" in the libext2fs interface is because that's an on-disk
structure which I keep hoping we might change someday --- for example,
to allow for 64-bit logical block numbers so we can create ext4 files
greater than 2**32 blocks.  It might be that some other future
enhancement, such as say, reflinks (depending on how we implement
them), or reverse pointers, might also require making changes to the
on-disk format.

The kernel code has the on-disk format and the various logical
manipulations of the extent tree hopelessly entangled with each other,
which means changing the kernel code to support more than one on-disk
extent structure is going to be **hard**.  But in the userspace code,
all of the knowledge about the on-disk structure is abstracted away
inside lib/ext2fs/extent.c.

It may very well be that for fast commit, we're going to need to crack
open that abstraction barrier a bit.  But let's make sure the function
name makes it clear that what we are doing here is converting between
a particular on-disk encoding and the ext2fs abtract extent type.
"ext2fs_convert_extent" doesn't exactly make this clear.

It might also be that what should do is include a pointer to the fs
and inode structures, and call this something like
"ext2fs_{decode,encode}_extent()", and pass in the on-disk format via
a void *.  We might also want to have some kind of
ext2fs_validate_extent() function which takes a void * and validates
the on-disk structure to make sure it's sane.

What do you think?

					- Ted
