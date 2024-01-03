Return-Path: <linux-ext4+bounces-649-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3DA8229EC
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 10:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64191F23EB7
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE4B182B9;
	Wed,  3 Jan 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HT1eUY/B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HCPWQEpi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IYde8UxT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Qv37F+2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E4182AA;
	Wed,  3 Jan 2024 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1527621C64;
	Wed,  3 Jan 2024 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704272815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVYGaD1iXkZpEhUzeeoLKbgqHl8xg5shjR780mg9i9Q=;
	b=HT1eUY/BbKV1q0boKUF66Wia0mQHD9gV9IdwrxYOl4uJhbOB1dRhds1MxYEDIgQgv44cZe
	/Nf4R7FCAxLMZ99brjdeke36nbEPUffY6145dCib9YrQ46ZhWkAqnPZPbPGRViyrEIhEL9
	1XIiZH9PFgg5fwRngP9qqSWeBOj3skg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704272815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVYGaD1iXkZpEhUzeeoLKbgqHl8xg5shjR780mg9i9Q=;
	b=HCPWQEpi0K3R9bxlpuZMXUZ/1hWTuOuW6DsNPngaSPq80rcNN13QSRPP3xL8In5pR8VBL+
	ekAQbkgp1hKzd/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704272814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVYGaD1iXkZpEhUzeeoLKbgqHl8xg5shjR780mg9i9Q=;
	b=IYde8UxTPRfveYbVw6Z8y+TUYm7L8yL4m6zES1kWQ1bEbZt4VpuZKyrci5NLkmKQlsuJlM
	/UpvPK6uasjhWenoyp+2upPQ+5hwG86ISIclZpZcADz3VZgr+YnS6xB+rntHtg2l/dTSJy
	sZAO01TuC1ejty3A18Z6K8VrG7PsU2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704272814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVYGaD1iXkZpEhUzeeoLKbgqHl8xg5shjR780mg9i9Q=;
	b=5Qv37F+2N8zAKzUJitU4gWQ01DHpiUg7Pnuln4QuLSM15B5wHebBWV2i/Kjxn+yzI1bEwV
	CuYNNtXlwUwzYgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0055A1340C;
	Wed,  3 Jan 2024 09:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJ8uAK4jlWVCaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jan 2024 09:06:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 60CF5A07EF; Wed,  3 Jan 2024 10:06:53 +0100 (CET)
Date: Wed, 3 Jan 2024 10:06:53 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix uninitialized ratelimit_state->lock access in
 __ext4_fill_super()
Message-ID: <20240103090653.jlpamka2et73mzlp@quack3>
References: <20240102133730.1098120-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102133730.1098120-1-libaokun1@huawei.com>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IYde8UxT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5Qv37F+2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 1527621C64
X-Spam-Flag: NO

On Tue 02-01-24 21:37:30, Baokun Li wrote:
> In the following concurrency we will access the uninitialized rs->lock:
> 
> ext4_fill_super
>   ext4_register_sysfs
>    // sysfs registered msg_ratelimit_interval_ms
>                              // Other processes modify rs->interval to
>                              // non-zero via msg_ratelimit_interval_ms
>   ext4_orphan_cleanup
>     ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
>       __ext4_msg
>         ___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state)
>           if (!rs->interval)  // do nothing if interval is 0
>             return 1;
>           raw_spin_trylock_irqsave(&rs->lock, flags)
>             raw_spin_trylock(lock)
>               _raw_spin_trylock
>                 __raw_spin_trylock
>                   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_)
>                     lock_acquire
>                       __lock_acquire
>                         register_lock_class
>                           assign_lock_key
>                             dump_stack();
>   ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
>     raw_spin_lock_init(&rs->lock);
>     // init rs->lock here
> 
> and get the following dump_stack:
> 
> =========================================================
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 12 PID: 753 Comm: mount Tainted: G E 6.7.0-rc6-next-20231222 #504
> [...]
> Call Trace:
>  dump_stack_lvl+0xc5/0x170
>  dump_stack+0x18/0x30
>  register_lock_class+0x740/0x7c0
>  __lock_acquire+0x69/0x13a0
>  lock_acquire+0x120/0x450
>  _raw_spin_trylock+0x98/0xd0
>  ___ratelimit+0xf6/0x220
>  __ext4_msg+0x7f/0x160 [ext4]
>  ext4_orphan_cleanup+0x665/0x740 [ext4]
>  __ext4_fill_super+0x21ea/0x2b10 [ext4]
>  ext4_fill_super+0x14d/0x360 [ext4]
> [...]
> =========================================================
> 
> Normally interval is 0 until s_msg_ratelimit_state is initialized, so
> ___ratelimit() does nothing. But registering sysfs precedes initializing
> rs->lock, so it is possible to change rs->interval to a non-zero value
> via the msg_ratelimit_interval_ms interface of sysfs while rs->lock is
> uninitialized, and then a call to ext4_msg triggers the problem by
> accessing an uninitialized rs->lock. Therefore register sysfs after all
> initializations are complete to avoid such problems.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0980845c8b8f..1db23b0e8a4f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5564,19 +5564,15 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	if (err)
>  		goto failed_mount6;
>  
> -	err = ext4_register_sysfs(sb);
> -	if (err)
> -		goto failed_mount7;
> -
>  	err = ext4_init_orphan_info(sb);
>  	if (err)
> -		goto failed_mount8;
> +		goto failed_mount7;
>  #ifdef CONFIG_QUOTA
>  	/* Enable quota usage during mount. */
>  	if (ext4_has_feature_quota(sb) && !sb_rdonly(sb)) {
>  		err = ext4_enable_quotas(sb);
>  		if (err)
> -			goto failed_mount9;
> +			goto failed_mount8;
>  	}
>  #endif  /* CONFIG_QUOTA */
>  
> @@ -5602,7 +5598,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		ext4_msg(sb, KERN_INFO, "recovery complete");
>  		err = ext4_mark_recovery_complete(sb, es);
>  		if (err)
> -			goto failed_mount10;
> +			goto failed_mount9;
>  	}
>  
>  	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
> @@ -5619,15 +5615,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	atomic_set(&sbi->s_warning_count, 0);
>  	atomic_set(&sbi->s_msg_count, 0);
>  
> +	/* Register sysfs after all initializations are complete. */
> +	err = ext4_register_sysfs(sb);
> +	if (err)
> +		goto failed_mount9;
> +
>  	return 0;
>  
> -failed_mount10:
> +failed_mount9:
>  	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
> -failed_mount9: __maybe_unused
> +failed_mount8: __maybe_unused
>  	ext4_release_orphan_info(sb);
> -failed_mount8:
> -	ext4_unregister_sysfs(sb);
> -	kobject_put(&sbi->s_kobj);
>  failed_mount7:
>  	ext4_unregister_li_request(sb);
>  failed_mount6:
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

