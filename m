Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13086D82CF
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjDEQDN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbjDEQDM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 12:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E2E40E0
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680710550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4E5sAaKj2nRhZMpCfhlf1IVMfFLjV6lcrwFxgfc+2Uo=;
        b=cGM/yVshAUMr9/igXZVs2TQJwuHhJ+JzQSaajsHhsxK2+Mp5piRqdtwFBivCJ2DFDDM1ZL
        Vuw4B98E/WnwcdTdyACtOlK1xX+Y5HREAFDUzAcMTEKfsRblGWy2ey6IJJ+oXUn17mq+2x
        hL1yzmLKqk0Qw1YjRRYGzXtZV/3+sUE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-kCqsheJyOReJMWwnYoqD9w-1; Wed, 05 Apr 2023 12:02:29 -0400
X-MC-Unique: kCqsheJyOReJMWwnYoqD9w-1
Received: by mail-qt1-f199.google.com with SMTP id y10-20020a05622a164a00b003e38e0a3cc3so24540982qtj.14
        for <linux-ext4@vger.kernel.org>; Wed, 05 Apr 2023 09:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680710548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E5sAaKj2nRhZMpCfhlf1IVMfFLjV6lcrwFxgfc+2Uo=;
        b=JHVYh5Zq6P6jM0JHIUY22cDMTdmQOuScQZ5b1mDikFVAS3p34JNJlg1+uP+DB7HcNG
         NOcFx0unR27+C9YqfzeslvUMr2zLMtMHoWGI8gEJxuYtTOrgVzOkUBVw5reOk1hCpHHN
         Q5goN885g0Gq55Fl4Yw9rwgPGCUfTy+EFMLsRkP609BjJOJJ9q99CbVIKXsgT+QYC4ej
         9iL80L5k8XQ80eHTLfw83TqE0ZTYZ+5EqI+AFe3hXxVhl6AsHOur327omdR/B4U8PWsy
         RZEFLd6LqtcUywkoeAgVWIVmAIHOdsGJ6oQi7MeeaTsYg8dHoQ9v2XxxjTo58wUvi5C2
         jcNA==
X-Gm-Message-State: AAQBX9dJXTEvH8GAuZ4bgC0fJInqaJwZiJdGyCpx33IdnosCxBSIAPbA
        VsovZ/ru27elnwoeG+IfWOwxKB9dzudvFbZhpVfmFUYJJNcgOGn/Wc8A+haOP6VnYszpkyoZvEd
        mACJU45T/iR0rT2oHOFvH
X-Received: by 2002:ac8:5fce:0:b0:3b9:b6e3:c78e with SMTP id k14-20020ac85fce000000b003b9b6e3c78emr5645498qta.8.1680710548281;
        Wed, 05 Apr 2023 09:02:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350a9fBwBu823yNMJRRNCF/kPjd5TTa8a0sHl1G7/F6LAQ61bqbdFkGDEgXPZez2BOg5cs9V+tg==
X-Received: by 2002:ac8:5fce:0:b0:3b9:b6e3:c78e with SMTP id k14-20020ac85fce000000b003b9b6e3c78emr5645405qta.8.1680710547586;
        Wed, 05 Apr 2023 09:02:27 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id m12-20020ac8688c000000b003df7d7bbc8csm4060750qtq.75.2023.04.05.09.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:02:26 -0700 (PDT)
Date:   Wed, 5 Apr 2023 18:02:21 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dchinner@redhat.com, ebiggers@kernel.org, hch@infradead.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404163602.GC109974@frogsfrogsfrogs>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Darrick,

On Tue, Apr 04, 2023 at 09:36:02AM -0700, Darrick J. Wong wrote:
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
> 
> Ahah, ok, that's why we can't pass the xfs_buf pages up to fsverity.
> 
> > +		offset = bs * n;
> > +		name = cpu_to_be64(((index << PAGE_SHIFT) + offset));
> 
> Really this ought to be a typechecked helper...
> 
> struct xfs_fsverity_merkle_key {
> 	__be64	merkleoff;

Sure, thanks, will change this

> };
> 
> static inline void
> xfs_fsverity_merkle_key_to_disk(struct xfs_fsverity_merkle_key *k, loff_t pos)
> {
> 	k->merkeloff = cpu_to_be64(pos);
> }
> 
> 
> 
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
> 
> If there's enough memory pressure to cause the merkle tree pages to get
> evicted, what are the chances that the xfs_bufs survive the eviction?

The merkle tree pages are dropped after verification. When page is
dropped xfs_buf is marked as verified. If fs-verity wants to
verify again it will get the same verified buffer. If buffer is
evicted it won't have verified state.

So, with enough memory pressure buffers will be dropped and need to
be reverified.

> 
> > +		memcpy(page_address(page) + offset, args.value, args.valuelen);
> > +		kmem_free(args.value);
> > +		args.value = NULL;
> > +	}
> > +
> > +	if (is_checked)
> >  		SetPageChecked(page);
> > +	page->private = (unsigned long)buf_list;
> >  
> > -	page->private = (unsigned long)args.bp;
> > -	memcpy(page_address(page), args.value, args.valuelen);
> > -
> > -	kmem_free(args.value);
> >  	return page;
> >  }
> >  
> > @@ -191,16 +228,21 @@ xfs_write_merkle_tree_block(
> >  
> >  static void
> >  xfs_drop_page(
> > -	struct page	*page)
> > +	struct page			*page)
> >  {
> > -	struct xfs_buf *buf = (struct xfs_buf *)page->private;
> > +	int				i = 0;
> > +	struct xfs_verity_buf_list	*buf_list =
> > +		(struct xfs_verity_buf_list *)page->private;
> >  
> > -	ASSERT(buf != NULL);
> > +	ASSERT(buf_list != NULL);
> >  
> > -	if (PageChecked(page))
> > -		buf->b_flags |= XBF_VERITY_CHECKED;
> > +	for (i = 0; i < buf_list->buf_count; i++) {
> > +		if (PageChecked(page))
> > +			buf_list->bufs[i]->b_flags |= XBF_VERITY_CHECKED;
> > +		xfs_buf_rele(buf_list->bufs[i]);
> > +	}
> >  
> > -	xfs_buf_rele(buf);
> > +	kmem_free(buf_list);
> >  	put_page(page);
> >  }
> >  
> > diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
> > index ae5d87ca32a8..433b2f4ae3bc 100644
> > --- a/fs/xfs/xfs_verity.h
> > +++ b/fs/xfs/xfs_verity.h
> > @@ -16,4 +16,12 @@ extern const struct fsverity_operations xfs_verity_ops;
> >  #define xfs_verity_ops NULL
> >  #endif	/* CONFIG_FS_VERITY */
> >  
> > +/* Minimal Merkle tree block size is 1024 */
> > +#define XFS_VERITY_MAX_MBLOCKS_PER_PAGE (1 << (PAGE_SHIFT - 10))
> > +
> > +struct xfs_verity_buf_list {
> > +	unsigned int	buf_count;
> > +	struct xfs_buf	*bufs[XFS_VERITY_MAX_MBLOCKS_PER_PAGE];
> 
> So... this is going to be a 520-byte allocation on arm64 with 64k pages?
> Even if the merkle tree block size is the same as the page size?  Ouch.

yeah, it also allocates a page and is dropped with the page, so,
I took it as an addition to already big chunk of memory. But I
probably will change it, viz. comment from Eric on this patch.

-- 
- Andrey

