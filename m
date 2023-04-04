Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2613B6D6794
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjDDPhq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 11:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbjDDPhk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 11:37:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86844ED1;
        Tue,  4 Apr 2023 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RdOI5GFBXvz2+CG+FGj78+ixvujqTitirHZIon4ASxI=; b=Ahkq88G655jnqkQwTcWuEN6RRq
        h8yjZsKe+Ya6vZx2aj5qznyop6e9Fzt7P3UjXbJv3YvhdNnBewCyzgwcmFuLfVIeeo8HxJITi6zqF
        VoJUTlDJH5weysUFBompr1TeaFJM8Cz/IkuTB8joY0PeYjQN3d5QSaNxM/Z9JSHb6bQ7wMMntt34l
        7HaqQ/BUxGKLrBBoO7LliRbNqk1tsSJOHBjuMuQ7qPPZJPANfHUxtfGJ6ugxXpXKnJP4ZjWXMUpqq
        uLWr5qtFE8Do8CSM76bQ0+Ns9i69roqtrrCuU0gAnh3o2vzYHSwZCxKjZFPcpTofIEqLTRS34odrA
        LrFUS5OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiiU-0021sG-0G;
        Tue, 04 Apr 2023 15:37:02 +0000
Date:   Tue, 4 Apr 2023 08:37:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 09/23] iomap: allow filesystem to implement read path
 verification
Message-ID: <ZCxEHkWayQyGqnxL@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-10-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-10-aalbersh@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

>  	if (iomap_block_needs_zeroing(iter, pos)) {
>  		folio_zero_range(folio, poff, plen);
> +		if (iomap->flags & IOMAP_F_READ_VERITY) {

Wju do we need the new flag vs just testing that folio_ops and
folio_ops->verify_folio is non-NULL?

> -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> -				     REQ_OP_READ, gfp);
> +		ctx->bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs),
> +				REQ_OP_READ, GFP_NOFS, &iomap_read_ioend_bioset);

All other callers don't really need the larger bioset, so I'd avoid
the unconditional allocation here, but more on that later.

> +		ioend = container_of(ctx->bio, struct iomap_read_ioend,
> +				read_inline_bio);
> +		ioend->io_inode = iter->inode;
> +		if (ctx->ops && ctx->ops->prepare_ioend)
> +			ctx->ops->prepare_ioend(ioend);
> +

So what we're doing in writeback and direct I/O, is to:

 a) have a submit_bio hook
 b) allow the file system to then hook the bi_end_io caller
 c) (only in direct O/O for now) allow the file system to provide
    a bio_set to allocate from

I wonder if that also makes sense and keep all the deferral in the
file system.  We'll need that for the btrfs iomap conversion anyway,
and it seems more flexible.  The ioend processing would then move into
XFS.

> @@ -156,6 +160,11 @@ struct iomap_folio_ops {
>  	 * locked by the iomap code.
>  	 */
>  	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> +
> +	/*
> +	 * Verify folio when successfully read
> +	 */
> +	bool (*verify_folio)(struct folio *folio, loff_t pos, unsigned int len);

Why isn't this in iomap_readpage_ops?
