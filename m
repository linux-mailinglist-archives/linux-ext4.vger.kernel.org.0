Return-Path: <linux-ext4+bounces-10235-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB55B80FCA
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 18:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69962A6355
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2305934BA4C;
	Wed, 17 Sep 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bef9jcm/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dqURvPom";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bef9jcm/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dqURvPom"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A834BA47
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126183; cv=none; b=tNpTmR6G4gJRUEdikf+joxXfZ/w2FdC8Dv8RWeVZOmhYNoApDbzpkHahMXxcWHZekZhhMbp8/fpZd7opPwmQxJ8sKZ1dBj0nwZK5Yt2zDIVRU2pwaiujDECulobweBf/rPRH2HFN31QtTlQBaR+AKS0VdDxGheeSzpwa20TVVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126183; c=relaxed/simple;
	bh=mKXsPKlvY7qyQLdUDgerhbXk3EwxDVgaBEkqeMDJYwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmO1QJBkBxBbHKTFGYdHqYdR85QP0WptOa8Nen2PKupgOcTZcTr/uVaVKK2FAwPyoaqg+5kVOM8xFwux7Ibe/1g0xgE1fphAUX2Y9VhihXRK2vEGh2JscdZcMrbvOu6TygsyMfiXXtRpneVYfLD37Tl4rV+hdKm3OpI+gHRXdXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bef9jcm/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dqURvPom; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bef9jcm/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dqURvPom; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D49A33BDB;
	Wed, 17 Sep 2025 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wMQARSAyuBhye5q0DhV2fTMbAl2HHh+cmKAhT9SIbM=;
	b=bef9jcm/v5miTanOjvV2KofQHSDR2kwTnLVFDAQ8r+z5ZbA1HejvFRak3w4PcUwUmwj22e
	R7MSl/FEE0EJXHhEBhRSJ31HsK+FGSZ5XRZ2wU4Xg/AohjqYh+gRhdid0WsKfyEJSNQDtS
	ENkXeLuaPTzgQGZpIjaDjGFCHzJbi1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wMQARSAyuBhye5q0DhV2fTMbAl2HHh+cmKAhT9SIbM=;
	b=dqURvPom+YPp2S3TRmz5CNxk1wques6oYpgqV7LAuwv5CYVYLBsblcXT0EPvfQxuWbOwFs
	+WYhxDXC93wEIBAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="bef9jcm/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dqURvPom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wMQARSAyuBhye5q0DhV2fTMbAl2HHh+cmKAhT9SIbM=;
	b=bef9jcm/v5miTanOjvV2KofQHSDR2kwTnLVFDAQ8r+z5ZbA1HejvFRak3w4PcUwUmwj22e
	R7MSl/FEE0EJXHhEBhRSJ31HsK+FGSZ5XRZ2wU4Xg/AohjqYh+gRhdid0WsKfyEJSNQDtS
	ENkXeLuaPTzgQGZpIjaDjGFCHzJbi1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wMQARSAyuBhye5q0DhV2fTMbAl2HHh+cmKAhT9SIbM=;
	b=dqURvPom+YPp2S3TRmz5CNxk1wques6oYpgqV7LAuwv5CYVYLBsblcXT0EPvfQxuWbOwFs
	+WYhxDXC93wEIBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B0751368D;
	Wed, 17 Sep 2025 16:22:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QE0cGmPgymhIMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 16:22:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 019A8A083B; Wed, 17 Sep 2025 18:22:50 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:22:50 +0200
From: Jan Kara <jack@suse.cz>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ext4: implemet new ioctls to set and get
 superblock parameters
Message-ID: <rtkw2a5hwurbrft5ukldsothzc75ijehb77ssoyo7tv2uyt5rd@uqsm577rr6ij>
References: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
 <20250916-tune2fs-v2-3-d594dc7486f0@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-tune2fs-v2-3-d594dc7486f0@mit.edu>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8D49A33BDB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Tue 16-09-25 23:22:49, Theodore Ts'o via B4 Relay wrote:
