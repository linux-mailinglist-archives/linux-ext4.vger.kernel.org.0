Return-Path: <linux-ext4+bounces-9232-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C86BB15DA9
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 11:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDF24E59C4
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56340291880;
	Wed, 30 Jul 2025 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fNd9zYpP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yO+QUXvs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fNd9zYpP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yO+QUXvs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7C230981
	for <linux-ext4@vger.kernel.org>; Wed, 30 Jul 2025 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869350; cv=none; b=RNlsRESU5at4NW2pgfCzfmNkmKIIY2QpC6ml+oOA3wquE+ejp1Yriaz39VIoNsh5assbesuaQNYfCQ9+1a80fzlDFpWonUqHO+4mS6o3dA24BXs96eeKafW42tkVziRFBL4A7k4rlOHyGEx2zTyf/C/Spdo7RnsWu7jt3WUgCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869350; c=relaxed/simple;
	bh=XTXxciGEVeAh7uLF/y5qLSEgG0iN/zk4R/cgpxYEcYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU5CWCZhKdeKNoIhfRc5F6M8bsLYmxZjvLsVuJsGTa/8E0tCLoWYW1epQDuwlCfkOO1mx0QcjdlsTSUKg7qvWIf10hg98ikNJZqMb34XhyR8L0GMNlQ8FZvQPqFLn9VL6srHVfsVlzrJlaj1pvJc2aWUuR2rOjlfW/KuqTxltdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fNd9zYpP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yO+QUXvs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fNd9zYpP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yO+QUXvs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 852C01F8D5;
	Wed, 30 Jul 2025 09:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753869346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4PFGiNz7H3oAIKcLDB2QM4lgpaFjNjpSnfL7WIyvjI=;
	b=fNd9zYpPgfxEr2mtcchdYo6zL2AtvALdC5j+ascWH2H2XkbG3jljJa+T7H2AR7dlSc1lLU
	KVeJEXea9/vM9uvm+gCYmLF5EDNWE4SW18v+46Yv8R37MpJ5pn/ePp/PTCqQ7wkQzRZauk
	JxgOACUkatF4Lfeoaa7gyqGN4eoU7kU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753869346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4PFGiNz7H3oAIKcLDB2QM4lgpaFjNjpSnfL7WIyvjI=;
	b=yO+QUXvsecudDLqM0r91DzRbJSVQqlCqR4K2LFaQbqgGoX5JpgO4t9g9xemvUg413HNNag
	fT3pK5OIFamILzCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753869346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4PFGiNz7H3oAIKcLDB2QM4lgpaFjNjpSnfL7WIyvjI=;
	b=fNd9zYpPgfxEr2mtcchdYo6zL2AtvALdC5j+ascWH2H2XkbG3jljJa+T7H2AR7dlSc1lLU
	KVeJEXea9/vM9uvm+gCYmLF5EDNWE4SW18v+46Yv8R37MpJ5pn/ePp/PTCqQ7wkQzRZauk
	JxgOACUkatF4Lfeoaa7gyqGN4eoU7kU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753869346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4PFGiNz7H3oAIKcLDB2QM4lgpaFjNjpSnfL7WIyvjI=;
	b=yO+QUXvsecudDLqM0r91DzRbJSVQqlCqR4K2LFaQbqgGoX5JpgO4t9g9xemvUg413HNNag
	fT3pK5OIFamILzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75E5C13942;
	Wed, 30 Jul 2025 09:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BI0zHCLsiWi0cgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Jul 2025 09:55:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F0BE3A09FB; Wed, 30 Jul 2025 11:55:41 +0200 (CEST)
Date: Wed, 30 Jul 2025 11:55:41 +0200
From: Jan Kara <jack@suse.cz>
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: prevent module unload while filesystem is in use
Message-ID: <g6cbleoltydfxhdcuttckw7ntiqvwilqnbxegvec7eqtnqauje@e3h36x2lsj45>
References: <20250724153044.149890-1-kevinpaul468@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724153044.149890-1-kevinpaul468@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 24-07-25 21:00:44, Kevin Paul Reddy Janagari wrote:
> preventing attempt to unload the ext4 module while the fs is still actively
> mounted by adding a check before exit
> 
> The crash occurs because ext4_inode_cache still contain objects
> in use when kmem_cache_destroy is called
> 
> This is a log of the bug produced by crepro given by a local syzkaller
> 
> [  301.647795] BUG ext4_inode_cache (Tainted: G  R                ): Objects remaining on __kmem_cache_shutdown()
> [  301.652120] -----------------------------------------------------------
> [  301.652120] 
> [  301.653366] Object 0xffff88800ec88008 @offset=8
> [  301.653877] Allocated in ext4_alloc_inode+0x27/0x1a0 [ext4] age=46055 cpu=0 pid=616
> [  301.655766]  ext4_alloc_inode+0x27/0x1a0 [ext4]
> [  301.657063]  alloc_inode+0x2b/0x120
> [  301.657570]  iget_locked+0x1ae/0x3e0
> [  301.658137]  __ext4_iget+0x243/0x1af0 [ext4]
> [  301.659197]  ext4_lookup+0x1b5/0x3e0 [ext4]
> [  301.660784]  __lookup_slow+0xd1/0x1f0
> [  301.661575]  walk_component+0x1a7/0x250
> [  301.662411]  path_lookupat+0x9a/0x2f0
> [  301.663179]  filename_lookup+0x14e/0x2e0
> [  301.663947]  vfs_statx+0xb9/0x240
> [  301.664622]  __do_sys_newstat+0x62/0xd0
> [  301.665376]  do_syscall_64+0x80/0x2c0
> [  301.666091]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Was not able to reproduce on my host system
> Tested in a Qemu instance
> 
> Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>

This is definitely wrong. VFS calls get_filesystem() (to acquire module
refcount) when mounting the filesystem (in sget_fc() or sget() depending on
whether the filesystem has been converted to the new mount API or not).
This prevents module removal so there must have been something else that
broke this protection mechanism in the syzbot reproducer you have and we
need to figure out what *that* was.

								Honza

> ---
>  fs/ext4/super.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c7d39da7e733..c6c77369a252 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -7480,8 +7480,24 @@ static int __init ext4_init_fs(void)
>  	return err;
>  }
>  
> +static void ext4_busy_check(struct super_block *sb, void *data)
> +{
> +	int *is_busy = data;
> +	*is_busy = 1;
> +}
> +
>  static void __exit ext4_exit_fs(void)
>  {
> +
> +	int is_busy = 0;
> +
> +	iterate_supers_type(&ext4_fs_type, ext4_busy_check, &is_busy);
> +
> +	if (is_busy) {
> +		pr_warn("ext4: Cannot unload module, filesystem is still in use.\n");
> +		return;
> +	}
> +
>  	ext4_destroy_lazyinit_thread();
>  	unregister_as_ext2();
>  	unregister_as_ext3();
> -- 
> 2.39.5
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

