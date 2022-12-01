Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC01963EF61
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 12:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiLALX2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 06:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLALW5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 06:22:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CE2271
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 03:21:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so1700616pjo.3
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 03:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjzbReO55cCERV1GhO8uKdt0joYmsA/tAM/NZj805ec=;
        b=ULn1gMb/MpkvZkD+gskI2aXOyBgIdEJXXa+d7nxSNJfvLg/8eAPWUCfOCYcJ9FDi/P
         Xv9wQoU8oFJ5pdZ/R++BLFKRD7AK4vXHVkHaW7Id5ww2C9BB7R2tIn5dnqrudrVK/7sO
         45aZYIt+peCOxyduOlm8pLHZCElAhMRWoSl+0/C3yCVB2R+f37Epf8n/5PXarr0eYTf1
         qHmjYtmB9vQzeYtx9Qd2qDCFfJlaWGMysjAcG8oY2wI3x8OJkTWR/bviaQ1TuQqAs1vE
         vgcQvWU8rlaNwmAiHOgmwW0t6wclnsDhdcmTACFRgCa3qq+W5ttbVGl6l0fUWUdHbJ+f
         nIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjzbReO55cCERV1GhO8uKdt0joYmsA/tAM/NZj805ec=;
        b=STo9ofY4VERp1zGRNu0mpCOAzupGosqonWDgBgGQRKE5KKKBXZi7TlfWZ/UXJDDOJY
         ZuA2eu3b4V9EiyaEth7yshx6/MFX6gq5Wji3t5ZbnUsBCm5futPdsj6WhZGqCvDfB5mL
         4M8vbVSSP8rvkRq5PG1n1f5GqaIdAxQbCFdcrFZjRE6VHakg6dtI3IgZcAFxNr8Sxoyp
         E0m/jTSx/8SmuQINvBnLqVtpJyqOEkFpxmq0ld54zd6kZo8aJJXqGy6M5vkEh5izDvbY
         yV3gq6Zzr4+EI82Mcm2+9i+DpH/WmWRnskOQeYEy1ka8PwG9GfCmckqHGbxsgODcqv7W
         PBeg==
X-Gm-Message-State: ANoB5pluJq+sfYM81TtHcVJ1jerA3rVz1w8cpBrbv36hR3oeOm2u3Ry9
        B+5j+z+AQ4c2G1z5ivdXpZg=
X-Google-Smtp-Source: AA0mqf7bmamAEQVK9hzyMEBwDICS8pvfhOWQxAG0ENl77UiqFOnWO+WINierTV5lcDPF71G4ebQTxw==
X-Received: by 2002:a17:90b:484:b0:218:9d3d:71f4 with SMTP id bh4-20020a17090b048400b002189d3d71f4mr60721541pjb.148.1669893717107;
        Thu, 01 Dec 2022 03:21:57 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id x28-20020aa7957c000000b00572275e68f8sm2992972pfq.166.2022.12.01.03.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:21:56 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:51:52 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 9/9] ext4: Remove ordered data support from
 ext4_writepage()
