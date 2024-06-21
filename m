Return-Path: <linux-ext4+bounces-2914-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2572A912B32
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4866E1C218D9
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2A115FA8E;
	Fri, 21 Jun 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W25IS6Do";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x70kDJ/i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MJD2t93f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BnFRaGAf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08810A39
	for <linux-ext4@vger.kernel.org>; Fri, 21 Jun 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986784; cv=none; b=PqJgCHl4PG8Nfkh+0TmPpPaFJfGep6pBc93QipGDRO04eccII7qKzTPfjL8tk+YH8QztLHdmqLHnFvvdUs18LSTsonoTLIpzAfFFW23U0Lqi1sCa70kMMyUAxa5K9s692UmpgtO7Wnz4rMq15MRvLzvMYABOFgPgtf2u38K4cyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986784; c=relaxed/simple;
	bh=YPrQjb1eSXsLfb3QEl+9sOiMZ3a1t0X151SEj9xnNrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/4SvKFMBwvMfcOosnaKEsDD6sKzmZu84nbFP5x+OiiJDSLTz6S19bZGHkHad880fp19pUQkYzwdbY9nzXuEKMfF9CyUbGheAONtBagwoPNoVL98yUlCT74Ja98whDJHACU/iKQ3gPNas6t5DZqQOunNQMDqhGmecexLYJk4Nj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W25IS6Do; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x70kDJ/i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MJD2t93f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BnFRaGAf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB84821AFA;
	Fri, 21 Jun 2024 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718986778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5I46ijghJTdzkJGCXxSm2kBn/5maHDTbLBHK2ObmSyM=;
	b=W25IS6Do2VDWgIhPDEIGtFv5JaajSUfFpvXOW+8sX3U/Pget0bpbj3Y+54j40DOz/z8Osl
	Q7hBQP+wav+8DKMvbtKMr/eNApf02X8eN/Px25BUPleH/R3ue21Wony4iqBv3to4ASph6w
	Btua/SVmmtH4KutbMMJDUV7GPjAsnjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718986778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5I46ijghJTdzkJGCXxSm2kBn/5maHDTbLBHK2ObmSyM=;
	b=x70kDJ/i617ZgiM+4kcCijLNBVmZEz0+XFOBOWV/GS6i6iwpyEqovkXWXOhQLTGMlRBhGR
	BmUpXdhUj9wKU+Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MJD2t93f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BnFRaGAf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718986776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5I46ijghJTdzkJGCXxSm2kBn/5maHDTbLBHK2ObmSyM=;
	b=MJD2t93fAJf6Zfl0GRxu0CLw1Om3m7TVFZ3xzTCYybhrw/Wd6OjB00aIsh6UjUUpY4c4OX
	vS23AJUnczUfIEaZpLVBPp/EIDTt785W0Lam2zmMsZb7gf4MJ23BsgGJkqwuGsmNaqso2R
	Q7EEXTUaryYE97swYClcDIJWi7nIyck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718986776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5I46ijghJTdzkJGCXxSm2kBn/5maHDTbLBHK2ObmSyM=;
	b=BnFRaGAfWRSQpJYTYIdjU8wqEqUmylEc667BMTsJOkQsPp3UwGlPBDHHJAPxr9tHXwC8Z7
	GE2TTtS2sevpmgCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C739813ABD;
	Fri, 21 Jun 2024 16:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qRSfMBiodWaBTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 21 Jun 2024 16:19:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59178A085C; Fri, 21 Jun 2024 18:19:34 +0200 (CEST)
Date: Fri, 21 Jun 2024 18:19:34 +0200
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com,
	harshads@google.com
Subject: Re: [PATCH v6 01/10] ext4: convert i_fc_lock to spinlock
Message-ID: <20240621161934.6u36oo3yhofuhlnk@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-2-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529012003.4006535-2-harshadshirwadkar@gmail.com>
X-Rspamd-Queue-Id: EB84821AFA
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 29-05-24 01:19:54, Harshad Shirwadkar wrote:
> Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
> in invalid contexts.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

