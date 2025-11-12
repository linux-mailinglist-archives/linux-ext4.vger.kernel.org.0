Return-Path: <linux-ext4+bounces-11826-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16792C539C8
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 18:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765585668FF
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7ED34402D;
	Wed, 12 Nov 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvaa7OU1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IpJmCaF/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvaa7OU1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IpJmCaF/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17F3396E5
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963018; cv=none; b=mfdFqonRWvjGY9ndAN+vGYr2V3hQPh5DMjcZe5ZDQXtg9omlBS5OWsSfRmttXdTYNeeKCIOcJBk2K2rtNJRDt7Bo+2dWjiESxKZCWRTKDbYKL04mtdFUVefta903zD0IjwD+Dj7GeKMIj9BcZ0UYA/tUOtyn0mUKnGPljGueOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963018; c=relaxed/simple;
	bh=YewLhtlCBuR+qUWb4ZgFZVbrKB4EmN5db0vzQJjeaIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgIkA6SL8gd/JxWB80a8xwO1ZEGr30kSt0BEDRiIwkb0DL3+Bn+x1PNk/q2SCH0ky/XXZ95xTg2+Uh6L27fOUQx01KiGw5OBucHRW11mI/FkyBMMukS1Jj9wA6cE//DJavzueMsWQrxyROWNY2qzrN+QqyLKrreCGP2YeL1i4B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvaa7OU1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IpJmCaF/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvaa7OU1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IpJmCaF/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64F9F1F841;
	Wed, 12 Nov 2025 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762963014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MU0KYNfEXJCSQOiseOltKllEwRxMN9AqV6tFWCTlD6U=;
	b=xvaa7OU1NsiOa+ULOWk+vKgTpY7hv37flEw8E2qIndk1vzdmev8YNIIg5BAQ8pETxQw3I5
	V/nCr6xNfFW24bB6Gub0mz9ZRONdmCIrkt7N1Dx28NClXRzGeaUJf8HEW9l6Spql6fctFZ
	kVvN+BE+OQyBhmytWcD6gJrxZOxb5P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762963014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MU0KYNfEXJCSQOiseOltKllEwRxMN9AqV6tFWCTlD6U=;
	b=IpJmCaF/GuhHFKRULcsN0OfG9pmsxsFwT9a2nHwANoCptHEBou7xIz9mb2IL6q3O2SM29K
	RDLCxk/Yy7pXFOAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xvaa7OU1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="IpJmCaF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762963014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MU0KYNfEXJCSQOiseOltKllEwRxMN9AqV6tFWCTlD6U=;
	b=xvaa7OU1NsiOa+ULOWk+vKgTpY7hv37flEw8E2qIndk1vzdmev8YNIIg5BAQ8pETxQw3I5
	V/nCr6xNfFW24bB6Gub0mz9ZRONdmCIrkt7N1Dx28NClXRzGeaUJf8HEW9l6Spql6fctFZ
	kVvN+BE+OQyBhmytWcD6gJrxZOxb5P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762963014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MU0KYNfEXJCSQOiseOltKllEwRxMN9AqV6tFWCTlD6U=;
	b=IpJmCaF/GuhHFKRULcsN0OfG9pmsxsFwT9a2nHwANoCptHEBou7xIz9mb2IL6q3O2SM29K
	RDLCxk/Yy7pXFOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37B2A3EA61;
	Wed, 12 Nov 2025 15:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rhKUDUauFGloDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Nov 2025 15:56:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B00DA06F7; Wed, 12 Nov 2025 16:56:53 +0100 (CET)
Date: Wed, 12 Nov 2025 16:56:53 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v3 21/24] ext4: make data=journal support large block size
Message-ID: <o7udqn5qfsay5kt4dlewtms23je65prmvqqlc6szbxtpke2v3f@bj2fnzdplnzn>
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
 <20251111142634.3301616-22-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111142634.3301616-22-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 64F9F1F841
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:email,suse.cz:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /

