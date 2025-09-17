Return-Path: <linux-ext4+bounces-10234-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A0DB80EBE
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 18:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0E07A1C37
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE61C2FCC02;
	Wed, 17 Sep 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="048+C0cM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4NuMkM+j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S8cKG8Q4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="juVb8VPY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA9E217733
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125424; cv=none; b=FkI9tDwiexqgTDqXG+yKSe8UHGBzPtqgJLO0lKAyL5usQ6+gagMLYj9Z8fffogrKCl2zOkegBn8zgCGJL4ScVn9HHgENZEPOpciT5f6T/9q9RqNHPrfPyArfIB8QyrTfFyWeAgBB113TuNU5hhqscpp3O1iImpJxi7j2cWCXuEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125424; c=relaxed/simple;
	bh=uNMZYc4ugcKjNMUlIc50dxcUEApkAV+BVpVo9TBRPhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMvssihTUAu03LonHjXJdMbEkTsG7/2+m7i5nylAnmoSQYdGXPeHPdNNkSjSFmnXFzGAWNfcnSTFveZgcg0PpLoqrJphyf0LcyqHFrw7vyTk1XvlWmReNOsQAzCZDCG7PUpPrEktFtrP8wgAwb3KhB5AYDLgHSOf4PTQxCUuf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=048+C0cM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4NuMkM+j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S8cKG8Q4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=juVb8VPY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBCE9224E8;
	Wed, 17 Sep 2025 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758125419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKnmkVCV3EZ/XZBw8q8j95dELfBXO7AieYsYTYHNZA0=;
	b=048+C0cMCEIWsWE3IWnjemwA08Mdt+p6jGqwNoWHMAhzArdmhdqNz7KVj5rKVeCAqNeikj
	bBAa6k8fzqWaPoJrTatlcSdaJpJcwTz8XaJkFMXNSpxlzR+D8k4TxGseDK9EMHXw7fFhzh
	xXjqOwQ5ceqHM7blkbOJG9iORiyAoBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758125419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKnmkVCV3EZ/XZBw8q8j95dELfBXO7AieYsYTYHNZA0=;
	b=4NuMkM+j5MbdGPt7Q1aXXvpE7pPH8uToX0UVSQSutAMG+ITpsgTEUDfKxPa9LDivzdsUFP
	hCingSpmJ9g3WoCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=S8cKG8Q4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=juVb8VPY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758125418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKnmkVCV3EZ/XZBw8q8j95dELfBXO7AieYsYTYHNZA0=;
	b=S8cKG8Q4kBSXNzregQ9pHF9jnXmg+NnUpf3WxTcnUSzvARtsleDW7AromEZrQuVF9KLOmB
	UvxgdLQpcfr9R7Z/bc5SjTHAseU8XDaSBbfRQm1fy7Mn12WY6BlRFSYcZ45GYSJopx881n
	eCkU/lZkhcmTAmlKzzV1sma+WnwCaXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758125418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKnmkVCV3EZ/XZBw8q8j95dELfBXO7AieYsYTYHNZA0=;
	b=juVb8VPY4mfhkneV1Xm8pIVErSWf+1B7oFsP5+oyf3Ks852pemOqEM3vcEQKx97edisQo0
	PGc0/CelD+Fh9kBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFA6C137C3;
	Wed, 17 Sep 2025 16:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ax7LLmrdymguLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 16:10:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 818E1A083B; Wed, 17 Sep 2025 18:10:14 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:10:14 +0200
From: Jan Kara <jack@suse.cz>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ext4: add support for 32-bit default reserved uid
 and gid values
Message-ID: <qer3kr5vjietsze72b47gdw5bk3vkb5phulmpzz3pthpgvf3vu@xwvih5oy2ixe>
References: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
 <20250916-tune2fs-v2-2-d594dc7486f0@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-tune2fs-v2-2-d594dc7486f0@mit.edu>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CBCE9224E8
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 16-09-25 23:22:48, Theodore Ts'o via B4 Relay wrote:
> From: Theodore Ts'o <tytso@mit.edu>
> 
> Support for specifying the default user id and group id that is
> allowed to use the reserved block space was added way back when Linux
> only supported 16-bit uid's and gid's.  (Yeah, that long ago.)  It's
> not a commonly used feature, but let's add support for 32-bit user and
> group id's.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/ext4.h  | 16 +++++++++++++++-
>  fs/ext4/super.c |  8 ++++----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 01a6e2de7fc3ef0e20b039d3200b9c9bd656f59f..4bfcd5f0c74fda30db4009ee28fbee00a2f6b76f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1442,7 +1442,9 @@ struct ext4_super_block {
>  	__le16  s_encoding;		/* Filename charset encoding */
>  	__le16  s_encoding_flags;	/* Filename charset encoding flags */
>  	__le32  s_orphan_file_inum;	/* Inode for tracking orphan inodes */
> -	__le32	s_reserved[94];		/* Padding to the end of the block */
> +	__le16	s_def_resuid_hi;
> +	__le16	s_def_resgid_hi;
> +	__le32	s_reserved[93];		/* Padding to the end of the block */
>  	__le32	s_checksum;		/* crc32c(superblock) */
>  };
>  
> @@ -1812,6 +1814,18 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
>  		 ino <= le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count));
>  }
>  
> +static inline int ext4_get_resuid(struct ext4_super_block *es)
> +{
> +	return(le16_to_cpu(es->s_def_resuid) |
> +	       (le16_to_cpu(es->s_def_resuid_hi) << 16));
> +}

I'd prefer a style like:

	return le16_to_cpu(es->s_def_resuid) |
	       (le16_to_cpu(es->s_def_resuid_hi) << 16);

but whatever...

> @@ -5270,8 +5270,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	ext4_set_def_opts(sb, es);
>  
> -	sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
> -	sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
> +	sbi->s_resuid = make_kuid(&init_user_ns, ext4_get_resuid(es));
> +	sbi->s_resgid = make_kgid(&init_user_ns, ext4_get_resuid(es));
						^^^^ ext4_get_resgid() here.

>  	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
>  	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
>  	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

