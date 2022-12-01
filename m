Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC7163EF39
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 12:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiLALRa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 06:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiLALRB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 06:17:01 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04421EC77
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 03:14:05 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 140so1552575pfz.6
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zq2ONMD5zS9bODwOwPIy8gKGmyMPXuXGTpzCDN8SFBE=;
        b=NtLmoYax0FT/GweDKZzXYk2iDCCf3LXb0NLaEA7D19/ln06+dcgoTzV1FQqrrWscci
         oZALan1kllXkHYq2E7Z1cErotCZ7R65U6l8/6Ui17D4jgdGIfmCXXZSuTsmr4onsu4ii
         RmalqxxKnmurijwX833wHBIHvl6l++xTKvdhQyApQFxWukcth+AvUW9V3fXXh4Hex5cK
         V2Oi/Dn17WS04f5TLkH9dH7lEbyCHe+F1huLK/q/fpPAyhRXs6JNtEdI9TO4PlEG+u9P
         4J5lFWfsH/ZK/SmsFYva85Q/R+NQPA+6DNJU4UnSrNoyTIboiafJi0+j2e/gAzcj8Yvy
         T8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq2ONMD5zS9bODwOwPIy8gKGmyMPXuXGTpzCDN8SFBE=;
        b=7XcQEMBZoEOAhITUMOcxYIner/xYGhguhFh9sC4JSqx1OA4XLa5y/q7w+ATY4CMrgg
         G7Sr5Qh1AD/JU3For1ZvKmxvGdf1t+GpKFqN+npxfiA+9RATbD2IJwfd4RpN5fBRF1DQ
         ebYvWEiTB4GyqJ0sa0yhOPlWsKbH9WIl9K/5gFdXwYFTFC+rqL5XCaEc6hmwS7aYyQvY
         /b4mXvE53trKcF66rWuD+pFOpljOW1yw9/BdXwhYCFuPZri00WB2wrHBMahZt7Gr2nKv
         pY3kH/SWrXTcnubPOO+/tShSZwIbA+MFPNB13u8c1oadTLhYI2WEV9sEevqLu/vLbAw4
         MtPw==
X-Gm-Message-State: ANoB5pmgZs5tKlqEk51rr0XQ1dUvbzXlrwpdMiSqakGjCNIL4d1gKsk0
        YJvw6l+EbAqrk2X/ORVrOEk=
X-Google-Smtp-Source: AA0mqf47YvIvUmren58SI8t24nwnJpKE0h6XKX2KnmfgB6NPrEW9JzuhIx8L7wC9jTYLcr+9XNFqUQ==
X-Received: by 2002:a63:d516:0:b0:477:857d:d264 with SMTP id c22-20020a63d516000000b00477857dd264mr40106315pgg.224.1669893245226;
        Thu, 01 Dec 2022 03:14:05 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090a3e0500b00218fb211778sm4614560pjc.41.2022.12.01.03.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:14:04 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:43:59 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/9] ext4: Add support for writepages calls that cannot
 map blocks
Message-ID: <20221201111359.onr5edsaaxcr2ndh@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130163608.29034-5-jack@suse.cz>
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
> Add support for calls to ext4_writepages() than cannot map blocks. These
> will be issued from jbd2 transaction commit code.

I guess we should expand the description of mpage_prepare_extent_to_map()
function now. Other than that the patch looks good to me.

Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 47 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 43eb175d0c1c..1cde20eb6500 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1557,6 +1557,7 @@ struct mpage_da_data {
>  	struct ext4_map_blocks map;
>  	struct ext4_io_submit io_submit;	/* IO submission data */
>  	unsigned int do_map:1;
> +	unsigned int can_map:1;	/* Can writepages call map blocks? */
>  	unsigned int scanned_until_end:1;
>  };
>
> @@ -2549,6 +2550,19 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
>  				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
>  }
>
> +/* Return true if the page needs to be written as part of transaction commit */
> +static bool ext4_page_nomap_can_writeout(struct page *page)
> +{
> +	struct buffer_head *bh, *head;
> +
> +	bh = head = page_buffers(page);
> +	do {
> +		if (buffer_dirty(bh) && buffer_mapped(bh) && !buffer_delay(bh))
> +			return true;
> +	} while ((bh = bh->b_this_page) != head);
> +	return false;
> +}
> +
>  /*
>   * mpage_prepare_extent_to_map - find & lock contiguous range of dirty pages
>   * 				 and underlying extent to map

Since we are overloading this function. this can be also called with can_map
as 0. Maybe good to add some description around that?

> @@ -2651,14 +2665,30 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)


adding context of code so that it doesn't get missed in the discussion.

<...>
			/* If we can't merge this page, we are done. */
			if (mpd->map.m_len > 0 && mpd->next_page != page->index)
				goto out;

I guess this also will not hold for us given we will always have m_len to be 0.
<...>
>  			if (mpd->map.m_len == 0)
>  				mpd->first_page = page->index;
>  			mpd->next_page = page->index + 1;
> -			/* Add all dirty buffers to mpd */
> -			lblk = ((ext4_lblk_t)page->index) <<
> -				(PAGE_SHIFT - blkbits);
> -			head = page_buffers(page);
> -			err = mpage_process_page_bufs(mpd, head, head, lblk);
> -			if (err <= 0)
> -				goto out;
> -			err = 0;
> +			/*
> +			 * Writeout for transaction commit where we cannot
> +			 * modify metadata is simple. Just submit the page.
> +			 */
> +			if (!mpd->can_map) {
> +				if (ext4_page_nomap_can_writeout(page)) {
> +					err = mpage_submit_page(mpd, page);
> +					if (err < 0)
> +						goto out;
> +				} else {
> +					unlock_page(page);
> +					mpd->first_page++;

We anyway should always have mpd->map.m_len = 0.
That means, we always set mpd->first_page = page->index above.
So this might not be useful. But I guess for consistency of the code,
or to avoid any future bugs, this isn't harmful to keep.


> +				}
> +			} else {
> +				/* Add all dirty buffers to mpd */
> +				lblk = ((ext4_lblk_t)page->index) <<
> +					(PAGE_SHIFT - blkbits);
> +				head = page_buffers(page);
> +				err = mpage_process_page_bufs(mpd, head, head,
> +							      lblk);
> +				if (err <= 0)
> +					goto out;
> +				err = 0;
> +			}
>  			left--;
>  		}
>  		pagevec_release(&pvec);
> @@ -2778,6 +2808,7 @@ static int ext4_writepages(struct address_space *mapping,
>  	 */
>  	mpd.do_map = 0;
>  	mpd.scanned_until_end = 0;
> +	mpd.can_map = 1;
>  	mpd.io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
>  	if (!mpd.io_submit.io_end) {
>  		ret = -ENOMEM;
> --
> 2.35.3
>
