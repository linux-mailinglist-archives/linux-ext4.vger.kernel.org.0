Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7FE63EF4B
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiLALTZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 06:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiLALSy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 06:18:54 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256B1A5557
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 03:15:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so1696752pjm.2
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwzHaXla7djs+GLVkya13TnK94uJPe0RT1zazwzufhY=;
        b=CB9aiFMrGHZbEHgBrLOem4v4UpYV1unA7YPxmIueRWa9uqSWl0o/gNi5DhWeF0UX3X
         g/6o0+4faN7+I9LqP4mReqFQUQF3RzLYI5CVFJs9hiy1vy6wkVYluvGH7mgecNwd+K/M
         U4d+lzTXAVjWppayiTJy+1LWsS1DJRyInaIOIv3wdSH9u2/MmQYjS+KzFmB2/W/AgiKa
         DL6BIskiFhZE87jKiRYvgdN5D1eavESMQa4UJFTBDBdOY9hp2a/xmUAyNVzD7xeAEjou
         nSTP7al/duzHL2GWfUbjojb631eMhhmYmTksoSbM57X52vUC5fc8gULAlj0U3zfUbw5c
         FW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwzHaXla7djs+GLVkya13TnK94uJPe0RT1zazwzufhY=;
        b=OjwlK1YyLJylRDRzdc6fMtDDglMyZ+mlhOuLQn2cBaHXN/YM8STHUJnnF/pzXEVUc9
         7S3en1V6jx35ziiWvfgiO2FEooQBLZ4H8ZQJdmFlsqwy3JNyQeULnx3Y/z+S4ZH5rs8p
         8jhHfeper5CR5DWJDQmZBTXSvxYwZIaVjwMtYuAJFhJggoCtAxYxCa4/v4br6uj94OPT
         2sW51jo71ZTwBl/1WaMEYw9HdPCDUlETyiUH3noHI7uQIB8gDSyk5kD3ptRrThI5GAGs
         CqykemX5kWfJMJJtfqoEXGMxhFA7SX3og58XpCPIDGmFad4b9gCsNNI1G6oXfEJYkGW/
         MV5w==
X-Gm-Message-State: ANoB5pmLaN+Swqgw6Gok2hFJG2NUJPecW9BtCs5EkW5EeW1HsLmyoopV
        piLqOefCSlqu8bYC80CZ/WA=
X-Google-Smtp-Source: AA0mqf4dFV40wCf19e9W8zM5DGQXKYyFNMG86WRlh/fn4jVHlhMWJoPGxEEzGuNJMMUKpmWCYYMCjA==
X-Received: by 2002:a17:902:e948:b0:189:26bb:870b with SMTP id b8-20020a170902e94800b0018926bb870bmr48168841pll.53.1669893342558;
        Thu, 01 Dec 2022 03:15:42 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e74a00b00186acb14c4asm3388193plf.67.2022.12.01.03.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:15:42 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:45:37 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 6/9] ext4: Provide ext4_do_writepages()
