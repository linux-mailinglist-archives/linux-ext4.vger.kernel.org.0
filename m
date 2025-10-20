Return-Path: <linux-ext4+bounces-10984-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C345BF15D9
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 14:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5F1C344D3B
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 12:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16B2311978;
	Mon, 20 Oct 2025 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xJ57byvK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XFnwxYjP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rUmscdYD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6S1b49oP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54C2F83DE
	for <linux-ext4@vger.kernel.org>; Mon, 20 Oct 2025 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964959; cv=none; b=scS3mZTLwPcQ+SLsJc/qFpbQucaiZQ40g/HKQutkdeK84T6l1D/xo9zdFYutCF9bMgFO8pcS+JzkTurrhuQR7xpsSrvmZ9/OUfGoCVnZL+Ov9lJFOrjri8hF8C2edWjhFJZvntKmRqpGqSVnJEsOu2Z1q9cycgjBdnt2kmRytMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964959; c=relaxed/simple;
	bh=+0rUfdlMxO9JraJg6qIsZwZHS1DTYPRo55R7j28HSII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGkPrV17IIcPE/iyzej76S2EoLIBJ3Rk3Lmn1CqzTQ/c84CDRzV+hjAwgBsjO4MY3rAbPPzntBDqfiz2UclQuowuvjDG2aZ4dAEiRH6F/efgDhshQ6eAPy3SlAfBGWDUezH6QhTAlio4fIYDXMSaXOsNou+1XMtRFAVnZvuRpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xJ57byvK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XFnwxYjP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rUmscdYD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6S1b49oP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96F551F38D;
	Mon, 20 Oct 2025 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760964950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61Kmnn66THBDMzAI4p9r7PLhGYmIPIYbgMJ3YzEIo9Q=;
	b=xJ57byvKzC5bwqhBFcff5uzN6K63ekGmDLrM9JBoBElbX2/sBTqm9o4chF2rjd8aAr8jZJ
	OTX7XJfGiXlBX2X9+0kDDOkk0bnM6oNfGfqoieeXIs4Mu4iJMaJTVO1fHUOAX1QrJyIsO4
	HSazKtqK6YXbZX92NlOvwYZJUAzEg4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760964950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61Kmnn66THBDMzAI4p9r7PLhGYmIPIYbgMJ3YzEIo9Q=;
	b=XFnwxYjPmKmF+6iw1vSMCUDEaurZSty88k2qd5VpIpi7XI56j/cVZKHuxtg3djMnI2vuiA
	2CRYwasqe5jr3kBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rUmscdYD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6S1b49oP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760964946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61Kmnn66THBDMzAI4p9r7PLhGYmIPIYbgMJ3YzEIo9Q=;
	b=rUmscdYDoQGIPQq16is1dwozSLoDO3sI9+u0uyK7oW+ZsOMHDRn3ekqmRz0P7nt4jGnPAM
	/sgyIS2Wmvq33FgjurIhWwEA2lPzBKlukwUmmr2AenJqDX0uoA4+OJJm60D4QWIBKp4rNe
	rjzGLyrifz4SovF65V5uwunjygaz//A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760964946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61Kmnn66THBDMzAI4p9r7PLhGYmIPIYbgMJ3YzEIo9Q=;
	b=6S1b49oPox8BhPHriviCMoMEMn/+g/VZidgugH6m/d5oi8qEvKmIDl0TWuxuxmymEvwkUP
	fFvLnUiu7jvotUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A6B913A8E;
	Mon, 20 Oct 2025 12:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lIbCIVIx9miWSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 12:55:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C50D9A088E; Mon, 20 Oct 2025 14:55:41 +0200 (CEST)
Date: Mon, 20 Oct 2025 14:55:41 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jbd2: assign different lock_class_key for different
 filesystem
