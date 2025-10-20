Return-Path: <linux-ext4+bounces-10980-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C0BF02F8
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 11:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F523E0DE7
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A612F6193;
	Mon, 20 Oct 2025 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gquGZJ6U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ORqlsX3T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IWcIMYH5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ivHGj+Go"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20712F6181
	for <linux-ext4@vger.kernel.org>; Mon, 20 Oct 2025 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952704; cv=none; b=r0l1r7kUzmcR1iu+XZdJnp2lzxaec1RDMRjKrE40ycVGy1JR5xcAj6u4TVpyzJl9HNsKCyAVuk/j//MxcntlTCJpofsk1MSqS/WxHQGJDIXEIMZg7kYkVn2PVOSNQWfF2b8Rk3si0CcLTQHNU8bKOG07YjTlctNcorbUN1WCMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952704; c=relaxed/simple;
	bh=gGWF/gL3pxgqO4wmhr8C64711fMNUvptZAxxS/vc/pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVANCWZCI5kBgm2NOH5xRGwBkR02K5CbWP56zQrhlg6AojW8nfWrjWJwHC3FDo5PRo8fco5nl3pGn79UdEQNTbXXRg/Z8Q4UtttUdFGS+Fhhhh76GOJ6b8HZEVNE7YXKD6vps/HvcSQ0oQ+AX31d6E5DpNXVuUzI9TPQIz5vW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gquGZJ6U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ORqlsX3T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IWcIMYH5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ivHGj+Go; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC5171F394;
	Mon, 20 Oct 2025 09:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760952696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECppE9Mn7U6ZqSaQSwyIXm3vKaPDY0O90ZCnu98Mfio=;
	b=gquGZJ6UdkAOVWkANwVGecdpjH0r9FiaxV5c9SpmzQmU1GIEdXVaYj6bAlpM3ldmOuMncr
	STzazTy/2ZaN5yhvlW3ajTfPzXK0iuIwi1IFbmyG3rJ2iQVUvfCgtrUqe6Ro85aUFkxT4k
	ixUdu+15UwfMiNoIY/HgKQiEV6UGSbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760952696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECppE9Mn7U6ZqSaQSwyIXm3vKaPDY0O90ZCnu98Mfio=;
	b=ORqlsX3Tp62Uep+WZ5WwLkMxI20SsgH3b1bMDnCwWXepsnP2vuHvCO1WPo6tr1hsLGfaU5
	dSWvnUm3AkhTMoAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IWcIMYH5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ivHGj+Go
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760952691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECppE9Mn7U6ZqSaQSwyIXm3vKaPDY0O90ZCnu98Mfio=;
	b=IWcIMYH5CM4okWwdhU89XorBGGftbuxp9pBUB8ddpbnsS/2u1x/x8NVYOq9SVpIaOieP04
	FpR2Esbr3JPGQfvosqcMhJiAI26mdoR4rwqdTGvvhNV+3t7qu4xxMLz+pGgvgpYNgx+Mgw
	EKvF+vnA2y0UyktmP2GEJ8b1Mml6Yn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760952691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECppE9Mn7U6ZqSaQSwyIXm3vKaPDY0O90ZCnu98Mfio=;
	b=ivHGj+GodxMXaCnRFLApdTPA7rfVp178rM6REwc3qi/9h15ZPJfjjbp8wxQatIxPOlIsPd
	agGmGITBiRaHOgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD06F13AAC;
	Mon, 20 Oct 2025 09:31:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N/YwMXMB9mjoCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:31:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A6A2A0856; Mon, 20 Oct 2025 11:31:31 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:31:31 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jbd2: assign different lock_class_key for different
 filesystem
Message-ID: <fwsxrb7ugi5zeosugo6hyjdbhw36ppa5kekfi6n7we2vvi3r7m@ljrizqoagsg7>
References: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
X-Rspamd-Queue-Id: DC5171F394
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sun 19-10-25 19:52:43, Tetsuo Handa wrote:
> syzbot is reporting possibility of deadlock due to sharing lock_class_key
> for jbd2_handle across ext4 and ocfs2. But one disk partition can't have
> two filesystems at the same time, and how locks in journal_t interacts
> with other filesystem specific locks can vary depending on filesystems.
> Therefore, lockdep should treat locks in journal_t different locks if
> the filesystem which allocated the journal_t differs.
> 
> Reported-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com