> From: Theodore Ts'o <tytso@mit.edu>
> 
> Implement the EXT4_IOC_GET_TUNE_SB_PARAM and
> EXT4_IOC_SET_TUNE_SB_PARAM ioctls, which allow certains superblock
> parameters to be set while the file system is mounted, without needing
> write access to the block device.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/ext4/ioctl.c           | 312 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/ext4.h |  53 +++++++++++++
>  2 files changed, 358 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 84e3c73952d72e436429489f5fc8b7ae1c01c7a1..a93a7baae990cc5580d2ddb3ffcc72fe15246978 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -27,14 +27,16 @@
>  #include "fsmap.h"
>  #include <trace/events/ext4.h>
>  
> -typedef void ext4_update_sb_callback(struct ext4_super_block *es,
> -				       const void *arg);
> +typedef void ext4_update_sb_callback(struct ext4_sb_info *sbi,
> +				     struct ext4_super_block *es,
> +				     const void *arg);
>  
>  /*
>   * Superblock modification callback function for changing file system
>   * label
>   */
> -static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
> +static void ext4_sb_setlabel(struct ext4_sb_info *sbi,
> +			     struct ext4_super_block *es, const void *arg)
>  {
>  	/* Sanity check, this should never happen */
>  	BUILD_BUG_ON(sizeof(es->s_volume_name) < EXT4_LABEL_MAX);
> @@ -46,7 +48,8 @@ static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
>   * Superblock modification callback function for changing file system
>   * UUID.
>   */
> -static void ext4_sb_setuuid(struct ext4_super_block *es, const void *arg)
> +static void ext4_sb_setuuid(struct ext4_sb_info *sbi,
> +			    struct ext4_super_block *es, const void *arg)
>  {
>  	memcpy(es->s_uuid, (__u8 *)arg, UUID_SIZE);
>  }
> @@ -71,7 +74,7 @@ int ext4_update_primary_sb(struct super_block *sb, handle_t *handle,
>  		goto out_err;
>  
>  	lock_buffer(bh);
> -	func(es, arg);
> +	func(sbi, es, arg);
>  	ext4_superblock_csum_set(sb);
>  	unlock_buffer(bh);
>  
> @@ -149,7 +152,7 @@ static int ext4_update_backup_sb(struct super_block *sb,
>  		unlock_buffer(bh);
>  		goto out_bh;
>  	}
> -	func(es, arg);
> +	func(EXT4_SB(sb), es, arg);
>  	if (ext4_has_feature_metadata_csum(sb))
>  		es->s_checksum = ext4_superblock_csum(es);
>  	set_buffer_uptodate(bh);
> @@ -1230,6 +1233,295 @@ static int ext4_ioctl_setuuid(struct file *filp,
>  	return ret;
>  }
>  
> +
> +#define TUNE_OPS_SUPPORTED (EXT4_TUNE_FL_ERRORS_BEHAVIOR |    \
> +	EXT4_TUNE_FL_MNT_COUNT | EXT4_TUNE_FL_MAX_MNT_COUNT | \
> +	EXT4_TUNE_FL_CHECKINTRVAL | EXT4_TUNE_FL_LAST_CHECK_TIME | \
> +	EXT4_TUNE_FL_RESERVED_BLOCKS | EXT4_TUNE_FL_RESERVED_UID | \
> +	EXT4_TUNE_FL_RESERVED_GID | EXT4_TUNE_FL_DEFAULT_MNT_OPTS | \
> +	EXT4_TUNE_FL_DEF_HASH_ALG | EXT4_TUNE_FL_RAID_STRIDE | \
> +	EXT4_TUNE_FL_RAID_STRIPE_WIDTH | EXT4_TUNE_FL_MOUNT_OPTS | \
> +	EXT4_TUNE_FL_FEATURES | EXT4_TUNE_FL_EDIT_FEATURES | \
> +	EXT4_TUNE_FL_FORCE_FSCK | EXT4_TUNE_FL_ENCODING | \
> +	EXT4_TUNE_FL_ENCODING_FLAGS)
> +
> +#define EXT4_TUNE_SET_COMPAT_SUPP \
> +		(EXT4_FEATURE_COMPAT_DIR_INDEX |	\
> +		 EXT4_FEATURE_COMPAT_STABLE_INODES)
> +#define EXT4_TUNE_SET_INCOMPAT_SUPP \
> +		(EXT4_FEATURE_INCOMPAT_EXTENTS |	\
> +		 EXT4_FEATURE_INCOMPAT_EA_INODE |	\
> +		 EXT4_FEATURE_INCOMPAT_ENCRYPT |	\
> +		 EXT4_FEATURE_INCOMPAT_CSUM_SEED |	\
> +		 EXT4_FEATURE_INCOMPAT_LARGEDIR |	\
> +		 EXT4_FEATURE_INCOMPAT_CASEFOLD)
> +#define EXT4_TUNE_SET_RO_COMPAT_SUPP \
> +		(EXT4_FEATURE_RO_COMPAT_LARGE_FILE |	\
> +		 EXT4_FEATURE_RO_COMPAT_DIR_NLINK |	\
> +		 EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE |	\
> +		 EXT4_FEATURE_RO_COMPAT_PROJECT |	\
> +		 EXT4_FEATURE_RO_COMPAT_VERITY)
> +
> +#define EXT4_TUNE_CLEAR_COMPAT_SUPP (0)
> +#define EXT4_TUNE_CLEAR_INCOMPAT_SUPP (0)
> +#define EXT4_TUNE_CLEAR_RO_COMPAT_SUPP (0)
> +
> +#define SB_ENC_SUPP_MASK (SB_ENC_STRICT_MODE_FL |	\
> +			  SB_ENC_NO_COMPAT_FALLBACK_FL)
> +
> +static int ext4_ioctl_get_tune_sb(struct ext4_sb_info *sbi,
> +				  struct ext4_tune_sb_params __user *params)
> +{
> +	struct ext4_tune_sb_params ret;
> +	struct ext4_super_block *es = sbi->s_es;
> +
> +	memset(&ret, 0, sizeof(ret));
> +	ret.set_flags = TUNE_OPS_SUPPORTED;
> +	ret.errors_behavior = le16_to_cpu(es->s_errors);
> +	ret.mnt_count = le16_to_cpu(es->s_mnt_count);
> +	ret.max_mnt_count = le16_to_cpu(es->s_max_mnt_count);
> +	ret.checkinterval = le32_to_cpu(es->s_checkinterval);
> +	ret.last_check_time = le32_to_cpu(es->s_lastcheck);
> +	ret.reserved_blocks = ext4_r_blocks_count(es);
> +	ret.blocks_count = ext4_blocks_count(es);
> +	ret.reserved_uid = ext4_get_resuid(es);
> +	ret.reserved_gid = ext4_get_resgid(es);
> +	ret.default_mnt_opts = le32_to_cpu(es->s_default_mount_opts);
> +	ret.def_hash_alg = es->s_def_hash_version;
> +	ret.raid_stride = le16_to_cpu(es->s_raid_stride);
> +	ret.raid_stripe_width = le32_to_cpu(es->s_raid_stripe_width);
> +	ret.encoding = le16_to_cpu(es->s_encoding);
> +	ret.encoding_flags = le16_to_cpu(es->s_encoding_flags);
> +	strscpy_pad(ret.mount_opts, es->s_mount_opts);
> +	ret.feature_compat = le32_to_cpu(es->s_feature_compat);
> +	ret.feature_incompat = le32_to_cpu(es->s_feature_incompat);
> +	ret.feature_ro_compat = le32_to_cpu(es->s_feature_ro_compat);
> +	ret.set_feature_compat_mask = EXT4_TUNE_SET_COMPAT_SUPP;
> +	ret.set_feature_incompat_mask = EXT4_TUNE_SET_INCOMPAT_SUPP;
> +	ret.set_feature_ro_compat_mask = EXT4_TUNE_SET_RO_COMPAT_SUPP;
> +	ret.clear_feature_compat_mask = EXT4_TUNE_CLEAR_COMPAT_SUPP;
> +	ret.clear_feature_incompat_mask = EXT4_TUNE_CLEAR_INCOMPAT_SUPP;
> +	ret.clear_feature_ro_compat_mask = EXT4_TUNE_CLEAR_RO_COMPAT_SUPP;
> +	if (copy_to_user(params, &ret, sizeof(ret)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static void ext4_sb_setparams(struct ext4_sb_info *sbi,
> +			      struct ext4_super_block *es, const void *arg)
> +{
> +	const struct ext4_tune_sb_params *params = arg;
> +
> +	if (params->set_flags & EXT4_TUNE_FL_ERRORS_BEHAVIOR)
> +		es->s_errors = cpu_to_le16(params->errors_behavior);
> +	if (params->set_flags & EXT4_TUNE_FL_MNT_COUNT)
> +		es->s_mnt_count = cpu_to_le16(params->mnt_count);
> +	if (params->set_flags & EXT4_TUNE_FL_MAX_MNT_COUNT)
> +		es->s_max_mnt_count = cpu_to_le16(params->max_mnt_count);
> +	if (params->set_flags & EXT4_TUNE_FL_CHECKINTRVAL)
> +		es->s_checkinterval = cpu_to_le32(params->checkinterval);
> +	if (params->set_flags & EXT4_TUNE_FL_LAST_CHECK_TIME)
> +		es->s_lastcheck = cpu_to_le32(params->last_check_time);
> +	if (params->set_flags & EXT4_TUNE_FL_RESERVED_BLOCKS) {
> +		ext4_fsblk_t blk = params->reserved_blocks;
> +
> +		es->s_r_blocks_count_lo = cpu_to_le32((u32)blk);
> +		es->s_r_blocks_count_hi = cpu_to_le32(blk >> 32);
> +	}
> +	if (params->set_flags & EXT4_TUNE_FL_RESERVED_UID) {
> +		int uid = params->reserved_uid;
> +
> +		es->s_def_resuid = cpu_to_le16(uid & 0xFFFF);
> +		es->s_def_resuid_hi = cpu_to_le16(uid >> 16);
> +	}
> +	if (params->set_flags & EXT4_TUNE_FL_RESERVED_GID) {
> +		int gid = params->reserved_gid;
> +
> +		es->s_def_resgid = cpu_to_le16(gid & 0xFFFF);
> +		es->s_def_resgid_hi = cpu_to_le16(gid >> 16);
> +	}
> +	if (params->set_flags & EXT4_TUNE_FL_DEFAULT_MNT_OPTS)
> +		es->s_default_mount_opts = cpu_to_le32(params->default_mnt_opts);
> +	if (params->set_flags & EXT4_TUNE_FL_DEF_HASH_ALG)
> +		es->s_def_hash_version = params->def_hash_alg;
> +	if (params->set_flags & EXT4_TUNE_FL_RAID_STRIDE)
> +		es->s_raid_stride = cpu_to_le16(params->raid_stride);
> +	if (params->set_flags & EXT4_TUNE_FL_RAID_STRIPE_WIDTH)
> +		es->s_raid_stripe_width =
> +			cpu_to_le32(params->raid_stripe_width);
> +	if (params->set_flags & EXT4_TUNE_FL_ENCODING)
> +		es->s_encoding = cpu_to_le16(params->encoding);
> +	if (params->set_flags & EXT4_TUNE_FL_ENCODING_FLAGS)
> +		es->s_encoding_flags = cpu_to_le16(params->encoding_flags);
> +	strscpy_pad(es->s_mount_opts, params->mount_opts);
> +	if (params->set_flags & EXT4_TUNE_FL_EDIT_FEATURES) {
> +		es->s_feature_compat |=
> +			cpu_to_le32(params->set_feature_compat_mask);
> +		es->s_feature_incompat |=
> +			cpu_to_le32(params->set_feature_incompat_mask);
> +		es->s_feature_ro_compat |=
> +			cpu_to_le32(params->set_feature_ro_compat_mask);
> +		es->s_feature_compat &=
> +			~cpu_to_le32(params->clear_feature_compat_mask);
> +		es->s_feature_incompat &=
> +			~cpu_to_le32(params->clear_feature_incompat_mask);
> +		es->s_feature_ro_compat &=
> +			~cpu_to_le32(params->clear_feature_ro_compat_mask);
> +		if (params->set_feature_compat_mask &
> +		    EXT4_FEATURE_COMPAT_DIR_INDEX)
> +			es->s_def_hash_version = sbi->s_def_hash_version;
> +		if (params->set_feature_incompat_mask &
> +		    EXT4_FEATURE_INCOMPAT_CSUM_SEED)
> +			es->s_checksum_seed = cpu_to_le32(sbi->s_csum_seed);
> +	}
> +	if (params->set_flags & EXT4_TUNE_FL_FORCE_FSCK)
> +		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> +}
> +
> +static int ext4_ioctl_set_tune_sb(struct file *filp,
> +				  struct ext4_tune_sb_params __user *in)
> +{
> +	struct ext4_tune_sb_params params;
> +	struct super_block *sb = file_inode(filp)->i_sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_super_block *es = sbi->s_es;
> +	int enabling_casefold = 0;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (copy_from_user(&params, in, sizeof(params)))
> +		return -EFAULT;
> +
> +	if ((params.set_flags & ~TUNE_OPS_SUPPORTED) != 0)
> +		return -EOPNOTSUPP;
> +
> +	if ((params.set_flags & EXT4_TUNE_FL_ERRORS_BEHAVIOR) &&
> +	    (params.errors_behavior > EXT4_ERRORS_PANIC))
> +		return -EINVAL;
> +
> +	if ((params.set_flags & EXT4_TUNE_FL_RESERVED_BLOCKS) &&
> +	    (params.reserved_blocks > ext4_blocks_count(sbi->s_es) / 2))
> +		return -EINVAL;
> +	if ((params.set_flags & EXT4_TUNE_FL_DEF_HASH_ALG) &&
> +	    ((params.def_hash_alg > DX_HASH_LAST) ||
> +	     (params.def_hash_alg == DX_HASH_SIPHASH)))
> +		return -EINVAL;
> +	if ((params.set_flags & EXT4_TUNE_FL_FEATURES) &&
> +	    (params.set_flags & EXT4_TUNE_FL_EDIT_FEATURES))
> +		return -EINVAL;
> +
> +	if (params.set_flags & EXT4_TUNE_FL_FEATURES) {
> +		params.set_feature_compat_mask =
> +			params.feature_compat &
> +			~le32_to_cpu(es->s_feature_compat);
> +		params.set_feature_incompat_mask =
> +			params.feature_incompat &
> +			~le32_to_cpu(es->s_feature_incompat);
> +		params.set_feature_ro_compat_mask =
> +			params.feature_ro_compat &
> +			~le32_to_cpu(es->s_feature_ro_compat);
> +		params.clear_feature_compat_mask =
> +			~params.feature_compat &
> +			le32_to_cpu(es->s_feature_compat);
> +		params.clear_feature_incompat_mask =
> +			~params.feature_incompat &
> +			le32_to_cpu(es->s_feature_incompat);
> +		params.clear_feature_ro_compat_mask =
> +			~params.feature_ro_compat &
> +			le32_to_cpu(es->s_feature_ro_compat);
> +		params.set_flags |= EXT4_TUNE_FL_EDIT_FEATURES;
> +	}
> +	if (params.set_flags & EXT4_TUNE_FL_EDIT_FEATURES) {
> +		if ((params.set_feature_compat_mask &
> +		     ~EXT4_TUNE_SET_COMPAT_SUPP) ||
> +		    (params.set_feature_incompat_mask &
> +		     ~EXT4_TUNE_SET_INCOMPAT_SUPP) ||
> +		    (params.set_feature_ro_compat_mask &
> +		     ~EXT4_TUNE_SET_RO_COMPAT_SUPP) ||
> +		    (params.clear_feature_compat_mask &
> +		     ~EXT4_TUNE_CLEAR_COMPAT_SUPP) ||
> +		    (params.clear_feature_incompat_mask &
> +		     ~EXT4_TUNE_CLEAR_INCOMPAT_SUPP) ||
> +		    (params.clear_feature_ro_compat_mask &
> +		     ~EXT4_TUNE_CLEAR_RO_COMPAT_SUPP))
> +			return -EOPNOTSUPP;
> +
> +		/*
> +		 * Filter out the features that are already set from
> +		 * the set_mask.
> +		 */
> +		params.set_feature_compat_mask &=
> +			~le32_to_cpu(es->s_feature_compat);
> +		params.set_feature_incompat_mask &=
> +			~le32_to_cpu(es->s_feature_incompat);
> +		params.set_feature_ro_compat_mask &=
> +			~le32_to_cpu(es->s_feature_ro_compat);
> +		if ((params.set_feature_incompat_mask &
> +		     EXT4_FEATURE_INCOMPAT_CASEFOLD)) {
> +			enabling_casefold = 1;
> +			if (!(params.set_flags & EXT4_TUNE_FL_ENCODING)) {
> +				params.encoding = EXT4_ENC_UTF8_12_1;
> +				params.set_flags |= EXT4_TUNE_FL_ENCODING;
> +			}
> +			if (!(params.set_flags & EXT4_TUNE_FL_ENCODING_FLAGS)) {
> +				params.encoding_flags = 0;
> +				params.set_flags |= EXT4_TUNE_FL_ENCODING_FLAGS;
> +			}
> +		}
> +		if ((params.set_feature_compat_mask &
> +		     EXT4_FEATURE_COMPAT_DIR_INDEX)) {
> +			uuid_t	uu;
> +
> +			memcpy(&uu, sbi->s_hash_seed, UUID_SIZE);
> +			if (uuid_is_null(&uu))
> +				generate_random_uuid((char *)
> +						     &sbi->s_hash_seed);
> +			if (params.set_flags & EXT4_TUNE_FL_DEF_HASH_ALG)
> +				sbi->s_def_hash_version = params.def_hash_alg;
> +			else if (sbi->s_def_hash_version == 0)
> +				sbi->s_def_hash_version = DX_HASH_HALF_MD4;
> +			if (!(es->s_flags &
> +			      cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH)) &&
> +			    !(es->s_flags &
> +			      cpu_to_le32(EXT2_FLAGS_SIGNED_HASH))) {
> +#ifdef __CHAR_UNSIGNED__
> +				sbi->s_hash_unsigned = 3;
> +#else
> +				sbi->s_hash_unsigned = 0;
> +#endif
> +			}
> +		}
> +	}
> +	if (params.set_flags & EXT4_TUNE_FL_ENCODING) {
> +		if (!enabling_casefold)
> +			return -EINVAL;
> +		if (params.encoding == 0)
> +			params.encoding = EXT4_ENC_UTF8_12_1;
> +		else if (params.encoding != EXT4_ENC_UTF8_12_1)
> +			return -EINVAL;
> +	}
> +	if (params.set_flags & EXT4_TUNE_FL_ENCODING_FLAGS) {
> +		if (!enabling_casefold)
> +			return -EINVAL;
> +		if (params.encoding_flags & ~SB_ENC_SUPP_MASK)
> +			return -EINVAL;
> +	}
> +
> +	ret = mnt_want_write_file(filp);
> +	if (ret)
> +		return ret;
> +
> +	ret = ext4_update_superblocks_fn(sb, ext4_sb_setparams, &params);
> +	mnt_drop_write_file(filp);
> +
> +	if (params.set_flags & EXT4_TUNE_FL_DEF_HASH_ALG)
> +		sbi->s_def_hash_version = params.def_hash_alg;
> +
> +	return ret;
> +}
> +
>  static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> @@ -1616,6 +1908,11 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
>  	case EXT4_IOC_SETFSUUID:
>  		return ext4_ioctl_setuuid(filp, (const void __user *)arg);
> +	case EXT4_IOC_GET_TUNE_SB_PARAM:
> +		return ext4_ioctl_get_tune_sb(EXT4_SB(sb),
> +					      (void __user *)arg);
> +	case EXT4_IOC_SET_TUNE_SB_PARAM:
> +		return ext4_ioctl_set_tune_sb(filp, (void __user *)arg);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -1703,7 +2000,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  }
>  #endif
>  
> -static void set_overhead(struct ext4_super_block *es, const void *arg)
> +static void set_overhead(struct ext4_sb_info *sbi,
> +			 struct ext4_super_block *es, const void *arg)
>  {
>  	es->s_overhead_clusters = cpu_to_le32(*((unsigned long *) arg));
>  }
> diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
> index 1c4c2dd29112cda9f7dc91d917492cffc33ee524..411dcc1e4a35c8c6a10f3768d17b8cc50cff4c34 100644
> --- a/include/uapi/linux/ext4.h
> +++ b/include/uapi/linux/ext4.h
> @@ -33,6 +33,8 @@
>  #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
>  #define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
>  #define EXT4_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
> +#define EXT4_IOC_GET_TUNE_SB_PARAM	_IOR('f', 45, struct ext4_tune_sb_params)
> +#define EXT4_IOC_SET_TUNE_SB_PARAM	_IOW('f', 46, struct ext4_tune_sb_params)
>  
>  #define EXT4_IOC_SHUTDOWN _IOR('X', 125, __u32)
>  
> @@ -108,6 +110,57 @@ struct ext4_new_group_input {
>  	__u16 unused;
>  };
>  
> +struct ext4_tune_sb_params {
> +	__u32 set_flags;
> +	__u32 checkinterval;
> +	__u16 errors_behavior;
> +	__u16 mnt_count;
> +	__u16 max_mnt_count;
> +	__u16 raid_stride;
> +	__u64 last_check_time;
> +	__u64 reserved_blocks;
> +	__u64 blocks_count;
> +	__u32 default_mnt_opts;
> +	__u32 reserved_uid;
> +	__u32 reserved_gid;
> +	__u32 raid_stripe_width;
> +	__u16 encoding;
> +	__u16 encoding_flags;
> +	__u8  def_hash_alg;
> +	__u8  pad_1;
> +	__u16 pad_2;
> +	__u32 feature_compat;
> +	__u32 feature_incompat;
> +	__u32 feature_ro_compat;
> +	__u32 set_feature_compat_mask;
> +	__u32 set_feature_incompat_mask;
> +	__u32 set_feature_ro_compat_mask;
> +	__u32 clear_feature_compat_mask;
> +	__u32 clear_feature_incompat_mask;
> +	__u32 clear_feature_ro_compat_mask;
> +	__u8  mount_opts[64];
> +	__u8  pad[64];
> +};
> +
> +#define EXT4_TUNE_FL_ERRORS_BEHAVIOR	0x00000001
> +#define EXT4_TUNE_FL_MNT_COUNT		0x00000002
> +#define EXT4_TUNE_FL_MAX_MNT_COUNT	0x00000004
> +#define EXT4_TUNE_FL_CHECKINTRVAL	0x00000008
> +#define EXT4_TUNE_FL_LAST_CHECK_TIME	0x00000010
> +#define EXT4_TUNE_FL_RESERVED_BLOCKS	0x00000020
> +#define EXT4_TUNE_FL_RESERVED_UID	0x00000040
> +#define EXT4_TUNE_FL_RESERVED_GID	0x00000080
> +#define EXT4_TUNE_FL_DEFAULT_MNT_OPTS	0x00000100
> +#define EXT4_TUNE_FL_DEF_HASH_ALG	0x00000200
> +#define EXT4_TUNE_FL_RAID_STRIDE	0x00000400
> +#define EXT4_TUNE_FL_RAID_STRIPE_WIDTH	0x00000800
> +#define EXT4_TUNE_FL_MOUNT_OPTS		0x00001000
> +#define EXT4_TUNE_FL_FEATURES		0x00002000
> +#define EXT4_TUNE_FL_EDIT_FEATURES	0x00004000
> +#define EXT4_TUNE_FL_FORCE_FSCK		0x00008000
> +#define EXT4_TUNE_FL_ENCODING		0x00010000
> +#define EXT4_TUNE_FL_ENCODING_FLAGS	0x00020000
> +
>  /*
>   * Returned by EXT4_IOC_GET_ES_CACHE as an additional possible flag.
>   * It indicates that the entry in extent status cache is for a hole.
> 
> -- 
> 2.51.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

