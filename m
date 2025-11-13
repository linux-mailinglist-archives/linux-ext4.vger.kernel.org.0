Return-Path: <linux-ext4+bounces-11856-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB4C572ED
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 12:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 711644E39B2
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF86833BBD8;
	Thu, 13 Nov 2025 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tTkNB/iL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uykkzG4v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v0zpEWp0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CDY5ES+i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738133BBCD
	for <linux-ext4@vger.kernel.org>; Thu, 13 Nov 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033284; cv=none; b=SDK6LT6ewMZibnQCr+Bn9owppsy5QSFW51atpT7jiI3DI/3H9+kMzBb1JlP2AnaC2YuBreFtNXfglD6mhNaFiL/3iEOhxbISax7PxBtTc4WfMoo3utpEsgw4XSQQz4QmMNhqDTGAXv5XJwNReyjgTvC0iqwTlRWwcSLnRxnQbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033284; c=relaxed/simple;
	bh=tNFjSh+Q+51b2FExvAGz0XzrpTRcG3fxp9OUX4D9lVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu8pwiStJ9x6QNPO1jxNYQNLCn2wlsRdEKXKzi4ZXTH6a/45yo3mcx6cAh/jqozGtl5JDvnzEAcxHAdWQtOyMOvc+gvcvKGuoos9diugxnbImo/vHzN8lKyMSUC4uZN2CHRiQe7yRCmDRTO85IngzElcdGUfywyHyxYfiOEOOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tTkNB/iL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uykkzG4v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v0zpEWp0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CDY5ES+i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8DC121275;
	Thu, 13 Nov 2025 11:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763033281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXRmss8T2+CNX/9rF/GTDsiJMzpye64aPPQY4ay9AlI=;
	b=tTkNB/iL6zyIvbSZaNsYB1hnRviqQoONEsPMHhJ6hYA804F/W3FuSuiLnp8Tsfx8eiQQGs
	GpGSYhzhmst0tX4GxJs+Xiaz4pOGPX90Tfaj1tWmvj1ZaPIKgz3+PSnGYbguTr37dFSjme
	oFP7yCLEX6015RMAYLVWtA1uAnC8tuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763033281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXRmss8T2+CNX/9rF/GTDsiJMzpye64aPPQY4ay9AlI=;
	b=uykkzG4vvRLBMdqkfPj9zn3b2gEqTyTTqsugfyWwQbpaJ4xnnfhiR7hNJQHYLhZT7K02xg
	ea6ER+YbIgNp7LBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763033280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXRmss8T2+CNX/9rF/GTDsiJMzpye64aPPQY4ay9AlI=;
	b=v0zpEWp07M72eeE3MJB/B5zS+2KYLR9JJnivKME4a3Rf2AnU/nE3STG/AKhPtW0sqkU9LZ
	kSic/u3tU7QO340FBXwogao10nDo6ZboOvzrLID5O8g4Ch65B8y5vz0+zvvLm+NFlCq0n/
	8iZJy7WMmc1NEVNbMB5m3Ktg4sZ+JEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763033280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXRmss8T2+CNX/9rF/GTDsiJMzpye64aPPQY4ay9AlI=;
	b=CDY5ES+iEPyC/VY4O8DZ/8bX5Zkg0mMzxJ101to+GY9etbkex3sra9oVmUWghE8WWo8rET
	k9bg0rhExAJCIyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD8C53EA61;
	Thu, 13 Nov 2025 11:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AcMQNsDAFWmYawAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Nov 2025 11:28:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CB086A0976; Thu, 13 Nov 2025 12:27:54 +0100 (CET)
Date: Thu, 13 Nov 2025 12:27:54 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Yang Erkun <yangerkun@huawei.com>, linux-ext4@vger.kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, libaokun1@huawei.com, 
	yangerkun@huaweicloud.com
Subject: Re: [PATCH v3 1/3] ext4: remove useless code in
 ext4_map_create_blocks
