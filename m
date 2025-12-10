Return-Path: <linux-ext4+bounces-12265-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD75CB298E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 10:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02A9230213DB
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CFB2D7DFB;
	Wed, 10 Dec 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AGnghbYC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FR3are1U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rcVeF6HX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OpjNzGm6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A928C87C
	for <linux-ext4@vger.kernel.org>; Wed, 10 Dec 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360048; cv=none; b=qZ/LxZb8C+FCFEJO334C9+ocdEXDZbMSllwj/KDkpyNYRrODB2xnUj8IiTZ+4yut7wqNlMXwU1vYZ/pKlVe9dDukuhtWBz5Ehf+LTHqR4LONHF3Slx2omA41eAtpW4gsdP/lkq/HzuamcORlQ+LpdcYu6Pq9mOyLN3c9ctTKi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360048; c=relaxed/simple;
	bh=GIW68pyKx6QQ7XkM3eQqeicv8Ohxi43Mf/j8QDDE+so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvvqEX+SaF8ZiW9BwsiNKo4CPkQ0Hq98MAleFrvOts5r2XhAKa0tdsQ3ML3YpRzuisK9IM6NNWHMQ7RYhc3Ny0t9Iqpcy9w2rCq4l3BYeZGT66iPi4Id0hOeKwkbV5Dazt7XZnyQIwq9Xk231sBxDq1/4sNdVL9YmF8OTEOKsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AGnghbYC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FR3are1U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rcVeF6HX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OpjNzGm6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6C3E5BDB9;
	Wed, 10 Dec 2025 09:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765360044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cJReymf4S/ndWgWNOJiIQlGYfJWbM/Cj0U0zV5njsI=;
	b=AGnghbYCCGdY4zxwgd9B7x4apOR73/YnW8GxdykrpzpRDp0qSpSdUYzq1mjsi1JpsrtNc8
	lmrDGEt9QBaXMyjvZrpiMmEZQcLYX7Bhd5Y4cjlLl3jdQs2ZL+QwDiWRCoSFF7dPnhf580
	ad3/bfAZ/kvvPWJZyVmoW2Q247TloQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765360044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cJReymf4S/ndWgWNOJiIQlGYfJWbM/Cj0U0zV5njsI=;
	b=FR3are1UCcnQcbwg2xMi3jnEmgPQMPqXMw5lqNxOmz8CIqPdyaaRGMyuTkKc1Damf2ixsv
	L8Fp2Kh8N0KviICw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765360042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cJReymf4S/ndWgWNOJiIQlGYfJWbM/Cj0U0zV5njsI=;
	b=rcVeF6HXLW0e+AlKb1H9AsnB+uqdLNKSvWSMwbTvFnbf+gwrtzcnMm/cUPLYSfd5YsTtcx
	a+wblCtmwnr5NeNRZGYqvhHVkW59iaj2PY3y/SSvzB6PZB7GS0WBqjg7jq1Lujkox3mEG9
	SFvT95lI6uufosp/jWbxOGCUPLzLWSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765360042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cJReymf4S/ndWgWNOJiIQlGYfJWbM/Cj0U0zV5njsI=;
	b=OpjNzGm6uiQDLCSAB91K8gOqBiHr8X7n8rRI53jerF0a/ti2rxjok7ibPXs3Y4kB3HhcnA
	xwbN++KUecRH88BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC3D43EA63;
	Wed, 10 Dec 2025 09:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rSvBNapBOWlzYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Dec 2025 09:47:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C806A0A61; Wed, 10 Dec 2025 10:47:18 +0100 (CET)
Date: Wed, 10 Dec 2025 10:47:18 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH e2fsprogs] lib/quota: fix checksum mismatch on
 uninitialized PRJQUOTA inode