> ---
>  fs/ext4/ext4.h        |  7 +++++--
>  fs/ext4/fast_commit.c | 24 +++++++++++-------------
>  fs/ext4/super.c       |  2 +-
>  3 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 983dad8c07ec..611b8c80d99c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1062,8 +1062,11 @@ struct ext4_inode_info {
>  	/* Fast commit wait queue for this inode */
>  	wait_queue_head_t i_fc_wait;
>  
> -	/* Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len */
> -	struct mutex i_fc_lock;
> +	/*
> +	 * Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len
> +	 * and inode's EXT4_FC_STATE_COMMITTING state bit.
> +	 */
> +	spinlock_t i_fc_lock;
>  
>  	/*
>  	 * i_disksize keeps track of what the inode size is ON DISK, not
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 87c009e0c59a..a1aadebfcd66 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -382,7 +382,7 @@ static int ext4_fc_track_template(
>  	int ret;
>  
>  	tid = handle->h_transaction->t_tid;
> -	mutex_lock(&ei->i_fc_lock);
> +	spin_lock(&ei->i_fc_lock);
>  	if (tid == ei->i_sync_tid) {
>  		update = true;
>  	} else {
> @@ -390,7 +390,7 @@ static int ext4_fc_track_template(
>  		ei->i_sync_tid = tid;
>  	}
>  	ret = __fc_track_fn(inode, args, update);
> -	mutex_unlock(&ei->i_fc_lock);
> +	spin_unlock(&ei->i_fc_lock);
>  
>  	if (!enqueue)
>  		return ret;
> @@ -424,19 +424,19 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>  	struct super_block *sb = inode->i_sb;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  
> -	mutex_unlock(&ei->i_fc_lock);
> +	spin_unlock(&ei->i_fc_lock);
>  
>  	if (IS_ENCRYPTED(dir)) {
>  		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_ENCRYPTED_FILENAME,
>  					NULL);
> -		mutex_lock(&ei->i_fc_lock);
> +		spin_lock(&ei->i_fc_lock);
>  		return -EOPNOTSUPP;
>  	}
>  
>  	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
>  	if (!node) {
>  		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, NULL);
> -		mutex_lock(&ei->i_fc_lock);
> +		spin_lock(&ei->i_fc_lock);
>  		return -ENOMEM;
>  	}
>  
> @@ -448,7 +448,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>  		if (!node->fcd_name.name) {
>  			kmem_cache_free(ext4_fc_dentry_cachep, node);
>  			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, NULL);
> -			mutex_lock(&ei->i_fc_lock);
> +			spin_lock(&ei->i_fc_lock);
>  			return -ENOMEM;
>  		}
>  		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
> @@ -482,7 +482,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>  		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
>  	}
>  	spin_unlock(&sbi->s_fc_lock);
> -	mutex_lock(&ei->i_fc_lock);
> +	spin_lock(&ei->i_fc_lock);
>  
>  	return 0;
>  }
> @@ -614,10 +614,8 @@ static int __track_range(struct inode *inode, void *arg, bool update)
>  	struct __track_range_args *__arg =
>  		(struct __track_range_args *)arg;
>  
> -	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb)) {
> -		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
> +	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb))
>  		return -ECANCELED;
> -	}
>  
>  	oldstart = ei->i_fc_lblk_start;
>  
> @@ -896,15 +894,15 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
>  	struct ext4_extent *ex;
>  	int ret;
>  
> -	mutex_lock(&ei->i_fc_lock);
> +	spin_lock(&ei->i_fc_lock);
>  	if (ei->i_fc_lblk_len == 0) {
> -		mutex_unlock(&ei->i_fc_lock);
> +		spin_unlock(&ei->i_fc_lock);
>  		return 0;
>  	}
>  	old_blk_size = ei->i_fc_lblk_start;
>  	new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
>  	ei->i_fc_lblk_len = 0;
> -	mutex_unlock(&ei->i_fc_lock);
> +	spin_unlock(&ei->i_fc_lock);
>  
>  	cur_lblk_off = old_blk_size;
>  	ext4_debug("will try writing %d to %d for inode %ld\n",
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index f9a4a4e89dac..77173ec91e49 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1436,7 +1436,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  	atomic_set(&ei->i_unwritten, 0);
>  	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
>  	ext4_fc_init_inode(&ei->vfs_inode);
> -	mutex_init(&ei->i_fc_lock);
> +	spin_lock_init(&ei->i_fc_lock);
>  	return &ei->vfs_inode;
>  }
>  
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

