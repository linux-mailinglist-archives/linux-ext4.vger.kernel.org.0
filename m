Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4ED249950
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 11:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHSJ1j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 05:27:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:45320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgHSJ1i (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Aug 2020 05:27:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74803B709;
        Wed, 19 Aug 2020 09:28:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD1BF1E1312; Wed, 19 Aug 2020 11:27:35 +0200 (CEST)
Date:   Wed, 19 Aug 2020 11:27:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: Re: [RFC PATCH v2 0/5] ext4/jbd2: data=journal: write-protect pages
 on transaction commit
Message-ID: <20200819092735.GI1902@quack2.suse.cz>
References: <20200810010210.3305322-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810010210.3305322-1-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Mauricio!

On Sun 09-08-20 22:02:03, Mauricio Faria de Oliveira wrote:
> I'd like to ask for your comments on the patchset so far, and have a few
> questions.

Thanks for taking time to write these patches! I have commented on the
patches and now let's address the remaining questions :)

> Third, my changes/observations/questions:
> 
> 1) > Probably the best place to add inode to this list is
> ext4_journalled_writepage().
> 
> I think we also need it in ext4_page_mkwrite(), right?  See the test
> case, for example:
> 
>     fd = open("file");
>     addr = mmap(fd);
>     pwrite(fd, "a", 1, 0);
>     addr[0] = 'a';
>     press_enter(); // when asked for.
>     addr[0] = 'b';
> 
> Here pwrite() led to ext4_write_begin() which added the inode to a
> transaction (not to the transaction's inode list).

Hum, right. Good spotting, I didn't think of this possibility. Actually,
when we have to do this in ext4_page_mkwrite() we don't need
ext4_journalled_writepage() at all which is what I've suggested when
commenting on your patch 3/5 anyway to simplify things :).

> 2) Do not return early in ext4_page_mkwrite() 'if we have all the buffers mapped'?
> 
> There's this check in ext4_page_mkwrite():
> 
>         /*
>          * Return if we have all the buffers mapped. This avoids the need to do
>          * journal_start/journal_stop which can block and take a long time
>          */
> 
> Corresponding to this line in the debug messages:
> 
>     [   20.677639] TESTDBG: ext4_page_mkwrite() :: returning; all buffers mapped for inode ffff8f72eda5fca8
> 
> That returns early, *before* do_journal_get_write_access(), which is
> needed in data=journal, regardless of whether all buffers are mapped: we
> could exit ext4_page_mkwrite() then change buffers under commit during
> the race window.
>     
> So, it seems we should ignore that for data=journal, which allows us to
> ext4_journal_start() and get a transaction handle, used to add the inode
> to the transaction's inode list (per #1.)

Yes, correct.

> With the changes from 1) and 2), the inode is added to the transaction's
> inode list, and the callback does write-protect the page correctly.
> 
> When trying to change the buffer contents later (pressing enter) there
> _is_ a wait in ext4_page_mkwrite() as expected!  But it's first at the
> file_update_time() because it calls do_get_write_access() for that inode,
> which is also in the transaction.
> 
> I presume that a commit can start after file_update_time() and before
> ext4_journal_start() in ext4_page_mkwrite(), so we'd still have to keep
> these changes to ext4_page_mkwrite() ?

Yes, relying on file_update_time() waiting is definitely too fragile.

> 3) When checking to redirty the page in the writepage callback,
>    does a buffer without a journal head means we should redirty
>    the page? (for the reason it's not part of the committing txn)

This is going to change after the simplifications I've suggested so there's
no need to worry about this now.

> 4) Should we clear the PageChecked bit?
> 
> We don't clear the PageChecked bit, thus later when the writeback
> work kicks in, __ext4_journalled_writepage() adds the page to the
> transaction's inode list again.
> 
> Since the page is clean, it just goes into the submit data buffers
> callback, but write_cache_pages() returns before the writepage callback.
> 
> Should we try to provent that by, say, clearing the pagechecked bit
> in case we don't have to redirty the page (in the writepage callback) ?

I guess it's difficult to determine when PageChecked bit can be safely
cleared. And I plan to do away with PageChecked bit usage completely in my
cleanup so this should go away anyway...

> 5) Inodes with inline data.  I haven't checked in detail yet, but
> would appreciate if you have a brief explanation about them, and
> if they need special handling since they apparently don't get
> do_journal_get_write_access() called (eg, see __ext4_journalled_writepage()).

I think I've commented about this in a particular patch.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
