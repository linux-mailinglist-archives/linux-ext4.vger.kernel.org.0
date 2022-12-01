Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714E963F1BF
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 14:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLANg2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 08:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiLANg1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 08:36:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23148C7717
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 05:36:25 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso5288827pjt.0
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 05:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDGcCD4XoSE4WOFIwMmauxu7CJD72vgxfnxvYu/n+iE=;
        b=PgZTTkFdH/PohS1KiRLfQqwLKpqEMYkE+AGBunHt3X4lSEJsqUW1wSp/4EVofso5R/
         W9zzKQTR/hNy0xpozvKkRKR4l/vxwRQEiBbU/rcaQJwOhN+RX2RE2+ZrzQ7mJw4w/Kc9
         +rOrFACJea0mCBDSFnU2h9zDS0wRWgKq2G80HnWZMXsYPl305vmXVbqgcuIgiXuXe2WB
         kCCcUlFXpP93HD05VSoVcH2TisPcrbOFuQxDQkpVjZOROlsveJ4miZ9jxR+N4XIzyt1O
         4xoT0ZbYQuycLAUjN6MioyWJ9ploBRz5ZL32Qi6/UvYs47EzEI7da7/1fT6FTkQnmlMn
         /96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDGcCD4XoSE4WOFIwMmauxu7CJD72vgxfnxvYu/n+iE=;
        b=g+d77evNj5hr97TlrilFkJFrD4vEdeFj4SPoG7/p+Lkfch2s/tQvjWLJXehBKYxWoG
         C0yNnWVMYUqEM1Ehfm2WIRMlTmVX9t0UstbfSCkR89c6LhmglFYnUqsgEElOfJlrb+vt
         q1GY7qEa3kiyFVA1kIlh/8Y0iSW1kI6FAN5t3DbB2aOvYcIleMitAuFFIRM562d3kU5g
         uJrLjNjzEdOb2GKAkWDAPbva7WrkNxLG9J/9YIrpotSokCpyXAvb+GxUTculmiIH6/EP
         yeN85sjaOT4H8Wcwm0LlYNRDkMYX5WIFLFYIELZpFjdAXe8kHAYIJHRzjk6SzVAdBCZB
         gBPA==
X-Gm-Message-State: ANoB5plOgXlDgwyxkRxt2zXMOzID0hVuynqRLdzEEwNfVkQtb0A7L4Hs
        I7KgdzMXnV5Q8E7fyvWSXO0=
X-Google-Smtp-Source: AA0mqf5u6674g9ESOuQyK4qFa5xZDVLhuA93BaOanvfnXxPgbiiTXQ9aq2KfNnwjJ4vrtLPJvfzH9A==
X-Received: by 2002:a17:90a:fe05:b0:219:29eb:bc4b with SMTP id ck5-20020a17090afe0500b0021929ebbc4bmr24312842pjb.199.1669901784538;
        Thu, 01 Dec 2022 05:36:24 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b00188fc33e96dsm3633340plk.198.2022.12.01.05.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:36:23 -0800 (PST)
Date:   Thu, 1 Dec 2022 19:06:19 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 9/9] ext4: Remove ordered data support from
 ext4_writepage()
Message-ID: <20221201133619.cov6ntr2fuceqhjs@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-9-jack@suse.cz>
 <20221201112152.slnmx3u6jh7bhww5@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201112152.slnmx3u6jh7bhww5@riteshh-domain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/12/01 04:51PM, Ritesh Harjani (IBM) wrote:
