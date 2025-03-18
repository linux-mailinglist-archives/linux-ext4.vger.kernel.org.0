Return-Path: <linux-ext4+bounces-6910-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5EBA670C0
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 11:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE9D7A7513
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA920767E;
	Tue, 18 Mar 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XxrJHIM6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X3ZsTDJy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XxrJHIM6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X3ZsTDJy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C137205E12
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292515; cv=none; b=WO/Px/8WL1CqhkhsrwfUwagjr/NLbmNfCSdFzihH0x+x4o89sx4ihoDqo+2v1JOfICW9CCV9FpDLPdZPQ/rVMoRhM5uqo4Qx9ORooIh45jERHAfUv2Fu7Qw/GKodcJIXNPlLfv0y+wEI8iZ3LteZK/us5KRLsV10dR0Yp7d2E6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292515; c=relaxed/simple;
	bh=O1LfbznHY9GACuVBpiz1Kk2JhnswxG87k5bolHDFFPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apOT2afeysNWDThGcXCXlfLZfes8CRKvf73srREx5Ba7z5Cv9FG2ATgAJzAS4dXp4gVr0iQ3Fi2vRqiokf89lPl50iGUmV/kSlU/iCIR77rciF16qJ6i06RL76S2RNGoSiAoEW+vqcBaxYrBqRoWlq/8lEkQ3aP+v6ez1TD+VZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XxrJHIM6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X3ZsTDJy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XxrJHIM6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X3ZsTDJy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6297C21BAD;
	Tue, 18 Mar 2025 10:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742292511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pw/DOlUg+0rVaqanyjGKf+geLrmj3zg8fCat/IUSzgc=;
	b=XxrJHIM6k2YTp3tBjSwM66Hky7cdsIKklajhQWuFJlO2mWOFyDgNL6ADtiKRkmAvn9hfUX
	sWmEOjUE+g6afHugb2l5sBkZwRVn0oDURY/Wi5LX5UWXm2ZUV6lf2974Q5usc5Jpk64OL+
	3jh2jBXtrqteh6McBF7O4kf3GhgLFrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742292511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pw/DOlUg+0rVaqanyjGKf+geLrmj3zg8fCat/IUSzgc=;
	b=X3ZsTDJyKcNWofIHkbJU+FaD9irXm1bNq7HI8HI9Vb9Q5Hd1jRCd/KbIxWzHlV1p2WJWJ7
	Nd02cSSE4pRKOLCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742292511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pw/DOlUg+0rVaqanyjGKf+geLrmj3zg8fCat/IUSzgc=;
	b=XxrJHIM6k2YTp3tBjSwM66Hky7cdsIKklajhQWuFJlO2mWOFyDgNL6ADtiKRkmAvn9hfUX
	sWmEOjUE+g6afHugb2l5sBkZwRVn0oDURY/Wi5LX5UWXm2ZUV6lf2974Q5usc5Jpk64OL+
	3jh2jBXtrqteh6McBF7O4kf3GhgLFrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742292511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pw/DOlUg+0rVaqanyjGKf+geLrmj3zg8fCat/IUSzgc=;
	b=X3ZsTDJyKcNWofIHkbJU+FaD9irXm1bNq7HI8HI9Vb9Q5Hd1jRCd/KbIxWzHlV1p2WJWJ7
	Nd02cSSE4pRKOLCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56F931379A;
	Tue, 18 Mar 2025 10:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pyY0FR9G2WdwMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Mar 2025 10:08:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 09299A091F; Tue, 18 Mar 2025 11:08:31 +0100 (CET)
Date: Tue, 18 Mar 2025 11:08:30 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org, 
	Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v4 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <b2tjisgqzq2tzhupbduxht33mipegk2jijzpu3ew3g6tpe2e7m@3s3fp3ywq6hj>
References: <cover.1742279837.git.ojaswin@linux.ibm.com>
 <9613c465d6ff00cd315602f99283d5f24018c3f7.1742279837.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9613c465d6ff00cd315602f99283d5f24018c3f7.1742279837.git.ojaswin@linux.ibm.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,suse.cz,huawei.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 18-03-25 13:22:56, Ojaswin Mujoo wrote:
