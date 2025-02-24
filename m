Return-Path: <linux-ext4+bounces-6544-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D7A42758
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 17:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38921188F590
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EDB21CC58;
	Mon, 24 Feb 2025 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WC7zej1s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ujMx84Le";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WC7zej1s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ujMx84Le"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD603DBB6
	for <linux-ext4@vger.kernel.org>; Mon, 24 Feb 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412952; cv=none; b=S2qBYBtzZMznLSiiHjgW5GoE7WTs7FNhUNhzflfXR7AFZASpWfXOQ8RedIijOjJMtK2CHqQ64Ob8VVYv3abHQMjsSsswB7ZjHVohbYrjbzUYKIv2VgL4xbne5L71LanucfXsvnXXySQVC3etvO8TL/ucQm3NjGRODswe42CVu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412952; c=relaxed/simple;
	bh=J1ItzUcKFxhDg6gOurHTrvvrGC41F8ivWsFNllHHUgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xxi3wvx9AaHrGXeRnJGtuya25buce2ZLzIxdrHdjIwpjXziZTv8XY6mexiRmHFRe4npr199IVrOK2QVambZ3rJjlU8Wp3N2nAUhW555FzmYp9TZmR2QLo7/cjiryw9WmKJecT2N7UZcuoK8La/Ds7J68sFoISRng+K2yAVJHzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WC7zej1s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ujMx84Le; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WC7zej1s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ujMx84Le; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27B0221189;
	Mon, 24 Feb 2025 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740412947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Olk6sVm6GpfgcCAgyW9Xry+RRY5WIuEOO4uDZXH5rs=;
	b=WC7zej1sxSk1Fux/LgOxmXFcebk5ha+IO/x/32dmWbGF1caab257f22kMcxmubARkUu/c6
	3JiVaEHHfPwmW9PPDt20D66sFBFzdDFOcLyjUGQwncO1kJonKc9+50Cn/3xYe2ZdQIJ4CJ
	c+UIVZhqjc2EEggBbXVlxnvq5Tkq3EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740412947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Olk6sVm6GpfgcCAgyW9Xry+RRY5WIuEOO4uDZXH5rs=;
	b=ujMx84LePj/yqJoT6yDrimtmAAb63l5iQy5roGaeuuY45BuhNF1J3JFvu1n/KlbDkrIzLV
	MbL31UoMKPVGVqBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740412947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Olk6sVm6GpfgcCAgyW9Xry+RRY5WIuEOO4uDZXH5rs=;
	b=WC7zej1sxSk1Fux/LgOxmXFcebk5ha+IO/x/32dmWbGF1caab257f22kMcxmubARkUu/c6
	3JiVaEHHfPwmW9PPDt20D66sFBFzdDFOcLyjUGQwncO1kJonKc9+50Cn/3xYe2ZdQIJ4CJ
	c+UIVZhqjc2EEggBbXVlxnvq5Tkq3EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740412947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Olk6sVm6GpfgcCAgyW9Xry+RRY5WIuEOO4uDZXH5rs=;
	b=ujMx84LePj/yqJoT6yDrimtmAAb63l5iQy5roGaeuuY45BuhNF1J3JFvu1n/KlbDkrIzLV
	MbL31UoMKPVGVqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DE2813707;
	Mon, 24 Feb 2025 16:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ca9FBxOYvGfGZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Feb 2025 16:02:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DA586A0851; Mon, 24 Feb 2025 17:02:26 +0100 (CET)
Date: Mon, 24 Feb 2025 17:02:26 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] ext2: convert to the new mount API
Message-ID: <goynv3cssrrdpykmtwon63xiye4qdzbmvpwq6gjzwine63r25n@4mfgf2ycqzql>
References: <20250223201014.7541-1-sandeen@redhat.com>
 <20250223201014.7541-2-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223201014.7541-2-sandeen@redhat.com>
X-Spam-Level: 
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
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Sun 23-02-25 13:57:40, Eric Sandeen wrote:
> Convert ext2 to the new mount API.
> 
> Note that this makes the sb= option more accepting than it was before;
> previosly, sb= was only accepted if it was the first specified option.
> Now it can exist anywhere, and if respecified, the last specified value
> is used.
> 
> Parse-time messages here are sent to ext2_msg with a NULL sb, and
> ext2_msg is adjusted to accept that, as ext4 does today as well.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good to me. Thanks!

									Honza