On Tue 11-11-25 22:26:31, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Currently, ext4_set_inode_mapping_order() does not set max folio order
> for files with the data journalling flag. For files that already have
> large folios enabled, ext4_inode_journal_mode() ignores the data
> journalling flag once max folio order is set.
> 
> This is not because data journalling cannot work with large folios, but
> because credit estimates will go through the roof if there are too many
> blocks per folio.
> 
> Since the real constraint is blocks-per-folio, to support data=journal
> under LBS, we now set max folio order to be equal to min folio order for
> files with the journalling flag. When LBS is disabled, the max folio order
> remains unset as before.
> 
> Therefore, before ext4_change_inode_journal_flag() switches the journalling
> mode, we call truncate_pagecache() to drop all page cache for that inode,
> and filemap_write_and_wait() is called unconditionally.
> 
> After that, once the journalling mode has been switched, we can safely
> reset the inode mapping order, and the mapping_large_folio_support() check
> in ext4_inode_journal_mode() can be removed.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4_jbd2.c |  3 +--
>  fs/ext4/inode.c     | 32 ++++++++++++++++++--------------
>  2 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index a0e66bc10093..05e5946ed9b3 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -16,8 +16,7 @@ int ext4_inode_journal_mode(struct inode *inode)
>  	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
>  	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
>  	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
> -	    !test_opt(inode->i_sb, DELALLOC) &&
> -	    !mapping_large_folio_support(inode->i_mapping))) {
> +	    !test_opt(inode->i_sb, DELALLOC))) {
>  		/* We do not support data journalling for encrypted data */
>  		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
>  			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 22d215f90c64..613a989bf750 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5152,9 +5152,6 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
>  
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
> -	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> -	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> -		return false;
>  	if (ext4_has_feature_verity(sb))
>  		return false;
>  	if (ext4_has_feature_encrypt(sb))
> @@ -5172,12 +5169,20 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
>  		umin(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
>  void ext4_set_inode_mapping_order(struct inode *inode)
>  {
> +	u32 max_order;
> +
>  	if (!ext4_should_enable_large_folio(inode))
>  		return;
>  
> +	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> +	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> +		max_order = EXT4_SB(inode->i_sb)->s_min_folio_order;
> +	else
> +		max_order = EXT4_MAX_PAGECACHE_ORDER(inode);
> +
>  	mapping_set_folio_order_range(inode->i_mapping,
>  				      EXT4_SB(inode->i_sb)->s_min_folio_order,
> -				      EXT4_MAX_PAGECACHE_ORDER(inode));
> +				      max_order);
>  }
>  
>  struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> @@ -6553,14 +6558,14 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
>  	 * dirty data which can be converted only after flushing the dirty
>  	 * data (and journalled aops don't know how to handle these cases).
>  	 */
> -	if (val) {
> -		filemap_invalidate_lock(inode->i_mapping);
> -		err = filemap_write_and_wait(inode->i_mapping);
> -		if (err < 0) {
> -			filemap_invalidate_unlock(inode->i_mapping);
> -			return err;
> -		}
> +	filemap_invalidate_lock(inode->i_mapping);
> +	err = filemap_write_and_wait(inode->i_mapping);
> +	if (err < 0) {
> +		filemap_invalidate_unlock(inode->i_mapping);
> +		return err;
>  	}
> +	/* Before switch the inode journalling mode evict all the page cache. */
> +	truncate_pagecache(inode, 0);
>  
>  	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
>  	jbd2_journal_lock_updates(journal);
> @@ -6585,12 +6590,11 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
>  		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
>  	}
>  	ext4_set_aops(inode);
> +	ext4_set_inode_mapping_order(inode);
>  
>  	jbd2_journal_unlock_updates(journal);
>  	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
> -
> -	if (val)
> -		filemap_invalidate_unlock(inode->i_mapping);
> +	filemap_invalidate_unlock(inode->i_mapping);
>  
>  	/* Finally we can mark the inode as dirty. */
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

