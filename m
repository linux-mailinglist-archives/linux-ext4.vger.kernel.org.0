Return-Path: <linux-ext4+bounces-5807-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F909F90DF
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 12:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE1E16A9C5
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E891C07DF;
	Fri, 20 Dec 2024 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UkzBfNbs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jRAH98gx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UkzBfNbs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jRAH98gx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F9219C56D;
	Fri, 20 Dec 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692766; cv=none; b=XM7/vLH9l1m9qrPhzxR85Ma+1y5+Srfkq5rczb4hKi4W1Si7ccOIlSs4b7p0gbZsD3SCTlxZT0RFyH4h13mNz88UrYcjDoXfZi8DRnSO/nZkINWD0nEhP2jz8UcHNg6M1wccLCrUjUrfHmIUjsg0DKZER1Mvbetr7rmKYV1aSWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692766; c=relaxed/simple;
	bh=KqHnGXrAq2sJqKTFuFOMVhEIz0VTmL5M0UkZU+HxuaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzbJk8yOW4r+MiQ7D/4iEF5sTTAyNYNVfhKBOjKuhk9tJ6cw4MCDU+y0FgGLwTYLovvan2y5uRKncanq+V+XJmAQ5X9+mjf94vstBXJ7AaM1HKAwq8E4QX/UVRsFiPscMbIHvr7TRkr2uDYQINzwJtcub7stuF/WGeM4izi913Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UkzBfNbs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jRAH98gx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UkzBfNbs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jRAH98gx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2AF7F21CE8;
	Fri, 20 Dec 2024 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734692762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bwetx2HKvjkfFd15CvYGFxhmzz83sircOhfOzrpPE5E=;
	b=UkzBfNbs+BnNMj+4hXFFAjyegukA32c+Zw0fftI+EL2casgMR9iIO7oRN42D7hyzsM5U//
	+3lS5t/9KX21sGA3TN0beyKEcAgrHqWLddKB2ROSxJo7UEoqxBn4FH0epcKFrjdONAwfDX
	1vE7n+yOo7fXi91P4i7AtXsoqRGywG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734692762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bwetx2HKvjkfFd15CvYGFxhmzz83sircOhfOzrpPE5E=;
	b=jRAH98gxxC3dLzFK69+vkwwe0tlBkA1sILaUGRo9JqNM6JY4NAwXGGHmx3SS4elB2QxbJi
	OcHcrNpSgnukmmDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UkzBfNbs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jRAH98gx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734692762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bwetx2HKvjkfFd15CvYGFxhmzz83sircOhfOzrpPE5E=;
	b=UkzBfNbs+BnNMj+4hXFFAjyegukA32c+Zw0fftI+EL2casgMR9iIO7oRN42D7hyzsM5U//
	+3lS5t/9KX21sGA3TN0beyKEcAgrHqWLddKB2ROSxJo7UEoqxBn4FH0epcKFrjdONAwfDX
	1vE7n+yOo7fXi91P4i7AtXsoqRGywG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734692762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bwetx2HKvjkfFd15CvYGFxhmzz83sircOhfOzrpPE5E=;
	b=jRAH98gxxC3dLzFK69+vkwwe0tlBkA1sILaUGRo9JqNM6JY4NAwXGGHmx3SS4elB2QxbJi
	OcHcrNpSgnukmmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19CA413A63;
	Fri, 20 Dec 2024 11:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qg9HBppPZWdrEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Dec 2024 11:06:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80265A08CF; Fri, 20 Dec 2024 12:05:46 +0100 (CET)
Date: Fri, 20 Dec 2024 12:05:46 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 4/5] ext4: remove unused member 'i_unwritten' from
 'ext4_inode_info'
Message-ID: <20241220110546.f57xhsbrw2e67ki7@quack3>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
 <20241220060757.1781418-5-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220060757.1781418-5-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 2AF7F21CE8
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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