> ---
>  fs/ext2/ext2.h  |   1 +
>  fs/ext2/super.c | 571 ++++++++++++++++++++++++++----------------------
>  2 files changed, 310 insertions(+), 262 deletions(-)
> 
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index f38bdd46e4f7..4025f875252a 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -368,6 +368,7 @@ struct ext2_inode {
>  #define EXT2_MOUNT_ERRORS_CONT		0x000010  /* Continue on errors */
>  #define EXT2_MOUNT_ERRORS_RO		0x000020  /* Remount fs ro on errors */
>  #define EXT2_MOUNT_ERRORS_PANIC		0x000040  /* Panic on errors */
> +#define EXT2_MOUNT_ERRORS_MASK		0x000070
>  #define EXT2_MOUNT_MINIX_DF		0x000080  /* Mimics the Minix statfs */
>  #define EXT2_MOUNT_NOBH			0x000100  /* No buffer_heads */
>  #define EXT2_MOUNT_NO_UID32		0x000200  /* Disable 32-bit UIDs */
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 37f7ce56adce..cb6253656eb2 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -23,7 +23,8 @@
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/blkdev.h>
> -#include <linux/parser.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/random.h>
>  #include <linux/buffer_head.h>
>  #include <linux/exportfs.h>
> @@ -40,7 +41,6 @@
>  #include "acl.h"
>  
>  static void ext2_write_super(struct super_block *sb);
> -static int ext2_remount (struct super_block * sb, int * flags, char * data);
>  static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf);
>  static int ext2_sync_fs(struct super_block *sb, int wait);
>  static int ext2_freeze(struct super_block *sb);
> @@ -92,7 +92,10 @@ void ext2_msg(struct super_block *sb, const char *prefix,
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  
> -	printk("%sEXT2-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
> +	if (sb)
> +		printk("%sEXT2-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
> +	else
> +		printk("%sEXT2-fs: %pV\n", prefix, &vaf);
>  
>  	va_end(args);
>  }
> @@ -346,7 +349,6 @@ static const struct super_operations ext2_sops = {
>  	.freeze_fs	= ext2_freeze,
>  	.unfreeze_fs	= ext2_unfreeze,
>  	.statfs		= ext2_statfs,
> -	.remount_fs	= ext2_remount,
>  	.show_options	= ext2_show_options,
>  #ifdef CONFIG_QUOTA
>  	.quota_read	= ext2_quota_read,
> @@ -402,230 +404,217 @@ static const struct export_operations ext2_export_ops = {
>  	.get_parent = ext2_get_parent,
>  };
>  
> -static unsigned long get_sb_block(void **data)
> -{
> -	unsigned long 	sb_block;
> -	char 		*options = (char *) *data;
> -
> -	if (!options || strncmp(options, "sb=", 3) != 0)
> -		return 1;	/* Default location */
> -	options += 3;
> -	sb_block = simple_strtoul(options, &options, 0);
> -	if (*options && *options != ',') {
> -		printk("EXT2-fs: Invalid sb specification: %s\n",
> -		       (char *) *data);
> -		return 1;
> -	}
> -	if (*options == ',')
> -		options++;
> -	*data = (void *) options;
> -	return sb_block;
> -}
> -
>  enum {
> -	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
> -	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic,
> -	Opt_err_ro, Opt_nouid32, Opt_debug,
> -	Opt_oldalloc, Opt_orlov, Opt_nobh, Opt_user_xattr, Opt_nouser_xattr,
> -	Opt_acl, Opt_noacl, Opt_xip, Opt_dax, Opt_ignore, Opt_err, Opt_quota,
> -	Opt_usrquota, Opt_grpquota, Opt_reservation, Opt_noreservation
> +	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid, Opt_resgid, Opt_resuid,
> +	Opt_sb, Opt_errors, Opt_nouid32, Opt_debug, Opt_oldalloc, Opt_orlov,
> +	Opt_nobh, Opt_user_xattr, Opt_acl, Opt_xip, Opt_dax, Opt_ignore,
> +	Opt_quota, Opt_usrquota, Opt_grpquota, Opt_reservation,
> +};
> +
> +static const struct constant_table ext2_param_errors[] = {
> +	{"continue",	EXT2_MOUNT_ERRORS_CONT},
> +	{"panic",	EXT2_MOUNT_ERRORS_PANIC},
> +	{"remount-ro",	EXT2_MOUNT_ERRORS_RO},
> +	{}
> +};
> +
> +const struct fs_parameter_spec ext2_param_spec[] = {
> +	fsparam_flag	("bsddf", Opt_bsd_df),
> +	fsparam_flag	("minixdf", Opt_minix_df),
> +	fsparam_flag	("grpid", Opt_grpid),
> +	fsparam_flag	("bsdgroups", Opt_grpid),
> +	fsparam_flag	("nogrpid", Opt_nogrpid),
> +	fsparam_flag	("sysvgroups", Opt_nogrpid),
> +	fsparam_gid	("resgid", Opt_resgid),
> +	fsparam_uid	("resuid", Opt_resuid),
> +	fsparam_u32	("sb", Opt_sb),
> +	fsparam_enum	("errors", Opt_errors, ext2_param_errors),
> +	fsparam_flag	("nouid32", Opt_nouid32),
> +	fsparam_flag	("debug", Opt_debug),
> +	fsparam_flag	("oldalloc", Opt_oldalloc),
> +	fsparam_flag	("orlov", Opt_orlov),
> +	fsparam_flag	("nobh", Opt_nobh),
> +	fsparam_flag_no	("user_xattr", Opt_user_xattr),
> +	fsparam_flag_no	("acl", Opt_acl),
> +	fsparam_flag	("xip", Opt_xip),
> +	fsparam_flag	("dax", Opt_dax),
> +	fsparam_flag	("grpquota", Opt_grpquota),
> +	fsparam_flag	("noquota", Opt_ignore),
> +	fsparam_flag	("quota", Opt_quota),
> +	fsparam_flag	("usrquota", Opt_usrquota),
> +	fsparam_flag_no	("reservation", Opt_reservation),
> +	{}
>  };
>  
> -static const match_table_t tokens = {
> -	{Opt_bsd_df, "bsddf"},
> -	{Opt_minix_df, "minixdf"},
> -	{Opt_grpid, "grpid"},
> -	{Opt_grpid, "bsdgroups"},
> -	{Opt_nogrpid, "nogrpid"},
> -	{Opt_nogrpid, "sysvgroups"},
> -	{Opt_resgid, "resgid=%u"},
> -	{Opt_resuid, "resuid=%u"},
> -	{Opt_sb, "sb=%u"},
> -	{Opt_err_cont, "errors=continue"},
> -	{Opt_err_panic, "errors=panic"},
> -	{Opt_err_ro, "errors=remount-ro"},
> -	{Opt_nouid32, "nouid32"},
> -	{Opt_debug, "debug"},
> -	{Opt_oldalloc, "oldalloc"},
> -	{Opt_orlov, "orlov"},
> -	{Opt_nobh, "nobh"},
> -	{Opt_user_xattr, "user_xattr"},
> -	{Opt_nouser_xattr, "nouser_xattr"},
> -	{Opt_acl, "acl"},
> -	{Opt_noacl, "noacl"},
> -	{Opt_xip, "xip"},
> -	{Opt_dax, "dax"},
> -	{Opt_grpquota, "grpquota"},
> -	{Opt_ignore, "noquota"},
> -	{Opt_quota, "quota"},
> -	{Opt_usrquota, "usrquota"},
> -	{Opt_reservation, "reservation"},
> -	{Opt_noreservation, "noreservation"},
> -	{Opt_err, NULL}
> +#define EXT2_SPEC_s_resuid                      (1 << 0)
> +#define EXT2_SPEC_s_resgid                      (1 << 1)
> +
> +struct ext2_fs_context {
> +	unsigned long	vals_s_flags;	/* Bits to set in s_flags */
> +	unsigned long	mask_s_flags;	/* Bits changed in s_flags */
> +	unsigned int	vals_s_mount_opt;
> +	unsigned int	mask_s_mount_opt;
> +	kuid_t		s_resuid;
> +	kgid_t		s_resgid;
> +	unsigned long	s_sb_block;
> +	unsigned int	spec;
> +
>  };
>  
> -static int parse_options(char *options, struct super_block *sb,
> -			 struct ext2_mount_options *opts)
> +static inline void ctx_set_mount_opt(struct ext2_fs_context *ctx,
> +				  unsigned long flag)
> +{
> +	ctx->mask_s_mount_opt |= flag;
> +	ctx->vals_s_mount_opt |= flag;
> +}
> +
> +static inline void ctx_clear_mount_opt(struct ext2_fs_context *ctx,
> +				    unsigned long flag)
> +{
> +	ctx->mask_s_mount_opt |= flag;
> +	ctx->vals_s_mount_opt &= ~flag;
> +}
> +
> +static inline unsigned long
> +ctx_test_mount_opt(struct ext2_fs_context *ctx, unsigned long flag)
> +{
> +	return (ctx->vals_s_mount_opt & flag);
> +}
> +
> +static inline bool
> +ctx_parsed_mount_opt(struct ext2_fs_context *ctx, unsigned long flag)
> +{
> +	return (ctx->mask_s_mount_opt & flag);
> +}
> +
> +static void ext2_free_fc(struct fs_context *fc)
>  {
> -	char *p;
> -	substring_t args[MAX_OPT_ARGS];
> -	int option;
> -	kuid_t uid;
> -	kgid_t gid;
> -
> -	if (!options)
> -		return 1;
> -
> -	while ((p = strsep (&options, ",")) != NULL) {
> -		int token;
> -		if (!*p)
> -			continue;
> -
> -		token = match_token(p, tokens, args);
> -		switch (token) {
> -		case Opt_bsd_df:
> -			clear_opt (opts->s_mount_opt, MINIX_DF);
> -			break;
> -		case Opt_minix_df:
> -			set_opt (opts->s_mount_opt, MINIX_DF);
> -			break;
> -		case Opt_grpid:
> -			set_opt (opts->s_mount_opt, GRPID);
> -			break;
> -		case Opt_nogrpid:
> -			clear_opt (opts->s_mount_opt, GRPID);
> -			break;
> -		case Opt_resuid:
> -			if (match_int(&args[0], &option))
> -				return 0;
> -			uid = make_kuid(current_user_ns(), option);
> -			if (!uid_valid(uid)) {
> -				ext2_msg(sb, KERN_ERR, "Invalid uid value %d", option);
> -				return 0;
> -
> -			}
> -			opts->s_resuid = uid;
> -			break;
> -		case Opt_resgid:
> -			if (match_int(&args[0], &option))
> -				return 0;
> -			gid = make_kgid(current_user_ns(), option);
> -			if (!gid_valid(gid)) {
> -				ext2_msg(sb, KERN_ERR, "Invalid gid value %d", option);
> -				return 0;
> -			}
> -			opts->s_resgid = gid;
> -			break;
> -		case Opt_sb:
> -			/* handled by get_sb_block() instead of here */
> -			/* *sb_block = match_int(&args[0]); */
> -			break;
> -		case Opt_err_panic:
> -			clear_opt (opts->s_mount_opt, ERRORS_CONT);
> -			clear_opt (opts->s_mount_opt, ERRORS_RO);
> -			set_opt (opts->s_mount_opt, ERRORS_PANIC);
> -			break;
> -		case Opt_err_ro:
> -			clear_opt (opts->s_mount_opt, ERRORS_CONT);
> -			clear_opt (opts->s_mount_opt, ERRORS_PANIC);
> -			set_opt (opts->s_mount_opt, ERRORS_RO);
> -			break;
> -		case Opt_err_cont:
> -			clear_opt (opts->s_mount_opt, ERRORS_RO);
> -			clear_opt (opts->s_mount_opt, ERRORS_PANIC);
> -			set_opt (opts->s_mount_opt, ERRORS_CONT);
> -			break;
> -		case Opt_nouid32:
> -			set_opt (opts->s_mount_opt, NO_UID32);
> -			break;
> -		case Opt_debug:
> -			set_opt (opts->s_mount_opt, DEBUG);
> -			break;
> -		case Opt_oldalloc:
> -			set_opt (opts->s_mount_opt, OLDALLOC);
> -			break;
> -		case Opt_orlov:
> -			clear_opt (opts->s_mount_opt, OLDALLOC);
> -			break;
> -		case Opt_nobh:
> -			ext2_msg(sb, KERN_INFO,
> -				"nobh option not supported");
> -			break;
> +	kfree(fc->fs_private);
> +}
> +
> +static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct ext2_fs_context *ctx = fc->fs_private;
> +	int opt;
> +	struct fs_parse_result result;
> +
> +	opt = fs_parse(fc, ext2_param_spec, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_bsd_df:
> +		ctx_clear_mount_opt(ctx, EXT2_MOUNT_MINIX_DF);
> +		break;
> +	case Opt_minix_df:
> +		ctx_set_mount_opt(ctx, EXT2_MOUNT_MINIX_DF);
> +		break;
> +	case Opt_grpid:
> +		ctx_set_mount_opt(ctx, EXT2_MOUNT_GRPID);
> +		break;
> +	case Opt_nogrpid:
> +		ctx_clear_mount_opt(ctx, EXT2_MOUNT_GRPID);
> +		break;
> +	case Opt_resuid:
> +		ctx->s_resuid = result.uid;
> +		ctx->spec |= EXT2_SPEC_s_resuid;
> +		break;
> +	case Opt_resgid:
> +		ctx->s_resgid = result.gid;
> +		ctx->spec |= EXT2_SPEC_s_resgid;
> +		break;
> +	case Opt_sb:
> +		/* Note that this is silently ignored on remount */
> +		ctx->s_sb_block = result.uint_32;
> +		break;
> +	case Opt_errors:
> +		ctx_clear_mount_opt(ctx, EXT2_MOUNT_ERRORS_MASK);
> +		ctx_set_mount_opt(ctx, result.uint_32);
> +		break;
> +	case Opt_nouid32:
> +		ctx_set_mount_opt(ctx, EXT2_MOUNT_NO_UID32);
> +		break;
> +	case Opt_debug:
> +		ctx_set_mount_opt(ctx, EXT2_MOUNT_DEBUG);
> +		break;
> +	case Opt_oldalloc:
> +		ctx_set_mount_opt(ctx, EXT2_MOUNT_OLDALLOC);
> +		break;
> +	case Opt_orlov:
> +		ctx_clear_mount_opt(ctx, EXT2_MOUNT_OLDALLOC);
> +		break;
> +	case Opt_nobh:
> +		ext2_msg(NULL, KERN_INFO, "nobh option not supported\n");
> +		break;
>  #ifdef CONFIG_EXT2_FS_XATTR
> -		case Opt_user_xattr:
> -			set_opt (opts->s_mount_opt, XATTR_USER);
> -			break;
> -		case Opt_nouser_xattr:
> -			clear_opt (opts->s_mount_opt, XATTR_USER);
> -			break;
> +	case Opt_user_xattr:
> +		if (!result.negated)
> +			ctx_set_mount_opt(ctx, EXT2_MOUNT_XATTR_USER);
> +		else
> +			ctx_clear_mount_opt(ctx, EXT2_MOUNT_XATTR_USER);
> +		break;
>  #else
> -		case Opt_user_xattr:
> -		case Opt_nouser_xattr:
> -			ext2_msg(sb, KERN_INFO, "(no)user_xattr options"
> -				"not supported");
> -			break;
> +	case Opt_user_xattr:
> +		ext2_msg(NULL, KERN_INFO, "(no)user_xattr options not supported");
> +		break;
>  #endif
>  #ifdef CONFIG_EXT2_FS_POSIX_ACL
> -		case Opt_acl:
> -			set_opt(opts->s_mount_opt, POSIX_ACL);
> -			break;
> -		case Opt_noacl:
> -			clear_opt(opts->s_mount_opt, POSIX_ACL);
> -			break;
> +	case Opt_acl:
> +		if (!result.negated)
> +			ctx_set_mount_opt(ctx, EXT2_MOUNT_POSIX_ACL);
> +		else
> +			ctx_clear_mount_opt(ctx, EXT2_MOUNT_POSIX_ACL);
> +		break;
>  #else
> -		case Opt_acl:
> -		case Opt_noacl:
> -			ext2_msg(sb, KERN_INFO,
> -				"(no)acl options not supported");
> -			break;
> +	case Opt_acl:
> +		ext2_msg(NULL, KERN_INFO, "(no)acl options not supported");
> +		break;
>  #endif
> -		case Opt_xip:
> -			ext2_msg(sb, KERN_INFO, "use dax instead of xip");
> -			set_opt(opts->s_mount_opt, XIP);
> -			fallthrough;
> -		case Opt_dax:
> +	case Opt_xip:
> +		ext2_msg(NULL, KERN_INFO, "use dax instead of xip");
> +		ctx_set_mount_opt(ctx, EXT2_MOUNT_XIP);
> +		fallthrough;
> +	case Opt_dax:
>  #ifdef CONFIG_FS_DAX
> -			ext2_msg(sb, KERN_WARNING,
> -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> -			set_opt(opts->s_mount_opt, DAX);
> +		ext2_msg(NULL, KERN_WARNING,
> +		    "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> +		ctx_set_mount_opt(ctx, EXT2_MOUNT_DAX);
>  #else
> -			ext2_msg(sb, KERN_INFO, "dax option not supported");
> +		ext2_msg(NULL, KERN_INFO, "dax option not supported");
>  #endif
> -			break;
> +		break;
>  
>  #if defined(CONFIG_QUOTA)
> -		case Opt_quota:
> -		case Opt_usrquota:
> -			set_opt(opts->s_mount_opt, USRQUOTA);
> -			break;
> -
> -		case Opt_grpquota:
> -			set_opt(opts->s_mount_opt, GRPQUOTA);
> -			break;
> +	case Opt_quota:
> +	case Opt_usrquota:
> +		ctx_set_mount_opt(ctx, EXT2_MOUNT_USRQUOTA);
> +		break;
> +
> +	case Opt_grpquota:
> +		ctx_set_mount_opt(ctx, EXT2_MOUNT_GRPQUOTA);
> +		break;
>  #else
> -		case Opt_quota:
> -		case Opt_usrquota:
> -		case Opt_grpquota:
> -			ext2_msg(sb, KERN_INFO,
> -				"quota operations not supported");
> -			break;
> +	case Opt_quota:
> +	case Opt_usrquota:
> +	case Opt_grpquota:
> +		ext2_msg(NULL, KERN_INFO, "quota operations not supported");
> +		break;
>  #endif
> -
> -		case Opt_reservation:
> -			set_opt(opts->s_mount_opt, RESERVATION);
> -			ext2_msg(sb, KERN_INFO, "reservations ON");
> -			break;
> -		case Opt_noreservation:
> -			clear_opt(opts->s_mount_opt, RESERVATION);
> -			ext2_msg(sb, KERN_INFO, "reservations OFF");
> -			break;
> -		case Opt_ignore:
> -			break;
> -		default:
> -			return 0;
> +	case Opt_reservation:
> +		if (!result.negated) {
> +			ctx_set_mount_opt(ctx, EXT2_MOUNT_RESERVATION);
> +			ext2_msg(NULL, KERN_INFO, "reservations ON");
> +		} else {
> +			ctx_clear_mount_opt(ctx, EXT2_MOUNT_RESERVATION);
> +			ext2_msg(NULL, KERN_INFO, "reservations OFF");
>  		}
> +		break;
> +	case Opt_ignore:
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
> -	return 1;
> +	return 0;
>  }
>  
>  static int ext2_setup_super (struct super_block * sb,
> @@ -801,24 +790,83 @@ static unsigned long descriptor_loc(struct super_block *sb,
>  	return ext2_group_first_block_no(sb, bg) + ext2_bg_has_super(sb, bg);
>  }
>  
> -static int ext2_fill_super(struct super_block *sb, void *data, int silent)
> +/*
> + * Set all mount options either from defaults on disk, or from parsed
> + * options. Parsed/specified options override on-disk defaults.
> + */
> +static void ext2_set_options(struct fs_context *fc, struct ext2_sb_info *sbi)
>  {
> +	struct ext2_fs_context *ctx = fc->fs_private;
> +	struct ext2_super_block *es = sbi->s_es;
> +	unsigned long def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
> +
> +	/* Copy parsed mount options to sbi */
> +	sbi->s_mount_opt = ctx->vals_s_mount_opt;
> +
> +	/* Use in-superblock defaults only if not specified during parsing */
> +	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_DEBUG) &&
> +	    def_mount_opts & EXT2_DEFM_DEBUG)
> +		set_opt(sbi->s_mount_opt, DEBUG);
> +
> +	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_GRPID) &&
> +	    def_mount_opts & EXT2_DEFM_BSDGROUPS)
> +		set_opt(sbi->s_mount_opt, GRPID);
> +
> +	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_NO_UID32) &&
> +	    def_mount_opts & EXT2_DEFM_UID16)
> +		set_opt(sbi->s_mount_opt, NO_UID32);
> +
> +#ifdef CONFIG_EXT2_FS_XATTR
> +	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_XATTR_USER) &&
> +	    def_mount_opts & EXT2_DEFM_XATTR_USER)
> +		set_opt(sbi->s_mount_opt, XATTR_USER);
> +#endif
> +#ifdef CONFIG_EXT2_FS_POSIX_ACL
> +	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_POSIX_ACL) &&
> +	    def_mount_opts & EXT2_DEFM_ACL)
> +		set_opt(sbi->s_mount_opt, POSIX_ACL);
> +#endif
> +
> +	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_ERRORS_MASK)) {
> +		if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_PANIC)
> +			set_opt(sbi->s_mount_opt, ERRORS_PANIC);
> +		else if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_CONTINUE)
> +			set_opt(sbi->s_mount_opt, ERRORS_CONT);
> +		else
> +			set_opt(sbi->s_mount_opt, ERRORS_RO);
> +	}
> +
> +	if (ctx->spec & EXT2_SPEC_s_resuid)
> +		sbi->s_resuid = ctx->s_resuid;
> +	else
> +		sbi->s_resuid = make_kuid(&init_user_ns,
> +					   le16_to_cpu(es->s_def_resuid));
> +
> +	if (ctx->spec & EXT2_SPEC_s_resgid)
> +		sbi->s_resgid = ctx->s_resgid;
> +	else
> +		sbi->s_resgid = make_kgid(&init_user_ns,
> +					   le16_to_cpu(es->s_def_resgid));
> +}
> +
> +static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	struct ext2_fs_context *ctx = fc->fs_private;
> +	int silent = fc->sb_flags & SB_SILENT;
>  	struct buffer_head * bh;
>  	struct ext2_sb_info * sbi;
>  	struct ext2_super_block * es;
>  	struct inode *root;
>  	unsigned long block;
> -	unsigned long sb_block = get_sb_block(&data);
> +	unsigned long sb_block = ctx->s_sb_block;
>  	unsigned long logic_sb_block;
>  	unsigned long offset = 0;
> -	unsigned long def_mount_opts;
>  	long ret = -ENOMEM;
>  	int blocksize = BLOCK_SIZE;
>  	int db_count;
>  	int i, j;
>  	__le32 features;
>  	int err;
> -	struct ext2_mount_options opts;
>  
>  	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>  	if (!sbi)
> @@ -877,42 +925,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	if (sb->s_magic != EXT2_SUPER_MAGIC)
>  		goto cantfind_ext2;
>  
> -	opts.s_mount_opt = 0;
> -	/* Set defaults before we parse the mount options */
> -	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
> -	if (def_mount_opts & EXT2_DEFM_DEBUG)
> -		set_opt(opts.s_mount_opt, DEBUG);
> -	if (def_mount_opts & EXT2_DEFM_BSDGROUPS)
> -		set_opt(opts.s_mount_opt, GRPID);
> -	if (def_mount_opts & EXT2_DEFM_UID16)
> -		set_opt(opts.s_mount_opt, NO_UID32);
> -#ifdef CONFIG_EXT2_FS_XATTR
> -	if (def_mount_opts & EXT2_DEFM_XATTR_USER)
> -		set_opt(opts.s_mount_opt, XATTR_USER);
> -#endif
> -#ifdef CONFIG_EXT2_FS_POSIX_ACL
> -	if (def_mount_opts & EXT2_DEFM_ACL)
> -		set_opt(opts.s_mount_opt, POSIX_ACL);
> -#endif
> -	
> -	if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_PANIC)
> -		set_opt(opts.s_mount_opt, ERRORS_PANIC);
> -	else if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_CONTINUE)
> -		set_opt(opts.s_mount_opt, ERRORS_CONT);
> -	else
> -		set_opt(opts.s_mount_opt, ERRORS_RO);
> -
> -	opts.s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
> -	opts.s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
> -	
> -	set_opt(opts.s_mount_opt, RESERVATION);
> -
> -	if (!parse_options((char *) data, sb, &opts))
> -		goto failed_mount;
> -
> -	sbi->s_mount_opt = opts.s_mount_opt;
> -	sbi->s_resuid = opts.s_resuid;
> -	sbi->s_resgid = opts.s_resgid;
> +	ext2_set_options(fc, sbi);
>  
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
> @@ -1324,23 +1337,21 @@ static void ext2_write_super(struct super_block *sb)
>  		ext2_sync_fs(sb, 1);
>  }
>  
> -static int ext2_remount (struct super_block * sb, int * flags, char * data)
> +static int ext2_reconfigure(struct fs_context *fc)
>  {
> +	struct ext2_fs_context *ctx = fc->fs_private;
> +	struct super_block *sb = fc->root->d_sb;
>  	struct ext2_sb_info * sbi = EXT2_SB(sb);
>  	struct ext2_super_block * es;
>  	struct ext2_mount_options new_opts;
> +	int flags = fc->sb_flags;
>  	int err;
>  
>  	sync_filesystem(sb);
>  
> -	spin_lock(&sbi->s_lock);
> -	new_opts.s_mount_opt = sbi->s_mount_opt;
> -	new_opts.s_resuid = sbi->s_resuid;
> -	new_opts.s_resgid = sbi->s_resgid;
> -	spin_unlock(&sbi->s_lock);
> -
> -	if (!parse_options(data, sb, &new_opts))
> -		return -EINVAL;
> +	new_opts.s_mount_opt = ctx->vals_s_mount_opt;
> +	new_opts.s_resuid = ctx->s_resuid;
> +	new_opts.s_resgid = ctx->s_resgid;
>  
>  	spin_lock(&sbi->s_lock);
>  	es = sbi->s_es;
> @@ -1349,9 +1360,9 @@ static int ext2_remount (struct super_block * sb, int * flags, char * data)
>  			 "dax flag with busy inodes while remounting");
>  		new_opts.s_mount_opt ^= EXT2_MOUNT_DAX;
>  	}
> -	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
> +	if ((bool)(flags & SB_RDONLY) == sb_rdonly(sb))
>  		goto out_set;
> -	if (*flags & SB_RDONLY) {
> +	if (flags & SB_RDONLY) {
>  		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS ||
>  		    !(sbi->s_mount_state & EXT2_VALID_FS))
>  			goto out_set;
> @@ -1470,10 +1481,9 @@ static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf)
>  	return 0;
>  }
>  
> -static struct dentry *ext2_mount(struct file_system_type *fs_type,
> -	int flags, const char *dev_name, void *data)
> +static int ext2_get_tree(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
> +	return get_tree_bdev(fc, ext2_fill_super);
>  }
>  
>  #ifdef CONFIG_QUOTA
> @@ -1624,12 +1634,49 @@ static int ext2_quota_off(struct super_block *sb, int type)
>  
>  #endif
>  
> +static const struct fs_context_operations ext2_context_ops = {
> +	.parse_param	= ext2_parse_param,
> +	.get_tree	= ext2_get_tree,
> +	.reconfigure	= ext2_reconfigure,
> +	.free		= ext2_free_fc,
> +};
> +
> +static int ext2_init_fs_context(struct fs_context *fc)
> +{
> +	struct ext2_fs_context *ctx;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
> +		struct super_block *sb = fc->root->d_sb;
> +		struct ext2_sb_info *sbi = EXT2_SB(sb);
> +
> +		spin_lock(&sbi->s_lock);
> +		ctx->vals_s_mount_opt = sbi->s_mount_opt;
> +		ctx->vals_s_flags = sb->s_flags;
> +		ctx->s_resuid = sbi->s_resuid;
> +		ctx->s_resgid = sbi->s_resgid;
> +		spin_unlock(&sbi->s_lock);
> +	} else {
> +		ctx->s_sb_block = 1;
> +		ctx_set_mount_opt(ctx, EXT2_MOUNT_RESERVATION);
> +	}
> +
> +	fc->fs_private = ctx;
> +	fc->ops = &ext2_context_ops;
> +
> +	return 0;
> +}
> +
>  static struct file_system_type ext2_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "ext2",
> -	.mount		= ext2_mount,
>  	.kill_sb	= kill_block_super,
>  	.fs_flags	= FS_REQUIRES_DEV,
> +	.init_fs_context = ext2_init_fs_context,
> +	.parameters	= ext2_param_spec,
>  };
>  MODULE_ALIAS_FS("ext2");
>  
> -- 
> 2.48.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

