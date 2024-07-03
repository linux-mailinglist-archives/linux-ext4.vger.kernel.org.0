Return-Path: <linux-ext4+bounces-3102-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075F9256F5
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2024 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545901C232B8
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2024 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2613D60F;
	Wed,  3 Jul 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TJIU7Oxp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NM8Gf7Qm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TJIU7Oxp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NM8Gf7Qm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8167D42A80;
	Wed,  3 Jul 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999393; cv=none; b=YZGf6yarKwysSV4T4ReKWtC6J0eU7wQ6mgRyLqfq1jtg6l1sKcuodCK486F8Q9fLf4azuCoJV1a/uaEvuqPMBuWN5WH912v//b/v2q4dbAHGppTzn+5nlpxwyqALpEIiJbmNMVGaXojDBoDJtgoHbQEJ+uYBQNvwyC1fF0R+ohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999393; c=relaxed/simple;
	bh=+Jz+X/tSnZUB2y+eECrqNMH2FT3yrdCKHvGBxxA5DxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azFg65C0pGSNzxi8diTNPEfZzhgj8x8ZYoU0OhOxOtF9nlFiWXpwCESRb2K5K46BjHXp3Smq4HrNNaitNgQOI7LppAxF+sDWhP5XaESx+Bk0rF8btG75dA1QlRA22UiiB2oARZZrtlmxNc27dydAsU8V8wrTAu/sh3SlZxer+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TJIU7Oxp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NM8Gf7Qm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TJIU7Oxp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NM8Gf7Qm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71EC51F747;
	Wed,  3 Jul 2024 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719999389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODDMJ5syjKC3m2Ep3RdDH/u/12tFlatinKlaGEJi1YY=;
	b=TJIU7OxpI5SYgftyTpfk0vSgGDmeqcx3AVDIjO86t7jXERT6a//U32FfO30r9o4OPaxoA0
	QtbaHp/vb8i+6a5Pfz3ibBKylN6FL8MaEFHrFE4A5kXzf6FuUFxPnSTsULlEpKk+F1MOho
	xBCzm0vKP0YZVso6wEysxpe39/vaJaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719999389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODDMJ5syjKC3m2Ep3RdDH/u/12tFlatinKlaGEJi1YY=;
	b=NM8Gf7Qmz4NwASdeQDOSeiYtFNpR8ThDSo2qmQY1a4GuKfwGa1Sh0uZPolKmUS6/21RalM
	uHaOGcH49yAldECA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TJIU7Oxp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NM8Gf7Qm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719999389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODDMJ5syjKC3m2Ep3RdDH/u/12tFlatinKlaGEJi1YY=;
	b=TJIU7OxpI5SYgftyTpfk0vSgGDmeqcx3AVDIjO86t7jXERT6a//U32FfO30r9o4OPaxoA0
	QtbaHp/vb8i+6a5Pfz3ibBKylN6FL8MaEFHrFE4A5kXzf6FuUFxPnSTsULlEpKk+F1MOho
	xBCzm0vKP0YZVso6wEysxpe39/vaJaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719999389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODDMJ5syjKC3m2Ep3RdDH/u/12tFlatinKlaGEJi1YY=;
	b=NM8Gf7Qmz4NwASdeQDOSeiYtFNpR8ThDSo2qmQY1a4GuKfwGa1Sh0uZPolKmUS6/21RalM
	uHaOGcH49yAldECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 626D913974;
	Wed,  3 Jul 2024 09:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KfICGJ0bhWaBWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jul 2024 09:36:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 17E43A08A9; Wed,  3 Jul 2024 11:36:29 +0200 (CEST)
Date: Wed, 3 Jul 2024 11:36:29 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>,
	syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com,
	stable@kernel.org
Subject: Re: [PATCH 2/2] ext4: make sure the first directory block is not a
 hole
Message-ID: <20240703093629.bm32twullwiqmkmp@quack3>
References: <20240702132349.2600605-1-libaokun@huaweicloud.com>
 <20240702132349.2600605-3-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702132349.2600605-3-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[ae688d469e36fb5138d0];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com,syzkaller.appspotmail.com,kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,syzkaller.appspot.com:url,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huaweicloud.com:email,appspotmail.com:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 71EC51F747
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Tue 02-07-24 21:23:49, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The syzbot constructs a directory that has no dirblock but is non-inline,
> i.e. the first directory block is a hole. And no errors are reported when
> creating files in this directory in the following flow.
> 
>     ext4_mknod
>      ...
>       ext4_add_entry
>         // Read block 0
>         ext4_read_dirblock(dir, block, DIRENT)
>           bh = ext4_bread(NULL, inode, block, 0)
>           if (!bh && (type == INDEX || type == DIRENT_HTREE))
>           // The first directory block is a hole
>           // But type == DIRENT, so no error is reported.
> 
> After that, we get a directory block without '.' and '..' but with a valid
> dentry. This may cause some code that relies on dot or dotdot (such as
> make_indexed_dir()) to crash.
> 
> Therefore when ext4_read_dirblock() finds that the first directory block
> is a hole report that the filesystem is corrupted and return an error to
> avoid loading corrupted data from disk causing something bad.
> 
> Reported-by: syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ae688d469e36fb5138d0
> Fixes: 4e19d6b65fb4 ("ext4: allow directory holes")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 35881e3dd880..6a95713f9193 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -151,10 +151,11 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
>  
>  		return bh;
>  	}
> -	if (!bh && (type == INDEX || type == DIRENT_HTREE)) {
> +	/* The first directory block must not be a hole. */
> +	if (!bh && (type == INDEX || type == DIRENT_HTREE || block == 0)) {
>  		ext4_error_inode(inode, func, line, block,
> -				 "Directory hole found for htree %s block",
> -				 (type == INDEX) ? "index" : "leaf");
> +				 "Directory hole found for htree %s block %u",
> +				 (type == INDEX) ? "index" : "leaf", block);
>  		return ERR_PTR(-EFSCORRUPTED);
>  	}
>  	if (!bh)
> @@ -3084,10 +3085,7 @@ bool ext4_empty_dir(struct inode *inode)
>  		EXT4_ERROR_INODE(inode, "invalid size");
>  		return false;
>  	}
> -	/* The first directory block must not be a hole,
> -	 * so treat it as DIRENT_HTREE
> -	 */
> -	bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
> +	bh = ext4_read_dirblock(inode, 0, EITHER);
>  	if (IS_ERR(bh))
>  		return false;
>  
> @@ -3529,10 +3527,7 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
>  		struct ext4_dir_entry_2 *de;
>  		unsigned int offset;
>  
> -		/* The first directory block must not be a hole, so
> -		 * treat it as DIRENT_HTREE
> -		 */
> -		bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
> +		bh = ext4_read_dirblock(inode, 0, EITHER);
>  		if (IS_ERR(bh)) {
>  			*retval = PTR_ERR(bh);
>  			return NULL;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

