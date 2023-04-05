Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32BB6D8124
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbjDEPKU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 11:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjDEPJy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 11:09:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1347A8F;
        Wed,  5 Apr 2023 08:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D5E463E79;
        Wed,  5 Apr 2023 15:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90FCC4339E;
        Wed,  5 Apr 2023 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680707188;
        bh=mlni390c+gmIDMlX2RnZzsHsCPBkb+xutjeyTZL88LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0Y5O+66tWXrhcV6ndCx07PGooMOJap5OIdpqEdvYFYnMHN0z5WiLYrWuKcSeaXHl
         UcZpAG3fUrlrKjP5/sAagW6AWG69d+rXgg1WBgDW+rC9NaJekXCvMerJzsJkjRnsXH
         m4Q6uAO39XKLOFgPn03RBth+eXeK/rY/VE0Yu1qLMe93Au/pMBUkCWq3xQz6voM133
         knKAwxEb9wOgh0gF0jn6wi8T39XIQ/aCS62UgeWnfbPOpTkjgiMeytHY928u5OUjWN
         J9dEljNMTn2fktd2Sp1o8GdjUkAWHM/TRVCjrukbVy3Hv8BEKS4poWg1XrW7ftU4DI
         o6Z6xJuTGto9g==
Date:   Wed, 5 Apr 2023 08:06:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, dchinner@redhat.com,
        ebiggers@kernel.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 09/23] iomap: allow filesystem to implement read path
 verification
Message-ID: <20230405150627.GC303486@frogsfrogsfrogs>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-10-aalbersh@redhat.com>
 <ZCxEHkWayQyGqnxL@infradead.org>
 <20230405110116.ia5wv3qxbnpdciui@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405110116.ia5wv3qxbnpdciui@aalbersh.remote.csb>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 01:01:16PM +0200, Andrey Albershteyn wrote:
> Hi Christoph,
> 
> On Tue, Apr 04, 2023 at 08:37:02AM -0700, Christoph Hellwig wrote:
> > >  	if (iomap_block_needs_zeroing(iter, pos)) {
> > >  		folio_zero_range(folio, poff, plen);
> > > +		if (iomap->flags & IOMAP_F_READ_VERITY) {
> > 
> > Wju do we need the new flag vs just testing that folio_ops and
> > folio_ops->verify_folio is non-NULL?
> 
> Yes, it can be just test, haven't noticed that it's used only here,
> initially I used it in several places.
> 
> > 
> > > -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> > > -				     REQ_OP_READ, gfp);
> > > +		ctx->bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs),
> > > +				REQ_OP_READ, GFP_NOFS, &iomap_read_ioend_bioset);
> > 
> > All other callers don't really need the larger bioset, so I'd avoid
> > the unconditional allocation here, but more on that later.
> 
> Ok, make sense.
> 
> > 
> > > +		ioend = container_of(ctx->bio, struct iomap_read_ioend,
> > > +				read_inline_bio);
> > > +		ioend->io_inode = iter->inode;
> > > +		if (ctx->ops && ctx->ops->prepare_ioend)
> > > +			ctx->ops->prepare_ioend(ioend);
> > > +
> > 
> > So what we're doing in writeback and direct I/O, is to:
> > 
> >  a) have a submit_bio hook
> >  b) allow the file system to then hook the bi_end_io caller
> >  c) (only in direct O/O for now) allow the file system to provide
> >     a bio_set to allocate from
> 
> I see.
> 
> > 
> > I wonder if that also makes sense and keep all the deferral in the
> > file system.  We'll need that for the btrfs iomap conversion anyway,
> > and it seems more flexible.  The ioend processing would then move into
> > XFS.
> > 
> 
> Not sure what you mean here.

I /think/ Christoph is talking about allowing callers of iomap pagecache
operations to supply a custom submit_bio function and a bio_set so that
filesystems can add in their own post-IO processing and appropriately
sized (read: minimum you can get away with) bios.  I imagine btrfs has
quite a lot of (read) ioend processing they need to do, as will xfs now
that you're adding fsverity.

> > > @@ -156,6 +160,11 @@ struct iomap_folio_ops {
> > >  	 * locked by the iomap code.
> > >  	 */
> > >  	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> > > +
> > > +	/*
> > > +	 * Verify folio when successfully read
> > > +	 */
> > > +	bool (*verify_folio)(struct folio *folio, loff_t pos, unsigned int len);

Any reason why we shouldn't return the usual negative errno?

> > Why isn't this in iomap_readpage_ops?
> > 
> 
> Yes, it can be. But it appears to me to be more relevant to
> _folio_ops, any particular reason to move it there? Don't mind
> moving it to iomap_readpage_ops.

I think the point is that this is a general "check what we just read"
hook, so it could be in readpage_ops since we're never going to need to
re-validate verity contents, right?  Hence it could be in readpage_ops
instead of the general iomap_folio_ops.

<shrug> Is there a use case for ->verify_folio that isn't a read post-
processing step?

--D

> -- 
> - Andrey
> 
