Return-Path: <linux-ext4+bounces-12266-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E454CB2A53
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 11:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8729301E182
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114F309DA5;
	Wed, 10 Dec 2025 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pUuXrJUc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyxMKuk9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eSOD/m9F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dMlNJiVm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C254C3090E4
	for <linux-ext4@vger.kernel.org>; Wed, 10 Dec 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361677; cv=none; b=VygilVtCIm0onfYlKEpbqsCwVmm3OhoNMXrkRfdc4OFDj6reKpFTEkzUM7XZh42kbsft6vcfOBU4LW9lH9/iuN0XvmmE25iQAzYydnxdWHzl4w4sVrQa1kDDS9PZQYuBrVEL1xqOk/z8VFay1jOJu8lgEb/na18/LvmJJcq6J3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361677; c=relaxed/simple;
	bh=DaPHLaC2xPG3YMzxq0DuSD0BGPUTFneXfo2wgLBwI9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2oZ/4AhrVvSP/hcWBaHxLnnWKZ6d9/zTMdFIwTC9df1nevwofys309A3CKhQgpDMV58o8sWuCp9Mlb4o5VkbIDhgYAxY001qcB4hYW+DOStEgZW5wIWdVEtI6Q1F+fdD4QycGkQmB6Mn6UDLUr2OdnXasQufn1ixPqNUV7+e2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pUuXrJUc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyxMKuk9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eSOD/m9F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dMlNJiVm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAA035BD21;
	Wed, 10 Dec 2025 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765361674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNOQedbVZS1BH6Aar5zYmCdUF2lgOPZ5uHIt3kMKXS4=;
	b=pUuXrJUceGCluuwh/QCltYLbOcLZujOzwPurd7OLyMQleey5u8mkD5ZAYpXc3QGtMgLEH0
	7nIcaYL3F74cymRMetdHwbQTTwSOH42cYtphdgfL4O4O+MIhv3+mXB4l7Ehm1+soIV64CP
	AtIqtGEz/P44zbF93UEDowExkXrg+MY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765361674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNOQedbVZS1BH6Aar5zYmCdUF2lgOPZ5uHIt3kMKXS4=;
	b=CyxMKuk93iFS3Q1CN3PRT3fR11cJVKLcvnpNvSzxD6S8vdjJ7pPU4X2tLE3CRKvt8ySZMx
	9SH4+o/3oBfvwZDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765361673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNOQedbVZS1BH6Aar5zYmCdUF2lgOPZ5uHIt3kMKXS4=;
	b=eSOD/m9FrVwzj39PR3E9aoURgn5Ev0/9HAcgc4RYWN1DnhSS7V4lCDtnDbCiNUs6TxLvc1
	MGar4DsrFhM/ewbJxkJv69sfoHsoD1EaOmF3weZQD+REj0zLsYC1DEksIu/IAoSOLBXHab
	DaEyLJGGswxhOZF79Iw0xH9+A0uOOL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765361673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNOQedbVZS1BH6Aar5zYmCdUF2lgOPZ5uHIt3kMKXS4=;
	b=dMlNJiVmElAm9+wEsw5FqHAY9jPa+DkhEz6mScZzvMkQKiIARDFeRfhbyUFkrE9kl2Ly7s
	5mMTufK3qFTsB2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEE463EA63;
	Wed, 10 Dec 2025 10:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iL1gNglIOWkDegAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Dec 2025 10:14:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9025DA0A61; Wed, 10 Dec 2025 11:14:33 +0100 (CET)
