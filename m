Return-Path: <linux-ext4+bounces-2334-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D38BD659
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 22:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25BE28308A
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 20:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC015B98B;
	Mon,  6 May 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UN2x9JeH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W9JuPY1B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UN2x9JeH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W9JuPY1B"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8D15B549;
	Mon,  6 May 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028028; cv=none; b=YgT10e697C9x6KHDooQIEobSZt2g9nHxT5VRFrAziklNNpzycuWJ7D8kd/gkCwIpZ5sarmwRfH5EpkX6N/SCSHAI7YDinqosYoTygrnEV5PQOqfLAcs2XkQYWpe1rc/MDMcXii4TsnhY9YeL7BeyrOMbpiSjeltU+w/5jLTxo80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028028; c=relaxed/simple;
	bh=bRrCAjz06oRrHO3hwsFHYzBBQ0U89GRMr5rX6rOxpqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ/DzkiqriZofYghp/VIm6g3rtkvkgnrVt9ndi+HlW4LUC06c0GWr9SIt0xykGhOOSVoBmprwjKr5Sswf0ADUgFeVvq499P0fvX2RGeygNcCfU4Lu7OdgMBacYwzqZvmxFbLyQK8LNwcOyYbtRVa9PjttxtlLHiy9s9iiaJWLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UN2x9JeH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W9JuPY1B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UN2x9JeH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W9JuPY1B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0668221901;
	Mon,  6 May 2024 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715028024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xZPg8EegazAFh05UDpFoYCCWIO3q0gdW8OkIjEIjWs=;
	b=UN2x9JeHQu+msfuPtXlQDHwMPlE4Z0fA2u6utIs0yiKJcSw4+ePgOXHnWTWUz7W8hwGkxr
	vdNoFVUZ3Q3gQvU6DNftgwo/mq8I7pn2uuimVaIplrtVaDNE+WVu2bClF8C01AksHHxmKH
	NFHxZ1AdEgARMqUE83yLC6gsun0nBGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715028024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xZPg8EegazAFh05UDpFoYCCWIO3q0gdW8OkIjEIjWs=;
	b=W9JuPY1BS9V6wwG3Y2jogIyPRn68vPaJIs29b8f7p9eN+bn99JbMYjf+AkwfmhOxi+tfi7
	HWZtIDmEFEqOybDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UN2x9JeH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=W9JuPY1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715028024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xZPg8EegazAFh05UDpFoYCCWIO3q0gdW8OkIjEIjWs=;
	b=UN2x9JeHQu+msfuPtXlQDHwMPlE4Z0fA2u6utIs0yiKJcSw4+ePgOXHnWTWUz7W8hwGkxr
	vdNoFVUZ3Q3gQvU6DNftgwo/mq8I7pn2uuimVaIplrtVaDNE+WVu2bClF8C01AksHHxmKH
	NFHxZ1AdEgARMqUE83yLC6gsun0nBGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715028024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xZPg8EegazAFh05UDpFoYCCWIO3q0gdW8OkIjEIjWs=;
	b=W9JuPY1BS9V6wwG3Y2jogIyPRn68vPaJIs29b8f7p9eN+bn99JbMYjf+AkwfmhOxi+tfi7
	HWZtIDmEFEqOybDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E82241386E;
	Mon,  6 May 2024 20:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 33qpODdAOWYOZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 May 2024 20:40:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 362CCA1306; Mon,  6 May 2024 22:40:23 +0200 (CEST)
Date: Mon, 6 May 2024 22:40:23 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 2/2] ext4: propagate errors from ext4_sb_bread() in
 ext4_xattr_block_cache_find()
Message-ID: <20240506204023.l74kejvjlinufuei@quack3>
References: <20240504075526.2254349-1-libaokun@huaweicloud.com>
 <20240504075526.2254349-3-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504075526.2254349-3-libaokun@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0668221901
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,huawei.com:email,huaweicloud.com:email]

On Sat 04-05-24 15:55:26, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_xattr_block_cache_find(), when ext4_sb_bread() returns an error,
> we will either continue to find the next ea block or return NULL to try to
> insert a new ea block. But whether ext4_sb_bread() returns -EIO or -ENOMEM,
> the next operation is most likely to fail with the same error. So propagate
> the error returned by ext4_sb_bread() to make ext4_xattr_block_set() fail
> to reduce pointless operations.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 9fdd13422073..11742e1f16d7 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2059,8 +2059,13 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
>  
>  inserted:
>  	if (!IS_LAST_ENTRY(s->first)) {
> -		new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
> -						     &ce);
> +		new_bh = ext4_xattr_block_cache_find(inode, header(s->base), &ce);
> +		if (IS_ERR(new_bh)) {
> +			error = PTR_ERR(new_bh);
> +			new_bh = NULL;
> +			goto cleanup;
> +		}
> +
>  		if (new_bh) {
>  			/* We found an identical block in the cache. */
>  			if (new_bh == bs->bh)
> @@ -3090,8 +3095,8 @@ ext4_xattr_cmp(struct ext4_xattr_header *header1,
>   *
>   * Find an identical extended attribute block.
>   *
> - * Returns a pointer to the block found, or NULL if such a block was
> - * not found or an error occurred.
> + * Returns a pointer to the block found, or NULL if such a block was not
> + * found, or an error pointer if an error occurred while reading ea block.
>   */
>  static struct buffer_head *
>  ext4_xattr_block_cache_find(struct inode *inode,
> @@ -3113,13 +3118,11 @@ ext4_xattr_block_cache_find(struct inode *inode,
>  
>  		bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
>  		if (IS_ERR(bh)) {
> -			if (PTR_ERR(bh) == -ENOMEM) {
> -				mb_cache_entry_put(ea_block_cache, ce);
> -				return NULL;
> -			}
> -			bh = NULL;
> -			EXT4_ERROR_INODE(inode, "block %lu read error",
> -					 (unsigned long)ce->e_value);
> +			if (PTR_ERR(bh) != -ENOMEM)
> +				EXT4_ERROR_INODE(inode, "block %lu read error",
> +						 (unsigned long)ce->e_value);
> +			mb_cache_entry_put(ea_block_cache, ce);
> +			return bh;
>  		} else if (ext4_xattr_cmp(header, BHDR(bh)) == 0) {
>  			*pce = ce;
>  			return bh;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