> On 22/11/30 05:36PM, Jan Kara wrote:
> > ext4_writepage() should not be called for ordered data anymore. Remove
> > support for it from the function.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/inode.c | 116 ++++++------------------------------------------
> >  1 file changed, 13 insertions(+), 103 deletions(-)
> >
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index c131b611dabf..0c8e700265f1 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -1642,12 +1642,6 @@ static void ext4_print_free_blocks(struct inode *inode)
> >  	return;
> >  }
> >
> > -static int ext4_bh_delay_or_unwritten(handle_t *handle, struct inode *inode,
> > -				      struct buffer_head *bh)
> > -{
> > -	return (buffer_delay(bh) || buffer_unwritten(bh)) && buffer_dirty(bh);
> > -}
> > -
> >  /*
> >   * ext4_insert_delayed_block - adds a delayed block to the extents status
> >   *                             tree, incrementing the reserved cluster/block
> > @@ -1962,56 +1956,17 @@ static int __ext4_journalled_writepage(struct page *page,
> >  }
> >
> >  /*
> > - * Note that we don't need to start a transaction unless we're journaling data
> > - * because we should have holes filled from ext4_page_mkwrite(). We even don't
> > - * need to file the inode to the transaction's list in ordered mode because if
> > - * we are writing back data added by write(), the inode is already there and if
> > - * we are writing back data modified via mmap(), no one guarantees in which
> > - * transaction the data will hit the disk. In case we are journaling data, we
> > - * cannot start transaction directly because transaction start ranks above page
> > - * lock so we have to do some magic.
> > - *
> > - * This function can get called via...
> > - *   - ext4_writepages after taking page lock (have journal handle)
> > - *   - journal_submit_inode_data_buffers (no journal handle)
> > - *   - shrink_page_list via the kswapd/direct reclaim (no journal handle)
> > - *   - grab_page_cache when doing write_begin (have journal handle)
> > - *
> > - * We don't do any block allocation in this function. If we have page with
> > - * multiple blocks we need to write those buffer_heads that are mapped. This
> > - * is important for mmaped based write. So if we do with blocksize 1K
> > - * truncate(f, 1024);
> > - * a = mmap(f, 0, 4096);
> > - * a[0] = 'a';
> > - * truncate(f, 4096);
> > - * we have in the page first buffer_head mapped via page_mkwrite call back
> > - * but other buffer_heads would be unmapped but dirty (dirty done via the
> > - * do_wp_page). So writepage should write the first block. If we modify
> > - * the mmap area beyond 1024 we will again get a page_fault and the
> > - * page_mkwrite callback will do the block allocation and mark the
> > - * buffer_heads mapped.
> > - *
> > - * We redirty the page if we have any buffer_heads that is either delay or
> > - * unwritten in the page.
> > - *
> > - * We can get recursively called as show below.
> > - *
> > - *	ext4_writepage() -> kmalloc() -> __alloc_pages() -> page_launder() ->
> > - *		ext4_writepage()
> > - *
> > - * But since we don't do any block allocation we should not deadlock.
> > - * Page also have the dirty flag cleared so we don't get recurive page_lock.
> > + * This function is now used only when journaling data. We cannot start
> > + * transaction directly because transaction start ranks above page lock so we
> > + * have to do some magic.
> >   */
> >  static int ext4_writepage(struct page *page,
> >  			  struct writeback_control *wbc)
> >  {
> >  	struct folio *folio = page_folio(page);
> > -	int ret = 0;
> >  	loff_t size;
> >  	unsigned int len;
> > -	struct buffer_head *page_bufs = NULL;
> >  	struct inode *inode = page->mapping->host;
> > -	struct ext4_io_submit io_submit;
> >
> >  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
> >  		folio_invalidate(folio, 0, folio_size(folio));
> > @@ -2036,60 +1991,16 @@ static int ext4_writepage(struct page *page,
> >  		return 0;
> >  	}
> >
> > -	page_bufs = page_buffers(page);
> > -	/*
> > -	 * We cannot do block allocation or other extent handling in this
> > -	 * function. If there are buffers needing that, we have to redirty
> > -	 * the page. But we may reach here when we do a journal commit via
> > -	 * journal_submit_inode_data_buffers() and in that case we must write
> > -	 * allocated buffers to achieve data=ordered mode guarantees.
>
> Maybe this description can go above mpage_prepare_extent_to_map
> for can_map = 0 case.
>
> Looks good to me. Feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>
>
> > -	 *
> > -	 * Also, if there is only one buffer per page (the fs block
> > -	 * size == the page size), if one buffer needs block
> > -	 * allocation or needs to modify the extent tree to clear the
> > -	 * unwritten flag, we know that the page can't be written at
> > -	 * all, so we might as well refuse the write immediately.
> > -	 * Unfortunately if the block size != page size, we can't as
> > -	 * easily detect this case using ext4_walk_page_buffers(), but
> > -	 * for the extremely common case, this is an optimization that
> > -	 * skips a useless round trip through ext4_bio_write_page().
> > -	 */
> > -	if (ext4_walk_page_buffers(NULL, inode, page_bufs, 0, len, NULL,
> > -				   ext4_bh_delay_or_unwritten)) {
> > -		redirty_page_for_writepage(wbc, page);
> > -		if ((current->flags & PF_MEMALLOC) ||
> > -		    (inode->i_sb->s_blocksize == PAGE_SIZE)) {
> > -			/*
> > -			 * For memory cleaning there's no point in writing only
> > -			 * some buffers. So just bail out. Warn if we came here
> > -			 * from direct reclaim.
> > -			 */
> > -			WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD))
> > -							== PF_MEMALLOC);
> > -			unlock_page(page);
> > -			return 0;
> > -		}
> > -	}
> > -
> > -	if (PageChecked(page) && ext4_should_journal_data(inode))
> > -		/*
> > -		 * It's mmapped pagecache.  Add buffers and journal it.  There
> > -		 * doesn't seem much point in redirtying the page here.
> > -		 */
> > -		return __ext4_journalled_writepage(page, len);
> > -
> > -	ext4_io_submit_init(&io_submit, wbc);
> > -	io_submit.io_end = ext4_init_io_end(inode, GFP_NOFS);
> > -	if (!io_submit.io_end) {
> > -		redirty_page_for_writepage(wbc, page);
> > +	WARN_ON_ONCE(!ext4_should_journal_data(inode));

Oh and one more thing, this will give a WARN_ON_ONCE(), until we change the pageout()
function from reclaim path to not call ->writepage() method.
This until then might cause random fstest to fail for sometime if it observes a
kernel warning message while the test was running.

[ 5081.820019] WARNING: CPU: 3 PID: 125 at fs/ext4/inode.c:1994 ext4_writepage+0x380/0xb80
[ 5081.822884] Modules linked in:
[ 5081.824487] CPU: 3 PID: 125 Comm: kswapd0 Not tainted 6.1.0-rc4-00054-g969d94a2d4d6 #101
[ 5081.825559] Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1200 0xf000005 of:SLOF,git-6b6c16 pSeries
[ 5081.826743] NIP:  c00000000077a2c0 LR: c00000000077a2b4 CTR: c000000000779f40
[ 5081.827547] REGS: c0000000073d72d0 TRAP: 0700   Not tainted  (6.1.0-rc4-00054-g969d94a2d4d6)
<...>
[ 5081.862838] NIP [c00000000077a2c0] ext4_writepage+0x380/0xb80
[ 5081.864963] LR [c00000000077a2b4] ext4_writepage+0x374/0xb80
[ 5081.865995] Call Trace:
[ 5081.866510]  ext4_writepage+0x190/0xb80 (unreliable)
[ 5081.867438]  pageout+0x1b0/0x550
[ 5081.868110]  shrink_folio_list+0xb48/0x1400
[ 5081.868803]  shrink_inactive_list+0x2ec/0x6b0
[ 5081.869504]  shrink_lruvec+0x6f0/0x7b0
[ 5081.870160]  shrink_node+0x5e4/0x980
[ 5081.870801]  balance_pgdat+0x4cc/0x910
[ 5081.871453]  kswapd+0x6e4/0x820
[ 5081.872062]  kthread+0x168/0x170
[ 5081.872691]  ret_from_kernel_thread+0x5c/0x64


-ritesh


> > +	if (!PageChecked(page)) {
> >  		unlock_page(page);
> > -		return -ENOMEM;
> > +		return 0;
> >  	}
> > -	ret = ext4_bio_write_page(&io_submit, page, len);
> > -	ext4_io_submit(&io_submit);
> > -	/* Drop io_end reference we got from init */
> > -	ext4_put_io_end_defer(io_submit.io_end);
> > -	return ret;
> > +	/*
> > +	 * It's mmapped pagecache.  Add buffers and journal it.  There
> > +	 * doesn't seem much point in redirtying the page here.
> > +	 */
> > +	return __ext4_journalled_writepage(page, len);
> >  }
> >
> >  static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
> > @@ -3142,9 +3053,8 @@ static int ext4_da_write_end(struct file *file,
> >  	 * i_disksize since writeback will push i_disksize upto i_size
> >  	 * eventually. If the end of the current write is > i_size and
> >  	 * inside an allocated block (ext4_da_should_update_i_disksize()
> > -	 * check), we need to update i_disksize here as neither
> > -	 * ext4_writepage() nor certain ext4_writepages() paths not
> > -	 * allocating blocks update i_disksize.
> > +	 * check), we need to update i_disksize here as ext4_writepages() need
> > +	 * not do it in this case.
> >  	 *
> >  	 * Note that we defer inode dirtying to generic_write_end() /
> >  	 * ext4_da_write_inline_data_end().
> > --
> > 2.35.3
> >
