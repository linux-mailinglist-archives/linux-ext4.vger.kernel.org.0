Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECDD6AF61E
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 20:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjCGTud (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 14:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjCGTuN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 14:50:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD5B952B
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 11:41:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29D37B819F3
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 19:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF561C433EF;
        Tue,  7 Mar 2023 19:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678218080;
        bh=9B9bcqp7oJFC+uGZwxWBD0tZr+TXrnebtvIXb04US5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbN+Cun7E/gWa6W2YECQK6HYoRZFWSw6jorkPhX1nvb/HOdNaI02gOYWH6gkmJ3VJ
         o6+LmvLboYXrE7ym3jXfuY2nkJXakPk6fOcyiLtJ6QLZMS/QrpF8psxwYcFbGY0n8Q
         SYjCyL0o3P1ZV0iUAFSYey1PBDJygxrMof/bcdeu/uR5T5Az/jXWPqc/qYnIrDbRiX
         v/yVRisduvMYSHZT4V3xPRjNIW1vVqpDCngx9V/013dbzbE/DQ3sATwC6fAGShdbtm
         c5IkJQe93X1Y2G5cnzxV+sSm1uAWdM0pveJWVHBuHa0V0CMtf/GK30WKSiydBkwUiF
         Ij3k8B8Lz0JzA==
Date:   Tue, 7 Mar 2023 11:41:18 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs/buffer.c: use b_folio for fsverity work
Message-ID: <ZAeTXsquewxAOHXI@sol.localdomain>
References: <20230224232530.98440-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224232530.98440-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 24, 2023 at 03:25:30PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Use b_folio now that it exists.  This removes an unnecessary call to
> compound_head().  No actual change in behavior.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/buffer.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 9e1e2add541e..034bece27163 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -308,20 +308,19 @@ static void verify_bh(struct work_struct *work)
>  	struct buffer_head *bh = ctx->bh;
>  	bool valid;
>  
> -	valid = fsverity_verify_blocks(page_folio(bh->b_page), bh->b_size,
> -				       bh_offset(bh));
> +	valid = fsverity_verify_blocks(bh->b_folio, bh->b_size, bh_offset(bh));
>  	end_buffer_async_read(bh, valid);
>  	kfree(ctx);
>  }
>  
>  static bool need_fsverity(struct buffer_head *bh)
>  {
> -	struct page *page = bh->b_page;
> -	struct inode *inode = page->mapping->host;
> +	struct folio *folio = bh->b_folio;
> +	struct inode *inode = folio->mapping->host;
>  
>  	return fsverity_active(inode) &&
>  		/* needed by ext4 */
> -		page->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
> +		folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
>  }
>  
>  static void decrypt_bh(struct work_struct *work)
> -- 

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next

- Eric
