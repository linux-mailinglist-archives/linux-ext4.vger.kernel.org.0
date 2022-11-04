Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12E618D3F
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Nov 2022 01:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKDAcn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Nov 2022 20:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiKDAcm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Nov 2022 20:32:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4007422BD5
        for <linux-ext4@vger.kernel.org>; Thu,  3 Nov 2022 17:32:40 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b62so3118976pgc.0
        for <linux-ext4@vger.kernel.org>; Thu, 03 Nov 2022 17:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqFWmWfUe3nfY/W1IhQtBrk1jdkAMC8SotBe5qoKInk=;
        b=59fd9mimgkb3jqAEBB6FDge8YWbKgQ9cCVLSYc0vbz/ITZ/+MWGUAhT+BfkD/WyOKR
         ZS72otyTGSBCMIn5KXHq3LY3eBVqj847EAys1SC/2LtlNG2ca/p3U0PFwYXe/Wnqkktr
         I3J8EoDvRfIbPMbLnYr+wIQ9y3cFpGyrA7PQRcteKx3oRqTR+RVUuWrOgzafCb1uOAwz
         nCRdmg7rcl4JIOC/F7kvcGFV4AMwfIgrEUm/9771CgvZ3C7eQT9zBQ3v6zbQ4HsMWHhf
         YC3gUQD3VRGl+O7/Jyi2szZ3xH6y79IvLO1d72Ja/0b7kFUBkMCtbZ/1nn2lxndqgNOT
         QynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqFWmWfUe3nfY/W1IhQtBrk1jdkAMC8SotBe5qoKInk=;
        b=twUUlL1z9mMhUVUl5FNTNotSHgirCv4w8ktPRePJo7cDc79maCFbt5N36tp8TMlQrP
         WuTA1YZpme1AhUjOr28g7NvVIz7G9hTbjP/47x9UquFCX4fubU4JaMQ3TcIakiMxqpaJ
         4Qc07E/jpFhvZct2/KTqTOrP2aTpJgPrEIp9N6ZAQ00wS9EDkml5J2WRJFA5ysf7lBti
         j6CjYgEqFX0nvurBCIojUOUGY8F1bYfV1z+wPmFiCeb3v4nihCAseew90OnpkTwlU6go
         f9VeCCnYTwAcezmaxciJVikHDuKNQoVeTra3ic3tyS5t8QmpQWgHU3wVxrGJCT9Qwnqu
         Zpfw==
X-Gm-Message-State: ACrzQf0v6Jc1oEaqKlxiyv2E+NXyKpqOxYcZRtgl4Q2OpVJ9rLRL34Es
        39vQ255jyME6Xaf5zbSX0qNITw==
X-Google-Smtp-Source: AMsMyM6iJ2SNWGuGLen8Rv+LFYo5aa41OR1ELR00lyKv92EB0uGeLIs3Yf+UrlIB5ACN2HoiTY/hWA==
X-Received: by 2002:aa7:962c:0:b0:56c:14c9:70dc with SMTP id r12-20020aa7962c000000b0056c14c970dcmr224950pfg.17.1667521959674;
        Thu, 03 Nov 2022 17:32:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id w189-20020a6282c6000000b0056c04dee930sm1341605pfd.120.2022.11.03.17.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 17:32:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oqkdP-009ySF-U9; Fri, 04 Nov 2022 11:32:35 +1100
Date:   Fri, 4 Nov 2022 11:32:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 04/23] page-writeback: Convert write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <20221104003235.GZ2703033@dread.disaster.area>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
 <20220901220138.182896-5-vishal.moola@gmail.com>
 <20221018210152.GH2703033@dread.disaster.area>
 <Y2RAdUtJrOJmYU4L@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2RAdUtJrOJmYU4L@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 03, 2022 at 03:28:05PM -0700, Vishal Moola wrote:
