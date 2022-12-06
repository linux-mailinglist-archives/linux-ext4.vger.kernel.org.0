Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629B8644D7F
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 21:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLFUuD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 15:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLFUuC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 15:50:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B03421A4;
        Tue,  6 Dec 2022 12:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GqYeEdRDIKDtP3Dh80e8LwPs1x4Mm1fuIZpe+mpsqUo=; b=pFvMCi6tmMv7Df3dHJpArkuvrS
        NwU5N4UYVTvX97KS2MivBzmbmL/bKB0UXqgc22Oj7YX1Aw0TgdjMyfsfclWi3qeCGc3zaIvxE3Nfq
        7jaybLs+3ug/gLuc+ZTvBkZLus9FV3l7eN9+SwWYwVv1xgMPD813u/zFzV4Y6aNVkuyOZqS90Umvo
        pT6bcotK9JEt+kiM/uIdS/6/+vZMna8KD6YNaOaH2wLVDq7fd/62WSRvwL6f3r2rWXzti382wnM1T
        dTybBbZTe9mYcbaGxdkIT/3cQAtFaa8st7fMHXdBou1CPgZvz1m1ZEQA1jNlHfvMIyWJiBYpFCd+t
        bZS9+H/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2et8-004o0f-9T; Tue, 06 Dec 2022 20:50:02 +0000
Date:   Tue, 6 Dec 2022 20:50:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH mm-unstable] ext4: Convert mext_page_double_lock() to
 mext_folio_double_lock()
Message-ID: <Y4+q+vYuqqM0RKOT@casper.infradead.org>
References: <20221206204115.35258-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206204115.35258-1-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 06, 2022 at 12:41:15PM -0800, Vishal Moola (Oracle) wrote:
> Converts mext_page_double_lock() to use folios. This change saves
> 146 bytes of kernel text and removes 3 calls to compound_head().

I think it actually removes more than three ...

>  	flags = memalloc_nofs_save();
> -	page[0] = grab_cache_page_write_begin(mapping[0], index1);
> -	if (!page[0]) {
> +	folio[0] = __filemap_get_folio(mapping[0], index1, fgp_flags,
> +			mapping_gfp_mask(mapping[0]));

one

> +	if (!folio[0]) {
>  		memalloc_nofs_restore(flags);
>  		return -ENOMEM;
>  	}
>  
> -	page[1] = grab_cache_page_write_begin(mapping[1], index2);
> +	folio[1] = __filemap_get_folio(mapping[1], index2, fgp_flags,
> +			mapping_gfp_mask(mapping[1]));

two

>  	memalloc_nofs_restore(flags);
> -	if (!page[1]) {
> -		unlock_page(page[0]);
> -		put_page(page[0]);
> +	if (!folio[1]) {
> +		folio_unlock(folio[0]);
> +		folio_put(folio[0]);

four

>  		return -ENOMEM;
>  	}
>  	/*
> -	 * grab_cache_page_write_begin() may not wait on page's writeback if
> +	 * __filemap_get_folio() may not wait on folio's writeback if
>  	 * BDI not demand that. But it is reasonable to be very conservative
> -	 * here and explicitly wait on page's writeback
> +	 * here and explicitly wait on folio's writeback
>  	 */
> -	wait_on_page_writeback(page[0]);
> -	wait_on_page_writeback(page[1]);
> +	folio_wait_writeback(folio[0]);
> +	folio_wait_writeback(folio[1]);

six

>  	if (inode1 > inode2)
> -		swap(page[0], page[1]);
> +		swap(folio[0], folio[1]);
>  
>  	return 0;
>  }
> @@ -252,7 +255,6 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
>  		     int block_len_in_page, int unwritten, int *err)
>  {
>  	struct inode *orig_inode = file_inode(o_filp);
> -	struct page *pagep[2] = {NULL, NULL};
>  	struct folio *folio[2] = {NULL, NULL};
>  	handle_t *handle;
>  	ext4_lblk_t orig_blk_offset, donor_blk_offset;
> @@ -303,8 +305,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
>  
>  	replaced_size = data_size;
>  
> -	*err = mext_page_double_lock(orig_inode, donor_inode, orig_page_offset,
> -				     donor_page_offset, pagep);
> +	*err = mext_folio_double_lock(orig_inode, donor_inode, orig_page_offset,
> +				     donor_page_offset, folio);
>  	if (unlikely(*err < 0))
>  		goto stop_journal;
>  	/*
> @@ -314,8 +316,6 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
>  	 * hold page's lock, if it is still the case data copy is not
>  	 * necessary, just swap data blocks between orig and donor.
>  	 */
> -	folio[0] = page_folio(pagep[0]);
> -	folio[1] = page_folio(pagep[1]);

eight.

Three are inline, which makes sense for the 146 bytes, but we're also
removing out of line calls as well as the inline calls.

Anyway, whether the description is updated or not, this looks good to me.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
