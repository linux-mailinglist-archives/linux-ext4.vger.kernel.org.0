Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA36B6D8159
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 17:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbjDEPPs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 11:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbjDEPPa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 11:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9DD7A98
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680707561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SqJwMhzGjMA4RLeL2DTJK7ERbSrDJ+6vKzhw2fl99yc=;
        b=PuDCgkRDjj7ceaDzYJz0/LmRKsfO5Dlw9YIFmG5uT3TScEB0ZOqycR3c6VEdb08gx+7olh
        isCUOAJsDrojxYEIrjPE2IH75+NyyYSbkasWJ7JLHyYygPORoqkTx+K96Hdsv7H7+haQBW
        hiJSuhJ9douR0r390WHr/LTEvBX8MA4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-da6hx3wtN6u6bK9FiLF7oQ-1; Wed, 05 Apr 2023 11:12:40 -0400
X-MC-Unique: da6hx3wtN6u6bK9FiLF7oQ-1
Received: by mail-qv1-f71.google.com with SMTP id v8-20020a0ccd88000000b005c1927d1609so16263574qvm.12
        for <linux-ext4@vger.kernel.org>; Wed, 05 Apr 2023 08:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqJwMhzGjMA4RLeL2DTJK7ERbSrDJ+6vKzhw2fl99yc=;
        b=dqq+dPIgAxX1Dpua/+d2V7Hgno++iShMq9gi+WUIBUz9d1Ymm7lyCFdLI2kfF8CGlm
         iNHNCw3yBk9II0IBXNF2twX2eYPwa2FeMCVc1S1xnB/alD7vLNvGuLiCGJ0yRmFQTQn6
         R62/N+ckIgzFaqcFJE7QikbvO5t2y3NVTXmJS6MXFJzuejZgemFaL7TI2TK7bYI0J04c
         skKXNbewbEbHYOQUMS3PHm2SwRzcwYrbpQZc0JmDxJDgdfI8156GieKO+K/xzIrhUL63
         NR9Ez0WZmuwbCEEQo6ua0q8Qy9SPxtiAu9YMl95cAnJUAFvkVdw5bLuovpZ2LZ9033VD
         s2ig==
X-Gm-Message-State: AAQBX9eggVHrUAC1szoxhUkt0XOvbZCM9XxuPjKVLdwh062ZbUGmrS63
        Cb/v4M1V6vnR6+phHiHmLJEhlUI4/zkeg3FTuHOnEiOy0Iz4idDIu90d4HsMX63DtNjMizKR1Ty
        AGpFGccD8vJ0wKiv1sdq7
X-Received: by 2002:ad4:5cc6:0:b0:5b8:d384:1b1b with SMTP id iu6-20020ad45cc6000000b005b8d3841b1bmr9629019qvb.28.1680707559353;
        Wed, 05 Apr 2023 08:12:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350bTLeyVegiyAT0lX0KuZbEyJnR2oIc+0ekYOMME6yW+MNP2PzqzXS2RPNGFIg86YMrIm+IHVg==
X-Received: by 2002:ad4:5cc6:0:b0:5b8:d384:1b1b with SMTP id iu6-20020ad45cc6000000b005b8d3841b1bmr9628970qvb.28.1680707558963;
        Wed, 05 Apr 2023 08:12:38 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id d1-20020a0cc681000000b005dd8b934579sm4274922qvj.17.2023.04.05.08.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:12:38 -0700 (PDT)
Date:   Wed, 5 Apr 2023 17:12:34 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     djwong@kernel.org, dchinner@redhat.com, hch@infradead.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <20230405151234.sgkuasb7lwmgetzz@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404233224.GE1893@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404233224.GE1893@sol.localdomain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Eric,