Message-ID: <mjzb7q6juxndqtmoaee3con6xtma5vfzkgfcicjjmt7ltv2gtt@ps2np5r36vn3>
References: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
 <fwsxrb7ugi5zeosugo6hyjdbhw36ppa5kekfi6n7we2vvi3r7m@ljrizqoagsg7>
 <93744126-237b-4e36-8a62-a33e1fb52051@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93744126-237b-4e36-8a62-a33e1fb52051@I-love.SAKURA.ne.jp>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 96F551F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Mon 20-10-25 20:28:54, Tetsuo Handa wrote:
> On 2025/10/20 18:31, Jan Kara wrote:
> > On Sun 19-10-25 19:52:43, Tetsuo Handa wrote:
> >> syzbot is reporting possibility of deadlock due to sharing lock_class_key
> >> for jbd2_handle across ext4 and ocfs2. But one disk partition can't have
> >> two filesystems at the same time, and how locks in journal_t interacts
> >> with other filesystem specific locks can vary depending on filesystems.
> >> Therefore, lockdep should treat locks in journal_t different locks if
> >> the filesystem which allocated the journal_t differs.
> > 
> > Thanks for debugging this. I agree with the idea of your solution but the
> > implementation is just ugly. Just let the filesystem pass the lockdep key
> > into jbd2_journal_init_dev() / jbd2_journal_init_inode() and make ext4 and
> > ocfs2 functions initializing the journal each have its own lock_class_key
> > declared and pass it to jbd2 functions. That way changes are much simpler
> > and also jbd2 doesn't have to be aware about which filesystems are using
> > it.
> 
> Well, do you mean something like below diff? If we can assume that only ext4
> and ocfs2 are using jbd2, the diff becomes smaller...

Yes, something like this. In fact, I think we could get away with just
jbd2_trans_commit_key. There's definitely no need for j_revoke_lock,
j_list_lock, j_history_lock, j_state_lock, j_abort_mutex keys as these are
internal to jbd2. j_checkpoint_mutex and j_barrier do wrap around some
filesystem code so maybe we'll need to specify keys for them but I'd start
with just jbd2_trans_commit_key and wait whether syzbot manages to trigger
another false positive report with that.

								Honza

