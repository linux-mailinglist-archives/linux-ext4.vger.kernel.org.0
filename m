Return-Path: <linux-ext4+bounces-5808-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E09F90E5
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 12:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFD41898483
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85721C5CBB;
	Fri, 20 Dec 2024 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qsq9wV3u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hiwDFP2s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QEHXfLMZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b1yDDYbo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42A2594A8;
	Fri, 20 Dec 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692788; cv=none; b=KronJa5zHEkTMFWnO6cDuJJcDK2uX6pl6ua3GklT0geHUF4ScEal+c+bLgSLMqt+LcNySTpbC1P3np2t1J9XWuhZMa2t+5vR2+ncKvqQPrGut6SI6HsMZfRtOaXGiLX6/2MCHNiCr960HW+cMVB0Hi0dvtZBe8X5zUWJZ47wyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692788; c=relaxed/simple;
	bh=A4s4j1445PNQ4RaXGCOymbQgJA8WxUSVVMHIJzkSMRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8tEKZ7qPJMuH6i57Ml88DY4z6rusUXbBoukM3YmNns0yRNDHF/b2YfXn2e4DFSEz2yJr08fc4oi53FzdrJh2Dii0MhwBQS5HNevrjUy8S0jQxFSCvK7Y81Y8PYvM+k2rgTLDHMpN9v1SKNy5NZCKcIDAcWNnTH8UeZXdnIhAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qsq9wV3u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hiwDFP2s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QEHXfLMZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b1yDDYbo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA9221FDA8;
	Fri, 20 Dec 2024 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734692785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVX8H9fJsFZK0ztq+cgt+4+0Q/lNh+D4C6abbWFdIM8=;
	b=Qsq9wV3uV3W6My/LFH9tSDZexNo0TEVPRspeYMyWVRkzuPS8YI3+nXRdkBt0/0UK90jnAs
	mihUAXY8EoL0dsaSRjRJTTOFEgFsevx3BYn7SK+0RBhJkqIqWw8cY7VH+MNaKLjz0mkHIJ
	8qpca6gS91rn0Nb6Uq3kBjQJaDoI28E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734692785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVX8H9fJsFZK0ztq+cgt+4+0Q/lNh+D4C6abbWFdIM8=;
	b=hiwDFP2sSuFHrPovl6ZQAZZEEqtpFW7d1KhjJCxMls+3HP5uCaRWCObNRX9Srsj2bNXtX9
	OUFb/b3XBcdhi/BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QEHXfLMZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b1yDDYbo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734692784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVX8H9fJsFZK0ztq+cgt+4+0Q/lNh+D4C6abbWFdIM8=;
	b=QEHXfLMZYiiIvCDNE898qa7b+mpaN3uvahDwKISknpscyriJDMu6tPo1z1T9zW7vszua8S
	JD9vZRHQIo4b+PE/KczZDVFiAmoKzBkCYB0fN6AebIlL8HJ7jHQufMr5uASFnsVJGQ3zqX
	ACAka7i8VnpAsiVIaMN3nGQSn/rwm0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734692784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVX8H9fJsFZK0ztq+cgt+4+0Q/lNh+D4C6abbWFdIM8=;
	b=b1yDDYboAI9esj1MrXFMYAx2YjbP3omE+ELpjpJyPVVLaVzZwZHXE0EnjWSQ7Pmrqwf515
	LtGOceALgv3AhUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDD3613A63;
	Fri, 20 Dec 2024 11:06:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tT4mNrBPZWeDEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Dec 2024 11:06:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 895D0A08CF; Fri, 20 Dec 2024 12:06:20 +0100 (CET)
Date: Fri, 20 Dec 2024 12:06:20 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 5/5] ext4: pack holes in ext4_inode_info
Message-ID: <20241220110620.keisbqz7a7tkn7zz@quack3>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
 <20241220060757.1781418-6-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220060757.1781418-6-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: EA9221FDA8
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 20-12-24 14:07:57, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> When CONFIG_DEBUG_SPINLOCK is not enabled (general case), there are four
> 4 bytes holes and one 2 bytes hole in struct ext4_inode_info. Move the
> members to pack the four 4 bytes holes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 203a900fd789..345dda2310d0 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1060,6 +1060,8 @@ struct ext4_inode_info {
>  	/* Number of ongoing updates on this inode */
>  	atomic_t  i_fc_updates;
>  
> +	spinlock_t i_raw_lock;	/* protects updates to the raw inode */
> +
>  	/* Fast commit wait queue for this inode */
>  	wait_queue_head_t i_fc_wait;
>  
> @@ -1097,8 +1099,6 @@ struct ext4_inode_info {
>  	struct inode vfs_inode;
>  	struct jbd2_inode *jinode;
>  
> -	spinlock_t i_raw_lock;	/* protects updates to the raw inode */
> -
>  	/*
>  	 * File creation time. Its function is same as that of
>  	 * struct timespec64 i_{a,c,m}time in the generic inode.
> @@ -1141,6 +1141,7 @@ struct ext4_inode_info {
>  	/* quota space reservation, managed internally by quota code */
>  	qsize_t i_reserved_quota;
>  #endif
> +	spinlock_t i_block_reservation_lock;
>  
>  	/* Lock protecting lists below */
>  	spinlock_t i_completed_io_lock;
> @@ -1151,8 +1152,6 @@ struct ext4_inode_info {
>  	struct list_head i_rsv_conversion_list;
>  	struct work_struct i_rsv_conversion_work;
>  
> -	spinlock_t i_block_reservation_lock;
> -
>  	/*
>  	 * Transactions that contain inode's metadata needed to complete
>  	 * fsync and fdatasync, respectively.
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

