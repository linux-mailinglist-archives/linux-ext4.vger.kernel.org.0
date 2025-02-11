Return-Path: <linux-ext4+bounces-6412-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10934A30EDA
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2025 15:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47F016189D
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2025 14:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A84D250BF9;
	Tue, 11 Feb 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NAYLE5Vx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xTkGe36D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NTx2E53h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ls00SH9c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4F20B81B;
	Tue, 11 Feb 2025 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285739; cv=none; b=qgxiN3cBpZJEBvPn0f6/vWDsw29fo5hnJbGkPKRQl/7V70QpQ1ihwvILlq+snn29TwOFZleZwMSL/zoB3HD13osBxwp6Ew6oGJ3/GDj0lvGzT/H12jqSqbmpwrFctc17l7MLJYokqOyAC5PiZy3TVy+2bG2aKwZdIN7GadH6UHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285739; c=relaxed/simple;
	bh=h/Zbu4a6hdn41uOMV8xjMtWrg8vRskudWypMzSK1qB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/q3gWq2k7w8GQgob2DICoDOOMc8n0gTyQlfSLmNQl1uLoX4Q4XPB4z9uHtVPt5J5c+Mycp7GHRXOkF1vHu7xqMMUCwTIi2UGSvP74W2P91HyHFzCFgUUD3kEbmYK+DrHTRFAEmZkgFWLF38sPJJKyKSWD5Iglb1LzKThrUfSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NAYLE5Vx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xTkGe36D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NTx2E53h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ls00SH9c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7653C2032F;
	Tue, 11 Feb 2025 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739284105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v8qG30/4kybfxJlxH8HHSqXj3/zitvI8GARaJXT9ZyI=;
	b=NAYLE5VxIc7KQ1jmJRwKzRjWjlOx3F9KZ3x5YQKqc4YTwpi5d/EHfrrHRJXBCY8tFHaKaJ
	5YTbH4r2Z5YySeLtYa+YeW3T5RX+4PO8bjgfwF3fN75UyL5EVPeMjfriJuWnrAhNyoHafP
	o+OoLScrG1o31Z2W/zZwiIZrTDgqFI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739284105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v8qG30/4kybfxJlxH8HHSqXj3/zitvI8GARaJXT9ZyI=;
	b=xTkGe36DkfX4IWl38eSPP1WT5T10bYRpyZGcanEqnEIKjeubQ72FjsyIZNH1r5s7qpUH9T
	JZ4FTdsjXAILPmAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NTx2E53h;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ls00SH9c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739284104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v8qG30/4kybfxJlxH8HHSqXj3/zitvI8GARaJXT9ZyI=;
	b=NTx2E53hIGKfv9aPrN6NcluvA+CUbwgHWG/T2JCWOxnS3y8WEJREjD9dFKOUVaROgddvC9
	YvxZlZyYWI3nAQfF7CBJuEkRv1mdkVCJNPF5dDCLTDLNudKgeddrifLBIy2EiHTjb57rtc
	SvocKpDLiU06WBMniJYawoJ5Hnu9av8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739284104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v8qG30/4kybfxJlxH8HHSqXj3/zitvI8GARaJXT9ZyI=;
	b=ls00SH9c25Mi4+tbu/CQ3T4z2gec8JKuX9VTtPQlZvfWxT+2Ae/9gKHeeO+torjWalSBn3
	LZ4XaHYXIAevVTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A09D13782;
	Tue, 11 Feb 2025 14:28:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MRorGoheq2fXTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Feb 2025 14:28:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E27A7A095C; Tue, 11 Feb 2025 15:28:19 +0100 (CET)
Date: Tue, 11 Feb 2025 15:28:19 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 4/7] ext4: add more ext4_emergency_state() checks
 around sb_rdonly()
Message-ID: <c4qihdjztjo4gn6srmuy3nl5qctxbf4vcc7j44rrtxosrfhlvj@qxivndjxqyms>
References: <20250122114130.229709-1-libaokun@huaweicloud.com>
 <20250122114130.229709-5-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122114130.229709-5-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 7653C2032F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,huawei.com:email,huaweicloud.com:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 22-01-25 19:41:27, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Some functions check sb_rdonly() to make sure the file system isn't
