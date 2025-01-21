Return-Path: <linux-ext4+bounces-6179-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BDDA17E90
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 14:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667D83A28F5
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2821F2398;
	Tue, 21 Jan 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qx/J1Y2g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHPOIKQV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qx/J1Y2g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHPOIKQV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A71F191E;
	Tue, 21 Jan 2025 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465090; cv=none; b=ObS1NCEG57BlQQz/ML/ba7rzYxIbzTuIHRZrCJfyWUeQNbINFV+swAwWyoiv37PoW5ocs1yZekF+nsuUHY7zLPkTjXRH0t3+Ue077wMbzzb4sQs7LYTZOFceQIAhw6B1D0/IBn9hVHcS0XSYlKrpA9MNLGBa3khN/F9YEmsyqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465090; c=relaxed/simple;
	bh=/GVc8sZBX57QTKXZaRlEBLket19U3UC5f+xFdiR1KS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT+6K/A2PIvgmWs6lZFQ+ImvDvBjYnrxBLRLEwlc7N1MfGwFywvSaLCqFaDKwYOn/3t7K1X75/cNeuql0ghJ5Tddfh9Hr8m1xTYGyWL8YBiwCYvcJpgAWT4kheJByYuBvyv2QAXuABfGZxB3asBjLZPihGtNFVwikvDqpIBIykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qx/J1Y2g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YHPOIKQV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qx/J1Y2g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YHPOIKQV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B6F44211CA;
	Tue, 21 Jan 2025 13:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737465086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqq9epxBFw/+5LQC3BZpJycBZYdV54MwrkkXVWFmkNw=;
	b=qx/J1Y2gu3TiBC5G0TkY9WT0MPQ6IBZde4QZlADcJXJo0u1PsAC0QwcfftntD5Cwkc4SSH
	VNy0irIdYRsO6INY0lLnKegt/CwkacIMXT4rQ0SS29Hp4T1Fkg4cgZq1iP115It5LiYIFw
	KDii5wRT3eE+6WVI/nyg/A7dzIAbpTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737465086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqq9epxBFw/+5LQC3BZpJycBZYdV54MwrkkXVWFmkNw=;
	b=YHPOIKQVnaWoIHEMLMfpUThy6PhL+3cBZgyw7aR0X8o4RDEosUvUq+VMsCJ4j8ffUp5YqC
	s2HJAHp1MTQzFKCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737465086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqq9epxBFw/+5LQC3BZpJycBZYdV54MwrkkXVWFmkNw=;
	b=qx/J1Y2gu3TiBC5G0TkY9WT0MPQ6IBZde4QZlADcJXJo0u1PsAC0QwcfftntD5Cwkc4SSH
	VNy0irIdYRsO6INY0lLnKegt/CwkacIMXT4rQ0SS29Hp4T1Fkg4cgZq1iP115It5LiYIFw
	KDii5wRT3eE+6WVI/nyg/A7dzIAbpTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737465086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqq9epxBFw/+5LQC3BZpJycBZYdV54MwrkkXVWFmkNw=;
	b=YHPOIKQVnaWoIHEMLMfpUThy6PhL+3cBZgyw7aR0X8o4RDEosUvUq+VMsCJ4j8ffUp5YqC
	s2HJAHp1MTQzFKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E4831387C;
	Tue, 21 Jan 2025 13:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id diCeJv6cj2eFCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 13:11:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 10420A0889; Tue, 21 Jan 2025 14:11:26 +0100 (CET)
Date: Tue, 21 Jan 2025 14:11:26 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 4/7] ext4: add ext4_sb_rdonly() helper function
Message-ID: <lnxxxz7xxwhtcywd2yaudkypffubonvl3zu5ehahzznqj5woov@fn6w6asmsw4q>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
 <20250117082315.2869996-5-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117082315.2869996-5-libaokun@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 17-01-25 16:23:12, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Because both SB_RDONLY and EXT4_FLAGS_EMERGENCY_RO indicate the file system
> is read-only, the ext4_sb_rdonly() helper function is added. This function
> returns true if either flag is set, signifying that the file system is
> read-only.
> 
> Then replace some sb_rdonly() with ext4_sb_rdonly() to avoid unexpected
> failures of some read-only operations or modification of the superblock
> after setting EXT4_FLAGS_EMERGENCY_RO.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I'm not sure we really need this. I rather think more places need
additional ext4_emergency_state() checks. Look:

> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 6db052a87b9b..70b556c87b88 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -844,7 +844,7 @@ static int ext4_sample_last_mounted(struct super_block *sb,
>  	if (likely(ext4_test_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED)))
>  		return 0;
>  
> -	if (sb_rdonly(sb) || !sb_start_intwrite_trylock(sb))
> +	if (ext4_sb_rdonly(sb) || !sb_start_intwrite_trylock(sb))

We don't want to be modifying superblock if the filesystem is shutdown so I
think we should have here something like:

	if (ext4_emergency_state(sb) || sb_rdonly(sb) ||
	    !sb_start_intwrite_trylock(sb))

>  		return 0;
>  
>  	ext4_set_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 7b9ce71c1c81..0807ee8cbcdc 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1705,7 +1705,7 @@ int ext4_update_overhead(struct super_block *sb, bool force)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  
> -	if (sb_rdonly(sb))
> +	if (ext4_sb_rdonly(sb))
>  		return 0;

Similarly here I think we should have:

	if (ext4_emergency_state(sb) || sb_rdonly(sb))
		return 0;

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c12133628ee9..fc5d30123f22 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -473,7 +473,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
>  	__u64 lifetime_write_kbytes;
>  	__u64 diff_size;
>  
> -	if (sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
> +	if (ext4_sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
>  	    !journal || (journal->j_flags & JBD2_UNMOUNT))
>  		return;

And here we should add ext4_emergency_state() check as well.

> @@ -707,7 +707,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  	if (test_opt(sb, WARN_ON_ERROR))
>  		WARN_ON_ONCE(1);
>  
> -	if (!continue_fs && !sb_rdonly(sb)) {
> +	if (!continue_fs && !ext4_sb_rdonly(sb)) {

Here I actually think we should just drop the sb_rdonly() check completely?
Because callers have already checked we are not in emergency state yet and
we want to shutdown the fs (or later flag the emergency RO state) even if
the filesystem is mounted read only?

>  		set_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
>  		if (journal)
>  			jbd2_journal_abort(journal, -EIO);
> @@ -737,7 +737,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  			sb->s_id);
>  	}
>  
> -	if (sb_rdonly(sb) || continue_fs)
> +	if (ext4_sb_rdonly(sb) || continue_fs)
>  		return;

This will need a bit of reworking with the emergency ro flag anyway so for
now I'd leave it as is.

>  
>  	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> @@ -765,7 +765,7 @@ static void update_super_work(struct work_struct *work)
>  	 * We use directly jbd2 functions here to avoid recursing back into
>  	 * ext4 error handling code during handling of previous errors.
>  	 */
> -	if (!sb_rdonly(sbi->s_sb) && journal) {
> +	if (!ext4_sb_rdonly(sbi->s_sb) && journal) {
>  		struct buffer_head *sbh = sbi->s_sbh;
>  		bool call_notify_err = false;

Again here I think we should just add ext4_emergency_state() check because
we don't want to be modifying superblock on shutdown filesystem either. And
in the four cases below as well.

> @@ -1325,12 +1325,12 @@ static void ext4_put_super(struct super_block *sb)
>  	ext4_mb_release(sb);
>  	ext4_ext_release(sb);
>  
> -	if (!sb_rdonly(sb) && !aborted) {
> +	if (!ext4_sb_rdonly(sb) && !aborted) {
>  		ext4_clear_feature_journal_needs_recovery(sb);
>  		ext4_clear_feature_orphan_present(sb);
>  		es->s_state = cpu_to_le16(sbi->s_mount_state);
>  	}
> -	if (!sb_rdonly(sb))
> +	if (!ext4_sb_rdonly(sb))
>  		ext4_commit_super(sb);
>  
>  	ext4_group_desc_free(sbi);
> @@ -3693,7 +3693,8 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
>  		if (group >= elr->lr_next_group) {
>  			ret = 1;
>  			if (elr->lr_first_not_zeroed != ngroups &&
> -			    !sb_rdonly(sb) && test_opt(sb, INIT_INODE_TABLE)) {
> +			    !ext4_sb_rdonly(sb) &&
> +			    test_opt(sb, INIT_INODE_TABLE)) {
>  				elr->lr_next_group = elr->lr_first_not_zeroed;
>  				elr->lr_mode = EXT4_LI_MODE_ITABLE;
>  				ret = 0;
> @@ -3998,7 +3999,7 @@ int ext4_register_li_request(struct super_block *sb,
>  		goto out;
>  	}
>  
> -	if (sb_rdonly(sb) ||
> +	if (ext4_sb_rdonly(sb) ||
>  	    (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
>  	     (first_not_zeroed == ngroups || !test_opt(sb, INIT_INODE_TABLE))))
>  		goto out;


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

