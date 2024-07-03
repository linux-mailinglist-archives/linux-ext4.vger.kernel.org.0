Return-Path: <linux-ext4+bounces-3101-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334B9256CC
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2024 11:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41D428BA4F
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2024 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91C13D602;
	Wed,  3 Jul 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="viXDdSoJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QlnNxEpZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="viXDdSoJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QlnNxEpZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BBBC8C0;
	Wed,  3 Jul 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998997; cv=none; b=JXYxuLvj244aX1aNlw7ndVT3gJR0vj41cy2gzmDT3w/0H9QfmzcQV+lvrE0sQYTZ/pQYJKJghZelrtJMysNBRR+5ECtxBsZpHiGIS/qOnCpghMAgGrwP7csqzw3OBqZHM7xeipIw1ZC5r8I6bvPap8wW+tZPitk9OiZqEC2etOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998997; c=relaxed/simple;
	bh=qXA/0XP0mErSdEsbkFeZbc5iGqHB95UjydhxaE87ZEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW00G7VVXeFxn3aWHPfvaHP1igR2uB1mqD0LAXkafPr5IaACKKwzf861RkpEPA5sN+ySosAtHE48xRlA9jeCV0lOX+KtoEt4RGNYtAz2+7hxam3aOkgBX5221rrWtXHTDNhES21NSb8hj9BGy+svRlSpixzWwWXnObmoJ0sBoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=viXDdSoJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QlnNxEpZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=viXDdSoJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QlnNxEpZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DA7C219B2;
	Wed,  3 Jul 2024 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719998993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qg8fh3E4O+gBZ3kQmrW77tAHA8+NQCdrYIWs4bWJwlM=;
	b=viXDdSoJiqYK7gDJfD5W4Ze7AfmYhmd9OaozC6pN+oibJobaYKs5V4hU6z4wqBtB3NX2ET
	7N8yJ3HpbaP8UxB0kEGg5ikBtHNITx+HB0z+qLUMjVKjXfEewheE972kvtGm8iBGlFEK19
	RlkRdCGYLvBeYrlKZEM66RQ5xRWdBNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719998993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qg8fh3E4O+gBZ3kQmrW77tAHA8+NQCdrYIWs4bWJwlM=;
	b=QlnNxEpZR6vXjpcp/ZwPhiVBmbh8Bjyi4EkIj5MWtDnEhLpC7zwtH372TP3Gozg9GOgGNG
	c/jGN70OKSfoYsCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=viXDdSoJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QlnNxEpZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719998993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qg8fh3E4O+gBZ3kQmrW77tAHA8+NQCdrYIWs4bWJwlM=;
	b=viXDdSoJiqYK7gDJfD5W4Ze7AfmYhmd9OaozC6pN+oibJobaYKs5V4hU6z4wqBtB3NX2ET
	7N8yJ3HpbaP8UxB0kEGg5ikBtHNITx+HB0z+qLUMjVKjXfEewheE972kvtGm8iBGlFEK19
	RlkRdCGYLvBeYrlKZEM66RQ5xRWdBNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719998993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qg8fh3E4O+gBZ3kQmrW77tAHA8+NQCdrYIWs4bWJwlM=;
	b=QlnNxEpZR6vXjpcp/ZwPhiVBmbh8Bjyi4EkIj5MWtDnEhLpC7zwtH372TP3Gozg9GOgGNG
	c/jGN70OKSfoYsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C7A013974;
	Wed,  3 Jul 2024 09:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H9lbHhEahWaIVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jul 2024 09:29:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2BB5CA08A9; Wed,  3 Jul 2024 11:29:53 +0200 (CEST)
Date: Wed, 3 Jul 2024 11:29:53 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>,
	syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com,
	stable@kernel.org
Subject: Re: [PATCH 1/2] ext4: check dot and dotdot of dx_root before making
 dir indexed
