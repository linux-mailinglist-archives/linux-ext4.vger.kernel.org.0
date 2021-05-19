Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876EF389239
	for <lists+linux-ext4@lfdr.de>; Wed, 19 May 2021 17:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348668AbhESPJr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 May 2021 11:09:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48209 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231361AbhESPJr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 May 2021 11:09:47 -0400
Received: from callcc.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14JF8Kjh016152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 11:08:22 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 70A3C420119; Wed, 19 May 2021 11:08:20 -0400 (EDT)
Date:   Wed, 19 May 2021 11:08:20 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: get discard out of jbd2 commit kthread
Message-ID: <YKUp5BpAwaBREe6d@mit.edu>
References: <53146e54-af36-0c32-cad8-433460461237@gmail.com>
 <YKLXev4cjeRuGRqd@mit.edu>
 <c7c00420-ed5c-0f5d-23c1-1c64b1800778@gmail.com>
 <YKPV6FZWfoUD3bgL@mit.edu>
 <1d43599f-fed1-b37e-a411-2b0f31583991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d43599f-fed1-b37e-a411-2b0f31583991@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 19, 2021 at 09:27:56AM +0800, Wang Jianchao wrote:
> 
> We're running ext4 with discard on a nbd device whose backend is storage
> cluster. The discard can help to free the unused space to storage pool.
> 
> And sometimes application delete a lot of data and discard is flooding. 
> Then we see the jbd2 commit kthread is blocked for a long time. Even
> move the discard out of jbd2, we still see the write IO of jbd2 log
> could be blocked. blk-wbt could help to relieve this. Finally the delay
> is shift to allocation path. But this is better than blocking the page
> fault path which holds the read mm->mmap_sem.

I'm assuming that the problem is when the application deletes a lot of
data, the discard flood is causing performance problems on your nbd
server.  Is that the high level problem that you are trying to solve?

So if that's the case, I'd suggest a different approach.  First, move
kmem_cache_free(ext4_free_data_cachep, entry) out of
ext4_free_data_in_buddy() to its caller, ext4_process_data.  Then if
discard is enabled, after calling ext4_free_data_in_buddy(), the
ext4_free_data struct will be detached from rbtree rooted in
ext4_group_info.bb_free_root, and then we can attach it to a new
rbtree rooted in ext4_group_info.bb_discard_root.

This allows the block to be reused as soon the commit is finished
(allowing for potentially more efficient block allocations), but we
can now keep track of which blocks would be useful for discarding and
decouple that from when we release the blocks to be reused.  We can
now use the pre-existing fstrim kernel thread infrastructure to lock a
block group, and we can now iterate over the rbtree, and take into
account which blocks have since become allocated --- since if a block
has been allocated, there's no need to send a discard for it.

I think this will be more efficient, and will allow us to share more
of the code for fstrim and the discard-at-runtime model used by "mount
-o discard".  We can also fine-tune how quickly we issue discards; it
might be that if user has executed "rm -rf" it might actually better
to wait until the deletes have completed, even if it takes several
commit intervals, since it might allow us to combine discards if the
blocks 100-199 and 400-500 are released in one commit, and blocks
200-399 are released two or three commits later.

Something else I'd urge you to consider is whether it's possible to
enhance the nbd protocol to add some kind of back-channel notification
when the shared storage is getting low on space.  In that case, when
the nbd client code a request from the nbd server indicating, "please
issue discards if possible", it could either trigger an upcall to
userspace, which could then issue the fstrim ioctl, which in the case
where "mount -o discard" is enabled, would accelerate when discards
took place.

We could then make the fstrim thread normally work on a much slower
pace, but when there is a signal from the shared storage that space is
needed, clients could accelerate when they issue discards to free up
shared space.

Cheers,

						- Ted

P.S.  One other potential thought; if we have established a new
bb_discard_root rbtree, it *might* actually be beneficial to consider
using that information in the block allocator.  One of the best way to
tell an SSD that block is no longer needed is to simply overwrite that
block.  If we do that, we don't need to send a discard to that block
any more.

Of course, we still want to keep blocks contiguous since even though
seeks are free for SSD's, we want to keep large reads contiguous as
much as possible, and we want to keep the extent tree as compact as
possible.  But if we have just released a 12k file, and we are writing
a new 12k file, and don't really care *where* in the block group we
are writing that file, reusing blocks that had just been freed might
actually be a good strategy.

That's not something you need to implement in this patch series, but
it might be an interesting optimization.
