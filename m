Return-Path: <linux-ext4+bounces-6541-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11008A422FE
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 15:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FF4188C58E
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2939D1386B4;
	Mon, 24 Feb 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xF/odzGl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AX2bvdGB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xF/odzGl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AX2bvdGB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800213F43A
	for <linux-ext4@vger.kernel.org>; Mon, 24 Feb 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407251; cv=none; b=PqpxqNuIvtPxWEx/qMUuLHewsdayo2onJTsopDK4nGv+tttT/HBwAgbF4zKoiFmPzrcJV1O3KktO1vGgwyQqIF1N2CrSRL8X0Z9cMgNmehtGIv7+xeMqpMIlG0eyk/GPOm+3tFM5lSvwnWf/ZpniUK0LhfLYhgDsYhhgJXJuujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407251; c=relaxed/simple;
	bh=cBiHR7/uZtf7KmSwt+mgH8sI9uam4ByqB9mtxjTEOMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxmeJS9mHDixskNO4zPBSb1ph0dcPBrpseHVWw/I68x8BdRcGZ6S8LdobahgIW8633ltN5JS5/rC/Cfa9uw4T0Cu0hd1Za31qcDJSN4jNSwgNkOX+REFFIRtI04ePMZjn7g5mzvzDN966P0VBG15sQ4ZCET5Cu7p+JObLyEJ4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xF/odzGl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AX2bvdGB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xF/odzGl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AX2bvdGB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02F0A21179;
	Mon, 24 Feb 2025 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740407248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+YEX228RJM8U97SxlrhGIsYu/R8oxHePPJweMuKpLc=;
	b=xF/odzGlo9tbP18HGk45ma07NEQ+YyqZ1p8yzeJMGZXUsF7hRJuOUF574bS4PEBTwyJHK4
	E88nzkq3iyS3FQRqyNZLYTDfylPL7qg9tSwEL8VxcJz2ImttppHpKRBAfIbKwLFm9p44Xz
	WIShGd5OTcBA23NrPDyT/alpHrNpe6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740407248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+YEX228RJM8U97SxlrhGIsYu/R8oxHePPJweMuKpLc=;
	b=AX2bvdGB4BDJwxmnTcg+dmcjVNDtd7Lux82pmY9ctNVIlQV2qBnj5W8zs098EBRS0dVVBo
	LXFXPwnQyysKhVDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740407248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+YEX228RJM8U97SxlrhGIsYu/R8oxHePPJweMuKpLc=;
	b=xF/odzGlo9tbP18HGk45ma07NEQ+YyqZ1p8yzeJMGZXUsF7hRJuOUF574bS4PEBTwyJHK4
	E88nzkq3iyS3FQRqyNZLYTDfylPL7qg9tSwEL8VxcJz2ImttppHpKRBAfIbKwLFm9p44Xz
	WIShGd5OTcBA23NrPDyT/alpHrNpe6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740407248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+YEX228RJM8U97SxlrhGIsYu/R8oxHePPJweMuKpLc=;
	b=AX2bvdGB4BDJwxmnTcg+dmcjVNDtd7Lux82pmY9ctNVIlQV2qBnj5W8zs098EBRS0dVVBo
	LXFXPwnQyysKhVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB8C613707;
	Mon, 24 Feb 2025 14:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KkB6Oc+BvGfNRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Feb 2025 14:27:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A5758A0785; Mon, 24 Feb 2025 15:27:27 +0100 (CET)
Date: Mon, 24 Feb 2025 15:27:27 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: Make sb update interval tunable
Message-ID: <rperz6ny5wjhhtmxrpnqtju64g33erxxi4rvho5gslqonzy5gb@uwbqxdjycw4y>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
 <86b177b0b0a863362f11afa3fd835c5734e14ef7.1740212945.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b177b0b0a863362f11afa3fd835c5734e14ef7.1740212945.git.ojaswin@linux.ibm.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 22-02-25 14:10:23, Ojaswin Mujoo wrote:
