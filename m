Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EB9BAE3
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Aug 2019 04:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfHXCbQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Aug 2019 22:31:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43169 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725807AbfHXCbQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Aug 2019 22:31:16 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7O2VAZb013443
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 22:31:11 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1358142049E; Fri, 23 Aug 2019 22:31:10 -0400 (EDT)
Date:   Fri, 23 Aug 2019 22:31:10 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: attempt to shrink directory on dentry removal
Message-ID: <20190824023110.GB19348@mit.edu>
References: <20190821182740.97127-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821182740.97127-1-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 21, 2019 at 11:27:40AM -0700, Harshad Shirwadkar wrote:
> As of now, we only support non-indexed directories and indexed
> directories with no intermediate dx nodes. 

From my testing, it doen't work on non-indexed directories; the
problem is in the is_empty_dirent_block() function.

> This technique can also be used to remove intermediate dx nodes. But
> it needs a little more interesting logic to make that happen since
> we don't store directory entry name in intermediate nodes.

Actually, that's not the problem.  An empty dx node is not allowed; in
a two-level htree directory, if removing an empty leaf node becomes
causes its parent dx node to become empty, we need to remove the
parent dx node immediately.  Which is fine, because when we did the
dx_probe, we know the path from the root to the leaf node.

But removing the parent dx node means we need to be able to remove an
empty block from the directory, regardless whether it is at the end of
the directory or not.  OK, so how to do that?

First of all, how to do find any directory block's parent?  If it is a
leaf node, we can simply calculate the hash on the first directory
entry (whether it is "dead" or not), and then do a lookup based on
that hash.  For an intermediate dx node, we can do the same thing,
since a dx node is simply a list of hashes and block numbers.  The
first hash in the dx node can be used to do a htree lookup, and that
will give us the full path from the root of the htree to the dx node.

So, suppose we delete a file, and that causes a leaf node to become
empty.  We can actually shrink the directory right then and there, and
not wait until the last block in the directory beomes empty.  How do we do that?

1) We'll call the logical block number of that empty leaf block Empty,
   and the block number of the parent of that empty leaf block Parent(Empty).
   We'll also call the logical block number of the last entry in the
   directory, Last.

2) Remove the pointer to Empty from Parent(Empty).  If that causes
   Parent(Empty) to become empty, we also need to remove the
   reference to Parent(Empty) in Parent(Parent(Empty)).  (And for 3
   level htree directories, which are present in Largedir
   directories, we might also need to do that one more level up.)

3) To free the directory block Empty, if Empty != Last, we copy the
   contents of Last into the directory block Empty, and then determine
   Parent(Last), and find the pointer to Last, and update it to be
   Empty.  At this point, the last directory block is not in use, so
   we can release the last directory block, and shrink the size of the
   directory by one block.

4) If we need to free Parent(Empty) because it was emptied by step 2,
   follow the procedure in step 3.

This has a couple of benefits.  The first is that it will work for
large dx directories, where directory shrinking is most needed.
Secondly, also allows the directory shrinking to take gradually place
as the directory is emptied, instead waiting until last directory
block is empty.  (And for multi-level dx directories that have been
optimized via e2fsck -fD, the above is needed to allow shrinking from
the end won't work at all.  Why that is the case is left as an
exercise to the reader.  Hint: try creating a very large directory and
optimize it using e2fsck -fD, and see where the index nodes end up.)

BTW, for non-indexed directories, we must always shrink from the end.
We can't play games with swapping with the last directory block,
unless we can guarantee that (a) there are no open fd's on the
directories (since there might be telldir/seekdir cookies that have to
stay valid), and (b) the directory isn't exported via NFS.  Given that
establishes these guarantees is tricky, and most of the file systems
we care about will have indexing enabled, I'm not *that* concerned
about making directory shrinking working well for non-indexed
directories.  (Which will tend to only exist from ext2 file systems.)


+static inline bool is_empty_dirent_block(struct inode *dir,
+					 struct buffer_head *bh)
+{
+	struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)bh->b_data;
+	int	csum_size = 0;
+
+	if (ext4_has_metadata_csum(dir->i_sb))
+		csum_size = sizeof(struct ext4_dir_entry_tail);

The dx_tail only exists for indexed directories.  So the if statement
should read:

	if (ext4_has_metadata_csum(dir->i_sb) && is_dx(dir))


> +	/*
> +	 * If i was 0 when we began above loop, we would have overwritten count
> +	 * and limit values sin ce those values live in dx_entry->hash of the

s/sin ce/since/


> +	/*
> +	 * Read blocks from directory in reverse orders and clean them up one by
> +	 * one!
> +	 */

s/reverse orders/reverse order/


> +		info = &((struct dx_root *)frames[0].bh->b_data)->info;
> +		if (info->indirect_levels > 0) {
> +			/*
> +			 * We don't shrink in this case. That's because the
> +			 * block that we just read could very well be an index
> +			 * block. If it's an index block, we need to do special
> +			 * handling to delete the block. 

Please delete this comment, and replace it with "we don't support dx
directories with a depth > 2 for now".  See the above discussion...

Cheers,

					- Ted
