Return-Path: <linux-ext4+bounces-8903-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEB8AFEB3C
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 16:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED72188C3E9
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 14:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5DF2E9728;
	Wed,  9 Jul 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kvta3z+C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4tBlqORK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kvta3z+C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4tBlqORK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499702E92D6
	for <linux-ext4@vger.kernel.org>; Wed,  9 Jul 2025 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069560; cv=none; b=NSz2cVkTJw9jS+VMFTKk27Xc+yN7+gATbH8Li/qSRyH7VQR1SuO5vN2xBDbIe8X3GgW67mQ2J/qH8LzDTg+Pj6AHFxBxMkjGDp54iisB7in5KCvu3Wizd82GRS2gcThvcFkfC/SEIFJD7n9YDFEefdcZWZWCcatmjY6EMi7q0OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069560; c=relaxed/simple;
	bh=W44Dx8CEiJqAGNoNDQUtc/NEP3Hw1jy06vJzBk5AcI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfmFj7ooTd4NmdbxYeTTodqApehsh9AgNNYHu17yZzMezFLWARgAv6POSrOhfrSlS8UABR9ttM+dI60awgPs99rG83kYQbKekupIsGYVkHFemz2TQehwoF1g5R5qTsyMOBkBkR00LIeXkN9kWPsg0iewMyq9J04ZK6OCxueuzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kvta3z+C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4tBlqORK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kvta3z+C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4tBlqORK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 604A72117F;
	Wed,  9 Jul 2025 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752069555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMPCr6UINKuwRmQCKzwzD7Kn5z/OexCUwjNTVqkIBlo=;
	b=Kvta3z+C1eqTOTttOm8SL+69h173JX6lByKFQPdeN8k5ywThIAsO2p755FsZBqmJYIDiC7
	yxdpqzQOCpVDa0QI95l2u6KUsBueEYfGXlH14k//aWs4g/QbIxHUFZbYqyBosp9KM3wim+
	OK+7gaRsBTRCHklQumEbYWN3+4+Zm5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752069555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMPCr6UINKuwRmQCKzwzD7Kn5z/OexCUwjNTVqkIBlo=;
	b=4tBlqORKs+wv7oWchEAKjeSXcRqwvmGMvgvf7Rpwk+llfITL7lHgYuDldHRz2nJ3lYm8Tx
	Xb06hZFakHm5uYDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Kvta3z+C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4tBlqORK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752069555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMPCr6UINKuwRmQCKzwzD7Kn5z/OexCUwjNTVqkIBlo=;
	b=Kvta3z+C1eqTOTttOm8SL+69h173JX6lByKFQPdeN8k5ywThIAsO2p755FsZBqmJYIDiC7
	yxdpqzQOCpVDa0QI95l2u6KUsBueEYfGXlH14k//aWs4g/QbIxHUFZbYqyBosp9KM3wim+
	OK+7gaRsBTRCHklQumEbYWN3+4+Zm5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752069555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMPCr6UINKuwRmQCKzwzD7Kn5z/OexCUwjNTVqkIBlo=;
	b=4tBlqORKs+wv7oWchEAKjeSXcRqwvmGMvgvf7Rpwk+llfITL7lHgYuDldHRz2nJ3lYm8Tx
	Xb06hZFakHm5uYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52743136DC;
	Wed,  9 Jul 2025 13:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iFkZFLN1bmjhZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Jul 2025 13:59:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E8D0DA09C3; Wed,  9 Jul 2025 15:59:10 +0200 (CEST)
Date: Wed, 9 Jul 2025 15:59:10 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH] ext4: fix inode use after free in ext4_end_io_rsv_work()
Message-ID: <oluows6umr337xas6i6tgq37t426px22rxyujl752xounwkfr5@zxizoujhnbe6>
References: <20250708111504.3208660-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708111504.3208660-1-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 604A72117F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Tue 08-07-25 19:15:04, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_io_end_defer_completion(), check if io_end->list_vec is empty to
> avoid adding an io_end that requires no conversion to the
> i_rsv_conversion_list, which in turn prevents starting an unnecessary
> worker. An ext4_emergency_state() check is also added to avoid attempting
> to abort the journal in an emergency state.
> 
> Additionally, ext4_put_io_end_defer() is refactored to call
> ext4_io_end_defer_completion() directly instead of being open-coded.
> This also prevents starting an unnecessary worker when EXT4_IO_END_FAILED
> is set but data_err=abort is not enabled.
> 
> This ensures that the check in ext4_put_io_end_defer() is consistent with
> the check in ext4_end_bio(). Otherwise, we might add an io_end to the
> i_rsv_conversion_list and then call ext4_finish_bio(), after which the
> inode could be freed before ext4_end_io_rsv_work() is called, triggering
> a use-after-free issue.
> 
> Fixes: ce51afb8cc5e ("ext4: abort journal on data writeback failure if in data_err=abort mode")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/page-io.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 179e54f3a3b6..3d8b0f6d2dea 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -236,10 +236,12 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
>  
>  static bool ext4_io_end_defer_completion(ext4_io_end_t *io_end)
>  {
> -	if (io_end->flag & EXT4_IO_END_UNWRITTEN)
> +	if (io_end->flag & EXT4_IO_END_UNWRITTEN &&
> +	    !list_empty(&io_end->list_vec))
>  		return true;
>  	if (test_opt(io_end->inode->i_sb, DATA_ERR_ABORT) &&
> -	    io_end->flag & EXT4_IO_END_FAILED)
> +	    io_end->flag & EXT4_IO_END_FAILED &&
> +	    !ext4_emergency_state(io_end->inode->i_sb))
>  		return true;
>  	return false;
>  }
> @@ -256,6 +258,7 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
>  	WARN_ON(!(io_end->flag & EXT4_IO_END_DEFER_COMPLETION));
>  	WARN_ON(io_end->flag & EXT4_IO_END_UNWRITTEN &&
>  		!io_end->handle && sbi->s_journal);
> +	WARN_ON(!io_end->bio);
>  
>  	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
>  	wq = sbi->rsv_conversion_wq;
> @@ -318,12 +321,9 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
>  void ext4_put_io_end_defer(ext4_io_end_t *io_end)
>  {
>  	if (refcount_dec_and_test(&io_end->count)) {
> -		if (io_end->flag & EXT4_IO_END_FAILED ||
> -		    (io_end->flag & EXT4_IO_END_UNWRITTEN &&
> -		     !list_empty(&io_end->list_vec))) {
> -			ext4_add_complete_io(io_end);
> -			return;
> -		}
> +		if (ext4_io_end_defer_completion(io_end))
> +			return ext4_add_complete_io(io_end);
> +
>  		ext4_release_io_end(io_end);
>  	}
>  }
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

