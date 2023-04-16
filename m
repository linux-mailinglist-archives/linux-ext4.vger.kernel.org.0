Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C906E3B91
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Apr 2023 21:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDPTj5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 15:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDPTj4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 15:39:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807852136
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D7A88ilqY4lEnHOcnoi2q4b4ArbBIYT1MIBWlwVd/98=; b=NnWpoLEdfYCL8TBNTpJYv84Olo
        vmB2Y0oiff1oK9MOb56qhWdbezlyGeFNxo+wo9Ll+Y7OKvoFQI0P/PQ1lXuWBsMMDBo5kt/FSS3GT
        j3/kOqQNZaP9djHswnx7amukBw4y9pNlbapLD7ooz71FBhA1IxIlsVFw+UX9/UpHSxLyQz2omgAx6
        mAbRUgR5mXYt7f/9CRLrNgeVDKgcJhZN6W3/bmeEYTw7SCBg8WLDqCTj2d1IhmNebOZLLBzMkCzsz
        LdEg3lgwJelJJTv4pJ8IEtnMYer2nkHnqY7K5sr3Kmni1nXp7hhO2G99NOQJBY4WvwyVcMyt6Zcs5
        t6Nmgf8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1po8E3-00Ac9A-EX; Sun, 16 Apr 2023 19:39:51 +0000
Date:   Sun, 16 Apr 2023 20:39:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv1 2/4] ext4: Change remaining tracepoints to use folio
Message-ID: <ZDxPB37NKDyXx9mE@casper.infradead.org>
References: <cover.1681669004.git.ritesh.list@gmail.com>
 <c9add7e988b0a64d448892da806e3b623c6cf8d3.1681669004.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9add7e988b0a64d448892da806e3b623c6cf8d3.1681669004.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 12:01:51AM +0530, Ritesh Harjani (IBM) wrote:
> est4_readpage() is converted to ext4_read_folio() hence change the
> related tracepoint from trace_ext4_readpage(page) to
> trace_ext4_read_folio(folio).
> 
> Do the same for trace_ext4_releasepage(page) to
> trace_ext4_release_folio(folio)

Thanks for doing this!

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

One possible enhancement is that each fo these functions does
folio->mapping->host already.  We could change ext4__folio_op
to take (inode, folio) instead of just folio and simplify/remove
some dereferences.

> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/inode.c             |  4 ++--
>  include/trace/events/ext4.h | 26 +++++++++++++-------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6d628d6c0847..5bb141288b1b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3157,7 +3157,7 @@ static int ext4_read_folio(struct file *file, struct folio *folio)
>  	int ret = -EAGAIN;
>  	struct inode *inode = folio->mapping->host;
>  
> -	trace_ext4_readpage(&folio->page);
> +	trace_ext4_read_folio(folio);
>  
>  	if (ext4_has_inline_data(inode))
>  		ret = ext4_readpage_inline(inode, folio);
> @@ -3218,7 +3218,7 @@ static bool ext4_release_folio(struct folio *folio, gfp_t wait)
>  {
>  	journal_t *journal = EXT4_JOURNAL(folio->mapping->host);
>  
> -	trace_ext4_releasepage(&folio->page);
> +	trace_ext4_release_folio(folio);
>  
>  	/* Page has dirty journalled data -> cannot release */
>  	if (folio_test_checked(folio))
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index ebccf6a6aa1b..a9415f1c68ec 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -560,10 +560,10 @@ TRACE_EVENT(ext4_writepages_result,
>  		  (unsigned long) __entry->writeback_index)
>  );
>  
> -DECLARE_EVENT_CLASS(ext4__page_op,
> -	TP_PROTO(struct page *page),
> +DECLARE_EVENT_CLASS(ext4__folio_op,
> +	TP_PROTO(struct folio *folio),
>  
> -	TP_ARGS(page),
> +	TP_ARGS(folio),
>  
>  	TP_STRUCT__entry(
>  		__field(	dev_t,	dev			)
> @@ -573,29 +573,29 @@ DECLARE_EVENT_CLASS(ext4__page_op,
>  	),
>  
>  	TP_fast_assign(
> -		__entry->dev	= page->mapping->host->i_sb->s_dev;
> -		__entry->ino	= page->mapping->host->i_ino;
> -		__entry->index	= page->index;
> +		__entry->dev	= folio->mapping->host->i_sb->s_dev;
> +		__entry->ino	= folio->mapping->host->i_ino;
> +		__entry->index	= folio->index;
>  	),
>  
> -	TP_printk("dev %d,%d ino %lu page_index %lu",
> +	TP_printk("dev %d,%d ino %lu folio_index %lu",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  (unsigned long) __entry->ino,
>  		  (unsigned long) __entry->index)
>  );
>  
> -DEFINE_EVENT(ext4__page_op, ext4_readpage,
> +DEFINE_EVENT(ext4__folio_op, ext4_read_folio,
>  
> -	TP_PROTO(struct page *page),
> +	TP_PROTO(struct folio *folio),
>  
> -	TP_ARGS(page)
> +	TP_ARGS(folio)
>  );
>  
> -DEFINE_EVENT(ext4__page_op, ext4_releasepage,
> +DEFINE_EVENT(ext4__folio_op, ext4_release_folio,
>  
> -	TP_PROTO(struct page *page),
> +	TP_PROTO(struct folio *folio),
>  
> -	TP_ARGS(page)
> +	TP_ARGS(folio)
>  );
>  
>  DECLARE_EVENT_CLASS(ext4_invalidate_folio_op,
> -- 
> 2.39.2
> 
