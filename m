Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CBF1F559E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jun 2020 15:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgFJNVo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Jun 2020 09:21:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:41232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbgFJNVm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 10 Jun 2020 09:21:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08D66AC12;
        Wed, 10 Jun 2020 13:21:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D96C51E1283; Wed, 10 Jun 2020 15:21:39 +0200 (CEST)
Date:   Wed, 10 Jun 2020 15:21:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: Re: [RFC PATCH 00/11] ext4: data=journal: writeback mmap'ed pagecache
Message-ID: <20200610132139.GG12551@quack2.suse.cz>
References: <20200423233705.5878-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423233705.5878-1-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

Firstly, thanks for the patches and I'm sorry that it took me so long to
get to this.

On Thu 23-04-20 20:36:54, Mauricio Faria de Oliveira wrote:
> Ted Ts'o explains, in the linux-ext4 thread [1], that currently
> data=journal + journal_checksum + mmap is not handled correctly,
> and outlines the changes to fix it (+ items/breaks for clarity):
> 
>     """
>     The fix is going to have to involve
>     - fixing __ext4_journalled_writepage() to call set_page_writeback()
>       before it unlocks the page,
>     - adding a list of pages under data=journalled writeback
>       which is attached to the transaction handle,
>     - have the jbd2 commit hook call end_page_writeback()
>       on all of these pages,
>     - and then in the places where ext4 calls wait_for_stable_page()
>       or grab_cache_page_write_begin(), we need to add:
>     
>     	if (ext4_should_journal_data(inode))
>     		wait_on_page_writeback(page);
>     
>     It's all relatively straightforward except for the part
>     where we have to attach a list of pages to the currently
>     running transaction.  That will require adding some
>     plumbing into the jbd2 layer.
>     """

So I was pondering about this general design for some time. First let me
state here how I see the problem you are hitting in data=journal mode:

The journalling machinery expects the buffer contents cannot change from
the moment transaction commit starts (more exactly from the moment
transaction exists LOCKED state) until the moment transaction commit
finishes. Places like jbd2_journal_get_write_access() are there exactly to
ascertain this - they copy the "to be committed" contents into a bounce
buffer (jh->b_frozen_data) or wait for commit to finish (if it's too late
for copying and the data is already in flight). data=journal mode breaks
this assumption because although ext4_page_mkwrite() calls
do_journal_get_write_access() for each page buffer (and thus makes sure
there's no commit with these buffers running at that moment), the commit
can start the moment we call ext4_journal_stop() in ext4_page_mkwrite() and
then this commit runs while buffers in the committing transaction are
writeably mapped to userspace.

However I don't think Ted's solution actually fully solves the above
problem. Think for example about the following scenario:

fd = open('file');
addr = mmap(fd);
addr[0] = 'a';
	-> caused page fault, ext4_page_mkwrite() is called, page is
	   dirtied, all buffers are added to running transaction
pwrite(fd, buf, 1, 1);
	-> page dirtied again, all buffer are dirtied in the running
	   transaction

					jbd2 thread commits transaction now
-> the problem with committing buffers that are writeably mapped is still
there and your patches wouldn't solve it because
ext4_journalled_writepage() didn't get called at all.

Also, as you found out, leaving pages under writeback while we didn't even
start transaction commit that will end writeback on them is going to cause
odd stalls in various unexpected places.

So I'd suggest a somewhat different solution. Instead of trying to mark,
when page is under writeback, do it the other way around and make jbd2 kick
ext4 on transaction commit to writeprotect journalled pages. Then, because
of do_journal_get_write_access() in ext4_page_mkwrite() we are sure pages
cannot be writeably mapped into page tables until transaction commit
finishes (or we'll copy data to commit to b_frozen_data).

Now let me explain a bit more the "make jbd2 kick ext4 on transaction
commit to writeprotect journalled pages" part. I think we could mostly
reuse the data=ordered machinery for that. data=ordered machinery tracks
with each running transaction also a list of inodes for which we need to
flush data pages before doing commit of metadata into the journal. Now we
could use the same mechanism for data=journal mode - we'd track in the
inode list inodes with writeably mapped pages and on transaction commit we
need to writeprotect these pages using clear_page_dirty_for_io(). Probably
the best place to add inode to this list is ext4_journalled_writepage().
To do the commit handling we probably need to introduce callbacks that jbd2
will call instead of journal_submit_inode_data_buffers() in
journal_submit_data_buffers() and instead of
filemap_fdatawait_range_keep_errors() in
journal_finish_inode_data_buffers(). In data=ordered mode ext4 will just do
what jbd2 does in its callback, when inode's data should be journalled, the
callback will use write_cache_pages() to iterate and writeprotect all dirty
pages. The writepage callback just returns AOP_WRITEPAGE_ACTIVATE, some
care needs to be taken to redirty a page in the writepage callback if not
all its underlying buffers are part of the committing transaction or if
some buffer already has b_next_transaction set (since in that case the page
was already dirtied also against the following transaction). But it should
all be reasonably doable.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
