Return-Path: <linux-ext4+bounces-2754-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260BD8D8499
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF30F28C67F
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8057112DDB3;
	Mon,  3 Jun 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qVF/v2me";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NK0LU5nX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qVF/v2me";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NK0LU5nX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5512DD90
	for <linux-ext4@vger.kernel.org>; Mon,  3 Jun 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423630; cv=none; b=Ga3ikCkaIg8nJnvd01QNHFHsVxRklJGxqAPt7YhZ4qboEkCosr3dqL/yWS0vSHY1ph17emSRpI1TZzMD+WJdiXN24fbU9WwJG7pHA3lDOvXAJyEbEqeiY3Q1qtODwPJJi/AuIAThmk3UsZQP29ZM8I7hhk9TlMenPv5LUgoeCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423630; c=relaxed/simple;
	bh=NIArwD6GvmzTL/BocNjVnpai1A9AMFeTgIIRlLA95dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+shTaMWm6Ab2U+Gxsuy5mAZmHE0NviZY34UcBwZYdFdfYU2t+830ZweF4IFyRJ9MO4mSoKmnR3NXCeUCNjjbqVSi7dJBGzInSDRJxBr1lUUxDSY8oSpS138I7zDWpx7gSGngP3In0moLbQopvluG5t7fX06Bd5gXLkI3K1jMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qVF/v2me; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NK0LU5nX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qVF/v2me; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NK0LU5nX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2602D20039;
	Mon,  3 Jun 2024 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717423626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+yU1MwLDkmvr8/i6oQDhT+Wo9J4N/KceIKuY1aSfWI=;
	b=qVF/v2me1be1EyRghJoj601WuIrDIuyqWE/qTuDI+ak3uQdQRti89YITNQTtb12tjc7riZ
	ExKLgTfuphb9cz6fQxHrc1L7KtGToubY30XlEx/5ne4BbXVyftKhMawB2HXysBBoDMZWt/
	hgCq3Jq2Ps8DcN9gcN5DYaoxXS0FMPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717423626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+yU1MwLDkmvr8/i6oQDhT+Wo9J4N/KceIKuY1aSfWI=;
	b=NK0LU5nXZfXfda6MR89GABkwOlncXkqUIA0k6eJgOYVIRujaJQj3KKTsXZkVzlw+T/kvO5
	TXetfvV1KlPsi9Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="qVF/v2me";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NK0LU5nX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717423626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+yU1MwLDkmvr8/i6oQDhT+Wo9J4N/KceIKuY1aSfWI=;
	b=qVF/v2me1be1EyRghJoj601WuIrDIuyqWE/qTuDI+ak3uQdQRti89YITNQTtb12tjc7riZ
	ExKLgTfuphb9cz6fQxHrc1L7KtGToubY30XlEx/5ne4BbXVyftKhMawB2HXysBBoDMZWt/
	hgCq3Jq2Ps8DcN9gcN5DYaoxXS0FMPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717423626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+yU1MwLDkmvr8/i6oQDhT+Wo9J4N/KceIKuY1aSfWI=;
	b=NK0LU5nXZfXfda6MR89GABkwOlncXkqUIA0k6eJgOYVIRujaJQj3KKTsXZkVzlw+T/kvO5
	TXetfvV1KlPsi9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1930D139CB;
	Mon,  3 Jun 2024 14:07:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NaHWBQrOXWZoXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Jun 2024 14:07:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BE57AA0881; Mon,  3 Jun 2024 16:07:05 +0200 (CEST)
Date: Mon, 3 Jun 2024 16:07:05 +0200
From: Jan Kara <jack@suse.cz>
To: Junchao Sun <sunjunchao2870@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz
Subject: Re: [PATCH] ext4: Adjust the layout of the ext4_inode_info structure
 to save memory.
Message-ID: <20240603140705.vfpdrbyljw6yfxpd@quack3>
References: <20240603131524.324224-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603131524.324224-1-sunjunchao2870@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2602D20039
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Mon 03-06-24 21:15:24, Junchao Sun wrote:
> Using pahole, we can see that there are some padding holes
> in the current ext4_inode_info structure. Adjusting the
> layout of ext4_inode_info can reduce these holes,
> resulting in the size of the structure decreasing
> from 2424 bytes to 2408 bytes.

But AFAICT this will save two holes 4 bytes each so only 8 bytes in total?
Not 16?

> 
> Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 023571f8dd1b..42bcd4f749a8 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1055,6 +1055,7 @@ struct ext4_inode_info {
>  
>  	/* Number of ongoing updates on this inode */
>  	atomic_t  i_fc_updates;
> +	atomic_t i_unwritten; /* Nr. of inflight conversions pending */
>  
>  	/* Fast commit wait queue for this inode */
>  	wait_queue_head_t i_fc_wait;
> @@ -1103,6 +1104,10 @@ struct ext4_inode_info {
>  
>  	/* mballoc */
>  	atomic_t i_prealloc_active;
> +
> +	/* allocation reservation info for delalloc */
> +	/* In case of bigalloc, this refer to clusters rather than blocks */
> +	unsigned int i_reserved_data_blocks;
>  	struct rb_root i_prealloc_node;
>  	rwlock_t i_prealloc_lock;
>  
> @@ -1119,10 +1124,6 @@ struct ext4_inode_info {
>  	/* ialloc */
>  	ext4_group_t	i_last_alloc_group;
>  
> -	/* allocation reservation info for delalloc */
> -	/* In case of bigalloc, this refer to clusters rather than blocks */
> -	unsigned int i_reserved_data_blocks;
> -
>  	/* pending cluster reservations for bigalloc file systems */
>  	struct ext4_pending_tree i_pending_tree;
>  
> @@ -1146,7 +1147,6 @@ struct ext4_inode_info {
>  	 */
>  	struct list_head i_rsv_conversion_list;
>  	struct work_struct i_rsv_conversion_work;
> -	atomic_t i_unwritten; /* Nr. of inflight conversions pending */
>  
>  	spinlock_t i_block_reservation_lock;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