Message-ID: <20240703092953.j53in72xzn4vheca@quack3>
References: <20240702132349.2600605-1-libaokun@huaweicloud.com>
 <20240702132349.2600605-2-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702132349.2600605-2-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 8DA7C219B2
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[ae688d469e36fb5138d0];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com,syzkaller.appspotmail.com,kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,huawei.com:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 02-07-24 21:23:48, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Syzbot reports a issue as follows:
> ============================================
> BUG: unable to handle page fault for address: ffffed11022e24fe
> PGD 23ffee067 P4D 23ffee067 PUD 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 PID: 5079 Comm: syz-executor306 Not tainted 6.10.0-rc5-g55027e689933 #0
> Call Trace:
>  <TASK>
>  make_indexed_dir+0xdaf/0x13c0 fs/ext4/namei.c:2341
>  ext4_add_entry+0x222a/0x25d0 fs/ext4/namei.c:2451
>  ext4_rename fs/ext4/namei.c:3936 [inline]
>  ext4_rename2+0x26e5/0x4370 fs/ext4/namei.c:4214
> [...]
> ============================================
> 
> The immediate cause of this problem is that there is only one valid dentry
> for the block to be split during do_split, so split==0 results in out of
> bounds accesses to the map triggering the issue.
> 
>     do_split
>       unsigned split
>       dx_make_map
>        count = 1
>       split = count/2 = 0;
>       continued = hash2 == map[split - 1].hash;
>        ---> map[4294967295]
> 
> The maximum length of a filename is 255 and the minimum block size is 1024,
> so it is always guaranteed that the number of entries is greater than or
> equal to 2 when do_split() is called.
> 
> But syzbot's crafted image has no dot and dotdot in dir, and the dentry
> distribution in dirblock is as follows:
> 
>   bus     dentry1          hole           dentry2           free
> |xx--|xx-------------|...............|xx-------------|...............|
> 0   12 (8+248)=256  268     256     524 (8+256)=264 788     236     1024
> 
> So when renaming dentry1 increases its name_len length by 1, neither hole
> nor free is sufficient to hold the new dentry, and make_indexed_dir() is
> called.
> 
> In make_indexed_dir() it is assumed that the first two entries of the
> dirblock must be dot and dotdot, so bus and dentry1 are left in dx_root
> because they are treated as dot and dotdot, and only dentry2 is moved
> to the new leaf block. That's why count is equal to 1.
> 
> Therefore add the ext4_check_dx_root() helper function to add more sanity
> checks to dot and dotdot before starting the conversion to avoid the above
> issue.
> 
> Reported-by: syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ae688d469e36fb5138d0
> Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks! The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 56 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index e6769b97a970..35881e3dd880 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2172,6 +2172,52 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
>  	return err ? err : err2;
>  }
>  
> +static bool ext4_check_dx_root(struct inode *dir, struct dx_root *root)
> +{
> +	struct fake_dirent *fde;
> +	const char *error_msg;
> +	unsigned int rlen;
> +	unsigned int blocksize = dir->i_sb->s_blocksize;
> +	char *blockend = (char *)root + dir->i_sb->s_blocksize;
> +
> +	fde = &root->dot;
> +	if (unlikely(fde->name_len != 1)) {
> +		error_msg = "invalid name_len for '.'";
> +		goto corrupted;
> +	}
> +	if (unlikely(strncmp(root->dot_name, ".", fde->name_len))) {
> +		error_msg = "invalid name for '.'";
> +		goto corrupted;
> +	}
> +	rlen = ext4_rec_len_from_disk(fde->rec_len, blocksize);
> +	if (unlikely((char *)fde + rlen >= blockend)) {
> +		error_msg = "invalid rec_len for '.'";
> +		goto corrupted;
> +	}
> +
> +	fde = &root->dotdot;
> +	if (unlikely(fde->name_len != 2)) {
> +		error_msg = "invalid name_len for '..'";
> +		goto corrupted;
> +	}
> +	if (unlikely(strncmp(root->dotdot_name, "..", fde->name_len))) {
> +		error_msg = "invalid name for '..'";
> +		goto corrupted;
> +	}
> +	rlen = ext4_rec_len_from_disk(fde->rec_len, blocksize);
> +	if (unlikely((char *)fde + rlen >= blockend)) {
> +		error_msg = "invalid rec_len for '..'";
> +		goto corrupted;
> +	}
> +
> +	return true;
> +
> +corrupted:
> +	EXT4_ERROR_INODE(dir, "Corrupt dir, %s, running e2fsck is recommended",
> +			 error_msg);
> +	return false;
> +}
> +
>  /*
>   * This converts a one block unindexed directory to a 3 block indexed
>   * directory, and adds the dentry to the indexed directory.
> @@ -2206,17 +2252,17 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
>  		brelse(bh);
>  		return retval;
>  	}
> +
>  	root = (struct dx_root *) bh->b_data;
> +	if (!ext4_check_dx_root(dir, root)) {
> +		brelse(bh);
> +		return -EFSCORRUPTED;
> +	}
>  
>  	/* The 0th block becomes the root, move the dirents out */
>  	fde = &root->dotdot;
>  	de = (struct ext4_dir_entry_2 *)((char *)fde +
>  		ext4_rec_len_from_disk(fde->rec_len, blocksize));
> -	if ((char *) de >= (((char *) root) + blocksize)) {
> -		EXT4_ERROR_INODE(dir, "invalid rec_len for '..'");
> -		brelse(bh);
> -		return -EFSCORRUPTED;
> -	}
>  	len = ((char *) root) + (blocksize - csum_size) - (char *) de;
>  
>  	/* Allocate new block for the 0th block's dirents */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