Date: Wed, 10 Dec 2025 11:14:33 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH] ext4: move ext4_percpu_param_init() before ext4_mb_init()
Message-ID: <odu3phjd54iv3zi7tft7ftmmn24hjgzszgd7456gh2cg2gbl4r@jgonvxf5ssfr>
References: <20251209133116.731350-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209133116.731350-1-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 09-12-25 21:31:16, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> When running `kvm-xfstests -c ext4/1k -C 1 generic/383` with the
> `DOUBLE_CHECK` macro defined, the following panic is triggered:
> 
> ==================================================================
> EXT4-fs error (device vdc): ext4_validate_block_bitmap:423:
>                         comm mount: bg 0: bad block bitmap checksum
> BUG: unable to handle page fault for address: ff110000fa2cc000
> PGD 3e01067 P4D 3e02067 PUD 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 2386 Comm: mount Tainted: G W
>                         6.18.0-gba65a4e7120a-dirty #1152 PREEMPT(none)
> RIP: 0010:percpu_counter_add_batch+0x13/0xa0
> Call Trace:
>  <TASK>
>  ext4_mark_group_bitmap_corrupted+0xcb/0xe0
>  ext4_validate_block_bitmap+0x2a1/0x2f0
>  ext4_read_block_bitmap+0x33/0x50
>  mb_group_bb_bitmap_alloc+0x33/0x80
>  ext4_mb_add_groupinfo+0x190/0x250
>  ext4_mb_init_backend+0x87/0x290
>  ext4_mb_init+0x456/0x640
>  __ext4_fill_super+0x1072/0x1680
>  ext4_fill_super+0xd3/0x280
>  get_tree_bdev_flags+0x132/0x1d0
>  vfs_get_tree+0x29/0xd0
>  vfs_cmd_create+0x59/0xe0
>  __do_sys_fsconfig+0x4f6/0x6b0
>  do_syscall_64+0x50/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ==================================================================
> 
> This issue can be reproduced using the following commands:
>         mkfs.ext4 -F -q -b 1024 /dev/sda 5G
>         tune2fs -O quota,project /dev/sda
>         mount /dev/sda /tmp/test
> 
> With DOUBLE_CHECK defined, mb_group_bb_bitmap_alloc() reads
> and validates the block bitmap. When the validation fails,
> ext4_mark_group_bitmap_corrupted() attempts to update
> sbi->s_freeclusters_counter. However, this percpu_counter has not been
> initialized yet at this point, which leads to the panic described above.
> 
> Fix this by moving the execution of ext4_percpu_param_init() to occur
> before ext4_mb_init(), ensuring the per-CPU counters are initialized
> before they are used.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 87205660c5d0..5c2e931d8a53 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5599,35 +5599,35 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	 */
>  	if (!(ctx->spec & EXT4_SPEC_mb_optimize_scan)) {
>  		if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
>  			set_opt2(sb, MB_OPTIMIZE_SCAN);
>  		else
>  			clear_opt2(sb, MB_OPTIMIZE_SCAN);
>  	}
>  
> +	err = ext4_percpu_param_init(sbi);
> +	if (err)
> +		goto failed_mount5;
> +
>  	err = ext4_mb_init(sb);
>  	if (err) {
>  		ext4_msg(sb, KERN_ERR, "failed to initialize mballoc (%d)",
>  			 err);
>  		goto failed_mount5;
>  	}
>  
>  	/*
>  	 * We can only set up the journal commit callback once
>  	 * mballoc is initialized
>  	 */
>  	if (sbi->s_journal)
>  		sbi->s_journal->j_commit_callback =
>  			ext4_journal_commit_callback;
>  
> -	err = ext4_percpu_param_init(sbi);
> -	if (err)
> -		goto failed_mount6;
> -
>  	if (ext4_has_feature_flex_bg(sb))
>  		if (!ext4_fill_flex_info(sb)) {
>  			ext4_msg(sb, KERN_ERR,
>  			       "unable to initialize "
>  			       "flex_bg meta info!");
>  			err = -ENOMEM;
>  			goto failed_mount6;
>  		}
> @@ -5699,18 +5699,18 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
>  failed_mount8: __maybe_unused
>  	ext4_release_orphan_info(sb);
>  failed_mount7:
>  	ext4_unregister_li_request(sb);
>  failed_mount6:
>  	ext4_mb_release(sb);
>  	ext4_flex_groups_free(sbi);
> -	ext4_percpu_param_destroy(sbi);
>  failed_mount5:
> +	ext4_percpu_param_destroy(sbi);
>  	ext4_ext_release(sb);
>  	ext4_release_system_zone(sb);
>  failed_mount4a:
>  	dput(sb->s_root);
>  	sb->s_root = NULL;
>  failed_mount4:
>  	ext4_msg(sb, KERN_ERR, "mount failed");
>  	if (EXT4_SB(sb)->rsv_conversion_wq)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

