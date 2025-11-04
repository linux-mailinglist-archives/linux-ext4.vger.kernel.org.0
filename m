Return-Path: <linux-ext4+bounces-11441-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5262BC30F2A
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 13:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5F24237B0
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79432F39B7;
	Tue,  4 Nov 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jKqB0r84";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FC0oHVL3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dPhQDD6K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VgbjsyHg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75392F360A
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258443; cv=none; b=qrUtmIQqRIHtF5k5RYv02hVnAUK5FuElcBYVl4NvNRH5iiHf+KxtU0NrVyc7m2ovxMhei7hnZ6f3LdlJiEZ8kaga3tWvBN8VpxCHEBkowdVfxq+nPew4wcDUd/l3rJxfvmtFTGPC+o2n5fdECCZuYoD0l3dz5XJNmtyqiL1ZIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258443; c=relaxed/simple;
	bh=tAcoZy4oj3w+179fFvx0GB1P3rEhxC/3Ddbdavei1sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw2UxtaPF63yFDfjkSkRpu0IOcqetkrv794Q36JCESbocG6xwmFlitomiS8/aqlkTxK7lrvD4gC1iXEaf+JTJ6dOBbBn3QwHBM73TXe3KaBDK9yYj0PJzbqOC4yb5n7C51lACE3kS/l2GvZ6iuD5N+R4VSImaTJlcbXtniMbkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jKqB0r84; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FC0oHVL3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dPhQDD6K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VgbjsyHg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05E711F451;
	Tue,  4 Nov 2025 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762258440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L517dqg4zC4ueTOGdaUNqBUzNrp/dN+azzWPFGThJ4=;
	b=jKqB0r840XjaL3dTaBxaFpve8i27EAA2sluuR5SuTVLwdyZLHQlyapPWS7llR7Lyvutouo
	BYMkZwJF6+rNANa4Kh2h+prHPfYOxa37t3StaW9EgRXLGNAgPWZSbX/HFAU4AQy1Ds5z9r
	UhZXPcZrvnDhW9GWlyQR4nt7AbNMjqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762258440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L517dqg4zC4ueTOGdaUNqBUzNrp/dN+azzWPFGThJ4=;
	b=FC0oHVL3V3pLJ/rGKNpdE0c5lcI64gGPeeCeYDO12A/+TNC8L559IUzBILOHKP5kn4TkTw
	cn4jvrGY1syVZhBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762258439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L517dqg4zC4ueTOGdaUNqBUzNrp/dN+azzWPFGThJ4=;
	b=dPhQDD6K/TmYvYJLEg47ZaYojZHgXRl2xKd+NnU7nqgMvGH5qFVPFLL1/QJNMrJrToI3Rs
	AsjtxMOH92LlzEKGk5Ks0g6FennHR3qi66HQxNzfl8X8mk3y787aDKOx88U/fpRPh7czrA
	AZXLi+RTdHaznLj3Z49N9ELRjLq6wl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762258439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L517dqg4zC4ueTOGdaUNqBUzNrp/dN+azzWPFGThJ4=;
	b=VgbjsyHgSIf015H97Db/8UfA3g94K4C4AGgG2LkxPgj+YdIquY7rG6wfjtNZNMVlld8V9o
	NcsvCTTlxEbExdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF8A6136D1;
	Tue,  4 Nov 2025 12:13:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b4JyOgbuCWmEQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 12:13:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFC9AA28E6; Tue,  4 Nov 2025 13:13:58 +0100 (CET)
Date: Tue, 4 Nov 2025 13:13:58 +0100
From: Jan Kara <jack@suse.cz>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] ext4: clear i_state_flags when alloc inode
Message-ID: <a5du4tx2ugmhjwzwtkwcf2fk6jzj3athhheojitnxwcz222lxu@4ntqpbfjehgo>
References: <20251104-ext4-v1-1-73691a0800f9@nxp.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-ext4-v1-1-73691a0800f9@nxp.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 04-11-25 16:12:24, Haibo Chen wrote:
> i_state_flags used on 32-bit archs, need to clear this flag when
> alloc inode.
> Find this issue when umount ext4, sometimes track the inode as orphan
> accidently, cause ext4 mesg dump.
> 
> Fixes: acf943e9768e ("ext4: fix checks for orphan inodes")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ialloc.c | 1 -
>  fs/ext4/inode.c  | 1 -
>  fs/ext4/super.c  | 1 +
>  3 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index ba4fd9aba1c14de56b89ebbeb4597f7becf947ff..b20a1bf866abedf3a768ee8a147f108ea09ecb01 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1293,7 +1293,6 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		ei->i_csum_seed = ext4_chksum(csum, (__u8 *)&gen, sizeof(gen));
>  	}
>  
> -	ext4_clear_state_flags(ei); /* Only relevant on 32-bit archs */
>  	ext4_set_inode_state(inode, EXT4_STATE_NEW);
>  
>  	ei->i_extra_isize = sbi->s_want_extra_isize;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index a163c087137314c541ec10c011488c5392fb7011..bf6786d373ff57c32d5a84cfd73ea8a33cb68b16 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5285,7 +5285,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	ei->i_projid = make_kprojid(&init_user_ns, i_projid);
>  	set_nlink(inode, le16_to_cpu(raw_inode->i_links_count));
>  
> -	ext4_clear_state_flags(ei);	/* Only relevant on 32-bit archs */
>  	ei->i_inline_off = 0;
>  	ei->i_dir_start_lookup = 0;
>  	ei->i_dtime = le32_to_cpu(raw_inode->i_dtime);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 33e7c08c9529c357d291f40269863398753dc650..3dcc9410c09a55d5dce2dbff388a97bf4f133818 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1396,6 +1396,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  
>  	inode_set_iversion(&ei->vfs_inode, 1);
>  	ei->i_flags = 0;
> +	ext4_clear_state_flags(ei);	/* Only relevant on 32-bit archs */
>  	spin_lock_init(&ei->i_raw_lock);
>  	ei->i_prealloc_node = RB_ROOT;
>  	atomic_set(&ei->i_prealloc_active, 0);
> 
> ---
> base-commit: 9823120909776bbca58a3c55ef1f27d49283c1f3
> change-id: 20251104-ext4-3f9647dcedd0
> 
> Best regards,
> -- 
> Haibo Chen <haibo.chen@nxp.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