> Currently, outside error paths, we auto commit the super block after 1
> hour has passed and 16MB worth of updates have been written since last
> commit. This is a policy decision so make this tunable while keeping the
> defaults same. This is useful if user wants to tweak the superblock
> update behavior or for debugging the codepath by allowing to trigger it
> more frequently.
> 
> We can now tweak the super block update using sb_update_sec and
> sb_update_kb files in /sys/fs/ext4/<dev>/
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  |  9 +++++++++
>  fs/ext4/super.c | 15 ++++++++-------
>  fs/ext4/sysfs.c |  4 ++++
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2b7d781bfcad..306e5db7129c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1608,6 +1608,8 @@ struct ext4_sb_info {
>  	unsigned int s_mb_prefetch;
>  	unsigned int s_mb_prefetch_limit;
>  	unsigned int s_mb_best_avail_max_trim_order;
> +	unsigned int s_sb_update_sec;
> +	unsigned int s_sb_update_kb;
>  
>  	/* stats for buddy allocator */
>  	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
> @@ -2279,6 +2281,13 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
>  #define EXT4_DEF_MIN_BATCH_TIME	0
>  #define EXT4_DEF_MAX_BATCH_TIME	15000 /* 15ms */
>  
> +/*
> + * Default values for superblock update
> + */
> +#define EXT4_DEF_SB_UPDATE_INTERVAL_SEC (3600) /* seconds (1 hour) */
> +#define EXT4_DEF_SB_UPDATE_INTERVAL_KB (16384) /* kilobytes (16MB) */
> +
> +
>  /*
>   * Minimum number of groups in a flexgroup before we separate out
>   * directories into the first block group of a flexgroup
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b7341e9acf62..129d666f450b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -447,9 +447,6 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
>  #define ext4_get_tstamp(es, tstamp) \
>  	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
>  
> -#define EXT4_SB_REFRESH_INTERVAL_SEC (3600) /* seconds (1 hour) */
> -#define EXT4_SB_REFRESH_INTERVAL_KB (16384) /* kilobytes (16MB) */
> -
>  /*
>   * The ext4_maybe_update_superblock() function checks and updates the
>   * superblock if needed.
> @@ -457,8 +454,10 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
>   * This function is designed to update the on-disk superblock only under
>   * certain conditions to prevent excessive disk writes and unnecessary
>   * waking of the disk from sleep. The superblock will be updated if:
> - * 1. More than an hour has passed since the last superblock update, and
> - * 2. More than 16MB have been written since the last superblock update.
> + * 1. More than sbi->s_sb_update_sec (def: 1 hour) has passed since the last
> + *    superblock update
> + * 2. More than sbi->s_sb_update_kb (def: 16MB) kbs have been written since the
> + *    last superblock update.
>   *
>   * @sb: The superblock
>   */
> @@ -479,7 +478,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
>  	now = ktime_get_real_seconds();
>  	last_update = ext4_get_tstamp(es, s_wtime);
>  
> -	if (likely(now - last_update < EXT4_SB_REFRESH_INTERVAL_SEC))
> +	if (likely(now - last_update < sbi->s_sb_update_sec))
>  		return;
>  
>  	lifetime_write_kbytes = sbi->s_kbytes_written +
> @@ -494,7 +493,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
>  	 */
>  	diff_size = lifetime_write_kbytes - le64_to_cpu(es->s_kbytes_written);
>  
> -	if (diff_size > EXT4_SB_REFRESH_INTERVAL_KB)
> +	if (diff_size > sbi->s_sb_update_kb)
>  		schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
>  }
>  
> @@ -5248,6 +5247,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
>  	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
>  	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
> +	sbi->s_sb_update_kb = EXT4_DEF_SB_UPDATE_INTERVAL_KB;
> +	sbi->s_sb_update_sec = EXT4_DEF_SB_UPDATE_INTERVAL_SEC;
>  
>  	/*
>  	 * set default s_li_wait_mult for lazyinit, for the case there is
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index ddb54608ca2e..987bd00f916a 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -254,6 +254,8 @@ EXT4_ATTR(journal_task, 0444, journal_task);
>  EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
>  EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
>  EXT4_RW_ATTR_SBI_UL(last_trim_minblks, s_last_trim_minblks);
> +EXT4_RW_ATTR_SBI_UI(sb_update_sec, s_sb_update_sec);
> +EXT4_RW_ATTR_SBI_UI(sb_update_kb, s_sb_update_kb);
>  
>  static unsigned int old_bump_val = 128;
>  EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -305,6 +307,8 @@ static struct attribute *ext4_attrs[] = {
>  	ATTR_LIST(mb_prefetch),
>  	ATTR_LIST(mb_prefetch_limit),
>  	ATTR_LIST(last_trim_minblks),
> +	ATTR_LIST(sb_update_sec),
> +	ATTR_LIST(sb_update_kb),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(ext4);
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

