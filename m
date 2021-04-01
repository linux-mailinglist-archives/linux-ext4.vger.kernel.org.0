Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419AC351E9A
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 20:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhDASn6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 14:43:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:58566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236933AbhDASdl (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 1 Apr 2021 14:33:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09EAFB167;
        Thu,  1 Apr 2021 16:15:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C984D1F2B53; Thu,  1 Apr 2021 18:15:48 +0200 (CEST)
Date:   Thu, 1 Apr 2021 18:15:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu
Subject: Re: generic/418 regression seen on 5.12-rc3
Message-ID: <20210401161548.GA12088@quack2.suse.cz>
References: <20210318181613.GA13891@localhost.localdomain>
 <20210318201506.GU3420@casper.infradead.org>
 <20210318213808.GA26924@localhost.localdomain>
 <20210318221620.GW3420@casper.infradead.org>
 <20210322163703.GA32047@localhost.localdomain>
 <20210328024106.GK1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328024106.GK1719932@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 28-03-21 03:41:06, Matthew Wilcox wrote:
> On Mon, Mar 22, 2021 at 12:37:03PM -0400, Eric Whitney wrote:
> > * Matthew Wilcox <willy@infradead.org>:
> > > On Thu, Mar 18, 2021 at 05:38:08PM -0400, Eric Whitney wrote:
> > > > * Matthew Wilcox <willy@infradead.org>:
> > > > > On Thu, Mar 18, 2021 at 02:16:13PM -0400, Eric Whitney wrote:
> > > > > > As mentioned in today's ext4 concall, I've seen generic/418 fail from time to
> > > > > > time when run on 5.12-rc3 and 5.12-rc1 kernels.  This first occurred when
> > > > > > running the 1k test case using kvm-xfstests.  I was then able to bisect the
> > > > > > failure to a patch landed in the -rc1 merge window:
> > > > > > 
> > > > > > (bd8a1f3655a7) mm/filemap: support readpage splitting a page
> > > > > 
> > > > > Thanks for letting me know.  This failure is new to me.
> > > > 
> > > > Sure - it's useful to know that it's new to you.  Ted said he's also going
> > > > to test XFS with a large number of generic/418 trials which would be a
> > > > useful comparison.  However, he's had no luck as yet reproducing what I've
> > > > seen on his Google compute engine test setup running ext4.
> > > > 
> > > > > 
> > > > > I don't understand it; this patch changes the behaviour of buffered reads
> > > > > from waiting on a page with a refcount held to waiting on a page without
> > > > > the refcount held, then starting the lookup from scratch once the page
> > > > > is unlocked.  I find it hard to believe this introduces a /new/ failure.
> > > > > Either it makes an existing failure easier to hit, or there's a subtle
> > > > > bug in the retry logic that I'm not seeing.
> > > > > 
> > > > 
> > > > For keeping Murphy at bay I'm rerunning the bisection from scratch just
> > > > to make sure I come out at the same patch.  The initial bisection looked
> > > > clean, but when dealing with a failure that occurs probabilistically it's
> > > > easy enough to get it wrong.  Is this patch revertable in -rc1 or -rc3?
> > > > Ordinarily I like to do that for confirmation.
> > > 
> > > Alas, not easily.  I've built a lot on top of it since then.  I could
> > > probably come up with a moral reversion (and will have to if we can't
> > > figure out why it's causing a problem!)
> > > 
> > > > And there's always the chance that a latent ext4 bug is being hit.
> > > 
> > > That would also be valuable information to find out.  If this
> > > patch is exposing a latent bug, I can't think what it might be.
> > > 
> > > > I'd be very happy to run whatever debugging patches you might want, though
> > > > you might want to wait until I've reproduced the bisection result.  The
> > > > offsets vary, unfortunately - I've seen 1024, 2048, and 3072 reported when
> > > > running a file system with 4k blocks.
> > > 
> > > As I expected, but thank you for being willing to run debug patches.
> > > I'll wait for you to confirm the bisection and then work up something
> > > that'll help figure out what's going on.
> > 
> > An update:
> > 
> > I've been able to rerun the bisection on a freshly installed test appliance
> > using a kernel built from a new tree using different test hardware.  It ended
> > at the same patch - "mm/filemap: support readpage splitting a page".
> > 
> > I'd thought I'd been able to reproduce the failure using ext4's 4K block size,
> > but my test logs say otherwise, as do a few thousand trial runs of generic/418.
> > So, at the moment I can only say definitively that I've seen the failures when
> > running with 1k blocks (block size < page size).
> > 
> > I've been able to simplify generic/418 by reducing the set of test cases it
> > uses to just "-w", or direct I/O writes.  When I modify the test to remove
> > just that test case and leaving the remainder, I no longer see test failures.
> > A beneficial side effect of the simplification is that it reduces the running
> > time by an order of magnitude.
> > 
> > When it fails, it looks like the test is writing via dio a chunk of bytes all
> > of which have been set to 0x1 and then reading back via dio the same chunk with
> > all those bytes equal to 0x0.
> > 
> > I'm attempting to create a simpler reproducer.  generic/418 actually has a
> > number of processes simultaneously writing to and reading from disjoint
> > regions of the same file, and I'd like to see if the failure is dependent
> > upon that behavior, or whether it can be isolated to a single writer/reader.
> 
> I've managed to reproduce this bug here now.  There are _two_ places
> in xfstests that I need to specify "-b 1024" *grumble*.
> 
> You've definitely identified the correct commit.  I can go back-and-forth
> applying it and removing it, and the failure definitely tracks this
> commit.
> 
> I think what's going on is that we have a dio write vs a buffered read.
> That is, we're only specifying -w to diotest and not -w -r.  So we have
> a read-vs-invalidate situation.
> 
> What used to happen:
> 
>  - Look up page in page cache, happens to be there
>  - Check page is uptodate (it isn't; another thread started IO that hasn't
>    finished yet)
>  - Wait for page to be unlocked when the read finishes
>  - See if page is now uptodate (it is)
>  - Copy data from it
> 
> What happens now:
> 
>  - Look up page in page cache, happens to be there
>  - Check page is uptodate (it isn't; another thread started IO that hasn't
>    finished yet)
>  - Wait for page to be unlocked when the read finishes
>  - Go back and look up the page again
>  - Allocate a new page and call readpage
>  - Wait for IO to complete
>  - Copy data from it
> 
> So if there's a subtle race in ext4 between DIO writes and ->readpage,
> this might be exposing it?
> 
> I think this theory is given more credence by going to the parent commit
> (480546259811) and applying this:
> 
> +++ b/mm/filemap.c
> @@ -2301,6 +2301,10 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
>                 put_page(page);
>                 return ERR_PTR(error);
>         }
> +       if (!page->mapping) {
> +               put_page(page);
> +               return NULL;
> +       }
>         if (PageUptodate(page))
>                 return page;
>  
> ie refusing to use a truncated page, even if it's still marked uptodate.
> That reproduces the g/418 crash within a minute for me.
> 
> Note that if the read had come in a few instructions later, it wouldn't've
> found a page in the page cache, so this is just widening the window in
> which this race can happen.

I was looking into this for a while after Eric was talking about this
problem on ext4 concall and I think I see where the problem is. The problem
is with handling of extending direct IO write. For extending dio write
ext4_dio_write_iter() ends up doing:

	iomap_dio_rw(..., IOMAP_DIO_FORCE_WAIT);
	ext4_handle_inode_extension()
		-> updates i_size

Now the problem is that i_size gets update only after we invalidate page
cache in iomap_dio_rw() after direct IO write. So we can race like:

CPU1 - write at offset 1k			CPU2 - read from offset 0
iomap_dio_rw(..., IOMAP_DIO_FORCE_WAIT);
						ext4_readpage();
ext4_handle_inode_extension()

We will read the page at index 0, still see i_size == 1k so we will leave
page contents beyond 1k zeroed out in ext4_mpage_readpages(). But the page
is marked uptodate and there's nobody to invalidate it anymore. So
following buffered read at offset 1k will read stale zeros.

The cleanest solution would be to handle inode extension in
ext4_dio_write_end_io() to avoid this race. However it is not obvious how
to propagate all the information we need there... :-|

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
