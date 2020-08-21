Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394A124D244
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 12:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgHUK0b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Aug 2020 06:26:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:57798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbgHUK01 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Aug 2020 06:26:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71C2EAE38;
        Fri, 21 Aug 2020 10:26:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 669D31E1312; Fri, 21 Aug 2020 12:26:25 +0200 (CEST)
Date:   Fri, 21 Aug 2020 12:26:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Jan Kara <jack@suse.com>
Subject: Re: [RFC PATCH v2 3/5] ext4: data=journal: write-protect pages on
 submit inode data buffers callback
Message-ID: <20200821102625.GB3432@quack2.suse.cz>
References: <20200810010210.3305322-1-mfo@canonical.com>
 <20200810010210.3305322-4-mfo@canonical.com>
 <20200819084421.GD1902@quack2.suse.cz>
 <20200819104139.GJ1902@quack2.suse.cz>
 <CAO9xwp2UBLyD5f3wzwBHQHA9NvxuasR3c+KCBsFLWR_NitLOxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp2UBLyD5f3wzwBHQHA9NvxuasR3c+KCBsFLWR_NitLOxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 20-08-20 19:55:05, Mauricio Faria de Oliveira wrote:
> On Wed, Aug 19, 2020 at 7:41 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 19-08-20 10:44:21, Jan Kara wrote:
> > > I was thinking about this and we may need to do this somewhat differently.
> > > I've realized that there's the slight trouble that we now use page dirty
> > > bit for two purposes in data=journal mode - to track pages that need write
> > > protection during commit and also to track pages which have buffers that
> > > need checkpointing. And this mixing is making things complex. So I was
> > > thinking that we could simply leave PageDirty bit for checkpointing
> > > purposes and always make sure buffers are appropriately attached to a
> > > transaction as dirty in ext4_page_mkwrite(). [snip]
> > > [snip] Furthermore I
> > > don't think that the tricks with PageChecked logic we play in data=journal
> > > mode are really needed as well which should bring further simplifications.
> > > I'll try to code this cleanup.
> >
> > I was looking more into this but it isn't as simple as I thought because
> > get_user_pages() users can still modify data and call set_page_dirty() when
> > the page is no longer writeably mapped. And by the time set_page_dirty() is
> > called page buffers are not necessarily part of any transaction so we need
> > to do effectively what's in ext4_journalled_writepage(). To handle this
> > corner case I didn't find anything considerably simpler than the current
> > code.
> >
> > So let's stay with what we have in
> > ext4_journalled_submit_inode_data_buffers(), we just have to also redirty
> > the page if we find any dirty buffers.
> >
> 
> Could you please clarify/comment whether the dirty buffers "flags" are
> different between the suggestions for ext4_page_mkwrite() and
> ext4_journalled_submit_inode_data_buffers() ?
> 
> I'm asking because..
> 
> In ext4_page_mkwrite() the suggestion is to attach buffers as dirty to
> a transaction, which I guess can be done with
> ext4_walk_page_buffers(..., write_end_fn) after
> ext4_walk_page_buffers(..., do_journal_get_write_access) -- just as
> done in ext4_journalled_writepage() -- and that sets the buffer as
> *jbd* dirty (BH_JBDDirty.)

Correct.

> In ext4_journalled_submit_inode_data_buffers() the suggestion is to
> check for dirty buffers to redirty the page
> (for the case of buffers that need checkpointing) and I think this is
> the non-jbd/just dirty (BH_Dirty.)

Again correct :).

> If I actually understood your explanation/suggest, the dirty buffer
> flags should be different,
> as otherwise we'd be unconditionally setting buffers dirty on
> ext4_page_mkwrite() to later
> check for (known to be) dirty buffers in
> ext4_journalled_submit_inode_data_buffers().
> 
> ...
> 
> And as you mentioned no cleanup / keeping ext4_journalled_writepage()
> and the PageChecked bit,
> I would like to revisit two questions from the cover letter that would
> have no impact with the cleanup,
> so to confirm my understanding for the next steps.
> 
>     > 3) When checking to redirty the page in the writepage callback,
>     >    does a buffer without a journal head means we should redirty
>     >    the page? (for the reason it's not part of the committing txn)
> 
> Per your explanation about the page dirty bit for buffers that need
> checkpointing, I see we cannot redirty
> the page just because a buffer isn't part of the transaction -- the
> buffer has to be dirty -- so I think it falls
> down to your suggestion of 'also redirty if we find any dirty buffers'
> (regardless of a buffer w/out txns.) right?

Correct. It should be:

		if (buffer_dirty(bh) || (jh && ...))
			redirty
 
>     > 4) Should we clear the PageChecked bit?
>     ...
>     > Should we try to prevent that [ext4_journalled_writepage()
> running later] by, say, clearing the pagechecked bit
>     > in case we don't have to redirty the page (in the writepage callback) ?
> 
> And I think the answer is no, per your explanation about page dirty
> being set elsewhere outside of our control,
> and thus ext4_journalled_page() still needs to run, and thus the  page
> checked bit still needs to remain set; correct?

Correct.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