Thanks for debugging this. I agree with the idea of your solution but the
implementation is just ugly. Just let the filesystem pass the lockdep key
into jbd2_journal_init_dev() / jbd2_journal_init_inode() and make ext4 and
ocfs2 functions initializing the journal each have its own lock_class_key
declared and pass it to jbd2 functions. That way changes are much simpler
and also jbd2 doesn't have to be aware about which filesystems are using
it.

								Honza
 

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 33e7c08c9529..4e206209a476 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5964,7 +5964,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
>  		return ERR_CAST(bdev_file);
>  
>  	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
> -					j_len, sb->s_blocksize);
> +					j_len, sb->s_blocksize, EXT4_SUPER_MAGIC);
>  	if (IS_ERR(journal)) {
>  		ext4_msg(sb, KERN_ERR, "failed to create device journal");
>  		errno = PTR_ERR(journal);
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..2f4fbd74cf76 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1517,11 +1517,13 @@ static int journal_load_superblock(journal_t *journal)
>   * superblock and initialize the journal_t object.
>   */
>  
> -static journal_t *journal_init_common(struct block_device *bdev,
> -			struct block_device *fs_dev,
> -			unsigned long long start, int len, int blocksize)
> +static journal_t *journal_init_common(struct block_device *bdev, struct block_device *fs_dev,
> +				      unsigned long long start, int len, int blocksize,
> +				      unsigned long fsmagic)
>  {
> -	static struct lock_class_key jbd2_trans_commit_key;
> +	static struct lock_class_key jbd2_trans_commit_key_ext4;
> +	static struct lock_class_key jbd2_trans_commit_key_ocfs2;
> +	static struct lock_class_key jbd2_trans_commit_key_unknown;
>  	journal_t *journal;
>  	int err;
>  	int n;
> @@ -1547,20 +1549,49 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	init_waitqueue_head(&journal->j_wait_updates);
>  	init_waitqueue_head(&journal->j_wait_reserved);
>  	init_waitqueue_head(&journal->j_fc_wait);
> -	mutex_init(&journal->j_abort_mutex);
> -	mutex_init(&journal->j_barrier);
> -	mutex_init(&journal->j_checkpoint_mutex);
> -	spin_lock_init(&journal->j_revoke_lock);
> -	spin_lock_init(&journal->j_list_lock);
> -	spin_lock_init(&journal->j_history_lock);
> -	rwlock_init(&journal->j_state_lock);
> +	if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_EXT4_FS) &&
> +	    fsmagic == EXT4_SUPER_MAGIC) {
> +		mutex_init(&journal->j_abort_mutex);
> +		mutex_init(&journal->j_barrier);
> +		mutex_init(&journal->j_checkpoint_mutex);
> +		spin_lock_init(&journal->j_revoke_lock);
> +		spin_lock_init(&journal->j_list_lock);
> +		spin_lock_init(&journal->j_history_lock);
> +		rwlock_init(&journal->j_state_lock);
> +	} else if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_OCFS2_FS) &&
> +		   fsmagic == OCFS2_SUPER_MAGIC) {
> +		mutex_init(&journal->j_abort_mutex);
> +		mutex_init(&journal->j_barrier);
> +		mutex_init(&journal->j_checkpoint_mutex);
> +		spin_lock_init(&journal->j_revoke_lock);
> +		spin_lock_init(&journal->j_list_lock);
> +		spin_lock_init(&journal->j_history_lock);
> +		rwlock_init(&journal->j_state_lock);
> +	} else {
> +		mutex_init(&journal->j_abort_mutex);
> +		mutex_init(&journal->j_barrier);
> +		mutex_init(&journal->j_checkpoint_mutex);
> +		spin_lock_init(&journal->j_revoke_lock);
> +		spin_lock_init(&journal->j_list_lock);
> +		spin_lock_init(&journal->j_history_lock);
> +		rwlock_init(&journal->j_state_lock);
> +	}
>  
>  	journal->j_commit_interval = (HZ * JBD2_DEFAULT_MAX_COMMIT_AGE);
>  	journal->j_min_batch_time = 0;
>  	journal->j_max_batch_time = 15000; /* 15ms */
>  	atomic_set(&journal->j_reserved_credits, 0);
> -	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
> -			 &jbd2_trans_commit_key, 0);
> +	if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_EXT4_FS) &&
> +	    fsmagic == EXT4_SUPER_MAGIC)
> +		lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_ext4",
> +				 &jbd2_trans_commit_key_ext4, 0);
> +	else if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_OCFS2_FS) &&
> +		 fsmagic == OCFS2_SUPER_MAGIC)
> +		lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_ocfs2",
> +				 &jbd2_trans_commit_key_ocfs2, 0);
> +	else
> +		lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_unknown",
> +				 &jbd2_trans_commit_key_unknown, 0);
>  
>  	/* The journal is marked for error until we succeed with recovery! */
>  	journal->j_flags = JBD2_ABORT;
> @@ -1631,6 +1662,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>   *  @start: Block nr Start of journal.
>   *  @len:  Length of the journal in blocks.
>   *  @blocksize: blocksize of journalling device
> + *  @fsmagic: filesystem magic number for lockdep annotation
>   *
>   *  Returns: a newly created journal_t *
>   *
> @@ -1638,13 +1670,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
>   *  range of blocks on an arbitrary block device.
>   *
>   */
> -journal_t *jbd2_journal_init_dev(struct block_device *bdev,
> -			struct block_device *fs_dev,
> -			unsigned long long start, int len, int blocksize)
> +journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
> +				 unsigned long long start, int len, int blocksize,
> +				 unsigned long fsmagic)
>  {
>  	journal_t *journal;
>  
> -	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
> +	journal = journal_init_common(bdev, fs_dev, start, len, blocksize, fsmagic);
>  	if (IS_ERR(journal))
>  		return ERR_CAST(journal);
>  
> @@ -1682,8 +1714,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
>  
>  	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
> -			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
> -			inode->i_sb->s_blocksize);
> +				      blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
> +				      inode->i_sb->s_blocksize, inode->i_sb->s_magic);
>  	if (IS_ERR(journal))
>  		return ERR_CAST(journal);
>  
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 43b9297fe8a7..56aa7ae4ec0b 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1523,9 +1523,9 @@ extern void	 jbd2_journal_unlock_updates (journal_t *);
>  
>  void jbd2_journal_wait_updates(journal_t *);
>  
> -extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
> -				struct block_device *fs_dev,
> -				unsigned long long start, int len, int bsize);
> +extern journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
> +					unsigned long long start, int len, int bsize,
> +					unsigned long fsmagic);
>  extern journal_t * jbd2_journal_init_inode (struct inode *);
>  extern int	   jbd2_journal_update_format (journal_t *);
>  extern int	   jbd2_journal_check_used_features
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

