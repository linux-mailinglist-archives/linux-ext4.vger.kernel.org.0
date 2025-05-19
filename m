Return-Path: <linux-ext4+bounces-8015-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F076ABBDC6
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CACB7AC338
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C02580D5;
	Mon, 19 May 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZr7MBTo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558241C5485
	for <linux-ext4@vger.kernel.org>; Mon, 19 May 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657842; cv=none; b=PFvIcEXsZc/BvrAl/iVWd+Xrs0ESGpCIiW3aK9APdElNR7iaDGPUnPXSPT/lp8yXslgynamcl0Ur+4JO47dZftC+xvh+/+i1Cb5RE0YSqi1btjnVvKmfguz2f9ABnocyn5veDcWKQVdATPq8v1xo3p4vu/hpKQILg8TxBgniSvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657842; c=relaxed/simple;
	bh=uwH35vZskqnFQCg782XfN3Nzayyc+Vps7Iy4QAYu7XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPSgwY1brqoD/9x9haU1rq98FHClMfbuniimOYliLeQBpDK/gZdm3uRFcBiz6XLiPknyzeQxoXRC82uPtnuEBu86mIqP3yC/rmWnMe6bT944ia26rE7BdlksMKG3ABa+YIv2CZ7JFLwRLvZ1trHT6ps9JHRVB6FGMzkzYCNvAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZr7MBTo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747657839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9WKrghLuANfXdQygrmbp9TAaeInx1YgSzFxjYIUOcyQ=;
	b=CZr7MBToArOtdfbd7TFFb/Xqs0ovUUvhK7+0OieUQAhhlhreGZrdCVbp9Fdj1duz4JeMnL
	3mqaEonoHL6SBMhqGuyVahGsfRAvFD355nz5fnn/X/Ps3JnEyZ6evBliQTo2QXH8E0Dvad
	mMO6IJWOsvDoYNJg33J55rSc0pyKh/U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-4ABGkcQ3OHS2PrRRIrlTHw-1; Mon,
 19 May 2025 08:30:35 -0400
X-MC-Unique: 4ABGkcQ3OHS2PrRRIrlTHw-1
X-Mimecast-MFC-AGG-ID: 4ABGkcQ3OHS2PrRRIrlTHw_1747657835
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D963C1956096;
	Mon, 19 May 2025 12:30:34 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.135])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 241EA195608D;
	Mon, 19 May 2025 12:30:33 +0000 (UTC)
Date: Mon, 19 May 2025 08:34:01 -0400
From: Brian Foster <bfoster@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: only dirty folios when data journaling regular
 files
Message-ID: <aCslObKt_kwVTn58@bfoster>
References: <20250516173800.175577-1-bfoster@redhat.com>
 <l2k5kbcipqjbeyw52cz2vuapgna6upxbm7cwehrnm7rdeshuon@v3yeyhe2xbha>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l2k5kbcipqjbeyw52cz2vuapgna6upxbm7cwehrnm7rdeshuon@v3yeyhe2xbha>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, May 19, 2025 at 12:24:32PM +0200, Jan Kara wrote:
> On Fri 16-05-25 13:38:00, Brian Foster wrote:
> > fstest generic/388 occasionally reproduces a crash that looks as
> > follows:
> > 
> > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > ...
> > Call Trace:
> >  <TASK>
> >  ext4_block_zero_page_range+0x30c/0x380 [ext4]
> >  ext4_truncate+0x436/0x440 [ext4]
> >  ext4_process_orphan+0x5d/0x110 [ext4]
> >  ext4_orphan_cleanup+0x124/0x4f0 [ext4]
> >  ext4_fill_super+0x262d/0x3110 [ext4]
> >  get_tree_bdev_flags+0x132/0x1d0
> >  vfs_get_tree+0x26/0xd0
> >  vfs_cmd_create+0x59/0xe0
> >  __do_sys_fsconfig+0x4ed/0x6b0
> >  do_syscall_64+0x82/0x170
> >  ...
> > 
> > This occurs when processing a symlink inode from the orphan list. The
> > partial block zeroing code in the truncate path calls
> > ext4_dirty_journalled_data() -> folio_mark_dirty(). The latter calls
> > mapping->a_ops->dirty_folio(), but symlink inodes are not assigned an
> > a_ops vector in ext4, hence the crash.
> > 
> > To avoid this problem, update the ext4_dirty_journalled_data() helper to
> > only mark the folio dirty on regular files (for which a_ops is
> > assigned). This also matches the journaling logic in the ext4_symlink()
> > creation path, where ext4_handle_dirty_metadata() is called directly.
> > 
> > Fixes: d84c9ebdac1e ("ext4: Mark pages with journalled data dirty")
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> 
> Yeah, I forgot about this subtlety when writing d84c9ebdac1e. Good catch
> and thanks for fixing this up! The fix looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > ---
> > 
> > Hi Jan,
> > 
> > I'm not intimately familiar with the jbd machinery here so this may well
> > be wrong, but it survives my testing so far. I initially hacked this to
> > mark the buffer dirty instead of the folio, but discovered jbd2 doesn't
> > seem to like that. I suspect that is because jbd2 wants to dirty/submit
> > the buffer itself after it's logged..?
> > 
> > Anyways, after that, this struck me as most consistent with behavior
> > prior to d84c9ebdac1e and/or with the creation path, so I'm floating
> > this as a first pass. Is my understanding of d84c9ebdac1e correct in
> > that it is mainly an optimization to allow writeback to force the
> > journaling mechanism vs. otherwise waiting for the other way around
> > (i.e. a journal commit to mark folios dirty)? Thoughts appreciated..
> 
> Well, the motivation for d84c9ebdac1e was not so much an optimization but
> rather to provide better visibility to the generic code what needs writing
> out. Otherwise we had to special-case data journalling in a lot of places
> that tried to do "clean the inode & purge the page cache" because simple
> filemap_write_and_wait() was not enough to get the dirty pages in the inode
> to disk.
> 

Ah, I see. Thanks for the insight (and review).

Brian

> 								Honza
> 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 94c7d2d828a6..d3c138003ad3 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -1009,7 +1009,12 @@ int ext4_walk_page_buffers(handle_t *handle, struct inode *inode,
> >   */
> >  static int ext4_dirty_journalled_data(handle_t *handle, struct buffer_head *bh)
> >  {
> > -	folio_mark_dirty(bh->b_folio);
> > +	struct folio *folio = bh->b_folio;
> > +	struct inode *inode = folio->mapping->host;
> > +
> > +	/* only regular files have a_ops */
> > +	if (S_ISREG(inode->i_mode))
> > +		folio_mark_dirty(folio);
> >  	return ext4_handle_dirty_metadata(handle, NULL, bh);
> >  }
> >  
> > -- 
> > 2.49.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 