> On Wed, Oct 19, 2022 at 08:01:52AM +1100, Dave Chinner wrote:
> > On Thu, Sep 01, 2022 at 03:01:19PM -0700, Vishal Moola (Oracle) wrote:
> > > Converted function to use folios throughout. This is in preparation for
> > > the removal of find_get_pages_range_tag().
> > > 
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > ---
> > >  mm/page-writeback.c | 44 +++++++++++++++++++++++---------------------
> > >  1 file changed, 23 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > index 032a7bf8d259..087165357a5a 100644
> > > --- a/mm/page-writeback.c
> > > +++ b/mm/page-writeback.c
> > > @@ -2285,15 +2285,15 @@ int write_cache_pages(struct address_space *mapping,
> > >  	int ret = 0;
> > >  	int done = 0;
> > >  	int error;
> > > -	struct pagevec pvec;
> > > -	int nr_pages;
> > > +	struct folio_batch fbatch;
> > > +	int nr_folios;
> > >  	pgoff_t index;
> > >  	pgoff_t end;		/* Inclusive */
> > >  	pgoff_t done_index;
> > >  	int range_whole = 0;
> > >  	xa_mark_t tag;
> > >  
> > > -	pagevec_init(&pvec);
> > > +	folio_batch_init(&fbatch);
> > >  	if (wbc->range_cyclic) {
> > >  		index = mapping->writeback_index; /* prev offset */
> > >  		end = -1;
> > > @@ -2313,17 +2313,18 @@ int write_cache_pages(struct address_space *mapping,
> > >  	while (!done && (index <= end)) {
> > >  		int i;
> > >  
> > > -		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
> > > -				tag);
> > > -		if (nr_pages == 0)
> > > +		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> > > +				tag, &fbatch);
> > 
> > This can find and return dirty multi-page folios if the filesystem
> > enables them in the mapping at instantiation time, right?
> 
> Yup, it will.
> 
> > > +
> > > +		if (nr_folios == 0)
> > >  			break;
> > >  
> > > -		for (i = 0; i < nr_pages; i++) {
> > > -			struct page *page = pvec.pages[i];
> > > +		for (i = 0; i < nr_folios; i++) {
> > > +			struct folio *folio = fbatch.folios[i];
> > >  
> > > -			done_index = page->index;
> > > +			done_index = folio->index;
> > >  
> > > -			lock_page(page);
> > > +			folio_lock(folio);
> > >  
> > >  			/*
> > >  			 * Page truncated or invalidated. We can freely skip it
> > > @@ -2333,30 +2334,30 @@ int write_cache_pages(struct address_space *mapping,
> > >  			 * even if there is now a new, dirty page at the same
> > >  			 * pagecache address.
> > >  			 */
> > > -			if (unlikely(page->mapping != mapping)) {
> > > +			if (unlikely(folio->mapping != mapping)) {
> > >  continue_unlock:
> > > -				unlock_page(page);
> > > +				folio_unlock(folio);
> > >  				continue;
> > >  			}
> > >  
> > > -			if (!PageDirty(page)) {
> > > +			if (!folio_test_dirty(folio)) {
> > >  				/* someone wrote it for us */
> > >  				goto continue_unlock;
> > >  			}
> > >  
> > > -			if (PageWriteback(page)) {
> > > +			if (folio_test_writeback(folio)) {
> > >  				if (wbc->sync_mode != WB_SYNC_NONE)
> > > -					wait_on_page_writeback(page);
> > > +					folio_wait_writeback(folio);
> > >  				else
> > >  					goto continue_unlock;
> > >  			}
> > >  
> > > -			BUG_ON(PageWriteback(page));
> > > -			if (!clear_page_dirty_for_io(page))
> > > +			BUG_ON(folio_test_writeback(folio));
> > > +			if (!folio_clear_dirty_for_io(folio))
> > >  				goto continue_unlock;
> > >  
> > >  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> > > -			error = (*writepage)(page, wbc, data);
> > > +			error = writepage(&folio->page, wbc, data);
> > 
> > Yet, IIUC, this treats all folios as if they are single page folios.
> > i.e. it passes the head page of a multi-page folio to a callback
> > that will treat it as a single PAGE_SIZE page, because that's all
> > the writepage callbacks are currently expected to be passed...
> > 
> > So won't this break writeback of dirty multipage folios?
> 
> Yes, it appears it would. But it wouldn't because its already 'broken'.

It is? Then why isn't XFS broken on existing kernels? Oh, we don't
know because it hasn't been tested?

Seriously - if this really is broken, and this patchset further
propagating the brokeness, then somebody needs to explain to me why
this is not corrupting data in XFS.

I get it that page/folios are in transition, but passing a
multi-page folio page to an interface that expects a PAGE_SIZE
struct page is a pretty nasty landmine, regardless of how broken the
higher level iteration code already might be.

At minimum, it needs to be documented, though I'd much prefer that
we explicitly duplicate write_cache_pages() as write_cache_folios()
with a callback that takes a folio and change the code to be fully
multi-page folio safe. Then filesystems that support folios (and
large folios) natively can be passed folios without going through
this crappy "folio->page, page->folio" dance because the writepage
APIs are unaware of multi-page folio constructs.

Then you can convert the individual filesystems using
write_cache_pages() to call write_cache_folios() one at a time,
updating the filesystem callback to do the conversion from folio to
struct page and checking that it an order-0 page that it has been
handed....

> The current find_get_pages_range_tag() actually has the exact same
> issue. The current code to fill up the pages array is:
> 
> 		pages[ret] = &folio->page;
> 		if (++ret == nr_pages) {
> 			*index = folio->index + folio_nr_pages(folio);
> 			goto out;

"It's already broken so we can make it more broken" isn't an
acceptible answer....

> Its not great to leave it 'broken' but its something that isn't - or at
> least shouldn't be - creating any problems at present. And I believe Matthew
> has plans to address them at some point before they actually become problems?

You are modifying the interfaces and doing folio conversions that
expose and propagate the brokenness. The brokeness needs to be
either avoided or fixed and not propagated further. Doing the above
write_cache_folios() conversion avoids the propagating the
brokenness, adds runtime detection of brokenness, and provides the
right interface for writeback iteration of folios.

Fixing the generic writeback iterator properly is not much extra
work, and it sets the model for filesytsems that have copy-pasted
write_cache_pages() and then hacked it around for their own purposes
(e.g. ext4, btrfs) to follow.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
