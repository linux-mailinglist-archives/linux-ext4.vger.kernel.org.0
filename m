Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28462C0251
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 10:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgKWJeg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 04:34:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:39246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbgKWJeg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Nov 2020 04:34:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FEEBABCE;
        Mon, 23 Nov 2020 09:34:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1D47D1E130F; Mon, 23 Nov 2020 10:34:34 +0100 (CET)
Date:   Mon, 23 Nov 2020 10:34:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix mmap write protection for data=journal mode
Message-ID: <20201123093434.GA27294@quack2.suse.cz>
References: <20201027132751.29858-1-jack@suse.cz>
 <CAO9xwp0AtCLG77g6fWgu9un9XPD3d5U6ZtjWc3FRJrB8NK44SQ@mail.gmail.com>
 <CAO9xwp3sSjzy9W8pMjV6vYitfZ9BmZE-9bLwcLg1uz3CFBHUcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp3sSjzy9W8pMjV6vYitfZ9BmZE-9bLwcLg1uz3CFBHUcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Mauricio!

On Fri 20-11-20 12:27:56, Mauricio Faria de Oliveira wrote:
> On Tue, Oct 27, 2020 at 1:10 PM Mauricio Faria de Oliveira
> <mfo@canonical.com> wrote:
> > On Tue, Oct 27, 2020 at 10:27 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Commit afb585a97f81 "ext4: data=journal: write-protect pages on
> > > j_submit_inode_data_buffers()") added calls ext4_jbd2_inode_add_write()
> > > to track inode ranges whose mappings need to get write-protected during
> > > transaction commits. However the added calls use wrong start of a range
> > > (0 instead of page offset) and so write protection is not necessarily
> > > effective. Use correct range start to fix the problem.
> > >
> > > Fixes: afb585a97f81 ("ext4: data=journal: write-protect pages on j_submit_inode_data_buffers()")
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/ext4/inode.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > Mauricio, I think this could be the reason for occasional test failures you
> > > were still seeing. Can you try whether this patch fixes those for you? Thanks!
> > >
> >
> > Thanks! Nice catch. Sure, I'll give it a try and follow up.
> 
> TL;DR:
> 
> 1) Thanks! The patch fixed almost 100% of the checksum failures.
> 2) I can send a debug patch to verify buffer checksums before write-out.
> 3) The remaining, rare checksum failures seem to be due to
>     a race between commit/write-protect and page writeback
>     related to PageChecked(), clearing pagecache dirty tag used to
> write-protect.
> 4) Test results statistics confirm that the occurrence of checksum
> failures is really low.

Glad to hear that!

> Thanks for the patch! The results with v5.10-rc4 are almost 100%:
> 
> There are now _very rare_ occasions of journal checksum failures detected; with
> _zero_ recovery failures in stress-ng/crash/reboot/mount in 1187 loops
> overnight.
> (Previously I'd get 3-5 out of 10.)
> 
> I plan to send the debug patch used to verify the buffer checksum in the tag
> before write-out (catches the checksum failures that fail recovery in advance),
> if you think it might be useful. I thought of it under CONFIG_JBD2_DEBUG.
> 
> ...
> 
> The remaining checksum changes due to write-protect failures _seem_ to be
> a race between our write-protect with write_cache_pages() and writeback/sync.
> But I'm not exactly sure as it's been hard to find the timing/steps
> for both threads.
> The idea is,
> 
> Our write_cache_pages() during commit /
> ext4_journalled_submit_inode_data_buffers()
> depends on PAGECACHE_TAG_DIRTY being set, for pagevec_lookup_range_tag()
> to put such pages in the array to be write-protected with
> clear_page_dirty_for_io().
> 
> With a debug patch to dump_stack() callers of
> __test_set_page_writeback(), that can
> xas_clear_mark() it, _while_ the page is still going in our call to
> write_cache_pages(),
> we see this: wb_workfn() -> ext4_writepage() -> ext4_ext4_bio_write_page(),

I guess there was something between wb_workfn() and ext4_writepage(),
wasn't there? There should be write_cache_pages()...

> i.e., _not_ going through ext4_journalled_writepage(), which
> knows/waits on journal.
> The other leg of ext4_writepage()  _doesn't_, and thus can clear the
> tag and prevent
> write-protect while the journal commit / our write_cache_pages() is running.

So I don't think this is quite it. If there are two writebacks racing,
either of them will writeprotect the page which is enough for commit to be
safe (as the mapped write will then trigger ext4_page_mkwrite() which will
wait for the end of running commit in jbd2_journal_get_write_access()). Or
am I missing something? But there must be still some race as you can still
see occasional checksum changes... So I must be missing something.

> Since the switch to either leg is PageChecked(), I guess this might be
> due to clearing it right away in ext4_journalled_writepage(), before
> write-protection.

The write-protection happens in clear_page_dirty_for_io() call so that's
before our ->writepage() callback is even called.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