Message-ID: <25z7f7wug2hsciq7iriagtnhoajoanx2h6z6jg6pwcmih4e6ee@kbfsk42u5h6g>
References: <20251210081558.2714709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210081558.2714709-1-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 10-12-25 16:15:58, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In quota_inode_init_new(), we attempt to read and truncate an existing
> quota inode before proceeding with its initialization.
> 
> This read operation verifies the inode's checksum. This works fine for
> USRQUOTA and GRPQUOTA inodes because write_reserved_inodes() is always
> called during ext4 image creation to set appropriate checksums for these
> reserved inodes.
> 
> However, the PRJQUOTA inode is not reserved, and its corresponding inode
> table block may not have been zeroed, potentially containing stale data.
> Consequently, reading this inode can fail due to a checksum mismatch.
> 
> This can be reproduced by running the following sequence:
> 
>   dd if=/dev/random of=$DISK bs=1M count=128
>   mkfs.ext4 -F -q -b 1024 $DISK 5G
>   tune2fs -O quota,project $DISK
> 
> Which results in the following error output:
> 
>  tune2fs 1.47.3 (8-Jul-2025)
>  [ERROR] quotaio.c:279:quota_inode_init_new: ex2fs_read_inode failed
>  [ERROR] quotaio.c:341:quota_file_create: init_new_quota_inode failed
>  tune2fs: Inode checksum does not match inode while writing quota file (2)
> 
> While running `kvm-xfstests -c ext4/1k -C 1 generic/383`, the test itself
> does not fail, but checksum verification failures are reported even
> without fault injection, which led to discovering this issue.
> 
> To fix this, we stop attempting to read the quota inode that is about
> to be initialized inside quota_inode_init_new(). Instead, the logic
> to attempt truncation of an existing quota inode is moved to be handled
> inside quota_file_create().
> 
> Fixes: 080e09b4 ("Add project quota support")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  lib/support/quotaio.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/lib/support/quotaio.c b/lib/support/quotaio.c
> index f5f2c7f7..827df85b 100644
> --- a/lib/support/quotaio.c
> +++ b/lib/support/quotaio.c
> @@ -274,18 +274,6 @@ static errcode_t quota_inode_init_new(ext2_filsys fs, ext2_ino_t ino)
>  	errcode_t err = 0;
>  	time_t now;
>  
> -	err = ext2fs_read_inode(fs, ino, &inode);
> -	if (err) {
> -		log_err("ex2fs_read_inode failed");
> -		return err;
> -	}
> -
> -	if (EXT2_I_SIZE(&inode)) {
> -		err = quota_inode_truncate(fs, ino);
> -		if (err)
> -			return err;
> -	}
> -
>  	memset(&inode, 0, sizeof(struct ext2_inode));
>  	ext2fs_iblk_set(fs, &inode, 0);
>  	now = fs->now ? fs->now : time(0);
> @@ -319,6 +307,10 @@ errcode_t quota_file_create(struct quota_handle *h, ext2_filsys fs,
>  	if (fmt == -1)
>  		fmt = QFMT_VFS_V1;
>  
> +	err = ext2fs_read_bitmaps(fs);
> +	if (err)
> +		goto out_err;
> +
>  	h->qh_qf.fs = fs;
>  	qf_inum = quota_type2inum(qtype, fs->super);
>  	if (qf_inum == 0 && qtype == PRJQUOTA) {
> @@ -330,15 +322,19 @@ errcode_t quota_file_create(struct quota_handle *h, ext2_filsys fs,
>  		ext2fs_mark_ib_dirty(fs);
>  	} else if (qf_inum == 0) {
>  		return EXT2_ET_BAD_INODE_NUM;
> +	} else {
> +		err = quota_inode_truncate(fs, qf_inum);
> +		if (err) {
> +			log_err("quota_inode_truncate failed, ino=%u, type=%d",
> +				qf_inum, qtype);
> +			return err;
> +		}
>  	}
>  
> -	err = ext2fs_read_bitmaps(fs);
> -	if (err)
> -		goto out_err;
> -
>  	err = quota_inode_init_new(fs, qf_inum);
>  	if (err) {
> -		log_err("init_new_quota_inode failed");
> +		log_err("init_new_quota_inode failed, ino=%u, type=%d",
> +			qf_inum, qtype);
>  		goto out_err;
>  	}
>  	h->qh_qf.ino = qf_inum;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