On Fri 20-12-24 14:07:56, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> After commit 378f32bab371 ("ext4: introduce direct I/O write using iomap
> infrastructure"), no one cares about the value of i_unwritten, so there
> is no need to maintain this variable, remove it, and clean up the
> associated logic.
> 
> Suggested-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Good spotting! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  | 22 +++-------------------
>  fs/ext4/inode.c |  2 +-
>  fs/ext4/super.c |  9 +--------
>  3 files changed, 5 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9da0e32af02a..203a900fd789 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1059,7 +1059,6 @@ struct ext4_inode_info {
>  
>  	/* Number of ongoing updates on this inode */
>  	atomic_t  i_fc_updates;
> -	atomic_t i_unwritten; /* Nr. of inflight conversions pending */
>  
>  	/* Fast commit wait queue for this inode */
>  	wait_queue_head_t i_fc_wait;
> @@ -3786,34 +3785,19 @@ static inline void set_bitmap_uptodate(struct buffer_head *bh)
>  	set_bit(BH_BITMAP_UPTODATE, &(bh)->b_state);
>  }
>  
> -/* For ioend & aio unwritten conversion wait queues */
> -#define EXT4_WQ_HASH_SZ		37
> -#define ext4_ioend_wq(v)   (&ext4__ioend_wq[((unsigned long)(v)) %\
> -					    EXT4_WQ_HASH_SZ])
> -extern wait_queue_head_t ext4__ioend_wq[EXT4_WQ_HASH_SZ];
> -
>  extern int ext4_resize_begin(struct super_block *sb);
>  extern int ext4_resize_end(struct super_block *sb, bool update_backups);
>  
> -static inline void ext4_set_io_unwritten_flag(struct inode *inode,
> -					      struct ext4_io_end *io_end)
> +static inline void ext4_set_io_unwritten_flag(struct ext4_io_end *io_end)
>  {
> -	if (!(io_end->flag & EXT4_IO_END_UNWRITTEN)) {
> +	if (!(io_end->flag & EXT4_IO_END_UNWRITTEN))
>  		io_end->flag |= EXT4_IO_END_UNWRITTEN;
> -		atomic_inc(&EXT4_I(inode)->i_unwritten);
> -	}
>  }
>  
>  static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
>  {
> -	struct inode *inode = io_end->inode;
> -
> -	if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
> +	if (io_end->flag & EXT4_IO_END_UNWRITTEN)
>  		io_end->flag &= ~EXT4_IO_END_UNWRITTEN;
> -		/* Wake up anyone waiting on unwritten extent conversion */
> -		if (atomic_dec_and_test(&EXT4_I(inode)->i_unwritten))
> -			wake_up_all(ext4_ioend_wq(inode));
> -	}
>  }
>  
>  extern const struct iomap_ops ext4_iomap_ops;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7c54ae5fcbd4..36b1f9fb690a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2225,7 +2225,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
>  			handle->h_rsv_handle = NULL;
>  		}
> -		ext4_set_io_unwritten_flag(inode, mpd->io_submit.io_end);
> +		ext4_set_io_unwritten_flag(mpd->io_submit.io_end);
>  	}
>  
>  	BUG_ON(map->m_len == 0);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a50e5c31b937..853997655e40 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1426,7 +1426,6 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  	spin_lock_init(&ei->i_completed_io_lock);
>  	ei->i_sync_tid = 0;
>  	ei->i_datasync_tid = 0;
> -	atomic_set(&ei->i_unwritten, 0);
>  	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
>  	ext4_fc_init_inode(&ei->vfs_inode);
>  	mutex_init(&ei->i_fc_lock);
> @@ -7381,12 +7380,9 @@ static struct file_system_type ext4_fs_type = {
>  };
>  MODULE_ALIAS_FS("ext4");
>  
> -/* Shared across all ext4 file systems */
> -wait_queue_head_t ext4__ioend_wq[EXT4_WQ_HASH_SZ];
> -
>  static int __init ext4_init_fs(void)
>  {
> -	int i, err;
> +	int err;
>  
>  	ratelimit_state_init(&ext4_mount_msg_ratelimit, 30 * HZ, 64);
>  	ext4_li_info = NULL;
> @@ -7394,9 +7390,6 @@ static int __init ext4_init_fs(void)
>  	/* Build-time check for flags consistency */
>  	ext4_check_flag_values();
>  
> -	for (i = 0; i < EXT4_WQ_HASH_SZ; i++)
> -		init_waitqueue_head(&ext4__ioend_wq[i]);
> -
>  	err = ext4_init_es();
>  	if (err)
>  		return err;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