> modified after it's read-only. Since we also don't want the file system
> modified if it's in an emergency state (shutdown or emergency_ro),
> we're adding additional ext4_emergency_state() checks where sb_rdonly()
> is checked.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c  |  3 ++-
>  fs/ext4/ioctl.c |  2 +-
>  fs/ext4/super.c | 26 +++++++++++++++-----------
>  3 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index d0c21e6503c6..45fc6586d41b 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -844,7 +844,8 @@ static int ext4_sample_last_mounted(struct super_block *sb,
>  	if (likely(ext4_test_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED)))
>  		return 0;
>  
> -	if (sb_rdonly(sb) || !sb_start_intwrite_trylock(sb))
> +	if (ext4_emergency_state(sb) || sb_rdonly(sb) ||
> +	    !sb_start_intwrite_trylock(sb))
>  		return 0;
>  
>  	ext4_set_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 7b9ce71c1c81..0c5ce9c2cdfc 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1705,7 +1705,7 @@ int ext4_update_overhead(struct super_block *sb, bool force)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  
> -	if (sb_rdonly(sb))
> +	if (ext4_emergency_state(sb) || sb_rdonly(sb))
>  		return 0;
>  	if (!force &&
>  	    (sbi->s_overhead == 0 ||
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4b089a5b760a..d8116c9c2bd0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -473,8 +473,9 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
>  	__u64 lifetime_write_kbytes;
>  	__u64 diff_size;
>  
> -	if (sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
> -	    !journal || (journal->j_flags & JBD2_UNMOUNT))
> +	if (ext4_emergency_state(sb) || sb_rdonly(sb) ||
> +	    !(sb->s_flags & SB_ACTIVE) || !journal ||
> +	    journal->j_flags & JBD2_UNMOUNT)
>  		return;
>  
>  	now = ktime_get_real_seconds();
> @@ -765,7 +766,8 @@ static void update_super_work(struct work_struct *work)
>  	 * We use directly jbd2 functions here to avoid recursing back into
>  	 * ext4 error handling code during handling of previous errors.
>  	 */
> -	if (!sb_rdonly(sbi->s_sb) && journal) {
> +	if (!ext4_emergency_state(sbi->s_sb) &&
> +	    !sb_rdonly(sbi->s_sb) && journal) {
>  		struct buffer_head *sbh = sbi->s_sbh;
>  		bool call_notify_err = false;
>  
> @@ -1325,13 +1327,14 @@ static void ext4_put_super(struct super_block *sb)
>  	ext4_mb_release(sb);
>  	ext4_ext_release(sb);
>  
> -	if (!sb_rdonly(sb) && !aborted) {
> -		ext4_clear_feature_journal_needs_recovery(sb);
> -		ext4_clear_feature_orphan_present(sb);
> -		es->s_state = cpu_to_le16(sbi->s_mount_state);
> -	}
> -	if (!sb_rdonly(sb))
> +	if (!ext4_emergency_state(sb) && !sb_rdonly(sb)) {
> +		if (!aborted) {
> +			ext4_clear_feature_journal_needs_recovery(sb);
> +			ext4_clear_feature_orphan_present(sb);
> +			es->s_state = cpu_to_le16(sbi->s_mount_state);
> +		}
>  		ext4_commit_super(sb);
> +	}
>  
>  	ext4_group_desc_free(sbi);
>  	ext4_flex_groups_free(sbi);
> @@ -3699,7 +3702,8 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
>  		if (group >= elr->lr_next_group) {
>  			ret = 1;
>  			if (elr->lr_first_not_zeroed != ngroups &&
> -			    !sb_rdonly(sb) && test_opt(sb, INIT_INODE_TABLE)) {
> +			    !ext4_emergency_state(sb) && !sb_rdonly(sb) &&
> +			    test_opt(sb, INIT_INODE_TABLE)) {
>  				elr->lr_next_group = elr->lr_first_not_zeroed;
>  				elr->lr_mode = EXT4_LI_MODE_ITABLE;
>  				ret = 0;
> @@ -4004,7 +4008,7 @@ int ext4_register_li_request(struct super_block *sb,
>  		goto out;
>  	}
>  
> -	if (sb_rdonly(sb) ||
> +	if (ext4_emergency_state(sb) || sb_rdonly(sb) ||
>  	    (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
>  	     (first_not_zeroed == ngroups || !test_opt(sb, INIT_INODE_TABLE))))
>  		goto out;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

