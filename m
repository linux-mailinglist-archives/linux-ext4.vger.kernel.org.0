Return-Path: <linux-ext4+bounces-1607-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D9087B0E2
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Mar 2024 20:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0144B1F23EBE
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Mar 2024 19:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD2605CC;
	Wed, 13 Mar 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wjV4GhcV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8hcOaIzC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="juFvqmo5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPCdJLh9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEA605CA
	for <linux-ext4@vger.kernel.org>; Wed, 13 Mar 2024 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353605; cv=none; b=JsKBrPxsEetL7IJSaudq0pNCHE28Ik47fP1KMMTccNvHBbwSK/pIKvVypv0djtsfUXvGUMl1LHOVWwYkRRLQnc5p6bwpgDihoYpguDvSP2WfwrLsKiZvmicFlAyBOHqb5FnyzDcnC1urX4tYjUCWLtUa8lgWek9D0O5DWtG2+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353605; c=relaxed/simple;
	bh=tjWv8OVv4VDAUvmm4Sp1QfQ2u3buI82S3iG+A+sCYEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYF4UyDYiXr0HUIXq1puws6Ze5wufr8JVhW/I52FDOsFk7z7WAJkc1FVJF28AWr1SBIKNxBs+uHibe/CLTJ+5OPSYn81YlM50l0K2YD5sKZtLEP0BQyLLJPwceTWbmhRDxaSfU5PRz5EWwqEqFTUsEWYUCAzo4vxN7kn6m6DCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wjV4GhcV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8hcOaIzC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=juFvqmo5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPCdJLh9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70F4E1F7A1;
	Wed, 13 Mar 2024 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710353600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ufZvLwcVzv82NhqhC6sQviY8/HulsWupAS5LjO+grk=;
	b=wjV4GhcVz+RynU3Wc/jeWZ7haszSAuMhljQ0MZFZFSGSxCK5RuAhf0ZDFB/77nXozbL81d
	mSVN87INrjqMcJrUhqRmPA4eHFijgQTalAlHRC1xtoO4KR+xhFOaOMjbR63oJm95xg8pS2
	y19uX4/bmjnCi6vkqAcUmbQrOVeedbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710353600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ufZvLwcVzv82NhqhC6sQviY8/HulsWupAS5LjO+grk=;
	b=8hcOaIzCmpk/oIund2IHJXE1elNgLSEuVg6Pjom7BlDwBCgPnUXFAscf1/xEfOMVvq/SLs
	iT1mGxXzGsZFd5Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710353599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ufZvLwcVzv82NhqhC6sQviY8/HulsWupAS5LjO+grk=;
	b=juFvqmo5qa4O2lxbUtDtUrOefN6CJ7Tw+JmBVJieUSekc3NBXpS3Gw3iY4Hhx9ncilnIzz
	KrC4AEgPvMu53NkRiKlgm2463+DaX8IYwSKkcWSDTn4yluLMkOlKdHHGWJOPzvKZIukbOc
	rGccS9TRN6yb2KjJDtTrShyIiQzVOHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710353599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ufZvLwcVzv82NhqhC6sQviY8/HulsWupAS5LjO+grk=;
	b=DPCdJLh9dTTozGkuPgImY1zHn9m87xnmBlolVYOG1Fv3zSUqFYw2R3zgIHOT/lSRKk3yOZ
	iLGlcEwcejhjF3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 623671397F;
	Wed, 13 Mar 2024 18:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SDD0F7/s8WWcLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Mar 2024 18:13:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E6E6CA07D9; Wed, 13 Mar 2024 19:13:18 +0100 (CET)
Date: Wed, 13 Mar 2024 19:13:18 +0100
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] ext4: set FMODE_CAN_ODIRECT instead of a dummy
 direct_IO method
Message-ID: <20240313181318.2blrwlbjth34ukps@quack3>
References: <e5797bb597219a49043e53e4e90aa494b97dc328.1709215665.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5797bb597219a49043e53e4e90aa494b97dc328.1709215665.git.ritesh.list@gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=juFvqmo5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DPCdJLh9
X-Spamd-Result: default: False [-1.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,lst.de:email];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,lst.de:email,suse.cz:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: 70F4E1F7A1
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 29-02-24 19:54:12, Ritesh Harjani (IBM) wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
> systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
> wiring up a dummy direct_IO method to indicate support for direct I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [RH: Rebased to upstream]
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Stumbled upon [1], while I was trying to enable this flag in ext4_file_open().
> Looks like it might have slipped through the cracks.
> Hence sending this patch with Christoph as the author.
> [1]: https://lore.kernel.org/linux-ext4/20230612053731.585947-1-hch@lst.de/
> 
>  fs/ext4/file.c  | 2 +-
>  fs/ext4/inode.c | 4 ----
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 54d6ff22585c..965febab1d04 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -886,7 +886,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
>  	}
>  
>  	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC |
> -			FMODE_DIO_PARALLEL_WRITE;
> +			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
>  	return dquot_file_open(inode, filp);
>  }
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2ccf3b5e3a7c..60a03b2ca178 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3530,7 +3530,6 @@ static const struct address_space_operations ext4_aops = {
>  	.bmap			= ext4_bmap,
>  	.invalidate_folio	= ext4_invalidate_folio,
>  	.release_folio		= ext4_release_folio,
> -	.direct_IO		= noop_direct_IO,
>  	.migrate_folio		= buffer_migrate_folio,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_folio	= generic_error_remove_folio,
> @@ -3547,7 +3546,6 @@ static const struct address_space_operations ext4_journalled_aops = {
>  	.bmap			= ext4_bmap,
>  	.invalidate_folio	= ext4_journalled_invalidate_folio,
>  	.release_folio		= ext4_release_folio,
> -	.direct_IO		= noop_direct_IO,
>  	.migrate_folio		= buffer_migrate_folio_norefs,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_folio	= generic_error_remove_folio,
> @@ -3564,7 +3562,6 @@ static const struct address_space_operations ext4_da_aops = {
>  	.bmap			= ext4_bmap,
>  	.invalidate_folio	= ext4_invalidate_folio,
>  	.release_folio		= ext4_release_folio,
> -	.direct_IO		= noop_direct_IO,
>  	.migrate_folio		= buffer_migrate_folio,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_folio	= generic_error_remove_folio,
> @@ -3573,7 +3570,6 @@ static const struct address_space_operations ext4_da_aops = {
>  
>  static const struct address_space_operations ext4_dax_aops = {
>  	.writepages		= ext4_dax_writepages,
> -	.direct_IO		= noop_direct_IO,
>  	.dirty_folio		= noop_dirty_folio,
>  	.bmap			= ext4_bmap,
>  	.swap_activate		= ext4_iomap_swap_activate,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