Message-ID: <20221201112152.slnmx3u6jh7bhww5@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130163608.29034-9-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/30 05:36PM, Jan Kara wrote:
> ext4_writepage() should not be called for ordered data anymore. Remove
> support for it from the function.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 116 ++++++------------------------------------------
>  1 file changed, 13 insertions(+), 103 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c131b611dabf..0c8e700265f1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1642,12 +1642,6 @@ static void ext4_print_free_blocks(struct inode *inode)
>  	return;
>  }
>
> -static int ext4_bh_delay_or_unwritten(handle_t *handle, struct inode *inode,
> -				      struct buffer_head *bh)
> -{
> -	return (buffer_delay(bh) || buffer_unwritten(bh)) && buffer_dirty(bh);
> -}
> -
>  /*
>   * ext4_insert_delayed_block - adds a delayed block to the extents status
>   *                             tree, incrementing the reserved cluster/block
> @@ -1962,56 +1956,17 @@ static int __ext4_journalled_writepage(struct page *page,
>  }
>
>  /*
> - * Note that we don't need to start a transaction unless we're journaling data
> - * because we should have holes filled from ext4_page_mkwrite(). We even don't
> - * need to file the inode to the transaction's list in ordered mode because if
> - * we are writing back data added by write(), the inode is already there and if
> - * we are writing back data modified via mmap(), no one guarantees in which
> - * transaction the data will hit the disk. In case we are journaling data, we
> - * cannot start transaction directly because transaction start ranks above page
> - * lock so we have to do some magic.
> - *
> - * This function can get called via...
> - *   - ext4_writepages after taking page lock (have journal handle)
> - *   - journal_submit_inode_data_buffers (no journal handle)
> - *   - shrink_page_list via the kswapd/direct reclaim (no journal handle)
> - *   - grab_page_cache when doing write_begin (have journal handle)
> - *
> - * We don't do any block allocation in this function. If we have page with
> - * multiple blocks we need to write those buffer_heads that are mapped. This
> - * is important for mmaped based write. So if we do with blocksize 1K
> - * truncate(f, 1024);
> - * a = mmap(f, 0, 4096);
> - * a[0] = 'a';
> - * truncate(f, 4096);
> - * we have in the page first buffer_head mapped via page_mkwrite call back
> - * but other buffer_heads would be unmapped but dirty (dirty done via the
> - * do_wp_page). So writepage should write the first block. If we modify
> - * the mmap area beyond 1024 we will again get a page_fault and the
> - * page_mkwrite callback will do the block allocation and mark the
> - * buffer_heads mapped.
> - *
> - * We redirty the page if we have any buffer_heads that is either delay or
> - * unwritten in the page.
> - *
> - * We can get recursively called as show below.
> - *
> - *	ext4_writepage() -> kmalloc() -> __alloc_pages() -> page_launder() ->
> - *		ext4_writepage()
> - *
> - * But since we don't do any block allocation we should not deadlock.
> - * Page also have the dirty flag cleared so we don't get recurive page_lock.
> + * This function is now used only when journaling data. We cannot start
> + * transaction directly because transaction start ranks above page lock so we
> + * have to do some magic.
>   */
>  static int ext4_writepage(struct page *page,
>  			  struct writeback_control *wbc)
>  {
>  	struct folio *folio = page_folio(page);
> -	int ret = 0;
>  	loff_t size;
>  	unsigned int len;
> -	struct buffer_head *page_bufs = NULL;
>  	struct inode *inode = page->mapping->host;
> -	struct ext4_io_submit io_submit;
>
>  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
>  		folio_invalidate(folio, 0, folio_size(folio));
> @@ -2036,60 +1991,16 @@ static int ext4_writepage(struct page *page,
>  		return 0;
>  	}
>
> -	page_bufs = page_buffers(page);
> -	/*
> -	 * We cannot do block allocation or other extent handling in this
> -	 * function. If there are buffers needing that, we have to redirty
> -	 * the page. But we may reach here when we do a journal commit via
> -	 * journal_submit_inode_data_buffers() and in that case we must write
> -	 * allocated buffers to achieve data=ordered mode guarantees.

Maybe this description can go above mpage_prepare_extent_to_map
for can_map = 0 case.

Looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>



> -	 *
> -	 * Also, if there is only one buffer per page (the fs block
> -	 * size == the page size), if one buffer needs block
> -	 * allocation or needs to modify the extent tree to clear the
> -	 * unwritten flag, we know that the page can't be written at
> -	 * all, so we might as well refuse the write immediately.
> -	 * Unfortunately if the block size != page size, we can't as
> -	 * easily detect this case using ext4_walk_page_buffers(), but
> -	 * for the extremely common case, this is an optimization that
> -	 * skips a useless round trip through ext4_bio_write_page().
> -	 */
> -	if (ext4_walk_page_buffers(NULL, inode, page_bufs, 0, len, NULL,
> -				   ext4_bh_delay_or_unwritten)) {
> -		redirty_page_for_writepage(wbc, page);
> -		if ((current->flags & PF_MEMALLOC) ||
> -		    (inode->i_sb->s_blocksize == PAGE_SIZE)) {
> -			/*
> -			 * For memory cleaning there's no point in writing only
> -			 * some buffers. So just bail out. Warn if we came here
> -			 * from direct reclaim.
> -			 */
> -			WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD))
> -							== PF_MEMALLOC);
> -			unlock_page(page);
> -			return 0;
> -		}
> -	}
> -
> -	if (PageChecked(page) && ext4_should_journal_data(inode))
> -		/*
> -		 * It's mmapped pagecache.  Add buffers and journal it.  There
> -		 * doesn't seem much point in redirtying the page here.
> -		 */
> -		return __ext4_journalled_writepage(page, len);
> -
> -	ext4_io_submit_init(&io_submit, wbc);
> -	io_submit.io_end = ext4_init_io_end(inode, GFP_NOFS);
> -	if (!io_submit.io_end) {
> -		redirty_page_for_writepage(wbc, page);
> +	WARN_ON_ONCE(!ext4_should_journal_data(inode));
> +	if (!PageChecked(page)) {
>  		unlock_page(page);
> -		return -ENOMEM;
> +		return 0;
>  	}
> -	ret = ext4_bio_write_page(&io_submit, page, len);
> -	ext4_io_submit(&io_submit);
> -	/* Drop io_end reference we got from init */
> -	ext4_put_io_end_defer(io_submit.io_end);
> -	return ret;
> +	/*
> +	 * It's mmapped pagecache.  Add buffers and journal it.  There
> +	 * doesn't seem much point in redirtying the page here.
> +	 */
> +	return __ext4_journalled_writepage(page, len);
>  }
>
>  static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
> @@ -3142,9 +3053,8 @@ static int ext4_da_write_end(struct file *file,
>  	 * i_disksize since writeback will push i_disksize upto i_size
>  	 * eventually. If the end of the current write is > i_size and
>  	 * inside an allocated block (ext4_da_should_update_i_disksize()
> -	 * check), we need to update i_disksize here as neither
> -	 * ext4_writepage() nor certain ext4_writepages() paths not
> -	 * allocating blocks update i_disksize.
> +	 * check), we need to update i_disksize here as ext4_writepages() need
> +	 * not do it in this case.
>  	 *
>  	 * Note that we defer inode dirtying to generic_write_end() /
>  	 * ext4_da_write_inline_data_end().
> --
> 2.35.3
>
