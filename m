Return-Path: <linux-ext4+bounces-2140-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BF08A9521
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 10:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEC61F22141
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C61586C0;
	Thu, 18 Apr 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TVZSxHd2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Npwd5rNs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="swas1d1F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mg01c/1Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279481E489;
	Thu, 18 Apr 2024 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429502; cv=none; b=CAb/eLMwe6CpACpOKYb0ymIcUeSX71t/bVKkXIBFasKAfBUp3eYLf+Fol8b0sEfD6OEHEcN04kcQo5r9nJDvLIrZnYYNCQiDNEHAEA3Lt4RWsd4O2gtYUWdcN8VvlDTFk1xI5n8fdX5CCV6z1/25dVJo10bIQTYCODt3iA4ygu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429502; c=relaxed/simple;
	bh=gC82ojHyQRv9o7U3cJhcomhfqvdL8b5auhWdEGoLyts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUzWLITv0ZfTljY6rdfRQKfhqqzFvWvgkLaHM/qr5ImY/wbOwPq8VxlmjMDjXHYOSJZKKF6vzyOfMzwpYlX96FyZTJKsnw4iw5k/6F5/4zSrI5vHneCpMja9PSzsLZkKxGNGvVAkJ1559BDCaGpOVl6R2svgEp4KVHW7v2xpJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TVZSxHd2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Npwd5rNs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=swas1d1F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mg01c/1Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB5A65C6E3;
	Thu, 18 Apr 2024 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713429496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQHI2HfhY8U7ChqqJPGtYV9epgIcoTThki5zkJAswYc=;
	b=TVZSxHd2PLnZkdQSg+uvQ1UvK6pRgbrYL+SFpOK4c1mqz+rufDOE8IiMMKNoBcdyFeHqBB
	I1QO3JrMgQqO5g1tnPhnJt0S/cyCYKoA7n0zVpijRqsW8a3qvH7YWnUM/ruNCpG8QSiXD0
	yL6mg6Jv12yWSeJVyLjyVj+H+G8P8i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713429496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQHI2HfhY8U7ChqqJPGtYV9epgIcoTThki5zkJAswYc=;
	b=Npwd5rNs20t17xatnQGS+LsO0xP4lMi7x0Z0X9ozy3fydXHu0AVlZVcNaEz5TNZDQOIjOK
	KR+oBjFUfXrWXnBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=swas1d1F;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="mg01c/1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713429495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQHI2HfhY8U7ChqqJPGtYV9epgIcoTThki5zkJAswYc=;
	b=swas1d1F0v96+qwfHrFZcLhRCZP9vy8pkgUTHLA2A1mrjozBRy2I4lM9C3PhZt+FQG/CIr
	cDCtEt81F7pkWVuL5eZfaGy0qhTmNeyCbWUQprX2zjUbdZsc3GRVogpf/omad1/0cs4kkq
	AW34Ji3TpFYFT2PpzNm1SHQBsZ/92AY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713429495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQHI2HfhY8U7ChqqJPGtYV9epgIcoTThki5zkJAswYc=;
	b=mg01c/1Q3ng9Mpby0s7ulX18bRqiHZ17a+D+EP2liUJWM/tmbnIbVtGraZvHNHs/4A6z+W
	h0cKJVpO+nOkJkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1A0613687;
	Thu, 18 Apr 2024 08:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z/ooM/fbIGalJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Apr 2024 08:38:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D3A2A0812; Thu, 18 Apr 2024 10:38:15 +0200 (CEST)
Date: Thu, 18 Apr 2024 10:38:15 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin10@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] e2fsck: fix acl block leak when process orphan list
Message-ID: <20240418083815.3qjyo7jpaqhueen3@quack3>
References: <20240418063946.2802835-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418063946.2802835-1-yebin10@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DB5A65C6E3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 18-04-24 14:39:46, Ye Bin wrote:
> There's a issue:
> []$~/e2fsprogs/e2fsck/e2fsck -f scsi-disk2.img
> e2fsck 1.47.0 (5-Feb-2023)
> scsi-disk2.img: recovering journal
> Clearing orphaned inode 12 (uid=0, gid=0, mode=0140777, size=0)
> Pass 1: Checking inodes, blocks, and sizes
> Extended attribute block 4247 has reference count 3, should be 2.  Fix<y>? no
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> Free blocks count wrong (249189, counted=249188).
> Fix<y>? no
> Free inodes count wrong (65526, counted=65523).
> Fix<y>? no
> 
> scsi-disk2.img: ***** FILE SYSTEM WAS MODIFIED *****
> 
> scsi-disk2.img: ********** WARNING: Filesystem still has errors **********
> 
> scsi-disk2.img: 10/65536 files (0.0% non-contiguous), 12955/262144 blocks
> 
> Above issue can reproduce as follows:
> step1: socat UNIX-LISTEN:/home/test/mysocket.sock,mode=777,reuseaddr,fork EXEC:/home/test  &
> step2: setfacl some xattr for mysocket.sock
> step3: cp -a /home/test/mysocket.sock /home/test/sock1
>        cp -a /home/test/mysocket.sock /home/test/sock2
> step4: sync
> step5: Power-off
> step6: run e2fsck
> 
> As after commit 42475e281d22 add ext2fs_inode_has_valid_blocks() judgement in
> release_inode_blocks() which means socket type file skip realse block include
> ACL block. The kernel does not restrict the setting of extended attributes for
> socket files. So this will lead to ACL block leak.
> To solve above issue there's need to release ACL block for other kind of
> special file.
> 
> Fixes: 42475e281d22 ("super.c (release_inode_blocks): Don't try to release the blocks if the orphaned inode is a device file, symlink, or some other kind of special file that doesn't have a block list.")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  e2fsck/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/e2fsck/super.c b/e2fsck/super.c
> index be40dd8f..cefc2b07 100644
> --- a/e2fsck/super.c
> +++ b/e2fsck/super.c
> @@ -196,7 +196,7 @@ static int release_inode_blocks(e2fsck_t ctx, ext2_ino_t ino,
>  	__u32				count;
>  
>  	if (!ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(inode)))
> -		return 0;
> +		goto release_acl;
>  
>  	pb.buf = block_buf + 3 * ctx->fs->blocksize;
>  	pb.ctx = ctx;
> @@ -235,7 +235,7 @@ static int release_inode_blocks(e2fsck_t ctx, ext2_ino_t ino,
>  	if (pb.truncated_blocks)
>  		ext2fs_iblk_sub_blocks(fs, EXT2_INODE(inode),
>  				pb.truncated_blocks);
> -
> +release_acl:
>  	blk = ext2fs_file_acl_block(fs, EXT2_INODE(inode));
>  	if (blk) {
>  		retval = ext2fs_adjust_ea_refcount3(fs, blk, block_buf, -1,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