Message-ID: <mxecryxfba54eb4a5etvumjsqs4cayxbv47wufo7mso3gxlzf5@qqftillhryo6>
References: <20251107115810.47199-1-yangerkun@huawei.com>
 <72def5a4-c30a-4461-8bce-c6c2b09b044c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72def5a4-c30a-4461-8bce-c6c2b09b044c@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,huawei.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hi!

On Wed 12-11-25 12:46:26, Zhang Yi wrote:
> On 11/7/2025 7:58 PM, Yang Erkun wrote:
> > IO path with EXT4_GET_BLOCKS_PRE_IO means dio within i_size or
> > dioread_nolock buffer writeback, they all means we need a unwritten
> > extent(or this extent has already been initialized), and the split won't
> > zero the range we really write. So this check seems useless. Besides,
> > even if we repeatedly execute ext4_es_insert_extent, there won't
> > actually be any issues.
> > 
> > Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> > ---
> >  fs/ext4/inode.c | 11 -----------
> >  1 file changed, 11 deletions(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index e99306a8f47c..e8bac93ca668 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -583,7 +583,6 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
> >  static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> >  				  struct ext4_map_blocks *map, int flags)
> >  {
> > -	struct extent_status es;
> >  	unsigned int status;
> >  	int err, retval = 0;
> >  
> > @@ -644,16 +643,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> >  			return err;
> >  	}
> >  
> > -	/*
> > -	 * If the extent has been zeroed out, we don't need to update
> > -	 * extent status tree.
> > -	 */
> > -	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
> > -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> > -		if (ext4_es_is_written(&es))
> > -			return retval;
> > -	}
> > -
> 
> Sorry, I think I was wrong and I now realize that we need to keep this code
> snippet. Because ext4_split_extent() may convert the on-disk extent to written
> with the EXT4_EXT_MAY_ZEROOUT flag set. If we drop this check, it will add an
> unwritten extent into the extent status tree, which is inconsistent with the
> real one.
> 
> Although this might not seem like a practical issue now, it's a potential
> problem and conflicts with the ext4_es_cache_extent() extension I am currently
> developing[1], which triggers a mismatch alarm when caching extents.
> 
> Besides, I also notice there is a potential stale data issue about the
> EXT4_EXT_MAY_ZEROOUT flag.
> 
> Assume we have an unwritten file, and then DIO writes the second half.
> 
>    [UUUUUUUUUUUUUUUU] on-disk extent
>    [UUUUUUUUUUUUUUUU] extent status tree
>             |<----->| dio write
> 
> 1. ext4_iomap_alloc() call ext4_map_blocks() with EXT4_GET_BLOCKS_PRE_IO,
>    EXT4_GET_BLOCKS_UNWRIT_EXT and EXT4_GET_BLOCKS_CREATE flags set.
> 2. ext4_map_blocks() find this extent and call ext4_split_convert_extents()
>    with EXT4_GET_BLOCKS_CONVERT and the above flags set.
> 3. call ext4_split_extent() with EXT4_EXT_MAY_ZEROOUT, EXT4_EXT_MARK_UNWRIT2 and
>    EXT4_EXT_DATA_VALID2 flags set.
> 4. call ext4_split_extent_at() to split the second half with EXT4_EXT_DATA_VALID2,
>    EXT4_EXT_MARK_UNWRIT1, EXT4_EXT_MAY_ZEROOUT and EXT4_EXT_MARK_UNWRIT2 flags
>    set.
> 5. We failed to insert extent since -NOSPC in ext4_split_extent_at().
> 6. ext4_split_extent_at() zero out the first half but convert the entire on-disk
>    extent to written since the EXT4_EXT_DATA_VALID2 flag set, and left the second
>    half as unwritten in the extent status tree.
> 
>    [0000000000SSSSSS]  data
>    [WWWWWWWWWWWWWWWW]  on-disk extent
>    [WWWWWWWWWWUUUUUU]  extent status tree
> 
> 7. If the dio failed to write data to the disk, If DIO fails to write data, the
>    stale data in the second half will be exposed.

Right. That looks like a bug.

> Therefore, I think we should zero out the entire extent range to zero for this
> case, and also mark the extent as written in the extent status tree (that is the
> another reason I think we should keep this code snippet).

I agree this is probably the easiest fix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