Message-ID: <20221201111537.oai5xaibwynyst4u@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130163608.29034-6-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/30 05:35PM, Jan Kara wrote:
> Provide ext4_do_writepages() function that takes mpage_da_data as an
> argument and make ext4_writepages() just a simple wrapper around it. No
> functional changes.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 96 +++++++++++++++++++++++++++----------------------
>  1 file changed, 54 insertions(+), 42 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1cde20eb6500..fbea77ab470f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1543,9 +1543,12 @@ void ext4_da_release_space(struct inode *inode, int to_free)
>   */
>
>  struct mpage_da_data {
> +	/* These are input fields for ext4_do_writepages() */
>  	struct inode *inode;
>  	struct writeback_control *wbc;
> +	unsigned int can_map:1;	/* Can writepages call map blocks? */
>
> +	/* These are internal state of ext4_do_writepages() */
>  	pgoff_t first_page;	/* The first page to write */
>  	pgoff_t next_page;	/* Current page to examine */
>  	pgoff_t last_page;	/* Last page to examine */
> @@ -1557,7 +1560,6 @@ struct mpage_da_data {
>  	struct ext4_map_blocks map;
>  	struct ext4_io_submit io_submit;	/* IO submission data */
>  	unsigned int do_map:1;
> -	unsigned int can_map:1;	/* Can writepages call map blocks? */
>  	unsigned int scanned_until_end:1;
>  };
>
> @@ -2701,16 +2703,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  	return err;
>  }
>
> -static int ext4_writepages(struct address_space *mapping,
> -			   struct writeback_control *wbc)
> +static int ext4_do_writepages(struct mpage_da_data *mpd)
>  {
> +	struct writeback_control *wbc = mpd->wbc;
>  	pgoff_t	writeback_index = 0;
>  	long nr_to_write = wbc->nr_to_write;
>  	int range_whole = 0;
>  	int cycled = 1;
>  	handle_t *handle = NULL;
> -	struct mpage_da_data mpd;
> -	struct inode *inode = mapping->host;
> +	struct inode *inode = mpd->inode;
> +	struct address_space *mapping = inode->i_mapping;
>  	int needed_blocks, rsv_blocks = 0, ret = 0;
>  	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
>  	struct blk_plug plug;
> @@ -2785,19 +2787,18 @@ static int ext4_writepages(struct address_space *mapping,
>  		writeback_index = mapping->writeback_index;
>  		if (writeback_index)
>  			cycled = 0;
> -		mpd.first_page = writeback_index;
> -		mpd.last_page = -1;
> +		mpd->first_page = writeback_index;
> +		mpd->last_page = -1;
>  	} else {
> -		mpd.first_page = wbc->range_start >> PAGE_SHIFT;
> -		mpd.last_page = wbc->range_end >> PAGE_SHIFT;
> +		mpd->first_page = wbc->range_start >> PAGE_SHIFT;
> +		mpd->last_page = wbc->range_end >> PAGE_SHIFT;
>  	}
>
> -	mpd.inode = inode;
> -	mpd.wbc = wbc;
> -	ext4_io_submit_init(&mpd.io_submit, wbc);
> +	ext4_io_submit_init(&mpd->io_submit, wbc);
>  retry:
>  	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag_pages_for_writeback(mapping, mpd.first_page, mpd.last_page);
> +		tag_pages_for_writeback(mapping, mpd->first_page,
> +					mpd->last_page);
>  	blk_start_plug(&plug);
>
>  	/*
> @@ -2806,28 +2807,27 @@ static int ext4_writepages(struct address_space *mapping,
>  	 * in the block layer on device congestion while having transaction
>  	 * started.
>  	 */
> -	mpd.do_map = 0;
> -	mpd.scanned_until_end = 0;
> -	mpd.can_map = 1;
> -	mpd.io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
> -	if (!mpd.io_submit.io_end) {
> +	mpd->do_map = 0;
> +	mpd->scanned_until_end = 0;
> +	mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
> +	if (!mpd->io_submit.io_end) {
>  		ret = -ENOMEM;
>  		goto unplug;
>  	}
> -	ret = mpage_prepare_extent_to_map(&mpd);
> +	ret = mpage_prepare_extent_to_map(mpd);
>  	/* Unlock pages we didn't use */
> -	mpage_release_unused_pages(&mpd, false);
> +	mpage_release_unused_pages(mpd, false);
>  	/* Submit prepared bio */
> -	ext4_io_submit(&mpd.io_submit);
> -	ext4_put_io_end_defer(mpd.io_submit.io_end);
> -	mpd.io_submit.io_end = NULL;
> +	ext4_io_submit(&mpd->io_submit);
> +	ext4_put_io_end_defer(mpd->io_submit.io_end);
> +	mpd->io_submit.io_end = NULL;
>  	if (ret < 0)
>  		goto unplug;
>
> -	while (!mpd.scanned_until_end && wbc->nr_to_write > 0) {
> +	while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
>  		/* For each extent of pages we use new io_end */
> -		mpd.io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
> -		if (!mpd.io_submit.io_end) {
> +		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
> +		if (!mpd->io_submit.io_end) {
>  			ret = -ENOMEM;
>  			break;
>  		}
> @@ -2851,16 +2851,16 @@ static int ext4_writepages(struct address_space *mapping,
>  			       "%ld pages, ino %lu; err %d", __func__,
>  				wbc->nr_to_write, inode->i_ino, ret);
>  			/* Release allocated io_end */
> -			ext4_put_io_end(mpd.io_submit.io_end);
> -			mpd.io_submit.io_end = NULL;
> +			ext4_put_io_end(mpd->io_submit.io_end);
> +			mpd->io_submit.io_end = NULL;
>  			break;
>  		}
> -		mpd.do_map = 1;
> +		mpd->do_map = 1;
>
> -		trace_ext4_da_write_pages(inode, mpd.first_page, mpd.wbc);
> -		ret = mpage_prepare_extent_to_map(&mpd);
> -		if (!ret && mpd.map.m_len)
> -			ret = mpage_map_and_submit_extent(handle, &mpd,
> +		trace_ext4_da_write_pages(inode, mpd->first_page, wbc);
> +		ret = mpage_prepare_extent_to_map(mpd);
> +		if (!ret && mpd->map.m_len)
> +			ret = mpage_map_and_submit_extent(handle, mpd,
>  					&give_up_on_write);
>  		/*
>  		 * Caution: If the handle is synchronous,
> @@ -2875,12 +2875,12 @@ static int ext4_writepages(struct address_space *mapping,
>  		if (!ext4_handle_valid(handle) || handle->h_sync == 0) {
>  			ext4_journal_stop(handle);
>  			handle = NULL;
> -			mpd.do_map = 0;
> +			mpd->do_map = 0;
>  		}
>  		/* Unlock pages we didn't use */
> -		mpage_release_unused_pages(&mpd, give_up_on_write);
> +		mpage_release_unused_pages(mpd, give_up_on_write);
>  		/* Submit prepared bio */
> -		ext4_io_submit(&mpd.io_submit);
> +		ext4_io_submit(&mpd->io_submit);
>
>  		/*
>  		 * Drop our io_end reference we got from init. We have
> @@ -2890,11 +2890,11 @@ static int ext4_writepages(struct address_space *mapping,
>  		 * up doing unwritten extent conversion.
>  		 */
>  		if (handle) {
> -			ext4_put_io_end_defer(mpd.io_submit.io_end);
> +			ext4_put_io_end_defer(mpd->io_submit.io_end);
>  			ext4_journal_stop(handle);
>  		} else
> -			ext4_put_io_end(mpd.io_submit.io_end);
> -		mpd.io_submit.io_end = NULL;
> +			ext4_put_io_end(mpd->io_submit.io_end);
> +		mpd->io_submit.io_end = NULL;
>
>  		if (ret == -ENOSPC && sbi->s_journal) {
>  			/*
> @@ -2914,8 +2914,8 @@ static int ext4_writepages(struct address_space *mapping,
>  	blk_finish_plug(&plug);
>  	if (!ret && !cycled && wbc->nr_to_write > 0) {
>  		cycled = 1;
> -		mpd.last_page = writeback_index - 1;
> -		mpd.first_page = 0;
> +		mpd->last_page = writeback_index - 1;
> +		mpd->first_page = 0;
>  		goto retry;
>  	}
>
> @@ -2925,7 +2925,7 @@ static int ext4_writepages(struct address_space *mapping,
>  		 * Set the writeback_index so that range_cyclic
>  		 * mode will write it back later
>  		 */
> -		mapping->writeback_index = mpd.first_page;
> +		mapping->writeback_index = mpd->first_page;
>
>  out_writepages:
>  	trace_ext4_writepages_result(inode, wbc, ret,
> @@ -2934,6 +2934,18 @@ static int ext4_writepages(struct address_space *mapping,
>  	return ret;
>  }
>
> +static int ext4_writepages(struct address_space *mapping,
> +			   struct writeback_control *wbc)
> +{
> +	struct mpage_da_data mpd = {
> +		.inode = mapping->host,
> +		.wbc = wbc,
> +		.can_map = 1,
> +	};
> +
> +	return ext4_do_writepages(&mpd);
> +}
> +

Nice. Looks good to me.

Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