On Tue, Apr 04, 2023 at 04:32:24PM -0700, Eric Biggers wrote:
> Hi Andrey,
> 
> On Tue, Apr 04, 2023 at 04:53:17PM +0200, Andrey Albershteyn wrote:
> > In case of different Merkle tree block size fs-verity expects
> > ->read_merkle_tree_page() to return Merkle tree page filled with
> > Merkle tree blocks. The XFS stores each merkle tree block under
> > extended attribute. Those attributes are addressed by block offset
> > into Merkle tree.
> > 
> > This patch make ->read_merkle_tree_page() to fetch multiple merkle
> > tree blocks based on size ratio. Also the reference to each xfs_buf
> > is passed with page->private to ->drop_page().
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/xfs/xfs_verity.c | 74 +++++++++++++++++++++++++++++++++++----------
> >  fs/xfs/xfs_verity.h |  8 +++++
> >  2 files changed, 66 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
> > index a9874ff4efcd..ef0aff216f06 100644
> > --- a/fs/xfs/xfs_verity.c
> > +++ b/fs/xfs/xfs_verity.c
> > @@ -134,6 +134,10 @@ xfs_read_merkle_tree_page(
> >  	struct page		*page = NULL;
> >  	__be64			name = cpu_to_be64(index << PAGE_SHIFT);
> >  	uint32_t		bs = 1 << log_blocksize;
> > +	int			blocks_per_page =
> > +		(1 << (PAGE_SHIFT - log_blocksize));
> > +	int			n = 0;
> > +	int			offset = 0;
> >  	struct xfs_da_args	args = {
> >  		.dp		= ip,
> >  		.attr_filter	= XFS_ATTR_VERITY,
> > @@ -143,26 +147,59 @@ xfs_read_merkle_tree_page(
> >  		.valuelen	= bs,
> >  	};
> >  	int			error = 0;
> > +	bool			is_checked = true;
> > +	struct xfs_verity_buf_list	*buf_list;
> >  
> >  	page = alloc_page(GFP_KERNEL);
> >  	if (!page)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	error = xfs_attr_get(&args);
> > -	if (error) {
> > -		kmem_free(args.value);
> > -		xfs_buf_rele(args.bp);
> > +	buf_list = kzalloc(sizeof(struct xfs_verity_buf_list), GFP_KERNEL);
> > +	if (!buf_list) {
> >  		put_page(page);
> > -		return ERR_PTR(-EFAULT);
> > +		return ERR_PTR(-ENOMEM);
> >  	}
> >  
> > -	if (args.bp->b_flags & XBF_VERITY_CHECKED)
> > +	/*
> > +	 * Fill the page with Merkle tree blocks. The blcoks_per_page is higher
> > +	 * than 1 when fs block size != PAGE_SIZE or Merkle tree block size !=
> > +	 * PAGE SIZE
> > +	 */
> > +	for (n = 0; n < blocks_per_page; n++) {
> > +		offset = bs * n;
> > +		name = cpu_to_be64(((index << PAGE_SHIFT) + offset));
> > +		args.name = (const uint8_t *)&name;
> > +
> > +		error = xfs_attr_get(&args);
> > +		if (error) {
> > +			kmem_free(args.value);
> > +			/*
> > +			 * No more Merkle tree blocks (e.g. this was the last
> > +			 * block of the tree)
> > +			 */
> > +			if (error == -ENOATTR)
> > +				break;
> > +			xfs_buf_rele(args.bp);
> > +			put_page(page);
> > +			kmem_free(buf_list);
> > +			return ERR_PTR(-EFAULT);
> > +		}
> > +
> > +		buf_list->bufs[buf_list->buf_count++] = args.bp;
> > +
> > +		/* One of the buffers was dropped */
> > +		if (!(args.bp->b_flags & XBF_VERITY_CHECKED))
> > +			is_checked = false;
> > +
> > +		memcpy(page_address(page) + offset, args.value, args.valuelen);
> > +		kmem_free(args.value);
> > +		args.value = NULL;
> > +	}
> 
> I was really hoping for a solution where the cached data can be used directly,
> instead allocating a temporary page and copying the cached data into it every
> time the cache is accessed.  The problem with what you have now is that every
> time a single 32-byte hash is accessed, a full page (potentially 64KB!) will be
> allocated and filled.  That's not very efficient.  The need to allocate the
> temporary page can also cause ENOMEM (which will get reported as EIO).
> 
> Did you consider alternatives that would work more efficiently?  I think it
> would be worth designing something that works properly with how XFS is planned
> to cache the Merkle tree, instead of designing a workaround.
> ->read_merkle_tree_page was not really designed for what you are doing here.
> 
> How about replacing ->read_merkle_tree_page with a function that takes in a
> Merkle tree block index (not a page index!) and hands back a (page, offset) pair
> that identifies where the Merkle tree block's data is located?  Or (folio,
> offset), I suppose.
> 
> With that, would it be possible to directly return the XFS cache?
> 
> - Eric
> 

Yeah, I also don't like it, I didn't want to change fs-verity much
so went with this workaround. But as it's ok, I will look into trying
to pass xfs buffers to fs-verity without direct use of
->read_merkle_tree_page(). I think it's possible with (folio,
offset), the xfs buffers aren't xattr value align so the 4k merkle
tree block is stored in two pages.

Thanks for suggestion!

-- 
- Andrey

