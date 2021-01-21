Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4431B2FE22C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 07:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbhAUF7g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 00:59:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38250 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726309AbhAUF7P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 00:59:15 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10L5wQmX024801
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 00:58:26 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E36AB15C35F5; Thu, 21 Jan 2021 00:58:25 -0500 (EST)
Date:   Thu, 21 Jan 2021 00:58:25 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 06/15] ext2fs: add new APIs needed for fast commits
Message-ID: <YAkYAeTL66Eq0OZE@mit.edu>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
 <20210120212641.526556-7-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120212641.526556-7-user@harshads-520.kir.corp.google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 20, 2021 at 01:26:32PM -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> This patch adds the following new APIs:
> 
> Count the total number of blocks occupied by inode including
> intermediate extent tree nodes.
> extern blk64_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
>                                        struct ext2_inode *inode);

I wonder if this should be something like this instead:

extern errcode_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
                                     struct ext2_inode *inode, blk64_t *ret_count);

The problem is that ext2fs_count_blocks() calls a whole series of
ext2fs functions which could return errors:

> +	errcode = ext2fs_extent_open2(fs, ino, inode, &handle);
> +	if (errcode)
> +		goto out;
> +
> +	errcode = ext2fs_extent_get(handle, EXT2_EXTENT_ROOT, &extent);
> +	if (errcode)
> +		goto out;

... and any of these functions could return an error.  So we need to
make sure errors are faithfully returned to the caller and handled
correctly, instead of just having ext2fs_count_blocks returning a
value of 0.


I then started taking a look at the users of ext2fs_count_blocks() in
e2fsck, and I ran into more concerns.  One of the problems here is
that some of these functions get called by kernel code --- and kernel
code has a different error handling convetion of negative errno's.

And in some cases, I see we are doing this:

static int ext4_fc_handle_inode(e2fsck_t ctx, struct ext4_fc_tl *tl)
{
	...
	
	ret = ext2fs_read_inode_full(ctx->fs, ino, (struct ext2_inode *)inode,
					inode_len);
	if (ret)
		goto out;
	...
out:
	ext2fs_free_mem(&inode);
	return ret;
}

The problem here is that ext2fs_read_inode_full() returns an
errcode_t, and this is getting cast to an int and returned as if it
were a kernel error code.

Also note that ext4_fc_replay() can return 0 or 1:

#define JBD2_FC_REPLAY_STOP		0
#define JBD2_FC_REPLAY_CONTINUE		1

Fortunately, none of the functions that ext4_fc_*() call seem to be
ones which could return in an ext2fs library returning EPERM (which is
errno 1), but you see the potential risks of conflating an errcode_t
and kernel negative errno convention.

This is going to be a bit tricky to deal with, since an errcode_t can
be a errno code, but it can also be one of the codes defined in
lib/ext2fs/ext2_err.et, which get translated to numbers like:

#define EXT2_ET_DIR_CORRUPTED                    (2133571363L)
#define EXT2_ET_SHORT_READ                       (2133571364L)
#define EXT2_ET_SHORT_WRITE                      (2133571365L)

(See lib/ext2fs/ext2_err.h in the build directory of e2fsprogs and the
com_err library found in lib/et.)

So what we may need to do is to create a function which does a simple
mapping of errcode_t values to negative errno's.  It doesn't need to
be exact; in fact, a first pass might just map all errcode_t's greater
than 256 to something like -EFAULT, and all normal errno's to -errno.

We might also want to have it print a diagnistic message to stderr
that prints error_message(retval) was encoutered in function __func__
at line __LINE__.  Hopefully in actual practice they won't happen
(unless a malicious attacker is feeding us a fuzzed file sytem), but
if it does, it would be good if there is a useful message so we can
actually debug what happened.

      	   	  	     	    	     - Ted
