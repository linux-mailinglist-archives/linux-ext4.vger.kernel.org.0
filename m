Return-Path: <linux-ext4+bounces-3018-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2E91BF5A
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 15:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18361C22423
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627691586F2;
	Fri, 28 Jun 2024 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="chmN+8pL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h7l7SkPj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="chmN+8pL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h7l7SkPj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A68B653
	for <linux-ext4@vger.kernel.org>; Fri, 28 Jun 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719580531; cv=none; b=TUKXyb3ROkVQ9tFUrrfd7gshCxPVjWYnTm2JsuJvotNw67f95NkApM8SmT0fI044HNJnwq/mZ23IitylAbhBtYjW/NBGrcbh/83BqQ4U4VW1sjCd0yg+V0clX8SBaicgKmYSoBcaORC+DJPwpyEl/+QC1DGSzAFi0oAxaEpvkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719580531; c=relaxed/simple;
	bh=r84wrb5jCWki/QPc2KMLvn1bOJG1FfaGJ+CT51lUbBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb+HNC3aIBwZnY/H+p1N+KuLvjggc6VFxulGG6ucyLXvxlvVlI760o5YvYkMHc1XVinws2r46X10iA1wMXfeuiZRw9j5WyvFdpWEkCrtbtOgPO5KgJKaljZy2xlPrDzRf1l0TCD5PB0Ju1pmwIibtuoP8EgyhZY9pPYIkiPkLe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=chmN+8pL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h7l7SkPj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=chmN+8pL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h7l7SkPj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 481571F397;
	Fri, 28 Jun 2024 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719580527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=40FdRXlW+5frfovb/7Gl+o19l9ctKRekrKizyo6YcHY=;
	b=chmN+8pLXj12Zsf0djZS2cdk2NKY+8YpWrOJ8gxNueBkej9xq90g8NToHOhhCu8tK9uGj1
	obTO0Nwn1EDH8R+UEbnKEXQK3nFD1j2ZzPqe1+jPip7jSYHNBzqdPefddJVKDVR/aYkjTw
	m/EiZ+8rRozxVOcyQH1eEQOVBpVnwtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719580527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=40FdRXlW+5frfovb/7Gl+o19l9ctKRekrKizyo6YcHY=;
	b=h7l7SkPjeXGtJj7yUF95goTdvB8hKQw4EaYa8wt86Gf3XgjTq8xLleNqL8SFw86spRFCHc
	58h/XmM+Lo8BhUDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=chmN+8pL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h7l7SkPj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719580527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=40FdRXlW+5frfovb/7Gl+o19l9ctKRekrKizyo6YcHY=;
	b=chmN+8pLXj12Zsf0djZS2cdk2NKY+8YpWrOJ8gxNueBkej9xq90g8NToHOhhCu8tK9uGj1
	obTO0Nwn1EDH8R+UEbnKEXQK3nFD1j2ZzPqe1+jPip7jSYHNBzqdPefddJVKDVR/aYkjTw
	m/EiZ+8rRozxVOcyQH1eEQOVBpVnwtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719580527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=40FdRXlW+5frfovb/7Gl+o19l9ctKRekrKizyo6YcHY=;
	b=h7l7SkPjeXGtJj7yUF95goTdvB8hKQw4EaYa8wt86Gf3XgjTq8xLleNqL8SFw86spRFCHc
	58h/XmM+Lo8BhUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C6DC1373E;
	Fri, 28 Jun 2024 13:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9gu7Dm+3fmZSewAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Jun 2024 13:15:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8133CA088E; Fri, 28 Jun 2024 15:15:18 +0200 (CEST)
Date: Fri, 28 Jun 2024 15:15:18 +0200
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com,
	harshads@google.com
Subject: Re: [PATCH v6 03/10] ext4: mark inode dirty before grabbing
 i_data_sem in ext4_setattr
Message-ID: <20240628131518.nxirjq7qqhz3ckh5@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-4-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529012003.4006535-4-harshadshirwadkar@gmail.com>
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 481571F397
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed 29-05-24 01:19:56, Harshad Shirwadkar wrote:
> Mark inode dirty first and then grab i_data_sem in ext4_setattr().
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  fs/ext4/inode.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index aa6440992a55..61ffbdc2fb16 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5410,12 +5410,13 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
>  					inode->i_sb->s_blocksize_bits);
>  
> -			down_write(&EXT4_I(inode)->i_data_sem);
> -			old_disksize = EXT4_I(inode)->i_disksize;
> -			EXT4_I(inode)->i_disksize = attr->ia_size;
>  			rc = ext4_mark_inode_dirty(handle, inode);
>  			if (!error)
>  				error = rc;
> +			down_write(&EXT4_I(inode)->i_data_sem);
> +			old_disksize = EXT4_I(inode)->i_disksize;
> +			EXT4_I(inode)->i_disksize = attr->ia_size;
> +

This is wrong. ext4_mark_inode_dirty() will copy the data to on-disk
buffer. If you set i_disksize after ext4_mark_inode_dirty(), the change
will not get properly logged in the transaction.

What you rather need is calling ext4_mark_inode_dirty() after dropping
i_data_sem which should be completely fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