> Presently we always BUG_ON if trying to start a transaction on a journal marked
> with JBD2_UNMOUNT, since this should never happen. However, while ltp running
> stress tests, it was observed that in case of some error handling paths, it is
> possible for update_super_work to start a transaction after the journal is
> destroyed eg:
> 
> (umount)
> ext4_kill_sb
>   kill_block_super
>     generic_shutdown_super
>       sync_filesystem /* commits all txns */
>       evict_inodes
>         /* might start a new txn */
>       ext4_put_super
> 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>         jbd2_journal_destroy
>           journal_kill_thread
>             journal->j_flags |= JBD2_UNMOUNT;
>           jbd2_journal_commit_transaction
>             jbd2_journal_get_descriptor_buffer
>               jbd2_journal_bmap
>                 ext4_journal_bmap
>                   ext4_map_blocks
>                     ...
>                     ext4_inode_error
>                       ext4_handle_error
>                         schedule_work(&sbi->s_sb_upd_work)
> 
>                                                /* work queue kicks in */
>                                                update_super_work
>                                                  jbd2_journal_start
>                                                    start_this_handle
>                                                      BUG_ON(journal->j_flags &
>                                                             JBD2_UNMOUNT)
> 
> Hence, introduce a new mount flag to indicate journal is destroying and only do
> a journaled (and deferred) update of sb if this flag is not set. Otherwise, just
> fallback to an un-journaled commit.
> 
> Further, in the journal destroy path, we have the following sequence:
> 
>   1. Set mount flag indicating journal is destroying
>   2. force a commit and wait for it
>   3. flush pending sb updates
> 
> This sequence is important as it ensures that, after this point, there is no sb
> update that might be journaled so it is safe to update the sb outside the
> journal. (To avoid race discussed in 2d01ddc86606)
> 
> Also, we don't need a similar check in ext4_grp_locked_error since it is only
> called from mballoc and AFAICT it would be always valid to schedule work here.
> 
> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/ext4.h      |  3 ++-
>  fs/ext4/ext4_jbd2.h | 15 +++++++++++++++
>  fs/ext4/super.c     | 16 ++++++++--------
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2b7d781bfcad..0685bb68e64a 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1823,7 +1823,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
>   */
>  enum {
>  	EXT4_MF_MNTDIR_SAMPLED,
> -	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
> +	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
> +	EXT4_MF_JOURNAL_DESTROY	/* Journal is in process of destroying */
>  };
>  
>  static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 9b3c9df02a39..3221714d9901 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -437,6 +437,21 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
>  {
>  	int err = 0;
>  
> +	/*
> +	 * At this point only two things can be operating on the journal.
> +	 * JBD2 thread performing transaction commit and s_sb_upd_work
> +	 * issuing sb update through the journal. Once we set
> +	 * EXT4_JOURNAL_DESTROY, new ext4_handle_error() calls will not
> +	 * queue s_sb_upd_work and ext4_force_commit() makes sure any
> +	 * ext4_handle_error() calls from the running transaction commit are
> +	 * finished. Hence no new s_sb_upd_work can be queued after we
> +	 * flush it here.
> +	 */
> +	ext4_set_mount_flag(sbi->s_sb, EXT4_MF_JOURNAL_DESTROY);
> +
> +	ext4_force_commit(sbi->s_sb);
> +	flush_work(&sbi->s_sb_upd_work);
> +
>  	err = jbd2_journal_destroy(journal);
>  	sbi->s_journal = NULL;
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8ad664d47806..46f7c9922cda 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -704,9 +704,13 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  		 * In case the fs should keep running, we need to writeout
>  		 * superblock through the journal. Due to lock ordering
>  		 * constraints, it may not be safe to do it right here so we
> -		 * defer superblock flushing to a workqueue.
> +		 * defer superblock flushing to a workqueue. We just need to be
> +		 * careful when the journal is already shutting down. If we get
> +		 * here in that case, just update the sb directly as the last
> +		 * transaction won't commit anyway.
>  		 */
> -		if (continue_fs && journal)
> +		if (continue_fs && journal &&
> +		    !ext4_test_mount_flag(sb, EXT4_MF_JOURNAL_DESTROY))
>  			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
>  		else
>  			ext4_commit_super(sb);
> @@ -1291,7 +1295,6 @@ static void ext4_put_super(struct super_block *sb)
>  	ext4_unregister_li_request(sb);
>  	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
>  
> -	flush_work(&sbi->s_sb_upd_work);
>  	destroy_workqueue(sbi->rsv_conversion_wq);
>  	ext4_release_orphan_info(sb);
>  
> @@ -1301,7 +1304,8 @@ static void ext4_put_super(struct super_block *sb)
>  		if ((err < 0) && !aborted) {
>  			ext4_abort(sb, -err, "Couldn't clean up the journal");
>  		}
> -	}
> +	} else
> +		flush_work(&sbi->s_sb_upd_work);
>  
>  	ext4_es_unregister_shrinker(sbi);
>  	timer_shutdown_sync(&sbi->s_err_report);
> @@ -4957,8 +4961,6 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>  	return 0;
>  
>  out:
> -	/* flush s_sb_upd_work before destroying the journal. */
> -	flush_work(&sbi->s_sb_upd_work);
>  	ext4_journal_destroy(sbi, sbi->s_journal);
>  	return -EINVAL;
>  }
> @@ -5648,8 +5650,6 @@ failed_mount8: __maybe_unused
>  	sbi->s_ea_block_cache = NULL;
>  
>  	if (sbi->s_journal) {
> -		/* flush s_sb_upd_work before journal destroy. */
> -		flush_work(&sbi->s_sb_upd_work);
>  		ext4_journal_destroy(sbi, sbi->s_journal);
>  	}
>  failed_mount3a:
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

