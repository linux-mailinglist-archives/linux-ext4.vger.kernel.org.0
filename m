Return-Path: <linux-ext4+bounces-11837-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF77BC54522
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 21:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41B7D4FA6EE
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C7728B407;
	Wed, 12 Nov 2025 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m6IbvfXD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2UZ6NlEJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x0F5lwjP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Sp1EVhN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432127E07E
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976937; cv=none; b=c4y+pZgZiRuiUchJw0DK1s9A7sJT+tUIrvppsSTtIfezhSsJAbr89Wqt4ul97q8WFU6OtEv5zbBc5ourayuAhgNLNNyuEzC2t/XoJuN8+3Qvt8Veq0ytNftkpUqAdRW9i9gGchgv5bdedm5w1R4n1qsgQddDKCRezjt8YNSM7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976937; c=relaxed/simple;
	bh=dFk02J1e4F+vb6I69BypXFIFsjrKjflzdjo5oj8iEJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILu0gwwARUcZZYRD5MRt3iawdYixM+zvc3ZZ0IQPX5JtONCJ1CRm+f2IbZ8P1D9Mnmg0kn2ZxdxnmIVPNDx0XfMOsRT1Zl6HytXWJPH22pQdIk12FDsznXKBQvpjiNcKU/x4F24ZFYGGpjf58P3xu+RwzOyP+fO7dza5myhZgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m6IbvfXD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2UZ6NlEJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x0F5lwjP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6Sp1EVhN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCF6021985;
	Wed, 12 Nov 2025 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762976933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfCE5gV0f+mGPzt5wRJ6d2S+07AAQqFW8KGSu8LeIz8=;
	b=m6IbvfXDa5x9zPEhq7MCwQ1h/nxNbQsWBZjju34HUGDxO1jsQZHQSGm8otpomvIExml3Er
	wxNpR0JRdRYxJY4dY8hqNWMuEXLm/zKdGEDd/XvTBQ6sBibk6UhBUI9qVkfcmAiasoCLAB
	tfbiousIPhtkA7lzzcoLTQ3OU4v0Jfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762976933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfCE5gV0f+mGPzt5wRJ6d2S+07AAQqFW8KGSu8LeIz8=;
	b=2UZ6NlEJxLiOkUUDsg52wH22sZVr/d3z3Tm38nHZToY7YuREVRyhHkiKdLzGoEuPqiPe82
	FUEgKuidL+uHbyDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x0F5lwjP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6Sp1EVhN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762976931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfCE5gV0f+mGPzt5wRJ6d2S+07AAQqFW8KGSu8LeIz8=;
	b=x0F5lwjPrukfJFuW3Aeuwmi1nRCdRqQwtY5H0gybRP38jD5UQoRJx5rJDuIgB7+QNXDz2J
	zXBDHynjW9+42ytXLVgPTScpqXN3v20r6F273yjW5ykPNJjaOO9FkORR9A+Nv783XA38wP
	p9MZbjoYUgYQq0LsVRrdOKCM/2XnIDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762976931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfCE5gV0f+mGPzt5wRJ6d2S+07AAQqFW8KGSu8LeIz8=;
	b=6Sp1EVhNiCpX1zaGnyBD0Ig2oW5M4CX9oD/4Krhz3ZXFwhZZJd8MQPLrWjvLdxo9V9ACSu
	Arfp/vU6DGt8zlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C1843EA61;
	Wed, 12 Nov 2025 19:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QXdWJaPkFGlBbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Nov 2025 19:48:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0533CA06F7; Wed, 12 Nov 2025 20:48:50 +0100 (CET)
Date: Wed, 12 Nov 2025 20:48:50 +0100
From: Jan Kara <jack@suse.cz>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, cascardo@igalia.com, 
	jack@suse.cz, yebin10@huawei.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: validate xattrs to avoid OOB in
 ext4_find_inline_entry
Message-ID: <6jsnfb2qu3rlygp7ejlp4fzv2mmnzy2t5eqlhq5edhttnp3jar@5vynnrxzi54f>
References: <aRHSrpFone-SSkZa@quatroqueijos.cascardo.eti.br>
 <20251112185712.2031993-2-rpthibeault@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112185712.2031993-2-rpthibeault@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BCF6021985
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[3ee481e21fd75e14c397];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,system.data:url,syzkaller.appspot.com:url,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.51

On Wed 12-11-25 13:57:13, Raphael Pinsonneault-Thibeault wrote:
> When looking for an entry in an inlined directory, if e_value_offs is
> changed underneath the filesystem by some change in the block device, it
> will lead to an out-of-bounds access that KASAN detects as a
> use-after-free.
> 
> This is a similar problem as fixed by
> commit c6b72f5d82b1 ("ext4: avoid OOB when system.data xattr changes underneath the filesystem")
> whose fix was to call ext4_xattr_ibody_find() right after reading the
> inode with ext4_get_inode_loc() to check the validity of the xattrs.
> 
> However, ext4_xattr_ibody_find() only checks xattr names, via
> xattr_find_entry(), not e_value_offs.
> 
> Fix by calling xattr_check_inode() which performs a full check on the
> xattrs in inode.
> 
> Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
> Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
> Fixes: 5701875f9609 ("ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()")
> Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>

When the filesystem is mounted on top of a block device, syzbot cannot
write to it (it disables CONFIG_BLKDEV_WRITE_MOUNTED option). Also there's
no sane way how the filesystem driver could avoid oopses when the block
device's buffer cache is modified while the filesystem is mounted without
unacceptable slowdown so this patch is pointless in my opinion.

The syzbot reproducer you're referencing actually seems to use
LOOP_SET_STATUS ioctl to mess with the loop device while the filesystem is
mounted. Understanding what exactly happens there and modifying the
loopback device driver to forbid that is in my opinion a more sustainable
way to fix problems like this.

								Honza
> ---
> changelog
> v1 -> v2: change Fixes tag to reflect that ext4_xattr_ibody_find() used to call 
> xattr_check_inode() until 5701875f9609.
> 
>  fs/ext4/inline.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 1b094a4f3866..7d46e1e16b52 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1593,6 +1593,13 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
>  
>  	down_read(&EXT4_I(dir)->xattr_sem);
>  
> +	if (EXT4_INODE_HAS_XATTR_SPACE(dir)) {
> +		ret = xattr_check_inode(dir, IHDR(dir, ext4_raw_inode(&is.iloc)),
> +					ITAIL(dir, ext4_raw_inode(&is.iloc)));
> +		if (ret)
> +			goto out;
> +	}
> +
>  	ret = ext4_xattr_ibody_find(dir, &i, &is);
>  	if (ret)
>  		goto out;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

