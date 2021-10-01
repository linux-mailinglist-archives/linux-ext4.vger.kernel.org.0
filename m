Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BBE41EF28
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbhJAOLH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Oct 2021 10:11:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41626 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231702AbhJAOLH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Oct 2021 10:11:07 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 191E9BA1015444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Oct 2021 10:09:13 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4784415C34A8; Fri,  1 Oct 2021 10:09:11 -0400 (EDT)
Date:   Fri, 1 Oct 2021 10:09:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     yangerkun <yangerkun@huawei.com>, linux-ext4@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: check magic even the extent block bh is
 verified
Message-ID: <YVcWh6KqzJQytiSJ@mit.edu>
References: <20210904044946.2102404-1-yangerkun@huawei.com>
 <20210904044946.2102404-3-yangerkun@huawei.com>
 <20211001091833.GB28799@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001091833.GB28799@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 01, 2021 at 11:18:33AM +0200, Jan Kara wrote:
> > 
> > Digging deep and we found it's actually a xattr block which can happened
> > with follow steps:
> > 
> > 1. extent update for file1 and will remove a leaf extent block(block A)
> > 2. we need update the idx extent block too
> > 3. block A has been allocated as a xattr block and will set verified
> > 3. io error happened for this idx block and will the buffer has been
> >    released late
> > 4. extent find for file1 will read the idx block and see block A again
> > 5. since the buffer of block A is already verified, we will use it
> >    directly, which can lead the upper OOB
> > 
> > Same as __ext4_xattr_check_block, we can check magic even the buffer is
> > verified to fix the problem.
> > 
> > Signed-off-by: yangerkun <yangerkun@huawei.com>
> 
> Honestly, I'm not sure if this is worth it. What you suggest will work if
> the magic is overwritten but if we reallocate the block for something else
> but the magic happens to stay intact, we have a problem. The filesystem is
> corrupted at that point with metadata blocks being multiply claimed and
> that's very difficult to deal with. Maybe we should start ignoring
> buffer_verified() bit once the fs is known to have errors and recheck the
> buffer contents on each access? Sure it will be slow but I have little
> sympathy towards people running filesystems with errors... What do people
> think?

At some point, if we transition away from using buffer_heads for the
jbd2 layer, and use our own ext4_metadata_buf structure which
incorporates the journal_head and buffer_head fields, this will allow
us to control our own writeback, and allow us to have our own error
callbacks so we can do things like declare an inode to be bad and not
to be referenced again.  This would allow us to have a metadata type
field, so we could know that a buffer had been verified as an inode
table block, or bitmap block, or an xattr block.

However, I think the bigger issue is that even if we had a metadata
type field in the buffer_head (or ext4_metadata_buf), we should be
using the metadata validation, and buffer_verified bit, as a backup.
It should not be the primary line of defense.

So what I would suggest doing is preventing the out of bounds
reference in ext4_find_extent() in the first place.  I note we're not
sanity checking the values of EXT4_{FIRST,LAST}_{EXTENT,INDEX} used in
ext4_ext_binsearch() and ext4_ext_binsearch_idx(), and that's probably
how we triggered the out of bounds read in the first place.  The cost
of making sure that pointers returned by
EXT4_{FIRST,LAST}_{EXTENT,INDEX} don't exceed the bounds of the extent
tree node would be minimal, and it would be an additional cross check
which would protect us against the buffer getting corrupted while in
memory (bit flips, or wild pointer dereferences).

Cheers,

						- Ted