> 
>  fs/ext4/super.c      |    6 +++-
>  fs/jbd2/journal.c    |   68 ++++++++++++++++++++++++++++++++++++---------------
>  fs/ocfs2/journal.c   |    6 +++-
>  include/linux/jbd2.h |   15 ++++++++---
>  4 files changed, 67 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 43b9297fe8a7..184d025341da 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1287,6 +1287,13 @@ struct journal_s
>  	int (*j_bmap)(struct journal_s *journal, sector_t *block);
>  };
>  
> +struct jbd2_lock_class_keys {
> +	const char *name;
> +	struct lock_class_key jbd2_trans_commit_key, j_abort_mutex, j_barrier,
> +		j_checkpoint_mutex, j_revoke_lock, j_list_lock, j_history_lock,
> +		j_state_lock;
> +};
> +
>  #define jbd2_might_wait_for_commit(j) \
>  	do { \
>  		rwsem_acquire(&j->j_trans_commit_map, 0, 0, _THIS_IP_); \
> @@ -1523,10 +1530,10 @@ extern void	 jbd2_journal_unlock_updates (journal_t *);
>  
>  void jbd2_journal_wait_updates(journal_t *);
>  
> -extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
> -				struct block_device *fs_dev,
> -				unsigned long long start, int len, int bsize);
> -extern journal_t * jbd2_journal_init_inode (struct inode *);
> +extern journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
> +					unsigned long long start, int len, int bsize,
> +					struct jbd2_lock_class_keys *keys);
> +extern journal_t *jbd2_journal_init_inode(struct inode *inode, struct jbd2_lock_class_keys *keys);
>  extern int	   jbd2_journal_update_format (journal_t *);
>  extern int	   jbd2_journal_check_used_features
>  		   (journal_t *, unsigned long, unsigned long, unsigned long);
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..775c1cfa452a 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1506,6 +1506,34 @@ static int journal_load_superblock(journal_t *journal)
>  	return 0;
>  }
>  
> +#ifndef CONFIG_RT
> +/* This change goes to include/linux/spinlock.h */
> +#ifdef CONFIG_DEBUG_SPINLOCK
> +#define spin_lock_init_with_key(lock, key)				\
> +	__raw_spin_lock_init(spinlock_check(lock), #lock, key, LD_WAIT_CONFIG)
> +#else
> +#define spin_lock_init_with_key(lock, key) do { spin_lock_init(lock); (void)(key); } while (0)
> +#endif
> +#else
> +/* This change goes to include/linux/spinlock_rt.h */
> +#define spin_lock_init_with_key(slock, key) __spin_lock_init(slock, #slock, key, false)
> +#endif
> +
> +#ifndef CONFIG_RT
> +/* This change goes to include/linux/rwlock.h */
> +#ifdef CONFIG_DEBUG_SPINLOCK
> +#define rwlock_init_with_key(lock, key) __rwlock_init((lock), #lock, key)
> +#else
> +#define rwlock_init_with_key(lock, key) do { rwlock_init(lock); (void)(key); } while (0)
> +#endif
> +#else
> +/* This change goes to include/linux/rwlock_rt.h */
> +#define rwlock_init_with_key(rwl, key)			\
> +	do {						\
> +		init_rwbase_rt(&(rwl)->rwbase);		\
> +		__rt_rwlock_init(rwl, #rwl, key);	\
> +	} while (0)
> +#endif
>  
>  /*
>   * Management for journal control blocks: functions to create and
> @@ -1517,11 +1545,10 @@ static int journal_load_superblock(journal_t *journal)
>   * superblock and initialize the journal_t object.
>   */
>  
> -static journal_t *journal_init_common(struct block_device *bdev,
> -			struct block_device *fs_dev,
> -			unsigned long long start, int len, int blocksize)
> +static journal_t *journal_init_common(struct block_device *bdev, struct block_device *fs_dev,
> +				      unsigned long long start, int len, int blocksize,
> +				      struct jbd2_lock_class_keys *keys)
>  {
> -	static struct lock_class_key jbd2_trans_commit_key;
>  	journal_t *journal;
>  	int err;
>  	int n;
> @@ -1547,20 +1574,20 @@ static journal_t *journal_init_common(struct block_device *bdev,
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
> +	mutex_init_with_key(&journal->j_abort_mutex, &keys->j_abort_mutex);
> +	mutex_init_with_key(&journal->j_barrier, &keys->j_barrier);
> +	mutex_init_with_key(&journal->j_checkpoint_mutex, &keys->j_checkpoint_mutex);
> +	spin_lock_init_with_key(&journal->j_revoke_lock, &keys->j_revoke_lock);
> +	spin_lock_init_with_key(&journal->j_list_lock, &keys->j_list_lock);
> +	spin_lock_init_with_key(&journal->j_history_lock, &keys->j_history_lock);
> +	rwlock_init_with_key(&journal->j_state_lock, &keys->j_state_lock);
>  
>  	journal->j_commit_interval = (HZ * JBD2_DEFAULT_MAX_COMMIT_AGE);
>  	journal->j_min_batch_time = 0;
>  	journal->j_max_batch_time = 15000; /* 15ms */
>  	atomic_set(&journal->j_reserved_credits, 0);
> -	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
> -			 &jbd2_trans_commit_key, 0);
> +	lockdep_init_map(&journal->j_trans_commit_map, keys->name,
> +			 &keys->jbd2_trans_commit_key, 0);
>  
>  	/* The journal is marked for error until we succeed with recovery! */
>  	journal->j_flags = JBD2_ABORT;
> @@ -1631,6 +1658,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>   *  @start: Block nr Start of journal.
>   *  @len:  Length of the journal in blocks.
>   *  @blocksize: blocksize of journalling device
> + *  @keys: Pointer to struct jbd2_lock_class_keys for lockdep annotation
>   *
>   *  Returns: a newly created journal_t *
>   *
> @@ -1638,13 +1666,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
>   *  range of blocks on an arbitrary block device.
>   *
>   */
> -journal_t *jbd2_journal_init_dev(struct block_device *bdev,
> -			struct block_device *fs_dev,
> -			unsigned long long start, int len, int blocksize)
> +journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
> +				 unsigned long long start, int len, int blocksize,
> +				 struct jbd2_lock_class_keys *keys)
>  {
>  	journal_t *journal;
>  
> -	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
> +	journal = journal_init_common(bdev, fs_dev, start, len, blocksize, keys);
>  	if (IS_ERR(journal))
>  		return ERR_CAST(journal);
>  
> @@ -1664,7 +1692,7 @@ journal_t *jbd2_journal_init_dev(struct block_device *bdev,
>   * the journal.  The inode must exist already, must support bmap() and
>   * must have all data blocks preallocated.
>   */
> -journal_t *jbd2_journal_init_inode(struct inode *inode)
> +journal_t *jbd2_journal_init_inode(struct inode *inode, struct jbd2_lock_class_keys *keys)
>  {
>  	journal_t *journal;
>  	sector_t blocknr;
> @@ -1682,8 +1710,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
>  
>  	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
> -			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
> -			inode->i_sb->s_blocksize);
> +				      blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
> +				      inode->i_sb->s_blocksize, keys);
>  	if (IS_ERR(journal))
>  		return ERR_CAST(journal);
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 699c15db28a8..fc93a2ef5c2d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -60,6 +60,8 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/ext4.h>
>  
> +static struct jbd2_lock_class_keys jbd2_ext4_lock_class_keys = { .name = "jbd2_ext4_handle" };
> +
>  static struct ext4_lazy_init *ext4_li_info;
>  static DEFINE_MUTEX(ext4_li_mtx);
>  static struct ratelimit_state ext4_mount_msg_ratelimit;
> @@ -5851,7 +5853,7 @@ static journal_t *ext4_open_inode_journal(struct super_block *sb,
>  	if (IS_ERR(journal_inode))
>  		return ERR_CAST(journal_inode);
>  
> -	journal = jbd2_journal_init_inode(journal_inode);
> +	journal = jbd2_journal_init_inode(journal_inode, &jbd2_ext4_lock_class_keys);
>  	if (IS_ERR(journal)) {
>  		ext4_msg(sb, KERN_ERR, "Could not load journal inode");
>  		iput(journal_inode);
> @@ -5956,7 +5958,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
>  		return ERR_CAST(bdev_file);
>  
>  	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
> -					j_len, sb->s_blocksize);
> +					j_len, sb->s_blocksize, &jbd2_ext4_lock_class_keys);
>  	if (IS_ERR(journal)) {
>  		ext4_msg(sb, KERN_ERR, "failed to create device journal");
>  		errno = PTR_ERR(journal);
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index e5f58ff2175f..e92746e3cb0b 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -43,6 +43,8 @@
>  
>  DEFINE_SPINLOCK(trans_inc_lock);
>  
> +static struct jbd2_lock_class_keys jbd2_ocfs2_lock_class_keys = { .name = "jbd2_ocfs2_handle" };
> +
>  #define ORPHAN_SCAN_SCHEDULE_TIMEOUT 300000
>  
>  static int ocfs2_force_read_journal(struct inode *inode);
> @@ -968,7 +970,7 @@ int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
>  				 OCFS2_I(inode)->ip_clusters);
>  
>  	/* call the kernels journal init function now */
> -	j_journal = jbd2_journal_init_inode(inode);
> +	j_journal = jbd2_journal_init_inode(inode, &jbd2_ocfs2_lock_class_keys);
>  	if (IS_ERR(j_journal)) {
>  		mlog(ML_ERROR, "Linux journal layer error\n");
>  		status = PTR_ERR(j_journal);
> @@ -1759,7 +1761,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
>  		goto done;
>  	}
>  
> -	journal = jbd2_journal_init_inode(inode);
> +	journal = jbd2_journal_init_inode(inode, &jbd2_ocfs2_lock_class_keys);
>  	if (IS_ERR(journal)) {
>  		mlog(ML_ERROR, "Linux journal layer error\n");
>  		status = PTR_ERR(journal);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

